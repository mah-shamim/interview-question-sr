<?php

namespace App\Http\Controllers;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth');
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function index()
    {
        return view('home');
    }

    // Store Image

    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function storeImage(Request $request): JsonResponse
    {
        $request->validate([
            'file' => 'required|image|mimes:png,jpg,jpeg,svg|max:2048'
        ]);

        $imageName = microtime().'.'.$request->file->extension();

        // Public Folder
        $request->file->move(public_path('images'), $imageName);

        return response()->json(['name'=>$imageName, 'imagePath'=>public_path('images')]);
    }

    public function deleteImage(Request $request)
    {
        if(file_exists(public_path('images')."/".$request->file_to_be_deleted)){
            unlink(public_path('images')."/".$request->file_to_be_deleted);
        }
    }
}
