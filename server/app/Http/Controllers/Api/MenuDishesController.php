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
    public function GetAllDishes()
    {
        return response()->json(menu_dishes::with("category")->get());
    }

    public function GetAllDishesWhereStatus($status)
    {
        return response()->json(menu_dishes::where("status", $status)->with("category")->get());
    }



    // POST
    public function CreateDishes(Request $request)
    {
        $menuDishIn = json_decode($request->input("menuDishIn"));

        try
        {
            DB::beginTransaction();
            
            menu_dishes::Create([
                "menu_id" => $request->menuId,
                "name" => $menuDishIn->name,
                "odoo_name" => $menuDishIn->odooName,
                "category_id" => $menuDishIn->categoryId === "" ? null : $menuDishIn->categoryId,
                "unit_cost" => $menuDishIn->unitCost,
                "production" => $menuDishIn->production,
            ]);

            DB::commit();

            return response()->json([
                "status" => 200,
                "message" => "Dish successfully added"
            ]);
        }
        catch(\Exception $e)
        {
            DB::rollBack();
            return response()->json([
                "status" => 500,
                "message" => $e->getMessage()
            ], 500);
        }
    }
    


    public function CreateDishesViaExcel(Request $request)
    {
        $excelData = json_decode($request->input("excelData"));

        try
        {
            DB::beginTransaction();

            // return response()->json($excelData, 500);

            foreach ($excelData as $key => $cell) {
                // return response()->json($cell, 500);

                // FIND THE MENU 
                $menu = menu::where("menu_week", $cell->week)
                ->where("menu_day", $cell->day)
                ->where("meal_type", $cell->mealType)
                ->where("menu_size", $cell->menuSize)
                ->first();

                if(!$menu)
                {
                    return response()->json([
                        "status" => 404,
                        "message" => "There is no menu for  $cell->week $cell->day $cell->mealType $cell->menuSize"
                    ]);
                }
                    // Find THE CATEGORY
                $category = menu_dishes_categories::where("category", $cell->category)->first();

                if(!$category)
                {
                    return response()->json([
                        "status" => 404,
                        "message" => "There is no matched category for  $cell->category"
                    ]);
                }

                menu_dishes::Create([
                    "menu_id" => $menu->id,
                    "name" => $cell->dishName,
                    "odoo_name" => $cell->odooName,
                    "category_id" => $category->id,
                    "unit_cost" => $cell->unitCost,
                    "production" => $cell->production,
                ]);
            }            

            DB::commit();

            return response()->json([
                "status" => 200,
                "message" => "Dish successfully added"
            ]);
        }
        catch(\Exception $e)
        {
            DB::rollBack();
            return response()->json([
                "status" => 500,
                "message" => $e->getMessage()
            ], 500);
        }
    }
}
