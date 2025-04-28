<?php

use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/
Route::post('/login', [AuthController::class, 'login']);

Route::get('/logs', function () {
    return response()->json(DB::select("SELECT * FROM audit_logs ORDER BY event_time DESC"));
});

Route::post('/failed-login', function (Request $request) {
    DB::table('failed_logins')->insert([
        'username' => $request->username,
        'host' => $request->ip(),
    ]);

    return response()->json(['message' => 'Failed login recorded.']);
});

Route::get('/failed-logins', function () {
    return response()->json(DB::select("SELECT * FROM failed_logins ORDER BY attempt_time DESC"));
});

// RBAC

// Secured route to get authenticated user details
Route::middleware(['auth:sanctum'])->get('/user', function (Request $request) {
   return $request->user();
});

// Secured route to fetch audit logs
Route::middleware('auth:sanctum')->get('/logs', function () {
   // Fetch and return the audit logs from the database   
   return response()->json(DB::select("SELECT * FROM audit_logs ORDER BY event_time DESC"));
});

Route::middleware('auth:sanctum')->get('/protected', function () {
   return response()->json(['message' => 'This is a protected route']);
});

// Route accessible only to 'admin' users
Route::middleware(['auth:sanctum', 'role:admin'])->get('/admin', function () {
   return response()->json(['message' => 'Welcome, admin!']);
});

// Route accessible only to 'auditor' users
Route::middleware(['auth:sanctum', 'role:auditor'])->get('/auditor', function () {
   return response()->json(['message' => 'Welcome, auditor!']);
});

// Route accessible only to 'viewer' users
Route::middleware(['auth:sanctum', 'role:viewer'])->get('/viewer', function () {
   return response()->json(['message' => 'Welcome, viewer!']);
});
