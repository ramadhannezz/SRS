<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class UpdateOrdersTableForSmartRouting extends Migration
{
    public function up()
    {
        Schema::table('orders', function (Blueprint $table) {
            // Tambahkan kolom baru
            $table->json('load_address')->nullable();
            $table->json('unload_addresses')->nullable();
            $table->json('routes')->nullable();
        });
    }

    public function down()
    {
        Schema::table('orders', function (Blueprint $table) {
            // Tambah kolom kembali
            $table->unsignedBigInteger('lokasi_muat_id')->nullable();
            $table->unsignedBigInteger('lokasi_bongkar_id')->nullable();
            $table->foreign('lokasi_muat_id')->references('id')->on('lokasi_muat');
            $table->foreign('lokasi_bongkar_id')->references('id')->on('lokasi_bongkar');

            // Hapus kolom baru
            $table->dropColumn('load_address');
            $table->dropColumn('unload_addresses');
            $table->dropColumn('routes');
        });
    }
}
