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
        Schema::create('branches', function (Blueprint $table) {
            $table->string("id", 20)->primary();
            $table->string("branch_code")->unique();
            $table->string("name");
            $table->string("address");
            $table->string("area_manager_id", 20)->nullable();
            $table->enum("size", ["XL", "Large", "Medium", "Medium Frying", "Small", "Small Frying"])->default("XL");
            $table->enum("status", ["Active", "Suspended", "Discontinued"])->default("Active");
            $table->timestamps();

            $table->foreign("area_manager_id")
            ->references("id")
            ->on("area_managers")
            ->nullOnDelete()
            ->cascadeOnUpdate();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('branches');
    }
};
