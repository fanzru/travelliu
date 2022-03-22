<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTikumsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('tikums', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->string("tempat_tujuan");
            $table->string("tempat_kumpul");
            $table->string("link_group")->nullable();
            $table->string("deskripsi")->nullable();
            $table->dateTime("waktu_kumpul");
            
            // Foreign key
            $table->foreignId("user_id")->constrained();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('tikums');
    }
}
