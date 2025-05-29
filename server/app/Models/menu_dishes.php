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
        "odoo_description",
        "system_description",
        "menu_tag_id",
        "menu_category_id",
        "menu_sub_category_id",
        "unit_cost",
        "srp",
        "uom_id",
        "odoo_code",
        "production_id",
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
    public function menu_tag()
    {
        return $this->belongsTo(menu_tags::class, "menu_tag_id", "id");
    }

    public function menu_category()
    {
        return $this->belongsTo(menu_categories::class, "menu_category_id", "id");
    }
    
    public function menu_sub_category()
    {
        return $this->belongsTo(menu_sub_categories::class, "menu_sub_category_id", "id");
    }

    public function uom()
    {
        return $this->belongsTo(menu_uoms::class, "uom_id", "id");
    }

    public function production()
    {
        return $this->belongsTo(menu_productions::class, "production_id", "id");
    }
}
