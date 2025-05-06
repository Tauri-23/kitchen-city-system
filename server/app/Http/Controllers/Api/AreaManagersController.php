<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\area_managers;
use DB;
use Illuminate\Http\Request;

class AreaManagersController extends Controller
{
    // GET
    public function GetAllAreaManagers()
    {
        return response()->json(area_managers::all());
    }



    // POST
    public function CreateAreaManager(Request $request)
    {
        $areaManagerIn = json_decode($request->input("areaManagerIn"));
        $isEmailExist = area_managers::where("email", $areaManagerIn->email)->exists();
        
        
        if ($isEmailExist) {
            return response()->json([
                "status" => 422,
                "message" => "Email already exists"
            ]);
        }

        try
        {
            DB::beginTransaction();

            area_managers::Create([
                "fname" => $areaManagerIn->fname,
                "mname" => $areaManagerIn->mname,
                "lname" => $areaManagerIn->lname,
                "email" => $areaManagerIn->email,
            ]);

            DB::commit();

            return response()->json([
                "status" => 200,
                "message" => "Area manager successfully added",
                "areaManagers" => area_managers::all()
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
}
