import { useEffect, useState } from "react";
import { useBranchManagerContext } from "../../../contexts/BranchManagerContext";
import { Outlet } from "react-router-dom";
import { Button } from "antd";

export type mlOrdersActivePageTypes = "Bakeshop" | "Rawmat"

export default function BranchManagerMarketListOrdersDefault() {
    const { setActiveSideNavLink } = useBranchManagerContext();

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
                >
                    Bakeshop
                </Button>
                <Button
                variant={mlOrdersActivePage === "Rawmat" ? "solid" : "outlined"}
                color="primary"
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