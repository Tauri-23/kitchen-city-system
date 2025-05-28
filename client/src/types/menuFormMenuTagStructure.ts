import { MenuFormClassStructure } from "./menuFormClassStructure";
import { MenuTagStructure } from "./menuTagStructure";

export interface MenuFormMenuTagStructure {
    id: number;
    menu_form_class_id: number;
    menu_tag_id: number;
    created_at: string | Date;
    updated_at: string | Date;



    /**
     * Foreign Joins
     */
    menu_form_class: MenuFormClassStructure;
    menu_tag: MenuTagStructure;
}