<?php

namespace App\Http\Controllers;

use App\Models\Order;
use App\Models\Customer;
use App\Models\KategoriLokasi;
use App\Models\Kota;
use App\Models\LokasiBongkar;
use App\Models\LokasiMuat;
use App\Models\Service;
use App\Models\TypeTruck;
use App\Models\Driver;
use App\Models\Truck;
use App\Models\Vendor;
use App\Models\Claim;
use App\Models\SuratJalan;
use App\Models\OrderStatusLog;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Carbon\Carbon;
use Illuminate\Support\Facades\Log;
use App\Models\Document;
use Illuminate\Validation\Rule;

class OrderController extends Controller
{

// ===== WEB APP BACKEND ===== //

    // Logika untuk menampilkan data di halaman create order
    public function create()
    {
        $customers = Customer::all();
        $services = Service::all();
        $typetrucks = TypeTruck::all();
        $drivers = Driver::all();
        $trucks = Truck::all();
        $lokasiMuat = LokasiMuat::all();
        $lokasiBongkar = LokasiBongkar::all();
        $kotas = Kota::all();
        $kategoriLokasi = KategoriLokasi::all();

        return Inertia::render('CreateOrder', [
            'customers' => $customers,
            'services' => $services,
            'typetrucks' => $typetrucks,
            'drivers' => $drivers,
            'trucks' => $trucks,
            'lokasiMuat' => $lokasiMuat,
            'lokasiBongkar' => $lokasiBongkar,
            'kotas' => $kotas,
            'kategoriLokasi' => $kategoriLokasi
        ]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'nomor_order' => 'required|unique:orders',
            'customers_id' => 'required',
            'services_id' => 'required',
            'typetrucks_id' => 'required',
            'tanggal_muat' => 'required|date',
            'jumlah_armada' => 'required|integer',
            'nama_muatan' => 'required|string',
            'berat_muatan' => 'required|integer',
            'volume_muatan' => 'required|integer',
            'jumlah_barang' => 'required|integer',
            'uang_jalan' => 'required|integer',
            'uang_tol' => 'required|integer',
            'catatan' => 'nullable|string',
            'load_address' => 'required|array',
            'unload_addresses' => 'required|array|min:1',
            'routes' => 'required|array',
            'driver_id' => 'nullable|exists:drivers,id',
            'truck_id' => 'nullable|exists:trucks,id',
        ]);

        $data = $request->all();
        $data['tanggal_muat'] = date('Y-m-d', strtotime($request->tanggal_muat));
    
        Order::create($data);
    
