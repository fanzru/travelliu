{{-- 
  Extends layout artinya kita mengambil file dari layout.blade.php,
  melakukan copy paste ke file ini secara literal
  --}}
@extends("layout")


{{-- Extamds navbar artinya kita mengambil file dari navbar.blade.php,
  melakukan copy paste ke dalam file ini secara literal --}}
@extends("navbar")

{{-- Kita mengisi file dari hasil copy paste yang literal, dan mengisi
  yield("content") dengan <div>Hello World</div> --}}
@section('content')
    <div>
      Hello World
    </div>
@endsection