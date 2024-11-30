<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddCurrentStatusToOrdersTable extends Migration
{
    public function up()
    {
        Schema::table('orders', function (Blueprint $table) {
            $table->enum('current_status', [
                'Dijadwalkan Berangkat',
                'Menuju Lokasi Muat',
                'Sampai Lokasi Muat',
                'Mulai Muat',
                'Selesai Muat',
                'Menuju Lokasi Bongkar',
                'Sampai Lokasi Bongkar',
                'Mulai Bongkar',
                'Selesai Bongkar'
            ])->default('Dijadwalkan Berangkat')->after('routes');
        });
    }

    public function down()
    {
        Schema::table('orders', function (Blueprint $table) {
            $table->dropColumn('current_status');
        });
    }
}
