import { Modal, Input, Button, InputNumber, Select } from "antd";
import { ChangeEvent, FormEvent, useState } from "react";
import { isEmptyOrSpaces, notify } from "../../assets/lib/utils";
import axiosClient from "../../axios-client";
import { MenuDishStructure } from "../../types/menuDishStructure";

interface SuperAdminAddMenuDishModalTypes {
    menuToDishtag: string;
    setMenuDishes: React.Dispatch<React.SetStateAction<MenuDishStructure[] | null>>
    onClose: () => void;
}

const SuperAdminAddMenuDishModal: React.FC<SuperAdminAddMenuDishModalTypes> = ({menuToDishtag, setMenuDishes, onClose}) => {
    const [isAdding, setIsAdding] = useState<boolean>(false);

    const productionTypes = ["Commis", "Commis Cooked", "On Site"];

    const [menuDishIn, setMenuDishIn] = useState({
        menu_to_dish_tag: menuToDishtag,
        dish_code: "",
        name: "",
        sub_category: "",
        unit_cost: 0,
        production: "",
    });



    /**
     * Checkers
     */
    const isSubmitBtnDisabled = isEmptyOrSpaces(menuDishIn.name) || menuDishIn.production === "";



    /**
     * Handlers
     */
    const handleSubmit = (e: FormEvent<HTMLFormElement>) => {
        e.preventDefault();
        setIsAdding(true);


        const formData = new FormData();
        formData.append("menuDishIn", JSON.stringify(menuDishIn));

        axiosClient.post("/create-menu-dish", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);

            if(data.status === 200) {
                setMenuDishes(data.updatedMenuDishes);
            }
        })
        .catch(error => {
            console.error(error);
            notify("error", "Server Error", "top-center", 3000);
        })
        .finally(() => {
            setIsAdding(false);
        });
    }

    const handleInputChange = (e: ChangeEvent<HTMLInputElement>) => {
        setMenuDishIn(prev => ({...prev, [e.target.name]: e.target.value}));
    }

    const clearFields = () => {
        setMenuDishIn({
            menu_to_dish_tag: menuToDishtag,
            dish_code: "",
            name: "",
            sub_category: "",
            unit_cost: 0,
            production: "",
        })
    }




    /**
     * Render
     */
    return(
        <Modal
        title="Add Menu Dish"
        open={true}
        onCancel={onClose}
        footer={null}
        width={650}
        >
            <form onSubmit={handleSubmit} className="mar-top-1">

                {/* Fields */}
                <div className="mar-bottom-1">
                    <label htmlFor="dish_code">Dish Code</label>
                    <Input
                    className="mar-bottom-3"
                    size="large"
                    id="dish_code"
                    name="dish_code"
                    value={menuDishIn.dish_code}
                    onChange={handleInputChange}/>

                    <label htmlFor="name">Dish Name (Odoo Name / Description)</label>
                    <Input
                    className="mar-bottom-3"
                    size="large"
                    id="name"
                    name="name"
                    value={menuDishIn.name}
                    onChange={handleInputChange}/>

                    <label htmlFor="unit_cost">Unit Cost</label>
                    <InputNumber
                    className="mar-bottom-3 w-100"
                    size="large"
                    id="unit_cost"
                    name="unit_cost"
                    value={menuDishIn.unit_cost}
                    onChange={(val) => handleInputChange({ target: { name: "unit_cost", value: val } } as unknown as ChangeEvent<HTMLInputElement>)}/>

                    <label htmlFor="production">Production</label>
                    <Select
                    className="mar-bottom-3 w-100"
                    size="large"
                    id="production"
                    options={[
                        {label: "Select Production Type", value: ""},
                        ...productionTypes.map(prod => ({label: prod, value: prod}))
                    ]}
                    value={menuDishIn.production}
                    onChange={(val) => handleInputChange({ target: { name: "production", value: val } } as unknown as ChangeEvent<HTMLInputElement>)}/>                    
                </div>

                {/* Buttons */}
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
                    ghost
                    onClick={clearFields}
                    >
                        Clear
                    </Button>

                    <Button 
                    size="large"
                    type="primary"
                    loading={isAdding}
                    disabled={isSubmitBtnDisabled}
                    htmlType="submit"
                    >
                        Add
                    </Button>
                </div>
            </form>
        </Modal>
    )
}

export default SuperAdminAddMenuDishModal;