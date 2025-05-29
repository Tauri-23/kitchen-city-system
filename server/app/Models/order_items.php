<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Str;

class order_items extends Model
{
    protected $primaryKey = 'id';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        "order_id",
        "menu_dish_id",
        "qty",
        "unit_cost",
        "srp",
        "total_cost",
        "status",
        "completed_at",
        "cancelled_at",
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
        return $this->belongsTo(menu_dishes::class, "menu_dish_id", "id")->with(["menu_tag", "menu_category", "menu_sub_category", "uom", "production"]);
    }
}
