import { InputNumber } from "antd";
import { useEffect, useState } from "react";
import React from "react";
import { SelectedRawmatItemsInType } from "../braManMarketListAddRawmatOrders";

interface QtyInputProps {
    row: any;
    setSelectedRawmatItemsIn: React.Dispatch<React.SetStateAction<SelectedRawmatItemsInType[]>>;
}

const BranchManagerAddRawmatOrderQtyInput: React.FC<QtyInputProps> = React.memo(({ row, setSelectedRawmatItemsIn }) => {
    const [localQty, setLocalQty] = useState<number | null>(row.qty_selected);

    useEffect(() => {
        setLocalQty(row.qty_selected ?? 0);
    }, [row.qty_selected]);

    const handleBlur = () => {
        const finalQty = localQty == null || isNaN(localQty) ? 0 : localQty;

        setLocalQty(finalQty); // Reset local state to 0 if cleared

        setSelectedRawmatItemsIn(prev => {
            if (!prev) return [];
            
            return prev.map(dish => {
                if (dish.ml_rawmat_item_id === row.ml_rawmat_item_id) {
                    
                    return { ...dish, qty_selected: finalQty };
                }
                return dish;
            });
        });

    };

    return (
        <InputNumber
            size="small"
            className="w-100"
            style={{ width: 100 }}
            value={localQty}
            min={0}
            maxLength={1000}
            onChange={(val) => setLocalQty(val)} // don’t override null yet
            onBlur={handleBlur}
        />
    );
});

export default BranchManagerAddRawmatOrderQtyInput;
