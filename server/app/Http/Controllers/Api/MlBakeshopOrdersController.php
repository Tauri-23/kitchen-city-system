<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\branch_managers;
use App\Models\ml_bakeshop_order_items;
use App\Models\ml_bakeshop_orders;
use DB;
use Illuminate\Http\Request;

class MlBakeshopOrdersController extends Controller
{
    // GET
    public function GetAllMlBakeshopOrdersWith(Request $request)
    {
        $with = $request->query('with');

        // Convert to array if it's a single string like "*"
        if (!is_array($with)) {
            $with = [$with];
        }

        $orders = ml_bakeshop_orders::with($with)->get();

        return response()->json($orders);
    }

    public function GetMlBakeshopOrderInformation(Request $request)
    {
        $with = $request->query('with');
        $id = $request->query('id');

        // Convert to array if it's a single string like "*"
        if ($with && !is_array($with)) {
            $with = [$with];
        }

        $orders = $with ? ml_bakeshop_orders::with($with)->find($id) : ml_bakeshop_orders::find($id);

        return response()->json($orders);
    }


    // POST
    public function CreateMlBakeshopOrder(Request $request)
    {
        $selectedBakeshopItemsIn = json_decode($request->input("selectedBakeshopItemsIn"));

        $branchManager = branch_managers::find($request->branchManager);

        try
        {
            DB::beginTransaction();

            $order = ml_bakeshop_orders::Create([
                "branch_id" => $branchManager->branch_id,
                "total_cost" => (float) $request->totalCost
            ]);
    
            foreach ($selectedBakeshopItemsIn as $key => $dish) {
                // return response()->json($dish, 500);
                
                ml_bakeshop_order_items::Create([
                    "ml_bakeshop_order_id" => $order->id,
                    "ml_bakeshop_item_id" => $dish->ml_bakeshop_item_id,
                    "qty" => $dish->qty_selected,
                    "unit_cost" => $dish->ml_bakeshop_item->unit_cost,
                    "srp" => $dish->ml_bakeshop_item->srp,
                    "total_cost" => $dish->ml_bakeshop_item->unit_cost * $dish->qty_selected
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
