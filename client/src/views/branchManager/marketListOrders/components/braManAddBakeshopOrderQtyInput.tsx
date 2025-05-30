import { InputNumber } from "antd";
import { useEffect, useState } from "react";
import React from "react";
import { SelectedBakeshopItemsInType } from "../braManMarketListAddBakeshopOrders";

interface QtyInputProps {
    row: any;
    setSelectedBakeshopItemsIn: React.Dispatch<React.SetStateAction<SelectedBakeshopItemsInType[]>>;
}

const BranchManagerAddBakeshopOrderQtyInput: React.FC<QtyInputProps> = React.memo(({ row, setSelectedBakeshopItemsIn }) => {
    const [localQty, setLocalQty] = useState<number | null>(row.qty_selected);

    useEffect(() => {
        setLocalQty(row.qty_selected ?? 0);
    }, [row.qty_selected]);

    const handleBlur = () => {
        const finalQty = localQty == null || isNaN(localQty) ? 0 : localQty;

        setLocalQty(finalQty); // Reset local state to 0 if cleared

        setSelectedBakeshopItemsIn(prev => {
            if (!prev) return [];
            
            return prev.map(dish => {
                if (dish.ml_bakeshop_item_id === row.ml_bakeshop_item_id) {
                    
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

export default BranchManagerAddBakeshopOrderQtyInput;
