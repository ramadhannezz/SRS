<?php

// app/Models/KategoriLokasi.php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Storage;


class KategoriLokasi extends Model
{
    use HasFactory;

    protected $table = 'kategori_lokasi';

    protected $fillable = [
        'name',
        'icon',
    ];

    // Di Model KategoriLokasi
public function getIconUrlAttribute()
{
    return Storage::url($this->icon);
}

}
