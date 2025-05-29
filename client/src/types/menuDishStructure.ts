import { MenuCategoryStructure } from "./menuCategoryStructure";
import { MenuProductionStructure } from "./menuProductionStructure";
import { MenuSubCategoryStructure } from "./menuSubCategoryStucture";
import { MenuTagStructure } from "./menuTagStructure";
import { MenuUomStructure } from "./menuUomStructure";

export interface MenuDishStructure {
    id: string;

    odoo_description: string;
    system_description: string;

    menu_tag_id: number;
    menu_category_id: number;
    menu_sub_category_id: number;

    unit_cost: number;
    srp: number;

    uom_id: number;

    odoo_code: string;

    production_id: number;
    status: "Active" | "Discontinued";

    created_type: string | Date;
    updated_at: string | Date;


    
    /**
     * Foriegn Joins
     */
    menu_tag: MenuTagStructure;
    menu_category: MenuCategoryStructure;
    menu_sub_category: MenuSubCategoryStructure;
    uom: MenuUomStructure;
    production: MenuProductionStructure;



    // Optionals
    qtySelected: number;
}