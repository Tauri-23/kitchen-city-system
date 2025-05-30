<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Str;

class ml_bakeshop_items extends Model
{
    protected $primaryKey = 'id';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        "name",
        "ml_bakeshop_category_id",
        "unit_cost",
        "srp",
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
    public function ml_bakeshop_category()
    {
        return $this->belongsTo(ml_bakeshop_categories::class, "ml_bakeshop_category_id", "id");
    }
}
