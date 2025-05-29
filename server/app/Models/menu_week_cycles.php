<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class menu_week_cycles extends Model
{
    protected $fillable = [
        "month",
        "date",
        "day",
        "count",
        "week",
        "open_date",
        "closing_date"
    ];
}
