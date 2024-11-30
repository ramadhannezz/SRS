<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateClaimsTable extends Migration
{
    public function up()
    {
        Schema::create('claims', function (Blueprint $table) {
            $table->id('id_claim');
            $table->foreignId('nomor_order')->constrained('orders')->onDelete('cascade');
            $table->foreignId('nama_muatan')->constrained('orders')->onDelete('cascade');
            $table->foreignId('jumlah_barang')->constrained('orders')->onDelete('cascade');
            $table->enum('status_muatan', ['Rusak', 'Hilang', 'Kurang', 'Lebih']);
            $table->string('nama_muatan_claim');
            $table->integer('jumlah_muatan_claim');
            $table->text('catatan_muatan')->nullable();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('claims');
    }
}
