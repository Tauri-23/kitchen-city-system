<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Str;

class super_admins extends Model
{
    public $incrementing = false;
    protected $keyType = 'string';

    public static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            if (!$model->getKey()) {
                $model->{$model->getKeyName()} = Str::random(20);
            }
        });
    }
}
