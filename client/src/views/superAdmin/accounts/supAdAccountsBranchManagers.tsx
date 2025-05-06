import { useOutletContext } from "react-router-dom";
import { SuperAdminAccountsOutletContextType } from "./supAdAccountsDefault";
import { useEffect, useState } from "react";
import { useGeneralContext } from "../../../contexts/GeneralContext";
import { BranchManagerStructure } from "../../../types/branchManagerSturcture";
import { Button, Input, Spin, Table, TableColumnsType } from "antd";
import { fetchAllBranchManagers } from "../../../services/branchManagerServices";
import { BranchStructure } from "../../../types/branchStructure";
import { fetchAllBranches } from "../../../services/branchServices";

export default function SuperAdminAccountsBranchManagers() {
    const { showModal } = useGeneralContext();
    const { setActiveLink } = useOutletContext<SuperAdminAccountsOutletContextType>();

    const [branchManagers, setBranchManagers] = useState<BranchManagerStructure[] | null>(null);
    const [filteredBranchManagers, setFilteredBranchManagers] = useState<BranchManagerStructure[] | null>(null);

    const [branches, setBranches] = useState<BranchStructure | null>(null);

    const {Search} = Input;



    /**
     * Onmount
     */
    useEffect(() => {
        setActiveLink("Branch Managers");
        const getAll = async() => {
            const [branchManagersData, branchesData] = await Promise.all([
                fetchAllBranchManagers(),
                fetchAllBranches()
            ]);
            setBranchManagers(branchManagersData);
            setFilteredBranchManagers(branchManagersData);
            setBranches(branchesData);
        }

        getAll();
    }, []);



    /**
     * Setup Columns
     */
    const tableCols: TableColumnsType<BranchManagerStructure> = [
        {
            title: "Id",
            dataIndex: "id"
        },
        {
            title: "Name (FN MI. LN)",
            render: (_, row) => `${row.fname} ${row.mname ? row.mname[0] + "." : ""} ${row.lname}`
        },
        {
            title: "Branch",
            render: (_, row) => row.branch ? `${row.branch.name} (${row.branch.address})` : "N/A"
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
        showModal("SuperAdminAddBranchManagerModal", {
            setBranchManagers,
            setFilteredBranchManagers,
            branches
        });
    }



    /**
     * Render
     */
    return (
        <>
            {!branchManagers || !filteredBranchManagers || !branches
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
                            Add Super Admin
                        </Button>
                    </div>

                    <Table
                    dataSource={filteredBranchManagers.map((item, index) => ({...item, key: index}))}
                    columns={tableCols}
                    bordered/>
                </>
            )}
        </>
    )
}
