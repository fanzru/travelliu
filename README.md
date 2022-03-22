
# Travelliu

Tugas Besar Aplikasi Berbasis Platform , Sedang berprogress mohon doa restunya ya temen - temen semoga kami mampu menyelesaikan ini dan bisa menjadi mahasiswa yang tetap sehat tanpa begadang, Aamiin.

## Development
Requirements: Python `>3.8`, Php `>8.0` dengan `composer`, Node.js `>14.0`  
### Initial Setup
1. Masuk ke dalam folder `backend` dan jalankan perintah `npm i` dan `composer install`
2. Masuk ke dalam folder `frontend` dan jalankan perintah `npm i`
3. Masuk ke dalam folder `ai_backend` dan jalankan perintah `python -m pip install -r requirements.txt`
  
### Frontend Development
Untuk melakukan development pada frontend:  
1. Masuk ke dalam folder `frontend` dan set menjadi direktori aktif
2. Buat file `.env.local` dan masukkan isi dari `.env.local.example` ke dalam file `.env.local`
3. Jalankan perintah `npm run dev` untuk memulai sesi development

### Backend Development
Untuk melakukan development pada backend:  
1. Masuk ke dalam folder `backend` dan set menjadi direktori aktif
2. Buat file `.env` dan isi file tersebut dengan isian dari file `.env.example`
3. Buka file `.env` dan isikan `DB_DATABASE` dengan `[nama]_dev` (contoh: zendy_dev) dan untuk `DB_HOST`, `DB_PORT`, `DB_USERNAME`, `DB_PASSWORD` bisa melihat pada grup Whatsapp.
4. Lakukan migrasi **jika dibutuhkan** dengan menjalankan `php artisan migrate`
5. Untuk menyalakan server backend jalankan `php artisan serve`
6. Untuk menyalakan AI endpoint, masuk ke dalam folder `ai_backend` dan nyalakan server dengan `python main.py`

### Frontend - Backend Development
Lakukan pada dua terminal yang berbeda untuk menjalankan urutan `Frontend Development` dan `Backend Development`