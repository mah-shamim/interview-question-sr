@extends('layouts.app')

@section('content')

    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Products</h1>
    </div>


    <div class="card">
        <form action="" method="get" class="card-header">
            <div class="form-row justify-content-between">
                <div class="col-md-2">
                    <input type="text" name="title" placeholder="Product Title" class="form-control" value="{{request('title')}}">
                </div>
                <div class="col-md-2">
                    <select name="variant" id="" class="form-control">
                        <option value="">-- Select Variant --</option>
                        @foreach($variants as $variant)
                            <optgroup label="{{$variant->title}}">
                                @foreach($variant->productVariants as $productVariant)
                                    <option value="{{$productVariant->variant}}"
                                            @if($productVariant->variant == request('variant')) selected @endif
                                    >{{$productVariant->variant}}</option>
                                @endforeach
                            </optgroup>
                        @endforeach
                    </select>
                </div>

                <div class="col-md-3">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">Price Range</span>
                        </div>
                        <input type="text" name="price_from" aria-label="Price From" placeholder="From" class="form-control" value="{{request('price_from')}}">
                        <input type="text" name="price_to" aria-label="Price To" placeholder="To" class="form-control" value="{{request('price_to')}}">
                    </div>
                </div>
                <div class="col-md-2">
                    <input type="date" name="date" placeholder="Date" class="form-control" value="{{request('date')}}">
                </div>
                <div class="col-md-1">
                    <button type="submit" class="btn btn-primary float-right"><i class="fa fa-search"></i></button>
                </div>
            </div>
        </form>

        <div class="card-body">
            <div class="table-response">
                <table class="table">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Variant</th>
                        <th width="150px">Action</th>
                    </tr>
                    </thead>

                    <tbody>

                    @foreach($products as $product)
                        <tr>
                            <td>{{$product->id}}</td>
                            <td>{{$product->title}} <br> Created at : {{\Carbon\Carbon::parse($product->created_at)->format('d-M-Y')}}</td>
                            <td>Quality product in low cost</td>
<!--                            <td>{{$product->description}}</td>-->
                            <td>

                                <dl class="row mb-0 variant" style="height: 160px; overflow: hidden" id="variant">
                                @if(isset($product->product_variant_prices))
                                    @foreach(json_decode($product->product_variant_prices) as $productVariantPrice)

                                        <dt class="col-sm-3 pb-0">
                                            {{isset($productVariantPrice->product_variant_two) ? strtoupper($productVariantPrice->product_variant_two) : ''}}
                                            {{isset($productVariantPrice->product_variant_one) ? ' / '.ucfirst($productVariantPrice->product_variant_one) : ''}}
                                            {{isset($productVariantPrice->product_variant_three) ? ' / '.ucfirst($productVariantPrice->product_variant_three) : ''}}
                                        </dt>
                                        <dd class="col-sm-9">
                                            <dl class="row mb-0">
                                                <dt class="col-sm-4 pb-0">Price : {{ number_format($productVariantPrice->price,2) }}</dt>
                                                <dd class="col-sm-8 pb-0">InStock : {{ number_format($productVariantPrice->stock,2) }}</dd>
                                            </dl>
                                        </dd>
                                    @endforeach
                                </dl>
                                        <button onclick="$(this).parent().find('.variant:first').toggleClass('h-auto')" class="btn btn-sm btn-link">Show more</button>
                                @endif
                            </td>
                            <td>
                                <div class="btn-group btn-group-sm">
                                    <a href="{{ route('product.edit', $product->id) }}" class="btn btn-success">Edit</a>
                                </div>
                            </td>
                        </tr>

                    @endforeach


                    </tbody>

                </table>
            </div>

        </div>

        <div class="card-footer">
            {{$products->links()}}
        </div>
    </div>

@endsection
