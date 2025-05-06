<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\orders;
use Illuminate\Http\Request;

class OrdersController extends Controller
{
    //GET
    public function GetAllOrders()
    {
        return response()->json(orders::with("order_items")->get());
    }



    // POST
    public function CreateOrder()
    {
        
    }
}
