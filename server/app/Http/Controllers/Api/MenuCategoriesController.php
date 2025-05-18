<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\menu_categories;
use DB;
use Illuminate\Http\Request;

class MenuCategoriesController extends Controller
{
    // GET
    public function GetAllCategories()
    {
        return response()->json(menu_categories::all());
    }



    // POST
    public function CreateMenuCategory(Request $request)
    {
        $menuCategoryIn = json_decode($request->input("menuCategoryIn"));

        try
        {
            DB::beginTransaction();

            $newCategory = menu_categories::Create([
                "shift_id" => $menuCategoryIn->menu_shift_id,
                "category" => $menuCategoryIn->category
            ]);

            DB::commit();

            return response()->json([
                "status" => 200,
                "message" => "Category successfully added",
                "newCategory" => $newCategory->load("menu_tags")
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

    public function UpdateMenuCategory(Request $request)
    {
        $editMenuCategoryIn = json_decode($request->input("editMenuCategoryIn"));

        menu_categories::find($editMenuCategoryIn->id)->update([
            "category" => $editMenuCategoryIn->category
        ]);

        $getMenuShifts = new MenuShiftsController();

        return response()->json([
            "status" => 200,
            "message" => "Menu category updated successfully",
            "updated_menu_shifts" => $getMenuShifts->GetAllMenuShiftsFull()->original
        ]);
    }

    public function DeleteMenuCategory(Request $request)
    {
        menu_categories::find($request->id)->delete();

        $getMenuShifts = new MenuShiftsController();

        return response()->json([
            "status" => 200,
            "message" => "Menu category successfully deleted",
            "updated_menu_shifts" => $getMenuShifts->GetAllMenuShiftsFull()->original
        ]);
    }
}
