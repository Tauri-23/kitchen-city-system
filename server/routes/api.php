<?php

use App\Http\Controllers\Api\AreaManagersController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\BranchesController;
use App\Http\Controllers\Api\BranchManagerController;
use App\Http\Controllers\Api\MenuCategoriesController;
use App\Http\Controllers\Api\MenuClassesController;
use App\Http\Controllers\Api\MenuController;
use App\Http\Controllers\Api\MenuDishesController;
use App\Http\Controllers\Api\MenuFormElementsController;
use App\Http\Controllers\Api\MenuProductionController;
use App\Http\Controllers\Api\MenuShiftsController;
use App\Http\Controllers\Api\MenuSubCategoryController;
use App\Http\Controllers\Api\MenuTagsController;
use App\Http\Controllers\Api\MenuWeekCycleController;
use App\Http\Controllers\Api\MlBakeshopCategoryController;
use App\Http\Controllers\Api\MlBakeshopItemController;
use App\Http\Controllers\Api\MlBakeshopOrdersController;
use App\Http\Controllers\Api\MlRawmatCategoryController;
use App\Http\Controllers\Api\MlRawmatItemController;
use App\Http\Controllers\Api\MlRawmatOrdersController;
use App\Http\Controllers\Api\OrdersController;
use App\Http\Controllers\Api\SuperAdminController;
use Illuminate\Support\Facades\Route;

Route::middleware("auth:sanctum")
->group(function() {
    Route::get('/user', [AuthController::class, "GetUser"]);
    Route::post('/logout', [AuthController::class, "Logout"]);
});





/*
|----------------------------------------
| Auth 
|----------------------------------------
*/
Route::post("/login", [AuthController::class, "Login"]);





/*
|----------------------------------------
| Shifts 
|----------------------------------------
*/
Route::get("/get-all-menu-shifts", [MenuShiftsController::class, "GetAllMenuShifts"]);

Route::post("/create-menu-shift", [MenuShiftsController::class, "CreateMenuShift"]);
Route::post("/update-menu-shift", [MenuShiftsController::class, "UpdateMenuShift"]);
Route::post("/delete-menu-shift", [MenuShiftsController::class, "DeleteMenuShift"]);





/*
|----------------------------------------
| Menu Categories 
|----------------------------------------
*/
Route::get("/get-all-menu-categories", [MenuCategoriesController::class, "GetAllMenuCategories"]);

Route::post("/create-menu-category", [MenuCategoriesController::class, "CreateMenuCategory"]);
Route::post("/update-menu-category", [MenuCategoriesController::class, "UpdateMenuCategory"]);
Route::post("/delete-menu-category", [MenuCategoriesController::class, "DeleteMenuCategory"]);





/*
|----------------------------------------
| Menu Classes 
|----------------------------------------
*/
Route::get("/get-all-menu-classes", [MenuClassesController::class, "GetAllMenuClasses"]);

Route::post("/create-menu-class", [MenuClassesController::class, "CreateMenuClass"]);
Route::post("/update-menu-class", [MenuClassesController::class, "UpdateMenuClass"]);
Route::post("/delete-menu-class", [MenuClassesController::class, "DeleteMenuClass"]);





/*
|----------------------------------------
| Menu Tags 
|----------------------------------------
*/
Route::get("/get-all-menu-tags", [MenuTagsController::class, "GetAllMenuTags"]);

Route::post("/create-menu-tag", [MenuTagsController::class, "CreateMenuTag"]);
Route::post("/update-menu-tag", [MenuTagsController::class, "UpdateMenuTag"]);
Route::post("/delete-menu-tag", [MenuTagsController::class, "DeleteMenuTag"]);





/*
|----------------------------------------
| Menu Productions
|----------------------------------------
*/
Route::get('/get-all-menu-productions', [MenuProductionController::class, "GetAllMenuProductions"]);

Route::get('/create-menu-production', [MenuProductionController::class, "CreateMenuProduction"]);
Route::get('/update-menu-production', [MenuProductionController::class, "UpdateMenuProduction"]);
Route::get('/delete-menu-production', [MenuProductionController::class, "DeleteMenuProduction"]);





/*
|----------------------------------------
| Menu Sub Categories
|----------------------------------------
*/
Route::get('/get-all-menu-sub-categories', [MenuSubCategoryController::class, "GetAllMenuSubCategories"]);

Route::post('/create-menu-sub-category', [MenuSubCategoryController::class, "CreateMenuSubCategory"]);
Route::post('/update-menu-sub-category', [MenuSubCategoryController::class, "UpdateMenuSubCategory"]);
Route::post('/delete-menu-sub-category', [MenuSubCategoryController::class, "DeleteMenuSubCategory"]);





/*
|----------------------------------------
| Menu Form Elements 
|----------------------------------------
*/
Route::get("/get-all-menu-form-elements", [MenuFormElementsController::class, "GetAllMenuFormElements"]);

Route::post("/create-menu-form-element", [MenuFormElementsController::class, "CreateMenuFormElement"]);
Route::post("/delete-menu-form-element", [MenuFormElementsController::class, "DeleteMenuFormElement"]);





