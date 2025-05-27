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
        $tagExist = menu_tags::where("tag", $menuTagIn->tag)->exists();

        if($tagExist) 
        {
            return response()->json([
                "status" => 422,
                "message" => "tag $menuTagIn->tag already exists"
            ]);
        }

        try
        {
            DB::beginTransaction();

            menu_tags::Create([
                "tag" => $menuTagIn->tag,
            ]);

            DB::commit();

            return response()->json([
                "status" => 200,
                "message" => "Menu tag added successfully",
                "menu_tags" => menu_tags::all()
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

        return response()->json([
            "status" => 200,
            "message" => "Menu tag updated successfully",
            "updated_menu_tags" => menu_tags::all()
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
