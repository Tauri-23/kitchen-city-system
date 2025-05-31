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
        Schema::create('ml_rawmat_order_items', function (Blueprint $table) {
            $table->string("id", 20)->primary();
            $table->string("ml_rawmat_order_id", 20)->nullable();
            $table->string("ml_rawmat_item_id", 20)->nullable();
            
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
            $table->foreign("ml_rawmat_order_id")
            ->references("id")
            ->on("ml_rawmat_orders")
            ->cascadeOnDelete()
            ->cascadeOnUpdate();

            $table->foreign("ml_rawmat_item_id")
            ->references("id")
            ->on("ml_rawmat_items")
            ->nullOnDelete()
            ->cascadeOnUpdate();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('ml_rawmat_order_items');
    }
};
