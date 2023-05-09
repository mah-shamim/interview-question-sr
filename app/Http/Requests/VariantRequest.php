<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class VariantRequest extends FormRequest
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

        if ($this->method() == 'PUT') {
            return [
                'title' => 'required|unique:variants,title,' . $this->route('product_variant')
            ];
        }

        return [
            'title' => 'required|unique:variants',
            'description'
        ];
    }
}
