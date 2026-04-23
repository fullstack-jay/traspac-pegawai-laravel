<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Employee;
use App\Models\Agama;
use App\Models\UnitKerja;
use App\Models\Golongan;
use App\Models\Eselon;

class MigrateEmployeeDataSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $this->command->info('🔄 Migrating employee data to use foreign keys...');

        $employees = Employee::all();

        foreach ($employees as $employee) {
            // Find or create master data records
            $agama = Agama::where('nama', $employee->agama)->first();
            $unitKerja = UnitKerja::where('nama', $employee->unit_kerja)->first();
            $golongan = Golongan::where('nama', $employee->golongan)->first();
            $eselon = $employee->eselon ? Eselon::where('nama', $employee->eselon)->first() : null;

            // Update employee with foreign key IDs
            $employee->update([
                'agama_id' => $agama?->id,
                'unit_kerja_id' => $unitKerja?->id,
                'golongan_id' => $golongan?->id,
                'eselon_id' => $eselon?->id,
            ]);
        }

        $this->command->info('✅ Employee data migration completed!');
        $this->command->info('📊 Total employees migrated: ' . $employees->count());
    }
}
