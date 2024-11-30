# ---- Readme - Smart Routing Pages ---- #
###### ############################ ######

# Frontend #
1. Install Library PrimeReact, Google Maps Javascript API, dan Inertia.JS
npm install primereact primeicons 
npm install @react-google-maps/api 

2. Buat Direktori resources/js/Pages/SmartRouting/

3. Membuat Komponen SmartRouting.jsx di Direktori resources/js/Pages/SmartRouting/

# Mengintegrasikan Google Maps
# handleGenerateRouting
Kode belum lengkap dibagian 'handleGenerateRouting' tambahkan logika generate routing dan direction google maps, serta logika untuk menyimpan route ke database.

# Menambahkan Google Maps Initialization
#  useEffect
Kode belum lengkap dibagian 'useEffect' tambahkan kode untuk inisialisasi Google Maps

4. Integrasikan Google Maps di app.blade.php 
<script src="https://maps.googleapis.com/maps/api/js?key={{ config('app.google_maps_api_key') }}&libraries=places,directions"></script>

5. Styling dan Optimasi CSS sesuai kebutuhan di resources/css/app.css


# Backend #
1. Menambahkan route di routes/web.php

use App\Http\Controllers\SmartRoutingController;
Route::get('/smart-routing', [SmartRoutingController::class, 'index']);
Route::post('/smart-routing/generate', [SmartRoutingController::class, 'generate']);

2. Membuat file migrasi untuk table routes

3. Membuat Controller
php artisan make:controller SmartRoutingController

# Menangani Permintaan Frontend Untuk Generate Route (Mendapatkan Koordinat Dari Alamat, Implementasi Algoritma Dijkstra, Menyimpan Data Rute ke Database)

# public function generate
Kode belum lengkap dibagian 'public function generate' untuk mendapatkan lokasi muat dan bongkar lalu mengenerate smart routing menggunakan algoritma Dijkstra dan mengirim data rute kembali ke frontend serta menyimpannya ke databas table routes.

1. Kode belum lengkap untuk mendapatkan kordinat alamat dari table lokasi_muat dan lokasi_bongkar
2. Menangani Implementasi Algoritma Dijkstra Guna Menghitung Rute 
Kode belum lengkap untuk implementasi logika Dijkstra guna menghitung rute terpendek.
3. Menangani Logika Untuk Menyimpan Data Rute ke Database
Kode belum lengkap untuk menyimpan data hasil generate smart routing ke database table routes.

# private function calculateDijkstra
Kode belum lengkap dibagian 'private function calculateDijkstra' tambahkan logika untuk menghitung rute terpendek menggunakan algoritma dijkstra.