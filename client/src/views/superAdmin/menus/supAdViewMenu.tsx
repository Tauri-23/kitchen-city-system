import { useEffect, useState } from "react";
import { useSuperAdminContext } from "../../../contexts/SuperAdminContext";
import { Link, useParams } from "react-router-dom";
import { Breadcrumb, Button, Popconfirm, Select, Spin, Table, TableColumnsType } from "antd";
import "../../../assets/css/viewMenu.css";
import { fetchAllMenusWhereWeekDayAndSize } from "../../../services/menusServices";
import { MenuStructure } from "../../../types/menuStructure";
import { MenuShiftStructure } from "../../../types/menuShiftStructure";
import { fetchAllMenuShifts } from "../../../services/menuShiftsServices";
import { MenuDishStructure } from "../../../types/menuDishStructure";
import { fetchAllMenuDishes } from "../../../services/menuDishesServices";
import { LuTrash2 } from "react-icons/lu";

type SelectedDishType = {
    menu_shift_id: number;
    menu_dish_id: string;
    menu_dish: MenuDishStructure;
};

export default function SuperAdminViewMenu() {
    const { setActiveSideNavLink } = useSuperAdminContext();

    const [menus, setMenus] = useState<MenuStructure[] | null>(null);
    const [shifts, setShifts] = useState<MenuShiftStructure[] | null>(null);
    const [menuDishes, setMenuDishes] = useState<MenuDishStructure[] | null>(null);
    
    const days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    const sizes = ["XL", "Large", "Medium", "Medium Frying", "Medium No Frying", "Small", "Small Frying", "Small No Frying"];
    
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
            const [shiftsData, menuDishesData] = await Promise.all([
                fetchAllMenuShifts(),
                fetchAllMenuDishes()
            ]);
            setShifts(shiftsData);
            setMenuDishes(menuDishesData);
        }

        getAll();
    }, []);

    useEffect(() => {
        const updateMenus = async() => {
            setMenus(null);
            const data = await fetchAllMenusWhereWeekDayAndSize(String(params.id), selectedDay, selectedSize);
            console.log(data);
            setMenus(data);
            setSelectedDishesIn(prev => [
                ...prev,
                ...data.map((menu: MenuStructure) => ({
                    menu_shift_id: menu.menu_shift_id,
                    menu_dish_id: menu.menu_dish_id,
                    menu_dish: menu.menu_dish,
                    day: menu.menu_day
                }))
            ]);
        }
        updateMenus();
    }, [selectedDay, selectedSize]);   



    /**
     * Setup Columns
     */
    const transformedShifts = shifts?.map((shift) => ({
        key: `shift-${shift.id}`,
        id: shift.id,
        shift: shift.shift,
        type: "shift",
        childrens: selectedDishesIn?.filter(dish => dish.menu_shift_id == shift.id).length,
        children: selectedDishesIn?.filter(dish => dish.menu_shift_id == shift.id).map((menuDish, index) => {
            return {
                key: `dish-${menuDish.menu_dish_id}-shift-${shift.id}-index-${index}`,
                id: menuDish.menu_dish_id,
                dish: menuDish.menu_dish,
                type: "dish"
            }
        })
    })) || [];

    const getDefaultExpandedKeys = (shifts: MenuShiftStructure[] | any[]) => {
        const keys: string[] = [];

        shifts.forEach(shift => {
            // Expand shift row if needed
            keys.push(shift.key);

            // shift.children?.forEach((menuClass: { key: string; }) => {
            //     // Expand all categories
            //     keys.push(menuClass.key);
            // });
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
                return row.type === "shift" ? `${row.shift} (${row.childrens} Dishes)` : row.dish.odoo_description;
            },
            onCell: (row) => ({
                style: {
                    backgroundColor: row.type === "shift" ? 'black' : (row.type === "class" ? "orange" : undefined),
                    color: row.type === "shift" ? "white" : "black"
                },
                colSpan: row.type === "dish" ? 1 : 4
            }),
        },
        {
            title: "System Description",
            render: (_, row) => row.type === "shift" ? row.shift : row.dish.system_description,
            onCell: (row) => ({
                colSpan: row.type === "dish" ? 1 : 0
            }),
        },
        {
            title: "Category",
            render: (_, row) => row.type === "shift" ? row.shift : row.dish.menu_category.category,
            onCell: (row) => ({
                colSpan: row.type === "dish" ? 1 : 0
            }),
        },
        {
            title: "Production",
            render: (_, row) => row.type === "shift" ? row.shift : row.dish.production?.production || "N/A",
            onCell: (row) => ({
                colSpan: row.type === "dish" ? 1 : 0
            }),
        },
        {
            title: "Actions",
            render: (_, row) => {
                if(row.type === "shift") {
                    return(
                        <Button
                        size="small">Add Dish</Button>
                    )
                } else {
                    return (
                        <Popconfirm
                        title="Delete this menu item"
                        onConfirm={() => handleDeleteMenuItem(row.id)}
                        >
                            <Button
                            size="small"
                            icon={<LuTrash2 />}
                            color="red"
                            variant="solid"
                            />
                        </Popconfirm>
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
    const handleDeleteMenuItem = (id: string) => {
        console.log(id);
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
                    className="mar-bottom-1 text-m1 fw-bold"
                    items={[
                        {
                        title: <Link to={`/KCSuperAdmin/Menus`}>Menus</Link>,
                        },
                        {
                        title: `Menu Cycle Week ${params.id} / ${selectedSize} / ${selectedDay}`,
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
                    </div>

                    <Table
                    columns={menuSettingsColumns}
                    dataSource={transformedShifts}
                    size="small"
                    bordered
                    pagination={false}
                    loading={!shifts || !menus || !menuDishes || !selectedDishesIn}
                    expandable={{defaultExpandedRowKeys: getDefaultExpandedKeys(transformedShifts)}}
                    />
                </>
            )}
        </div>
    )
}