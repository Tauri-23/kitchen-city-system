<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\menu_week_cycles;
use Carbon\Carbon;
use DB;
use Illuminate\Http\Request;

class MenuWeekCycleController extends Controller
{
    // GET
    public function CreateMenuCycle(Request $request)
    {
        $selectedMenuDates = json_decode($request->input("selectedMenuDates"));
        $orderWindows = json_decode($request->input("orderWindows"));

        try
        {
            DB::beginTransaction();

            foreach ($selectedMenuDates as $key => $selectedDate) 
            {
                foreach ($selectedDate as $index => $date) 
                {
                    menu_week_cycles::Create([
                        "month" => Carbon::parse($date)->format("M"),
                        "date" => Carbon::parse($date)->toDateString(),
                        "day" => Carbon::parse($date)->isoFormat("dddd"),
                        "count" => $index + 1,
                        "week" => $key,
                        "open_date" => Carbon::parse($orderWindows->$key[0])->toDateString(),
                        "closing_date" => Carbon::parse($orderWindows->$key[count($orderWindows->$key) - 1])->toDateString()
                    ]);
                }
            }

            DB::commit();

            return response()->json([
                "status" => 200,
                "message" => "Success"
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
