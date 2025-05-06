<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\LoginRequest;
use App\Models\branch_managers;
use App\Models\super_admins;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    public function Login(Request $request)
    {
        $loginCreDentials = json_decode($request->input("loginCredentials"));

        $superAdmin = super_admins::where('username', $loginCreDentials->username)
        ->first();
        $branchManager = branch_managers::where('username', $loginCreDentials->username)
        ->first();

        if($superAdmin && Hash::check($loginCreDentials->password, $superAdmin->password))
        {
            $token = $superAdmin->createToken("superAdmin")->plainTextToken;

            return response()->json([
                "status" => 200,
                "message" => "Success",
                "user" => [
                    "id" => $superAdmin->id,
                    "fname" => $superAdmin->fname,
                    "mname" => $superAdmin->mname,
                    "lname" => $superAdmin->lname,
                    "user_type" => "Super Admin"
                ],
                "token" => $token,
                "userType" => "Super Admin"
            ]);
        }
        else if($branchManager && Hash::check($loginCreDentials->password, $branchManager->password))
        {
            $token = $branchManager->createToken("branchManager")->plainTextToken;

            return response()->json([
                "status" => 200,
                "message" => "Success",
                "user" => [
                    "id" => $branchManager->id,
                    "fname" => $branchManager->fname,
                    "mname" => $branchManager->mname,
                    "lname" => $branchManager->lname,
                    "user_type" => "Branch Manager"
                ],
                "token" => $token,
                "userType" => "Branch Manager"
            ]);
        }

        return response()->json([
            "status" => 401,
            "message" => "Credentials doesn't match"
        ]);
    }


    public function Logout(Request $request)
    {
        $user = $request->user();

        if($user)
        {
            $user->currentAccessToken()->delete();
            
            return response()->json([
                "status" => 200,
                "message" => "Logged out successfully"
            ]);
        }

        return response()->json([
            'status' => 401,
            'message' => 'User not authenticated.'
        ], 401);
    }


    public function GetUser(Request $request)
    {
        $user = $request->user();

        $userType = $user instanceof super_admins
            ? "Super Admin"
            : "";
        
        return response()->json([
            "user" => [
                "id" => $user->id,
                "fname" => $user->fname,
                "mname" => $user->mname,
                "lname" => $user->lname,
                "user_type" => $userType
            ],
            "userType" => $userType
        ]);
    }
}
