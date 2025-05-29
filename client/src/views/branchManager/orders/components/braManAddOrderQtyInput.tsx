import { InputNumber } from "antd";
import { useEffect, useState } from "react";
import { SelectedMenusType } from "../braManAddOrder";
import React from "react";

interface QtyInputProps {
    row: any;
    setSelectedMenusIn: React.Dispatch<React.SetStateAction<SelectedMenusType[]>>;
}

const BranchManagerAddOrderQtyInput: React.FC<QtyInputProps> = React.memo(({ row, setSelectedMenusIn }) => {
    const [localQty, setLocalQty] = useState<number | null>(row.qty_selected);

    useEffect(() => {
        setLocalQty(row.qty_selected ?? 0);
    }, [row.qty_selected]);

    const handleBlur = () => {
        const finalQty = localQty == null || isNaN(localQty) ? 0 : localQty;

        setLocalQty(finalQty); // Reset local state to 0 if cleared

        setSelectedMenusIn(prev => {
            if (!prev) return [];
            
            return prev.map(dish => {
                if (
                    dish.menu_shift_id === row.menu_shift_id &&
                    dish.menu_dish_id === row.dish.id
                ) {
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

export default BranchManagerAddOrderQtyInput;
