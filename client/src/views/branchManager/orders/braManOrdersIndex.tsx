import { useEffect } from "react";
import { useBranchManagerContext } from "../../../contexts/BranchManagerContext"
import { Button, Input, Table } from "antd";
import { useNavigate } from "react-router-dom";

export default function BranchManagerOrdersIndex() {
    const { setActiveSideNavLink } = useBranchManagerContext();

    const {Search} = Input;
    const navigate = useNavigate();




    /**
     * Oumount
     */
    useEffect(() => {
        setActiveSideNavLink("Orders");
    });



    /**
     * Handlers
     */
    const handleSearch = (val: string) => {
        console.log(val);
    }



    /**
     * Render
     */
    return (
        <div className="content1 compressed">
            <h3 className="fw-bold mar-bottom-1">Orders</h3>

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
                onClick={() => navigate("/KCBranchManager/AddOrder")}>
                    Add Orders
                </Button>
            </div>

            <Table
            columns={[]}
            dataSource={[]}
            bordered/>
        </div>
    )
}
