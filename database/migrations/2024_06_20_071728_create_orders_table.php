<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateOrdersTable extends Migration
{
    public function up()
    {
        Schema::create('orders', function (Blueprint $table) {
            $table->id();
            $table->string('nomor_order');
            $table->foreignId('customers_id')->constrained('customers');
            $table->foreignId('services_id')->constrained('services');
            $table->date('tanggal_muat');
            $table->foreignId('typetrucks_id')->constrained('typetrucks');
            $table->foreignId('truck_id')->constrained('trucks');
            $table->foreignId('driver_id')->constrained('drivers');
            $table->foreignId('vendor_id')->constrained('vendors');
            $table->integer('jumlah_armada');
            $table->string('nama_muatan');
            $table->integer('berat_muatan');
            $table->integer('volume_muatan');
            $table->integer('jumlah_barang');
            $table->integer('uang_jalan');
            $table->integer('uang_tol');
            $table->text('catatan')->nullable();
            $table->timestamps();
            $table->string('load_address');
            $table->string('unload_addresses');
            $table->string('routes');
        });
    }

    public function down()
    {
        Schema::dropIfExists('orders');
    }
}
