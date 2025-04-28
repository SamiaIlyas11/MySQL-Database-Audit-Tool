<?php

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Route;

/*
|----------------------------------------------------------------------
| Web Routes
|----------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('/failed-logins-page', function () {
    // Fetch failed login records from the database
    $failedLogins = DB::select("SELECT * FROM failed_logins ORDER BY attempt_time DESC");

    // Return the data to a Blade view for display
    return view('failed-logins', ['failedLogins' => $failedLogins]);
});
