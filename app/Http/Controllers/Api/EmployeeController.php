<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Employee;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use OpenApi\Attributes as OA;

class EmployeeController extends Controller
{
    #[OA\Post(
    path: "/api/employees/list",
    summary: "Daftar pegawai dengan pagination",
    description: "Mendapatkan daftar pegawai dengan filter, sorting, dan pagination",
    tags: ["Employees"],
    requestBody: new OA\RequestBody(
        required: false,
        content: new OA\JsonContent(
            properties: [
                new OA\Property(property: "search", type: "string", example: "saifulloh", description: "Pencarian berdasarkan nama, nip, jabatan, atau unit kerja"),
                new OA\Property(property: "unitKerja", type: "string", example: "Sekretariat Utama"),
                new OA\Property(property: "golongan", type: "string", example: "IV/e"),
                new OA\Property(property: "jenisKelamin", type: "string", example: "L", enum: ["L", "P"]),
                new OA\Property(property: "eselon", type: "string", example: "I"),
                new OA\Property(property: "sortColumn", type: "string", example: "id", description: "Kolom untuk sorting (id, nama, nip, golongan, eselon, jabatan, unitKerja, createdAt)"),
                new OA\Property(property: "sortColumnDir", type: "string", example: "asc", enum: ["asc", "desc"], description: "Arah sorting (asc/desc)"),
                new OA\Property(property: "pageNumber", type: "integer", example: 1, description: "Nomor halaman"),
                new OA\Property(property: "pageSize", type: "integer", example: 10, description: "Jumlah data per halaman")
            ]
        )
    ),
    responses: [
        new OA\Response(
            response: 200,
            description: "Data pegawai dengan pagination",
            content: new OA\JsonContent(
                properties: [
                    new OA\Property(property: "success", type: "boolean", example: true),
                    new OA\Property(
                        property: "data",
                        type: "array",
                        items: new OA\Items(
                            properties: [
                                new OA\Property(property: "no", type: "integer", example: 1, description: "Nomor urut"),
                                new OA\Property(property: "id", type: "integer", example: 1),
                                new OA\Property(property: "nip", type: "string", example: "197503152000031001"),
                                new OA\Property(property: "nama", type: "string", example: "Budi Santoso"),
                                new OA\Property(property: "jabatan", type: "string", example: "Kepala Sekretariat Utama"),
                                new OA\Property(property: "unitKerja", type: "string", example: "Sekretariat Utama"),
                                new OA\Property(property: "golongan", type: "string", example: "IV/e"),
                                new OA\Property(property: "jenisKelamin", type: "string", example: "L")
                            ],
                            type: "object"
                        )
                    ),
                    new OA\Property(property: "meta", type: "object",
                        properties: [
                            new OA\Property(property: "pageNumber", type: "integer", example: 1),
                            new OA\Property(property: "pageSize", type: "integer", example: 10),
                            new OA\Property(property: "total", type: "integer", example: 50),
                            new OA\Property(property: "totalPages", type: "integer", example: 5),
                            new OA\Property(property: "sortColumn", type: "string", example: "id"),
                            new OA\Property(property: "sortColumnDir", type: "string", example: "asc")
                        ]
                    )
                ]
            )
        )
    ],
)]
    public function list(Request $request)
    {
        $query = Employee::query();

        // Filter pencarian
        if ($request->filled('search')) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('nama', 'like', "%{$search}%")
                  ->orWhere('nip', 'like', "%{$search}%")
                  ->orWhere('jabatan', 'like', "%{$search}%")
                  ->orWhere('unit_kerja', 'like', "%{$search}%");
            });
        }

        if ($request->filled('unitKerja'))    $query->where('unit_kerja', $request->unitKerja);
        if ($request->filled('golongan'))      $query->where('golongan', $request->golongan);
        if ($request->filled('jenisKelamin')) $query->where('jenis_kelamin', $request->jenisKelamin);
        if ($request->filled('eselon'))        $query->where('eselon', $request->eselon);

        // Sorting
        $sortColumn = $request->input('sortColumn', 'id');
        $sortDirection = $request->input('sortColumnDir', 'asc');

        // Validate sort direction
        if (!in_array(strtolower($sortDirection), ['asc', 'desc'])) {
            $sortDirection = 'asc';
        }

        // Validasi sort column untuk SQL injection prevention
        $allowedColumns = ['id', 'nama', 'nip', 'golongan', 'eselon', 'jabatan', 'unit_kerja', 'created_at'];
        if (!in_array($sortColumn, $allowedColumns)) {
            $sortColumn = 'id';
        }

        $query->orderBy($sortColumn, $sortDirection);

        // Pagination parameters
        $pageNumber = $request->input('pageNumber', 1);
        $pageSize = $request->input('pageSize', 10);

        $paginated = $query->paginate($pageSize, ['*'], 'page', $pageNumber);

        // Add nomor urut to each item and reorder fields
        $items = $paginated->items();
        $total = $paginated->total();
        $dataWithNo = collect($items)->map(function ($item, $index) use ($pageNumber, $pageSize, $total, $sortDirection) {
            // Calculate nomor urut based on sort direction
            if (strtolower($sortDirection) === 'desc') {
                // DESC: Count down from total (20, 19, 18...)
                $no = $total - (($pageNumber - 1) * $pageSize + $index);
            } else {
                // ASC: Count up from 1 (1, 2, 3...)
                $no = ($pageNumber - 1) * $pageSize + $index + 1;
            }

            // Convert to array and reorder fields (no first)
            $itemArray = $item->toArray();
            $reordered = [
                'no' => $no,
            ];

            // Add all other fields except 'no'
            foreach ($itemArray as $key => $value) {
                if ($key !== 'no') {
                    $reordered[$key] = $value;
                }
            }

            return $reordered;
        });

        return response()->json([
            'success' => true,
            'data'    => $dataWithNo,
            'meta'    => [
                'pageNumber'  => $paginated->currentPage(),
                'pageSize'    => (int) $pageSize,
                'total'       => $paginated->total(),
                'totalPages'  => $paginated->lastPage(),
                'sortColumn'  => $sortColumn,
                'sortColumnDir' => strtolower($sortDirection),
            ],
        ]);
    }

    #[OA\Post(
    path: "/api/employees/all",
    summary: "Semua data pegawai",
    description: "Mendapatkan semua data pegawai tanpa pagination (untuk cetak/export)",
    tags: ["Employees"],
    requestBody: new OA\RequestBody(
        required: false,
        content: new OA\JsonContent(
            properties: [
                new OA\Property(property: "unitKerja", type: "string", example: "Sekretariat Utama"),
                new OA\Property(property: "golongan", type: "string", example: "IV/e"),
                new OA\Property(property: "jenisKelamin", type: "string", example: "L", enum: ["L", "P"])
            ]
        )
    ),
    responses: [
        new OA\Response(
            response: 200,
            description: "Semua data pegawai",
            content: new OA\JsonContent(
                properties: [
                    new OA\Property(property: "success", type: "boolean", example: true),
                    new OA\Property(
                        property: "data",
                        type: "array",
                        items: new OA\Items(type: "object")
                        )
                ]
            )
        )
    ],
)]
    public function all(Request $request)
    {
        $query = Employee::query();

        if ($request->filled('unitKerja'))    $query->where('unit_kerja', $request->unitKerja);
        if ($request->filled('golongan'))      $query->where('golongan', $request->golongan);
        if ($request->filled('jenisKelamin')) $query->where('jenis_kelamin', $request->jenisKelamin);

        $employees = $query->orderBy('nama')->get();

        return response()->json([
            'success' => true,
            'data'    => $employees,
        ]);
    }

    #[OA\Post(
    path: "/api/employees/detail",
    summary: "Detail pegawai",
    description: "Mendapatkan detail satu pegawai berdasarkan ID",
    tags: ["Employees"],
    requestBody: new OA\RequestBody(
        required: true,
        content: new OA\JsonContent(
            required: ["id"],
            properties: [
                new OA\Property(property: "id", type: "integer", example: 1, description: "ID pegawai")
            ]
        )
    ),
    responses: [
        new OA\Response(
            response: 200,
            description: "Detail pegawai",
            content: new OA\JsonContent(
                properties: [
                    new OA\Property(property: "success", type: "boolean", example: true),
                    new OA\Property(property: "data", type: "object")
                ]
            )
        ),
        new OA\Response(response: 404, description: "Pegawai tidak ditemukan")
    ],
)]
    public function detail(Request $request)
    {
        $request->validate([
            'id' => 'required|integer|exists:employees,id',
        ]);

        $employee = Employee::findOrFail($request->id);

        return response()->json([
            'success' => true,
            'data'    => $employee,
        ]);
    }

    #[OA\Post(
    path: "/api/employees/create",
    summary: "Tambah pegawai baru",
    description: "Menambahkan data pegawai baru",
    tags: ["Employees"],
    requestBody: new OA\RequestBody(
        required: true,
        content: new OA\JsonContent(
            required: ["nip", "nama", "tempatLahir", "tanggalLahir", "jenisKelamin", "alamat", "golongan", "jabatan", "tempatTugas", "agama", "unitKerja"],
            properties: [
                new OA\Property(property: "nip", type: "string", maxLength: 20, example: "19680315199003001"),
                new OA\Property(property: "nama", type: "string", maxLength: 100, example: "Saifulloh Rifai"),
                new OA\Property(property: "tempatLahir", type: "string", maxLength: 50, example: "Banjarnegara"),
                new OA\Property(property: "tanggalLahir", type: "string", format: "date", example: "1968-03-15"),
                new OA\Property(property: "jenisKelamin", type: "string", enum: ["L", "P"], example: "L"),
                new OA\Property(property: "alamat", type: "string", example: "Jl. Melon No.16 Dian Asri"),
                new OA\Property(property: "golongan", type: "string", maxLength: 5, example: "IV/e"),
                new OA\Property(property: "eselon", type: "string", maxLength: 5, example: "I"),
                new OA\Property(property: "jabatan", type: "string", maxLength: 150, example: "Kepala Sekretariat Utama"),
                new OA\Property(property: "tempatTugas", type: "string", maxLength: 100, example: "Jakarta"),
                new OA\Property(property: "agama", type: "string", maxLength: 20, example: "Islam"),
                new OA\Property(property: "unitKerja", type: "string", maxLength: 100, example: "Sekretariat Utama"),
                new OA\Property(property: "noHp", type: "string", maxLength: 20, example: "081234567890"),
                new OA\Property(property: "npwp", type: "string", maxLength: 25, example: "12.345.678.9-001.000"),
                new OA\Property(property: "foto", type: "string", example: "http://localhost:8000/storage/photos/abc.jpg")
            ]
        )
    ),
    responses: [
        new OA\Response(
            response: 201,
            description: "Data pegawai berhasil ditambahkan",
            content: new OA\JsonContent(
                properties: [
                    new OA\Property(property: "success", type: "boolean", example: true),
                    new OA\Property(property: "message", type: "string", example: "Data pegawai berhasil ditambahkan"),
                    new OA\Property(property: "data", type: "object",
                        properties: [
                            new OA\Property(property: "id", type: "integer", example: 1),
                            new OA\Property(property: "nip", type: "string", example: "19680315199003001"),
                            new OA\Property(property: "nama", type: "string", example: "Saifulloh Rifai"),
                            new OA\Property(property: "tempatLahir", type: "string", example: "Banjarnegara"),
                            new OA\Property(property: "tanggalLahir", type: "string", format: "date", example: "1968-03-15"),
                            new OA\Property(property: "jenisKelamin", type: "string", enum: ["L", "P"], example: "L"),
                            new OA\Property(property: "alamat", type: "string", example: "Jl. Melon No.16 Dian Asri"),
                            new OA\Property(property: "golongan", type: "string", example: "IV/e"),
                            new OA\Property(property: "eselon", type: "string", example: "I"),
                            new OA\Property(property: "jabatan", type: "string", example: "Kepala Sekretariat Utama"),
                            new OA\Property(property: "tempatTugas", type: "string", example: "Jakarta"),
                            new OA\Property(property: "agama", type: "string", example: "Islam"),
                            new OA\Property(property: "unitKerja", type: "string", example: "Sekretariat Utama"),
                            new OA\Property(property: "noHp", type: "string", example: "081234567890"),
                            new OA\Property(property: "npwp", type: "string", example: "12.345.678.9-001.000"),
                            new OA\Property(property: "foto", type: "string", example: "http://localhost:8000/storage/photos/abc.jpg")
                        ])
                ]
            )
        ),
        new OA\Response(response: 422, description: "Validasi gagal")
    ],
)]
    public function create(Request $request)
    {
        // Validate using camelCase (frontend format)
        $validated = $request->validate([
            'nip'           => 'required|string|max:20|unique:employees,nip',
            'nama'          => 'required|string|max:100',
            'tempatLahir'   => 'required|string|max:50',
            'tanggalLahir'  => 'required|date',
            'jenisKelamin'  => 'required|in:L,P',
            'alamat'        => 'required|string',
            'golongan'      => 'required|string|max:5',
            'eselon'        => 'nullable|string|max:5',
            'jabatan'       => 'required|string|max:150',
            'tempatTugas'   => 'required|string|max:100',
            'agama'         => 'required|string|max:20',
            'unitKerja'     => 'required|string|max:100',
            'noHp'          => 'nullable|string|max:20',
            'npwp'          => 'nullable|string|max:25',
            'foto'          => 'nullable|string',
        ]);

        // Convert camelCase to snake_case for database
        $dbData = $this->convertToSnakeCase($validated);
        $employee = Employee::create($dbData);

        return response()->json([
            'success' => true,
            'message' => 'Data pegawai berhasil ditambahkan',
            'data'    => $employee,
        ], 201);
    }

    #[OA\Post(
    path: "/api/employees/update",
    summary: "Update data pegawai",
    description: "Mengupdate data pegawai yang sudah ada",
    tags: ["Employees"],
    requestBody: new OA\RequestBody(
        required: true,
        content: new OA\JsonContent(
            required: ["id"],
            properties: [
                new OA\Property(property: "id", type: "integer", example: 1),
                new OA\Property(property: "nip", type: "string", maxLength: 20, example: "19680315199003001"),
                new OA\Property(property: "nama", type: "string", maxLength: 100, example: "Saifulloh Rifai"),
                new OA\Property(property: "tempatLahir", type: "string", maxLength: 50, example: "Banjarnegara"),
                new OA\Property(property: "tanggalLahir", type: "string", format: "date", example: "1968-03-15"),
                new OA\Property(property: "jenisKelamin", type: "string", enum: ["L", "P"], example: "L"),
                new OA\Property(property: "alamat", type: "string", example: "Jl. Melon No.16 Dian Asri"),
                new OA\Property(property: "golongan", type: "string", maxLength: 5, example: "IV/e"),
                new OA\Property(property: "eselon", type: "string", maxLength: 5, example: "I"),
                new OA\Property(property: "jabatan", type: "string", maxLength: 150, example: "Kepala Sekretariat Utama"),
                new OA\Property(property: "tempatTugas", type: "string", maxLength: 100, example: "Jakarta"),
                new OA\Property(property: "agama", type: "string", maxLength: 20, example: "Islam"),
                new OA\Property(property: "unitKerja", type: "string", maxLength: 100, example: "Sekretariat Utama"),
                new OA\Property(property: "noHp", type: "string", maxLength: 20, example: "081234567890"),
                new OA\Property(property: "npwp", type: "string", maxLength: 25, example: "12.345.678.9-001.000"),
                new OA\Property(property: "foto", type: "string", example: "http://localhost:8000/storage/photos/abc.jpg")
            ]
        )
    ),
    responses: [
        new OA\Response(
            response: 200,
            description: "Data pegawai berhasil diperbarui",
            content: new OA\JsonContent(
                properties: [
                    new OA\Property(property: "success", type: "boolean", example: true),
                    new OA\Property(property: "message", type: "string", example: "Data pegawai berhasil diperbarui"),
                    new OA\Property(property: "data", type: "object",
                        properties: [
                            new OA\Property(property: "id", type: "integer", example: 1),
                            new OA\Property(property: "nip", type: "string", example: "19680315199003001"),
                            new OA\Property(property: "nama", type: "string", example: "Saifulloh Rifai"),
                            new OA\Property(property: "tempatLahir", type: "string", example: "Banjarnegara"),
                            new OA\Property(property: "tanggalLahir", type: "string", format: "date", example: "1968-03-15"),
                            new OA\Property(property: "jenisKelamin", type: "string", enum: ["L", "P"], example: "L"),
                            new OA\Property(property: "alamat", type: "string", example: "Jl. Melon No.16 Dian Asri"),
                            new OA\Property(property: "golongan", type: "string", example: "IV/e"),
                            new OA\Property(property: "eselon", type: "string", example: "I"),
                            new OA\Property(property: "jabatan", type: "string", example: "Kepala Sekretariat Utama"),
                            new OA\Property(property: "tempatTugas", type: "string", example: "Jakarta"),
                            new OA\Property(property: "agama", type: "string", example: "Islam"),
                            new OA\Property(property: "unitKerja", type: "string", example: "Sekretariat Utama"),
                            new OA\Property(property: "noHp", type: "string", example: "081234567890"),
                            new OA\Property(property: "npwp", type: "string", example: "12.345.678.9-001.000"),
                            new OA\Property(property: "foto", type: "string", example: "http://localhost:8000/storage/photos/abc.jpg")
                        ])
                ]
            )
        ),
        new OA\Response(response: 404, description: "Pegawai tidak ditemukan"),
        new OA\Response(response: 422, description: "Validasi gagal")
    ],
)]
    public function update(Request $request)
    {
        $request->validate([
            'id' => 'required|integer|exists:employees,id',
        ]);

        $employee = Employee::findOrFail($request->id);

        // Validate using camelCase (frontend format)
        $validated = $request->validate([
            'nip'           => 'sometimes|string|max:20|unique:employees,nip,' . $employee->id,
            'nama'          => 'sometimes|string|max:100',
            'tempatLahir'   => 'sometimes|string|max:50',
            'tanggalLahir'  => 'sometimes|date',
            'jenisKelamin'  => 'sometimes|in:L,P',
            'alamat'        => 'sometimes|string',
            'golongan'      => 'sometimes|string|max:5',
            'eselon'        => 'nullable|string|max:5',
            'jabatan'       => 'sometimes|string|max:150',
            'tempatTugas'   => 'sometimes|string|max:100',
            'agama'         => 'sometimes|string|max:20',
            'unitKerja'     => 'sometimes|string|max:100',
            'noHp'          => 'nullable|string|max:20',
            'npwp'          => 'nullable|string|max:25',
            'foto'          => 'nullable|string',
        ]);

        // Convert camelCase to snake_case for database
        $dbData = $this->convertToSnakeCase($validated);
        $employee->update($dbData);

        return response()->json([
            'success' => true,
            'message' => 'Data pegawai berhasil diperbarui',
            'data'    => $employee->fresh(),
        ]);
    }

    #[OA\Post(
    path: "/api/employees/delete",
    summary: "Hapus pegawai",
    description: "Menghapus data pegawai (soft delete)",
    tags: ["Employees"],
    requestBody: new OA\RequestBody(
        required: true,
        content: new OA\JsonContent(
            required: ["id"],
            properties: [
                new OA\Property(property: "id", type: "integer", example: 1, description: "ID pegawai")
            ]
        )
    ),
    responses: [
        new OA\Response(
            response: 200,
            description: "Data pegawai berhasil dihapus",
            content: new OA\JsonContent(
                properties: [
                    new OA\Property(property: "success", type: "boolean", example: true),
                    new OA\Property(property: "message", type: "string", example: "Data pegawai berhasil dihapus")
                ]
            )
        ),
        new OA\Response(response: 404, description: "Pegawai tidak ditemukan")
    ],
)]
    public function delete(Request $request)
    {
        $request->validate([
            'id' => 'required|integer|exists:employees,id',
        ]);

        $employee = Employee::findOrFail($request->id);

        // Hapus foto dari S3 jika ada
        if ($employee->foto) {
            // Ekstrak filename dari URL S3
            $filename = basename($employee->foto);
            $path = 'photos/' . $filename;

            if (Storage::disk('s3')->exists($path)) {
                Storage::disk('s3')->delete($path);
            }
        }

        $employee->delete(); // soft delete

        return response()->json([
            'success' => true,
            'message' => 'Data pegawai berhasil dihapus',
        ]);
    }

    #[OA\Post(
    path: "/api/employees/units",
    summary: "List unit kerja",
    description: "Mendapatkan daftar unit kerja unik",
    tags: ["Employees"],
    responses: [
        new OA\Response(
            response: 200,
            description: "Daftar unit kerja",
            content: new OA\JsonContent(
                properties: [
                    new OA\Property(property: "success", type: "boolean", example: true),
                    new OA\Property(
                        property: "data",
                        type: "array",
                        items: new OA\Items(type: "string", example: "Sekretariat Utama")
                        )
                ]
            )
        )
    ],
)]
    public function units(Request $request)
    {
        $units = Employee::select('unit_kerja')
            ->distinct()
            ->orderBy('unit_kerja')
            ->pluck('unit_kerja');

        return response()->json([
            'success' => true,
            'data'    => $units,
        ]);
    }

    /**
     * Convert camelCase array keys to snake_case for database
     */
    private function convertToSnakeCase(array $data): array
    {
        $camelToSnakeMap = [
            'tempatLahir'  => 'tempat_lahir',
            'tanggalLahir' => 'tanggal_lahir',
            'jenisKelamin' => 'jenis_kelamin',
            'tempatTugas'  => 'tempat_tugas',
            'unitKerja'    => 'unit_kerja',
            'noHp'         => 'no_hp',
        ];

        $result = [];
        foreach ($data as $key => $value) {
            // Convert known camelCase keys to snake_case
            $newKey = $camelToSnakeMap[$key] ?? $key;
            $result[$newKey] = $value;
        }

        return $result;
    }
}
