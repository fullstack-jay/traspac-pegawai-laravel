<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Golongan extends Model
{
    protected $fillable = [
        'nama',
        'grade',
        'keterangan',
    ];

    /**
     * Relasi ke Employee
     */
    public function employees(): HasMany
    {
        return $this->hasMany(Employee::class);
    }
}
