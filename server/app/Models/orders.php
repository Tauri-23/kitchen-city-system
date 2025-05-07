<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Str;

class orders extends Model
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
    public function order_items()
    {
        return $this->hasMany(order_items::class, "order_id", "id")->with("menu_dish");
    }    

    public function branch()
    {
        return $this->belongsTo(branches::class, "branch_id", "id");
    }
}
