<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ml_rawmat_categories;
use Illuminate\Http\Request;

class MlRawmatCategoryController extends Controller
{
    // GET
    public function GetAllMlRawmatCategories()
    {
        return response()->json(ml_rawmat_categories::all());
    }
}
