<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use OpenApi\Attributes as OA;

class AuthController extends Controller
{
    #[OA\Post(
        path: '/api/auth/login',
        summary: 'Login user',
        description: 'Autentikasi user dengan username dan password',
        tags: ['Auth'],
        requestBody: new OA\RequestBody(
            required: true,
            content: new OA\JsonContent(
                required: ['username', 'password'],
                properties: [
                    new OA\Property(property: 'username', type: 'string', example: 'admin', description: 'Username user'),
                    new OA\Property(property: 'password', type: 'string', format: 'password', example: 'admin123', description: 'Password user')
                ]
            )
        ),
        responses: [
            new OA\Response(
                response: 200,
                description: 'Login berhasil',
                content: new OA\JsonContent(
                    properties: [
                        new OA\Property(property: 'success', type: 'boolean', example: true),
                        new OA\Property(property: 'data', properties: [
                            new OA\Property(property: 'id', type: 'integer', example: 1),
                            new OA\Property(property: 'name', type: 'string', example: 'Administrator'),
                            new OA\Property(property: 'username', type: 'string', example: 'admin'),
                            new OA\Property(property: 'role', type: 'string', example: 'admin', enum: ['admin', 'operator', 'viewer']),
                            new OA\Property(property: 'unitKerja', type: 'string', example: 'Semua Unit'),
                            new OA\Property(property: 'token', type: 'string', example: '1|abc123xyz...')
                        ], type: 'object')
                    ]
                )
            ),
            new OA\Response(
                response: 401,
                description: 'Username atau password salah',
                content: new OA\JsonContent(
                    properties: [
                        new OA\Property(property: 'success', type: 'boolean', example: false),
                        new OA\Property(property: 'message', type: 'string', example: 'Username atau password salah')
                    ]
                )
            )
        ],
        security: []
    )]
    public function login(Request $request)
    {
        $request->validate([
            'username' => 'required|string',
            'password' => 'required|string',
        ]);

        $user = User::where('username', $request->username)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json([
                'success' => false,
                'message' => 'Username atau password salah',
            ], 401);
        }

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'success' => true,
            'data' => [
                'id'         => $user->id,
                'name'       => $user->name,
                'username'   => $user->username,
                'role'       => $user->role,
                'unit_kerja' => $user->unit_kerja,
                'token'      => $token,
            ],
        ]);
    }

    #[OA\Post(
        path: '/api/auth/logout',
        summary: 'Logout user',
        description: 'Logout user dan hapus token autentikasi',
        tags: ['Auth'],
        responses: [
            new OA\Response(
                response: 200,
                description: 'Logout berhasil',
                content: new OA\JsonContent(
                    properties: [
                        new OA\Property(property: 'success', type: 'boolean', example: true),
                        new OA\Property(property: 'message', type: 'string', example: 'Logout berhasil')
                    ]
                )
            )
        ],
    )]
    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'success' => true,
            'message' => 'Logout berhasil',
        ]);
    }

    #[OA\Post(
        path: '/api/auth/verify',
        summary: 'Verify token',
        description: 'Verifikasi token aktif dan dapat data user yang sedang login',
        tags: ['Auth'],
        responses: [
            new OA\Response(
                response: 200,
                description: 'Token valid',
                content: new OA\JsonContent(
                    properties: [
                        new OA\Property(property: 'success', type: 'boolean', example: true),
                        new OA\Property(property: 'data', properties: [
                            new OA\Property(property: 'id', type: 'integer', example: 1),
                            new OA\Property(property: 'name', type: 'string', example: 'Administrator'),
                            new OA\Property(property: 'username', type: 'string', example: 'admin'),
                            new OA\Property(property: 'role', type: 'string', example: 'admin'),
                            new OA\Property(property: 'unitKerja', type: 'string', example: 'Semua Unit')
                        ], type: 'object')
                    ]
                )
            )
        ],
    )]
    public function verify(Request $request)
    {
        return response()->json([
            'success' => true,
            'data'    => $request->user(),
        ]);
    }

    #[OA\Post(
        path: '/api/auth/profile',
        summary: 'Get profile',
        description: 'Mendapatkan data profile user yang sedang login',
        tags: ['Auth'],
        responses: [
            new OA\Response(
                response: 200,
                description: 'Data profile user',
                content: new OA\JsonContent(
                    properties: [
                        new OA\Property(property: 'success', type: 'boolean', example: true),
                        new OA\Property(property: 'data', properties: [
                            new OA\Property(property: 'id', type: 'integer', example: 1),
                            new OA\Property(property: 'name', type: 'string', example: 'Administrator'),
                            new OA\Property(property: 'username', type: 'string', example: 'admin'),
                            new OA\Property(property: 'role', type: 'string', example: 'admin'),
                            new OA\Property(property: 'unitKerja', type: 'string', example: 'Semua Unit')
                        ], type: 'object')
                    ]
                )
            )
        ],
    )]
    public function profile(Request $request)
    {
        return response()->json([
            'success' => true,
            'data'    => $request->user(),
        ]);
    }
}
