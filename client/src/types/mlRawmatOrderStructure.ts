import { BranchStructure } from "./branchStructure";
import { MlRawmatOrderItemStructure } from "./mlRawmatOrderItemSturcture";

export default interface MlRawmatOrderStructure {
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
    ml_rawmat_order_items: MlRawmatOrderItemStructure[];
    branch: BranchStructure;
}