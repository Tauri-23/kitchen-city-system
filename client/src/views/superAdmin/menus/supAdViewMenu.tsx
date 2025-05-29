import { useEffect, useState } from "react";
import { useSuperAdminContext } from "../../../contexts/SuperAdminContext";
import { Link, useParams } from "react-router-dom";
import { Breadcrumb, Button, Popconfirm, Select, Spin, Table, TableColumnsType } from "antd";
import "../../../assets/css/viewMenu.css";
import { fetchAllMenusWhereWeekDayAndSize } from "../../../services/menusServices";
import { MenuStructure } from "../../../types/menuStructure";
import { MenuShiftStructure } from "../../../types/menuShiftStructure";
import { MenuFormElementStructure } from "../../../types/menuFormElementStructure";
import { MenuClassStructure } from "../../../types/menuClassStructure";
import { fetchAllMenuShifts } from "../../../services/menuShiftsServices";
import { MenuDishStructure } from "../../../types/menuDishStructure";
import { fetchAllMenuDishes } from "../../../services/menuDishesServices";
import { formatToPhilPeso, notify } from "../../../assets/lib/utils";
import axiosClient from "../../../axios-client";

type SelectedDishType = {
    menu_shift_id: number;
    menu_dish_id: string;
    menu_dish: MenuDishStructure;
};

