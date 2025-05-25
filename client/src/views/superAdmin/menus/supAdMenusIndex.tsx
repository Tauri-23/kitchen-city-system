import { Input, Table, TableColumnsType } from "antd";
import { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { useSuperAdminContext } from "../../../contexts/SuperAdminContext";

export default function SuperAdminMenusIndex() {
    const {setActiveSideNavLink} = useSuperAdminContext();

    const {Search} = Input;

    const navigate = useNavigate();
    
    const weeks = [{week: 1}, {week: 2}, {week: 3}, {week: 4}];
    



    /**
     * Onmount
     */
    useEffect(() => {
        setActiveSideNavLink("Menus");
    }, []);



    /**
     * Setup Columns
     */
    const simplifiedMenuColumns: TableColumnsType<any> = [
        {
            title: "Week",
            render: (_, row) => `Week ${row.week}`
        },
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
        <div className="content1 compressed">
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
                </div>
                
                {/* Table Itself */}
                <Table
                size="small"
                columns={simplifiedMenuColumns}
                dataSource={weeks.map((item, index) => ({...item, key: index}))}
                bordered
                onRow={(item) => ({
                    onDoubleClick: () => navigate(`../ViewMenu/${item.week}`)
                })}
                />
        </div>
    )
}