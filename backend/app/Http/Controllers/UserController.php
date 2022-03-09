<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use mysql_xdevapi\Exception;

class UserController extends Controller
{
    public function __construct()
    {
        $this->status = 200;
        $this->data = [];
    }

    public function register(Request $request)
    {
        try {
            $this->validate($request, [
                'name' => "required",
                'email' => 'required|email',
                'password'=> 'required',
            ]);

            User::create([
                'name' => $request->name,
                'email' => $request->email,
                'password' =>bcrypt($request->password),
            ]);

            $this->data = [
                "message"=>"Sukses"
            ];
            return response($this->data, $this->status);
        } catch (Exception $e) {
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
                'password'=> 'required',
            ]);
            if (Auth::attempt(["email"=>$request->email, "password"=>$request->password])) {
                $user = Auth::user();
                $token = $user->createToken('tkn')->plainTextToken;
                $this->data = [
                    "user" => $user,
                    "token" => $token,
                ];
                return response($this->data, $this->status)->cookie(
                    "personal_token", $token, 60*24 // 1 Day
                );
            } else {
                $this->status = 400;
                $this->data = [
                    "message"=>"Nama atau password salah",
                ];
                return response($this->data, $this->status);
            }
        } catch ( Exception $e ) {
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
        } catch ( Exception $e ) {
            $this->data = $e->getMessage();
            $this->status = 500;
            return response($this->data, $this->status);
        }
    }
}
