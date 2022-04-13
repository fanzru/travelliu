<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Review;
use App\Models\Tikum;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class UserController extends Controller
{

    public function myProfile(Request $request)
    {
        try {
            $user = $request->user();
            $allReview = Review::where('user_id', $user->id)->get();
            $allTikum = Tikum::where('user_id', $user->id)->get();
            $totalReview = $allReview->count();
            if ($totalReview == 0) {
                $data = [
                    "user" => $user,
                    "review" => [],
                    "tikum" => $allTikum,
                    "total_review" => 0,
                    "avg_ratings" => 0
                ];
                return response($data, 200);
            }
            $sumReviewRatings = $allReview->sum('rating');
            $data = [
                "user" => $user,
                "review" => $allReview,
                "tikum" => $allTikum,
                "total_review" => $totalReview,
                "avg_ratings" => $sumReviewRatings / $totalReview
            ];
            return response($data, 200);
        } catch (\Exception $e) {
            return response("Internal Server Error", 500);
        }
    }

    public function profile(int $id)
    {
        try {
            $user = User::find($id);
            $reviews = Review::where('user_id', $user->id)->get();
            $totalReview = $reviews->count();
            if ($totalReview == 0) {
                $data = [
                    "user" => $user,
                    "reviews" => [],
                    "total_review" => 0,
                    "avg_ratings" => 0
                ];
                return response($data, 200);
            }
            $sumReviewRatings = Review::where('user_id', $user->id)->sum('rating');
            $data = [
                "user" => $user,
                "reviews" => $reviews,
                "total_review" => $totalReview,
                "avg_ratings" => $sumReviewRatings / $totalReview
            ];
            return response($data, 200);
        } catch (\Exception $e) {
            return response("Internal Server Error", 500);
        }
    }

    public function register(Request $request)
    {
        try {
            $this->validate($request, [
                'name' => "required",
                'email' => 'required|email',
                'password' => 'required',
            ]);

            User::create([
                'name' => $request->name,
                'email' => $request->email,
                'password' => bcrypt($request->password),
            ]);
            return response("Sukses", 200);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response("Nama, Email, atau Password tidak valid", 400);
        } catch (\Exception $e) {
            return response("Internal Server Error", 500);
        }
    }

    public function login(Request $request)
    {
        try {
            $this->validate($request, [
                'email' => 'required|email',
                'password' => 'required',
            ]);
            if (Auth::attempt(["email" => $request->email, "password" => $request->password])) {
                $user = Auth::user();
                $token = $user->createToken('tkn')->plainTextToken;
                $data = [
                    "user" => $user,
                    "token" => $token,
                ];
                return response($data, 200);
            } else {
                return response("Nama atau password salah", 400);
            }
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response("Nama, Email, atau Password tidak valid", 400);
        } catch (\Exception $e) {
            return response("Internal Server Error", 500);
        }
    }

    public function logout()
    {
        try {
            Auth::guard('web')->logout();
            auth()->user()->tokens()->delete();
            return response("Sukses", 200);
        } catch (\Exception $e) {
            return response("Internal Server Error", 500);
        }
    }
}
