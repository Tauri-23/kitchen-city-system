<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Str;

class ml_rawmat_order_items extends Model
{
    protected $primaryKey = 'id';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        "ml_rawmat_order_id",
        "ml_rawmat_item_id",
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
    public function ml_rawmat_item()
    {
        return $this->belongsTo(ml_rawmat_items::class, "ml_rawmat_item_id", "id")->with("ml_rawmat_category");
    }
}
