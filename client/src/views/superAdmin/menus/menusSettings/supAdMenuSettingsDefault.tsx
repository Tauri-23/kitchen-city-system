import { useEffect, useState } from "react";
import { useOutletContext } from "react-router-dom";
import { SuperAdminMenuActivePageTypes } from "../supAdMenusDefault";
import { MenuShiftStructure } from "../../../../types/menuShiftStructure";
import { fetchAllMenuShiftsFull } from "../../../../services/menuShiftsServices";
import { Button, Input, Popconfirm, Spin, Table, TableColumnsType } from "antd";
import { LuSquareCheckBig, LuSquarePen, LuTrash2 } from "react-icons/lu";
import { useGeneralContext } from "../../../../contexts/GeneralContext";
import { GiCancel } from "react-icons/gi";
import axiosClient from "../../../../axios-client";
import { notify } from "../../../../assets/lib/utils";
import { MenuCategoryStructure } from "../../../../types/menuCategoryStructure";

interface OutletContextTypes {
    setSupAdMenuActivePage: (value: SuperAdminMenuActivePageTypes) => void;
}

export default function SuperAdminMenuSettingsDefault() {
    const { showModal } = useGeneralContext();
    const {setSupAdMenuActivePage} = useOutletContext<OutletContextTypes>();

    const [shifts, setShifts] = useState<MenuShiftStructure[] | null>(null);

    const [editMenuTagIn, setEditMenuTagIn] = useState({
        id: "",
        tag: ""
    })



    /**
     * Onmount
     */
    useEffect(() => {
        setSupAdMenuActivePage("Menu Settings");

        const getAll = async() => {
            const [shiftsData] = await Promise.all([
                fetchAllMenuShiftsFull()
            ]);
            setShifts(shiftsData);
        }

        getAll();
    }, []);



    /**
     * Transformed Data for Table
     */
    const transformedShifts = shifts?.map((shift) => ({
        key: `shift-${shift.id}`,
        id: shift.id,
        name: shift.shift,
        type: "shift",
        children: shift.categories.map(category => ({
            key: `category-${category.id}`,
            id: category.id,
            category: category.category,
            shiftId: shift.id,
            shift: shift,
            type: "category",
            children: category.menu_tags.map(tag => ({
                key: `tag-${tag.id}`,
                id: tag.id,
                name: tag.tag,
                categoryId: category.id,
                type: "tag"
            }))
        }))
    })) || [];



    /**
     * Menu Tag Handlers
     */
    const handleAddMenuTag = (category: MenuCategoryStructure, shift: MenuShiftStructure) => {
        showModal("SuperAdminAddMenuTagModal", {
            category,
            shift,
            setShifts
        })
    }

    const handleEditMenuTag = () => {
        const formData = new FormData();
        formData.append("editMenuTagIn", JSON.stringify(editMenuTagIn));

        axiosClient.post("/update-menu-tag", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);

            if(data.status === 200) {
                console.log(data.updated_menu_shifts);
                setShifts(data.updated_menu_shifts);
                setEditMenuTagIn({id: "", tag: ""});
            }
        })
        .catch(error => {
            console.error(error);
            notify("error", "Server Error", "top-center", 3000);
        })
    }

    const handleDeleteMenuTag = (menuTagId: number) => {
        const formData = new FormData();
        formData.append("menuTagId", String(menuTagId));

        axiosClient.post("/delete-menu-tag", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);
            setShifts(data.updated_menu_shifts);
        })
        .catch(error => {
            console.error(error);
            notify("error", "Server Error", "top-center", 3000);
        })
    }



    /**
     * Setup Columns
     */
    const menuSettingsColumns: TableColumnsType<any> = [
        {
            title: "Name",
            render: (_, row) => {
                if (row.type === "tag" && parseInt(editMenuTagIn.id) === row.id) {
                    return (
                        <Input
                            size="small"
                            value={editMenuTagIn.tag}
                            onChange={(e) => setEditMenuTagIn(prev => ({ ...prev, tag: e.target.value }))}
                        />
                    );
                }
                return row.type === "category" ? row.category : row.name;
            },
            onCell: (row) => ({
                style: {
                    backgroundColor: row.type === "shift" ? 'black' : (row.type === "category" ? "orange" : undefined),
                    color: row.type === "shift" ? "white" : "black"
                },
            })
        },
        {
            title: "Actions",
            render: (_, row) => {
                if (row.type === "shift") {
                    return (
                        <Button
                        variant="solid"
                        color="primary"
                        size="small"
                        onClick={() => {/* handleAddCategory(row.id) */}}>
                        Add Category
                        </Button>
                    );
                }

                if (row.type === "category") {
                    return (
                        <div className="d-flex gap3">
                            <Button
                                size="small"
                                onClick={() => handleAddMenuTag(row, row.shift)}>
                                Add Menu Tag
                            </Button>
                            {/* Edit & Delete category buttons */}
                        </div>
                    );
                }

                if (row.type === "tag") {
                    return editMenuTagIn.id !== row.id ? (
                        <div className="d-flex gap3">
                            <Button
                            size="small"
                            icon={<LuSquarePen />}
                            onClick={() => setEditMenuTagIn({ id: row.id, tag: row.name })}
                            color="blue"
                            variant="solid"
                            />
                            <Popconfirm
                                title="Delete the tag"
                                onConfirm={() => handleDeleteMenuTag(row.id)}
                            >
                                <Button
                                size="small"
                                icon={<LuTrash2 />}
                                color="red"
                                variant="solid"
                                />
                            </Popconfirm>
                        </div>
                    ) : (
                        <div className="d-flex gap3">
                            <Button
                                size="small"
                                icon={<LuSquareCheckBig />}
                                color="green"
                                onClick={handleEditMenuTag}
                            />
                            <Button
                                size="small"
                                icon={<GiCancel />}
                                onClick={() => setEditMenuTagIn({ id: "", tag: "" })}
                            />
                        </div>
                    );
                }

                return null;
            },
            width: 250
        }
    ];



    /**
     * Render
     */
    return(
        <>
            <h3 className="fw-bold mar-bottom-1">Menu Settings</h3>

            {!shifts
            ? (<Spin size="large"/>)
            : (
                <>
                    <Table
                    columns={menuSettingsColumns}
                    dataSource={transformedShifts}
                    size="small"
                    bordered
                    pagination={false}
                    />

                </>
            )}
        </>
    );
}