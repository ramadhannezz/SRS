<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Document extends Model
{
    use HasFactory;

    // Nama tabel jika tidak mengikuti konvensi 'snake_case' dari Laravel
    protected $table = 'documents';

    // Kolom yang dapat diisi
    protected $fillable = [
        'orders_id',
        'unload_address_id',
        'type',
        'document_type',
        'file_path',
    ];

    // Definisi relasi ke tabel Order
    public function order()
    {
        return $this->belongsTo(Order::class, 'orders_id');
    }

    // Definisi relasi ke tabel UnloadAddress
    public function unloadAddress()
    {
        return $this->belongsTo(UnloadAddress::class, 'unload_address_id');
    }
}
