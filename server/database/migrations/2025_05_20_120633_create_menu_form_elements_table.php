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
        Schema::create('menu_form_elements', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("menu_shift_id")->nullable();
            $table->unsignedBigInteger("menu_class_id")->nullable();
            $table->timestamps();

            $table->foreign("menu_shift_id")
            ->references("id")
            ->on("menu_shifts")
            ->nullOnDelete()
            ->cascadeOnUpdate();

            $table->foreign("menu_class_id")
            ->references("id")
            ->on("menu_classes")
            ->nullOnDelete()
            ->cascadeOnUpdate();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('menu_form_elements');
    }
};
