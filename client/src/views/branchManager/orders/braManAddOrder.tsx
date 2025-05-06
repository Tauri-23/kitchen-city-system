import { useEffect, useState } from "react";
import { useBranchManagerContext } from "../../../contexts/BranchManagerContext"
import { formatToPhilPeso, getWeekOfMonthFixed4 } from "../../../assets/lib/utils";
import { MenuStructure } from "../../../types/menuStructure";
import { fetchAllMenusWhereWeek } from "../../../services/menusServices";
import { Button, Select, Spin, Table, TableColumnsType } from "antd";
import { MenuDishStructure } from "../../../types/menuDishStructure";

export default function BranchManagerAddOrder() {
    const { setActiveSideNavLink } = useBranchManagerContext();

    const [menus, setMenus] = useState<MenuStructure[] | null>(null);

    const days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    const sizes = ["XL", "Large", "Medium", "Medium Frying", "Small", "Small Frying"];
    const mealType = ["Breakfast", "Lunch", "Snack", "Dinner", "Midnight Lunch", "Midnight Snack"];
    
    const dateNow = new Date();
    const weekNow = getWeekOfMonthFixed4(dateNow);

    const [selectedDay, setSelectedDay] = useState<string>((days[dateNow.getDay() -1]));
    const [selectedSize, setSelectedSize] = useState<string>("XL");

    const filteredMenus = menus?.filter(menu => menu.menu_day === selectedDay && menu.menu_size === selectedSize);



    /**
     * Onmount
     */
    useEffect(() => {
        setActiveSideNavLink("Orders");

        const getAll = async() => {
            const data = await fetchAllMenusWhereWeek(weekNow);
            setMenus(data);
        }

        getAll();
    }, []);



    /**
     * Setup Columns
     */
    const orderCols: TableColumnsType<MenuDishStructure> = [
        {
            title: "Dish Name",
            dataIndex: "name"
        },
        {
            title: "Odoo Name",
            dataIndex: "odoo_name"
        },
        {
            title: "Category",
            render: (_, row) => row.category?.category
        },
        {
            title: "Unit Cost",
            render: (_, row) => formatToPhilPeso(row.unit_cost)
        },
        {
            title: "Production",
            dataIndex: "production"
        },
        {
            title: "QTY Ordered",
            render: () => 0
        },
        {
            title: "Actions",
            render: () => <Button type="primary" ghost>Order Item</Button>
        },
    ]



    /**
     * Render
     */
    return(
        <div className="content1 compressed">
            <h3 className="fw-bold mar-bottom-1">Add Orders</h3>

            <div className="mar-bottom-2">Avaliable menus (Week {weekNow})</div>

            <div className="d-flex align-items-center gap3 mar-bottom-1">
                <Select
                size="large"
                style={{width: 200}}
                options={[
                    ...days.map(day => ({label: day, value: day}))
                ]}
                value={selectedDay}
                onChange={(val) => setSelectedDay(val)}
                />

                <Select
                size="large"
                style={{width: 200}}
                options={[
                    ...sizes.map(size => ({label: size, value: size}))
                ]}
                value={selectedSize}
                onChange={(val) => setSelectedSize(val)}
                />
            </div>


                {!menus
                ? (<Spin size="large"/>)
                : (
                    <>
                        {/* Breakfast */}
                        <div className="mar-bottom-3">
                            <h4>Breakfast</h4>
                            <Table
                            columns={orderCols}
                            dataSource={
                                filteredMenus?.find(x => x.meal_type === "Breakfast")
                                ?.menu_dishes?.map((menuDish, index) => ({...menuDish, key: index}))
                            }
                            bordered/>
                        </div>

                        {/* Lunch */}
                        <h4>Lunch</h4>
                        {filteredMenus?.filter(x => x.meal_type === "Lunch")?.map((menu, index) => (
                            <div key={index}>
                                
                                {menu.menu_name}
                            </div>
                        ))}
                    </>
                )}
            </div>
    )
}