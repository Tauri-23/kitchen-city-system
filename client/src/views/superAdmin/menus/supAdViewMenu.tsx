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
import { fetchAllMenuFormElements } from "../../../services/menuFormElementServices";
import { fetchAllMenuClasses } from "../../../services/menuClassesServices";
import { MenuDishStructure } from "../../../types/menuDishStructure";
import { fetchAllMenuDishes } from "../../../services/menuDishesServices";
import { formatToPhilPeso, notify } from "../../../assets/lib/utils";
import axiosClient from "../../../axios-client";

type SelectedDishType = {
    menu_shift_id: number;
    menu_class_id: number;
    menu_sub_category_id: number;
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
            const [menusData, shiftsData, menuFormElementsData, menuClassesData, menuDishesData] = await Promise.all([
                fetchAllMenusWhereWeekDayAndSize(String(params.id), selectedDay, selectedSize),
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
            setSelectedDishesIn(menusData.map((menu: MenuStructure) => ({
                menu_shift_id: menu.menu_shift_id,
                menu_class_id: menu.menu_class_id,
                menu_sub_category_id: menu.menu_sub_category_id,
                menu_dish_id: menu.menu_dish_id,
                menu_dish: menu.menu_dish
            })));
        }

        getAll();
    }, []);

    useEffect(() => {
        const updateMenus = async() => {
            setMenus(null);
            const data = await fetchAllMenusWhereWeekDayAndSize(String(params.id), selectedDay, selectedSize);
            setMenus(data);
            setSelectedDishesIn(data.map((menu: MenuStructure) => ({
                menu_shift_id: menu.menu_shift_id,
                menu_class_id: menu.menu_class_id,
                menu_sub_category_id: menu.menu_sub_category_id,
                menu_dish_id: menu.menu_dish_id,
                menu_dish: menu.menu_dish
            })));
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
                colSpan: row.type === "tag" ? 1 : 6
            }),
            width: 150
        },
        {
            title: "Dish",
            render: (_, row) => {
                const value = selectedDishesIn.find(dish => 
                    dish.menu_sub_category_id === row.subCategoryId && dish.menu_class_id === row.classId 
                    && dish.menu_shift_id === row.shiftId
                );
                if(row.type === "tag") {
                    return(
                        <Select
                        className="w-100"
                        size="small"
                        options={[
                            {label: "-", value: ""},
                            ...menuDishes
                            ? menuDishes.filter(dish => dish.menu_sub_category_id === row.subCategoryId && dish.menu_class_id === row.classId)
                            .map(dish => ({label: dish.name, value: dish.id})) : []
                        ]}
                        value={value?.menu_dish_id || ""}
                        onChange={(val) => handleInputMenuDish(row.shiftId, row.subCategoryId, row.classId, menuDishes?.find(dish => dish.id === val))}/>
                    )
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
                const value = selectedDishesIn.find(dish => 
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
                const value = selectedDishesIn.find(dish => 
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
                const value = selectedDishesIn.find(dish => 
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
                const value = selectedDishesIn.find(dish => 
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
    ];



    /**
     * Handlers
     */
    const handleInputMenuDish = (
        menuShiftId: number,
        menuSubCategoryId: number,
        menuClassId: number,
        newMenuDish?: MenuDishStructure
    ) => {

        setSelectedDishesIn(prev => {
            // Remove if newMenuDish is not provided
            if (!newMenuDish) {
                return prev.filter(
                    menu =>
                        !(
                            menu.menu_class_id === menuClassId &&
                            menu.menu_sub_category_id === menuSubCategoryId &&
                            menu.menu_shift_id === menuShiftId
                        )
                );
            }
            
            const exists = prev.some(menu =>
                menu.menu_class_id === menuClassId &&
                menu.menu_sub_category_id === menuSubCategoryId &&
                menu.menu_shift_id === menuShiftId
            );

            if (exists) {
                return prev.map(menu => {
                    if (
                        menu.menu_class_id === menuClassId &&
                        menu.menu_sub_category_id === menuSubCategoryId &&
                        menu.menu_shift_id === menuShiftId
                    ) {
                        return {
                            menu_shift_id: menuShiftId,
                            menu_class_id: menuClassId,
                            menu_sub_category_id: menuSubCategoryId,
                            menu_dish_id: newMenuDish.id,
                            menu_dish: newMenuDish
                        };
                    }
                    return menu;
                });
            } 
            else {
                return [
                    ...prev,
                    {
                        menu_shift_id: menuShiftId,
                        menu_class_id: menuClassId,
                        menu_sub_category_id: menuSubCategoryId,
                        menu_dish_id: newMenuDish.id,
                        menu_dish: newMenuDish
                    }
                ];
            }
        });
    };

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
            { !menuClasses
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
                    loading={!shifts || !menuFormElements || !menus || !menuDishes}
                    expandable={{defaultExpandedRowKeys: getDefaultExpandedKeys(transformedShifts)}}
                    />                    
                </>
            )}
        </div>
    )
}