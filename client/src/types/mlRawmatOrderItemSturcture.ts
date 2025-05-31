import MlRawmatItemStructure from "./mlRawmatItemStructure";

export interface MlRawmatOrderItemStructure {
    id: string;
    ml_rawmat_order_id: string;
    ml_rawmat_item_id: string;
    qty: number;
    unit_cost: number;
    total_cost: number;
    status: "Open" | "Pending" | "Completed" | "Cancelled";
    completed_at: string | Date | null;
    cancelled_at: string | Date | null;
    
    created_at: string | Date;
    updated_at: string | Date;


    /**
     * Foreign Joins
     */
    ml_rawmat_item: MlRawmatItemStructure;
}