<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::create('documents', function (Blueprint $table) {
            $table->id();
            $table->foreignId('orders_id')->constrained('orders')->onDelete('cascade');
            $table->string('type'); // 'muat' or 'bongkar'
            $table->string('document_type'); // 'surat_jalan', 'proses', 'packing_list', 'bukti_timbang', 'dokumen_lain'
            $table->string('file_path');
            $table->timestamps();
        });
        
    }

    /**
     * Reverse the migrations.
     */
    public function down()
    {
        Schema::dropIfExists('documents');
    }
};
