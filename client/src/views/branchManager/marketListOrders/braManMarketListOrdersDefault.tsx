import { useEffect, useState } from "react";
import { useBranchManagerContext } from "../../../contexts/BranchManagerContext";
import { Outlet, useNavigate } from "react-router-dom";
import { Button } from "antd";

export type mlOrdersActivePageTypes = "Bakeshop" | "Rawmat"

export default function BranchManagerMarketListOrdersDefault() {
    const { setActiveSideNavLink } = useBranchManagerContext();

    const navigate = useNavigate();

    const [mlOrdersActivePage, setMlOrdersActivePage] = useState<mlOrdersActivePageTypes>("Bakeshop");



    /**
     * Onmount
     */
    useEffect(() => {
        setActiveSideNavLink("Market Lists Orders");
    }, []);



    /**
     * Render
     */
    return(
        <div className="content1 compressed">
            <h3 className="mar-bottom-1 fw-bold">Market Lists Orders</h3>

            <div className="d-flex mar-bottom-1 gap3">
                <Button
                variant={mlOrdersActivePage === "Bakeshop" ? "solid" : "outlined"}
                color="primary"
                onClick={() => navigate("")}
                >
                    Bakeshop
                </Button>
                <Button
                variant={mlOrdersActivePage === "Rawmat" ? "solid" : "outlined"}
                color="primary"
                onClick={() => navigate("Rawmat")}
                >
                    Raw Materials
                </Button>
            </div>

            <Outlet context={{
                setMlOrdersActivePage
            }}/>
        </div>
    );
}