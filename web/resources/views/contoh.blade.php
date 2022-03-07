@extends('template.layout')

@section('title', "Judul Custom")

@section('style')
<style>

</style>
@endsection

@section('head')
    
@endsection

@section('script')
<script>
    $("button").click(function(){
        alert("Hello World");
    });
</script>
@endsection

@section('content')
<div class="bg-gray-900">
   <div class="min-h-screen flex items-center justify-center">
   @component('components.button', ["angka" => "1", "judul" =>"affan ganteng"]) @endcomponent
   </div>
</div>
@endsection