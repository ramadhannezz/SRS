<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Claim extends Model
{
    use HasFactory;

    protected $table = 'claims'; // Nama tabel
    protected $primaryKey = 'id_claim'; // Primary key

    // Kolom yang dapat diisi
    protected $fillable = [
        'orders_id',
        'nama_muatan',
        'jumlah_barang',
        'status_muatan',
        'nama_muatan_claim',
        'jumlah_muatan_claim',
        'catatan_muatan',
        'created_at',
    ];

    public $timestamps = true; // Aktifkan timestamps (default: true)

    // Relasi ke model Order (jika tabel orders ada)
    public function order()
    {
        return $this->belongsTo(Order::class, 'orders_id', 'id');
    }
}
