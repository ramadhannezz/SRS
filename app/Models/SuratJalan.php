<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SuratJalan extends Model
{
    use HasFactory;

    protected $table = 'surat_jalan';

    protected $primaryKey = 'id_surat_jalan';

    protected $fillable = [
        'nomor_order',
        'surat_jalan_muat',
        'surat_jalan_bongkar',
    ];

    public function order()
    {
        return $this->belongsTo(Order::class, 'nomor_order');
    }
}
