import { Modal, Input, Button, AutoComplete } from "antd";
import { ChangeEvent, FormEvent, useEffect, useState } from "react";
import { isEmptyOrSpaces, notify } from "../../assets/lib/utils";
import axiosClient from "../../axios-client";
import { MenuShiftStructure } from "../../types/menuShiftStructure";
import { MenuCategoryStructure } from "../../types/menuCategoryStructure";
import { fetchAllUniqueMenuToDishTags } from "../../services/menuTagsServices";

interface SuperAdminAddMenuTagModalTypes {
    category: MenuCategoryStructure;
    shift: MenuShiftStructure;
    setShifts: React.Dispatch<React.SetStateAction<MenuShiftStructure[] | null>>;
    onClose: () => void
}

const SuperAdminAddMenuTagModal: React.FC<SuperAdminAddMenuTagModalTypes> = ({category, shift, setShifts, onClose}) => {
    const [isAdding, setIsAdding] = useState<boolean>(false);
    const [menuToDishTagOptions, setMenuToDishTagOptions] = useState<{value: string | any}[] | null>(null);

    const [menuTagIn, setMenuTagIn] = useState({
        menu_category_id: category.id,
        tag: "",
        menu_to_dish_tag: ""
    });


    /**
     * Onmount
     */
    useEffect(() => {
        const getAll = async() => {
            const uniqueMenuDishTagData = await fetchAllUniqueMenuToDishTags();
            console.log(uniqueMenuDishTagData);
            setMenuToDishTagOptions(uniqueMenuDishTagData);
        }

        getAll();
    }, []);



    /**
     * Checkers
     */
    const isSubmitBtnDisabled = isEmptyOrSpaces(menuTagIn.tag) || isEmptyOrSpaces(menuTagIn.menu_to_dish_tag);



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
                const newUniqueMenuDishTags = await fetchAllUniqueMenuToDishTags();
                setMenuToDishTagOptions(newUniqueMenuDishTags);
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
            tag: "",
            menu_to_dish_tag: ""
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
        loading={!menuToDishTagOptions}
        >
            <form onSubmit={handleSubmit} className="mar-top-1">

                <h4 className="fw-bold mar-bottom-2">For {category.category} {shift.shift}</h4>

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

                    <label htmlFor="menu_to_dish_tag">Menu - Dish Tag</label>
                    <AutoComplete
                    size="large"
                    className="w-100"
                    options={menuToDishTagOptions || []}
                    placeholder="Input menu to dish tag e.g. Egg"
                    filterOption={(inputValue, option) =>
                        option!.value.toLowerCase().includes(inputValue.toLowerCase())
                    }
                    onChange={(value) => handleInputChange({target: {name:"menu_to_dish_tag", value: value}} as ChangeEvent<HTMLInputElement>)}
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