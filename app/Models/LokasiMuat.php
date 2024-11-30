<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class LokasiMuat extends Model
{
    use HasFactory;

    protected $table = 'lokasi_muat';

    protected $fillable = [
        'name',
        'address',
        'kotas_id',
        'coordinate',
        'kategori_lokasi_id',
    ];

    protected $casts = [
        'coordinate' => 'array',
    ];

    public function kota()
    {
        return $this->belongsTo(Kota::class, 'kotas_id');
    }

    public function kategoriLokasi()
    {
        return $this->belongsTo(KategoriLokasi::class, 'kategori_lokasi_id');
    }
}
