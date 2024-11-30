<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OrderStatusLog extends Model
{
    use HasFactory;

    protected $fillable = ['orders_id', 'status', 'timestamp', 'location_id'];

    public function order()
    {
        return $this->belongsTo(Order::class, 'orders_id');
    }
}
