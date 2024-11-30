<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use App\Models\Document;
use App\Models\Order;

class DocumentController extends Controller
{

        // Upload dokumen berdasarkan orders_id dan location_id
    public function uploadDocument($orderId, Request $request)
    {
        // Validasi data yang diterima
        $rules = [
            'type' => 'required|string|in:loading,unloading',
            'document_type' => 'required|string|in:surat_jalan,proses_muat,packing_list,dokumen_lain,proses_bongkar',
            'file' => 'required|image|mimes:jpeg,png,jpg|max:2048', // Validasi file gambar
        ];

        // Validasi unload_address_id hanya jika type adalah unloading atau document_type adalah proses_bongkar
        if ($request->type === 'unloading' || $request->document_type === 'proses_bongkar') {
            $rules['unload_address_id'] = 'required|integer';
        }

        $request->validate($rules);

        // Cari order berdasarkan orderId
        $order = Order::find($orderId);
        if (!$order) {
            return response()->json(['message' => 'Order not found'], 404);
        }

        // Pastikan unload_address_id ada dalam JSON array unload_addresses hanya jika type adalah unloading
        if ($request->has('unload_address_id')) {
            $unloadAddresses = collect($order->unload_addresses); // Mengubah JSON ke collection
            $unloadAddress = $unloadAddresses->firstWhere('id', $request->unload_address_id);

            if (!$unloadAddress) {
                return response()->json(['errors' => ['unload_address_id' => 'The selected unload address id is invalid.']], 422);
            }
        }

        // Upload file ke direktori storage
        if ($request->hasFile('file')) {
            $filePath = $request->file('file')->store('public/documents'); // Simpan ke storage/public/documents
            $fileName = basename($filePath);

            // Cek apakah dokumen dengan jenis yang sama sudah ada untuk orders_id dan unload_address_id
            $existingDocument = Document::where('orders_id', $orderId)
                ->where('unload_address_id', $request->unload_address_id)
                ->where('document_type', $request->document_type)
                ->first();

            if ($existingDocument) {
                // Update dokumen yang ada jika ditemukan
                Storage::delete('public/documents/' . $existingDocument->file_path); // Hapus file lama
                $existingDocument->file_path = $fileName;
                $existingDocument->save();

                return response()->json([
                    'message' => 'Document updated successfully',
                    'document' => $existingDocument,
                ], 200);
            } else {
                // Simpan dokumen baru
                $document = new Document();
                $document->orders_id = $orderId;
                $document->unload_address_id = $request->unload_address_id ?? null;
                $document->type = $request->type;
                $document->document_type = $request->document_type;
                $document->file_path = $fileName; 
                $document->save();

                return response()->json([
                    'message' => 'Document uploaded successfully',
                    'document' => $document,
                ], 200);
            }
        }

        return response()->json(['message' => 'File upload failed'], 400);
    }

    // Ambil dokumen berdasarkan orders_id dan unload_address_id (Tambahan)
    public function getDocumentsByLocation($orderId, $unloadAddressId)
    {
        $documents = Document::where('orders_id', $orderId)
            ->where('unload_address_id', $unloadAddressId)
            ->get();

        if ($documents->isEmpty()) {
            return response()->json(['message' => 'No documents found'], 404);
        }

        return response()->json($documents);
    }
//     public function uploadDocument($orderId, Request $request)
// {
//     // Validasi data yang diterima
//     $rules = [
//         'type' => 'required|string|in:loading,unloading',
//         'document_type' => 'required|string|in:surat_jalan,proses_muat,packing_list,dokumen_lain,proses_bongkar',
//         'file' => 'required|image|mimes:jpeg,png,jpg|max:2048', // Validasi file gambar
//     ];

//     // Validasi unload_address_id hanya jika type adalah unloading atau document_type adalah proses_bongkar
//     if ($request->type === 'unloading' || $request->document_type === 'proses_bongkar') {
//         $rules['unload_address_id'] = 'required|integer';
//     }

//     $request->validate($rules);

//     // Cari order berdasarkan orderId
//     $order = Order::find($orderId);
//     if (!$order) {
//         return response()->json(['message' => 'Order not found'], 404);
//     }

//     // Pastikan unload_address_id ada dalam JSON array unload_addresses hanya jika type adalah unloading
//     if ($request->has('unload_address_id')) {
//         $unloadAddresses = collect($order->unload_addresses); // Mengubah JSON ke collection
//         $unloadAddress = $unloadAddresses->firstWhere('id', $request->unload_address_id);

//         if (!$unloadAddress) {
//             return response()->json(['errors' => ['unload_address_id' => 'The selected unload address id is invalid.']], 422);
//         }
//     }

//     // Upload file ke direktori storage
//     if ($request->hasFile('file')) {
//         $filePath = $request->file('file')->store('public/documents'); // Simpan ke storage/public/documents
//         $fileName = basename($filePath);

//         // Simpan path ke database
//         $document = new Document();
//         $document->orders_id = $orderId;
//         $document->unload_address_id = $request->unload_address_id ?? null; // Gunakan unload_address_id jika ada
//         $document->type = $request->type;
//         $document->document_type = $request->document_type;
//         $document->file_path = $fileName; // Simpan nama file saja, bukan path lengkap
//         $document->save();

//         return response()->json([
//             'message' => 'Document uploaded successfully',
//             'document' => $document,
//         ], 200);
//     }

//     return response()->json(['message' => 'File upload failed'], 400);
// }
}
