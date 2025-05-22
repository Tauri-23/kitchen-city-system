<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\menu;
use DB;
use Illuminate\Http\Request;

class MenuController extends Controller
{
    //GET
    public function GetAllMenus()
    {
        return response()->json(menu::with(["menu_dish", "menu_class", "menu_sub_category"])->get());
    }

    public function GetAllMenusWhereWeek($week)
    {
        return response()->json(
            menu::with("menu_dishes")
            ->where("menu_week", $week)
            ->with(["menu_dish", "menu_class", "menu_sub_category"])
            ->get()
        );
    }
    
    public function GetAllMenusWhereWeekDayAndSize($week, $day, $size)
    {
        return response()->json(
            menu::with("menu_dishes")
            ->where("menu_week", $week)
            ->where("menu_day", $day)
            ->where("menu_size", $size)
            ->with(["menu_dish", "menu_class", "menu_sub_category"])
            ->get()
        );
    }



    // POST
}
