import { MenuSubCategoryStructure } from "./menuSubCategoryStucture";

export interface MenuDishStructure {
    id: string;
    menu_to_dish_tag: string;
    dish_code: string | null;
    name: string;
    sub_category_id: number;
    unit_cost: number;
    production: "Commis" | "Commis Cooked" | "On Site";
    status: "Active" | "Discontinued";
    created_type: string | Date;
    updated_at: string | Date;


    
    // Foreign Joins
    sub_category: MenuSubCategoryStructure;



    // Optionals
    qtySelected: number;
}