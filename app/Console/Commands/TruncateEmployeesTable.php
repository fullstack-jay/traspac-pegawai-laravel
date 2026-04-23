<?php

namespace App\Console\Commands;

use Illuminate\Console\Attributes\Description;
use Illuminate\Console\Attributes\Signature;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

#[Signature('truncate:employees')]
#[Description('Truncate employees table (delete all data)')]
class TruncateEmployeesTable extends Command
{
    /**
     * Execute the console command.
     */
    public function handle(): int
    {
        $this->info('⚠️  WARNING: This will DELETE ALL data from employees table!');
        $this->newLine();

        if (!$this->confirm('Are you sure you want to truncate the employees table?')) {
            $this->info('❌ Operation cancelled.');
            return self::SUCCESS;
        }

        try {
            // Disable foreign key checks temporarily
            DB::statement('SET CONSTRAINTS ALL DEFERRED');

            // Truncate the table
            DB::table('employees')->truncate();

            // Reset auto-increment
            if (Schema::hasTable('employees')) {
                DB::statement("ALTER SEQUENCE employees_id_seq RESTART WITH 1");
            }

            $this->info('✅ Employees table truncated successfully!');
            $this->info('📊 All employee data has been deleted.');
            $this->newLine();
            $this->info('💡 Run seeders to populate data again:');
            $this->warn('   php artisan db:seed --class=EmployeeSeeder');

            return self::SUCCESS;

        } catch (\Exception $e) {
            $this->error('❌ Failed to truncate employees table!');
            $this->error('Error: ' . $e->getMessage());
            return self::FAILURE;
        }
    }
}
