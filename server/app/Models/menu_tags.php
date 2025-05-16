<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class menu_tags extends Model
{
    protected $fillable = [
        "menu_category_id",
        "tag"
    ];
}
