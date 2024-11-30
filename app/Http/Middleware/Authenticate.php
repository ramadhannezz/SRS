<?php

// app/Http/Middleware/Authenticate.php

namespace App\Http\Middleware;

use Illuminate\Auth\Middleware\Authenticate as Middleware;
use Illuminate\Http\Request;

class Authenticate extends Middleware
{
    protected function redirectTo(Request $request): ?string
    {
        if (!$request->expectsJson()) {
            return route('login');
        }
    }

    public function handle($request, \Closure $next, ...$guards)
    {
        $this->authenticate($request, $guards);

        if ($this->auth->guard()->guest()) {
            if ($request->expectsJson()) {
                return response()->json(['message' => 'Unauthenticated.'], 401);
            } else {
                return redirect()->guest(route('login'));
            }
        }

        return $next($request);
    }
}
