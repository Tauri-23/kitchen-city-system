import { Modal, Input, Button } from "antd";
import { ChangeEvent, FormEvent, useState } from "react";
import { isEmptyOrSpaces, notify } from "../../assets/lib/utils";
import axiosClient from "../../axios-client";
import { MenuCategoryStructure } from "../../types/menuCategoryStructure";

interface SuperAdminAddMenuCategoryTypes {
    setMenuCategories: React.Dispatch<React.SetStateAction<MenuCategoryStructure[] | null>>;
    onClose: () => void
}

const SuperAdminAddMenuCategoryModal: React.FC<SuperAdminAddMenuCategoryTypes> = ({setMenuCategories, onClose}) => {
    const [isAdding, setIsAdding] = useState<boolean>(false);

    const [menuCategoryIn, setMenuCategoryIn] = useState({
        category: ""
    });



    /**
     * Checkers
     */
    const isSubmitBtnDisabled = isEmptyOrSpaces(menuCategoryIn.category);



    /**
     * Handlers
     */
    const handleSubmit = (e: FormEvent<HTMLFormElement>) => {
        e.preventDefault();
        setIsAdding(true);


        const formData = new FormData();
        formData.append("menuCategoryIn", JSON.stringify(menuCategoryIn));

        axiosClient.post("/create-menu-category", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);

            if(data.status === 200) {
                setMenuCategories(prev => [...(prev || []), data.newCategory]);
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
        setMenuCategoryIn(prev => ({...prev, [e.target.name]: e.target.value}));
    }

    const clearFields = () => {
        setMenuCategoryIn({
            category: ""
        })
    }




    /**
     * Render
     */
    return(
        <Modal
        title="Add Menu Categories"
        open={true}
        onCancel={onClose}
        footer={null}
        width={650}
        >
            <form onSubmit={handleSubmit} className="mar-top-1">

                {/* Tag */}
                <div className="mar-bottom-1">
                    <label htmlFor="category">Category</label>
                    <Input
                    size="large"
                    id="category"
                    name="category"
                    value={menuCategoryIn.category}
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

export default SuperAdminAddMenuCategoryModal;