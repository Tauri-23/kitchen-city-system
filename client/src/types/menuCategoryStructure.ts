import { MenuShiftStructure } from "./menuShiftStructure";
import { MenuTagStructure } from "./menuTagStructure";

export interface MenuCategoryStructure {
    key: string;
    id: number;
    shift_id: number;
    category: string;
    created_type: string | Date;
    updated_at: string | Date;

    /**
     * Foreign Joins
     */
    shift: MenuShiftStructure
    menu_tags: MenuTagStructure[]
}