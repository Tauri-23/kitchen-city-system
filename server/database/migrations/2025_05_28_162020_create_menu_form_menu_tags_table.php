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
        Schema::create('menu_form_menu_tags', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("menu_form_class_id");
            $table->unsignedBigInteger("menu_tag_id");
            $table->timestamps();

            /**
             * Forien Key
             */
            $table->foreign("menu_form_class_id")
            ->references("id")
            ->on("menu_form_classes")
            ->cascadeOnDelete()
            ->cascadeOnUpdate();

            $table->foreign("menu_tag_id")
            ->references("id")
            ->on("menu_tags")
            ->cascadeOnDelete()
            ->cascadeOnUpdate();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('menu_form_menu_tags');
    }
};
