<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class menu_shifts extends Model
{
    //
    /**
     * Foreign Joins
     */
    public function categories()
    {
        return $this->hasMany(menu_categories::class, "shift_id", "id");
    }
}
