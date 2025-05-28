<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class menu_form_menu_tags extends Model
{
    protected $fillable = [
        "menu_form_class_id",
        "menu_tag_id"
    ];



    /**
     * Foreign Joins
     */
    public function menu_form_class()
    {
        return $this->belongsTo(menu_form_classes::class, "menu_form_class_id", "id");
    }

    public function menu_tag()
    {
        return $this->belongsTo(menu_tags::class, "menu_tag_id", "id");
    }
}
