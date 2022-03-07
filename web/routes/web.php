<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('/test', function () {
    return view('test');
});

// Disini saya mempersiapkan route untuk menampilkan dari resource yang ada 
// di folder resources/views/conteoh_template. Selanjutnya kita ke file tsb
Route::get('/layout', function () {
    return view('contoh_template');
});
