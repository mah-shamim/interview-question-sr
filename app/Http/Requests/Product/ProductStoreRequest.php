<?php

namespace App\Http\Requests\Product;

use Illuminate\Foundation\Http\FormRequest;

class ProductStoreRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            "title" => ['string', 'required'],
            "sku" => ['string', 'required', 'unique:products,sku'],
            "description" => ["nullable", "string"],
            "imageUpload" => ["nullable", "array"],
            "imagePath" => ["nullable", "array"],
            "product_variant" => ["nullable", "array"],
            "product_variant.*.option" => ["required", "integer"],
            "product_variant.*.tags" => ["nullable", "array"],
            "product_variant.*.tags.*" => ["nullable", "string"],
            "product_preview" => ["nullable", "array"],
            "product_preview.*.variant" => ["nullable", "string"],
            "product_preview.*.price" => ["nullable", "numeric"],
            "product_preview.*.stock" => ["nullable", "numeric"],
        ];
    }
}
