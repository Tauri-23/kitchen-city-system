import { MenuDishStructure } from "./menuDishStructure";
import { OrderStructure } from "./orderSturcture";

export interface OrderItemStructure {
    id: string;
    order_id: string | OrderStructure;
    menu_dish_id: string;
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
    menu_dish: MenuDishStructure;
}