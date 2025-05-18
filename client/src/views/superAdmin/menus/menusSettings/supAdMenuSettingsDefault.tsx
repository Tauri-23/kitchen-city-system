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
import { isEmptyOrSpaces, notify } from "../../../../assets/lib/utils";
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
    });
    
    const [editMenuCategoryIn, setEditMenuCategoryIn] = useState({
        id: "",
        category: ""
    });

    const [editMenuShiftIn, setEditMenuShiftIn] = useState({
        id: "",
        shift: ""
    });



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
        shift: shift.shift,
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
                tag: tag.tag,
                categoryId: category.id,
                type: "tag"
            }))
        }))
    })) || [];

    const getDefaultExpandedKeys = (shifts: MenuShiftStructure[] | any[]) => {
        const keys: string[] = [];

        shifts.forEach(shift => {
            // Expand shift row if needed
            // keys.push(shift.key);

            shift.children?.forEach((category: { key: string; }) => {
                // Expand all categories
                keys.push(category.key);
            });
        });

        return keys;
    };



    /**
     * Menu Shift Handlers
     */
    const handleAddMenuShift = () => {
        showModal("SuperAdminAddMenuShiftModal", {
            setShifts
        })
    }




    /**
     * Menu Category Handlers
     */
    const handleAddMenuCategory = (shift: MenuShiftStructure) => {
        showModal("SuperAdminAddMenuCategoryModal", {
            shift,
            setShifts
        })
    }
    
    const handleEditMenuCategory = () => {
        const formData = new FormData();
        formData.append("editMenuCategoryIn", JSON.stringify(editMenuCategoryIn));

        axiosClient.post("/update-menu-category", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);

            if(data.status === 200) {
                setShifts(data.updated_menu_shifts);
                setEditMenuCategoryIn({id: "", category: ""});
            }
        })
        .catch(error => {
            console.error(error);
            notify("error", "Server Error", "top-center", 3000);
        })
    }

    const handleDeleteMenuCategory = (id: number) => {
        const formData = new FormData();
        formData.append("id", String(id));

        axiosClient.post("/delete-menu-category", formData)
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

                if (row.type === "category" && parseInt(editMenuCategoryIn.id) === row.id) {
                    return (
                        <Input
                            size="small"
                            value={editMenuCategoryIn.category}
                            onChange={(e) => setEditMenuCategoryIn(prev => ({ ...prev, category: e.target.value }))}
                        />
                    );
                }
                return row.type === "category" ? row.category : (row.type === "shift" ? row.shift : row.tag);
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
                        <div className="d-flex gap3">
                            {editMenuShiftIn.id === row.id
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
                                        onClick={() => setEditMenuShiftIn({ id: "", shift: "" })}
                                    />
                                </>
                            )
                            : (
                                <>
                                    <Button
                                    variant="solid"
                                    color="primary"
                                    size="small"
                                    onClick={() => {handleAddMenuCategory(row)}}>
                                    Add Category
                                    </Button>

                                    <Button
                                    size="small"
                                    icon={<LuSquarePen />}
                                    onClick={() => setEditMenuShiftIn({ id: row.id, shift: row.shift })}
                                    color="blue"
                                    variant="solid"
                                    />
                                </>
                            )}
                        </div>
                        
                    );
                }

                if (row.type === "category") {
                    return (
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
                                        onClick={() => setEditMenuCategoryIn({ id: "", category: "" })}
                                    />
                                </>
                            )
                            : (
                                <>
                                    <Button
                                    size="small"
                                    onClick={() => handleAddMenuTag(row, row.shift)}>
                                    Add Menu Tag
                                    </Button>
                                    
                                    <Button
                                    size="small"
                                    icon={<LuSquarePen />}
                                    onClick={() => setEditMenuCategoryIn({ id: row.id, category: row.category })}
                                    color="blue"
                                    variant="solid"
                                    />

                                    <Popconfirm
                                        title="Delete this category"
                                        onConfirm={() => handleDeleteMenuCategory(row.id)}
                                    >
                                        <Button
                                        size="small"
                                        icon={<LuTrash2 />}
                                        color="red"
                                        variant="solid"
                                        disabled={row.children.length > 0}
                                        />
                                    </Popconfirm>
                                </>
                            )}
                            
                        </div>
                    );
                }

                if (row.type === "tag") {
                    return editMenuTagIn.id !== row.id ? (
                        <div className="d-flex gap3">
                            <Button
                            size="small"
                            icon={<LuSquarePen />}
                            onClick={() => setEditMenuTagIn({ id: row.id, tag: row.tag })}
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
                                variant="solid"
                                disabled={isEmptyOrSpaces(editMenuTagIn.tag) || editMenuTagIn.tag === row.tag}
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
            
            <div className="d-flex align-items-center gap3 justify-content-end mar-bottom-1">
                <Button
                size="large"
                type="primary"
                onClick={handleAddMenuShift}>
                    Add Shift
                </Button>
            </div>

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
                    expandable={{defaultExpandedRowKeys: getDefaultExpandedKeys(transformedShifts)}}
                    />
                </>
            )}
        </>
    );
}