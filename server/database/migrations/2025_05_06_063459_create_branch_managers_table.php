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
        Schema::create('branch_managers', function (Blueprint $table) {
            $table->string("id", 20)->primary();
            $table->string("branch_id", 20)->nullable();
            $table->string("fname", 50);
            $table->string("mname", 50)->nullable();
            $table->string("lname", 50);
            $table->string("username", 50)->unique();
            $table->string("password");
            $table->string("email", 50)->unique();
            $table->enum("status", ["Active", "Suspended", "Deleted"])->default("Active");
            $table->timestamps();

            /**
             * Foreign Keys
             */
            $table->foreign("branch_id")
            ->references("id")
            ->on("branches")
            ->nullOnDelete()
            ->cascadeOnUpdate();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('branch_managers');
    }
};
