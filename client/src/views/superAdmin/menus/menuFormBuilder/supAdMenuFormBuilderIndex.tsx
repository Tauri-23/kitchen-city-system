import { useEffect, useState } from "react";
import { useOutletContext } from "react-router-dom";
import { SuperAdminMenuActivePageTypes } from "../supAdMenusDefault";
import { MenuShiftStructure } from "../../../../types/menuShiftStructure";
import { fetchAllMenuShifts } from "../../../../services/menuShiftsServices";
import { Button, Popconfirm, Spin, Table, TableColumnsType } from "antd";
import { useGeneralContext } from "../../../../contexts/GeneralContext";
import { MenuFormElementStructure } from "../../../../types/menuFormElementStructure";
import { fetchAllMenuFormElements } from "../../../../services/menuFormElementServices";
import { MenuClassStructure } from "../../../../types/menuClassStructure";
import { fetchAllMenuClasses } from "../../../../services/menuClassesServices";
import axiosClient from "../../../../axios-client";
import { notify } from "../../../../assets/lib/utils";

interface OutletContextTypes {
    setSupAdMenuActivePage: (value: SuperAdminMenuActivePageTypes) => void;
}

export default function SuperAdminMenuFormBuilderIndex() {
    const { showModal } = useGeneralContext();
    const {setSupAdMenuActivePage} = useOutletContext<OutletContextTypes>();

    const [shifts, setShifts] = useState<MenuShiftStructure[] | null>(null);
    const [menuFormElements, setmenuFormElements] = useState<MenuFormElementStructure[] | null>(null);
    const [menuClasses, setMenuClasses] = useState<MenuClassStructure[] | null>(null);



    /**
     * Onmount
     */
    useEffect(() => {
        setSupAdMenuActivePage("Menu Form Builder");

        const getAll = async() => {
            const [shiftsData, menuFormElementsData, menuClassesData] = await Promise.all([
                fetchAllMenuShifts(),
                fetchAllMenuFormElements(),
                fetchAllMenuClasses()
            ]);
            setShifts(shiftsData);
            setmenuFormElements(menuFormElementsData);
            setMenuClasses(menuClassesData);
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
        children: menuFormElements?.filter(element => element.menu_shift_id === shift.id).map(category => ({
            key: `class-${category.id}`,
            id: category.id,
            class: category.menu_class.class,
            type: "class",
            children: category.menu_class.menu_tags.map(tag => ({
                key: `tag-${tag.id}`,
                id: tag.id,
                tag: tag.tag,
                type: "tag"
            }))
        }))
    })) || [];

    const getDefaultExpandedKeys = (shifts: MenuShiftStructure[] | any[]) => {
        const keys: string[] = [];

        shifts.forEach(shift => {
            // Expand shift row if needed
            // keys.push(shift.key);

            shift.children?.forEach((menuClass: { key: string; }) => {
                // Expand all categories
                keys.push(menuClass.key);
            });
        });

        return keys;
    };



    /**
     * Setup Columns
     */
    const menuSettingsColumns: TableColumnsType<any> = [
        {
            title: "Name",
            render: (_, row) => {
                return row.type === "shift" ? row.shift : (row.type === "class" ? row.class : row.tag);
            },
            onCell: (row) => ({
                style: {
                    backgroundColor: row.type === "shift" ? 'black' : (row.type === "class" ? "orange" : undefined),
                    color: row.type === "shift" ? "white" : "black"
                },
            })
        },
        {
            title: "Actions",
            render: (_, row) => {
                if(row.type === "shift") {
                    return <Button size="small" onClick={() => handleAddElement(row)}>Add Element</Button>
                }
                if(row.type === "class") {
                    return (
                        <Popconfirm
                        title="Delete this element"
                        onConfirm={() => handleDeleteElement(row.id)}>
                            <Button size="small">Remove Element</Button>
                        </Popconfirm>
                    )
                }
            },
            onCell: (row) => ({
                style: {
                    backgroundColor: row.type === "shift" ? 'black' : (row.type === "class" ? "orange" : undefined),
                    color: row.type === "shift" ? "white" : "black"
                },
            }),
            width: "100px"
        }
    ];



    /**
     * Handlers
     */
    const handleAddElement = (selectedShift: MenuShiftStructure) => {
        showModal("SuperAdminAddMenuFormElementModal", {
            setmenuFormElements,
            selectedShift,
            menuClasses
        });
    }

    const handleDeleteElement = (id: number) => {
        const formData = new FormData();
        formData.append("id", String(id));

        axiosClient.post("/delete-menu-form-element", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);
            if(data.status === 200) {
                setmenuFormElements(prev => prev?.filter(element => element.id !== id) || []);
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
        <>
            <h3 className="fw-bold mar-bottom-1">Menu Form Builder</h3>

            {!shifts || !menuFormElements
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