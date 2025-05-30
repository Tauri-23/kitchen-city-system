<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Str;

class ml_bakeshop_order_items extends Model
{
    protected $primaryKey = 'id';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        "ml_bakeshop_order_id",
        "ml_bakeshop_item_id",
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
    public function ml_bakeshop_item()
    {
        return $this->belongsTo(ml_bakeshop_items::class, "ml_bakeshop_item_id", "id")->with("ml_bakeshop_category");
    }
}
