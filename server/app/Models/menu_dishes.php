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
        "menu_to_dish_tag",
        "dish_code",
        "name",
        "sub_category_id",
        "unit_cost",
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
    public function sub_category()
    {
        return $this->belongsTo(menu_sub_categories::class, "sub_category_id", "id");
    }
}
