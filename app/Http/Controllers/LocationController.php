<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\DriverLocation;
use App\Events\LocationUpdated;

class LocationController extends Controller
{

    public function store(Request $request)
    {
        // Validasi input data
        $request->validate([
            'driver_id' => 'required|integer',
            'latitude' => 'required|numeric',
            'longitude' => 'required|numeric',
        ]);

        // Simpan data lokasi ke database
        $location = new DriverLocation();
        $location->driver_id = $request->input('driver_id');
        $location->latitude = $request->input('latitude');
        $location->longitude = $request->input('longitude');
        $location->save();

        // Broadcast event ke Pusher
        event(new LocationUpdated($location->driver_id, $location->latitude, $location->longitude));

        return response()->json(['status' => 'success'], 200);
    }

    public function getLatestLocation(Request $request)
    {
        $driver_id = $request->input('driver_id');

        $location = DriverLocation::where('driver_id', $driver_id)
            ->latest('created_at')
            ->first();

        if ($location) {
            return response()->json([
                'latitude' => $location->latitude,
                'longitude' => $location->longitude,
            ], 200);
        } else {
            return response()->json(['error' => 'Location not found'], 404);
        }
    }


}
