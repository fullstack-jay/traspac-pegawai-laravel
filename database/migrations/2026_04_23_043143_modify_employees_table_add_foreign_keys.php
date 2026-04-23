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
        Schema::table('employees', function (Blueprint $table) {
            // Add foreign key columns (nullable first for smooth migration)
            $table->foreignId('agama_id')->nullable()->after('agama')->constrained('agamas')->nullOnDelete();
            $table->foreignId('unit_kerja_id')->nullable()->after('unit_kerja')->constrained('unit_kerjas')->nullOnDelete();
            $table->foreignId('golongan_id')->nullable()->after('golongan')->constrained('golongans')->nullOnDelete();
            $table->foreignId('eselon_id')->nullable()->after('eselon')->constrained('eselons')->nullOnDelete();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('employees', function (Blueprint $table) {
            $table->dropForeign(['agama_id']);
            $table->dropForeign(['unit_kerja_id']);
            $table->dropForeign(['golongan_id']);
            $table->dropForeign(['eselon_id']);

            $table->dropColumn(['agama_id', 'unit_kerja_id', 'golongan_id', 'eselon_id']);
        });
    }
};
