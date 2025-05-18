import { Modal, Input, Button } from "antd";
import { ChangeEvent, FormEvent, useState } from "react";
import { isEmptyOrSpaces, notify } from "../../assets/lib/utils";
import axiosClient from "../../axios-client";
import { MenuShiftStructure } from "../../types/menuShiftStructure";

interface SuperAdminAddMenuShiftModalTypes {
    setShifts: React.Dispatch<React.SetStateAction<MenuShiftStructure[] | null>>;
    onClose: () => void
}

const SuperAdminAddMenuShiftModal: React.FC<SuperAdminAddMenuShiftModalTypes> = ({setShifts, onClose}) => {
    const [isAdding, setIsAdding] = useState<boolean>(false);

    const [menuShiftIn, setMenuShiftIn] = useState({
        shift: ""
    });



    /**
     * Checkers
     */
    const isSubmitBtnDisabled = isEmptyOrSpaces(menuShiftIn.shift);



    /**
     * Handlers
     */
    const handleSubmit = (e: FormEvent<HTMLFormElement>) => {
        e.preventDefault();
        setIsAdding(true);


        const formData = new FormData();
        formData.append("menuShiftIn", JSON.stringify(menuShiftIn));

        axiosClient.post("/create-menu-shift", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);

            if(data.status === 200) {
                setShifts((prev) => (prev ? [...prev, data.newShift] : []));
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
        setMenuShiftIn(prev => ({...prev, [e.target.name]: e.target.value}));
    }

    const clearFields = () => {
        setMenuShiftIn({
            shift: ""
        })
    }




    /**
     * Render
     */
    return(
        <Modal
        title="Add Menu Shift"
        open={true}
        onCancel={onClose}
        footer={null}
        width={650}
        >
            <form onSubmit={handleSubmit} className="mar-top-1">

                {/* Tag */}
                <div className="mar-bottom-1">
                    <label htmlFor="shift">Shift</label>
                    <Input
                    size="large"
                    id="shift"
                    name="shift"
                    value={menuShiftIn.shift}
                    onChange={handleInputChange}/>
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

export default SuperAdminAddMenuShiftModal;