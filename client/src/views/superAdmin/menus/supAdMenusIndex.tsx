import { Button, Input, Spin, Table, TableColumnsType } from "antd";
import { MenuStructure } from "../../../types/menuStructure";
import { useEffect, useState } from "react";
import { fetchAllMenus } from "../../../services/menusServices";

export default function SuperAdminMenusIndex() {
    const [menus, setMenus] = useState<MenuStructure[] | null>(null);
    const [filteredMenus, setFilteredMenus] = useState<MenuStructure[] | null>(null);

    const {Search} = Input;



    /**
     * Onmount
     */
    useEffect(() => {
        const getAll = async() => {
            const data = await fetchAllMenus();
            console.log(data);
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
            title: "Menu Name",
            dataIndex: "menu_name"
        },
        {
            title: "Week",
            dataIndex: "menu_week"
        },
        {
            title: "Meal Type",
            dataIndex: "meal_type"
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
                        placeholder="input search text" 
                        onSearch={handleSearch} enterButton
                        style={{width: 300}} 
                        />
                        
                        <Button
                        type="primary"
                        href="AddMenu"
                        >Add Menu
                        </Button>
                    </div>

                    <Table
                    columns={menuColumns}
                    dataSource={filteredMenus.map((item, index) => ({...item, key: index}))}
                    bordered
                    />
                </>
            )}
        </>
    )
}