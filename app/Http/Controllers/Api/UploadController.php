<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use OpenApi\Attributes as OA;

class UploadController extends Controller
{
    #[OA\Post(
        path: "/api/upload/photo",
        summary: "Upload foto pegawai",
        description: "Upload foto pegawai (jpg/png, max 2MB)",
        tags: ["Upload"],
        requestBody: new OA\RequestBody(
            required: true,
            content: new OA\MediaType(
                mediaType: "multipart/form-data",
                schema: new OA\Schema(
                    required: ["file"],
                    properties: [
                        new OA\Property(property: "file", type: "string", format: "binary", description: "File gambar (jpg/png, max 2MB)"),
                        new OA\Property(property: "employee_id", type: "integer", example: 1, description: "ID pegawai (opsional)")
                    ]
                )
            )
        ),
        responses: [
            new OA\Response(
                response: 200,
                description: "Foto berhasil diupload",
                content: new OA\JsonContent(
                    properties: [
                        new OA\Property(property: "success", type: "boolean", example: true),
                        new OA\Property(property: "data", type: "object",
                            properties: [
                                new OA\Property(property: "url", type: "string", example: "http://localhost:8000/storage/photos/uuid-filename.jpg"),
                                new OA\Property(property: "filename", type: "string", example: "uuid-filename.jpg")
                            ]
                        )
                    ]
                )
            ),
            new OA\Response(response: 422, description: "Validasi gagal")
        ],
    )]
    public function uploadPhoto(Request $request)
    {
        try {
            $request->validate([
                'file'        => 'required|image|mimes:jpg,jpeg,png|max:2048', // max 2MB
                'employee_id' => 'nullable|integer',
            ]);

            $file     = $request->file('file');
            $filename = Str::uuid() . '.' . $file->getClientOriginalExtension();

            // Upload ke S3/R2 dengan visibility public
            $path = Storage::disk('s3')->putFileAs('photos', $file, $filename, 'public');

            // Generate URL yang lengkap dengan path file
            $url = env('AWS_URL') . '/photos/' . $filename;

            return response()->json([
                'success' => true,
                'data'    => [
                    'url'      => $url,
                    'filename' => $filename,
                ],
            ], 200);

        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Validasi gagal',
                'errors'  => $e->errors(),
            ], 422);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Gagal upload foto: ' . $e->getMessage(),
            ], 500);
        }
    }

    #[OA\Post(
        path: "/api/upload/photo/delete",
        summary: "Hapus foto pegawai",
        description: "Menghapus foto pegawai berdasarkan URL",
        tags: ["Upload"],
        requestBody: new OA\RequestBody(
            required: true,
            content: new OA\JsonContent(
                required: ["url"],
                properties: [
                    new OA\Property(property: "url", type: "string", example: "http://localhost:8000/storage/photos/uuid-filename.jpg", description: "URL foto yang akan dihapus")
                ]
            )
        ),
        responses: [
            new OA\Response(
                response: 200,
                description: "Foto berhasil dihapus",
                content: new OA\JsonContent(
                    properties: [
                        new OA\Property(property: "success", type: "boolean", example: true),
                        new OA\Property(property: "message", type: "string", example: "Foto berhasil dihapus")
                    ]
                )
            ),
            new OA\Response(response: 422, description: "Validasi gagal")
        ],
    )]
    public function deletePhoto(Request $request)
    {
        $request->validate([
            'url' => 'required|string',
        ]);

        // Ekstrak path dari URL
        $path = 'photos/' . basename($request->url);

        if (Storage::disk('s3')->exists($path)) {
            Storage::disk('s3')->delete($path);
        }

        return response()->json([
            'success' => true,
            'message' => 'Foto berhasil dihapus',
        ]);
    }
}
