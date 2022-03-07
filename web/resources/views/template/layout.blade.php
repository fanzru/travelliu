@include('template.navbar')
@include('template.footer')

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Contoh Layouting Bag 2 - @yield('title')</title>
  <link href="{{ asset('css/app.css') }}" rel="stylesheet">
  @yield('style')
  @yield('head')
</head>
<body>
  @yield('navbar')
  @yield('content')
  @yield('footer')
</body>
</html>