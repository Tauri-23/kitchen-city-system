<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Laravel\Sanctum\HasApiTokens;
use Str;

class branch_managers extends Model
{
    use HasApiTokens;

    protected $primaryKey = 'id';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        "branch_id",
        "fname",
        "mname",
        "lname",
        "username",
        "password",
        "email",
        "status",
    ];

    public static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            if (!$model->getKey()) {
                $model->{$model->getKeyName()} = Str::random(20);
            }
        });
    }



    /**
     * Foriegn Joins
     */
    public function branch()
    {
        return $this->belongsTo(branches::class, "branch_id", "id");
    }
}
