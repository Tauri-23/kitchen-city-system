import { MenuClassStructure } from "./menuClassStructure";
import { MenuShiftStructure } from "./menuShiftStructure";

export interface MenuFormClassStructure {
    id: number;
    menu_shift_id: number;
    menu_class_id: number;
    created_at: string | Date;
    updated_at: string | Date;


    
    /**
     * Foreign Joins
     */
    menu_shift: MenuShiftStructure;
    menu_class: MenuClassStructure;
}