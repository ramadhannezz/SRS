<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TypeTruck extends Model
{
    use HasFactory;

    protected $table = 'typetrucks'; // Pastikan tabel sesuai
    protected $fillable = ['name']; // Tambahkan kolom yang relevan
}
