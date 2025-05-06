import { useSuperAdminContext } from "../../../contexts/SuperAdminContext";
import { useEffect, useState } from "react";
import { BranchStructure } from "../../../types/branchStructure";
import { fetchAllBranches } from "../../../services/branchServices";
import { Button, Input, Spin, Table, TableColumnsType } from "antd";
import { useGeneralContext } from "../../../contexts/GeneralContext";
import { fetchAllAreaManagers } from "../../../services/areaManagerServices";
import { AreaManagerStructure } from "../../../types/areaManagerSturcture";

export default function SuperAdminBranchesIndex() {
    const { setActiveSideNavLink } = useSuperAdminContext();
    const { showModal } = useGeneralContext();

    const [branches, setBranches] = useState<BranchStructure[] | null>(null);
    const [filteredBranches, setFilteredBranches] = useState<BranchStructure[] | null>(null);

    const [areaManagers, setAreaManagers] = useState<AreaManagerStructure[] | null>(null);

    const {Search} = Input;



    /**
     * Onmount
     */
    useEffect(() => {
        setActiveSideNavLink("Branches");

        const getAll = async() => {
            const [branchesData, areaManagersData] = await Promise.all([
                fetchAllBranches(),
                fetchAllAreaManagers()
            ]);
            setBranches(branchesData);
            setFilteredBranches(branchesData);
            setAreaManagers(areaManagersData);
        }
        
        getAll();
    }, []);



    /**
     * Setup Columns
     */
    const brancheCols: TableColumnsType<BranchStructure> = [
        {
            title: "Branch Id",
            dataIndex: "id"
        },
        {
            title: "Branch Code",
            dataIndex: "branch_code"
        },
        {
            title: "Branch Name",
            dataIndex: "name"
        },
        {
            title: "Branch Address",
            dataIndex: "address"
        },
        {
            title: "Area Manager",
            render: (_, row) => row.area_manager 
            ? `${row.area_manager.fname} ${row.area_manager.lname}`
            : "N/A"
        },
        {
            title: "Status",
            dataIndex: "status"
        }
    ]



    /**
     * Handlers
     */
    const handleSearch = (val: string) => {
        console.log(val);
    }

    const handleAddBranch = () => {
        showModal("SuperAdminAddBranchModal", {
            setBranches,
            setFilteredBranches,
            areaManagers
        });
    }



    /**
     * Render
     */
    return(
        <div className="content1 compressed">
            <h3 className="fw-bold mar-bottom-1">Branches</h3>

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
                onClick={handleAddBranch}
                disabled={!areaManagers}
                >
                    Add Branch
                </Button>
            </div>

            {!branches || !filteredBranches || !areaManagers
            ? (
                <Spin size="large"/>
            )
            : (
                <Table
                columns={brancheCols}
                dataSource={filteredBranches.map((item, index) => ({...item, key: index}))}
                bordered
                />
            )}
        </div>
    )
}