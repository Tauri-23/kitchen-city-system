import { MenuCategoryStructure } from "./menuCategoryStructure";
import { MenuClassStructure } from "./menuClassStructure";
import { MenuSubCategoryStructure } from "./menuSubCategoryStucture";

export interface MenuDishStructure {
    id: string;
    dish_code: string | null;
    name: string;
    menu_class_id: number;
    menu_category_id: number;
    menu_sub_category_id: number;
    unit_cost: number;
    srp: number;
    production: "Commis" | "Commis Cooked" | "On Site";
    status: "Active" | "Discontinued";

    created_type: string | Date;
    updated_at: string | Date;


    
    // Foreign Joins
    menu_class: MenuClassStructure;
    menu_category: MenuCategoryStructure;
    menu_sub_category: MenuSubCategoryStructure;



    // Optionals
    qtySelected: number;
}