<?php

// Migration file: 2024_07_15_000000_add_truck_and_driver_to_orders_table.php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddTruckAndDriverToOrdersTable extends Migration
{
    public function up()
    {
        Schema::table('orders', function (Blueprint $table) {
            $table->unsignedBigInteger('truck_id')->nullable()->after('typetrucks_id');
            $table->unsignedBigInteger('driver_id')->nullable()->after('truck_id');

            $table->foreign('truck_id')->references('id')->on('trucks')->onDelete('set null');
            $table->foreign('driver_id')->references('id')->on('drivers')->onDelete('set null');
        });
    }

    public function down()
    {
        Schema::table('orders', function (Blueprint $table) {
            $table->dropForeign(['truck_id']);
            $table->dropForeign(['driver_id']);
            $table->dropColumn('truck_id');
            $table->dropColumn('driver_id');
        });
    }
}
