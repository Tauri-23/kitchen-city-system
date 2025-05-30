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
        Schema::create('ml_bakeshop_order_items', function (Blueprint $table) {
            $table->string("id", 20)->primary();
            $table->string("ml_bakeshop_order_id", 20)->nullable();
            $table->string("ml_bakeshop_item_id", 20)->nullable();
            
            $table->integer("qty")->nullable();
            $table->float("unit_cost")->default(0);
            $table->float("srp")->default(0);
            $table->float("total_cost")->default(0);
            $table->enum("status", ["Open", "Pending", "Completed", "Cancelled"])->default("Open");
            
            $table->timestamp("completed_at")->nullable();
            $table->timestamp("cancelled_at")->nullable();

            $table->timestamps();

            

            /**
             * Foreign
             */
            $table->foreign("ml_bakeshop_order_id")
            ->references("id")
            ->on("ml_bakeshop_orders")
            ->cascadeOnDelete()
            ->cascadeOnDelete();

            $table->foreign("ml_bakeshop_item_id")
            ->references("id")
            ->on("ml_bakeshop_items")
            ->nullOnDelete()
            ->cascadeOnDelete();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('ml_bakeshop_order_items');
    }
};
