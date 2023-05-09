<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ProductVariant extends Model
{
    protected $fillable = ['variant', 'variant_id', 'product_id'];

    /**
     * Return variant type this variant belongs
     *
     * @return BelongsTo
     */
    public function variants(): BelongsTo
    {
        return $this->belongsTo(Variant::class, 'variant_id', 'id');
    }

    /**
     * Return variant type this variant belongs
     *
     * @return HasMany
     */
    public function productVariantOne(): HasMany
    {
        return $this->hasMany(Variant::class, 'variant_id', 'id');
    }
}
