import { useEffect, useState } from "react";
import { useSuperAdminContext } from "../../../contexts/SuperAdminContext";
import { Button, DatePicker, Select, Spin } from "antd";
import { BranchStructure } from "../../../types/branchStructure";
import { fetchAllBranches } from "../../../services/branchServices";
import SuperAdminDashboardAllContent from "./_components/supAdDashAllContent";

export default function SuperAdminDashboard() {
    const { setActiveSideNavLink } = useSuperAdminContext();

    const [branches, setBranches] = useState<BranchStructure[] | null>(null);

    const [selectedBranch, setSelectedBranch] = useState<BranchStructure | null>(null);

    const {RangePicker} = DatePicker;



    /**
     * Onmount
     */
    useEffect(() => {
        setActiveSideNavLink("Dashboard");
        const getAll = async() => {
            const [branchesData] = await Promise.all([
                fetchAllBranches()
            ]);

            setBranches(branchesData);
        }

        getAll();
    }, []);



    /**
     * Render
     */
    return(
        <div className="content1 compressed">
            {!branches
            ? (
                <Spin size="large"/>
            )
            : (
                <>
                    <h3 className="fw-bold mar-bottom-1">Dashboard</h3>

                    {/* Filters */}
                    <div className="d-flex align-items-center justify-content-between mar-bottom-1">
                        <div className="d-flex align-items-center gap3">
                            <RangePicker
                            size="large"/>
                            
                            <Select
                            size="large"
                            style={{width: 250}}
                            value={selectedBranch?.id || ""}
                            onChange={(val) => {
                                const branch = branches?.find(branch => branch.id === val) || null;;
                                setSelectedBranch(branch)
                            }}
                            options={[
                                {label: "All", value: ""},
                                ...branches?.map(branch => ({label: `${branch.name} (${branch.address})`, value: branch.id}))
                            ]}/>
                        </div>
                        
                        <Button
                        size="large"
                        type="primary">
                            Download Report
                        </Button>
                    </div>
                    
                    {!selectedBranch && (
                        <SuperAdminDashboardAllContent branches={branches}/>
                    )}
                </>
            )}
        </div>
    )
}