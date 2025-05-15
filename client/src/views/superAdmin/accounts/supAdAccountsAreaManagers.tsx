import { useEffect, useState } from "react";
import { useOutletContext } from "react-router-dom"
import { SuperAdminAccountsOutletContextType } from "./supAdAccountsDefault";
import { Button, Input, Spin, Table, TableColumnsType } from "antd";
import { useGeneralContext } from "../../../contexts/GeneralContext";
import { AreaManagerStructure } from "../../../types/areaManagerSturcture";
import { fetchAllAreaManagers } from "../../../services/areaManagerServices";

export default function SuperAdminAccountsAreaManagers() {
    const { setActiveLink } = useOutletContext<SuperAdminAccountsOutletContextType>();
    const { showModal } = useGeneralContext();
    
    const [areaManagers, setAreaManagers] = useState<AreaManagerStructure[] | null>(null);
    
    const {Search} = Input;



    /**
     * Onmount
     */
    useEffect(() => {
        setActiveLink("Area Managers");
        
        const getAll = async() => {
            const data = await fetchAllAreaManagers();
            setAreaManagers(data);
        }

        getAll();
    }, []);



    /**
     * Setup Columns
     */
    const tableCols: TableColumnsType<AreaManagerStructure> = [
        {
            title: "Id",
            dataIndex: "id"
        },
        {
            title: "Name (FN MI. LN)",
            render: (_, row) => `${row.fname} ${row.mname ? row.mname[0] + "." : ""} ${row.lname}`
        },
        {
            title: "Email",
            dataIndex: "email"
        },
        {
            title: "Status",
            dataIndex: "status"
        },
    ]



    /**
     * Handlers
     */
    const handleSearch = (value: string) => {
        console.log(value);
    }

    const handleAddBtnClick = () => {
        showModal("SupAdAddAreaManagerModal", {
            setAreaManagers
        });
    }



    /**
     * Render
     */
    return (
        <>
            {!areaManagers
            ? (<Spin size="large"/>)
            : (
                <>
                    <div className="d-flex align-items-center justify-content-between mar-bottom-1">
                        <Search 
                        size="large"
                        placeholder="input search text" 
                        onSearch={handleSearch} enterButton
                        style={{width: 300}} 
                        />
                        
                        <Button
                        size="large"
                        type="primary"
                        onClick={handleAddBtnClick}
                        >
                            Add Area Manager
                        </Button>
                    </div>

                    <Table
                    size="small"
                    dataSource={areaManagers.map((item, index) => ({...item, key: index}))}
                    columns={tableCols}
                    bordered/>
                </>
            )}
        </>
    )
}
