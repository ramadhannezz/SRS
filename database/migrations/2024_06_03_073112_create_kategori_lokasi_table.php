<?php

// database/migrations/2024_06_03_000000_create_kategori_lokasi_table.php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateKategoriLokasiTable extends Migration
{
    public function up()
    {
        Schema::create('kategori_lokasi', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('icon');
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('kategori_lokasi');
    }
}
