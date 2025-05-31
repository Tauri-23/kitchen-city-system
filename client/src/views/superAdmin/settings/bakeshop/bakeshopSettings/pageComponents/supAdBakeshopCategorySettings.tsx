import { useState } from "react";
import { useGeneralContext } from "../../../../../../contexts/GeneralContext";
import MlBakeshopCategoryStructure from "../../../../../../types/mlBakeshopCategoryStructure";
import { Button, Input, Popconfirm, Table, TableColumnsType } from "antd";
import { LuSquareCheckBig, LuSquarePen, LuTrash2 } from "react-icons/lu";
import { isEmptyOrSpaces, notify } from "../../../../../../assets/lib/utils";
import { GiCancel } from "react-icons/gi";
import axiosClient from "../../../../../../axios-client";

interface SuperAdminBakeshopCategoriesSettingsTypes {
    bakeshopCategories: MlBakeshopCategoryStructure[] | null, 
    setBakeshopCategories: React.Dispatch<React.SetStateAction<MlBakeshopCategoryStructure[]>>
}

const SuperAdminBakeshopCategoriesSettings: React.FC<SuperAdminBakeshopCategoriesSettingsTypes> = ({bakeshopCategories, setBakeshopCategories}) => {
    const { showModal } = useGeneralContext();
    const [editBakeshopCategoryIn, setEditBakeshopCategoryIn] = useState({
        id: 0,
        category: ""
    });



    /**
     * Setup table columns
     */
    const bakeshopCategoriesColumns: TableColumnsType<MlBakeshopCategoryStructure> = [
        {
            title: "Category",
            render: (_, row) => {
                if(editBakeshopCategoryIn.id === row.id) {
                    return(
                        <Input
                        size="small"
                        width={"100%"}
                        value={editBakeshopCategoryIn.category}
                        onChange={(e) => setEditBakeshopCategoryIn(prev => ({...prev, category: e.target.value}))}/>
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
                        {editBakeshopCategoryIn.id === row.id
                        ? (
                            <>
                                <Button
                                    size="small"
                                    icon={<LuSquareCheckBig />}
                                    color="green"
                                    variant="solid"
                                    disabled={isEmptyOrSpaces(editBakeshopCategoryIn.category) || editBakeshopCategoryIn.category === row.category}
                                    onClick={handleEditBakeshopCategory}
                                />
                                <Button
                                    size="small"
                                    icon={<GiCancel />}
                                    onClick={() => setEditBakeshopCategoryIn({ id: 0, category: "" })}
                                />
                            </>
                        )
                        : (
                            <>
                                <Button
                                size="small"
                                icon={<LuSquarePen />}
                                onClick={() => setEditBakeshopCategoryIn({ id: row.id, category: row.category })}
                                color="blue"
                                variant="solid"
                                />
    
                                <Popconfirm
                                    title="Delete this shift"
                                    onConfirm={() => handleDeleteBakeshopCategory(row.id)}
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
    const handleAddBakeshopCategory = () => {
        showModal("SuperAdminAddBakeshopCategoryModal", {
            setBakeshopCategories
        })
    }

    const handleDeleteBakeshopCategory = (id: number) => {
        const formData = new FormData();

        formData.append("id", String(id));

        axiosClient.post("/delete-mlbakeshop-category", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);

            if(data.status === 200) {
                setBakeshopCategories(prev => ((prev || [])?.filter(cat => cat.id !== id)));
            }
        })
        .catch(error => {
            console.error(error);
            notify("error", "Server Error", "top-center", 3000);
        });
    };

    const handleEditBakeshopCategory = () => {
        const formData = new FormData();
        formData.append("editBakeshopCategoryIn", JSON.stringify(editBakeshopCategoryIn));

        axiosClient.post("/update-mlbakeshop-category", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);

            if(data.status === 200) {
                setBakeshopCategories(data.bakeshop_categories);
                setEditBakeshopCategoryIn({id: 0, category: ""})
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
                onClick={handleAddBakeshopCategory}>
                    Add Category
                </Button>
            </div>

            <Table
            className="mar-bottom-1"
            size="small"
            columns={bakeshopCategoriesColumns}
            dataSource={(bakeshopCategories || []).map((item, index) => ({...item, key: index}))}
            loading={!bakeshopCategories}
            bordered
            pagination={{pageSize: 10}}/>
        </>
    )
}

export default SuperAdminBakeshopCategoriesSettings;