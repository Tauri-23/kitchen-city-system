import Table, { ColumnsType as TableColumnsType } from "antd/es/table";
import { MenuSubCategoryStructure } from "../../../../../../types/menuSubCategoryStucture";
import { Button, Input, Popconfirm } from "antd";
import { LuSquareCheckBig, LuSquarePen, LuTrash2 } from "react-icons/lu";
import { isEmptyOrSpaces, notify } from "../../../../../../assets/lib/utils";
import { useGeneralContext } from "../../../../../../contexts/GeneralContext";
import { useState } from "react";
import { GiCancel } from "react-icons/gi";
import axiosClient from "../../../../../../axios-client";

interface SuperAdminMenuSubCategoriesSettingsTypes {
    menuSubCategories: MenuSubCategoryStructure[];
    setMenuSubCategories: React.Dispatch<React.SetStateAction<MenuSubCategoryStructure[]>>;
}

const SuperAdminMenuSubCategoriesSettings: React.FC<SuperAdminMenuSubCategoriesSettingsTypes> = ({menuSubCategories, setMenuSubCategories}) => {
    const { showModal } = useGeneralContext();
    const [editMenuSubCategoryIn, setEditMenuSubCategoryIn] = useState({
        id: 0,
        sub_category: ""
    })

    const isEditMenuSubCategorySubmitDisabled = (selectedMenuTag: MenuSubCategoryStructure) => {
        return isEmptyOrSpaces(editMenuSubCategoryIn.sub_category) || (editMenuSubCategoryIn.sub_category === selectedMenuTag.sub_category)
    }



    /**
     * Setup table columns
     */
    const menuSubCategoriesColumns: TableColumnsType<MenuSubCategoryStructure> = [
        {
            title: "Category",
            render: (_, row) => (
                row.id === editMenuSubCategoryIn.id
                ? (
                    <Input
                    size="small"
                    value={editMenuSubCategoryIn.sub_category}
                    onChange={(e) => setEditMenuSubCategoryIn(prev => ({...prev, sub_category: e.target.value}))}
                    />
                )
                : (row.sub_category)
            )
        },
        {
            title: "Actions",
            render: (_, row) => {
                return(
                    <div className="d-flex gap3">
                        {editMenuSubCategoryIn.id === row.id
                        ? (
                            <>
                                <Button
                                    size="small"
                                    icon={<LuSquareCheckBig />}
                                    color="green"
                                    variant="solid"
                                    disabled={isEditMenuSubCategorySubmitDisabled(row)}
                                    onClick={handleEditMenuSubCategory}
                                />
                                <Button
                                    size="small"
                                    icon={<GiCancel />}
                                    onClick={() => setEditMenuSubCategoryIn({ id: 0, sub_category: "" })}
                                />
                            </>
                        )
                        : (
                            <>
                                <Button
                                size="small"
                                icon={<LuSquarePen />}
                                onClick={() => setEditMenuSubCategoryIn({ id: row.id, sub_category: row.sub_category })}
                                color="blue"
                                variant="solid"
                                />
        
                                <Popconfirm
                                    title="Delete this tag"
                                    onConfirm={() => handleDeleteMenuSubCategory(row.id)}
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
            width: "10%"
        }
    ];



    /**
     * Handlers
     */
    const handleAddMenuSubCategory = () => {
        showModal("SuperAdminAddMenuSubCategoryModal", {
            setMenuSubCategories
        });
    }

    const handleEditMenuSubCategory = () => {
        const formData = new FormData();
        formData.append("editMenuSubCategoryIn", JSON.stringify(editMenuSubCategoryIn));

        axiosClient.post("/update-menu-sub-category", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);
            if(data.status === 200) {
                setMenuSubCategories(data.updated_menu_sub_categories);
                setEditMenuSubCategoryIn({
                    id: 0,
                    sub_category: ""
                })
            }
        })
        .catch(error => {
            console.error(error);
            notify("error", "Server Error", "top-center", 3000);
        })
    }

    const handleDeleteMenuSubCategory = (id: number) => {
        const formData = new FormData();
        formData.append("id", String(id));

        axiosClient.post("/delete-menu-sub-category", formData)
        .then(async ({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);

            if(data.status === 200) {
                setMenuSubCategories((prev) => prev.filter(subCat => subCat.id !== id));
            }
        })
        .catch(error => {
            console.error(error);
            notify("error", "Server Error", "top-center", 3000);
        })
    }



    /**
     * Render
     */
    return(
        <div>
            <div className="d-flex align-items-center justify-content-between mar-bottom-3">
                <h4 className="fw-bold">Sub-Categories</h4>
                <Button
                type="primary"
                onClick={handleAddMenuSubCategory}>
                    Add Sub-Category
                </Button>
            </div>
            <Table
            className="mar-bottom-1"
            size="small"
            columns={menuSubCategoriesColumns}
            dataSource={menuSubCategories.map((item, index) => ({...item, key: index}))}
            bordered
            pagination={{pageSize: 10}}/>
        </div>
    );
}

export default SuperAdminMenuSubCategoriesSettings;