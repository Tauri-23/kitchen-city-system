<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\branches;
use DB;
use Illuminate\Http\Request;

class BranchesController extends Controller
{
    //GET
    public function GetAllBranches()
    {
        return response()->json(branches::with("area_manager")->get());
    }



    // POST
    public function CreateBranch(Request $request)
    {
        $branchIn = json_decode($request->input("branchIn"));
        $isBranchNameExistInLocation = branches::where("name", $branchIn->name)
        ->where("address", $branchIn->address)->exists();
        $isBranchCodeExists = branches::where("branch_code", $branchIn->branchCode)->exists();

        if ($isBranchNameExistInLocation || $isBranchCodeExists) {
            $alreadyExistsMessage = match (true) {
                $isBranchNameExistInLocation && $isBranchCodeExists => "Branch name in address and code already exist",
                $isBranchNameExistInLocation => "Branch name in address already exists",
                $isBranchCodeExists => "Branch code already exists",
            };

            return response()->json([
                "status" => 422,
                "message" => $alreadyExistsMessage
            ]);
        }

        try
        {
            DB::beginTransaction();

            branches::Create([
                "branch_code" => $branchIn->branchCode,
                "name" => $branchIn->name,
                "address" => $branchIn->address,
                "area_manager_id" => $branchIn->areaManagerId,
            ]);

            DB::commit();

            return response()->json([
                "status" => 200,
                "message" => "Branch successfully added.",
                "branches" => branches::with("area_manager")->get()
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
