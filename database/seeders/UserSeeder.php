<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        $users = [
            [
                'name'       => 'Administrator',
                'username'   => 'admin',
                'password'   => Hash::make('admin123'),
                'role'       => 'admin',
                'unit_kerja' => 'Semua Unit',
            ],
            [
                'name'       => 'Operator BKN',
                'username'   => 'operator',
                'password'   => Hash::make('operator123'),
                'role'       => 'operator',
                'unit_kerja' => 'Biro Kepegawaian',
            ],
            [
                'name'       => 'Viewer',
                'username'   => 'viewer',
                'password'   => Hash::make('viewer123'),
                'role'       => 'viewer',
                'unit_kerja' => 'Biro Umum',
            ],
        ];

        foreach ($users as $user) {
            User::updateOrCreate(['username' => $user['username']], $user);
        }
    }
}
