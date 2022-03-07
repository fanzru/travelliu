@extends('template.layout')

@section('title', 'Daftar')

@section('style')
    <style>

    </style>
@endsection

@section('head')

@endsection

@section('content')
<div class="z-10 h-screen flex flex-col items-center justify-center">
      <div class="max-w-[1440px]">
          <div class="w-full">
              <div>
                  <p class="text-3xl md:text-5xl font-bold w-full text-center mb-10">
                      Bagikan Momentmu!!
                  </p>
              </div>
              <div>
                <form action="/register" method="POST" class="form-control text-center ">
                  @csrf
                  <div>
                    
                    <label class="label  ">
                        <span class="label-text ">Nama</span>
                    </label>
                    <input name="name" placeholder="Type here"  type="text" class="input input-bordered w-full">

                    <label class="label  ">
                        <span class="label-text ">Email</span>
                    </label>
                    <input name="email" placeholder="Type here"  type="email"  class="input input-bordered w-full">
                    
                    <label class="label">
                        <span class="label-text ">Password</span>
                    </label>
                    <input name="password" type="password" placeholder="Type here" class="input input-bordered w-full ">
                    
                    <label class="label">
                        <span class="label-text ">Ulangi Password</span>
                    </label>
                    <input name="password" type="password" placeholder="Type here" class="input input-bordered w-full ">


                  </div>
                  <div>
                    <button type="submit" class="btn mt-10 w-[100px]">Daftar</button>
                  </div>
                </form>
                <div class="text-center mt-6 text-gray-400">
                  <p>
                    Sudah punya akun ? <a class="text-black" href="/login">Masuk</a>
                  </p>
                </div>
              </div>
          </div>
      </div>
  </div>
@endsection
