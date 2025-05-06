<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\super_admins;
use DB;
use Illuminate\Http\Request;
use PhpParser\Node\Expr\Match_;

class SuperAdminController extends Controller
{
    //GET
    public function GetAllSuperAdminsExceptId($id)
    {
        return response()->json(super_admins::whereNot("id", $id)->get());
    }



    // POST
    public function CreateSuperAdmin(Request $request)
    {
        $superAdminIn = json_decode($request->input("superAdminIn"));
        $isEmailExist = super_admins::where("email", $superAdminIn->email)->exists();
        $isUsernameExist = super_admins::where("username", $superAdminIn->username)->exists();
        
        
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

            super_admins::Create([
                "fname" => $superAdminIn->fname,
                "mname" => $superAdminIn->mname,
                "lname" => $superAdminIn->lname,
                "username" => $superAdminIn->username,
                "password" => bcrypt($superAdminIn->password),
                "email" => $superAdminIn->email,
            ]);

            DB::commit();

            return response()->json([
                "status" => 200,
                "message" => "Super admin successfully added",
                "superAdmins" => super_admins::whereNot("id", $request->superAdminId)->get()
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
