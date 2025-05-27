import { Modal, Input, Button } from "antd";
import { ChangeEvent, FormEvent, useState } from "react";
import { isEmptyOrSpaces, notify } from "../../assets/lib/utils";
import axiosClient from "../../axios-client";
import { MenuSubCategoryStructure } from "../../types/menuSubCategoryStucture";

interface SuperAdminAddMenuSubCategoryModalTypes {
    setMenuSubCategories: React.Dispatch<React.SetStateAction<MenuSubCategoryStructure[] | null>>;
    onClose: () => void
}

const SuperAdminAddMenuSubCategoryModal: React.FC<SuperAdminAddMenuSubCategoryModalTypes> = ({setMenuSubCategories, onClose}) => {
    const [isAdding, setIsAdding] = useState<boolean>(false);

    const [menuSubCategoryIn, setMenuSubCategoryIn] = useState({
        sub_category: ""
    });



    /**
     * Checkers
     */
    const isSubmitBtnDisabled = isEmptyOrSpaces(menuSubCategoryIn.sub_category);



    /**
     * Handlers
     */
    const handleSubmit = (e: FormEvent<HTMLFormElement>) => {
        e.preventDefault();
        setIsAdding(true);


        const formData = new FormData();
        formData.append("menuSubCategoryIn", JSON.stringify(menuSubCategoryIn));

        axiosClient.post("/create-menu-sub-category", formData)
        .then(async ({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);

            if(data.status === 200) {
                setMenuSubCategories(data.menu_sub_categories);
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
        setMenuSubCategoryIn(prev => ({...prev, [e.target.name]: e.target.value}));
    }

    const clearFields = () => {
        setMenuSubCategoryIn({
            sub_category: ""
        })
    }




    /**
     * Render
     */
    return(
        <Modal
        title="Add Menu Tag"
        open={true}
        onCancel={onClose}
        footer={null}
        width={650}
        >
            <form onSubmit={handleSubmit} className="mar-top-1">

                {/* Tag */}
                <div className="mar-bottom-1">
                    <label htmlFor="sub_category">Sub Category</label>
                    <Input
                    className="mar-bottom-3"
                    size="large"
                    id="sub_category"
                    name="sub_category"
                    placeholder="Input menu sub-category e.g. Rice"
                    value={menuSubCategoryIn.sub_category}
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

export default SuperAdminAddMenuSubCategoryModal;