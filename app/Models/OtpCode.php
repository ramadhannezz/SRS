<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OtpCode extends Model
{
    use HasFactory;

    protected $fillable = [
        'phone_number',
        'otp_code',
        'is_logged_in', // Pastikan kolom is_logged_in bisa diisi
        'drivers_id',
        'expires_at',
    ];

    // Relasi ke model Driver
    public function driver()
    {
        return $this->belongsTo(Driver::class, 'drivers_id');
    }
}
