<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return Inertia::render('Welcome', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
        'laravelVersion' => Application::VERSION,
        'phpVersion' => PHP_VERSION,
    ]);
});

Route::get('/dashboard', function () {
    return Inertia::render('Dashboard');
})
    ->name('dashboard');
//    ->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

// Route Untuk Menu Button
Route::get('/uikit/button', function () {
    return Inertia::render('main/uikit/button/page');
})->name('button');

// Route Untuk Menu Smart Routing
use App\Http\Controllers\SmartRoutingController;

Route::get('/smart-routing', [SmartRoutingController::class, 'index'])->name('smart-routing');
Route::post('/smart-routing/generate', [SmartRoutingController::class, 'generate']);

// Route Untuk Fitur Auto Plan Routing
use App\Http\Controllers\AutoPlanRoutingController;

Route::post('/auto-plan-routing', [AutoPlanRoutingController::class, 'autoPlan']);

// Route Untuk Halaman Kota
use App\Http\Controllers\KotaController;

Route::get('/kota', [KotaController::class, 'index'])->name('kota');
Route::post('/kota', [KotaController::class, 'store']);
Route::put('/kota/{kota}', [KotaController::class, 'update']);
Route::delete('/kota/{kota}', [KotaController::class, 'destroy']);

// Route Untuk Halaman Kategori Lokasi
use App\Http\Controllers\KategoriLokasiController;

Route::get('/kategori-lokasi', [KategoriLokasiController::class, 'index'])->name('kategori-lokasi.index');
Route::post('/kategori-lokasi', [KategoriLokasiController::class, 'store'])->name('kategori-lokasi.store');
Route::put('/kategori-lokasi/{id}', [KategoriLokasiController::class, 'update'])->name('kategori-lokasi.update');
Route::delete('/kategori-lokasi/{id}', [KategoriLokasiController::class, 'destroy'])->name('kategori-lokasi.destroy');


//==================== Route Untuk Halaman Lokasi Muat ====================//

use App\Http\Controllers\LokasiMuatController;

Route::resource('lokasiMuat', LokasiMuatController::class)->names([
    'index' => 'lokasiMuat.index',
    'create' => 'lokasiMuat.create',
    'store' => 'lokasiMuat.store',
    'show' => 'lokasiMuat.show',
    'edit' => 'lokasiMuat.edit',
    'update' => 'lokasiMuat.update',
    'destroy' => 'lokasiMuat.destroy',
]);

//=============================================================================//


//==================== Route Untuk Halaman Lokasi Bongkar ====================//

use App\Http\Controllers\LokasiBongkarController;

Route::resource('lokasiBongkar', LokasiBongkarController::class)->names([
    'index' => 'lokasiBongkar.index',
    'create' => 'lokasiBongkar.create',
    'store' => 'lokasiBongkar.store',
    'show' => 'lokasiBongkar.show',
    'edit' => 'lokasiBongkar.edit',
    'update' => 'lokasiBongkar.update',
    'destroy' => 'lokasiBongkar.destroy',
]);

Route::post('lokasiBongkar/import', [LokasiBongkarController::class, 'import'])->name('lokasiBongkar.import');

//==================== Route Untuk Master Data ====================//

use App\Http\Controllers\CustomerController;

// Define named routes for CustomerController
Route::get('/customer', [CustomerController::class, 'index'])->name('customer.index');
Route::get('/customer/create', [CustomerController::class, 'create'])->name('customer.create');
Route::post('/customer', [CustomerController::class, 'store'])->name('customer.store');
Route::get('/customer/{customer}', [CustomerController::class, 'show'])->name('customer.show');
Route::get('/customer/{customer}/edit', [CustomerController::class, 'edit'])->name('customer.edit');
Route::put('/customer/{customer}', [CustomerController::class, 'update'])->name('customer.update');
Route::delete('/customer/{customer}', [CustomerController::class, 'destroy'])->name('customer.destroy');


use App\Http\Controllers\VendorController;

// Define named routes for VendorController
Route::get('/vendor', [VendorController::class, 'index'])->name('vendor.index');
Route::get('/vendor/create', [VendorController::class, 'create'])->name('vendor.create');
Route::post('/vendor', [VendorController::class, 'store'])->name('vendor.store');
Route::get('/vendor/{vendor}', [VendorController::class, 'show'])->name('vendor.show');
Route::get('/vendor/{vendor}/edit', [VendorController::class, 'edit'])->name('vendor.edit');
Route::put('/vendor/{vendor}', [VendorController::class, 'update'])->name('vendor.update');
Route::delete('/vendor/{vendor}', [VendorController::class, 'destroy'])->name('vendor.destroy');


