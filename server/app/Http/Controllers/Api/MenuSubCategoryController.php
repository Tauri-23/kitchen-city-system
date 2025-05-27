<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\menu_sub_categories;
use DB;
use Illuminate\Http\Request;

class MenuSubCategoryController extends Controller
{
    // GET
    public function GetAllMenuSubCategories()
    {
        return response()->json(menu_sub_categories::all());
    }



    // POST
    public function CreateMenuSubCategory(Request $request)
    {
        $menuSubCategoryIn = json_decode($request->input("menuSubCategoryIn"));
        $subCatExist = menu_sub_categories::where("sub_category", $menuSubCategoryIn->sub_category)->exists();

        if($subCatExist) 
        {
            return response()->json([
                "status" => 422,
                "message" => "Sub-category $menuSubCategoryIn->sub_category already exists"
            ]);
        }

        try
        {
            DB::beginTransaction();

            menu_sub_categories::Create([
                "sub_category" => $menuSubCategoryIn->sub_category,
            ]);

            DB::commit();

            return response()->json([
                "status" => 200,
                "message" => "Menu sub-category added successfully",
                "menu_sub_categories" => menu_sub_categories::all()
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

    public function UpdateMenuSubCategory(Request $request)
    {
        $editMenuSubCategoryIn = json_decode($request->input("editMenuSubCategoryIn"));

        menu_sub_categories::find($editMenuSubCategoryIn->id)->update([
            "sub_category" => $editMenuSubCategoryIn->sub_category
        ]);

        return response()->json([
            "status" => 200,
            "message" => "Menu sub-category updated successfully",
            "updated_menu_sub_categories" => menu_sub_categories::all()
        ]);
    }

    public function DeleteMenuSubCategory(Request $request)
    {
        menu_sub_categories::find($request->id)->delete();

        return response()->json([
            "status" => 200,
            "message" => "Menu sub-category successfully deleted"
        ]);
    }
}
