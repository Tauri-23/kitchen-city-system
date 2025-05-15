import { MenuShiftStructure } from "./menuShiftStructure";

export interface MenuCategoryStructure {
    id: number;
    shift_id: number;
    category: string;
    created_type: string | Date;
    updated_at: string | Date;

    /**
     * Foreign Joins
     */
    shift: MenuShiftStructure
}