<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\MenuController;
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
Route::post("/logout", [AuthController::class, "Logout"]);





/*
|----------------------------------------
| Menu 
|----------------------------------------
*/
Route::get('/get-all-menus', [MenuController::class, "GetAllMenus"]);
