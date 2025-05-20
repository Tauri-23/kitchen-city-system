import { Modal, Input, Button, Select } from "antd";
import { ChangeEvent, FormEvent, useState } from "react";
import { isEmptyOrSpaces, notify } from "../../assets/lib/utils";
import axiosClient from "../../axios-client";
import { MenuSubCategoryStructure } from "../../types/menuSubCategoryStucture";
import { MenuClassStructure } from "../../types/menuClassStructure";

interface SuperAdminAddMenuTagModalTypes {
    menuSubCategories: MenuSubCategoryStructure[];
    menuClass: MenuClassStructure;
    setMenuClasses: React.Dispatch<React.SetStateAction<MenuClassStructure[] | null>>;
    onClose: () => void
}

const SuperAdminAddMenuTagModal: React.FC<SuperAdminAddMenuTagModalTypes> = ({menuSubCategories, menuClass, setMenuClasses, onClose}) => {
    const [isAdding, setIsAdding] = useState<boolean>(false);

    const [menuTagIn, setMenuTagIn] = useState({
        menu_class_id: menuClass.id,
        menu_sub_category_id: "",
        tag: ""
    });



    /**
     * Checkers
     */
    const isSubmitBtnDisabled = isEmptyOrSpaces(menuTagIn.tag) || menuTagIn.menu_sub_category_id === "";



    /**
     * Handlers
     */
    const handleSubmit = (e: FormEvent<HTMLFormElement>) => {
        e.preventDefault();
        setIsAdding(true);


        const formData = new FormData();
        formData.append("menuTagIn", JSON.stringify(menuTagIn));

        axiosClient.post("/create-menu-tag", formData)
        .then(async ({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);

            if(data.status === 200) {
                setMenuClasses((prev) => {
                    if (!prev) return prev; // handle null

                    const updated = prev.map(menuClassPrev => {
                        if (menuClassPrev.id !== menuClass.id) return menuClassPrev;

                        return {
                            ...menuClassPrev,
                            menu_tags: [...menuClassPrev.menu_tags, data.menu_tag]
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
            menu_class_id: menuClass.id,
            menu_sub_category_id: "",
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

                <h4 className="fw-bold mar-bottom-2">For {menuClass.class}</h4>

                {/* Tag */}
                <div className="mar-bottom-1">
                    <label htmlFor="tag">Menu Tag</label>
                    <Input
                    className="mar-bottom-3"
                    size="large"
                    id="tag"
                    name="tag"
                    placeholder="Input menu tag e.g. Egg 1"
                    value={menuTagIn.tag}
                    onChange={handleInputChange}/>

                    <label htmlFor="menu_sub_category_id">Sub Category</label>
                    <Select
                    size="large"
                    className="w-100"
                    id="menu_sub_category_id"
                    showSearch
                    value={menuTagIn.menu_sub_category_id}
                    options={[
                        {label: "Select menu class", value: ""},
                        ...menuSubCategories.map(item => ({label: item.sub_category, value: item.id}))
                    ]}
                    onChange={(value) => handleInputChange({target: {name:"menu_sub_category_id", value: value}} as ChangeEvent<HTMLInputElement>)}
                    filterOption={(input, option) =>
                        (option?.label ?? "")
                            .toString()
                            .toLowerCase()
                            .includes(input.toLowerCase())
                    }
                    />
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

export default SuperAdminAddMenuTagModal;