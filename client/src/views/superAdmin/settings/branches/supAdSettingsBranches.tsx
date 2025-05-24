import { useEffect, useState } from "react";
import { isEmptyOrSpaces, notify } from "../../../../assets/lib/utils";
import { useGeneralContext } from "../../../../contexts/GeneralContext";
import { BranchStructure } from "../../../../types/branchStructure";
import { AreaManagerStructure } from "../../../../types/areaManagerSturcture";
import { Button, Input, Select, Spin, Table, TableColumnsType } from "antd";
import { fetchAllBranches } from "../../../../services/branchServices";
import { fetchAllAreaManagers } from "../../../../services/areaManagerServices";
import { LuSquareCheckBig, LuSquarePen } from "react-icons/lu";
import { GiCancel } from "react-icons/gi";
import axiosClient from "../../../../axios-client";

export default function SuperAdminSettingsBranches() {
    const { showModal } = useGeneralContext();

    const [branches, setBranches] = useState<BranchStructure[] | null>(null);
    const [filteredBranches, setFilteredBranches] = useState<BranchStructure[] | null>(null);

    const [areaManagers, setAreaManagers] = useState<AreaManagerStructure[] | null>(null);

    const {Search} = Input;

    const sizes = ["XL", "Large", "Medium", "Medium Frying", "Small", "Small Frying"];
    const branchStatuses = ["Active", "Suspended", "Discontinued"];

    const [selectedBranch, setSelectedBranch] = useState<BranchStructure | null>(null);

    const [isEditBranch, setIsEditBranch] = useState<boolean>(false);

    const [editBranchIn, setEditBranchIn] = useState({
        id: "",
        name: "",
        address: "",
        size: "",
        areaManager: "",
        status: "",
    })

    const isSaveEditBranchBtnDisabled = editBranchIn.id === "" || isEmptyOrSpaces(editBranchIn.name) || 
    isEmptyOrSpaces(editBranchIn.address) || editBranchIn.size === "" || 
    editBranchIn.areaManager === "" || editBranchIn.status === "";



    /**
     * Onmount
     */
    useEffect(() => {
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
            render: (_, row) => {
                return (isEditBranch && selectedBranch?.id === row.id) 
                ? (
                    <Input
                    size="small"
                    className="w-100"
                    value={editBranchIn.name}
                    onChange={(e) => setEditBranchIn(prev => ({...prev, name: e.target.value}))}
                    />
                )
                : row.name
            }
        },
        {
            title: "Branch Address",
            render: (_, row) => {
                return (isEditBranch && selectedBranch?.id === row.id) 
                ? (
                    <Input
                    size="small"
                    className="w-100"
                    value={editBranchIn.address}
                    onChange={(e) => setEditBranchIn(prev => ({...prev, address: e.target.value}))}
                    />
                )
                : row.address
            }
        },
        {
            title: "Area Manager",
            render: (_, row) => {
                return (isEditBranch && selectedBranch?.id === row.id) 
                ? (
                    <Select
                    size="small"
                    className="w-100"
                    value={editBranchIn.areaManager}
                    options={areaManagers?.map(areaMngr => ({label: `${areaMngr.fname} ${areaMngr.mname} ${areaMngr.lname}`, value: areaMngr.id}))}
                    onChange={(val) => setEditBranchIn(prev => ({...prev, areaManager: val}))}
                    />
                )
                : (
                    row.area_manager 
                    ? `${row.area_manager.fname} ${row.area_manager.lname}`
                    : "N/A"
                )
            }
        },
        {
            title: "Branch Size",
            render: (_, row) => {
                return (isEditBranch && selectedBranch?.id === row.id) 
                ? (
                    <Select
                    size="small"
                    className="w-100"
                    value={editBranchIn.size}
                    options={sizes.map(size => ({label: size, value: size}))}
                    onChange={(val) => setEditBranchIn(prev => ({...prev, size: val}))}
                    />
                )
                : row.size
            }
        },
        {
            title: "Status",
            render: (_, row) => {
                return (isEditBranch && selectedBranch?.id === row.id) 
                ? (
                    <Select
                    size="small"
                    className="w-100"
                    value={editBranchIn.status}
                    options={branchStatuses.map(status => ({label: status, value: status}))}
                    onChange={(val) => setEditBranchIn(prev => ({...prev, status: val}))}
                    />
                )
                : row.status
            }
        },
        {
            title: "Actions",
            render: (row) => {
                return(
                    <>
                        {(isEditBranch && selectedBranch?.id === row.id)
                        ? (
                            <>
                                <Button
                                size="small"
                                color="green"
                                variant="solid"
                                className="mar-end-3"
                                icon={<LuSquareCheckBig/>}
                                onClick={handleSaveEdit}
                                disabled={isSaveEditBranchBtnDisabled}/>

                                <Button
                                size="small"
                                icon={<GiCancel/>}
                                onClick={() => {
                                    setSelectedBranch(null);
                                    setIsEditBranch(false);
                                    setEditBranchIn({
                                        id: "",
                                        name: "",
                                        address: "",
                                        size: "",
                                        areaManager: "",
                                        status: "",
                                    })
                                }}/>
                            </>
                        )
                        : (
                            <Button
                            size="small"
                            icon={<LuSquarePen/>}
                            color="blue"
                            variant="solid"
                            className="mar-end-3"
                            onClick={() => {
                                setSelectedBranch(row);
                                setIsEditBranch(true);
                                setEditBranchIn({
                                    id: row.id,
                                    name: row.name,
                                    address: row.address,
                                    size: row.size,
                                    areaManager: row.area_manager_id,
                                    status: row.status,
                                })
                            }}/>
                        )}
                    </>
                )
            }
        }
    ];



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

    const handleSaveEdit = () => {
        const formData = new FormData();
        formData.append("editBranchIn", JSON.stringify(editBranchIn));

        axiosClient.post("/update-branch", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);
            if(data.status === 200) {
                setSelectedBranch(null);
                setIsEditBranch(false);
                setEditBranchIn({
                    id: "",
                    name: "",
                    address: "",
                    size: "",
                    areaManager: "",
                    status: "",
                });
                setBranches(data.branches);
                setFilteredBranches(data.branches)
            }
        })
        .catch(error => {
            console.error(error);
            notify("error", "Server Error", "top-center", 3000);
        });
    }



    /**
     * Render
     */
    return(
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
                size="small"
                columns={brancheCols}
                dataSource={filteredBranches.map((item, index) => ({...item, key: index}))}
                bordered
                />
            )}
        </>
    );
}