//==================== Route Untuk Login Form ====================//

// Captcha Login for Random Captcha
use App\Http\Controllers\CaptchaController;

Route::get('/random-captcha', [CaptchaController::class, 'getRandomCaptcha']);

//==================== Master Data Order Management ====================//

use App\Http\Controllers\OrderController;

// Define named routes for OrderController
Route::get('/orders/create', [OrderController::class, 'create'])->name('orders.create');
Route::post('/orders', [OrderController::class, 'store'])->name('orders.store');
Route::get('/orders', [OrderController::class, 'index'])->name('orders.index');

// Define named routes for Generate Order Number
Route::get('/orders/generate-order-number', [OrderController::class, 'generateOrderNumber']);

// Define named routes for Assign 
Route::post('/orders/{order}/assign-driver', [OrderController::class, 'assignDriver']);
Route::post('/orders/{order}/assign-truck', [OrderController::class, 'assignTruck']);
Route::post('/orders/{order}/assign-vendor', [OrderController::class, 'assignVendor']);

// Rute untuk menampilkan halaman Update Status Trip
Route::get('/orders/{id}/update-status', function ($id) {
    return Inertia::render('MonitoringOrder/UpdateStatusTrip', [
        'orderId' => $id,
    ]);
})->name('orders.update-status');

// Rute untuk mengupdate status order
Route::post('/orders/{id}/update-status', [OrderController::class, 'updateStatus'])->name('orders.update-status.post');
Route::post('/orders/{id}/update-status', [OrderController::class, 'updateStatus'])->name('orders.update-status');
Route::get('/orders/{id}/data', [OrderController::class, 'getOrderData']);

Route::post('/orders/{id}/upload-documents', [OrderController::class, 'uploadDocuments']);
Route::get('/orders/{id}/documents', [OrderController::class, 'getDocuments']);


// Api untuk mengambil data order untuk Detail Trip dan Penerima Tugas dan Rute Perjalanan
Route::get('/api/orders/{id}', [OrderController::class, 'getOrderData']);

// Api untuk mengambil data order untuk Status Trip Load dan Unload Address
Route::get('/orders/{id}/data', [OrderController::class, 'getOrderData']);


// Define named routes for MonitoringOrder
use App\Http\Controllers\MonitoringOrderController;

Route::get('/monitoring-order/{id}', [MonitoringOrderController::class, 'show'])->name('monitoring.order.show');


//==================== Master Data Fleet Management ====================//

use App\Http\Controllers\DriverController;
use App\Http\Controllers\TruckController;

// Define named routes for DriverController
Route::get('/drivers', [DriverController::class, 'index'])->name('drivers.index');
Route::get('/drivers/create', [DriverController::class, 'create'])->name('drivers.create');
Route::post('/drivers', [DriverController::class, 'store'])->name('drivers.store');
Route::get('/drivers/{driver}', [DriverController::class, 'show'])->name('drivers.show');
Route::get('/drivers/{driver}/edit', [DriverController::class, 'edit'])->name('drivers.edit');
Route::put('/drivers/{driver}', [DriverController::class, 'update'])->name('drivers.update');
Route::delete('/drivers/{driver}', [DriverController::class, 'destroy'])->name('drivers.destroy');

// Define named routes for TruckController
Route::get('/trucks', [TruckController::class, 'index'])->name('trucks.index');
Route::get('/trucks/create', [TruckController::class, 'create'])->name('trucks.create');
Route::post('/trucks', [TruckController::class, 'store'])->name('trucks.store');
Route::get('/trucks/{truck}', [TruckController::class, 'show'])->name('trucks.show');
Route::get('/trucks/{truck}/edit', [TruckController::class, 'edit'])->name('trucks.edit');
Route::put('/trucks/{truck}', [TruckController::class, 'update'])->name('trucks.update');
Route::delete('/trucks/{truck}', [TruckController::class, 'destroy'])->name('trucks.destroy');

//=======================================================================//

use App\Http\Controllers\ClaimController;

// Route untuk halaman Claim Management
Route::get('/claim-management', [ClaimController::class, 'index'])->name('claim-management');

// Route untuk aksi CRUD klaim
Route::post('/claims', [ClaimController::class, 'store'])->name('claims.store');
Route::put('/claims/{claim}', [ClaimController::class, 'update'])->name('claims.update');
Route::delete('/claims/{claim}', [ClaimController::class, 'destroy'])->name('claims.destroy');

require __DIR__.'/auth.php';
