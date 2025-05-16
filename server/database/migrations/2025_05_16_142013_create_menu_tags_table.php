<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('menu_tags', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("menu_category_id")->nullable();
            $table->string("tag");
            $table->timestamps();

            /**
             * Foreign Keys
             */
            $table->foreign("menu_category_id")
            ->references("id")
            ->on("menu_categories")
            ->cascadeOnUpdate()
            ->nullOnDelete();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('menu_tags');
    }
};
