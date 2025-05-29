import { useEffect, useState } from "react";
import { useBranchManagerContext } from "../../../contexts/BranchManagerContext"
import { formatToPhilPeso } from "../../../assets/lib/utils";
import { MenuStructure } from "../../../types/menuStructure";
import { Breadcrumb, Button, Select, Spin, Table, TableColumnsType } from "antd";
import { MenuDishStructure } from "../../../types/menuDishStructure";
import { useGeneralContext } from "../../../contexts/GeneralContext";
import { Link, useNavigate } from "react-router-dom";
import { MenuShiftStructure } from "../../../types/menuShiftStructure";
import { fetchAllMenusWhereWeekDayAndSize } from "../../../services/menusServices";
import { fetchAllMenuShifts } from "../../../services/menuShiftsServices";
import { useLoggedUserContext } from "../../../contexts/LoggedUserContext";
import React from "react";
import BranchManagerAddOrderQtyInput from "./components/braManAddOrderQtyInput";

export type SelectedMenusType = {
    menu_shift_id: number;
    menu_dish_id: string;
    menu_dish: MenuDishStructure;
    qty_selected: number;
};

export default function BranchManagerAddOrder() {
    const { user } = useLoggedUserContext();
    const { setActiveSideNavLink } = useBranchManagerContext();
    const { showModal } = useGeneralContext();

    const navigate = useNavigate();

    const [menus, setMenus] = useState<MenuStructure[] | null>(null);
    const [shifts, setShifts] = useState<MenuShiftStructure[] | null>(null);
    const [selectedMenusIn, setSelectedMenusIn] = useState<SelectedMenusType[] | null>([]);

    const days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];

    const weekNow = 1;

    const [selectedDay, setSelectedDay] = useState<string>((days[0]));


    /**
     * Onmount
     */
    useEffect(() => {
        setActiveSideNavLink("Orders");

        const getAll = async() => {
            const [menusData, shiftsData] = await Promise.all([
                fetchAllMenusWhereWeekDayAndSize(String(weekNow), selectedDay, user?.branch?.size || ""),
                fetchAllMenuShifts(),
            ]);
            setMenus(menusData);
            setShifts(shiftsData);
            setSelectedMenusIn(menusData.map((menu: MenuStructure) => ({
                menu_shift_id: menu.menu_shift_id,
                menu_dish_id: menu.menu_dish_id,
                menu_dish: menu.menu_dish,
                qty_selected: 0
            })));
        }

        getAll();
    }, []);

    useEffect(() => {
        const updateMenus = async() => {
            setSelectedMenusIn(null);
            const data = await fetchAllMenusWhereWeekDayAndSize(String(weekNow), selectedDay, user?.branch?.size || "");
            setMenus(data);
            setSelectedMenusIn(data.map((menu: MenuStructure) => ({
                menu_shift_id: menu.menu_shift_id,
                menu_dish_id: menu.menu_dish_id,
                menu_dish: menu.menu_dish,
                qty_selected: 0
            })));
        }
        updateMenus();
    }, [selectedDay, user?.branch?.size || ""]);



    /**
     * Setup Columns
     */
    const transformedShifts = shifts?.map((shift) => ({
        key: `shift-${shift.id}`,
        id: shift.id,
        shift: shift.shift,
        type: "shift",
        childrens: selectedMenusIn?.filter(dish => dish.menu_shift_id == shift.id).length,
        children: selectedMenusIn?.filter(dish => dish.menu_shift_id == shift.id).map((menuDish, index) => {
            return {
                key: `dish-${menuDish.menu_dish_id}-shift-${shift.id}-index-${index}`,
                id: menuDish.menu_dish_id,
                dish: menuDish.menu_dish,
                qty_selected: menuDish.qty_selected,
                menu_shift_id: shift.id,
                type: "dish"
            }
        })
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
                return row.type === "shift" ? `${row.shift} (${row.childrens} Dishes)` : row.dish.odoo_description;
            },
            onCell: (row) => ({
                style: {
                    backgroundColor: row.type === "shift" ? 'black' : (row.type === "class" ? "orange" : undefined),
                    color: row.type === "shift" ? "white" : "black"
                },
                colSpan: row.type === "dish" ? 1 : 7
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
            title: "Unit Cost",
            render: (_, row) => row.type === "shift" ? row.shift : formatToPhilPeso(row.dish.unit_cost),
            onCell: (row) => ({
                colSpan: row.type === "dish" ? 1 : 0
            }),
            width: 100
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
            title: "QTY Ordered",
            render: (_, row) => {
                if (row.type === "dish") {
                    return <BranchManagerAddOrderQtyInput 
                    row={row} 
                    setSelectedMenusIn={setSelectedMenusIn as React.Dispatch<React.SetStateAction<SelectedMenusType[]>>} 
                    />;
                }
                return null;
            },
            onCell: (row) => ({
                colSpan: row.type === "dish" ? 1 : 0
            }),
            width: 100,
        }
    ];



    /**
     * Handlers
     */
    const handleCheckout = () => {
        showModal("BranchManagerOrderCheckoutModal", {
            selectedMenusIn,
            onSuccess: () => navigate("/KCBranchManager/Orders")
        })
    }



    /**
     * Render
     */
    return(
        <div className="content1 compressed">
            <Breadcrumb
            className="mar-bottom-1 text-m2"
            items={[
                {
                  title: <Link to={`/KCBranchManager/Orders`}>Orders</Link>,
                },
                {
                  title: "Add Order",
                },
            ]}
            />

            <h3 className="fw-bold mar-bottom-1">Add Orders ({user?.branch?.size || ""})</h3>

            <div className="d-flex align-items-center justify-content-between mar-bottom-1">
                <div className="d-flex gap3">
                    <Select
                    size="large"
                    style={{width: 200}}
                    options={days.map(day => ({label: day, value: day}))}
                    value={selectedDay}
                    onChange={(val) => setSelectedDay(val)}
                    />
                </div>
                <Button
                size="large"
                type="primary"
                disabled={!selectedMenusIn || selectedMenusIn?.length < 1}
                onClick={handleCheckout}>
                    Proceed Checkout
                </Button>
            </div>

            {!menus
            ? (<Spin size="large"/>)
            : (
                <Table
                columns={menuSettingsColumns}
                dataSource={transformedShifts}
                size="small"
                bordered
                pagination={false}
                loading={!menus || !selectedMenusIn}
                expandable={{defaultExpandedRowKeys: getDefaultExpandedKeys(transformedShifts)}}
                />
            )}
        </div>
    )
}