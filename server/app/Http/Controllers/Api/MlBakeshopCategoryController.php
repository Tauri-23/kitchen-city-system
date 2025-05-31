<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ml_bakeshop_categories;
use Illuminate\Http\Request;

class MlBakeshopCategoryController extends Controller
{
    // GET
    public function GetAllMlBakeshopCategories()
    {
        return response()->json(ml_bakeshop_categories::all());
    }



    // POST
    public function CreateBakeshopCategory(Request $request)
    {
        $bakeshopCategoryIn = json_decode($request->input("bakeshopCategoryIn"));
        $categoryExist = ml_bakeshop_categories::where("category", $bakeshopCategoryIn->category)->exists();

        if($categoryExist)
        {
            return response()->json([
                "status" => 422,
                "message" => "Category $bakeshopCategoryIn->category already exist."
            ]);
        }

        $newCategory = ml_bakeshop_categories::Create([
            "category" => $bakeshopCategoryIn->category
        ]);

        return response()->json([
            "status" => 200,
            "message" => "Category successfully added",
            "newCategory" => $newCategory
        ]);
    }

    public function UpdateBakeshopCategory(Request $request)
    {
        $editBakeshopCategoryIn = json_decode($request->input("editBakeshopCategoryIn"));

        ml_bakeshop_categories::find($editBakeshopCategoryIn->id)->update([
            "category" => $editBakeshopCategoryIn->category
        ]);

        return response()->json([
            "status" => 200,
            "message" => "Bakeshop category updated successfully",
            "bakeshop_categories" => ml_bakeshop_categories::all()
        ]);
    }

    public function DeleteBakeshopCategory(Request $request)
    {
        ml_bakeshop_categories::find($request->id)->delete();

        return response()->json([
            "status" => 200,
            "message" => "Bakeshop category successfully deleted",
        ]);
    }
}
