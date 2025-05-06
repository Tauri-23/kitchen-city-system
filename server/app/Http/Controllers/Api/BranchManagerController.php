<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\branch_managers;
use DB;
use Illuminate\Http\Request;

class BranchManagerController extends Controller
{
    //GET
    public function GetAllBranchManagers()
    {
        return response()->json(branch_managers::with("branch")->get());
    }



    // POST
    public function CreateBranchManager(Request $request)
    {
        $branchManagerIn = json_decode($request->input("branchManagerIn"));
        $isEmailExist = branch_managers::where("email", $branchManagerIn->email)->exists();
        $isUsernameExist = branch_managers::where("username", $branchManagerIn->username)->exists();
        
        
        if ($isEmailExist || $isUsernameExist) {
            $alreadyExistsMessage = match (true) {
                $isEmailExist && $isUsernameExist => "Email and username already exist",
                $isEmailExist => "Email already exists",
                $isUsernameExist => "Username already exists",
            };

            return response()->json([
                "status" => 422,
                "message" => $alreadyExistsMessage
            ]);
        }

        try
        {
            DB::beginTransaction();

            branch_managers::Create([
                "branch_id" => $branchManagerIn->branchId,
                "fname" => $branchManagerIn->fname,
                "mname" => $branchManagerIn->mname,
                "lname" => $branchManagerIn->lname,
                "username" => $branchManagerIn->username,
                "password" => bcrypt($branchManagerIn->password),
                "email" => $branchManagerIn->email,
            ]);

            DB::commit();

            return response()->json([
                "status" => 200,
                "message" => "Branch manager successfully added",
                "branchManagers" => branch_managers::with("branch")->get()
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
