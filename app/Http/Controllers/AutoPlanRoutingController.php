<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class AutoPlanRoutingController extends Controller
{
    public function autoPlan(Request $request)
    {
        $validated = $request->validate([
            'load_address' => 'required|array',
            'unload_addresses' => 'required|array|min:1',
        ]);

        $loadAddress = $validated['load_address'];
        $unloadAddresses = $validated['unload_addresses'];

        // Mendapatkan koordinat dari alamat
        $loadCoordinates = $this->getCoordinates($loadAddress['address']);
        if (!$loadCoordinates) {
            return response()->json(['errors' => ['load_address' => 'Invalid load address']], 422);
        }

        $unloadCoordinates = [];
        foreach ($unloadAddresses as $address) {
            $coordinates = $this->getCoordinates($address['address']);
            if ($coordinates) {
                $unloadCoordinates[] = ['address' => $address, 'coordinates' => $coordinates];
            } else {
                return response()->json(['errors' => ['unload_addresses' => 'Invalid unload address']], 422);
            }
        }

        // Mengurutkan alamat berdasarkan jarak dari load address
        usort($unloadCoordinates, function ($a, $b) use ($loadCoordinates) {
            $distanceA = $this->calculateDistance($loadCoordinates, $a['coordinates']);
            $distanceB = $this->calculateDistance($loadCoordinates, $b['coordinates']);
            return $distanceA <=> $distanceB;
        });

        return response()->json([
            'sorted_unload_addresses' => array_map(fn($item) => $item['address'], $unloadCoordinates),
            'status' => 'OK'
        ]);
    }

    private function getCoordinates($address)
    {
        $apiKey = env('GOOGLE_MAPS_API_KEY');
        $response = Http::get("https://maps.googleapis.com/maps/api/geocode/json", [
            'address' => $address,
            'key' => $apiKey
        ]);

        $data = $response->json();

        if (isset($data['results'][0]['geometry']['location'])) {
            return $data['results'][0]['geometry']['location'];
        }

        return null;
    }

    private function calculateDistance($coord1, $coord2)
    {
        $theta = $coord1['lng'] - $coord2['lng'];
        $dist = sin(deg2rad($coord1['lat'])) * sin(deg2rad($coord2['lat'])) + cos(deg2rad($coord1['lat'])) * cos(deg2rad($coord2['lat'])) * cos(deg2rad($theta));
        $dist = acos($dist);
        $dist = rad2deg($dist);
        $miles = $dist * 60 * 1.1515;
        return $miles * 1.609344; // Konversi ke kilometer
    }
}
