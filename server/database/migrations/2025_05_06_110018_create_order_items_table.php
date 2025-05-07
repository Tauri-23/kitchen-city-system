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
        Schema::create('order_items', function (Blueprint $table) {
            $table->string("id", 20)->primary();
            $table->string("order_id", 20)->nullable();
            $table->string("menu_dish_id", 20)->nullable();
            
            $table->integer("qty")->nullable();
            $table->float("unit_cost")->default(0);
            $table->float("total_cost")->default(0);
            $table->enum("status", ["Open", "Pending", "Completed", "Cancelled"])->default("Open");
            
            $table->timestamp("completed_at")->nullable();
            $table->timestamp("cancelled_at")->nullable();

            $table->timestamps();

            

            /**
             * Foreign
             */
            $table->foreign("order_id")
            ->references("id")
            ->on("orders")
            ->cascadeOnDelete()
            ->cascadeOnDelete();

            $table->foreign("menu_dish_id")
            ->references("id")
            ->on("menu_dishes")
            ->nullOnDelete()
            ->cascadeOnDelete();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('order_items');
    }
};
