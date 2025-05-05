import { MenuDishesCategoryStructure } from "./menuDishesCategoryStucture";
import { MenuStructure } from "./menuStructure";

export interface MenuDishStructure {
    id: string;
    menu_id: MenuStructure | string | null;
    menu: MenuStructure | null;
    name: string;
    odoo_name: string;
    category_id: number | null;
    category: MenuDishesCategoryStructure | null;
    unit_cost: number;
    production: "Commis" | "Commis Cooked" | "On Site";
    status: "Active" | "Discontinued";
    created_type: string | Date;
    updated_at: string | Date;
}