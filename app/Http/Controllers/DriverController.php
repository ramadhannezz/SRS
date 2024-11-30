<?php

namespace App\Http\Controllers;

use App\Models\OtpCode;
use App\Models\Driver;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Illuminate\Support\Facades\Validator;


class DriverController extends Controller
{
    public function index()
    {
        $drivers = Driver::all();
        return Inertia::render('FleetManagement/DriverPage', ['drivers' => $drivers]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'phone' => 'required|string|max:255|unique:drivers,phone',
            'ktp' => 'required|string|max:255|unique:drivers,ktp',
            'sim' => 'required|string|max:255|unique:drivers,sim',
        ]);

        Driver::create($request->all());

        return redirect()->route('drivers.index')->with('success', 'Driver created successfully.');
    }

    public function update(Request $request, Driver $driver)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'phone' => 'required|string|max:255|unique:drivers,phone,' . $driver->id,
            'ktp' => 'required|string|max:255|unique:drivers,ktp,' . $driver->id,
            'sim' => 'required|string|max:255|unique:drivers,sim,' . $driver->id,
        ]);

        $driver->update($request->all());

        return redirect()->route('drivers.index')->with('success', 'Driver updated successfully.');
    }

    public function destroy(Driver $driver)
    {
        $driver->delete();

        return redirect()->route('drivers.index')->with('success', 'Driver deleted successfully.');
    }

    public function checkLoginStatus(Request $request)
    {
        // Validasi input untuk memastikan drivers_id dikirim
        $validator = Validator::make($request->all(), [
            'drivers_id' => 'required|exists:drivers,id',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Data tidak valid',
                'errors' => $validator->errors(),
            ], 400);
        }

        // Ambil status login dari tabel otp_codes berdasarkan drivers_id
        $otpCode = OtpCode::where('drivers_id', $request->drivers_id)
                          ->where('is_logged_in', true) // Pastikan pengguna masih login
                          ->first();

        if ($otpCode) {
            // Ambil data driver dari tabel drivers
            $driver = Driver::find($request->drivers_id);

            // Jika driver ditemukan, kembalikan data driver
            if ($driver) {
                return response()->json([
                    'message' => 'User masih login',
                    'driver' => [
                        'id' => $driver->id,
                        'name' => $driver->name,
                        'phone' => $driver->phone,
                        'email' => $driver->email,
                    ]
                ], 200);
            } else {
                // Jika driver tidak ditemukan
                return response()->json([
                    'message' => 'Driver tidak ditemukan',
                ], 404);
            }
        } else {
            // Jika pengguna sudah logout atau tidak login
            return response()->json([
                'message' => 'User tidak login',
            ], 401);
        }
    }
}
