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
        "menu_dish_id",
        "menu_class_id",
        "menu_sub_category_id",
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
    public function menu_dish()
    {
        return $this->belongsTo(menu_dishes::class, "menu_dish_id", "id");
    }

    public function menu_class()
    {
        return $this->belongsTo(menu_classes::class, "menu_class_id", "id");
    }

    public function menu_sub_category()
    {
        return $this->belongsTo(menu_sub_categories::class, "menu_sub_category_id", "id");
    }

}
