@extends('template.layout')

@section('title', "Judul Custom")

@section('style')
    
@endsection

@section('head')
    
@endsection

@section('content')
<div class="bg-gray-900">
   @component('components.button', ["angka" => "1"])
       @slot('judul')
           Hello
       @endslot
   @endcomponent
</div>
@endsection