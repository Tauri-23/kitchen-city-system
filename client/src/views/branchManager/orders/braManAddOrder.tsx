import { useEffect, useState } from "react";
import { useBranchManagerContext } from "../../../contexts/BranchManagerContext"
import { formatToPhilPeso } from "../../../assets/lib/utils";
import { MenuStructure } from "../../../types/menuStructure";
import { Breadcrumb, Button, InputNumber, Select, Spin, Table, TableColumnsType } from "antd";
import { MenuDishStructure } from "../../../types/menuDishStructure";
import { useGeneralContext } from "../../../contexts/GeneralContext";
import { Link, useNavigate } from "react-router-dom";
import { MenuShiftStructure } from "../../../types/menuShiftStructure";
import { MenuFormElementStructure } from "../../../types/menuFormElementStructure";
import { MenuClassStructure } from "../../../types/menuClassStructure";
import { fetchAllMenusWhereWeekDayAndSize } from "../../../services/menusServices";
import { fetchAllMenuShifts } from "../../../services/menuShiftsServices";
import { fetchAllMenuFormElements } from "../../../services/menuFormElementServices";
import { fetchAllMenuClasses } from "../../../services/menuClassesServices";
import { fetchAllMenuDishes } from "../../../services/menuDishesServices";

export type SelectedMenusType = {
    menu_shift_id: number;
    menu_class_id: number;
    menu_sub_category_id: number;
    menu_dish_id: string;
    menu_dish: MenuDishStructure;
    qty_selected: number;
};

