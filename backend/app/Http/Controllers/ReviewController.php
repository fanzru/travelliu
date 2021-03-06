<?php

namespace App\Http\Controllers;

use App\Models\Review;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;

class ReviewController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        try {
            $review = Review::with('user')->orderByDesc('id')->get();
            $review->loadCount('komentar');
            return response($review, 200);
        } catch (\Exception $e) {
            return response("Internal Serer Error", 500);
        }
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function create(Request $request)
    {
        try {
            $validated = $this->validate($request, [
                'nama_tempat' => ['required'],
                'alamat' => ['required'],
                'rating' => ['required', 'numeric',"between:0,5.0"],
                'review' => ['required'],
                'latitude' => ['numeric','between:-90.0,90.0'],
                'longitude' => ['numeric','between:-180.0,180.0'],
                'photo' => ['required', 'mimes:jpg,png,jpeg', 'max:2000'],
            ]);
            if (predictTextIsSpam($request->review)) {
                return response("Review terdeteksi spam", 400);
            }
            $user = Auth::user();
            $uuid = Str::uuid()->toString();
            $extension = $request->photo->extension();
            $imageName = $uuid.'.'.$extension;  
            $request->photo->move(public_path('images'), $imageName);

            $review = Review::create([
                "nama_tempat" => $request->nama_tempat,
                "alamat" => $request->alamat,
                "rating" => $request->rating,
                "review" => $request->review,
                "latitude" => $request->latitude,
                "longitude" => $request->longitude,
                "photo" => "/images/".$imageName,
                "user_id" => $user->id
            ]);
            return response($review, 200);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response("Request tidak valid", 400);
        } catch (\Exception $e) {
            return response("Internal Server Error", 500);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Review  $review
     * @return \Illuminate\Http\Response
     * @param  string  $id
     */
    public function show(int $id)
    {
        try {
            $review = Review::findOrFail($id);
            // Lazy eager loading
            $review->load('user');
            $review->load('komentar');
            $review->load('komentar.user');
            return response($review, 200);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response("Review tidak ditemukan", 400);
        } catch (\Exception $e) {
            return response("Internal Server Error", 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Review  $review
     * @return \Illuminate\Http\Response
     */
    public function destroy(int $id)
    {
        //
        try {
            $user = Auth::user();
            $review = Review::findOrFail($id);
            if ($review->user_id !=  $user->id) {
                return response("Review tidak valid", 403);
            }
            $review->delete();
            return response("Delete Review sukses", 200);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response("Review tidak valid", 400);
        } catch (\Exception $e) {
            return response("Internal Server Error", 500);
        }
    }
}
