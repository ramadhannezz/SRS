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
            $table->unsignedBigInteger('orders_id');
            $table->unsignedBigInteger('nama_muatan');
            $table->unsignedBigInteger('jumlah_barang');
            $table->enum('status_muatan', ['Rusak', 'Hilang', 'Kurang', 'Lebih']);
            $table->string('nama_muatan_claim', 255);
            $table->integer('jumlah_muatan_claim');
            $table->text('catatan_muatan')->nullable();
            $table->timestamps();

            // Relasi ke tabel orders (jika ada foreign key)
            $table->foreign('orders_id')->references('id')->on('orders')->onDelete('cascade');
        });
    }

    public function down()
    {
        Schema::dropIfExists('claims');
    }
}
