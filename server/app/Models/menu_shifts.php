<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class menu_shifts extends Model
{
    protected $fillable = [
        "shift"
    ];



    /**
     * Foreign Joins
     */
    public function categories()
    {
        return $this->hasMany(menu_categories::class, "shift_id", "id")->with("menu_tags");
    }
}
