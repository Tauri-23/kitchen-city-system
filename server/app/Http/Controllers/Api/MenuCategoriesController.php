<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\menu_categories;
use DB;
use Illuminate\Http\Request;

class MenuCategoriesController extends Controller
{
    // GET
    public function GetAllMenuCategories()
    {
        return response()->json(menu_categories::all());
    }



    // POST
    public function CreateMenuCategory(Request $request)
    {
        $menuCategoryIn = json_decode($request->input("menuCategoryIn"));
        $categoryExist = menu_categories::where("category", $menuCategoryIn->category)->exists();

        if($categoryExist)
        {
            return response()->json([
                "status" => 422,
                "message" => "Category $menuCategoryIn->category already exist."
            ]);
        }

        $newCategory = menu_categories::Create([
            "category" => $menuCategoryIn->category
        ]);

        return response()->json([
            "status" => 200,
            "message" => "Category successfully added",
            "newCategory" => $newCategory
        ]);
    }

    public function UpdateMenuCategory(Request $request)
    {
        $editMenuCategoryIn = json_decode($request->input("editMenuCategoryIn"));

        menu_categories::find($editMenuCategoryIn->id)->update([
            "category" => $editMenuCategoryIn->category
        ]);

        return response()->json([
            "status" => 200,
            "message" => "Menu category updated successfully",
            "menu_categories" => menu_categories::all()
        ]);
    }

    public function DeleteMenuCategory(Request $request)
    {
        menu_categories::find($request->id)->delete();

        return response()->json([
            "status" => 200,
            "message" => "Menu category successfully deleted",
        ]);
    }
}
