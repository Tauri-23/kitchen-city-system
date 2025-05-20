<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\menu_form_elements;
use Illuminate\Http\Request;

class MenuFormElementsController extends Controller
{
    // GET
    public function GetAllMenuFormElements()
    {
        return response()->json(menu_form_elements::with(["menu_shift", "menu_class"])->get());
    }



    // POST
    public function CreateMenuFormElement(Request $request)
    {
        $menuFormElementIn = json_decode($request->input("menuFormElementIn"));

        menu_form_elements::Create([
            "menu_shift_id" => $menuFormElementIn->menu_shift_id,
            "menu_class_id" => $menuFormElementIn->menu_class_id
        ]);

        $menuFormElements = new MenuFormElementsController();

        return response()->json([
            "status" => 200,
            "message" => "Success",
            "menuFormElements" => $menuFormElements->GetAllMenuFormElements()->original
        ]);
    }

    public function DeleteMenuFormElement(Request $request)
    {
        menu_form_elements::find($request->id)->delete();

        return response()->json([
            "status" => 200,
            "message" => "Form element successfully deleted"
        ]);
    }
}
