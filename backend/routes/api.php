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



// User
Route::post("/register", [\App\Http\Controllers\UserController::class, 'register']);
Route::post("/login", [\App\Http\Controllers\UserController::class, 'login']);
Route::get("/user/{:id}", [\App\Http\Controllers\UserController::class, 'profile']);
Route::middleware('auth:sanctum')->get('/user', [\App\Http\Controllers\UserController::class, 'index']);
Route::middleware('auth:sanctum')->post("/logout", [\App\Http\Controllers\UserController::class, 'logout']);

// Review
Route::get("/review", [\App\Http\Controllers\ReviewController::class, 'index']);
Route::get("/review/{id}",[\App\Http\Controllers\ReviewController::class, "show"]);
Route::middleware('auth:sanctum')->group(function() {
    Route::post('/review', [\App\Http\Controllers\ReviewController::class, 'store']);
    Route::post('/review/create', [\App\Http\Controllers\ReviewController::class, 'create']);
    Route::post('/review/delete/');
    Route::get('/review/{user_id}',[\App\Http\Controllers\ReviewController::class, 'getUserByUserID']);
});

// Tikum
Route::get("/tikum",[\App\Http\Controllers\TikumController::class, "index"]);
Route::middleware('auth:sanctum')->group(function() {
    Route::post("/tikum/create",[\App\Http\Controllers\TikumController::class,"create"]);
});


// Komentar
Route::get("/komentar/{review_id}",[\App\Http\Controllers\KomentarController::class, "getallkomentar_byreviewid"]);
Route::middleware('auth:sanctum')->group(function(){
    Route::post('/komentar',[\App\Http\Controllers\KomentarController::class,"create"]);
    
});
