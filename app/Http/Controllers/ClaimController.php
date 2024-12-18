<?php

namespace App\Http\Controllers;

use App\Models\Claim;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Order;
use Illuminate\Support\Facades\Log;

class ClaimController extends Controller
{

    public function index()
    {
        // Ambil data klaim dengan relasi ke orders
        $claims = Claim::with('order') // Mengambil relasi order
        ->get()
        ->map(function ($claim) {
            return [
                'id_claim' => $claim->id_claim,
                'orders_id' => $claim->order ? $claim->order->nomor_order : 'Tidak Ada Nama',
                'nama_muatan' => $claim->order ? $claim->order->nama_muatan : 'Tidak Ada Nama', // Ambil nama_muatan dari relasi order
                'jumlah_barang' => $claim->jumlah_barang,
                'status_muatan' => $claim->status_muatan,
                'nama_muatan_claim' => $claim->nama_muatan_claim,
                'jumlah_muatan_claim' => $claim->jumlah_muatan_claim,
                'catatan_muatan' => $claim->catatan_muatan,
                'created_at' => $claim->created_at->format('d M Y'),
            ];
        });

            // Ambil daftar orders untuk dropdown
            $orders = Order::select('id', 'nomor_order', 'nama_muatan', 'jumlah_barang')->get();

        // Kirim data ke frontend
        return Inertia::render('ClaimManagement/ClaimManagement', [
            'claims' => $claims,
            'orders' => $orders,
        ])->withViewData(['debug' => 'Check path!']);
        
    }

    // public function store(Request $request)
    // {
    //     Log::info('Input request:', $request->all()); // Log inputan ke storage/logs/laravel.log
    
    //     try {
    //         $validatedData = $request->validate([
    //             'orders_id' => 'required|exists:orders,id',
    //             'nama_muatan' => 'required|exists:orders,id',
    //             'jumlah_barang' => 'required|exists:orders,id', // jumlah_barang sebagai ID
    //             'status_muatan' => 'required|in:Rusak,Hilang,Kurang,Lebih',
    //             'nama_muatan_claim' => 'required|string|max:255',
    //             'jumlah_muatan_claim' => 'required|integer',
    //             'catatan_muatan' => 'nullable|string',
    //             'created_at' => 'required|date',
    //         ]);
        
    //         // Simpan data ke database
    //         Claim::create([
    //             'orders_id' => $validatedData['orders_id'],
    //             'nama_muatan' => $validatedData['nama_muatan'], // ID yang valid
    //             'jumlah_barang' => $validatedData['jumlah_barang'], // ID yang valid
    //             'status_muatan' => $validatedData['status_muatan'],
    //             'nama_muatan_claim' => $validatedData['nama_muatan_claim'],
    //             'jumlah_muatan_claim' => $validatedData['jumlah_muatan_claim'],
    //             'catatan_muatan' => $validatedData['catatan_muatan'],
    //             'created_at' => $validatedData['created_at'],
    //         ]);
        
    //         return redirect()
    //         ->route('claim-management')
    //         ->with('success', 'Data berhasil disimpan');
    //         Log::info('Redirect executed successfully');

        
            
    //     } catch (\Exception $e) {
    //         Log::error('Error saat menyimpan data: ' . $e->getMessage());
    //         return back()->withErrors(['error' => 'Terjadi kesalahan saat menyimpan data'])->withInput();
    //     }
    // }

