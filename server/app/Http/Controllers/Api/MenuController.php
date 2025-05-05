<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\menu;
use Illuminate\Http\Request;

class MenuController extends Controller
{
    //GET
    public function GetAllMenus()
    {
        return response()->json(menu::all());
    }
}
