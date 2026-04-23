<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Eselon;

class EselonSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $eselons = [
            ['nama' => 'I', 'keterangan' => 'Pejabat Pimpinan Tinggi Madya'],
            ['nama' => 'II', 'keterangan' => 'Pejabat Pimpinan Tinggi Pratama'],
            ['nama' => 'III', 'keterangan' => 'Pejabat Administrator'],
            ['nama' => 'IV', 'keterangan' => 'Pejabat Pengawas'],
        ];

        foreach ($eselons as $data) {
            Eselon::firstOrCreate(
                ['nama' => $data['nama']],
                $data
            );
        }

        $this->command->info('✅ EselonSeeder completed successfully!');
    }
}
