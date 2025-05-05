<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\menu_dishes;
use Illuminate\Http\Request;

class MenuDishesController extends Controller
{
    //GET
    public function GetAllDishes()
    {
        return response()->json(menu_dishes::with("category")->get());
    }

    public function GetAllDishesWhereStatus($status)
    {
        return response()->json(menu_dishes::where("status", $status)->with("category")->get());
    }
}
