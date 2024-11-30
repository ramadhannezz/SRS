<?php

namespace App\Http\Controllers;

use App\Models\OrderStatusLog;
use Illuminate\Http\Request;

class OrderStatusLogController extends Controller
{

// ===== WEB APP BACKEND ===== //

    // Mengambil semua log status untuk order tertentu berdasarkan orders_id dan location_id
    public function index(Request $request)
    {
        $orderId = $request->input('orders_id');
        $locationId = $request->input('location_id');

        $logs = OrderStatusLog::where('orders_id', $orderId)
            ->when($locationId, function ($query) use ($locationId) {
                return $query->where('location_id', $locationId);
            })
            ->orderBy('created_at', 'desc')
            ->get();

        return response()->json($logs);
    }

    // Menyimpan log status baru
    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'orders_id' => 'required|exists:orders,id',
            'status' => 'required|in:Dijadwalkan Berangkat,Menuju Lokasi Muat,Sampai Lokasi Muat,Mulai Muat,Selesai Muat,Menuju Lokasi Bongkar,Sampai Lokasi Bongkar,Mulai Bongkar,Selesai Bongkar',
            'location_id' => 'required|integer',
        ]);

        $log = OrderStatusLog::create([
            'orders_id' => $validatedData['orders_id'],
            'status' => $validatedData['status'],
            'timestamp' => now(), // Atur timestamp sesuai waktu saat ini
            'location_id' => $validatedData['location_id'],
        ]);

        return response()->json($log, 201);
    }

    // Menghapus log status berdasarkan ID
    public function destroy($id)
    {
        $log = OrderStatusLog::findOrFail($id);
        $log->delete();

        return response()->json(null, 204);
    }

// ===== END WEB APP BACKEND ===== //

// ===== MOBILE APP ANDROID x IOS BACKEND ===== //

    // Function untuk mendapatkan status terakhir berdasarkan orders_id dan location_id (Tambahan)
    public function getLastStatusByLocation(Request $request)
    {
        $orderId = $request->input('orders_id');
        $locationId = $request->input('location_id');

        $lastLog = OrderStatusLog::where('orders_id', $orderId)
            ->where('location_id', $locationId)
            ->orderBy('created_at', 'desc')
            ->first();

        if ($lastLog) {
            return response()->json($lastLog);
        } else {
            return response()->json(['message' => 'Log not found'], 404);
        }
    }

    // Function untuk menyimpan log status baru dari platform mobile (Tambahan)
    public function storeFromMobile(Request $request)
    {
        $validatedData = $request->validate([
            'orders_id' => 'required|exists:orders,id',
            'status' => 'required|in:Dijadwalkan Berangkat,Menuju Lokasi Muat,Sampai Lokasi Muat,Mulai Muat,Selesai Muat,Menuju Lokasi Bongkar,Sampai Lokasi Bongkar,Mulai Bongkar,Selesai Bongkar',
            'location_id' => 'required|integer',
        ]);

        $log = OrderStatusLog::create([
            'orders_id' => $validatedData['orders_id'],
            'status' => $validatedData['status'],
            'timestamp' => now(),
            'location_id' => $validatedData['location_id'],
        ]);

        return response()->json($log, 201);
    }

// ===== END MOBILE APP ANDROID x IOS BACKEND ===== //
}
