<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ml_bakeshop_items;
use Illuminate\Http\Request;

class MlBakeshopItemController extends Controller
{
    // GET
    public function GetAllMLBakeshopItems()
    {
        return response()->json(ml_bakeshop_items::with("ml_bakeshop_category")->get());
    }



    // 
}
