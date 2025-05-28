<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class menu_form_classes extends Model
{
    protected $fillable = [
        "menu_shift_id",
        "menu_class_id"
    ];



    /**
     * Foreign Joins
     */
    public function menu_shift()
    {
        return $this->belongsTo(menu_shifts::class, "menu_shift_id", "id");
    }
    
    public function menu_class()
    {
        return $this->belongsTo(menu_classes::class, "menu_class_id", "id");
    }
}
