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
        Schema::create('menu_dishes', function (Blueprint $table) {
            $table->string("id", 20)->primary();

            $table->string("menu_to_dish_tag");
            $table->string("dish_code")->unique()->nullable();
            $table->string("name");
            $table->unsignedBigInteger("sub_category_id")->nullable();
            $table->float("unit_cost")->default(0);
            $table->enum("production", ["Commis", "Commis Cooked", "On Site"]);
            $table->enum("status", ["Active", "Discontinued"])->default("Active");

            $table->timestamps();


            /**
             * Foriegn Keys
             */
            $table->foreign("sub_category_id")
            ->references("id")
            ->on("menu_sub_categories")
            ->nullOnDelete()
            ->cascadeOnUpdate();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('menu_dishes');
    }
};
