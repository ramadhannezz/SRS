<?php

// app/Http/Controllers/KategoriLokasiController.php

namespace App\Http\Controllers;

use App\Models\KategoriLokasi;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Illuminate\Support\Facades\Log;

class KategoriLokasiController extends Controller
{
    public function index()
    {
        $kategoriLokasi = KategoriLokasi::all()->map(function ($item) {
            // Log the icon path for debugging
            Log::info('Icon path: ' . $item->icon);
            return $item;
        });
        return Inertia::render('KategoriLokasi/KategoriLokasiPage', ['kategoriLokasi' => $kategoriLokasi]);
    }
    

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required',
            'icon' => 'required|image',
        ]);

        $iconPath = $request->file('icon')->store('icons', 'public');

        KategoriLokasi::create([
            'name' => $request->name,
            'icon' => $iconPath,
        ]);

        return redirect()->back();
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'name' => 'required',
            'icon' => 'nullable|image',
        ]);
    
        $kategoriLokasi = KategoriLokasi::findOrFail($id);
    
        if ($request->hasFile('icon')) {
            $iconPath = $request->file('icon')->store('icons', 'public');
            $kategoriLokasi->icon = $iconPath;
        }
    
        $kategoriLokasi->name = $request->name;
        $kategoriLokasi->save();
    
        return redirect()->back();
    }
    

    public function destroy($id)
    {
        $kategoriLokasi = KategoriLokasi::findOrFail($id);
        $kategoriLokasi->delete();
        return redirect()->back();
    }
}
