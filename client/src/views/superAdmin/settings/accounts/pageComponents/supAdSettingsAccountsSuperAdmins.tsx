import { useEffect, useState } from "react";
import { Button, Input, Spin, Table, TableColumnsType } from "antd";
import { SuperAdminStructure } from "../../../../../types/superAdminSturcture";
import { fetchAllSuperAdminsWhereNotId } from "../../../../../services/superAdminServices";
import { useLoggedUserContext } from "../../../../../contexts/LoggedUserContext";
import { useGeneralContext } from "../../../../../contexts/GeneralContext";
import { activeLinkTypes } from "../supAdSettingsAccounts";

interface SuperAdminSettingsAccountsSuperAdminsTypes {
    setActiveLink: (value: activeLinkTypes) => void;
}

const SuperAdminSettingsAccountsSuperAdmins: React.FC<SuperAdminSettingsAccountsSuperAdminsTypes> = ({setActiveLink}) => {
    const { user } = useLoggedUserContext();
    const { showModal } = useGeneralContext();

    const [superAdmins, setSuperAdmins] = useState<SuperAdminStructure[] | null>(null);

    const {Search} = Input;



    /**
     * Onmount
     */
    useEffect(() => {
        setActiveLink("Super Admins");

        if(user) {
            const getAll = async() => {
                const data = await fetchAllSuperAdminsWhereNotId(String(user.id));
                setSuperAdmins(data);
            }

            getAll();
        }
    }, [user]);



    /**
     * Setup Columns
     */
    const tableCols: TableColumnsType<SuperAdminStructure> = [
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
        showModal("SupAdAddSuperAdminModal", {
            setSuperAdmins
        });
    }



    /**
     * Render
     */
    return (
        <>
            {!superAdmins
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
                    size="small"
                    dataSource={superAdmins.map((item, index) => ({...item, key: index}))}
                    columns={tableCols}
                    bordered/>
                </>
            )}
        </>
    )
}

export default SuperAdminSettingsAccountsSuperAdmins;