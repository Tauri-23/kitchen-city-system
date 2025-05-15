import { Button, Input, Spin, Table, TableColumnsType } from "antd";
import { MenuStructure } from "../../../types/menuStructure";
import { useEffect, useState } from "react";
import { fetchAllMenus } from "../../../services/menusServices";
import { useNavigate } from "react-router-dom";

interface SimplifiedMenuStructure {
    week: number;
    dishes_count: number;
}

export default function SuperAdminMenusIndex() {
    const [menus, setMenus] = useState<MenuStructure[] | null>(null);
    const [filteredMenus, setFilteredMenus] = useState<MenuStructure[] | null>(null);

    const {Search} = Input;
    const navigate = useNavigate();

    // const days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    const weeks = [1, 2, 3, 4];
    // const sizes = ["XL", "Large", "Medium", "Medium Frying", "Small", "Small Frying"];

    // const [selectedSize, setSelectedSize] = useState<string>(sizes[0]);
    // const mealTypes = ["Breakfast", "Lunch", "Snack", "Dinner", "Midnight Lunch", "Midnight Snack"];

    const [simplifiedMenus, setSimplifiedMenus] = useState<SimplifiedMenuStructure[] | null>(null);



    /**
     * Onmount
     */
    useEffect(() => {
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

                    <div className="d-flex gap3 mar-bottom-1">
                        {/* <Select
                        style={{width: 150}}
                        size="large"
                        options={[
                            ...days.map(day => ({label: day, value: day}))
                        ]}
                        value={selectedDay}
                        onChange={(val) => {setSelectedDay(val); console.log(val)}}
                        /> */}

                        {/* <Select
                        size="large"
                        style={{width: 180}}
                        options={[
                            ...sizes.map(size => ({label: size, value: size}))
                        ]}
                        value={selectedSize}
                        onChange={(val) => setSelectedSize(val)}
                        /> */}
                        
                        {/* <Select
                        size="large"
                        style={{width: 180}}
                        options={[
                            ...weeks.map(week => ({label: `Week ${week}`, value: week}))
                        ]}
                        value={selectedWeek}
                        onChange={(val) => setSelectedWeek(val)}
                        /> */}
                    </div>
                    

                    {/* Table Itself */}
                    <div className="mar-bottom-l3">
                        <h5 className="fw-bold mar-bottom-1">Menus</h5>
                        <Table
                        size="small"
                        columns={simplifiedMenuColumns}
                        dataSource={simplifiedMenus}
                        bordered
                        onRow={(item) => ({
                            onDoubleClick: () => navigate(`../ViewMenu/${item.week}`)
                        })}
                        />

                        {/* <Table
                        size="small"
                        columns={menuColumns}
                        dataSource={filteredMenus
                            .filter(menu => menu.menu_size === selectedSize)
                            .map((item, index) => ({...item, key: index}))}
                        bordered
                        onRow={(item) => ({
                            onDoubleClick: () => navigate(`../ViewMenu/${item.id}`)
                        })}
                        /> */}
                    </div>
                </>
            )}
        </>
    )
}