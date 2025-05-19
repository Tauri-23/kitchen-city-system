import { MenuTagStructure } from "./menuTagStructure";

export interface MenuCategoryStructure {
    id: number;
    category: string;
    created_type: string | Date;
    updated_at: string | Date;


    /**
     * Foreign Joins
     */
    menu_tags: MenuTagStructure[]
}