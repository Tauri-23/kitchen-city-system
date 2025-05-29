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

            $table->string("odoo_description", 100);
            $table->string("system_description", 100);

            $table->unsignedBigInteger("menu_tag_id")->nullable(); // Foreign
            $table->unsignedBigInteger("menu_category_id")->nullable(); // Foreign
            $table->unsignedBigInteger("menu_sub_category_id")->nullable(); // Foreign

            $table->float("unit_cost")->default(0);
            $table->float("srp")->default(0);

            $table->unsignedBigInteger("uom_id")->nullable(); // Foreign

            $table->string("odoo_code")->nullable();

            $table->unsignedBigInteger("production_id")->nullable(); // Foreign
            $table->enum("status", ["Active", "Discontinued"])->default("Active");

            $table->timestamps();


            /**
             * Foriegn Keys
             */
            $table->foreign("menu_tag_id")
            ->references("id")
            ->on("menu_tags")
            ->nullOnDelete()
            ->cascadeOnUpdate();

            $table->foreign("menu_category_id")
            ->references("id")
            ->on("menu_categories")
            ->nullOnDelete()
            ->cascadeOnUpdate();

            $table->foreign("menu_sub_category_id")
            ->references("id")
            ->on("menu_sub_categories")
            ->nullOnDelete()
            ->cascadeOnUpdate();

            $table->foreign("uom_id")
            ->references("id")
            ->on("menu_uoms")
            ->nullOnDelete()
            ->cascadeOnUpdate();

            $table->foreign("production_id")
            ->references("id")
            ->on("menu_productions")
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
