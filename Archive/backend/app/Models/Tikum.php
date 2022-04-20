<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Foundation\Auth\User;
use Illuminate\Database\Eloquent\SoftDeletes;

class Tikum extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $fillable = [
        'tempat_tujuan',
        'tempat_kumpul',
        'waktu_kumpul',
        'link_group',
        'deskripsi',
        'user_id'
    ];

    public function user() {
        return $this->belongsTo(User::class);
    }
}
