<?php

use App\Http\Controllers\Api\AreaManagersController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\BranchesController;
use App\Http\Controllers\Api\BranchManagerController;
use App\Http\Controllers\Api\MenuController;
use App\Http\Controllers\Api\MenuDishesCategoriesController;
use App\Http\Controllers\Api\MenuDishesController;
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
| Menu 
|----------------------------------------
*/
Route::get('/get-all-menus', [MenuController::class, "GetAllMenus"]);
Route::get('/get-all-menus-where-week/{week}', [MenuController::class, "GetAllMenusWhereWeek"]);
Route::get('/get-menu-by-id/{id}', [MenuController::class, "GetMenuById"]);

Route::post('/create-menus', [MenuController::class, "CreateMenu"]);
Route::post('/create-menus-via-excel', [MenuController::class, "CreateMenuViaExcel"]);





/*
|----------------------------------------
| Menu Dishes Categories
|----------------------------------------
*/
Route::get('/get-all-menu-dishes-categories', [MenuDishesCategoriesController::class, "GetAllCategories"]);





/*
|----------------------------------------
| Menu Dishes
|----------------------------------------
*/
Route::post("/create-menu-dish", [MenuDishesController::class, "CreateDishes"]);

Route::post("/create-menu-dish-via-excel", [MenuDishesController::class, "CreateDishesViaExcel"]);





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