@extends('layouts.app')

@section('content')
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Edit Product</h1>
    </div>
    <form action="{{ route('product.update', $product->id) }}" method="post" autocomplete="off" spellcheck="false">
        @csrf
        {{ method_field('PUT') }}
        <input type="hidden" id="edit_form" value="1">
        <section>
            <div class="row">
                <div class="col-md-6">
                    <!--                    Product-->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                            <h6 class="m-0 font-weight-bold text-primary">Product</h6>
                        </div>
                        <div class="card-body border">
                            <div class="form-group">
                                <label for="product_name">Product Name</label>
                                <input type="text"
                                       name="title"
                                       id="product_name"
                                       required
                                       placeholder="Product Name"
                                       class="form-control"
                                       value="{{$product->title}}"
                                >
                            </div>
                            <div class="form-group">
                                <label for="product_sku">Product SKU</label>
                                <input type="text" name="sku"
                                       id="product_sku"
                                       required
                                       placeholder="Product Name"
                                       class="form-control"
                                       value="{{$product->sku}}"
                                ></div>
                            <div class="form-group mb-0">
                                <label for="product_description">Description</label>
                                <textarea name="description"
                                          id="product_description"
                                          required
                                          rows="4"
                                          class="form-control">{{$product->description}}</textarea>
                            </div>
                        </div>
                    </div>
                    <!--                    Media-->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between"><h6
                                class="m-0 font-weight-bold text-primary">Media</h6></div>
                        <div class="card-body border">
                            <div id="file-upload" class="dropzone dz-clickable">
                                <div class="dz-default dz-message"><span>Drop files here to upload</span></div>
                            </div>
                        </div>
                        {{--@dd($product->productImages)--}}
                        @if($product->productImages)
                            {{--@foreach($product->productImages as $key=>$productImage)
                                <input type="text" class="form-control" value="{{$productImage->file_path}}" name="imageUpload[{{$key}}]" required>
                                <input type="text" class="form-control" value="{{public_path('images')}}" name="imagePath[{{$key}}]" required>
                                @push('page_js')
                                    <script>
                                        myDropzone.addFile('{{public_path('images')}}/{{$productImage->file_path}}')
                                    </script>
                                @endpush
                            @endforeach--}}

                        @endif
                        <div class="media-section"></div>
                    </div>
                </div>
                <!--                Variants-->
                <div class="col-md-6">
                    <div class="card shadow mb-4">
                        <div class="card-header py-3"><h6
                                class="m-0 font-weight-bold text-primary">Variants</h6>
                        </div>
                        <div class="card-body pb-0" id="variant-sections">
                            @php
                                $variant_sections_count = 0;
                            @endphp
                            @foreach($product['productVariant'] as $key=>$productVariant)
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="">Option</label>
                                        <select id="select2-option-{{$variant_sections_count}}" data-index="{{$variant_sections_count}}" name="product_variant[{{$variant_sections_count}}][option]" class="form-control custom-select select2 select2-option">
                                            <option value="1" @if($key == 1) selected @endif>
                                                Color
                                            </option>
                                            <option value="2" @if($key == 2) selected @endif>
                                                Size
                                            </option>
                                            <option value="6" @if($key == 6) selected @endif>
                                                Style
                                            </option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <div class="form-group">
                                        <label class="d-flex justify-content-between">
                                            <span>Value</span>
                                            <a href="#" class="remove-btn" data-index="{{$variant_sections_count}}" onclick="removeVariant(event, this);">Remove</a>
                                        </label>
                                        @push('page_js')
                                        <script>
                                            var vals = {!! '['.implode(',',$productVariant).']' !!};

                                            vals.forEach(function(e){
                                                //if(!$('#select2-value-{{$variant_sections_count}}').find('option:contains(' + e + ')').length)
                                                    $('#select2-value-{{$variant_sections_count}}').append($('<option value="'+e+'">').text(e));
                                            });

                                            $('#select2-value-{{$variant_sections_count}}').val(vals).trigger("change");
                                        </script>
                                        @endpush
                                        <select id="select2-value-{{$variant_sections_count}}" data-index="{{$variant_sections_count}}" name="product_variant[{{$variant_sections_count}}][value][]" class="select2 select2-value form-control custom-select" multiple="multiple">
                                        </select>
                                    </div>
                                </div>
                            </div>
                                @php
                                    $variant_sections_count++;
                                @endphp
                            @endforeach
                        </div>
                        <div class="card-footer bg-white border-top-0" id="add-btn">
                            <div class="row d-flex justify-content-center">
                                <button class="btn btn-primary add-btn" onclick="addVariant(event);">
                                    Add another option
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="card shadow">
                        <div class="card-header text-uppercase">Preview</div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered table-striped">
                                    <thead>
                                    <tr class="text-center">
                                        <th width="33%">Variant</th>
                                        <th>Price</th>
                                        <th>Stock</th>
                                    </tr>
                                    </thead>
                                    <tbody id="variant-previews">
                                    @foreach($product->productVariantPrices as $key=>$productVariantPrices)
                                        <tr>
                                            <th>
                                                <input type="hidden" name="product_preview[{{$key}}][variant]"
                                                       value="{{isset($productVariantPrices->productVariantTwo) ? $productVariantPrices->productVariantTwo->variant:null}}{{isset($productVariantPrices->productVariantOne) ? '/'.$productVariantPrices->productVariantOne->variant:null}}{{isset($productVariantPrices->productVariantThree) ? '/'.$productVariantPrices->productVariantThree->variant:null}}">
                                                <span class="font-weight-bold">{{isset($productVariantPrices->productVariantTwo) ? $productVariantPrices->productVariantTwo->variant:null}}{{isset($productVariantPrices->productVariantOne) ? '/'.$productVariantPrices->productVariantOne->variant:null}}{{isset($productVariantPrices->productVariantThree) ? '/'.$productVariantPrices->productVariantThree->variant:null}}</span>
                                            </th>
                                            <td>
                                                <input type="text" class="form-control" value="{{$productVariantPrices->price}}" name="product_preview[{{$key}}][price]" required>
                                            </td>
                                            <td>
                                                <input type="text" class="form-control" value="{{$productVariantPrices->stock}}" name="product_preview[{{$key}}][stock]">
                                            </td>
                                        </tr>
                                    @endforeach
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <button type="submit" class="btn btn-lg btn-primary">Save</button>
            <button type="button" class="btn btn-secondary btn-lg">Cancel</button>
        </section>
    </form>
@endsection

@push('page_js')
    @php
        $thumbnails = [];
        foreach ($product->productImages as $productImage){
            if(file_exists(public_path('images/'.$productImage->file_path)){
                $thumbnails[] = [
                   'name' => $productImage->file_path,
                    'size' => filesize(public_path('images/'.$productImage->file_path)),
                    'type' => mime_content_type(public_path('images/'.$productImage->file_path)),
                    'status' => 'added',
                    'url' => asset('images/'.$productImage->file_path),
                    'accepted' => true
                ];
            }
        }
    @endphp
    <script>
        fileUploadURL="{{ route('file-upload') }}";
        fileDeleteURL="{{ route('file-delete') }}";
        thumbnails = {!! json_encode($thumbnails) !!};
        console.log(thumbnails)
    </script>
    <script type="text/javascript" src="{{ asset('js/product.js') }}"></script>
@endpush
