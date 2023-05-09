<?php

namespace App\Http\Controllers;

use App\Http\Requests\VariantRequest;
use App\Models\Variant;
use Illuminate\Http\Request;

class VariantController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Http\Response|\Illuminate\View\View
     */
    public function index()
    {
        $variants = Variant::paginate(10);
        return view('products.variant.index', compact('variants'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Http\Response|\Illuminate\View\View
     */
    public function create()
    {
        return view('products.variant.create');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function store(VariantRequest $request)
    {
        $variant = new Variant();
        $variant->fill($request->all());
        $variant->save();
        return redirect()->back()->with('success', 'Variant Saved');
    }

    /**
     * Display the specified resource.
     *
     * @param \App\Models\Variant $variant
     * @return \Illuminate\Http\Response
     */
    public function show(Variant $variant)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param \App\Models\Variant $variant
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Http\Response|\Illuminate\View\View
     */
    public function edit($id)
    {
        $product_variant = Variant::findOrFail($id);
        return view('products.variant.edit', compact('product_variant'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function update(VariantRequest $request, $id)
    {
        $variant = Variant::findOrFail($id);
        $variant->fill($request->all());
        $variant->save();
        return redirect()->back()->with('success', 'Variant Updated');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param \App\Models\Variant $variant
     * @return \Illuminate\Http\Response
     */
    public function destroy(Variant $variant)
    {
        //
    }
}
