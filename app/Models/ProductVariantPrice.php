<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ProductVariantPrice extends Model
{

    protected $fillable = ['product_variant_one', 'product_variant_two', 'product_variant_three', 'price', 'stock', 'product_id'];

    public function productVariantOne(): BelongsTo
    {
        return $this->belongsTo(ProductVariant::class, 'product_variant_one');
    }

    public function productVariantTwo(): BelongsTo
    {
        return $this->belongsTo(ProductVariant::class, 'product_variant_two');
    }

    public function productVariantThree(): BelongsTo
    {
        return $this->belongsTo(ProductVariant::class, 'product_variant_three');
    }

}
