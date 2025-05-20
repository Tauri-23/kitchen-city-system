<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class menu_classes extends Model
{
    protected $fillable = [
        "class"
    ];


    
    /**
     * Foreign Joins
     */
    public function menu_tags()
    {
        return $this->hasMany(menu_tags::class, "menu_class_id", "id")->with("sub_category");
    }
}
