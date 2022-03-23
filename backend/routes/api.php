<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

// User
Route::post("/register", [\App\Http\Controllers\UserController::class, 'register']);
Route::post("/login", [\App\Http\Controllers\UserController::class, 'login']);
Route::middleware('auth:sanctum')->post("/logout", [\App\Http\Controllers\UserController::class, 'logout']);

// Review
Route::get("/review", [\App\Http\Controllers\ReviewController::class, 'index']);
Route::middleware('auth:sanctum')->group(function() {
    Route::post('/review', [\App\Http\Controllers\ReviewController::class, 'store']);
});

// Tikum
Route::get("/tikum",[\App\Http\Controllers\TikumController::class, "index"]);
Route::middleware('auth:sanctum')->group(function() {
    Route::post("/tikum/create",[\App\Http\Controllers\TikumController::class,"create"]);
});

