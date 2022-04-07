<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Review extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $fillable = [
        'nama_tempat',
        'alamat',
        'rating',
        'review',
        'latitude',
        'longitude',
        'photo',
        'user_id'
    ];

    public function user() {
        return $this->belongsTo(User::class);
    }

    public function komentar() {
        return $this->hasMany(Komentar::class);
    }
}
