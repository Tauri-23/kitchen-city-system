export interface MenuStructure {
    id: string;
    menu_name: string | null;
    menu_week: number;
    meal_type: "Breakfast" |"Lunch" | "Snack" | "Dinner" | "Midnight Lunch" | "Midnight Snack";
    created_type: string | Date;
    updated_at: string | Date;
}