        return redirect()->route('orders.index');
    }

    // Logika untuk menampilkan data di halaman list order
    public function index()
    {
        $orders = Order::with(['customer', 'service', 'typetrucks', 'driver', 'truck', 'vendor'])->get()->map(function($order) {
            return [
                'id' => $order->id,
                'nomor_order' => $order->nomor_order,
                'customer_name' => $order->customer->name,
                'service_name' => $order->service->name,
                'load_address_name' => $order->load_address_name,
                'unload_addresses_names' => $order->unload_addresses_names,
                'typetrucks_name' => $order->typetrucks->name,
                'tanggal_muat' => $order->tanggal_muat,
                'jumlah_armada' => $order->jumlah_armada,
                'nama_muatan' => $order->nama_muatan,
                'berat_muatan' => $order->berat_muatan,
                'volume_muatan' => $order->volume_muatan,
                'jumlah_barang' => $order->jumlah_barang,
                'uang_jalan' => $order->uang_jalan,
                'uang_tol' => $order->uang_tol,
                'catatan' => $order->catatan,
                'driver_name' => $order->driver ? $order->driver->name : null,
                'truck_licensePlate' => $order->truck ? $order->truck->licensePlate : null,
                'vendor_name' => $order->vendor ? $order->vendor->name : null,
                'current_status' => $order->current_status,
            ];
        });

        $drivers = Driver::all(['id', 'name']);
        $trucks = Truck::all(['id', 'licensePlate']);
        $vendors = Vendor::all(['id', 'name']);

        return Inertia::render('ListOrder', [
            'orders' => $orders,
            'drivers' => $drivers,
            'trucks' => $trucks,
            'vendors' => $vendors,
        ]);
    }

    // Logika untuk menampilkan data di halaman update status trip
    public function getOrderData($id)
    {
        $order = Order::with(['customer', 'service', 'typetrucks', 'driver', 'truck', 'vendor', 'orderStatusLogs'])
                    ->findOrFail($id);

        // Pastikan orderStatusLogs selalu berupa array
        if (!$order->relationLoaded('orderStatusLogs')) {
            $order->setRelation('orderStatusLogs', collect([]));
        }

        return response()->json([
            'nomor_trip' => $order->nomor_order,
            'nomor_do' => $order->nomor_order, // Asumsikan nomor DO sama dengan nomor order, sesuaikan jika berbeda
            'customer_name' => $order->customer->name,
            'nomor_to' => $order->nomor_order, // Sesuaikan dengan field yang tepat
            'current_status' => $order->current_status, // Tambahkan field untuk status
            'vendor_name' => $order->vendor ? $order->vendor->name : null,
            'driver_name' => $order->driver ? $order->driver->name : null,
            'truck_licensePlate' => $order->truck ? $order->truck->licensePlate : null,
            'driver_phone' => $order->driver ? $order->driver->phone : null, // Asumsi field phone ada di driver
            'typetrucks_name' => $order->typetrucks->name,
            'load_address' => $order->load_address,
            'tanggal_muat' => $order->tanggal_muat,
            'unload_addresses' => $order->unload_addresses,
            'orderStatusLogs' => $order->orderStatusLogs, // Kirim orderStatusLogs ke frontend
            // Tambahkan field lainnya yang diperlukan
        ]);
    }

    // Logika untuk membuat nomor_order sesuai system
    public function generateOrderNumber()
    {
        $today = Carbon::now()->format('dmY');
        $prefix = 'SRS' . $today;

        $lastOrder = Order::where('nomor_order', 'like', $prefix . '%')
            ->orderBy('created_at', 'desc')
            ->first();

        if (!$lastOrder) {
            $newOrderNumber = $prefix . '000001';
        } else {
            $lastNumber = (int) substr($lastOrder->nomor_order, -6);
            $newOrderNumber = $prefix . str_pad($lastNumber + 1, 6, '0', STR_PAD_LEFT);
        }

        return response()->json(['nomor_order' => $newOrderNumber]);
    }

    // Logika untuk menugaskan data driver dari table driver
    public function assignDriver(Request $request, Order $order)
    {
        $request->validate([
            'driver_id' => 'required|exists:drivers,id',
        ]);
    
        $order->update([
            'driver_id' => $request->driver_id,
        ]);
    
        return response()->json(['message' => 'Driver assigned successfully.']);
    }
    
    // Logika untuk menugaskan data truck dari table truck
    public function assignTruck(Request $request, Order $order)
    {
        $request->validate([
            'truck_id' => 'required|exists:trucks,id',
        ]);
    
        $order->update([
            'truck_id' => $request->truck_id,
        ]);
    
        return response()->json(['message' => 'Truck assigned successfully.']);
    }
    
    // Logika untuk menugaskan data vendor dari table vendor
    public function assignVendor(Request $request, Order $order)
    {
        // Validasi input vendor_id
        $validatedData = $request->validate([
            'vendor_id' => 'required|exists:vendors,id',
        ]);
    
        // Perbarui order dengan vendor_id
        try {
            $order->update(['vendor_id' => $validatedData['vendor_id']]);
            return response()->json(['message' => 'Vendor assigned successfully.']);
        } catch (\Exception $e) {
            // Log error untuk debugging
            Log::error("Failed to assign vendor: " . $e->getMessage());
            return response()->json(['message' => 'Failed to assign vendor.'], 500);
        }
    }

    // Kode baru fix current_status akan diperbarui dengan benar, bahkan jika beberapa status diperbarui sekaligus
    public function updateStatus(Request $request, $id)
    {
        Log::info('Data diterima:', $request->all());

        $order = Order::findOrFail($id);
        $statuses = json_decode($request->input('status'), true);

        $validStatusOrder = [
            'Dijadwalkan Berangkat',
            'Menuju Lokasi Muat',
            'Sampai Lokasi Muat',
            'Mulai Muat',
            'Selesai Muat',
            'Menuju Lokasi Bongkar',
            'Sampai Lokasi Bongkar',
            'Mulai Bongkar',
            'Selesai Bongkar'
        ];

        $latestStatus = null;
        $latestIndex = -1; // Untuk melacak prioritas status terakhir

        foreach ($statuses as $status) {
            $statusIndex = array_search($status['name'], $validStatusOrder);

            if ($status['checked'] && $statusIndex !== false) {
                try {
                    OrderStatusLog::updateOrCreate(
                        [
                            'orders_id' => $order->id,
                            'status' => $status['name'],
                            'location_id' => $status['location_id'],
                        ],
                        [
                            'timestamp' => $status['date']
                        ]
                    );

                    // Perbarui status terbaru berdasarkan indeks prioritas
                    if ($statusIndex > $latestIndex) {
                        $latestStatus = $status['name'];
                        $latestIndex = $statusIndex;
                    }

                    Log::info('Status disimpan:', ['status' => $status['name'], 'timestamp' => $status['date']]);
                } catch (\Exception $e) {
                    Log::error('Gagal menyimpan status:', ['error' => $e->getMessage()]);
                }
            } elseif (!$status['checked'] && $statusIndex !== false) {
                // Hapus status dari order_status_logs jika di-uncheck
                OrderStatusLog::where([
                    ['orders_id', '=', $order->id],
                    ['status', '=', $status['name']],
                    ['location_id', '=', $status['location_id']],
                ])->delete();
            }
        }

        // Perbarui current_status berdasarkan prioritas tertinggi
        if ($latestStatus) {
            $order->current_status = $latestStatus;
        } else {
            // Ambil status terakhir dari order_status_logs jika tidak ada status baru
            $lastStatusLog = OrderStatusLog::where('orders_id', $order->id)
                                        ->orderBy('timestamp', 'desc')
                                        ->first();

            $order->current_status = $lastStatusLog ? $lastStatusLog->status : 'Dijadwalkan Berangkat';
        }

        $order->save();

        return response()->json(['message' => 'Status berhasil diupdate.']);
    }

    
    public function uploadDocuments($id, Request $request)
    {
        $type = $request->query('type');
        $allowedTypes = ['surat_jalan', 'proses', 'packing_list', 'bukti_timbang', 'dokumen_lain'];

        foreach ($allowedTypes as $docType) {
            if ($request->hasFile($docType)) {
                $file = $request->file($docType);
                $filePath = $file->store("public/documents/{$id}");

                // Cek jika dokumen sudah ada, jika ada maka update, jika tidak, maka insert
                Document::updateOrCreate(
                    ['orders_id' => $id, 'type' => $type, 'document_type' => $docType],
                    ['file_path' => basename($filePath)]
                );
            }
        }

        return response()->json(['message' => 'Dokumen berhasil diupload.']);
    }

    public function getDocuments($id, Request $request)
    {
        $type = $request->query('type');

        $documents = Document::where('orders_id', $id)
                            ->where('type', $type)
                            ->get();

        $response = [
            'surat_jalan' => $documents->where('document_type', 'surat_jalan')->first()->file_path ?? null,
            'proses' => $documents->where('document_type', 'proses')->first()->file_path ?? null,
            'packing_list' => $documents->where('document_type', 'packing_list')->first()->file_path ?? null,
            'bukti_timbang' => $documents->where('document_type', 'bukti_timbang')->first()->file_path ?? null,
            'dokumen_lain' => $documents->where('document_type', 'dokumen_lain')->first()->file_path ?? null,
        ];

        return response()->json($response);
    }
