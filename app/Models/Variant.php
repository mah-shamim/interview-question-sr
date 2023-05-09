<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Variant extends Model
{
    protected $fillable = [
        'title', 'description'
    ];

    public function productVariants(): HasMany
    {
        return $this->hasMany(ProductVariant::class)->groupBy('variant');
    }

}