export default function SuperAdminViewMenu() {
    const { setActiveSideNavLink } = useSuperAdminContext();

    const [menus, setMenus] = useState<MenuStructure[] | null>(null);
    const [shifts, setShifts] = useState<MenuShiftStructure[] | null>(null);
    const [menuFormElements, setmenuFormElements] = useState<MenuFormElementStructure[] | null>(null);
    const [menuClasses, setMenuClasses] = useState<MenuClassStructure[] | null>(null);
    const [menuDishes, setMenuDishes] = useState<MenuDishStructure[] | null>(null);
    
    const days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    const sizes = ["XL", "Large", "Medium", "Medium Frying", "Small", "Small Frying"];
    
    const [selectedSize, setSelectedSize] = useState<string>(sizes[0]);
    const [selectedDay, setSelectedDay] = useState<string>(days[0]);

    const [selectedDishesIn, setSelectedDishesIn] = useState<SelectedDishType[]>([]);


    const params = useParams();



    /**
     * Onmount
     */
    useEffect(() => {
        setActiveSideNavLink("Menus");

        const getAll = async() => {
            const [menusData, shiftsData, menuDishesData] = await Promise.all([
                fetchAllMenusWhereWeekDayAndSize(String(params.id), selectedDay, selectedSize),
                fetchAllMenuShifts(),
                fetchAllMenuDishes()
            ]);
            setMenus(menusData);
            setShifts(shiftsData);
            setMenuDishes(menuDishesData);
        }

        getAll();
    }, []);

    useEffect(() => {
        const updateMenus = async() => {
            setMenus(null);
            const data = await fetchAllMenusWhereWeekDayAndSize(String(params.id), selectedDay, selectedSize);
            setMenus(data);
        }
        updateMenus();
    }, [selectedDay, selectedSize])



    /**
     * Setup Columns
     */
    const transformedShifts = shifts?.map((shift) => ({
        key: `shift-${shift.id}`,
        id: shift.id,
        shift: shift.shift,
        type: "shift",
        children: selectedDishesIn?.filter(dish => dish.menu_shift_id === shift.id).map(menuDish => ({
            key: `dish-${menuDish.menu_dish_id}`,
            id: menuDish.menu_dish_id,
            type: "dish"
        }))
    })) || [];

    const getDefaultExpandedKeys = (shifts: MenuShiftStructure[] | any[]) => {
        const keys: string[] = [];

        shifts.forEach(shift => {
            // Expand shift row if needed
            keys.push(shift.key);

            shift.children?.forEach((menuClass: { key: string; }) => {
                // Expand all categories
                keys.push(menuClass.key);
            });
        });

        return keys;
    };



    /**
     * Table columns
     */
    const menuSettingsColumns: TableColumnsType<any> = [
        {
            title: "Odoo Description",
            render: (_, row) => {
                return row.type === "shift" ? row.shift : row.menu_dish.odoo_description;
            },
            onCell: (row) => ({
                style: {
                    backgroundColor: row.type === "shift" ? 'black' : (row.type === "class" ? "orange" : undefined),
                    color: row.type === "shift" ? "white" : "black"
                },
                colSpan: row.type === "tag" ? 1 : 4
            }),
            width: 300
        },
        {
            title: "System Description",
            render: (_, row) => row.type === "shift" ? row.shift : row.menu_dish.system_description,
            onCell: (row) => ({
                colSpan: row.type === "dish" ? 1 : 0
            }),
            width: 300
        },
        {
            title: "Category",
            render: (_, row) => row.type === "shift" ? row.shift : row.menu_dish.menu_category.category,
            onCell: (row) => ({
                colSpan: row.type === "dish" ? 1 : 0
            }),
            width: 200
        },
        {
            title: "Production",
            render: (_, row) => row.type === "shift" ? row.shift : row.menu_dish.production.production,
            onCell: (row) => ({
                colSpan: row.type === "dish" ? 1 : 0
            }),
            width: 200
        },
        {
            title: "Actions",
            render: (_, row) => {
                if(row.type === "shift") {
                    return(
                        <Button
                        size="small">Add Dish</Button>
                    )
                }
            },
            onCell: (row) => ({
                style: {
                    backgroundColor: row.type === "shift" ? 'black' : (row.type === "class" ? "orange" : undefined),
                    color: row.type === "shift" ? "white" : "black"
                },
                colSpan: 1
            }),
            width: 50
        }
    ];



    /**
     * Handlers
     */
    const handleSaveMenu = () => {
        const formData = new FormData();
        formData.append("selectedDishesIn", JSON.stringify(selectedDishesIn));
        formData.append("menuWeek", String(params.id));
        formData.append("menuDay", selectedDay);
        formData.append("menuSize", selectedSize);

        axiosClient.post("/create-update-menu", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);
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
        <div className="content1 compressed">
            { !menus
            ? (<Spin size="large"/>)
            : ( 
                <>
                    <Breadcrumb
                    className="mar-bottom-1 text-m2"
                    items={[
                        {
                        title: <Link to={`/KCSuperAdmin/Menus`}>Menus</Link>,
                        },
                        {
                        title: `Week ${params.id}`,
                        },
                    ]}
                    />
                
                    {/* <h3 className="fw-bold mar-bottom-1">{menu.menu_name}</h3> */}
                    <div className="d-flex mar-bottom-1 justify-content-between">
                        <div className="d-flex gap3">
                            <Select
                            size="large"
                            style={{width: 200}}
                            options={sizes.map(size => ({label: size, value: size}))}
                            value={selectedSize}
                            onChange={(val) => setSelectedSize(val)}/>

                            <Select
                            size="large"
                            style={{width: 200}}
                            options={days.map(day => ({label: day, value: day}))}
                            value={selectedDay}
                            onChange={(val) => setSelectedDay(val)}/>
                        </div>
                        <Popconfirm
                        title="Do you want to save menu?"
                        onConfirm={handleSaveMenu}>
                            <Button
                            size="large"
                            type="primary">
                                Save Menu
                            </Button>
                        </Popconfirm>
                    </div>

                    <Table
                    columns={menuSettingsColumns}
                    dataSource={transformedShifts}
                    size="small"
                    bordered
                    pagination={false}
                    loading={!shifts || !menus || !menuDishes}
                    expandable={{defaultExpandedRowKeys: getDefaultExpandedKeys(transformedShifts)}}
                    />                    
                </>
            )}
        </div>
    )
}