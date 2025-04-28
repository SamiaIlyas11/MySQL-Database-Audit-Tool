<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class RoleMiddleware
{
    public function handle(Request $request, Closure $next, $role)
    {
        // Check if the user is authenticated and if their role matches the required role
        if (auth()->check() && auth()->user()->role === $role) {
            return $next($request);
        }

        // If the role does not match, return an unauthorized response
        return response()->json(['message' => 'Unauthorized'], 403);
    }
}

