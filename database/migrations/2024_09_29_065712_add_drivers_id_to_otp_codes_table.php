<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddDriversIdToOtpCodesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('otp_codes', function (Blueprint $table) {
            // Menambahkan kolom drivers_id yang berelasi dengan tabel drivers
            $table->unsignedBigInteger('drivers_id')->nullable()->after('phone_number');

            // Menambahkan foreign key constraint
            $table->foreign('drivers_id')->references('id')->on('drivers')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('otp_codes', function (Blueprint $table) {
            // Menghapus foreign key constraint dan kolom drivers_id
            $table->dropForeign(['drivers_id']);
            $table->dropColumn('drivers_id');
        });
    }
}
