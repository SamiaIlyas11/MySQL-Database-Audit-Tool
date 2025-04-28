<?php

namespace App\Console;

use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;

class Kernel extends ConsoleKernel
{
    /**
     * Define the application's command schedule.
     *
     * @param  \Illuminate\Console\Scheduling\Schedule  $schedule
     * @return void
     */
    protected function schedule(Schedule $schedule)
    {
        // Schedule the 'process:slowqueries' command to run every 5 minutes
        $schedule->command('process:slowqueries')->everyFiveMinutes();
    }

    /**
     * Register the commands for the application.
     *
     * @return void
     */
    protected function commands()
    {
        $this->load(__DIR__.'/Commands');

        require base_path('routes/console.php');
    }

    /**
     * Register the application's route middleware.
     *
     * @return void
     */
    protected function routeMiddleware()
    {
        $this->middlewareGroups = [
            'role' => \App\Http\Middleware\RoleMiddleware::class,
        ];
    }
}
