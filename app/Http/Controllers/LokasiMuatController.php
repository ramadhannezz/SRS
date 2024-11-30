<?php

namespace App\Http\Controllers;

use App\Models\LokasiMuat;
use App\Models\Kota;
use App\Models\KategoriLokasi;
use Illuminate\Http\Request;
use Inertia\Inertia;

class LokasiMuatController extends Controller
{
    public function index()
    {
        $lokasiMuat = LokasiMuat::with(['kota', 'kategoriLokasi'])->paginate(10);
        $kotas = Kota::all(['id', 'name']);
        $kategoriLokasi = KategoriLokasi::all(['id', 'name']);
        $googleMapsApiKey = env('GOOGLE_MAPS_API_KEY');

        return Inertia::render('LokasiMuat', [
            'lokasiMuat' => $lokasiMuat,
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
            'kategori_lokasi_id' => 'required|exists:kategori_lokasi,id', // Pastikan nama tabel benar
        ]);

        LokasiMuat::create($request->all());

        return redirect()->route('lokasiMuat.index');
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'address' => 'required|string|max:255',
            'kotas_id' => 'required|exists:kotas,id',
            'coordinate' => 'required|string|max:255',
            'kategori_lokasi_id' => 'required|exists:kategori_lokasi,id', // Pastikan nama tabel benar
        ]);

        $lokasiMuat = LokasiMuat::findOrFail($id);
        $lokasiMuat->update($request->all());

        return redirect()->route('lokasiMuat.index');
    }

    public function destroy($id)
    {
        $lokasiMuat = LokasiMuat::findOrFail($id);
        $lokasiMuat->delete();

        return redirect()->route('lokasiMuat.index');
    }
}
