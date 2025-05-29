<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\menu_productions;
use Illuminate\Http\Request;

class MenuProductionController extends Controller
{
    // GET
    public function GetAllMenuProductions()
    {
        return response()->json(menu_productions::all());
    }



    // POST
    public function CreateMenuProduction(Request $request)
    {
        $menuProductionExist = menu_productions::where("production", $request->production)->exists();

        if($menuProductionExist)
        {
            return response()->json([
                "status" => 400,
                "message" => "Menu production $request->production already exist"
            ]);
        }

        menu_productions::Create([
            "production" => $request->production
        ]);

        return response()->json([
            "status" => 200,
            "message" => "Menu production $request->production added successfully",
            "menu_productions" => menu_productions::all()
        ]);
    }

    public function UpdateMenuProduction(Request $request)
    {
        menu_productions::find($request->id)->update([
            "production" => $request->production
        ]);

        return response()->json([
            "status" => 200,
            "message" => "Menu production updated successfully",
            "menu_productions" => menu_productions::all()
        ]);
    }

    public function DeleteMenuProduction(Request $request)
    {
        menu_productions::find($request->id)->delete();

        return response()->json([
            "status" => 200,
            "message" => "Menu production deleted successfully"
        ]);
    }
}
