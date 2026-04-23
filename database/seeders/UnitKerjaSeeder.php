<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\UnitKerja;

class UnitKerjaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $unitKerjas = [
            ['nama' => 'Sekretariat Utama', 'kode' => 'SET'],
            ['nama' => 'Pusat Data Geospasial', 'kode' => 'PDG'],
            ['nama' => 'Pusat Pengembangan Standar', 'kode' => 'PPS'],
            ['nama' => 'Pusat Informasi Geospasial', 'kode' => 'PIG'],
            ['nama' => 'Pusat Restorasi', 'kode' => 'PR'],
            ['nama' => 'Pusat Survei Kependudukan', 'kode' => 'PSK'],
            ['nama' => 'Pusat Pemetaan Dasar', 'kode' => 'PPD'],
        ];

        foreach ($unitKerjas as $data) {
            UnitKerja::firstOrCreate(
                ['nama' => $data['nama']],
                $data
            );
        }

        $this->command->info('✅ UnitKerjaSeeder completed successfully!');
    }
}
