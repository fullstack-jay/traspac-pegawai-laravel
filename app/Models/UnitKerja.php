<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class UnitKerja extends Model
{
    protected $fillable = [
        'nama',
        'kode',
    ];

    /**
     * Relasi ke Employee
     */
    public function employees(): HasMany
    {
        return $this->hasMany(Employee::class);
    }
}
