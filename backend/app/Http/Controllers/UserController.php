<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Review;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class UserController extends Controller
{
    public function __construct()
    {
        $this->status = 200;
        $this->data = [];
    }

    public function index(Request $request)
    {
        try {
            $user = $request->user();
            $allReview = Review::where('user_id', $user->id)->get();
            $totalReview = $allReview->count();

            if ($totalReview == 0) {
                $this->data = [
                    "user" => $user,
                    "review" => [],
                    "total_review" => 0,
                    "avg_ratings" => 0
                ];
                return response($this->data, $this->status);
            }

            $sumReviewRatings = $allReview->sum('rating');

            $this->data = [
                "user" => $user,
                "review" => $allReview,
                "total_review" => $totalReview,
                "avg_ratings" => $sumReviewRatings / $totalReview
            ];

            return response($this->data, $this->status);
        } catch (\Exception $e) {
            $this->data = $e->getMessage();
            $this->status = 500;
            return response($this->data, $this->status);
        }
    }

    public function profile(int $id)
    {
        try {
            $user = User::find($id);
            $totalReview = Review::where('user_id', $user->id)->count();

            if ($totalReview == 0) {
                $this->data = [
                    "user" => $user,
                    "total_review" => 0,
                    "avg_ratings" => 0
                ];
                return response($this->data, $this->status);
            }

            $sumReviewRatings = Review::where('user_id', $user->id)->sum('rating');

            $this->data = [
                "user" => $user,
                "total_review" => $totalReview,
                "avg_ratings" => $sumReviewRatings / $totalReview
            ];

            return response($this->data, $this->status);
        } catch (\Exception $e) {
            $this->data = $e->getMessage();
            $this->status = 500;
            return response($this->data, $this->status);
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

            $this->data = [
                "message" => "Sukses"
            ];
            return response($this->data, $this->status);
        } catch (\Exception $e) {
            $this->data = $e->getMessage();
            $this->status = 500;
            return response($this->data, $this->status);
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
                $this->data = [
                    "user" => $user,
                    "token" => $token,
                ];
            } else {
                $this->status = 400;
                $this->data = [
                    "message" => "Nama atau password salah",
                ];
            }
            return response($this->data, $this->status);
        } catch (\Exception $e) {
            $this->data = $e->getMessage();
            $this->status = 500;
            return response($this->data, $this->status);
        }
    }

    public function logout()
    {
        try {
            Auth::guard('web')->logout();
            auth()->user()->tokens()->delete();
            $this->status = 200;
            $this->data = [
                "message" => "Sukses"
            ];
            return response($this->data, $this->status);
        } catch (\Exception $e) {
            $this->data = $e->getMessage();
            $this->status = 500;
            return response($this->data, $this->status);
        }
    }
}
