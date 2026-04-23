<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
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

