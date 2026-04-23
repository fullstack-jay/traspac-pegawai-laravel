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
        Schema::create('golongans', function (Blueprint $table) {
            $table->id();
            $table->string('nama', 5)->unique(); // I/a, I/b, II/a, II/b, III/a, III/b, III/c, III/d, IV/a, IV/b, IV/c, IV/d, IV/e
            $table->string('grade', 10)->nullable(); // Grade angka (opsional)
            $table->string('keterangan', 100)->nullable(); // Keterangan golongan
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('golongans');
    }
};
