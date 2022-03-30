<?php

namespace App\Http\Controllers;

use App\Models\Komentar;
use App\Models\Review;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class KomentarController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        try {
            $komentar = Komentar::with('user:id,name')->get();
            return response($komentar, 200);
        } catch (\Exception $e) {
            return response("Internal Server Error", 500);
        }
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(int $review_id, Request $request)
    {
        try {
            $this->validate($request, [
                'komentar' => ['required'],
            ]);
            $user = Auth::user();
            $review = Review::findOrFail($review_id);
            $komentar = Komentar::create([
                "komentar" => $request->komentar,
                "review_id" => $review->id,
                "user_id" => $user->id
            ]);
            return response($komentar, 200);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response("Review tidak valid", 400);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response("Request tidak valid", 400);
        } catch (\Exception $e) {
            return response("Internal Server Error", 500);
        }
    }

    public function getAllKomentarByReviewId(int $review_id)
    {
        try {
            $review = Review::findOrFail($review_id);
            $komentar = Komentar::where(array('review_id' => $review->id))->firstOrFail();
            $komentar->load('user');
            return response($komentar, 200);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response("Review tidak valid", 400);
        } catch (\Exception $e) {
            return response("Internal Server Error", 500);
        }
    }
}
