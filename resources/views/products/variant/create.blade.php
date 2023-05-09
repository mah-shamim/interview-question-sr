@extends('layouts.app')

@section('content')
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">New Product Variant</h1>
        <a href="{{ route('product-variant.index') }}" class="float-right btn btn-primary">+ All Variant</a>
    </div>
    <div class="row justify-content-center">
        <div class="col-md-4">
            <form class="card shadow mb-5" action="{{ route('product-variant.store') }}" method="post">
                @csrf
                <div class="card-body">
                    <div class="form-group">
                        <label for="">Title</label>
                        <input type="text" name="title" value="{{ old('title') }}" class="form-control @error('title') is-invalid @enderror">
                        @error('title')
                        <span class="invalid-feedback" role="alert"><strong>{{ $message }}</strong></span>
                        @enderror
                    </div>

                    <div class="form-group">
                        <label for="">Note</label>
                        <textarea name="description" id="" cols="30" rows="3"
                                  class="form-control @error('description') is-invalid @enderror">{{ old('description') }}</textarea>
                        @error('description')
                        <span class="invalid-feedback" role="alert"><strong>{{ $message }}</strong></span>
                        @enderror
                    </div>
                </div>

                <div class="card-footer">
                    <button type="submit" class="btn btn-primary">Submit</button>
                </div>
            </form>
        </div>
    </div>


@endsection

