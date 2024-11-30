<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Route extends Model
{
    use HasFactory;

    protected $fillable = [
        'load_address',
        'unload_addresses',
        'route',
    ];

    protected $casts = [
        'unload_addresses' => 'array',
        'route' => 'array',
    ];
}
