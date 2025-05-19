import { MenuCategoryStructure } from "./menuCategoryStructure";
import { MenuSubCategoryStructure } from "./menuSubCategoryStucture";

export interface MenuTagStructure {
    id: number;
    menu_category_id: number;
    menu_sub_category_id: number;
    tag: string;
    created_type: string | Date;
    updated_at: string | Date;

    /**
     * Foreign Joins
     */
    category: MenuCategoryStructure;
    sub_category: MenuSubCategoryStructure;
}