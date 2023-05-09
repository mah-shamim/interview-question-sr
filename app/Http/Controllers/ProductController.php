<?php

namespace App\Http\Controllers;

use App\Http\Requests\Product\ProductStoreRequest;
use App\Http\Requests\Product\ProductUpdateRequest;
use App\Models\Product;
use App\Models\Variant;
use App\Services\ProductService;
use Exception;
use Illuminate\Contracts\Foundation\Application;
use Illuminate\Contracts\View\Factory;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\View\View;

class ProductController extends Controller
{
    /**
     * @var ProductService
     */
    private $productService;

    /**
     * @param ProductService $productService
     */
    public function __construct(ProductService $productService)
    {

        $this->productService = $productService;
    }

    /**
     * Display a listing of the resource.
     *
     * @param Request $request
     * @return Application|Factory|Response|View
     */
    public function index(Request $request)
    {
        $variants = Variant::all();
        $products = $this->productService->productList($request->all())->paginate(2);

        return view('products.index', compact('variants', 'products'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Http\Response|\Illuminate\View\View
     */
    public function create()
    {
        $variants = Variant::all();
        return view('products.create', compact('variants'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param ProductStoreRequest $productStoreRequest
     * @return RedirectResponse
     * @throws Exception
     */
    public function store(ProductStoreRequest $productStoreRequest): RedirectResponse
    {
        $productCreateResponse = $this->productService
            ->createProduct(
                $productStoreRequest->validated()
            );
        //return response()->json($productCreateResponse);
        return redirect()->route('product.index');

    }


    /**
     * Display the specified resource.
     *
     * @param \App\Models\Product $product
     * @return \Illuminate\Http\Response
     */
    public function show($product)
    {

    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param Product $product
     * @return Application|Factory|View
     * @throws Exception
     */
    public function edit(Product $product)
    {
        $product = $this->productService->showProductById($product->id);
        $new_variant_list = [];
        foreach ($product->productVariants as $productVariant)
        {
            if(!empty($productVariant->variant)){

                $new_variant_list[$productVariant->variant_id][] = "'".($productVariant->variant)."'";
            }
        }
        $product['productVariant'] = $new_variant_list;
        //dd($product->productVariantPrices);
        $variants = Variant::all();
        return view('products.edit', compact('variants', 'product'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param ProductUpdateRequest $productUpdateRequest
     * @param Product $product
     * @return RedirectResponse
     * @throws Exception
     */
    public function update(ProductUpdateRequest $productUpdateRequest, Product $product): RedirectResponse
    {
        //dd($productUpdateRequest->validated());
        $productUpdateResponse = $this->productService
            ->updateProduct(
                $product->id,
                $productUpdateRequest->validated()
            );
        //return response()->json($productUpdateResponse);
        return redirect()->route('product.index');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param \App\Models\Product $product
     * @return \Illuminate\Http\Response
     */
    public function destroy(Product $product)
    {
        //
    }
}
