import { Modal, Button, Select } from "antd";
import { ChangeEvent, FormEvent, useState } from "react";
import { notify } from "../../assets/lib/utils";
import axiosClient from "../../axios-client";
import { MenuFormElementStructure } from "../../types/menuFormElementStructure";
import { MenuClassStructure } from "../../types/menuClassStructure";
import { MenuShiftStructure } from "../../types/menuShiftStructure";

interface SuperAdminAddMenuFormElementModalTypes {
    setmenuFormElements: React.Dispatch<React.SetStateAction<MenuFormElementStructure[] | null>>;
    selectedShift: MenuShiftStructure;
    menuClasses: MenuClassStructure[];
    onClose: () => void
}

const SuperAdminAddMenuFormElementModal: React.FC<SuperAdminAddMenuFormElementModalTypes> = ({setmenuFormElements, selectedShift, menuClasses, onClose}) => {
    const [isAdding, setIsAdding] = useState<boolean>(false);

    const [menuFormElementIn, setMenuFormElementIn] = useState({
        menu_shift_id: selectedShift.id,
        menu_class_id: "",
    });



    /**
     * Checkers
     */
    const isSubmitBtnDisabled = menuFormElementIn.menu_class_id === "";



    /**
     * Handlers
     */
    const handleSubmit = (e: FormEvent<HTMLFormElement>) => {
        e.preventDefault();
        setIsAdding(true);


        const formData = new FormData();
        formData.append("menuFormElementIn", JSON.stringify(menuFormElementIn));

        axiosClient.post("/create-menu-form-element", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);

            if(data.status === 200) {
                setmenuFormElements(data.menuFormElements);
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
        setMenuFormElementIn(prev => ({...prev, [e.target.name]: e.target.value}));
    }

    const clearFields = () => {
        setMenuFormElementIn({
            menu_shift_id: selectedShift.id,
            menu_class_id: "",
        })
    }




    /**
     * Render
     */
    return(
        <Modal
        title="Add Menu Element"
        open={true}
        onCancel={onClose}
        footer={null}
        width={650}
        >
            <form onSubmit={handleSubmit} className="mar-top-1">

                <h5 className="mar-bottom-1 fw-bold">For {selectedShift.shift}</h5>

                {/* Tag */}
                <div className="mar-bottom-1">
                    <label htmlFor="menu_class_id">Select Class</label>
                    <Select
                    className="w-100"
                    size="large"
                    id="menu_class_id"
                    options={[
                        {label: "Select a menu class", value: ""},
                        ...menuClasses.map(item => ({label: item.class, value: item.id}))
                    ]}
                    value={menuFormElementIn.menu_class_id}
                    onChange={(val) => handleInputChange({target: {name: "menu_class_id", value: val}} as ChangeEvent<HTMLInputElement>)}/>
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

export default SuperAdminAddMenuFormElementModal;