<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Komentar extends Model
{
    use HasFactory;

    protected $fillable = [
        'komentar',
        'review_id',
        'user_id'
    ];

    public function review() {
        return $this->belongsTo(Komentar::class);
    }

    public function user() {
        return $this->belongsTo(User::class);
    }
}
