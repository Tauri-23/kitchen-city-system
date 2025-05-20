import { MenuTagStructure } from "./menuTagStructure";

export interface MenuClassStructure {
    id: number;
    class: string;
    created_type: string | Date;
    updated_at: string | Date;


    /**
     * Foreign Joins
     */
    menu_tags: MenuTagStructure[]
}