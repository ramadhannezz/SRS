<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;
use Inertia\Inertia;
use App\Models\LokasiMuat;
use App\Models\LokasiBongkar;
use App\Models\Route;
use App\Models\Kota;
use App\Models\KategoriLokasi;
use Illuminate\Support\Facades\Log;

class SmartRoutingController extends Controller
{
    public function index()
    {
        $lokasiMuat = LokasiMuat::all();
        $lokasiBongkar = LokasiBongkar::all();
        $kotas = Kota::all(); // Ambil data kota
        $kategoriLokasi = KategoriLokasi::all(); // Ambil data kategori lokasi

        return Inertia::render('SmartRouting/SmartRouting', [
            'lokasiMuat' => $lokasiMuat,
            'lokasiBongkar' => $lokasiBongkar,    
            'kotas' => $kotas, // Kirim data kota ke frontend
            'kategoriLokasi' => $kategoriLokasi // Kirim data kategori lokasi ke frontend        
        ]);
    }

    public function generate(Request $request)
    {
        Log::info('Request Data:', $request->all());

        try {
            // Validasi input
            $validated = $request->validate([
                'load_address' => 'required|array',
                'load_address.address' => 'required|string', // Validasi bahwa load_address memiliki field 'address'
                'unload_addresses' => 'required|array|min:1', // Minimal dua alamat bongkar
                'unload_addresses.*.address' => 'required|string' // Validasi bahwa setiap unload_address memiliki field 'address'
            ]);

            Log::info('Validated Data:', $validated);

            $loadAddress = $validated['load_address']['address'];
            $unloadAddresses = array_map(function ($address) {
                return $address['address'];
            }, $validated['unload_addresses']);

            $loadCoordinates = $this->getCoordinates($loadAddress);
            if (!$loadCoordinates) {
                Log::error('Invalid load address: ' . $loadAddress);
                return response()->json(['errors' => ['load_address' => 'Invalid load address']], 422);
            }

            $unloadCoordinates = [];
            foreach ($unloadAddresses as $address) {
                $coordinates = $this->getCoordinates($address);
                
                if ($coordinates) {
                    $unloadCoordinates[] = $coordinates;
                } else {
                    Log::error('Invalid unload address: ' . $address);
                    return response()->json(['errors' => ['unload_addresses' => 'Invalid unload address: ' . $address]], 422);
                }
            }

            // Log the coordinates before calculating the route
            Log::info('Load Coordinates:', $loadCoordinates);
            Log::info('Unload Coordinates:', $unloadCoordinates);

            $routes = $this->calculateDijkstra($loadCoordinates, $unloadCoordinates);

            // Log the calculated routes
            Log::info('Calculated Routes:', $routes);

            Route::create([
                'load_address' => $loadAddress,
                'unload_addresses' => json_encode($unloadAddresses),
                'route' => json_encode($routes),
            ]);

            Log::info('Route Calculation Success:', $routes);

            return response()->json([
                'routes' => array_values($routes),
                'status' => 'OK'
            ]);
        } catch (\Exception $e) {
            Log::error('Error during route generation:', ['exception' => $e->getMessage()]);
            return response()->json(['error' => 'An error occurred during route generation'], 500);
        }
    }

    private function getCoordinates($address)
    {
        $apiKey = env('GOOGLE_MAPS_API_KEY');
        $response = Http::get("https://maps.googleapis.com/maps/api/geocode/json", [
            'address' => $address,
            'key' => $apiKey
        ]);

        Log::info('Geocoding Request for address: ' . $address);
        Log::info('Geocoding Response:', $response->json());

        $data = $response->json();

        if (isset($data['results'][0]['geometry']['location'])) {
            Log::info('Coordinates for address: ' . $address, ['coordinates' => $data['results'][0]['geometry']['location']]);
            return $data['results'][0]['geometry']['location'];
        }

        Log::error('Geocoding failed for address: ' . $address);
        Log::error('Geocoding API Response:', $data);

        return null;
    }

    private function calculateDijkstra($loadCoordinates, $unloadCoordinates)
    {
        $graph = [];
        $coordinates = array_merge([$loadCoordinates], $unloadCoordinates);
    
        Log::info('Coordinates for Dijkstra:', $coordinates); // Log semua koordinat sebelum diproses
    
        for ($i = 0; $i < count($coordinates); $i++) {
            $graph[$i] = [];
            for ($j = 0; $j < count($coordinates); $j++) {
                if ($i !== $j) {
                    $distance = $this->calculateDistance($coordinates[$i], $coordinates[$j]);
                    $graph[$i][$j] = $distance;
                }
            }
        }
    
        $start = 0;
        $dist = [];
        $prev = [];
        $queue = [];
    
        foreach ($graph as $vertex => $edges) {
            $dist[$vertex] = INF;
            $prev[$vertex] = null;
            $queue[$vertex] = $dist[$vertex];
        }
    
        $dist[$start] = 0;
        $queue[$start] = 0;
    
        while (!empty($queue)) {
            $min = array_search(min($queue), $queue);
            unset($queue[$min]);
    
            foreach ($graph[$min] as $neighbor => $value) {
                $alt = $dist[$min] + $graph[$min][$neighbor];
                if ($alt < $dist[$neighbor]) {
                    $dist[$neighbor] = $alt;
                    $prev[$neighbor] = $min;
                    $queue[$neighbor] = $alt;
                }
            }
        }
    
        // Membuat path dari start ke setiap titik
        $path = [];
        for ($i = 0; $i < count($coordinates); $i++) {
            $current = $i;
            $tempPath = [];
            while ($prev[$current] !== null) {
                array_unshift($tempPath, $coordinates[$current]);
                $current = $prev[$current];
            }
            if (!empty($tempPath)) {
                array_unshift($tempPath, $coordinates[$start]);
                $path = array_merge($path, $tempPath);
            }
        }
    
        // Menghapus duplikat
        $path = array_unique($path, SORT_REGULAR);
    
        Log::info('Calculated Path:', $path);
    
        return $path;
    }
    

    private function calculateDistance($coord1, $coord2)
    {
        $earthRadius = 6371; // Radius Bumi dalam kilometer
    
        $lat1 = deg2rad($coord1['lat']);
        $lng1 = deg2rad($coord1['lng']);
        $lat2 = deg2rad($coord2['lat']);
        $lng2 = deg2rad($coord2['lng']);
    
        $dLat = $lat2 - $lat1;
        $dLng = $lng2 - $lng1;
    
        $a = sin($dLat / 2) * sin($dLat / 2) +
            cos($lat1) * cos($lat2) *
            sin($dLng / 2) * sin($dLng / 2);
        $c = 2 * atan2(sqrt($a), sqrt(1 - $a));
    
        $distance = $earthRadius * $c;
    
        Log::info("Calculated Distance between ({$coord1['lat']}, {$coord1['lng']}) and ({$coord2['lat']}, {$coord2['lng']}): $distance km");
    
        return $distance;
    }
    
}

