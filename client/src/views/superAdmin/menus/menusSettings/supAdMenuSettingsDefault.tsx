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
     * Menu Tag Handlers
     */
    const handleAddMenuTag = (categoryId: number, shiftId: number) => {
        showModal("SuperAdminAddMenuTagModal", {
            menuCategoryId: categoryId,
            shiftId,
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
            render: (_, row) => {
                if(row.shift) {
                    return row.shift;
                } else if(row.category) {
                    return row.category;
                } else {
                    return (
                        editMenuTagIn.id !== row.id 
                        ? (
                            row.tag
                        )
                        : (
                            <Input
                            size="small"
                            value={editMenuTagIn.tag}
                            onChange={(e) => setEditMenuTagIn(prev => ({...prev, tag: e.target.value}))}/>
                        )
                    )
                }
            },
            onCell: (row) => ({
                style: {
                    backgroundColor: row.shift ? 'black' : (row.category ? "orange" : undefined),
                    color: row.shift ? "white" : "black"
                },
            })
        },
        {
            title: "Actions",
            render: (_, row) => {
                if(row.shift) {
                    return(
                        <Button
                        color="orange"
                        variant="solid"
                        size="small">
                            Add Category
                        </Button>
                    )
                } else if(row.category) {
                    return(
                        <div className="d-flex gap3">
                            <Button
                            variant="solid"
                            size="small"
                            onClick={() => handleAddMenuTag(row.id, row.shift_id)}>
                                Add Menu Tag
                            </Button>

                            <Button
                            size="small"
                            icon={<LuSquarePen/>}
                            color="blue"
                            variant="solid"/>

                            <Popconfirm
                                title="Delete the category"
                                description={`Delete this category: ${row.category} ?`}
                                // onConfirm={() => handleDeleteMenuTag(row.id)}
                                okText="Yes"
                                cancelText="No"
                            >
                                <Button
                                size="small"
                                icon={<LuTrash2/>}
                                color="red"
                                variant="solid"
                                disabled={row.menu_tags.length > 0}/>
                            </Popconfirm>
                        </div>
                        
                    )
                } else {
                    return(
                        <div className="d-flex gap3">
                            {editMenuTagIn.id !== row.id
                            ? (
                                <>
                                    <Button
                                    size="small"
                                    icon={<LuSquarePen/>}
                                    color="blue"
                                    variant="solid"
                                    onClick={() => setEditMenuTagIn({id: row.id, tag: row.tag})}/>

                                    <Popconfirm
                                        title="Delete the tag"
                                        description={`Delete this tag: ${row.tag} ?`}
                                        onConfirm={() => handleDeleteMenuTag(row.id)}
                                        okText="Yes"
                                        cancelText="No"
                                    >
                                        <Button
                                        size="small"
                                        icon={<LuTrash2/>}
                                        color="red"
                                        variant="solid"/>
                                    </Popconfirm>
                                </>
                            )
                            : (
                                <>
                                    <Button
                                    size="small"
                                    icon={<LuSquareCheckBig/>}
                                    color="green"
                                    variant="solid"
                                    onClick={handleEditMenuTag}/>

                                    <Button
                                    size="small"
                                    icon={<GiCancel/>}
                                    onClick={() => setEditMenuTagIn({id: "", tag: ""})}/>
                                </>
                            )}
                            
                        </div>
                    )
                }
            },
            width: 250
        }
    ]



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
                    dataSource={
                        shifts.flatMap((shift: MenuShiftStructure) => {
                            return [
                                { shift: shift.shift }, // Shift header
                                ...shift.categories.flatMap(category => [
                                    category, // Category header
                                    ...category.menu_tags.map(tag => tag) // Menu tags under that category
                                ])
                            ];
                        }).map((item, index) => ({...item, key: index}))
                    }
                    size="small"
                    bordered
                    pagination={false}
                    />

                </>
            )}
        </>
    );
}