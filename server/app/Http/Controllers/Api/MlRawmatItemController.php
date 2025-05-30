<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ml_rawmat_items;
use Illuminate\Http\Request;

class MlRawmatItemController extends Controller
{
    // GET
    public function GetAllMlRawmatItems()
    {
        return response()->json(ml_rawmat_items::with("ml_rawmat_category")->get());
    }
}
