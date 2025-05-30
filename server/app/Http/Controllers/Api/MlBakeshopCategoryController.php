<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ml_bakeshop_categories;
use Illuminate\Http\Request;

class MlBakeshopCategoryController extends Controller
{
    // GET
    public function GetAllMlBakeshopCategories()
    {
        return response()->json(ml_bakeshop_categories::all());
    }
}
