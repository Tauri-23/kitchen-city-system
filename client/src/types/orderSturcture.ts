import { BranchStructure } from "./branchStructure";
import { OrderItemStructure } from "./orderItemSturcture";

export interface OrderStructure {
    id: string;
    branch_id: string | null;
    deadline: string | Date | null;
    total_cost: number;
    status: "Open" | "Pending" | "Completed" | "Cancelled";
    completed_at: string | Date | null;
    cancelled_at: string | Date | null;
    created_at: string | Date;
    updated_at: string | Date;

    /**
     * Joins
     */
    order_items: OrderItemStructure[];
    branch: BranchStructure;
}