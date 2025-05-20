<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class menu_tags extends Model
{
    protected $fillable = [
        "menu_class_id",
        "menu_sub_category_id",
        "tag",
    ];



    /**
     * Foreign Joins
     */
    public function sub_category()
    {
        return $this->belongsTo(menu_sub_categories::class, "menu_sub_category_id", "id");
    }
}
