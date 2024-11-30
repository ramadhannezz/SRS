<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class UpdateOrdersTableForRoutes extends Migration
{
    public function up()
    {
        Schema::table('orders', function (Blueprint $table) {
            // Hapus kolom jika sudah ada
            if (Schema::hasColumn('orders', 'lokasi_muat_id')) {
                $table->dropForeign(['lokasi_muat_id']);
                $table->dropColumn('lokasi_muat_id');
            }
            if (Schema::hasColumn('orders', 'lokasi_bongkar_id')) {
                $table->dropForeign(['lokasi_bongkar_id']);
                $table->dropColumn('lokasi_bongkar_id');
            }
            if (Schema::hasColumn('orders', 'routes')) {
                $table->dropColumn('routes');
            }

            // Tambah kolom kembali
            $table->unsignedBigInteger('lokasi_muat_id')->nullable();
            $table->unsignedBigInteger('lokasi_bongkar_id')->nullable();

            // Tambah kolom routes
            $table->json('routes')->nullable();

            // Tambah foreign key constraints
            $table->foreign('lokasi_muat_id')->references('id')->on('lokasi_muat')->onDelete('set null');
            $table->foreign('lokasi_bongkar_id')->references('id')->on('lokasi_bongkar')->onDelete('set null');
        });
    }

    public function down()
    {
        Schema::table('orders', function (Blueprint $table) {
            // Hapus foreign key constraints
            $table->dropForeign(['lokasi_muat_id']);
            $table->dropForeign(['lokasi_bongkar_id']);

            // Hapus kolom
            $table->dropColumn('lokasi_muat_id');
            $table->dropColumn('lokasi_bongkar_id');
            $table->dropColumn('routes');
        });
    }
}
