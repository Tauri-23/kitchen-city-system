<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\menu_tags;
use DB;
use Illuminate\Http\Request;

class MenuTagsController extends Controller
{
    // GET
    public function GetAllMenuTags()
    {
        return response()->json(menu_tags::all());
    }



    // POST
    public function CreateMenuTag(Request $request)
    {
        $menuTagIn = json_decode($request->input("menuTagIn"));

        try
        {
            DB::beginTransaction();

            $menuTag = menu_tags::Create([
                "menu_category_id" => $menuTagIn->menu_category_id,
                "tag" => $menuTagIn->tag
            ]);

            DB::commit();

            return response()->json([
                "status" => 200,
                "message" => "Menu tag added successfully",
                "menu_tag" => $menuTag
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

    public function UpdateMenuTag(Request $request)
    {
        $editMenuTagIn = json_decode($request->input("editMenuTagIn"));

        menu_tags::find($editMenuTagIn->id)->update([
            "tag" => $editMenuTagIn->tag
        ]);

        $getMenuShifts = new MenuShiftsController();

        return response()->json([
            "status" => 200,
            "message" => "Menu tag updated successfully",
            "updated_menu_shifts" => $getMenuShifts->GetAllMenuShiftsFull()->original
        ]);
    }

    public function DeleteMenuTag(Request $request)
    {
        menu_tags::find($request->menuTagId)->delete();

        $getMenuShifts = new MenuShiftsController();

        return response()->json([
            "status" => 200,
            "message" => "Menu tag successfully deleted",
            "updated_menu_shifts" => $getMenuShifts->GetAllMenuShiftsFull()->original
        ]);
    }
}
