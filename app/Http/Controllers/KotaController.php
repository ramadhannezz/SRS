<?php

namespace App\Http\Controllers;

use App\Models\Kota;
use Illuminate\Http\Request;
use Inertia\Inertia;

class KotaController extends Controller
{
    public function index()
    {
        $kotas = Kota::all();
        return Inertia::render('Kota/KotaPage', ['kotas' => $kotas]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'region' => 'required|string|max:255',
        ]);

        Kota::create($request->all());

        return redirect()->route('kota');
    }

    public function update(Request $request, Kota $kota)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'region' => 'required|string|max:255',
        ]);

        $kota->update($request->all());

        return redirect()->route('kota');
    }

    public function destroy(Kota $kota)
    {
        $kota->delete();

        return redirect()->route('kota');
    }
}
