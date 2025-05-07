<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\branch_managers;
use App\Models\order_items;
use App\Models\orders;
use DB;
use Illuminate\Http\Request;

class OrdersController extends Controller
{
    //GET
    public function GetAllOrders()
    {
        return response()->json(orders::all());
    }

    public function GetAllOrdersWith($with)
    {
        if (in_array('*', $with)) {
            $orders = orders::with(['order_items', 'branch'])->get();
        } else if (is_array($with) && !empty($with)) {
            $orders = orders::with($with)->get();
        } else {
            $orders = orders::all();
        }

        return response()->json($orders);
    }



    // POST
    public function CreateOrder(Request $request)
    {
        $orderedDishes = json_decode($request->input("orderedDishes"));

        $branchManager = branch_managers::find($request->branchManager);

        try
        {
            DB::beginTransaction();

            $order = orders::Create([
                "branch_id" => $branchManager->branch_id,
                "total_cost" => (float) $request->totalCost
            ]);
    
            foreach ($orderedDishes as $key => $dish) {
                order_items::Create([
                    "order_id" => $order->id,
                    "menu_dish_id" => $dish->id,
                    "qty" => $dish->qtySelected,
                    "unit_cost" => $dish->unit_cost,
                    "total_cost" => $dish->unit_cost * $dish->qtySelected
                ]);
            }

            DB::commit();

            return response()->json([
                "status" => 200,
                "message" => "Order successfulle placed."
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
