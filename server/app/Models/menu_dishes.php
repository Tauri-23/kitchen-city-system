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
        "menu_id",
        "name",
        "odoo_name",
        "category_id",
        "unit_cost",
        "production",
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
     * Forieng Joins
     */
    public function category()
    {
        return $this->belongsTo(menu_dishes_categories::class, "category_id", "id");
    }
}
