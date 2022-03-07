{{-- 
  Dimulai dari sini, kita bisa tentukan layout dasar (App.js kalau di react)
  --}}

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Contoh Layouting</title>
</head>
<body>
  {{-- Menggunakan yield, berarti nanti ketika ada 
    @content("navbar") akan membaca isi dari hal tersebut --}}
  @yield('navbar') 
  {{-- Menggunakan yield, berarti nanti ketika ada 
    @content("content") akan membaca isi dari hal tersebut --}}
  @yield('content')
</body>
</html>

{{-- Pada intinya kita menyiapkan component menggunakan yield
    Selanjutnya kita bisa buka file resource/routes/web.php
  --}}