<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddUnloadAddressIdToDocumentsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('documents', function (Blueprint $table) {
            $table->unsignedBigInteger('unload_address_id')->nullable()->after('orders_id');
            $table->foreign('unload_address_id')->references('id')->on('unload_addresses')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('documents', function (Blueprint $table) {
            $table->dropForeign(['unload_address_id']);
            $table->dropColumn('unload_address_id');
        });
    }
}
