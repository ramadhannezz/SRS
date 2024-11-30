<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateLokasiMuatTable extends Migration
{
    public function up()
    {
        Schema::create('lokasi_muat', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('address');
            $table->foreignId('kotas_id')->constrained('kotas');
            $table->string('coordinate');
            $table->foreignId('kategori_lokasi_id')->constrained('kategori_lokasi');
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('lokasi_muat');
    }
}
