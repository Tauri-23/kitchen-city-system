<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Str;

class menu_dishes extends Model
{
    protected $primaryKey = 'id';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        "dish_code",
        "name",
        "menu_class_id",
        "menu_category_id",
        "menu_sub_category_id",
        "unit_cost",
        "srp",
        "production",
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
     * Foreign Joins
     */
    public function menu_class()
    {
        return $this->belongsTo(menu_classes::class, "menu_class_id", "id");
    }

    public function menu_category()
    {
        return $this->belongsTo(menu_categories::class, "menu_category_id", "id");
    }
    
    public function menu_sub_category()
    {
        return $this->belongsTo(menu_sub_categories::class, "menu_sub_category_id", "id");
    }
}
