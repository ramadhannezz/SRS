<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddDocumentAndCargoDataToOrderStatusLogsTable extends Migration
{
    public function up()
    {
        Schema::table('order_status_logs', function (Blueprint $table) {
            $table->json('document_data')->nullable()->after('location_id');
            $table->json('cargo_data')->nullable()->after('document_data');
        });
    }

    public function down()
    {
        Schema::table('order_status_logs', function (Blueprint $table) {
            $table->dropColumn('document_data');
            $table->dropColumn('cargo_data');
        });
    }
}
