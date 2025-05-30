import { BranchStructure } from "./branchStructure";
import { MlBakeshopOrderItemStructure } from "./mlBakeshopOrderItemSturcture";

export default interface MlBakeshopOrderStructure {
    id: string;
    branch_id: string;
    deadline: Date;
    total_cost: number
    status: "Open" | "Pending" | "Completed" | "Cancelled";
    completed_at: Date | null;
    cancelled_at: Date | null;

    created_at: Date | null;
    updated_at: Date | null;



    /**
     * Foreign Joins
     */
    ml_bakeshop_order_items: MlBakeshopOrderItemStructure[];
    branch: BranchStructure;
}