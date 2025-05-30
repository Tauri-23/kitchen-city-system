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
        Schema::create('ml_bakeshop_orders', function (Blueprint $table) {
            $table->string("id", 20)->primary();
            $table->string("branch_id", 20)->nullable();
            
            $table->dateTime("deadline")->nullable();
            $table->float("total_cost")->default(0);
            $table->enum("status", ["Open", "Pending", "Completed", "Cancelled"])->default("Open");
            
            $table->timestamp("completed_at")->nullable();
            $table->timestamp("cancelled_at")->nullable();

            $table->timestamps();



            /**
             * Foreign
             */
            $table->foreign("branch_id")
            ->references("id")
            ->on("branches")
            ->nullOnDelete()
            ->cascadeOnDelete();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('ml_bakeshop_orders');
    }
};
