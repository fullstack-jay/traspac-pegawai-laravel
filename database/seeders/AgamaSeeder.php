<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Agama;

class AgamaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $agamas = ['Islam', 'Kristen', 'Katolik', 'Hindu', 'Buddha', 'Konghucu'];

        foreach ($agamas as $nama) {
            Agama::firstOrCreate(
                ['nama' => $nama],
                ['nama' => $nama]
            );
        }

        $this->command->info('✅ AgamaSeeder completed successfully!');
    }
}
