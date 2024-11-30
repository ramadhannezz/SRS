<?php

namespace App\Http\Controllers;

use App\Models\Vendor;
use Illuminate\Http\Request;
use Inertia\Inertia;

class VendorController extends Controller
{
    public function index()
    {
        $vendors = Vendor::all();
        return Inertia::render('MasterData/VendorPage', [
            'vendors' => $vendors,
        ]);
    }

    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:vendors',
            'phone' => 'required|string|max:15|unique:vendors',
        ]);

        Vendor::create($validatedData);

        return redirect()->route('vendor.index')->with('success', 'Vendor created successfully.');
    }

    public function update(Request $request, Vendor $vendor)
    {
        $validatedData = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:vendors,email,' . $vendor->id,
            'phone' => 'required|string|max:15|unique:vendors,phone,' . $vendor->id,
        ]);

        $vendor->update($validatedData);

        return redirect()->route('vendor.index')->with('success', 'Vendor updated successfully.');
    }

    public function destroy(Vendor $vendor)
    {
        $vendor->delete();

        return redirect()->route('vendor.index')->with('success', 'Vendor deleted successfully.');
    }
}
