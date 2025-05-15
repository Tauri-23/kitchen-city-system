import { Button, Input, Spin, Table, TableColumnsType } from "antd";
import { MenuStructure } from "../../../types/menuStructure";
import { useEffect, useState } from "react";
import { fetchAllMenus } from "../../../services/menusServices";
import { useNavigate, useOutletContext } from "react-router-dom";
import { SuperAdminMenuActivePageTypes } from "./supAdMenusDefault";

interface SimplifiedMenuStructure {
    week: number;
    dishes_count: number;
}

interface OutletContextTypes {
    setSupAdMenuActivePage: (value: SuperAdminMenuActivePageTypes) => void;
}

export default function SuperAdminMenusIndex() {
    const {setSupAdMenuActivePage} = useOutletContext<OutletContextTypes>();
    const [menus, setMenus] = useState<MenuStructure[] | null>(null);
    const [filteredMenus, setFilteredMenus] = useState<MenuStructure[] | null>(null);
    const [simplifiedMenus, setSimplifiedMenus] = useState<SimplifiedMenuStructure[] | null>(null);

    const {Search} = Input;

    const navigate = useNavigate();
    
    const weeks = [1, 2, 3, 4];
    



    /**
     * Onmount
     */
    useEffect(() => {
        setSupAdMenuActivePage("Menu");

        const getAll = async() => {
            const menuData = await fetchAllMenus();
            setMenus(menuData);
            setFilteredMenus(menuData);

            const simplifiedMenusData = weeks.map((week) => {
                const filteredMenuData = menuData.filter((menu: MenuStructure) => menu.menu_week === week);

                const dishCount = filteredMenuData.reduce((sum: any, dish: MenuStructure) => {
                    return sum + (dish.menu_dishes?.length);
                }, 0);

                return {week, dishes_count: dishCount}
            });

            console.log(simplifiedMenusData);
            setSimplifiedMenus(simplifiedMenusData);
        }

        getAll();
    }, []);



    /**
     * Setup Columns
     */
    const simplifiedMenuColumns: TableColumnsType<SimplifiedMenuStructure> = [
        {
            title: "Week",
            render: (_, row) => `Week ${row.week}`
        },
        {
            title: "Dishes",
            render: (_, row) =>  `${row.dishes_count} Dishes`
        }
    ]



    /**
     * Handlers
     */
    const handleSearch = (value: string) => {
        console.log(value);
    }



    /**
     * Render
     */
    return(
        <>
            {!menus || !filteredMenus || !simplifiedMenus
            ? (<Spin size="large"/>)
            : (
                <>
                    <h3 className="fw-bold mar-bottom-1">Menus</h3>

                    <div 
                    className="d-flex align-items-center justify-content-between mar-bottom-1"
                    >
                        <Search 
                        size="large"
                        placeholder="input search text" 
                        onSearch={handleSearch} enterButton
                        style={{width: 300}} 
                        />
                        
                        <Button
                        size="large"
                        type="primary"
                        onClick={() => navigate("/KCSuperAdmin/AddMenu")}
                        >Add Menu
                        </Button>
                    </div>
                    

                    {/* Table Itself */}
                    <Table
                    size="small"
                    columns={simplifiedMenuColumns}
                    dataSource={simplifiedMenus}
                    bordered
                    onRow={(item) => ({
                        onDoubleClick: () => navigate(`../ViewMenu/${item.week}`)
                    })}
                    />
                </>
            )}
        </>
    )
}