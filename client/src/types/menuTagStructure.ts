import { MenuCategoryStructure } from "./menuCategoryStructure";

export interface MenuTagStructure {
    id: number;
    menu_category_id: number;
    tag: string;
    created_type: string | Date;
    updated_at: string | Date;

    /**
     * Foreign Joins
     */
    category: MenuCategoryStructure;
}