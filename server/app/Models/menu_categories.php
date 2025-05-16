<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class menu_categories extends Model
{
    protected $fillable = [
        "shift_id",
        "category"
    ];



    /**
     * Foreign Joins
     */
    public function menu_tags()
    {
        return $this->hasMany(menu_tags::class, "menu_category_id", "id");
    }
}
