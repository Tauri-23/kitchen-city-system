import { useEffect, useState } from "react";
import { useBranchManagerContext } from "../../../contexts/BranchManagerContext"
import { formatToPhilPeso } from "../../../assets/lib/utils";
import { MenuStructure } from "../../../types/menuStructure";
import { fetchAllMenusWhereWeek } from "../../../services/menusServices";
import { Breadcrumb, Button, InputNumber, Select, Spin, Table, TableColumnsType } from "antd";
import { MenuDishStructure } from "../../../types/menuDishStructure";
import { useGeneralContext } from "../../../contexts/GeneralContext";
import { Link, useNavigate } from "react-router-dom";

export default function BranchManagerAddOrder() {
    const { setActiveSideNavLink } = useBranchManagerContext();
    const { showModal } = useGeneralContext();

    const [menus, setMenus] = useState<MenuStructure[] | null>(null);

    const days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    const sizes = ["XL", "Large", "Medium", "Medium Frying", "Small", "Small Frying"];
    const mealTypes = ["Breakfast", "Lunch", "Snack", "Dinner", "Midnight Lunch", "Midnight Snack"];
    
    const navigate = useNavigate();
    const dateNow = new Date();
    const weekNow = 1;

    const [selectedDay, setSelectedDay] = useState<string>((days[dateNow.getDay() -1]));
    const [selectedSize, setSelectedSize] = useState<string>(sizes[0]);
    const [selectedMealType, setSelectedMealType] = useState<string>(mealTypes[0]);
    const [processedMenus, setprocessedMenus] = useState<MenuStructure[] | null>(null);

    const orderedDishes = processedMenus
    ?.flatMap(menu => 
        menu.menu_dishes?.filter(dish => dish.qtySelected > 0) ?? []
    ) || [];


    /**
     * Onmount
     */
    useEffect(() => {
        setActiveSideNavLink("Orders");

        const getAll = async() => {
            const data = await fetchAllMenusWhereWeek(weekNow);
            setMenus(data);

            setprocessedMenus(
            data?.map((menu: MenuStructure) => ({
                ...menu,
                menu_dishes: (menu.menu_dishes || []).map((dish: MenuDishStructure) => ({
                ...dish,
                qtySelected: 0
                }))
            })));
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
            title: "Order Price",
            render: (_, row) => formatToPhilPeso(row.qtySelected * row.unit_cost)
        },
        {
            title: "QTY Ordered",
            render: (_, row) => (
                <>
                    <InputNumber
                    size="large"
                    style={{width: 100}}
                    value={row.qtySelected}
                    maxLength={1000}
                    min={0}
                    onChange={(value) => {
                        const updatedMenus = processedMenus?.map(menu => {
                            const updatedDishes = menu.menu_dishes
                                ? menu.menu_dishes.map(dish => {
                                    if (dish.id === row.id) {
                                        return {
                                            ...dish,
                                            qtySelected: value
                                        };
                                    }
                                    return dish;
                                })
                                : null;
                        
                            return {
                                ...menu,
                                menu_dishes: updatedDishes
                            };
                        });
                        
                        setprocessedMenus(updatedMenus as MenuStructure[] | null);
                    }}
                    />
                </>
            )
        }
    ];



    /**
     * Handlers
     */
    // const handleRemoveOrder = (menuDish: MenuDishStructure) => {
    //     const updatedMenus = processedMenus?.map(menu => {
    //         const updatedDishes = menu.menu_dishes
    //             ? menu.menu_dishes.map(dish => {
    //                 if (dish.id === menuDish.id) {
    //                     return {
    //                         ...dish,
    //                         qtySelected: 0
    //                     };
    //                 }
    //                 return dish;
    //             })
    //             : null;
        
    //         return {
    //             ...menu,
    //             menu_dishes: updatedDishes
    //         };
    //     });
    
    //     setprocessedMenus(updatedMenus || null);

    //     notify("success", "Order Removed", "top-center", 3000);
    // }

    const handleCheckout = () => {
        showModal("BranchManagerOrderCheckoutModal", {
            orderedDishes,
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

            <h3 className="fw-bold mar-bottom-1">Add Orders</h3>

            <div className="mar-bottom-2">Avaliable menus (Week {weekNow})</div>

            <div className="d-flex align-items-center justify-content-between mar-bottom-1">
                <div className="d-flex align-items-center gap3">
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

                    <Select
                    size="large"
                    style={{width: 200}}
                    options={[
                        ...mealTypes.map(mealType => ({label: mealType, value: mealType}))
                    ]}
                    value={selectedMealType}
                    onChange={(val) => setSelectedMealType(val)}
                    />
                </div>

                <Button
                size="large"
                type="primary"
                disabled={orderedDishes?.length < 1}
                onClick={handleCheckout}>
                    Proceed Checkout
                </Button>
            </div>

            {!menus
            ? (<Spin size="large"/>)
            : (
                <>
                    {/* Breakfast */}
                    <div className="mar-bottom-3">
                        <h4>{selectedMealType}</h4>
                        <Table
                        columns={orderCols}
                        dataSource={
                            processedMenus?.find((menu) => menu.meal_type === selectedMealType && menu.menu_day === selectedDay && menu.menu_size === selectedSize)
                            ?.menu_dishes?.map((menuDish: any, index: any) => ({...menuDish, key: index}))
                        }
                        bordered
                        pagination={false}/>
                    </div>
                </>
            )}
        </div>
    )
}