<?php

namespace App\Swagger;

use OpenApi\Attributes as OA;

#[OA\Info(
    title: 'SIMPEG API',
    version: '1.0.0',
    description: 'API Documentation untuk SIMPEG (Sistem Informasi Manajemen Pegawai) BIG - Badan Informasi Geospasial',
    contact: new OA\Contact(
        email: 'admin@big.go.id'
    ),
    license: new OA\License(
        name: 'Apache 2.0',
        url: 'https://www.apache.org/licenses/LICENSE-2.0.html'
    )
)]
#[OA\Server(
    url: 'http://localhost:8000',
    description: 'API Server'
)]
#[OA\SecurityScheme(
    securityScheme: 'sanctum',
    type: 'apiKey',
    description: 'Enter token in format (Bearer <token>)',
    name: 'Authorization',
    in: 'header',
)]
#[OA\Get(
    path: '/api/health',
    description: 'Health check endpoint',
    summary: 'Check API health',
    tags: ['Health'],
    responses: [
        new OA\Response(
            response: 200,
            description: 'OK'
        )
    ]
)]
class Swagger
{
}
