@include('template.navbar')
@include('template.footer')

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Travelliu - @yield('title')
    </title>
    <link href="{{ asset('css/app.css') }}" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    @yield('style')
    @yield('head')
    @yield('script')
</head>

<body>
    @yield('navbar')
    @yield('content')
    @yield('footer')
</body>

</html>
