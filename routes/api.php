<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\EmployeeController;
use App\Http\Controllers\Api\UploadController;
use Illuminate\Support\Facades\DB;

// ─────────────────────────────────────────────────────────
//  AUTH SERVICE
// ─────────────────────────────────────────────────────────
Route::prefix('auth')->group(function () {
    Route::post('/login',   [AuthController::class, 'login']);
    Route::post('/logout',  [AuthController::class, 'logout'])->middleware('auth:sanctum');
    Route::post('/verify',  [AuthController::class, 'verify'])->middleware('auth:sanctum');
    Route::post('/profile', [AuthController::class, 'profile'])->middleware('auth:sanctum');
});

// ─────────────────────────────────────────────────────────
//  MASTER DATA SERVICE (Direct from master tables)
// ─────────────────────────────────────────────────────────
Route::middleware('auth:sanctum')->prefix('master')->group(function () {
    Route::post('/unit-kerjas', function () {
        return response()->json([
            'success' => true,
            'data' => DB::table('unit_kerjas')->orderBy('nama')->get(['id', 'nama', 'kode'])
        ]);
    });

    Route::post('/agamas', function () {
        return response()->json([
            'success' => true,
            'data' => DB::table('agamas')->orderBy('nama')->get(['id', 'nama'])
        ]);
    });

    Route::post('/golongans', function () {
        return response()->json([
            'success' => true,
            'data' => DB::table('golongans')->orderBy('nama')->get(['id', 'nama', 'grade', 'keterangan'])
        ]);
    });

    Route::post('/eselons', function () {
        return response()->json([
            'success' => true,
            'data' => DB::table('eselons')->orderBy('nama')->get(['id', 'nama', 'keterangan'])
        ]);
    });
});

// ─────────────────────────────────────────────────────────
//  EMPLOYEE SERVICE
// ─────────────────────────────────────────────────────────
Route::middleware('auth:sanctum')->prefix('employees')->group(function () {
    Route::post('/list',   [EmployeeController::class, 'list']);    // daftar + filter + pagination
    Route::post('/all',    [EmployeeController::class, 'all']);     // semua data (untuk cetak)
    Route::post('/detail', [EmployeeController::class, 'detail']); // detail by id
    Route::post('/create', [EmployeeController::class, 'create']); // tambah pegawai
    Route::post('/update', [EmployeeController::class, 'update']); // ubah pegawai
    Route::post('/delete', [EmployeeController::class, 'delete']); // hapus pegawai
    Route::post('/units',  [EmployeeController::class, 'units']);  // list unit kerja (deprecated - use /master/unit-kerjas)
});

// ─────────────────────────────────────────────────────────
//  UPLOAD SERVICE
// ─────────────────────────────────────────────────────────
Route::middleware('auth:sanctum')->prefix('upload')->group(function () {
    Route::post('/photo',        [UploadController::class, 'uploadPhoto']);
    Route::post('/photo/delete', [UploadController::class, 'deletePhoto']);
});
