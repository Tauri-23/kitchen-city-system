<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\menu;
use App\Models\menu_dishes;
use App\Models\menu_dishes_categories;
use DB;
use Illuminate\Http\Request;

class MenuDishesController extends Controller
{
    //GET
    public function GetAllMenuDishes()
    {
        return response()->json(menu_dishes::with("sub_category")->get());
    }

    

    // POST
    public function CreateMenuDish(Request $request)
    {
        $menuDishIn = json_decode($request->input("menuDishIn"));

        $dishCodeExist = menu_dishes::where("dish_code", $menuDishIn->dish_code)->exists();

        if($dishCodeExist)
        {
            return response()->json([
                "status" => 422,
                "message" => "Dish code $menuDishIn->dish_code already exist"
            ]);
        }

        menu_dishes::Create([
            "menu_to_dish_tag" => $menuDishIn->menu_to_dish_tag,
            "dish_code" => $menuDishIn->dish_code,
            "name" => $menuDishIn->name,
            "sub_category_id" => $menuDishIn->sub_category,
            "unit_cost" => $menuDishIn->unit_cost,
            "production" => $menuDishIn->production,
        ]);

        return response()->json([
            "status" => 200,
            "message" => "Dish successfully added",
            "updatedMenuDishes" => menu_dishes::with("sub_category")->get()
        ]);
    }
}
