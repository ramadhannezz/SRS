<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class UpdateNomorOrderToOrdersIdInClaimsTable extends Migration
{
    public function up()
    {
        Schema::table('claims', function (Blueprint $table) {
            // Drop the existing foreign key and column
            $table->dropForeign(['nomor_order']);
            $table->dropColumn('nomor_order');

            // Add the new orders_id column with a foreign key
            $table->foreignId('orders_id')->constrained('orders')->onDelete('cascade');
        });
    }

    public function down()
    {
        Schema::table('claims', function (Blueprint $table) {
            // Drop the new orders_id column
            $table->dropForeign(['orders_id']);
            $table->dropColumn('orders_id');

            // Re-add the original nomor_order column with a foreign key
            $table->foreignId('nomor_order')->constrained('orders')->onDelete('cascade');
        });
    }
}
