import { Modal, Input, Button } from "antd";
import { ChangeEvent, FormEvent, useState } from "react";
import { isEmptyOrSpaces, notify } from "../../assets/lib/utils";
import axiosClient from "../../axios-client";
import { MenuShiftStructure } from "../../types/menuShiftStructure";
import { MenuCategoryStructure } from "../../types/menuCategoryStructure";

interface SuperAdminAddMenuCategoryTypes {
    category: MenuCategoryStructure;
    shift: MenuShiftStructure;
    setShifts: React.Dispatch<React.SetStateAction<MenuShiftStructure[] | null>>;
    onClose: () => void
}

const SuperAdminAddMenuCategoryModal: React.FC<SuperAdminAddMenuCategoryTypes> = ({category, shift, setShifts, onClose}) => {
    const [isAdding, setIsAdding] = useState<boolean>(false);

    const [menuTagIn, setMenuTagIn] = useState({
        menu_category_id: category.id,
        tag: ""
    });



    /**
     * Checkers
     */
    const isSubmitBtnDisabled = isEmptyOrSpaces(menuTagIn.tag);



    /**
     * Handlers
     */
    const handleSubmit = (e: FormEvent<HTMLFormElement>) => {
        e.preventDefault();
        setIsAdding(true);


        const formData = new FormData();
        formData.append("menuTagIn", JSON.stringify(menuTagIn));

        axiosClient.post("/create-menu-tag", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);

            if(data.status === 200) {
                setShifts((prev) => {
                    if (!prev) return prev; // handle null

                    const updated = prev.map(shiftPrev => {
                        if (shiftPrev.id !== shift.id) return shiftPrev;

                        return {
                            ...shiftPrev,
                            categories: shiftPrev.categories.map(categoryPrev => {
                                if (categoryPrev.id !== category.id) return categoryPrev;

                                return {
                                    ...categoryPrev,
                                    menu_tags: [...categoryPrev.menu_tags, data.menu_tag]
                                };
                            })
                        };
                    });

                    return updated;
                });
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
        setMenuTagIn(prev => ({...prev, [e.target.name]: e.target.value}));
    }

    const clearFields = () => {
        setMenuTagIn({
            menu_category_id: category.id,
            tag: ""
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

                <h4 className="fw-bold mar-bottom-2">For {category.category} {shift.shift}</h4>

                {/* Tag */}
                <div className="mar-bottom-1">
                    <label htmlFor="tag">Menu Tag</label>
                    <Input
                    size="large"
                    id="tag"
                    name="tag"
                    value={menuTagIn.tag}
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