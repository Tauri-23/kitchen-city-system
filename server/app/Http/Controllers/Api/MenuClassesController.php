<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\menu_classes;
use Illuminate\Http\Request;

class MenuClassesController extends Controller
{
    // GET
    public function GetAllMenuClasses()
    {
        return response()->json(menu_classes::with("menu_tags")->get());
    }



    // POST
    public function CreateMenuClass(Request $request)
    {
        $menuClassIn = json_decode($request->input("menuClassIn"));
        $classExist = menu_classes::where("class", $menuClassIn->class)->exists();

        if($classExist)
        {
            return response()->json([
                "status" => 422,
                "message" => "Class $menuClassIn->class already exist."
            ]);
        }

        $newClass = menu_classes::Create([
            "class" => $menuClassIn->class
        ]);

        return response()->json([
            "status" => 200,
            "message" => "Class successfully added",
            "newClass" => $newClass
        ]);
    }

    public function UpdateMenuClass(Request $request)
    {
        $editMenuClassIn = json_decode($request->input("editMenuClassIn"));

        menu_classes::find($editMenuClassIn->id)->update([
            "class" => $editMenuClassIn->class
        ]);

        return response()->json([
            "status" => 200,
            "message" => "Menu class updated successfully",
            "menu_classes" => menu_classes::all()
        ]);
    }

    public function DeleteMenuClass(Request $request)
    {
        menu_classes::find($request->id)->delete();

        return response()->json([
            "status" => 200,
            "message" => "Menu Class successfully deleted",
        ]);
    }
}
