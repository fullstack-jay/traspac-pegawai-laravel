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
        Schema::create('employees', function (Blueprint $table) {
            $table->id();
            $table->string('nip', 20)->unique();
            $table->string('nama', 100);
            $table->string('tempat_lahir', 50);
            $table->date('tanggal_lahir');
            $table->enum('jenis_kelamin', ['L', 'P']);
            $table->text('alamat');
            $table->string('golongan', 5);       // contoh: IV/e, III/a
            $table->string('eselon', 5)->nullable();
            $table->string('jabatan', 150);
            $table->string('tempat_tugas', 100);
            $table->string('agama', 20);
            $table->string('unit_kerja', 100);
            $table->string('no_hp', 20)->nullable();
            $table->string('npwp', 25)->nullable();
            $table->string('foto', 255)->nullable();
            $table->timestamps();
            $table->softDeletes();               // kolom deleted_at
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('employees');
    }
};
