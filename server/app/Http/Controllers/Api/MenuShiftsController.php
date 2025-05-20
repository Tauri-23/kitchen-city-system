<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\menu_shifts;
use DB;
use Illuminate\Http\Request;

class MenuShiftsController extends Controller
{
    // GET
    public function GetAllMenuShifts()
    {
        return response()->json(menu_shifts::all());
    }



    // POST
    public function CreateMenuShift(Request $request)
    {
        $menuShiftIn = json_decode($request->input("menuShiftIn"));

        try
        {
            DB::beginTransaction();

            $newShift = menu_shifts::Create([
                "shift" => $menuShiftIn->shift
            ]);

            DB::commit();

            return response()->json([
                "status" => 200,
                "message" => "Shift successfully added",
                "newShift" => $newShift
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

    public function UpdateMenuShift(Request $request)
    {
        $editMenuShiftIn = json_decode($request->input("editMenuShiftIn"));

        menu_shifts::find($editMenuShiftIn->id)->update([
            "shift" => $editMenuShiftIn->shift
        ]);

        $getMenuShifts = new MenuShiftsController();

        return response()->json([
            "status" => 200,
            "message" => "Menu shift updated successfully",
            "updated_menu_shifts" => $getMenuShifts->GetAllMenuShifts()->original
        ]);
    }

    public function DeleteMenuShift(Request $request)
    {
        menu_shifts::find($request->id)->delete();

        $getMenuShifts = new MenuShiftsController();

        return response()->json([
            "status" => 200,
            "message" => "Menu shift successfully deleted",
            "updated_menu_shifts" => $getMenuShifts->GetAllMenuShifts()->original
        ]);
    }
}
