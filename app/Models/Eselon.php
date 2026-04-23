<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Eselon extends Model
{
    protected $fillable = [
        'nama',
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
