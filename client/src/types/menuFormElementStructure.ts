import { MenuClassStructure } from "./menuClassStructure";
import { MenuShiftStructure } from "./menuShiftStructure";

export interface MenuFormElementStructure {
    id: number;
    menu_shift_id: number;
    menu_class_id: number; 
    created_type: string | Date;
    updated_at: string | Date;



    /**
     * Foreign joins
     */
    menu_shift: MenuShiftStructure;
    menu_class: MenuClassStructure;
}