/*
|----------------------------------------
| Menu 
|----------------------------------------
*/
Route::get('/get-all-menus', [MenuController::class, "GetAllMenus"]);
Route::get('/get-all-menus-where-week/{week}', [MenuController::class, "GetAllMenusWhereWeek"]);
Route::get('/get-all-menus-where-week-day-and-size/{week}/{day}/{size}', [MenuController::class, "GetAllMenusWhereWeekDayAndSize"]);
Route::get('/get-menu-by-id/{id}', [MenuController::class, "GetMenuById"]);

Route::post('/create-update-menu', [MenuController::class, "CreateUpdateMenu"]);
Route::post('/create-menu-via-excel', [MenuController::class, "CreateMenusViaExcel"]);





/*
|----------------------------------------
| Menu Dishes
|----------------------------------------
*/
Route::get("/get-all-menu-dishes", [MenuDishesController::class, "GetAllMenuDishes"]);

Route::post("/create-menu-dish", [MenuDishesController::class, "CreateMenuDish"]);
Route::post("/create-menu-dish-excel", [MenuDishesController::class, "CreateMenuDishExcel"]);
Route::post("/update-menu-dish", [MenuDishesController::class, "UpdateMenuDish"]);
Route::post("/delete-menu-dish", [MenuDishesController::class, "DeleteMenuDish"]);





/*
|----------------------------------------
| Super Admins
|----------------------------------------
*/
Route::get("/get-all-super-admins-wherenot-id/{id}", [SuperAdminController::class, "GetAllSuperAdminsExceptId"]);

Route::post("/create-super-admin", [SuperAdminController::class, "CreateSuperAdmin"]);





/*
|----------------------------------------
| Area Managers
|----------------------------------------
*/
Route::get("/get-all-area-managers", [AreaManagersController::class, "GetAllAreaManagers"]);

Route::post("/create-area-manager", [AreaManagersController::class, "CreateAreaManager"]);





/*
|----------------------------------------
| Branches
|----------------------------------------
*/
Route::get("/get-all-branches", [BranchesController::class, "GetAllBranches"]);

Route::post("/create-branch", [BranchesController::class, "CreateBranch"]);
Route::post("/update-branch", [BranchesController::class, "UpdateBranch"]);





/*
|----------------------------------------
| Branch Managers
|----------------------------------------
*/
Route::get("/get-all-branch-managers", [BranchManagerController::class, "GetAllBranchManagers"]);

Route::post("/create-branch-manager", [BranchManagerController::class, "CreateBranchManager"]);





/*
|----------------------------------------
| Orders
|----------------------------------------
*/
Route::get("/get-all-orders", [OrdersController::class, "GetAllOrders"]);
Route::get("/get-all-orders-with", [OrdersController::class, "GetAllOrdersWith"]);
Route::get("/get-order-informations", [OrdersController::class, "GetOrderInformation"]);

Route::post("/create-order", [OrdersController::class, "CreateOrder"]);





/*
|----------------------------------------
| Menu Week Cycle
|----------------------------------------
*/
Route::post("/create-menu-week-cycle", [MenuWeekCycleController::class, "CreateMenuCycle"]);
Route::get("/create-menu-week-cycle-where-order-window/{orderWindow}", [MenuWeekCycleController::class, "GetAllMenuWeekCyclesWhereOrderWindow"]);





/*
|----------------------------------------
| Market Lists Bakeshop Categories
|----------------------------------------
*/
Route::get("/get-all-mlbakeshop-categories", [MlBakeshopCategoryController::class, "GetAllMlBakeshopCategories"]);

Route::post("/create-mlbakeshop-category", [MlBakeshopCategoryController::class, "CreateBakeshopCategory"]);
Route::post("/update-mlbakeshop-category", [MlBakeshopCategoryController::class, "UpdateBakeshopCategory"]);
Route::post("/delete-mlbakeshop-category", [MlBakeshopCategoryController::class, "DeleteBakeshopCategory"]);





/*
|----------------------------------------
| Market Lists Bakeshop Items
|----------------------------------------
*/
Route::get("/get-all-mlbakeshop-items", [MlBakeshopItemController::class, "GetAllMLBakeshopItems"]);




/*
|----------------------------------------
| Market Lists Bakeshop Orders
|----------------------------------------
*/
Route::get("/get-all-mlbakeshop-orders-with", [MlBakeshopOrdersController::class, "GetAllMlBakeshopOrdersWith"]);

Route::post("/create-mlbakeshop-order", [MlBakeshopOrdersController::class, "CreateMlBakeshopOrder"]);





/*
|----------------------------------------
| Market Lists Rawmat Orders
|----------------------------------------
*/
Route::get("/get-all-mlrawmat-orders-with", [MlRawmatOrdersController::class, "GetAllMlRawmatOrdersWith"]);

Route::post("/create-mlrawmat-order", [MlRawmatOrdersController::class, "CreateMlRawmatOrder"]);





/*
|----------------------------------------
| Market Lists Rawmat Categories
|----------------------------------------
*/
Route::get("/get-all-mlrawmat-categories", [MlRawmatCategoryController::class, "GetAllMlRawmatCategories"]);





/*
|----------------------------------------
| Market Lists Rawmat Items
|----------------------------------------
*/
Route::get("/get-all-mlrawmat-items", [MlRawmatItemController::class, "GetAllMlRawmatItems"]);