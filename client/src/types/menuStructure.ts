import { MenuClassStructure } from "./menuClassStructure";
import { MenuDishStructure } from "./menuDishStructure";
import { MenuSubCategoryStructure } from "./menuSubCategoryStucture";

export interface MenuStructure {
    id: string;
    menu_week: number;
    menu_dish_id: string;
    menu_class_id: number;
    menu_sub_category_id: number;
    menu_day: "Monday" | "Tuesday" | "Wednesday" | "Thursday" | "Friday" | "Saturday" | "Sunday";
    menu_size: "XL" | "Large" | "Medium" | "Medium Frying" | "Small" | "Small Frying";
    created_type: string | Date;
    updated_at: string | Date;


    /**
     * Foreign Calls
     */
    menu_dish: MenuDishStructure;
    menu_class: MenuClassStructure;
    menu_sub_category: MenuSubCategoryStructure;
}