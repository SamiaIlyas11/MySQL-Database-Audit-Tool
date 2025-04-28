<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;

class UserSeeder extends Seeder
{
    public function run()
    {
        DB::table('users')->insert([
            [
                'username' => 'admin_user',
                'email' => 'admin_user@example.com', // Add email
                'password' => Hash::make('adminpass'),
                'role' => 'admin',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'username' => 'auditor_user',
                'email' => 'auditor_user@example.com', // Add email
                'password' => Hash::make('auditorpass'),
                'role' => 'auditor',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'username' => 'viewer_user',
                'email' => 'viewer_user@example.com', // Add email
                'password' => Hash::make('viewerpass'),
                'role' => 'viewer',
                'created_at' => now(),
                'updated_at' => now(),
            ]
        ]);
    }
}
