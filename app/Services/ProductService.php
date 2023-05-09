<?php

namespace App\Services;

use App\Models\Product;
use App\Models\ProductImage;
use App\Models\ProductVariant;
use App\Models\ProductVariantPrice;
use Exception;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;

class ProductService
{
    public $product;

    public function __construct()
    {
        $this->product = new Product;
    }

    /**
     * Return a query builder instance with given condition
     *
     * @param array $filters
     * @return Builder
     */
    public function productList(array $filters): Builder
    {

        DB::statement('SET SESSION group_concat_max_len = 99999999');
        $productVariantPricesSubQuery = DB::table('product_variant_prices')
            ->select(
                'product_variant_prices.*',
                DB::raw('product_variant_one.variant AS color'),
                DB::raw('product_variant_two.variant AS size'),
                DB::raw('product_variant_three.variant AS style')
            )
            ->leftJoin(
                DB::raw('product_variants AS product_variant_one'),
                'product_variant_one.id',
                '=',
                'product_variant_prices.product_variant_one'
            )
            ->leftJoin(
                DB::raw('product_variants AS product_variant_two'),
                'product_variant_two.id',
                '=',
                'product_variant_prices.product_variant_two'
            )
            ->leftJoin(
                DB::raw('product_variants AS product_variant_three'),
                'product_variant_three.id',
                '=',
                'product_variant_prices.product_variant_three'
            )
            ->orderBy('product_variant_prices.product_id');
        $query = $this->product->newQuery();

        $query->leftJoinSub(
            $productVariantPricesSubQuery->toSql(),
            'PVP',
            function ($join) {
                $join->on(
                    'PVP.product_id',
                    '=',
                    'products.id'
                );
            }
        );

        if(isset($filters['title']) && !($filters['title'])){
            $query->where('products.title', 'LIKE', '%'.$filters['title'].'%');
        }

        if (isset($filters['variant']) && $filters['variant']) {
            $variants = [];
            foreach ($filters['variant'] as $variant){
                $temp = explode('-', $variant, 2);
                $variants[$temp[0]][] = $temp[1] ?? '';
            }
            $query->where(function ($query) use ($variants) {
                if(isset($variants[1])){
                    $query->whereIn('PVP.color', $variants[1]);
                }
                if(isset($variants[2])){
                    $query->whereIn('PVP.size', $variants[2]);
                }
                if(isset($variants[6])){
                    $query->whereIn('PVP.style', $variants[6]);
                }
            });
        }

        if(isset($filters['date']) && ($filters['date'])){
            $query->where(DB::raw('DATE(products.created_at)'), $filters['date']);
        }

        if(
            isset($filters['price_from']) && $filters['price_from'] != '' &&
            isset($filters['price_to']) && $filters['price_to'] != ''
        ){
            $query->whereBetween('PVP.price', array($filters['price_from'], $filters['price_to']));
        }
        $select[] = 'products.*';
        $query->groupBy('PVP.product_id');
        $select[] = DB::raw("IF(PVP.product_id > 0, CONCAT(
        '[',
            GROUP_CONCAT(
                JSON_OBJECT(
                    'id',
                    PVP.id,
                    'product_variant_one',
                    PVP.color,
                    'product_variant_two',
                    PVP.size,
                    'product_variant_three',
                    PVP.style,
                    'price',
                    PVP.price,
                    'stock',
                    PVP.stock
                )
                SEPARATOR ','
            ),
        ']'
        ), null) AS product_variant_prices");
        $query->select($select);
        //$sql = Str::replaceArray('?', $query->getBindings(), $query->toSql());
        //dd($sql);
        return $query;
    }

    /**
     * @throws Exception
     */
    public function createProduct(array $inputs = []): Product
    {
        $productInfo = $this->formatProductInfo($inputs);
        $newProduct = $this->product->newInstance($productInfo);

        DB::beginTransaction();
        try {
            $newProduct->save();

            $inputs['product_id'] = $newProduct->id;

            $productVariantArray = [];

            $this->formatProductImageInfo($inputs);
            foreach ($this->formatProductVariantInfo($inputs) as $index => $singleProductVariant):
                $productVariantArray[$index] = new ProductVariant($singleProductVariant);
                $productVariantArray[$index]->save();
            endforeach;

            foreach ($this->formatProductVariantPriceInfo($inputs, $productVariantArray) as $singleProductVariantPrice):
                ProductVariantPrice::create($singleProductVariantPrice);
            endforeach;
            $newProduct->refresh();
            DB::commit();
            return $newProduct;
        } catch (Exception $exception) {
            DB::rollBack();
            throw new Exception($exception->getMessage());
        }

    }

    /**
     * Format Product Inputs
     *
     * @param array $inputs
     * @return array
     */
    private function formatProductInfo(array $inputs = []): array
    {
        $product['title'] = $inputs['title'] ?? '';
        $product['sku'] = $inputs['sku'] ?? '';
        $product['description'] = $inputs['description'] ?? '';

        return $product;
    }

    /**
     * Format Product Variant Array Inputs
     *
     * @param array $inputs
     * @return array
     */
    private function formatProductVariantInfo(array $inputs = []): array
    {
        $productVariantArray = [];

        foreach ($inputs['product_variant'] as $input):
            if(!empty($input['value'])){
                foreach ($input['value'] as $tag){
                    $check = ProductVariant::where('variant_id',$input['option'])
                        ->where('product_id',$inputs['product_id'])
                        ->where('variant',$tag)
                        ->first();

                    if($check === null){
                        $parentArr = [
                            'variant_id' => $input['option'],
                            'product_id' => $inputs['product_id'],
                        ];

                        $productVariantArray[] = array_merge($parentArr, [
                            'variant' => $tag
                        ]);

                    }else{
                        $productVariantArray[] = [
                            'variant_id' => $check['variant_id'],
                            'product_id' => $check['product_id'],
                            'id' => $check['id'],
                            'variant' => $check['variant']
                        ];
                    }
                }
            }
        endforeach;

        return $productVariantArray;
    }

    /**
     * Format Product Variant Array Inputs
     *
     * @param array $inputs
     * @param array $productVariantArray
     * @return array
     */
    private function formatProductVariantPriceInfo(array $inputs, array &$productVariantArray): array
    {
        $productVariantPriceArray = [];

        $variantFreqArr = [];

        foreach ($productVariantArray as $item):
            $variantFreqArr[$item->variant] = $item->id;
        endforeach;

        foreach ($inputs['product_preview'] as $input):

            $parentArr['price'] = $input['price'] ?? 0;
            $parentArr['stock'] = $input['stock'] ?? 0;
            $parentArr['product_id'] = $inputs['product_id'] ?? 0;

            $titleArray = explode("/", trim($input['variant'], "/"));

            if (isset($titleArray[0])) {
                $parentArr['product_variant_one'] = $variantFreqArr[$titleArray[0]] ?? null;
            }

            if (isset($titleArray[1])) {
                $parentArr['product_variant_two'] = $variantFreqArr[$titleArray[1]] ?? null;
            }

            if (isset($titleArray[2])) {
                $parentArr['product_variant_three'] = $variantFreqArr[$titleArray[2]] ?? null;
            }

            $productVariantPriceArray[] = $parentArr;
        endforeach;

        Log::info("Data", $productVariantPriceArray);
        return $productVariantPriceArray;
    }

    /**
     * @throws Exception
     */
    public function showProductById($id)
    {
        try {
            return $this->product::with([
                'productVariants',
                'productImages',
                'productVariantPrices',
                'productVariantPrices.productVariantOne',
                'productVariantPrices.productVariantTwo',
                'productVariantPrices.productVariantThree'
            ])->findOrFail($id);
        } catch (Exception $exception) {
            throw new Exception($exception->getMessage());
        }
    }

    /**
     * @param $id
     * @param array $inputs
     * @return mixed
     * @throws Exception
     */
    public function updateProduct($id, array $inputs = [])
    {
        //dd($inputs);
        $productInfo = $this->formatProductInfo($inputs);
        $existingProduct = $this->showProductById($id);
        $existingProduct->fill($productInfo);
        DB::beginTransaction();
        try {
            $existingProduct->save();
            //
            $inputs['product_id'] = $existingProduct->id;

            $this->removeOldVariants($existingProduct);
            $this->imageUnlink($inputs);

            $productVariantArray = [];

            $this->formatProductImageInfo($inputs);
            foreach ($this->formatProductVariantInfo($inputs) as $index => $singleProductVariant):
                if($singleProductVariant['id'] < 1){
                    $productVariantArray[$index] = new ProductVariant($singleProductVariant);
                    $productVariantArray[$index]->save();
                }else{
                    $productVariantArray[$index] = (object)$singleProductVariant;
                }
            endforeach;

            foreach ($this->formatProductVariantPriceInfo($inputs, $productVariantArray) as $singleProductVariantPrice):
                ProductVariantPrice::create($singleProductVariantPrice);
            endforeach;
            $existingProduct->refresh();
            DB::commit();
            return $existingProduct;
        } catch (Exception $exception) {
            DB::rollBack();
            throw new Exception($exception->getMessage());
        }
    }

    private function removeOldVariants($product)
    {
        //ProductVariant::where('product_id',$product->id)->delete();
        ProductVariantPrice::where('product_id',$product->id)->delete();
        /*foreach ($product->productVariantPrices as $temp) :
            $temp->delete();
        endforeach;*/

        /*foreach ($product->productVariants as $temp) :
            $temp->delete();
        endforeach;*/
    }

    /**
     * Format Product Images
     *
     * @param array $inputs
     * @return array
     */
    private function formatProductImageInfo(array $inputs = []): array
    {
        $productImageArray = [];

        if(count($inputs['imageUpload'])>0){
            foreach ($inputs['imageUpload'] as $input):
                if(!empty($input)){
                    $productImageArray['file_path'] = $input;
                    $productImageArray['thumbnail'] = 0;
                    $productImageArray['product_id'] = $inputs['product_id'];
                    ProductImage::create($productImageArray);
                }
            endforeach;
        }
        return $productImageArray;
    }

    /**
     * @param array $inputs
     * @return void
     */
    private function imageUnlink(array $inputs = [])
    {
        $productImages = ProductImage::where('product_id',$inputs['product_id'])->get();
        if(count($productImages)>0){
            foreach ($productImages as $productImage){
                if(!in_array($productImage->file_path, $inputs['imageUpload'])){
                    unlink(public_path('images')."/".$productImage->file_path);
                }
                $productImage->delete();
            }
        }
    }
}
