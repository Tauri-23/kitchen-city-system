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
                "menu_class_id" => $menuTagIn->menu_class_id,
                "menu_sub_category_id" => $menuTagIn->menu_sub_category_id,
                "tag" => $menuTagIn->tag,
            ]);

            DB::commit();

            return response()->json([
                "status" => 200,
                "message" => "Menu tag added successfully",
                "menu_tag" => $menuTag->load("sub_category")
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
            "menu_sub_category_id" => $editMenuTagIn->menu_sub_category_id,
            "tag" => $editMenuTagIn->tag
        ]);

        $getMenuClasses = new MenuClassesController();

        return response()->json([
            "status" => 200,
            "message" => "Menu tag updated successfully",
            "updated_menu_classes" => $getMenuClasses->GetAllMenuClasses()->original
        ]);
    }

    public function DeleteMenuTag(Request $request)
    {
        menu_tags::find($request->id)->delete();

        return response()->json([
            "status" => 200,
            "message" => "Menu tag successfully deleted"
        ]);
    }
}