export default function BranchManagerAddOrder() {
    const { setActiveSideNavLink } = useBranchManagerContext();
    const { showModal } = useGeneralContext();

    const navigate = useNavigate();

    const [menus, setMenus] = useState<MenuStructure[] | null>(null);
    const [shifts, setShifts] = useState<MenuShiftStructure[] | null>(null);
    const [menuFormElements, setmenuFormElements] = useState<MenuFormElementStructure[] | null>(null);
    const [menuClasses, setMenuClasses] = useState<MenuClassStructure[] | null>(null);
    const [menuDishes, setMenuDishes] = useState<MenuDishStructure[] | null>(null);
    const [selectedMenusIn, setSelectedMenusIn] = useState<SelectedMenusType[] | null>([]);

    const days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    const sizes = ["XL", "Large", "Medium", "Medium Frying", "Small", "Small Frying"];

    const dateNow = new Date();
    const weekNow = 1;

    const [selectedDay, setSelectedDay] = useState<string>((days[0]));
    const [selectedSize, setSelectedSize] = useState<string>(sizes[0]);


    /**
     * Onmount
     */
    useEffect(() => {
        setActiveSideNavLink("Orders");

        const getAll = async() => {
            const [menusData, shiftsData, menuFormElementsData, menuClassesData, menuDishesData] = await Promise.all([
                fetchAllMenusWhereWeekDayAndSize(String(weekNow), selectedDay, selectedSize),
                fetchAllMenuShifts(),
                fetchAllMenuFormElements(),
                fetchAllMenuClasses(),
                fetchAllMenuDishes()
            ]);
            setMenus(menusData);
            setShifts(shiftsData);
            setmenuFormElements(menuFormElementsData);
            setMenuClasses(menuClassesData);
            setMenuDishes(menuDishesData);
            setSelectedMenusIn(menusData.map((menu: MenuStructure) => ({
                menu_shift_id: menu.menu_shift_id,
                menu_class_id: menu.menu_class_id,
                menu_sub_category_id: menu.menu_sub_category_id,
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
            const data = await fetchAllMenusWhereWeekDayAndSize(String(weekNow), selectedDay, selectedSize);
            setMenus(data);
            setSelectedMenusIn(data.map((menu: MenuStructure) => ({
                menu_shift_id: menu.menu_shift_id,
                menu_class_id: menu.menu_class_id,
                menu_sub_category_id: menu.menu_sub_category_id,
                menu_dish_id: menu.menu_dish_id,
                menu_dish: menu.menu_dish,
                qty_selected: 0
            })));
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
        children: menuFormElements?.filter(element => element.menu_shift_id === shift.id).map(menuClass => ({
            key: `class-${menuClass.id}`,
            id: menuClass.id,
            class: menuClass.menu_class.class,
            type: "class",
            children: menuClass.menu_class.menu_tags.map(tag => ({
                key: `tag-${shift.id}-${tag.menu_class_id}-${tag.id}`,
                id: tag.id,
                tag: tag.tag,
                shiftId: shift.id,
                subCategoryId: tag.menu_sub_category_id,
                classId: tag.menu_class_id,
                type: "tag"
            }))
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
            title: "Name",
            render: (_, row) => {
                return row.type === "shift" ? row.shift : (row.type === "class" ? row.class : row.tag);
            },
            onCell: (row) => ({
                style: {
                    backgroundColor: row.type === "shift" ? 'black' : (row.type === "class" ? "orange" : undefined),
                    color: row.type === "shift" ? "white" : "black"
                },
                colSpan: row.type === "tag" ? 1 : 7
            }),
            width: 150
        },
        {
            title: "Dish",
            render: (_, row) => {
                const value = selectedMenusIn?.find(dish => 
                    dish.menu_sub_category_id === row.subCategoryId && dish.menu_class_id === row.classId 
                    && dish.menu_shift_id === row.shiftId
                );

                if(row.type === "tag") {
                    return value?.menu_dish.name || "-"
                }
            },
            onCell: (row) => ({
                colSpan: row.type === "tag" ? 1 : 0
            }),
            width: 250
        },
        {
            title: "Unit Cost",
            render: (_, row) => {
                const value = selectedMenusIn?.find(dish => 
                    dish.menu_sub_category_id === row.subCategoryId && dish.menu_class_id === row.classId 
                    && dish.menu_shift_id === row.shiftId
                );
                if(row.type === "tag") {
                    return value?.menu_dish ?  formatToPhilPeso(value?.menu_dish.unit_cost) : " - "
                }
            },
            onCell: (row) => ({
                colSpan: row.type === "tag" ? 1 : 0
            }),
            width: 100
        },
        {
            title: "SRP",
            render: (_, row) => {
                const value = selectedMenusIn?.find(dish => 
                    dish.menu_sub_category_id === row.subCategoryId && dish.menu_class_id === row.classId 
                    && dish.menu_shift_id === row.shiftId
                );
                if(row.type === "tag") {
                    return value?.menu_dish ?  formatToPhilPeso(value?.menu_dish.srp) : " - "
                }
            },
            onCell: (row) => ({
                colSpan: row.type === "tag" ? 1 : 0
            }),
            width: 100
        },
        {
            title: "Category",
            render: (_, row) => {
                const value = selectedMenusIn?.find(dish => 
                    dish.menu_sub_category_id === row.subCategoryId && dish.menu_class_id === row.classId 
                    && dish.menu_shift_id === row.shiftId
                );
                if(row.type === "tag") {
                    return value?.menu_dish ?  value?.menu_dish.menu_category.category : " - "
                }
            },
            onCell: (row) => ({
                colSpan: row.type === "tag" ? 1 : 0
            }),
            width: 200
        },
        {
            title: "Production",
            render: (_, row) => {
                const value = selectedMenusIn?.find(dish => 
                    dish.menu_sub_category_id === row.subCategoryId && dish.menu_class_id === row.classId 
                    && dish.menu_shift_id === row.shiftId
                );
                if(row.type === "tag") {
                    return value?.menu_dish ?  value?.menu_dish.production : " - "
                }
            },
            onCell: (row) => ({
                colSpan: row.type === "tag" ? 1 : 0
            }),
            width: 200
        },
        {
            title: "QTY Ordered",
            render: (_, row) => {
                if(row.type === "tag"){
                    const value = selectedMenusIn?.find(dish => 
                        dish.menu_sub_category_id === row.subCategoryId && dish.menu_class_id === row.classId 
                        && dish.menu_shift_id === row.shiftId
                    );
                    return value 
                    ? (
                        <>
                            <InputNumber
                            size="large"
                            className="w-100"
                            style={{width: 100}}
                            value={row.qtySelected}
                            maxLength={1000}
                            min={0}
                            onChange={(value) => {
                                const updatedMenus = selectedMenusIn?.map(dish => {
                                    if( dish.menu_sub_category_id === row.subCategoryId && 
                                    dish.menu_class_id === row.classId && dish.menu_shift_id === row.shiftId) {
                                        return {
                                            ...dish,
                                            qty_selected: value
                                        };
                                    }
                                    return dish
                                });
                                
                                setSelectedMenusIn(updatedMenus ?? null);
                            }}
                            />
                        </>
                    )
                    : "-"
                }
            },
            onCell: (row) => ({
                colSpan: row.type === "tag" ? 1 : 0
            }),
            width: 100,
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

            <h3 className="fw-bold mar-bottom-1">Add Orders</h3>

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