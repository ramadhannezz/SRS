<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\OtpCode;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use App\Models\Driver;
use Illuminate\Support\Facades\Log;

class OtpController extends Controller
{

    public function sendOtp(Request $request)
    {
        Log::info('Request data:', $request->all());
        Log::info('Incoming Request:', $request->all()); // Log data request
        
        // Validasi input
        $validator = Validator::make($request->all(), [
            'phone_number' => 'required|digits_between:10,15',
        ]);

        Log::info('Phone number passed validation:', ['phone_number' => $request->phone_number]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Nomor telepon tidak valid',
                'errors' => $validator->errors(),
            ], 400);
        }

        // Cari driver berdasarkan nomor telepon
        $driver = Driver::where('phone', $request->phone_number)->first();

        if (!$driver) {
            // Jika nomor tidak ditemukan di tabel drivers
            return response()->json([
                'message' => 'Nomor telepon belum terdaftar',
            ], 404);
        }

        // Jika nomor terdaftar, generate OTP (4 digit)
        $otpCode = rand(1000, 9999); // Menghasilkan 4 digit angka acak

        // Simpan ke tabel otp_codes
        OtpCode::create([
            'phone_number' => $request->phone_number,
            'otp_code'     => $otpCode,
            'drivers_id'   => $driver->id, // Simpan drivers_id
        ]);

        // Kirim SMS OTP (di sini simulasi pengiriman SMS)

        // Beri response sukses
        return response()->json([
            'message' => 'OTP terkirim',
            'otp'     => $otpCode, // Hanya untuk testing
        ], 200);
    }

    public function verifyOtp(Request $request)
    {
        // Validasi input
        $validator = Validator::make($request->all(), [
            'phone_number' => '
            ',
            'otp_code'     => 'required|digits:4',
        ]);
    
        if ($validator->fails()) {
            return response()->json([
                'message' => 'Data tidak valid',
                'errors' => $validator->errors(),
            ], 400);
        }
    
        // Cek apakah OTP sesuai dengan yang disimpan di database
        $otp = OtpCode::where('phone_number', $request->phone_number)
                      ->where('otp_code', $request->otp_code)
                      ->first();
    
        if ($otp) {
            // Ambil data driver dari tabel drivers berdasarkan drivers_id
            $driver = Driver::find($otp->drivers_id);
    
            if ($driver) {
                // Set is_logged_in menjadi true dan log hasilnya
                if ($otp->update(['is_logged_in' => true])) {
                    // Jika update berhasil
                    Log::info('is_logged_in berhasil diupdate untuk drivers_id: ' . $otp->drivers_id);
                } else {
                    // Jika update gagal
                    Log::error('Gagal mengupdate is_logged_in untuk drivers_id: ' . $otp->drivers_id);
                }
                
                // Kembalikan data driver lengkap
                return response()->json([
                    'message' => 'OTP valid',
                    'driver' => [
                        'id' => $driver->id,
                        'name' => $driver->name,
                        'phone' => $driver->phone,
                        'email' => $driver->email,
                        'ktp' => $driver->ktp,
                        'sim' => $driver->sim,
                    ]
                ], 200);
            } else {
                return response()->json([
                    'message' => 'Driver tidak ditemukan',
                ], 404);
            }
        } else {
            return response()->json([
                'message' => 'OTP tidak valid',
            ], 400);
        }
    }

    public function getDriverProfile(Request $request)
    {
        // Validasi input, misalnya menggunakan phone_number atau driver_id
        $validator = Validator::make($request->all(), [
            'driver_id' => 'required|integer|exists:drivers,id',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Data tidak valid',
                'errors' => $validator->errors(),
            ], 400);
        }

        // Ambil data driver dari tabel drivers berdasarkan driver_id
        $driver = Driver::find($request->driver_id);

        if ($driver) {
            return response()->json([
                'message' => 'Data driver ditemukan',
                'driver' => [
                    'id' => $driver->id,
                    'name' => $driver->name,
                    'phone' => $driver->phone,
                ]
            ], 200);
        } else {
            return response()->json([
                'message' => 'Driver tidak ditemukan',
            ], 404);
        }
    }

    public function logout(Request $request)
    {
        $otpCode = OtpCode::where('drivers_id', $request->drivers_id)->first();
    
        if ($otpCode) {
            // Ubah status is_logged_in menjadi false saat logout
            $otpCode->update([
                'is_logged_in' => false,
            ]);
    
            return response()->json([
                'message' => 'Logout berhasil',
            ], 200);
        } else {
            return response()->json([
                'message' => 'User tidak ditemukan',
            ], 404);
        }
    }
    

}

