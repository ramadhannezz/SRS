<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});



// Request dan Verify OTP Driver App
use App\Http\Controllers\OtpController;

Route::post('/send-otp', [OtpController::class, 'sendOtp']);
Route::post('/verify-otp', [OtpController::class, 'verifyOtp']);

// Get Data From Orders For TripsScreen

// use App\Http\Controllers\OrderController;

// // Routes for new and accepted orders
// Route::get('/orders/new', [OrderController::class, 'getNewOrders']); // Untuk kerjaan baru
// Route::get('/orders/accepted', [OrderController::class, 'getAcceptedOrders']); // Untuk kerjaan diambil

// // Get Data From Orders For TripDetailScreen
// Route::get('/orders/{orderId}/details', [OrderController::class, 'getNewOrderDetails']);
// Route::patch('/orders/{orderId}/status', [OrderController::class, 'updateStatusFromMobile']);

// use App\Http\Controllers\DocumentController;
// Route::post('/orders/{orderId}/documents', [DocumentController::class, 'uploadDocument']);

// Get Data From Orders For TripsScreen

use App\Http\Controllers\OrderController;

// Routes untuk new dan accepted orders
Route::get('/orders/new/{drivers_id}', [OrderController::class, 'getNewOrders']);
Route::get('/orders/accepted/{drivers_id}', [OrderController::class, 'getAcceptedOrders']);


// Get Data From Orders For TripDetailScreen
Route::get('/orders/{orderId}/details', [OrderController::class, 'getNewOrderDetails']);
Route::get('/orders/{orderId}/location/{locationId}/details', [OrderController::class, 'getOrderDetailsByLocation']); // Tambahan

// Update status order dari mobile
Route::patch('/orders/{orderId}/status', [OrderController::class, 'updateStatusFromMobile']);

use App\Http\Controllers\DocumentController;

// Upload dokumen berdasarkan orders_id
Route::post('/orders/{orderId}/documents', [DocumentController::class, 'uploadDocument']);
Route::get('/orders/{orderId}/location/{unloadAddressId}/documents', [DocumentController::class, 'getDocumentsByLocation']); // Tambahan

use App\Http\Controllers\OrderStatusLogController;

// Log status berdasarkan location_id
Route::get('/order-status-logs', [OrderStatusLogController::class, 'index']); // Untuk website
Route::get('/order-status-logs/last-status', [OrderStatusLogController::class, 'getLastStatusByLocation']); // Tambahan
Route::post('/order-status-logs', [OrderStatusLogController::class, 'storeFromMobile']); // Tambahan untuk mobile

// Request dan Verify dan Tampilkan di Profile Berdasarkan Data Login
use App\Http\Controllers\DriverController;

Route::post('/driver/profile', [DriverController::class, 'getDriverProfile']);

Route::post('/check-login-status', [DriverController::class, 'checkLoginStatus']);

// Untuk menerima lokasi yang dikirim dari frontend react-native
use App\Http\Controllers\LocationController;

Route::post('/driver/location', [LocationController::class, 'store']);

// Tambahkan autoRefresh untuk Memperbarui Lokasi Driver
Route::get('/driver/latest-location', [LocationController::class, 'getLatestLocation']);

// Untuk menampilkan lokasi dari database