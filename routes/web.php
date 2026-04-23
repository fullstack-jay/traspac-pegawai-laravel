<?php

use Illuminate\Support\Facades\Route;

// API Root Endpoint
Route::get('/', function () {
    return response()->json([
        'success' => true,
        'message' => 'SIMPEG API is running 🚀',
        'version' => '1.0.0',
        'endpoints' => [
            'api_docs' => url('/docs'),
            'api_auth' => url('/api/auth/login'),
            'api_employees' => url('/api/employees/list'),
        ],
        'documentation' => url('/docs'),
    ]);
});

// Override L5-Swagger docs route untuk handle file JSON dengan path parameter
Route::get('/docs/{file}', function ($file = 'api-docs.json') {
    $filePath = public_path('docs/' . basename($file));

    if (!file_exists($filePath)) {
        abort(404, 'API documentation not found.');
    }

    $content = file_get_contents($filePath);
    return response($content)->header('Content-Type', 'application/json');
})->where('file', '.*')->name('swagger.docs.json');

