<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Str;

class branches extends Model
{
    protected $primaryKey = 'id';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        "branch_code",
        "name",
        "address",
        "area_manager_id",
        "size",
        "status"
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
     * Foreing Join
     */
    public function area_manager()
    {
        return $this->belongsTo(area_managers::class, "area_manager_id", "id");
    }
}
