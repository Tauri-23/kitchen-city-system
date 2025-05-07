<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\menu;
use DB;
use Illuminate\Http\Request;

class MenuController extends Controller
{
    //GET
    public function GetAllMenus()
    {
        return response()->json(
            menu::with("menu_dishes")
            ->orderBy("menu_week", "asc")
            ->orderByRaw("FIELD(menu_day, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 
                'Friday', 'Saturday', 'Sunday')") 
            ->orderByRaw("FIELD(meal_type, 'Breakfast', 'Lunch', 'Snack', 'Dinner', 
                'Midnight Lunch', 'Midnight Snack')")
            ->orderByRaw("FIELD(menu_size, 'XL', 'Large', 'Medium', 'Medium Frying', 
                'Small', 'Small Frying')")
            ->get()
        );
    }

    public function GetAllMenusWhereWeek($week)
    {
        return response()->json(
            menu::with("menu_dishes")
            ->where("menu_week", $week)
            ->orderByRaw("FIELD(menu_day, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 
                'Friday', 'Saturday', 'Sunday')") 
            ->orderByRaw("FIELD(meal_type, 'Breakfast', 'Lunch', 'Snack', 'Dinner', 
                'Midnight Lunch', 'Midnight Snack')")
            ->orderByRaw("FIELD(menu_size, 'XL', 'Large', 'Medium', 'Medium Frying', 
                'Small', 'Small Frying')")
            ->get()
        );
    }

    public function GetMenuById($id)
    {
        return response()->json(menu::with("menu_dishes")->find($id));
    }



    // POST
    public function CreateMenu(Request $request)
    {
        $menuIn = json_decode($request->input("menuIn"));
        $menuExistBasedOnTypeDayWeekSize = menu::where("menu_week", $menuIn->menuWeek)
        ->where("menu_day", $menuIn->menuDay)
        ->where("meal_type", $menuIn->mealType)
        ->where("menu_size", $menuIn->menuSize)
        ->exists();

        $menuExistBasedOnName = menu::where("menu_name", $menuIn->menuName)->exists();

        // CHECK IF NAME ALRDY EXIST
        if($menuExistBasedOnName)
        {
            return response()->json([
                "status" => 422,
                "message" => "Menu name already exist."
            ]);
        }

        // CHECK IF WEEK AND MEAL TYPE EXIST
        if($menuExistBasedOnTypeDayWeekSize)
        {
            return response()->json([
                "status" => 422,
                "message" => "Menu for week $menuIn->menuWeek $menuIn->menuDay $menuIn->mealType $menuIn->menuSize already exist."
            ]);
        }

        try
        {
            DB::beginTransaction();

            menu::Create([
                "menu_name" => $menuIn->menuName,
                "menu_week" => $menuIn->menuWeek,
                "menu_day" => $menuIn->menuDay,
                "meal_type" => $menuIn->mealType,
                "menu_size" => $menuIn->menuSize
            ]);

            DB::commit();

            return response()->json([
                "status" => 200,
                "message" => "Menu created successfully."
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

    public function CreateMenuViaExcel(Request $request)
    {
        $excelData = json_decode($request->input("excelData"));

        try
        {
            DB::beginTransaction();

            foreach ($excelData as $key => $excelInfo) {
                $menuExistBasedOnTypeDayWeekSize = menu::where("menu_week", $excelInfo->menuWeek)
                ->where("menu_day", $excelInfo->menuDay)
                ->where("meal_type", $excelInfo->mealType)
                ->where("menu_size", $excelInfo->menuSize)
                ->exists();

                $menuExistBasedOnName = menu::where("menu_name", $excelInfo->menuName)->exists();

                // CHECK IF NAME ALRDY EXIST
                if($menuExistBasedOnName)
                {
                    return response()->json([
                        "status" => 422,
                        "message" => "Menu name $excelInfo->menuName already exist."
                    ]);
                }

                // CHECK IF WEEK AND MEAL TYPE EXIST
                if($menuExistBasedOnTypeDayWeekSize)
                {
                    return response()->json([
                        "status" => 422,
                        "message" => "Menu for week $excelInfo->menuWeek $excelInfo->menuDay $excelInfo->mealType $excelInfo->menuSize already exist."
                    ]);
                }

                menu::Create([
                    "menu_name" => $excelInfo->menuName,
                    "menu_week" => $excelInfo->menuWeek,
                    "menu_day" => $excelInfo->menuDay,
                    "meal_type" => $excelInfo->mealType,
                    "menu_size" => $excelInfo->menuSize
                ]);
            }

            DB::commit();

            return response()->json([
                "status" => 200,
                "message" => "Menu created successfully."
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
