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
        return response()->json(menu_dishes::with(["menu_class", "menu_category", "menu_sub_category"])->get());
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
            "dish_code" => $menuDishIn->dish_code,
            "name" => $menuDishIn->name,
            "menu_class_id" => $menuDishIn->menu_class_id,
            "menu_category_id" => $menuDishIn->menu_category_id,
            "menu_sub_category_id" => $menuDishIn->menu_sub_category_id,
            "unit_cost" => $menuDishIn->unit_cost,
            "srp" => ($menuDishIn->unit_cost * 30 / 100) + $menuDishIn->unit_cost,
            "production" => $menuDishIn->production,
        ]);

        $menuDishes = new MenuDishesController();

        return response()->json([
            "status" => 200,
            "message" => "Dish successfully added",
            "menuDishes" => $menuDishes->GetAllMenuDishes()->original
        ]);
    }

    public function UpdateMenuDish(Request $request)
    {
        $editMenuDishIn = json_decode($request->input("editMenuDishIn"));

        menu_dishes::find($editMenuDishIn->id)->update([
            "name" => $editMenuDishIn->name,
            "menu_class_id" => $editMenuDishIn->menu_class_id,
            "menu_category_id" => $editMenuDishIn->menu_category_id,
            "menu_sub_category_id" => $editMenuDishIn->menu_sub_category_id,
            "unit_cost" => $editMenuDishIn->unit_cost,
            "srp" => ($editMenuDishIn->unit_cost * 30 / 100) + $editMenuDishIn->unit_cost,
            "production" => $editMenuDishIn->production,
            "status" => $editMenuDishIn->status,
        ]);

        $menuDishes = new MenuDishesController();
        
        return response()->json([
            "status" => 200,
            "message" => "Menu dish successfully updated",
            "menuDishes" => $menuDishes->GetAllMenuDishes()->original
        ]);
    }

    public function DeleteMenuDish(Request $request)
    {
        menu_dishes::find($request->id)->delete();

        return response()->json([
            "status" => 200,
            "message" => "Dish successfully deleted"
        ]);
    }
}
