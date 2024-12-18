# **TMS / Smart Routing System** 🚀

TMS (Transportation Management System) atau **Smart Routing System** adalah sebuah platform berbasis Laravel yang dirancang untuk mengelola transportasi secara efisien dan pintar dengan fitur-fitur modern seperti manajemen dashboard, integrasi API, dan routing berbasis logika otomatis.

---

## **🎯 Fitur Utama**
- **Manajemen Dashboard:**
  - Monitoring data transportasi secara real-time.
  - Analisis performa kendaraan.
  - Panel admin yang user-friendly.

- **Sistem Routing Pintar:**
  - Routing otomatis untuk kendaraan berdasarkan algoritma efisiensi.
  - Pengelolaan rute kendaraan secara dinamis.

- **Integrasi API:**
  - Mendukung integrasi dengan aplikasi driver berbasis React Native.
  - Endpoint REST API yang aman dan terstruktur.

- **Notifikasi dan Log:**
  - Sistem pemberitahuan berbasis event.
  - Log aktivitas pengguna.

---

## **🛠️ Teknologi yang Digunakan**
- **Backend**: Laravel 9.x
- **Frontend**: Inertia.js + React.js
- **Database**: MySQL
- **DevOps**: Apache, Ubuntu VPS
- **Build Tools**: Vite, Node.js
- **Style**: TailwindCSS

---

## **📂 Struktur Proyek**
```bash
├── app/                # Direktori utama aplikasi Laravel
├── bootstrap/          # Bootstrap file untuk Laravel
├── config/             # File konfigurasi aplikasi
├── database/           # Migrasi dan seeder database
├── public/             # Entry point aplikasi (index.php)
├── resources/          # View, assets (CSS, JS), dan komponen React
├── routes/             # File routing aplikasi
├── storage/            # Log, cache, dan file storage
├── tests/              # Unit testing
├── .env.example        # Contoh file konfigurasi lingkungan
└── vite.config.js      # Konfigurasi Vite untuk frontend
```

---

## **⚙️ Cara Install dan Menjalankan Proyek**

### **1. Clone Repository**
```bash
git clone [https://github.com/username/repository-name.git](https://github.com/ramadhannezz/SRS.git)
cd repository-name
```

### **2. Instal Dependensi Backend**
Pastikan `composer` terinstal di sistem Anda:
```bash
composer install
```

### **3. Instal Dependensi Frontend**
Pastikan `Node.js` dan `npm` terinstal di sistem Anda:
```bash
npm install
```

### **4. Konfigurasi File `.env`**
Duplikat file `.env.example` dan ubah menjadi `.env`, kemudian sesuaikan konfigurasi seperti berikut:
```env
APP_NAME=TMS
APP_ENV=local
APP_KEY=base64:GENERATE_APP_KEY_HERE
APP_DEBUG=true
APP_URL=http://localhost

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=your_database
DB_USERNAME=your_username
DB_PASSWORD=your_password
```

### **5. Generate Key dan Migrasi Database**
```bash
php artisan key:generate
php artisan migrate --seed
```

### **6. Build Frontend**
Untuk development:
```bash
npm run dev
```
Untuk production:
```bash
npm run build
```

### **7. Jalankan Server**
```bash
php artisan serve
```

Buka di browser:
```
http://127.0.0.1:8000
```

---

## **🚀 Deployment**
Untuk deploy ke server VPS atau production:
1. **Pastikan PHP, Apache, MySQL, dan Node.js terinstal.**
2. **Copy semua file ke server.**
3. **Jalankan perintah berikut di server:**
   ```bash
   composer install --optimize-autoloader --no-dev
   npm install
   npm run build
   php artisan config:cache
   php artisan route:cache
   php artisan view:cache
   ```

4. **Setel izin folder:**
   ```bash
   chmod -R 775 storage bootstrap/cache
   chown -R www-data:www-data .
   ```

---

## **🌟 Kontributor**
- **Re-Developed by**: Ramadhan
- **Pengembang Awal**: Samuel Boadu
- **Terima Kasih kepada**:
  - Komunitas Laravel
  - Pengembang React.js

---

## **📄 Lisensi**
Proyek ini dilisensikan di bawah [MIT License](LICENSE).

---

## **📧 Kontak**
Jika Anda memiliki pertanyaan atau butuh bantuan:
- Email: ramadhan8100@gmail.com
- LinkedIn: [Ramadhan](https://linkedin.com/in/ramadhannezz)

Selamat menggunakan TMS / Smart Routing System! 🚚📍

--- 

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

Anda bisa mengubah beberapa detail sesuai dengan proyek Anda untuk menjadikannya lebih personal. 😊