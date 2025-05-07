import { Button, Input, Spin, Table, TableColumnsType } from "antd";
import { MenuStructure } from "../../../types/menuStructure";
import { useEffect, useState } from "react";
import { fetchAllMenus } from "../../../services/menusServices";
import { useNavigate } from "react-router-dom";

export default function SuperAdminMenusIndex() {
    const [menus, setMenus] = useState<MenuStructure[] | null>(null);
    const [filteredMenus, setFilteredMenus] = useState<MenuStructure[] | null>(null);

    const {Search} = Input;
    const navigate = useNavigate();

    const days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    const weeks = [1, 2, 3, 4];
    const sizes = ["XL", "Large", "Medium", "Medium Frying", "Small", "Small Frying"];
    const mealTypes = ["Breakfast", "Lunch", "Snack", "Dinner", "Midnight Lunch", "Midnight Snack"];



    /**
     * Onmount
     */
    useEffect(() => {
        const getAll = async() => {
            const data = await fetchAllMenus();
            setMenus(data);
            setFilteredMenus(data);
        }

        getAll();
    }, []);



    /**
     * Setup Columns
     */
    const menuColumns: TableColumnsType<MenuStructure> = [
        {
            title: "Menu Id",
            dataIndex: "id"
        },
        {
            title: "Menu Name",
            dataIndex: "menu_name"
        },
        {
            title: "Week",
            dataIndex: "menu_week"
        },
        {
            title: "Day",
            dataIndex: "menu_day"
        },
        {
            title: "Meal Type",
            dataIndex: "meal_type"
        },
        {
            title: "Size",
            dataIndex: "menu_size"
        },
        {
            title: "Dishes",
            render: (_, row) => row?.menu_dishes?.length
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
            {!menus || !filteredMenus
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

                    {weeks.map((week, index) => (
                        <div key={index} className="mar-bottom-1">
                            <h4 className="fw-bold mar-bottom-2">Week {week}</h4>
                            <Table
                            columns={menuColumns}
                            dataSource={filteredMenus.filter(menu => menu.menu_week === week).map((item, index) => ({...item, key: index}))}
                            bordered
                            onRow={(item) => ({
                                onDoubleClick: () => navigate(`../ViewMenu/${item.id}`)
                            })}
                            />
                        </div>
                    ))}
                </>
            )}
        </>
    )
}