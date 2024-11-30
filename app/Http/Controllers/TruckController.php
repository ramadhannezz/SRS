<?php

namespace App\Http\Controllers;

use App\Models\Truck;
use Illuminate\Http\Request;
use Inertia\Inertia;

class TruckController extends Controller
{
    public function index()
    {
        $trucks = Truck::all();
        return Inertia::render('FleetManagement/TruckPage', ['trucks' => $trucks]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'licensePlate' => 'required|string|max:255|unique:trucks,licensePlate',
            'truckType' => 'required|string|max:255',  // Validasi untuk Truck Type
            'typeYear' => 'required|string|max:255',
            'status' => 'required|string|max:255',
            'stnk' => 'required|string|max:255',
            'kir' => 'required|string|max:255',
            'gps' => 'required|string|max:255',
        ]);
    
        Truck::create($request->all());
    
        return redirect()->route('trucks.index')->with('success', 'Truck created successfully.');
    }
    
    public function update(Request $request, Truck $truck)
    {
        $request->validate([
            'licensePlate' => 'required|string|max:255|unique:trucks,licensePlate,' . $truck->id,
            'truckType' => 'required|string|max:255',  // Validasi untuk Truck Type
            'typeYear' => 'required|string|max:255',
            'status' => 'required|string|max:255',
            'stnk' => 'required|string|max:255',
            'kir' => 'required|string|max:255',
            'gps' => 'required|string|max:255',
        ]);
    
        $truck->update($request->all());
    
        return redirect()->route('trucks.index')->with('success', 'Truck updated successfully.');
    }
    

    public function destroy(Truck $truck)
    {
        $truck->delete();

        return redirect()->route('trucks.index')->with('success', 'Truck deleted successfully.');
    }
}
