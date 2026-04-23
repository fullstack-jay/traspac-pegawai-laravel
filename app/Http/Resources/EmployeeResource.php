<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class EmployeeResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'nip' => $this->nip,
            'nama' => $this->nama,
            'tempatLahir' => $this->tempat_lahir,
            'tanggalLahir' => $this->tanggal_lahir,
            'jenisKelamin' => $this->jenis_kelamin,
            'alamat' => $this->alamat,
            'golongan' => $this->whenLoaded('golongan', fn() => [
                'id' => $this->golongan->id,
                'nama' => $this->golongan->nama,
                'grade' => $this->golongan->grade,
            ]),
            'eselon' => $this->whenLoaded('eselon', fn() => [
                'id' => $this->eselon?->id,
                'nama' => $this->eselon?->nama,
            ]),
            'jabatan' => $this->jabatan,
            'tempatTugas' => $this->tempat_tugas,
            'agama' => $this->whenLoaded('agama', fn() => [
                'id' => $this->agama->id,
                'nama' => $this->agama->nama,
            ]),
            'unitKerja' => $this->whenLoaded('unitKerja', fn() => [
                'id' => $this->unitKerja->id,
                'nama' => $this->unitKerja->nama,
                'kode' => $this->unitKerja->kode,
            ]),
            'noHp' => $this->no_hp,
            'npwp' => $this->npwp,
            'foto' => $this->foto,
            'createdAt' => $this->created_at,
            'updatedAt' => $this->updated_at,
        ];
    }
}
