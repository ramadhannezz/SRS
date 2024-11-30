<?php

namespace App\Http\Controllers;

use App\Models\LokasiBongkar;
use App\Models\Kota;
use App\Models\KategoriLokasi;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Imports\LokasiBongkarImport;
use Maatwebsite\Excel\Facades\Excel;

class LokasiBongkarController extends Controller
{
    public function index()
    {
        $lokasiBongkar = LokasiBongkar::with(['kota', 'kategoriLokasi'])->paginate(10);
        $kotas = Kota::all(['id', 'name']);
        $kategoriLokasi = KategoriLokasi::all(['id', 'name']);
        $googleMapsApiKey = env('GOOGLE_MAPS_API_KEY');

        return Inertia::render('LokasiBongkar', [
            'lokasiBongkar' => $lokasiBongkar,
            'kotas' => $kotas,
            'kategoriLokasi' => $kategoriLokasi,
            'googleMapsApiKey' => $googleMapsApiKey,
        ]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'address' => 'required|string|max:255',
            'kotas_id' => 'required|exists:kotas,id',
            'coordinate' => 'required|string|max:255',
            'kategori_lokasi_id' => 'required|exists:kategori_lokasi,id',
        ]);

        LokasiBongkar::create($request->all());

        return redirect()->route('lokasiBongkar.index');
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'address' => 'required|string|max:255',
            'kotas_id' => 'required|exists:kotas,id',
            'coordinate' => 'required|string|max:255',
            'kategori_lokasi_id' => 'required|exists:kategori_lokasi,id',
        ]);

        $lokasiBongkar = LokasiBongkar::findOrFail($id);
        $lokasiBongkar->update($request->all());

        return redirect()->route('lokasiBongkar.index');
    }

    public function destroy($id)
    {
        $lokasiBongkar = LokasiBongkar::findOrFail($id);
        $lokasiBongkar->delete();

        return redirect()->route('lokasiBongkar.index');
    }

    public function import(Request $request)
    {
        $request->validate([
            'file' => 'required|mimes:xlsx'
        ]);
    
        Excel::import(new LokasiBongkarImport, $request->file('file'));
    
        return redirect()->route('lokasiBongkar.index')->with('success', 'Data imported successfully.');
    }
    
}