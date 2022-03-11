<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Review extends Model
{
    use HasFactory;

    protected $fillable = [
        'place_name',
        'address',
        'rating',
        'review',
        'latitude',
        'longitude'
    ];

    public function user() {
        return $this->belongsTo(User::class);
    }
}
