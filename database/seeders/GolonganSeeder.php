<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Golongan;

class GolonganSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $golongans = [
            ['nama' => 'I/a', 'grade' => '1a', 'keterangan' => 'Golongan I/a'],
            ['nama' => 'I/b', 'grade' => '1b', 'keterangan' => 'Golongan I/b'],
            ['nama' => 'I/c', 'grade' => '1c', 'keterangan' => 'Golongan I/c'],
            ['nama' => 'I/d', 'grade' => '1d', 'keterangan' => 'Golongan I/d'],
            ['nama' => 'II/a', 'grade' => '2a', 'keterangan' => 'Golongan II/a'],
            ['nama' => 'II/b', 'grade' => '2b', 'keterangan' => 'Golongan II/b'],
            ['nama' => 'II/c', 'grade' => '2c', 'keterangan' => 'Golongan II/c'],
            ['nama' => 'II/d', 'grade' => '2d', 'keterangan' => 'Golongan II/d'],
            ['nama' => 'III/a', 'grade' => '3a', 'keterangan' => 'Golongan III/a'],
            ['nama' => 'III/b', 'grade' => '3b', 'keterangan' => 'Golongan III/b'],
            ['nama' => 'III/c', 'grade' => '3c', 'keterangan' => 'Golongan III/c'],
            ['nama' => 'III/d', 'grade' => '3d', 'keterangan' => 'Golongan III/d'],
            ['nama' => 'IV/a', 'grade' => '4a', 'keterangan' => 'Golongan IV/a'],
            ['nama' => 'IV/b', 'grade' => '4b', 'keterangan' => 'Golongan IV/b'],
            ['nama' => 'IV/c', 'grade' => '4c', 'keterangan' => 'Golongan IV/c'],
            ['nama' => 'IV/d', 'grade' => '4d', 'keterangan' => 'Golongan IV/d'],
            ['nama' => 'IV/e', 'grade' => '4e', 'keterangan' => 'Golongan IV/e'],
        ];

        foreach ($golongans as $data) {
            Golongan::firstOrCreate(
                ['nama' => $data['nama']],
                $data
            );
        }

        $this->command->info('✅ GolonganSeeder completed successfully!');
    }
}
