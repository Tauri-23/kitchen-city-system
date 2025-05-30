import { Button, Input, Popconfirm, Table, TableColumnsType } from "antd";
import { MenuCategoryStructure } from "../../../../../../types/menuCategoryStructure";
import axiosClient from "../../../../../../axios-client";
import { isEmptyOrSpaces, notify } from "../../../../../../assets/lib/utils";
import { useState } from "react";
import { useGeneralContext } from "../../../../../../contexts/GeneralContext";
import { LuSquareCheckBig, LuSquarePen, LuTrash2 } from "react-icons/lu";
import { GiCancel } from "react-icons/gi";

interface SuperAdminMenuCategoriesSettingsTypes {
    menuCategories: MenuCategoryStructure[], 
    setMenuCategories: React.Dispatch<React.SetStateAction<MenuCategoryStructure[]>>
}

const SuperAdminMenuCategoriesSettings: React.FC<SuperAdminMenuCategoriesSettingsTypes> = ({menuCategories, setMenuCategories}) => {
    const { showModal } = useGeneralContext();
    const [editMenuCategoryIn, setEditMenuCategoryIn] = useState({
        id: 0,
        category: ""
    });



    /**
     * Setup table columns
     */
    const menuCategoriesColumns: TableColumnsType<MenuCategoryStructure> = [
        {
            title: "Category",
            render: (_, row) => {
                if(editMenuCategoryIn.id === row.id) {
                    return(
                        <Input
                        size="small"
                        width={"100%"}
                        value={editMenuCategoryIn.category}
                        onChange={(e) => setEditMenuCategoryIn(prev => ({...prev, category: e.target.value}))}/>
                    )
                }
    
                return row.category
            }
        },
        {
            title: "Actions",
            render: (_, row) => {
                return(
                    <div className="d-flex gap3">
                        {editMenuCategoryIn.id === row.id
                        ? (
                            <>
                                <Button
                                    size="small"
                                    icon={<LuSquareCheckBig />}
                                    color="green"
                                    variant="solid"
                                    disabled={isEmptyOrSpaces(editMenuCategoryIn.category) || editMenuCategoryIn.category === row.category}
                                    onClick={handleEditMenuCategory}
                                />
                                <Button
                                    size="small"
                                    icon={<GiCancel />}
                                    onClick={() => setEditMenuCategoryIn({ id: 0, category: "" })}
                                />
                            </>
                        )
                        : (
                            <>
                                <Button
                                size="small"
                                icon={<LuSquarePen />}
                                onClick={() => setEditMenuCategoryIn({ id: row.id, category: row.category })}
                                color="blue"
                                variant="solid"
                                />
    
                                <Popconfirm
                                    title="Delete this shift"
                                    onConfirm={() => handleDeleteMenuCategory(row.id)}
                                >
                                    <Button
                                    size="small"
                                    icon={<LuTrash2 />}
                                    color="red"
                                    variant="solid"
                                    />
                                </Popconfirm>
                            </>
                        )}
                    </div>
                )
            },
            width: 150
        }
    ];



    /**
     * Categories Handlers
     */
    const handleAddMenuCategory = () => {
        showModal("SuperAdminAddMenuCategoryModal", {
            setMenuCategories
        })
    }

    const handleDeleteMenuCategory = (id: number) => {
        const formData = new FormData();

        formData.append("id", String(id));

        axiosClient.post("/delete-menu-category", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);

            if(data.status === 200) {
                setMenuCategories(prev => ((prev || [])?.filter(cat => cat.id !== id)));
            }
        })
        .catch(error => {
            console.error(error);
            notify("error", "Server Error", "top-center", 3000);
        });
    };

    const handleEditMenuCategory = () => {
        const formData = new FormData();
        formData.append("editMenuCategoryIn", JSON.stringify(editMenuCategoryIn));

        axiosClient.post("/update-menu-category", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);

            if(data.status === 200) {
                setMenuCategories(data.menu_categories);
                setEditMenuCategoryIn({id: 0, category: ""})
            }
        })
        .catch(error => {
            console.error(error);
            notify("error", "Server Error", "top-center", 3000);
        });
    }



    /**
     * Render
     */
    return(
        <>
            <div className="d-flex align-items-center justify-content-between mar-bottom-3">
                <h5 className="fw-bold">Categories</h5>
                <Button
                type="primary"
                onClick={handleAddMenuCategory}>
                    Add Category
                </Button>
            </div>
            <Table
            className="mar-bottom-1"
            size="small"
            columns={menuCategoriesColumns}
            dataSource={menuCategories.map((item, index) => ({...item, key: index}))}
            bordered
            pagination={{pageSize: 10}}/>
        </>
    )
}

export default SuperAdminMenuCategoriesSettings;