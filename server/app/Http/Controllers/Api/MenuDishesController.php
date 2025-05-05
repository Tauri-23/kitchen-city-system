<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\menu_dishes;
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
}
