<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ScanDetection extends Model
{
    use HasFactory;
    protected $fillable = [
        'name',
        'label',
        'confidence',
        'image_path',
        'created_at',
        'updated_at',
    ];

    protected $casts = [
        'confidence' => 'float',
    ];
}