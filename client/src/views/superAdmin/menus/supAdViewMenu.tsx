import { useEffect, useState } from "react";
import { useSuperAdminContext } from "../../../contexts/SuperAdminContext";
import { Link, useNavigate, useParams } from "react-router-dom";
import { fetchMenuById } from "../../../services/menusServices";
import { MenuStructure } from "../../../types/menuStructure";
import { Breadcrumb, Button, Spin, Table, TableColumnsType } from "antd";
import "../../../assets/css/viewMenu.css";
import { MenuDishStructure } from "../../../types/menuDishStructure";
import { formatToPhilPeso } from "../../../assets/lib/utils";

export default function SuperAdminViewMenu() {
    const { setActiveSideNavLink } = useSuperAdminContext();

    const [menu, setMenu] = useState<MenuStructure | null>(null);

    const params = useParams();
    const navigate = useNavigate();



    /**
     * Onmount
     */
    useEffect(() => {
        setActiveSideNavLink("Menus");

        const getAll = async() => {
            const data = await fetchMenuById(String(params.id));
            console.log(data);
            setMenu(data);
        }

        getAll();
    }, []);



    /**
     * Setup Columns
     */
    const dishesColumns: TableColumnsType<MenuDishStructure> = [
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
    ]



    /**
     * Render
     */
    return(
        <div className="content1 compressed">
            {!menu
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
                        title: menu.menu_name,
                        },
                    ]}
                    />
                
                    <h3 className="fw-bold mar-bottom-1">{menu.menu_name}</h3>

                    {/* Menu Information */}
                    <div className="viewMenuCont1 mar-bottom-1">
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
                    </div>

                    {/* Menu Dishes */}
                    <h4 className="fw-bold mar-bottom-1">Dishes</h4>

                    <div 
                    className="d-flex align-items-center justify-content-between mar-bottom-1"
                    >
                        <Button
                        size="large"
                        type="primary"
                        onClick={() => navigate(`../AddMenuDish/${menu.id}`)}>
                            Add Dish
                        </Button>
                    </div>

                    <Table
                    dataSource={menu.menu_dishes?.map((item, index) => ({...item, key: index})) || []}
                    columns={dishesColumns}
                    bordered/>
                </>
            )}
        </div>
    )
}