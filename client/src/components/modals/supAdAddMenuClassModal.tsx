import { Modal, Input, Button } from "antd";
import { ChangeEvent, FormEvent, useState } from "react";
import { isEmptyOrSpaces, notify } from "../../assets/lib/utils";
import axiosClient from "../../axios-client";
import { MenuClassStructure } from "../../types/menuClassStructure";

interface SuperAdminAddMenuClassTypes {
    setMenuClasses: React.Dispatch<React.SetStateAction<MenuClassStructure[] | null>>;
    onClose: () => void
}

const SuperAdminAddMenuClassModal: React.FC<SuperAdminAddMenuClassTypes> = ({setMenuClasses, onClose}) => {
    const [isAdding, setIsAdding] = useState<boolean>(false);

    const [menuClassIn, setMenuClassIn] = useState({
        class: ""
    });



    /**
     * Checkers
     */
    const isSubmitBtnDisabled = isEmptyOrSpaces(menuClassIn.class);



    /**
     * Handlers
     */
    const handleSubmit = (e: FormEvent<HTMLFormElement>) => {
        e.preventDefault();
        setIsAdding(true);


        const formData = new FormData();
        formData.append("menuClassIn", JSON.stringify(menuClassIn));

        axiosClient.post("/create-menu-class", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);

            if(data.status === 200) {
                setMenuClasses(prev => [...(prev || []), data.newClass]);
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
        setMenuClassIn(prev => ({...prev, [e.target.name]: e.target.value}));
    }

    const clearFields = () => {
        setMenuClassIn({
            class: ""
        })
    }




    /**
     * Render
     */
    return(
        <Modal
        title="Add Menu Class"
        open={true}
        onCancel={onClose}
        footer={null}
        width={650}
        >
            <form onSubmit={handleSubmit} className="mar-top-1">

                {/* Tag */}
                <div className="mar-bottom-1">
                    <label htmlFor="class">Class</label>
                    <Input
                    size="large"
                    id="class"
                    name="class"
                    value={menuClassIn.class}
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

export default SuperAdminAddMenuClassModal;