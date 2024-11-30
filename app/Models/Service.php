<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Service extends Model
{
    use HasFactory;

    protected $table = 'services'; // Pastikan tabel sesuai
    protected $fillable = ['name']; // Tambahkan kolom yang relevan
}
