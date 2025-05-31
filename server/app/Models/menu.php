<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Str;

class menu extends Model
{
    protected $primaryKey = 'id';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        "menu_week",
        "menu_shift_id",
        "menu_dish_id",
        "menu_day",
        "menu_size"
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
     * Foreign Joins
     */
    public function menu_shift()
    {
        return $this->belongsTo(menu_shifts::class, "menu_shift_id", "id");
    }

    public function menu_dish()
    {
        return $this->belongsTo(menu_dishes::class, "menu_dish_id", "id")->with(["menu_tag", "menu_category", "production"]);
    }
}
