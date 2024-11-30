<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUnloadAddressesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('unload_addresses', function (Blueprint $table) {
            $table->id();
            $table->foreignId('orders_id')->constrained('orders')->onDelete('cascade');
            $table->string('name');
            $table->text('address');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('unload_addresses');
    }
}
