import { MenuDishStructure } from "./menuDishStructure";

export interface MenuStructure {
    id: string;
    menu_name: string | null;
    menu_week: number;
    menu_day: "Monday" | "Tuesday" | "Wednesday" | "Thursday" | "Friday" | "Saturday" | "Sunday";
    meal_type: "Breakfast" |"Lunch" | "Snack" | "Dinner" | "Midnight Lunch" | "Midnight Snack";
    menu_size: "XL" | "Large" | "Medium" | "Medium Frying" | "Small" | "Small Frying";
    menu_dishes: MenuDishStructure[] | null;
    created_type: string | Date;
    updated_at: string | Date;
}