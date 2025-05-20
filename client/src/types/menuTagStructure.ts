import { MenuClassStructure } from "./menuClassStructure";
import { MenuSubCategoryStructure } from "./menuSubCategoryStucture";

export interface MenuTagStructure {
    id: number;
    menu_class_id: number;
    menu_sub_category_id: number;
    tag: string;
    created_type: string | Date;
    updated_at: string | Date;

    /**
     * Foreign Joins
     */
    menu_class: MenuClassStructure;
    sub_category: MenuSubCategoryStructure;
}