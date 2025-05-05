<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\menu_dishes_categories;
use Illuminate\Http\Request;

class MenuDishesCategoriesController extends Controller
{
    //GET
    public function GetAllCategories()
    {
        return response()->json(menu_dishes_categories::all());
    }
}
