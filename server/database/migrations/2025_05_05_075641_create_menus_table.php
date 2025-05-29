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

            $table->integer("menu_week");

            $table->unsignedBigInteger("menu_shift_id")->nullable();
            $table->string("menu_dish_id", 20)->nullable();

            $table->enum("menu_day", [
                "Monday", "Tuesday", "Wednesday", "Thursday", 
                "Friday", "Saturday", "Sunday"
            ]);

            $table->enum("menu_size", [
                "XL", "Large", "Medium", "Medium Frying", "Medium No Frying ",
                "Small", "Small Frying", "Small No Frying"
            ]);

            $table->timestamps();



            /**
             * Foreign Keys
             */
            $table->foreign("menu_shift_id")
            ->references("id")
            ->on("menu_shifts")
            ->nullOnDelete()
            ->cascadeOnUpdate();

            $table->foreign("menu_dish_id")
            ->references("id")
            ->on("menu_dishes")
            ->nullOnDelete()
            ->cascadeOnUpdate();
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
