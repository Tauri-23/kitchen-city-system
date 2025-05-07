import { Button, InputNumber, Modal } from "antd";
import { MenuStructure } from "../../types/menuStructure";
import { FormEvent, useState } from "react";
import { MenuDishStructure } from "../../types/menuDishStructure";
import { formatToPhilPeso, notify } from "../../assets/lib/utils";

interface BranchManagerAddOrderModalTypes {
    menuDish: MenuDishStructure;
    processedMenus: MenuStructure[];
    setprocessedMenus: (value: MenuStructure[]) => void;
    onClose: () => void;
}

const BranchManagerAddOrderModal: React.FC<BranchManagerAddOrderModalTypes> = ({menuDish, processedMenus, setprocessedMenus, onClose}) => {
    const [qty, setQty] = useState<number>(menuDish.qtySelected);



    /**
     * Handlers
     */
    const handleAdd = (e: FormEvent<HTMLFormElement>) => {
        e.preventDefault();

        const updatedMenus = processedMenus.map(menu => {
            const updatedDishes = menu.menu_dishes
                ? menu.menu_dishes.map(dish => {
                    if (dish.id === menuDish.id) {
                        return {
                            ...dish,
                            qtySelected: qty
                        };
                    }
                    return dish;
                })
                : null;
        
            return {
                ...menu,
                menu_dishes: updatedDishes
            };
        });
    
        setprocessedMenus(updatedMenus);

        notify("success", "Order added", "top-center", 3000);

        onClose();
    }



    /**
     * Render
     */
    return(
        <Modal
        title="Add Order"
        open={true}
        onCancel={onClose}
        footer={null}
        width={650}
        >
            <form onSubmit={handleAdd} className="mar-top-1">
                <div>{menuDish.name}</div>
                <div className="text-l3 fw-bold">{menuDish.odoo_name}</div>
                <div className="text-m2">Unit Cost: {formatToPhilPeso(menuDish.unit_cost)}</div>
                <div className="text-m2 mar-bottom-1">Total Cost: {formatToPhilPeso(menuDish.unit_cost * qty)}</div>

                {/* Qty */}
                <div className="mar-bottom-1">
                    <label htmlFor="qty">Quantity</label>
                    <InputNumber
                    className="w-100"
                    size="large"
                    id="qty"
                    name="qty"
                    placeholder="e.g. John@domain.com"
                    value={qty}
                    min={0}
                    max={100}
                    onChange={(value) => setQty(value ?? 0)} // 👈 handles number | null
                    />
                </div>

                <div className="d-flex justify-content-end gap3 align-items-center">
                    <Button 
                    size="large"
                    onClick={onClose}
                    >
                        Cancel
                    </Button>

                    <Button 
                    size="large"
                    type="primary"
                    htmlType="submit"
                    >
                        Add
                    </Button>
                </div>
            </form>

        </Modal>
    )
}

export default BranchManagerAddOrderModal;