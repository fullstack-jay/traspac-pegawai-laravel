<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Symfony\Component\HttpFoundation\Response;

class CamelCaseResponse
{
    /**
     * Handle an incoming request.
     *
     * @param  Closure(Request): (Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        $response = $next($request);

        // Only process JSON responses
        if ($response instanceof JsonResponse) {
            $data = $response->getData(true);
            $camelCaseData = $this->convertKeysToCamelCase($data);

            return response()->json(
                $camelCaseData,
                $response->status(),
                $response->headers->all()
            );
        }

        return $response;
    }

    /**
     * Convert array keys from snake_case to camelCase recursively
     */
    private function convertKeysToCamelCase($array): array
    {
        $result = [];

        foreach ($array as $key => $value) {
            // Convert key to camelCase
            $camelCaseKey = $this->toCamelCase($key);

            // Recursively convert nested arrays
            if (is_array($value)) {
                $result[$camelCaseKey] = $this->convertKeysToCamelCase($value);
            } else {
                $result[$camelCaseKey] = $value;
            }
        }

        return $result;
    }

    /**
     * Convert string from snake_case to camelCase
     */
    private function toCamelCase(string $string): string
    {
        // Don't modify if already camelCase or doesn't contain underscore
        if (!str_contains($string, '_')) {
            return $string;
        }

        return lcfirst(str_replace(' ', '', ucwords(str_replace('_', ' ', $string))));
    }
}
