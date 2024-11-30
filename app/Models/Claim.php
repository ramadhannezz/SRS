<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Claim extends Model
{
    use HasFactory;

    protected $table = 'claims';

    protected $primaryKey = 'id_claim';

    protected $fillable = [
        'nomor_order',
        'nama_muatan',
        'jumlah_barang',
        'status_muatan',
        'nama_muatan_claim',
        'jumlah_muatan_claim',
        'catatan_muatan',
    ];

    public function order()
    {
        return $this->belongsTo(Order::class, 'nomor_order');
    }
}
