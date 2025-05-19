<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\menu_sub_categories;
use Illuminate\Http\Request;

class MenuSubCategoryController extends Controller
{
    // GET
    public function GetAllMenuSubCategories()
    {
        return response()->json(menu_sub_categories::all());
    }
}
