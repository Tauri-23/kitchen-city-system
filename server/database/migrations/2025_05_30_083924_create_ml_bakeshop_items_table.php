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
        Schema::create('ml_bakeshop_items', function (Blueprint $table) {
            $table->string("id", 20)->primary();

            $table->string("name", 100);

            $table->unsignedBigInteger("ml_bakeshop_category_id")->nullable(); // Foreign

            $table->float("unit_cost")->default(0);
            $table->float("srp")->default(0);

            $table->timestamps();

            
            /**
             * Foreign
             */
            $table->foreign("ml_bakeshop_category_id")
            ->references("id")
            ->on("ml_bakeshop_categories")
            ->nullOnDelete()
            ->cascadeOnUpdate();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('ml_bakeshop_items');
    }
};
