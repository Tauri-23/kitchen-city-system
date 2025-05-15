import { useEffect, useState } from "react";
import { useSuperAdminContext } from "../../../contexts/SuperAdminContext";
import { Link, useNavigate, useParams } from "react-router-dom";
import { Breadcrumb, Button, Select, Spin, Table, TableColumnsType } from "antd";
import "../../../assets/css/viewMenu.css";
import { MenuDishStructure } from "../../../types/menuDishStructure";
import { formatToPhilPeso } from "../../../assets/lib/utils";
import { fetchAllMenuDishesWhereWeek } from "../../../services/menuDishesServices";

interface menuDishNamesByMealTypeStructure {
    mealType: string;
    dishNames: string[];
}

export default function SuperAdminViewMenu() {
    const { setActiveSideNavLink } = useSuperAdminContext();

    const [dishes, setDishes] = useState<MenuDishStructure[] | null>(null);
    const [menuDishNamesByMealType, setMenuDishNamesByMealType] = useState<menuDishNamesByMealTypeStructure[] | null>(null);
    
    const days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    const sizes = ["XL", "Large", "Medium", "Medium Frying", "Small", "Small Frying"];
    const mealTypes = ["Breakfast", "Lunch", "Snack", "Dinner", "Midnight Lunch", "Midnight Snack"];
    
    const [selectedSize, setSelectedSize] = useState<string>(sizes[0]);


    const params = useParams();
    const navigate = useNavigate();



    /**
     * Onmount
     */
    useEffect(() => {
        setActiveSideNavLink("Menus");

        const getAll = async() => {
            const dishesData = await fetchAllMenuDishesWhereWeek(String(params.id));
            setDishes(dishesData);
        }

        getAll();
    }, []);

    useEffect(() => {
        if(dishes) {
            const extractedMenuDishNames = mealTypes.map(mealType => {
                const basedDish = dishes.filter((x: MenuDishStructure) => 
                    x.menu?.meal_type === mealType && 
                    x.menu.menu_day === days[0] && x.menu.menu_size === selectedSize
                );
                return {
                    mealType,
                    dishNames: basedDish.flatMap((x: MenuDishStructure) => x.name)
                }
            });

            setMenuDishNamesByMealType(extractedMenuDishNames);
        }
    }, [selectedSize, dishes])



    /**
     * Setup Columns
     */
    const dishesColumns: TableColumnsType<any> = [
        {
            title: "Dish Name",
            fixed: "left",
            dataIndex: "dishName",
            width: 250
        },
        ...days.map(day => ({
            title: day,
            children: [
            {
                title: "Description",
                render: (_: never, row: any) => {
                    const dish = dishes?.find(dish => 
                        dish.menu?.meal_type === row.mealType && 
                        dish.menu?.menu_size === selectedSize &&
                        dish.name === row.dishName && 
                        dish.menu?.menu_day === day
                    )

                    return dish ? dish.odoo_name : "-"
                },
                width: 250,
            },
            {
                title: "Category",
                render: (_: never, row: any) => {
                    const dish = dishes?.find(dish => 
                        dish.menu?.meal_type === row.mealType && 
                        dish.menu?.menu_size === selectedSize &&
                        dish.name === row.dishName && 
                        dish.menu?.menu_day === day
                    )

                    return dish ? dish.category?.category : "-" 
                },
                width: 150,
            },
            {
                title: "Unit Cost",
                render: (_: never, row: any) => {
                    const dish = dishes?.find(dish => 
                        dish.menu?.meal_type === row.mealType && 
                        dish.menu?.menu_size === selectedSize &&
                        dish.name === row.dishName && 
                        dish.menu?.menu_day === day
                    )

                    return dish ? formatToPhilPeso(dish.unit_cost) : "-"
                },
                width: 100,
            },
            {
                title: "Production",
                render: (_: never, row: any) => {
                    const dish = dishes?.find(dish => 
                        dish.menu?.meal_type === row.mealType && 
                        dish.menu?.menu_size === selectedSize &&
                        dish.name === row.dishName && 
                        dish.menu?.menu_day === day
                    )

                    return dish ? dish.production : "-"
                },
                width: 150,
            }
            ]
        }))
    ];



    /**
     * Render
     */
    return(
        <div className="content1 compressed">
            {!dishes || !menuDishNamesByMealType
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

                    {/* Menu Information */}
                    {/* <div className="viewMenuCont1 mar-bottom-1">
                        <div className="d-flex align-items-center">
                            <div className="text-m1 fw-bold" style={{width: 120}}>
                                Week
                            </div>
                            <div className="text-m1">
                                : {menu.menu_week}
                            </div>
                        </div>

                        <div className="d-flex align-items-center">
                            <div className="text-m1 fw-bold" style={{width: 120}}>
                                Day
                            </div>
                            <div className="text-m1">
                                : {menu.menu_day}
                            </div>
                        </div>

                        <div className="d-flex align-items-center">
                            <div className="text-m1 fw-bold" style={{width: 120}}>
                                Meal Type
                            </div>
                            <div className="text-m1">
                                : {menu.meal_type}
                            </div>
                        </div>

                        <div className="d-flex align-items-center">
                            <div className="text-m1 fw-bold" style={{width: 120}}>
                                Size
                            </div>
                            <div className="text-m1">
                                : {menu.menu_size}
                            </div>
                        </div>
                    </div> */}

                    {/* Menu Dishes */}
                    <h4 className="fw-bold mar-bottom-1">Dishes</h4>

                    <div 
                    className="d-flex align-items-center justify-content-between mar-bottom-1"
                    >
                        <Select
                        size="large"
                        style={{width: 200}}
                        value={selectedSize}
                        onChange={(val) => setSelectedSize(val)}
                        options={sizes.map(size => ({label: size, value: size}))}/>
                        <Button
                        size="large"
                        type="primary"
                        onClick={() => navigate(`../AddMenuDish/1`)}>
                            Add Dish
                        </Button>
                    </div>
                    
                    {mealTypes.map((mealType, index) => (
                        <div key={index} className="mar-bottom-2">
                            <h3>{mealType}</h3>

                            <Table
                            size="small"
                            dataSource={
                                // dishes?.filter(dish => dish.menu?.meal_type === mealType && dish.menu.menu_size === selectedSize).map((item, index) => ({...item, key: index})) || []
                                menuDishNamesByMealType.find(x => x.mealType === mealType)?.dishNames.map((item, index) => ({
                                    key: index,
                                    mealType,
                                    dishName: item
                                })) || []
                            }
                            columns={dishesColumns}
                            scroll={{ x: 'max-content', y: "600px" }}
                            pagination={false}
                            bordered/>
                        </div>
                    ))}
                    
                </>
            )}
        </div>
    )
}