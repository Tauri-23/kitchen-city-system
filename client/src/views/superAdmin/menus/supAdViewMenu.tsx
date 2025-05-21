import { useEffect, useState } from "react";
import { useSuperAdminContext } from "../../../contexts/SuperAdminContext";
import { Link, useNavigate, useParams } from "react-router-dom";
import { Breadcrumb, Button, Select, Spin, Table, TableColumnsType } from "antd";
import "../../../assets/css/viewMenu.css";
import { fetchAllMenusWhereWeek } from "../../../services/menusServices";
import { MenuStructure } from "../../../types/menuStructure";
import { MenuShiftStructure } from "../../../types/menuShiftStructure";
import { MenuFormElementStructure } from "../../../types/menuFormElementStructure";
import { MenuClassStructure } from "../../../types/menuClassStructure";
import { fetchAllMenuShifts } from "../../../services/menuShiftsServices";
import { fetchAllMenuFormElements } from "../../../services/menuFormElementServices";
import { fetchAllMenuClasses } from "../../../services/menuClassesServices";
import { MenuDishStructure } from "../../../types/menuDishStructure";
import { fetchAllMenuDishes } from "../../../services/menuDishesServices";

export default function SuperAdminViewMenu() {
    const { setActiveSideNavLink } = useSuperAdminContext();

    const [menus, setMenus] = useState<MenuStructure[] | null>(null);
    const [shifts, setShifts] = useState<MenuShiftStructure[] | null>(null);
    const [menuFormElements, setmenuFormElements] = useState<MenuFormElementStructure[] | null>(null);
    const [menuClasses, setMenuClasses] = useState<MenuClassStructure[] | null>(null);
    const [menuDishes, setMenuDishes] = useState<MenuDishStructure[] | null>(null);
    
    const days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    const sizes = ["XL", "Large", "Medium", "Medium Frying", "Small", "Small Frying"];
    const mealTypes = ["Breakfast", "Lunch", "Snack", "Dinner", "Midnight Lunch", "Midnight Snack"];
    
    const [selectedSize, setSelectedSize] = useState<string>(sizes[0]);
    const [selectedDishesIn, setSelectedDishesIn] = useState<MenuStructure[]>([]);


    const params = useParams();
    const navigate = useNavigate();



    /**
     * Onmount
     */
    useEffect(() => {
        setActiveSideNavLink("Menus");

        const getAll = async() => {
            const [menusData, shiftsData, menuFormElementsData, menuClassesData, menuDishesData] = await Promise.all([
                fetchAllMenusWhereWeek(String(params.id)),
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
        }

        getAll();
    }, []);



    /**
     * Setup Columns
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
                subCategory: tag.menu_sub_category_id,
                class: tag.menu_class_id,
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
                if(row.type === "tag") {
                    return(
                        <Select
                        className="w-100"
                        size="small"
                        options={[
                            {label: "-", value: ""},
                            ...menuDishes
                            ? menuDishes.filter(dish => dish.menu_sub_category_id === row.subCategory && dish.menu_class_id === row.class)
                            .map(dish => ({label: dish.name, value: dish.id})) : []
                        ]}
                        value={""}/>
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
                if(row.type === "tag") {
                    return " - "
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
                if(row.type === "tag") {
                    return " - "
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
                if(row.type === "tag") {
                    return " - "
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
                if(row.type === "tag") {
                    return " - "
                }
            },
            onCell: (row) => ({
                colSpan: row.type === "tag" ? 1 : 0
            }),
            width: 200
        },
    ];
    


    /**
     * Render
     */
    return(
        <div className="content1 compressed">
            {!menus || !shifts || !menuFormElements || !menuClasses || !menuDishes
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
        </div>
    )
}