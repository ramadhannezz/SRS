<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    use HasFactory;
    
    protected $fillable = [
        'nomor_order', 'customers_id', 'services_id', 'typetrucks_id', 'tanggal_muat',
        'jumlah_armada', 'nama_muatan', 'berat_muatan', 'volume_muatan', 'jumlah_barang', 
        'uang_jalan', 'uang_tol', 'catatan', 'load_address', 'unload_addresses', 'routes',
        'driver_id', 'truck_id', 'vendor_id', 'current_status', 'jumlah_muatan', 'nama_muatan', 
        'catatan_muatan', 'surat_jalan'
    ];

    protected $casts = [
        'load_address' => 'array',
        'unload_addresses' => 'array',
        'routes' => 'array',
    ];

    // Relasi dengan model lain
    public function customer()
    {
        return $this->belongsTo(Customer::class, 'customers_id');
    }

    public function service()
    {
        return $this->belongsTo(Service::class, 'services_id');
    }

    public function typetrucks()
    {
        return $this->belongsTo(TypeTruck::class, 'typetrucks_id');
    }

    public function driver()
    {
        return $this->belongsTo(Driver::class, 'driver_id');
    }

    public function truck()
    {
        return $this->belongsTo(Truck::class, 'truck_id');
    }

    public function vendor()
    {
        return $this->belongsTo(Vendor::class, 'vendor_id');
    }

    public function typetruck()
    {
        return $this->belongsTo(TypeTruck::class, 'typetrucks_id');
    }

    public function orderStatusLogs()
    {
        return $this->hasMany(OrderStatusLog::class, 'orders_id');
    }

    public function claims()
    {
        return $this->hasMany(Claim::class, 'orders_id');
    }

    public function unloadAddresses()
    {
        return $this->hasMany(UnloadAddress::class, 'orders_id');
    }

    public function documents()
    {
        return $this->hasMany(Document::class, 'orders_id');
    }
    

    // Relasi dengan smart routing
    public function getLoadAddressNameAttribute()
    {
        $loadAddress = $this->load_address ?: [];
        return $loadAddress['name'] ?? '';
    }
    
    public function getUnloadAddressesNamesAttribute()
    {
        $unloadAddresses = $this->unload_addresses ?: [];
        return array_map(function($address, $index) {
            return ['index' => $index + 1, 'name' => $address['name'], 'address' => $address['address']];
        }, $unloadAddresses, array_keys($unloadAddresses));
    }
}
