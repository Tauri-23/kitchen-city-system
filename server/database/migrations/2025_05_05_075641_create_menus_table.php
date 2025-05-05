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
        Schema::create('menus', function (Blueprint $table) {
            $table->string("id", 20)->primary();

            $table->string("menu_name")->nullable();
            $table->integer("menu_week");
            $table->enum("meal_type", [
                "Breakfast", "Lunch", "Snack", "Dinner", 
                "Midnight Lunch", "Midnight Snack"
            ]);

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('menus');
    }
};
