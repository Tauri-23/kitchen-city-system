import { AreaManagerStructure } from "./areaManagerSturcture";

export interface BranchStructure {
    id: string;
    branch_code: string;
    name: string;
    address: string;
    area_manager_id: string;
    area_manager: AreaManagerStructure;
    size: "XL" | "Large" | "Medium" | "Medium Frying" | "Small" | "Small Frying";
    status: "Active" | "Suspended" | "Discontinued";
    created_at: string | Date;
    updated_at: string | Date;
}