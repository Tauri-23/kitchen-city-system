import { Button } from "antd";
import { useEffect, useState } from "react";
import { useSuperAdminContext } from "../../../contexts/SuperAdminContext";
import { Outlet, useNavigate } from "react-router-dom";

export type SupAdMarketListActivePageTypes = "Bakeshop" | "Raw Mat";

export default function SuperAdminMarketListsDefault() {
    const { setActiveSideNavLink } = useSuperAdminContext();

    const navigate = useNavigate();

    const [supAdMarketListActivePage, setSupAdMarketListActivePage] = useState<SupAdMarketListActivePageTypes>("Bakeshop");



    /**
     * Onmount
     */
    useEffect(() => {
        setActiveSideNavLink("Market Lists");
    })



    /**
     * Render
     */
    return(
        <div className="content1 compressed">
            <h3 className="mar-bottom-1 fw-bold">Market Lists</h3>

            <div className="d-flex align-items-center gap3 mar-bottom-1">
                <Button
                variant={supAdMarketListActivePage === "Bakeshop" ? "solid" : "outlined"}
                color="primary"
                onClick={() => navigate("")}
                >
                    Bakeshop
                </Button>

                <Button
                variant={supAdMarketListActivePage === "Raw Mat" ? "solid" : "outlined"}
                color="primary"
                onClick={() => navigate("RawMat")}
                >
                    Raw mat
                </Button>
            </div>

            <Outlet context={{
                setSupAdMarketListActivePage
            }}/>
        </div>
    )
}