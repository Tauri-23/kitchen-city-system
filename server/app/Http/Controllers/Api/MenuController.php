<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\menu;
use App\Models\menu_dishes;
use App\Models\menu_shifts;
use DB;
use Illuminate\Http\Request;

class MenuController extends Controller
{
    //GET
    public function GetAllMenus()
    {
        return response()->json(menu::with(["menu_dish", "menu_class", "menu_sub_category"])->get());
    }

    public function GetAllMenusWhereWeek($week)
    {
        return response()->json(
            menu::with("menu_dishes")
            ->where("menu_week", $week)
            ->with(["menu_dish", "menu_class", "menu_sub_category"])
            ->get()
        );
    }
    
    public function GetAllMenusWhereWeekDayAndSize($week, $day, $size)
    {
        return response()->json(
            menu::where("menu_week", $week)
            ->where("menu_day", $day)
            ->where("menu_size", $size)
            ->with(["menu_dish"])
            ->get()
        );
    }



    // POST
    public function CreateUpdateMenu(Request $request)
    {
        try
        {
            $selectedDishesIn = json_decode($request->input("selectedDishesIn"));

            DB::beginTransaction();

            // Loops for update and create
            foreach ($selectedDishesIn as $key => $selectedDish) {
                // Check if exist (Update)
                $menuExist = menu::where("menu_week", $request->menuWeek)
                ->where("menu_day", $request->menuDay)
                ->where("menu_size", $request->menuSize)
                ->where("menu_shift_id", $selectedDish->menu_shift_id)
                ->where("menu_sub_category_id", $selectedDish->menu_sub_category_id)->first();
                
                if($menuExist) 
                {
                    // Update
                    $menuExist->update([
                        "menu_dish_id" => $selectedDish->menu_dish_id
                    ]); 
                }
                else {
                    // Create
                    menu::Create([
                        "menu_week" => $request->menuWeek,
                        "menu_shift_id" => $selectedDish->menu_shift_id,
                        "menu_dish_id" => $selectedDish->menu_dish_id,
                        "menu_class_id" => $selectedDish->menu_class_id,
                        "menu_sub_category_id" => $selectedDish->menu_sub_category_id,
                        "menu_day" => $request->menuDay,
                        "menu_size" => $request->menuSize
                    ]);
                }
            }

            /**
             * For deletion
             * all elements that are in menu::class that is not in the $selectedDishesIn will be deleted
             */
            $menus = menu::where("menu_week", $request->menuWeek)
                ->where("menu_day", $request->menuDay)
                ->where("menu_size", $request->menuSize)->get();

            // Loop Through menu record
            foreach ($menus as $menu) {
                $existsInInput = collect($selectedDishesIn)->contains(function ($selectedDish) use ($menu) {
                    return (
                        $selectedDish->menu_shift_id === $menu->menu_shift_id &&
                        $selectedDish->menu_class_id === $menu->menu_class_id &&
                        $selectedDish->menu_sub_category_id === $menu->menu_sub_category_id
                    );
                });

                if (!$existsInInput) {
                    $menu->delete();
                }
            }

            DB::commit();

            $updatedMenus = new MenuController();

            return response()->json([
                "status" => 200,
                "message" => "Success",
                "updatedMenus" => $updatedMenus->GetAllMenusWhereWeekDayAndSize($request->menuWeek, $request->menuDay, $request->menuSize)->original
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

    public function CreateMenusViaExcel(Request $request)
    {
        $menusIn = json_decode($request->input("menusIn"));

        try
        {
            DB::beginTransaction();

            foreach ($menusIn as $key => $menu) {
                $errors = [];

                $menuShift = menu_shifts::where("shift", ucfirst(strtolower($menu->menu_shift)))->first();
                if (!$menuShift && $menu->menu_shift) {
                    $errors[] = "Invalid menu shift: $menu->menu_shift";
                }

                $menuDish = menu_dishes::where("system_description", $menu->dish_system_desc)->first();
                if (!$menuDish && $menu->dish_system_desc) {
                    $errors[] = "Invalid dish: $menu->dish_system_desc";
                }

                if (!empty($errors)) {
                    return response()->json([
                        'status' => 400, 
                        'message' => implode("; ", $errors)
                    ]);
                }

                menu::Create([
                    "menu_week" => $menu->menu_week,
                    "menu_shift_id" => $menuShift->id,
                    "menu_dish_id" => $menuDish->id,
                    "menu_day" => ucfirst(strtolower($menu->menu_day)),
                    "menu_size" => ucfirst(strtolower($menu->menu_size)),
                ]);
            }

            DB::commit();

            return response()->json([
                "status" => 200,
                "message" => "Menu successfully added."
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
