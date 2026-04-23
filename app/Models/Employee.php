<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class Employee extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'nip',
        'nama',
        'tempat_lahir',
        'tanggal_lahir',
        'jenis_kelamin',
        'alamat',
        'golongan',
        'eselon',
        'jabatan',
        'tempat_tugas',
        'agama',
        'unit_kerja',
        'no_hp',
        'npwp',
        'foto',
        // Foreign keys
        'agama_id',
        'unit_kerja_id',
        'golongan_id',
        'eselon_id',
    ];

    protected $casts = [
        'tanggal_lahir' => 'date:Y-m-d',
    ];

    /**
     * Relasi ke Agama
     */
    public function agama(): BelongsTo
    {
        return $this->belongsTo(Agama::class);
    }

    /**
     * Relasi ke UnitKerja
     */
    public function unitKerja(): BelongsTo
    {
        return $this->belongsTo(UnitKerja::class);
    }

    /**
     * Relasi ke Golongan
     */
    public function golongan(): BelongsTo
    {
        return $this->belongsTo(Golongan::class);
    }

    /**
     * Relasi ke Eselon
     */
    public function eselon(): BelongsTo
    {
        return $this->belongsTo(Eselon::class);
    }
}
