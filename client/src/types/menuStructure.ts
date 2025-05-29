import { MenuDishStructure } from "./menuDishStructure";
import { MenuShiftStructure } from "./menuShiftStructure";

export interface MenuStructure {
    id: string;
    menu_week: number;
    menu_shift_id: number;
    menu_dish_id: string;
    menu_day: "Monday" | "Tuesday" | "Wednesday" | "Thursday" | "Friday" | "Saturday" | "Sunday";
    menu_size: "XL" | "Large" | "Medium" | "Medium Frying" | "Medium No Frying" | "Small" | "Small Frying" | "Small No Frying";
    created_type: string | Date;
    updated_at: string | Date;


    /**
     * Foreign Calls
     */
    menu_shift: MenuShiftStructure;
    menu_dish: MenuDishStructure;
}