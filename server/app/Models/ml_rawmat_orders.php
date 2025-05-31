<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Str;

class ml_rawmat_orders extends Model
{
    protected $primaryKey = 'id';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        "branch_id",
        "deadline",
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
    public function ml_rawmat_order_items()
    {
        return $this->hasMany(ml_rawmat_order_items::class, "ml_rawmat_order_id", "id")->with("ml_rawmat_item");
    }    

    public function branch()
    {
        return $this->belongsTo(branches::class, "branch_id", "id");
    }
}
