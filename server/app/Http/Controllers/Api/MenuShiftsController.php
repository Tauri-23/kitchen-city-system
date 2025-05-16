<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\menu_shifts;

class MenuShiftsController extends Controller
{
    // GET
    public function GetAllMenuShiftsFull()
    {
        return response()->json(menu_shifts::with("categories")->get());
    }
}
