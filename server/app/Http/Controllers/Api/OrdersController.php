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

    public function GetAllOrdersWith(Request $request)
    {
        $with = $request->query('with');

        // Convert to array if it's a single string like "*"
        if (!is_array($with)) {
            $with = [$with];
        }

        $orders = orders::with($with)->get();

        return response()->json($orders);
    }

    public function GetOrderInformation(Request $request)
    {
        $with = $request->query('with');
        $id = $request->query('id');

        // Convert to array if it's a single string like "*"
        if ($with && !is_array($with)) {
            $with = [$with];
        }

        $orders = $with ? orders::with($with)->find($id) : orders::find($id);

        return response()->json($orders);
    }



    // POST
    public function CreateOrder(Request $request)
    {
        $selectedMenusIn = json_decode($request->input("selectedMenusIn"));

        $branchManager = branch_managers::find($request->branchManager);

        try
        {
            DB::beginTransaction();

            $order = orders::Create([
                "branch_id" => $branchManager->branch_id,
                "total_cost" => (float) $request->totalCost
            ]);
    
            foreach ($selectedMenusIn as $key => $dish) {
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