// ===== END WEB APP BACKEND ===== //
    
// ===== MOBILE APP ANDROID x IOS BACKEND ===== //

    // Function untuk mengambil order dengan status 'Dijadwalkan Berangkat' Untuk di Tampilkan di frontend
    public function getNewOrders($driver_id)
    {
        Log::info('Menerima driver_id: ' . $driver_id);

        $orders = Order::where('current_status', 'Dijadwalkan Berangkat')
                       ->where('driver_id', $driver_id) // Filter berdasarkan drivers_id
                       ->select('id', 'nomor_order', 'tanggal_muat', 'load_address', 'unload_addresses', 'current_status')
                       ->get();
        Log::info('Menerima driver_id: ' . $driver_id);

        
        return response()->json([
            'status' => 'success',
            'data' => $orders
        ]);
    }
     
    // Function untuk mengambil order dengan status antara 'Menuju Lokasi Muat' hingga 'Selesai Bongkar'
    public function getAcceptedOrders($driver_id)
    {
        Log::info('Menerima driver_id: ' . $driver_id);

        $statuses = [
            'Menuju Lokasi Muat',
            'Sampai Lokasi Muat',
            'Mulai Muat',
            'Selesai Muat',
            'Menuju Lokasi Bongkar',
            'Sampai Lokasi Bongkar',
            'Mulai Bongkar',
            'Selesai Bongkar'
        ];
    
        $orders = Order::whereIn('current_status', $statuses)
                       ->where('driver_id', $driver_id) // Filter berdasarkan drivers_id
                       ->select('id', 'nomor_order', 'tanggal_muat', 'load_address', 'unload_addresses', 'current_status')
                       ->get();
        Log::info('Menerima driver_id: ' . $driver_id);

        return response()->json([
            'status' => 'success',
            'data' => $orders
        ]);
    }
    
    // Function untuk mengirim data hasil update status
    public function updateStatusFromMobile($orderId, Request $request)
    {
        // Validasi request yang masuk dengan memastikan bahwa current_status adalah salah satu nilai enum yang valid
        $request->validate([
            'current_status' => [
                'required',
                Rule::in([
                    'Dijadwalkan Berangkat', 'Menuju Lokasi Muat', 'Sampai Lokasi Muat', 'Mulai Muat',
                    'Selesai Muat', 'Menuju Lokasi Bongkar', 'Sampai Lokasi Bongkar', 'Mulai Bongkar',
                    'Selesai Bongkar',
                ]),
            ],
            // Validasi tambahan untuk data muatan (opsional)
            'nama_muatan' => 'nullable|string',
            'berat_muatan' => 'nullable|numeric',
            'volume_muatan' => 'nullable|numeric',
            'jumlah_barang' => 'nullable|integer',
            // Validasi untuk location_id (index lokasi bongkar)
            'location_id' => 'required|integer',
        ]);
        Log::info('Received location_id:', ['location_id' => $request->location_id]);

    
        // Cari order berdasarkan ID
        $order = Order::find($orderId);
    
        if (!$order) {
            return response()->json([
                'message' => 'Order not found',
            ], 404);
        }
    
        // Update current_status
        $order->current_status = $request->current_status;

        // Update informasi muatan jika ada data muatan yang dikirim
        if ($request->has('nama_muatan')) {
            $order->nama_muatan = $request->nama_muatan;
        }
        if ($request->has('berat_muatan')) {
            $order->berat_muatan = $request->berat_muatan;
        }
        if ($request->has('volume_muatan')) {
            $order->volume_muatan = $request->volume_muatan;
        }
        if ($request->has('jumlah_barang')) {
            $order->jumlah_barang = $request->jumlah_barang;
        }

        $order->save();

         // Tambahkan log ke order_status_logs setelah status diupdate
        OrderStatusLog::create([
            'orders_id' => $order->id,
            'status' => $order->current_status,
            'location_id' => $request->location_id, // Ambil location_id dari request untuk tahu lokasi bongkar keberapa
            'timestamp' => now(), // Timestamp log
        ]);
    
        Log::info('Order status updated for order id: ' . $orderId . ' to status: ' . $order->current_status); // Log status terbaru
    
        return response()->json([
            'message' => 'Order status updated successfully',
            'order' => $order,
        ], 200);
    }

    // Function untuk mengambil data order untuk ditampilkan di detail trip frontend
    public function getNewOrderDetails($orderId)
    {
        // Cari order berdasarkan orders_id
        $order = Order::with(['customer', 'truck', 'typetrucks', 'driver'])
            ->where('id', $orderId)
            ->whereIn('current_status', ['Dijadwalkan Berangkat', 'Menuju Lokasi Muat', 'Sampai Lokasi Muat', 'Mulai Muat',
                    'Selesai Muat', 'Menuju Lokasi Bongkar', 'Sampai Lokasi Bongkar', 'Mulai Bongkar',
                    'Selesai Bongkar'])
            ->firstOrFail();
            
            // $order = Order::find($orderId);
            if (!$order) {
                return response()->json(['error' => 'Order not found'], 404);
            }

            // Tambahkan log untuk memeriksa apakah data truck berhasil diambil
            Log::info('Truck ID:', ['truck' => $order->truck]);

            // Tambahkan log untuk melihat apakah data truck berhasil diambil
            Log::info('Data yang dikirim ke frontend:', [
                'truck_id' => $order->truck ? $order->truck->licenseplate : null, // Log truck license plate
                'typetrucks_id' => $order->typetrucks_id ? $order->typetrucks->name : null, // Log truck type
            ]);
            
            Log::info('Fetching order details for order id: ' . $orderId);
            Log::info('Order unload_addresses: ' . json_encode($order->unload_addresses));

        // Format data untuk dikirimkan ke frontend
        $orderDetails = [
            'infoRute' => [
                'truck_id' => $order->truck_id ? $order->truck->licenseplate : null, // Pastikan license_plate dari relasi truck
                'typetrucks_id' => $order->typetrucks_id ? $order->typetrucks->name : null, 
                'tanggal_muat' => $order->tanggal_muat,
                'load_address' => $order->load_address,
                'unload_addresses' => $order->unload_addresses,
                'load_pic' => $order->load_address['pic'] ?? '', // PIC untuk lokasi muat
                'unload_pic' => $order->unload_addresses[0]['pic'] ?? '' // PIC untuk lokasi bongkar
            ],
            'infoUmum' => [
                'orders_id' => $order->nomor_order,
                'customers_id' => $order->customer->name,
                'catatan' => $order->catatan
            ],
            'infoMuatan' => [
                'orders_id' => $order->nomor_order,
                'customers_id' => $order->customer->name,
                'nama_muatan' => $order->nama_muatan,
                'berat_muatan' => $order->berat_muatan,
                'volume_muatan' => $order->volume_muatan,
                'jumlah_barang' => $order->jumlah_barang
            ]
        ];

        return response()->json($orderDetails);
    }

    // Mendapatkan detail order berdasarkan orders_id dan location_id (Tambahan)
    public function getOrderDetailsByLocation($orderId, $locationId)
    {
        $order = Order::find($orderId);
        
        if (!$order) {
            return response()->json(['error' => 'Order not found'], 404);
        }

        // Pastikan location_id valid di unload_addresses
        $unloadAddresses = collect($order->unload_addresses);
        $unloadAddress = $unloadAddresses->firstWhere('id', $locationId);

        if (!$unloadAddress) {
            return response()->json(['error' => 'Invalid location_id'], 422);
        }

        // Format data order untuk dikirimkan ke frontend
        $orderDetails = [
            'infoRute' => [
                'truck_id' => $order->truck_id ? $order->truck->licenseplate : null,
                'typetrucks_id' => $order->typetrucks_id ? $order->typetrucks->name : null,
                'tanggal_muat' => $order->tanggal_muat,
                'load_address' => $order->load_address,
                'unload_address' => $unloadAddress, // Ambil unload_address berdasarkan location_id
                'load_pic' => $order->load_address['pic'] ?? '',
                'unload_pic' => $unloadAddress['pic'] ?? ''
            ],
            'infoUmum' => [
                'orders_id' => $order->nomor_order,
                'customers_id' => $order->customer->name,
                'catatan' => $order->catatan
            ],
            'infoMuatan' => [
                'orders_id' => $order->nomor_order,
                'customers_id' => $order->customer->name,
                'nama_muatan' => $order->nama_muatan,
                'berat_muatan' => $order->berat_muatan,
                'volume_muatan' => $order->volume_muatan,
                'jumlah_barang' => $order->jumlah_barang
            ]
        ];

        return response()->json($orderDetails);
    }

    public function getRoutes($orderId)
    {
        $order = Order::find($orderId);
    
        if (!$order) {
            return response()->json(['status' => 'error', 'message' => 'Order not found'], 404);
        }
    
        // Ambil kolom routes dan pastikan tidak null
        $routes = json_decode($order->routes);
    
        if (empty($routes) || count($routes) < 2) {
            Log::error("Routes data is invalid or less than two points for order: $orderId");
             return response()->json(['status' => 'error', 'message' => 'Not enough destinations'], 400);
        }
    
        return response()->json([
            'status' => 'success',
            'data' => $routes
        ]);
    }
    


// ===== END MOBILE APP ANDROID x IOS BACKEND ===== //

}