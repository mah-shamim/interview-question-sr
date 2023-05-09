<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Product extends Model
{
    protected $fillable = [
        'title', 'sku', 'description'
    ];


    /**
     * Return collection of all product variants
     * @return HasMany
     */
    public function productVariants(): HasMany
    {
        return $this->hasMany(ProductVariant::class, 'product_id', 'id');
    }

    /**
     * Return collection of all product variants
     * @return HasMany
     */
    public function productImages(): HasMany
    {
        return $this->hasMany(ProductImage::class, 'product_id', 'id');
    }

    /**
     * Return variant type this variant belongs
     *
     * @return HasMany
     */
    public function productVariantPrices(): HasMany
    {
        return $this->hasMany(ProductVariantPrice::class, 'product_id', 'id');
    }

}
