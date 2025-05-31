import { Modal, Input, Button } from "antd";
import { ChangeEvent, FormEvent, useState } from "react";
import { isEmptyOrSpaces, notify } from "../../assets/lib/utils";
import axiosClient from "../../axios-client";
import MlBakeshopCategoryStructure from "../../types/mlBakeshopCategoryStructure";

interface SuperAdminAddBakeshopCategoryTypes {
    setBakeshopCategories: React.Dispatch<React.SetStateAction<MlBakeshopCategoryStructure[] | null>>;
    onClose: () => void
}

const SuperAdminAddBakeshopCategoryModal: React.FC<SuperAdminAddBakeshopCategoryTypes> = ({setBakeshopCategories, onClose}) => {
    const [isAdding, setIsAdding] = useState<boolean>(false);

    const [bakeshopCategoryIn, setBakeshopCategoryIn] = useState({
        category: ""
    });



    /**
     * Checkers
     */
    const isSubmitBtnDisabled = isEmptyOrSpaces(bakeshopCategoryIn.category);



    /**
     * Handlers
     */
    const handleSubmit = (e: FormEvent<HTMLFormElement>) => {
        e.preventDefault();
        setIsAdding(true);


        const formData = new FormData();
        formData.append("bakeshopCategoryIn", JSON.stringify(bakeshopCategoryIn));

        axiosClient.post("/create-mlbakeshop-category", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);

            if(data.status === 200) {
                setBakeshopCategories(prev => [...(prev || []), data.newCategory]);
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
        setBakeshopCategoryIn(prev => ({...prev, [e.target.name]: e.target.value}));
    }

    const clearFields = () => {
        setBakeshopCategoryIn({
            category: ""
        })
    }




    /**
     * Render
     */
    return(
        <Modal
        title="Add Bakeshop Categories"
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
                    value={bakeshopCategoryIn.category}
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

export default SuperAdminAddBakeshopCategoryModal;