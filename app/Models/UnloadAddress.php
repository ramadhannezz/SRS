<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UnloadAddress extends Model
{
    use HasFactory;

    protected $fillable = ['orders_id', 'name', 'address'];

    public function order()
    {
        return $this->belongsTo(Order::class, 'orders_id');
    }

    public function documents()
    {
        return $this->hasMany(Document::class, 'unload_address_id');
    }
}
