<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateOrderStatusLogsTable extends Migration
{
    public function up()
    {
        Schema::create('order_status_logs', function (Blueprint $table) {
            $table->id();
            $table->foreignId('orders_id')->constrained('orders')->onDelete('cascade'); // Menggunakan `orders_id` sebagai foreign key
            $table->enum('status', [
                'Dijadwalkan Berangkat',
                'Menuju Lokasi Muat',
                'Sampai Lokasi Muat',
                'Mulai Muat',
                'Selesai Muat',
                'Menuju Lokasi Bongkar',
                'Sampai Lokasi Bongkar',
                'Mulai Bongkar',
                'Selesai Bongkar'
            ]);
            $table->timestamp('timestamp');
            $table->timestamps();
            $table->integer('location_id'); // Titik bongkar ke berapa
        });
    }

    public function down()
    {
        Schema::dropIfExists('order_status_logs');
    }
}