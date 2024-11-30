<?php

namespace App\Http\Controllers;

use App\Models\Order;
use App\Models\DriverLocation;
use Inertia\Inertia;

class MonitoringOrderController extends Controller
{
    public function show($id)
    {
        // Ambil data order berdasarkan ID
        $order = Order::with(['customer', 'driver', 'truck', 'typetruck', 'vendor', 'orderStatusLogs'])->findOrFail($id);

        // Ambil lokasi terbaru driver berdasarkan driver_id
        $driverLocation = null;
        if ($order->driver) {
            $driverLocation = DriverLocation::where('driver_id', $order->driver->id)
                ->latest('created_at') // Mengambil lokasi terbaru berdasarkan waktu
                ->first();
        }

        // Kirim data ke frontend
        return Inertia::render('MonitoringOrder/MonitoringOrder', [
            'order' => [
                'id' => $order->id,
                'nomor_order' => $order->nomor_order,
                'customer_name' => $order->customer->name,
                'driver_name' => $order->driver ? $order->driver->name : '',
                'truck_licensePlate' => $order->truck ? $order->truck->licensePlate : '',
                'nama_muatan' => $order->nama_muatan,
                'berat_muatan' => $order->berat_muatan,
                'load_address' => $order->load_address,
                'unload_addresses' => $order->unload_addresses,
                'typetruck_name' => $order->typetruck ? $order->typetruck->name : '',
                'vendor_name' => $order->vendor ? $order->vendor->name : '',
                'routes' => $order->routes,
                'current_status' => $order->current_status,
                'orderStatusLogs' => $order->orderStatusLogs->toArray(),
                'driverLocation' => $driverLocation ? [
                    'latitude' => (float) $driverLocation->latitude, // Pastikan tipe float
                    'longitude' => (float) $driverLocation->longitude, // Pastikan tipe float
                ] : null, // Lokasi terbaru driver
            ]
        ]);
    }
}