    public function store(Request $request)
    {
        Log::info('Input request:', $request->all());
    
        try {
            // Atur validasi dasar untuk field wajib
            $rules = [
                'orders_id' => 'required|exists:orders,id',
                'nama_muatan' => 'required|exists:orders,id',
                'jumlah_barang' => 'required|numeric',
            ];
    
            // Tambahkan validasi berat dan volume jika request dari API
            if ($request->expectsJson()) {
                $rules['berat_muatan'] = 'required|numeric';
                $rules['volume_muatan'] = 'required|numeric';
            } else {
                $rules['berat_muatan'] = 'nullable|numeric';
                $rules['volume_muatan'] = 'nullable|numeric';
            }
    
            // Validasi khusus hanya jika kolom klaim dikirim
            if ($request->filled('status_muatan') || $request->filled('nama_muatan_claim') || $request->filled('jumlah_muatan_claim')) {
                $rules['status_muatan'] = 'required|in:Rusak,Hilang,Kurang,Lebih';
                $rules['nama_muatan_claim'] = 'required|string|max:255';
                $rules['jumlah_muatan_claim'] = 'required|integer';
                $rules['catatan_muatan'] = 'nullable|string';
            }
    
            // Lakukan validasi berdasarkan rules
            $validatedData = $request->validate($rules);
    
            // Log untuk validasi data
            Log::info('Validated data:', $validatedData);
    
            // Periksa apakah data klaim diisi (jika ada field klaim)
            if ($request->filled('status_muatan') || $request->filled('nama_muatan_claim') || $request->filled('jumlah_muatan_claim')) {
                // Tambahkan created_at otomatis jika request dari API
                if ($request->expectsJson()) {
                    $validatedData['created_at'] = now();
                }
    
                // Simpan data ke database hanya jika klaim diisi
                $claim = Claim::create($validatedData);
                Log::info('Data claim berhasil disimpan', ['claim_id' => $claim->id]);
    
                // Respons sukses untuk API
                if ($request->expectsJson()) {
                    return response()->json([
                        'success' => true,
                        'message' => 'Data klaim berhasil disimpan!',
                        'data' => $claim
                    ], 200);
                }
            } else {
                Log::info('No claim data provided. Claim not created.');
    
                if ($request->expectsJson()) {
                    return response()->json([
                        'success' => true,
                        'message' => 'Data berhasil disimpan tanpa klaim.',
                    ], 200);
                }
            }
    
            // Redirect untuk aplikasi web
            return redirect()
                ->route('claim-management')
                ->with('success', 'Data berhasil disimpan.');
    
        } catch (\Exception $e) {
            Log::error('Error saat menyimpan data: ' . $e->getMessage());
    
            if ($request->expectsJson()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Terjadi kesalahan saat menyimpan data',
                    'error' => $e->getMessage()
                ], 500);
            }
    
            return back()->withErrors(['error' => 'Terjadi kesalahan saat menyimpan data'])->withInput();
        }
    }
    
    
    


    public function update(Request $request, Claim $claim)
    {
        Log::info('Input request (update):', $request->all()); // Debug input request
    
        try {
            // Validasi input
            $validatedData = $request->validate([
                'orders_id' => 'required|exists:orders,id',
                'nama_muatan' => 'required|exists:orders,id',
                'jumlah_barang' => 'required|exists:orders,id',
                'status_muatan' => 'required|in:Rusak,Hilang,Kurang,Lebih',
                'nama_muatan_claim' => 'required|string|max:255',
                'jumlah_muatan_claim' => 'required|integer',
                'catatan_muatan' => 'nullable|string',
                'created_at' => 'required|date',
            ]);
    
            // Update data klaim
            $claim->update([
                'orders_id' => $validatedData['orders_id'], // Harus ID dari orders
                'nama_muatan' => $validatedData['nama_muatan'],
                'jumlah_barang' => $validatedData['jumlah_barang'],
                'status_muatan' => $validatedData['status_muatan'],
                'nama_muatan_claim' => $validatedData['nama_muatan_claim'],
                'jumlah_muatan_claim' => $validatedData['jumlah_muatan_claim'],
                'catatan_muatan' => $validatedData['catatan_muatan'],
                'created_at' => $validatedData['created_at'],
            ]);
    
            Log::info('Data berhasil diperbarui:', $validatedData);
    
            // Redirect dengan pesan sukses
            return redirect()->route('claim-management')->with('success', 'Data berhasil diperbarui!');
        } catch (\Exception $e) {
            Log::error('Error saat memperbarui data: ' . $e->getMessage());
            return back()->withErrors(['error' => 'Terjadi kesalahan saat memperbarui data'])->withInput();
        }
    }

    public function destroy(Claim $claim)
    {
        // Hapus klaim
        $claim->delete();

        return redirect()->route('claim-management');
    }
}
