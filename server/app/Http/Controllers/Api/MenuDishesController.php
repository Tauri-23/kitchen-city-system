<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\menu;
use App\Models\menu_categories;
use App\Models\menu_dishes;
use App\Models\menu_dishes_categories;
use App\Models\menu_productions;
use App\Models\menu_sub_categories;
use App\Models\menu_tags;
use App\Models\menu_uoms;
use DB;
use Illuminate\Http\Request;

class MenuDishesController extends Controller
{
    //GET
    public function GetAllMenuDishes()
    {
        return response()->json(menu_dishes::with(["menu_tag", "menu_category", "menu_sub_category", "uom", "production"])->get());
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
    
    public function CreateMenuDishExcel(Request $request)
    {
        $menuDishesIn = json_decode($request->input("menuDishesIn"));

        try
        {
            DB::beginTransaction();

            foreach ($menuDishesIn as $key => $dish) {
                $odooCodeExist = menu_dishes::where("odoo_code", $dish->odoo_code)->exists();

                // if($odooCodeExist && $dish->odoo_code !== null)
                // {
                //     return response()->json([
                //         "status" => 422,
                //         "message" => "Odoo code $dish->odoo_code already exist"
                //     ]);
                // }

                $errors = [];

                $menuTag = menu_tags::where("tag", $dish->menu_tag)->first();
                if (!$menuTag && $dish->menu_tag) {
                    $errors[] = "Invalid menu tag: $dish->menu_tag";
                }

                $menuCategory = menu_categories::where("category", $dish->category)->first();
                if (!$menuCategory && $dish->category) {
                    $errors[] = "Invalid category: $dish->category";
                }

                $subCategory = menu_sub_categories::where("sub_category", $dish->sub_category)->first();
                if (!$subCategory && $dish->sub_category) {
                    $errors[] = "Invalid sub category: $dish->sub_category";
                }

                $uom = menu_uoms::where("uom", $dish->uom)->first();
                if (!$uom && $dish->uom) {
                    $errors[] = "Invalid uom: $dish->uom";
                }

                $production = menu_productions::where("production", $dish->production)->first();
                if (!$production && $dish->production) {
                    $errors[] = "Invalid production: $dish->production";
                }

                // Optional: Handle or return the errors
                if (!empty($errors)) {
                    return response()->json([
                        'status' => 400, 
                        'message' => implode("; ", $errors)
                    ]);
                }

                // Convert to numeric and compute SRP safely
                $unitCost = floatval($dish->unit_cost);
                $srp = ($unitCost * 0.30) + $unitCost;

                menu_dishes::Create([
                    "odoo_description" => $dish->odoo_description,
                    "system_description" => $dish->system_description,
                    "menu_tag_id" => $dish->menu_tag ? $menuTag->id : null,
                    "menu_category_id" => $dish->category ? $menuCategory->id : null,
                    "menu_sub_category_id" => $dish->sub_category ? $subCategory->id : null,
                    "unit_cost" => $unitCost,
                    "srp" => $srp,
                    "uom_id" => $dish->uom ? $uom->id : null,
                    "odoo_code" => $dish->odoo_code,
                    "production_id" => $dish->production ? $production->id : null,
                ]);
            }

            DB::commit();

            $menuDishes = new MenuDishesController();

            return response()->json([
                "status" => 200,
                "message" => "Dish successfully added",
                "menuDishes" => $menuDishes->GetAllMenuDishes()->original
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
