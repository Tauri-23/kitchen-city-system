import { Button } from "antd";
import { useEffect, useState } from "react";
import { useSuperAdminContext } from "../../../contexts/SuperAdminContext";

type supAdMarketListActivePageTypes = "Bakeshop" | "Raw Mat"

export default function SuperAdminMarketListsDefault() {
    const { setActiveSideNavLink } = useSuperAdminContext();

    const [supAdMarketListActivePage, setSupAdMarketListActivePage] = useState<supAdMarketListActivePageTypes>("Bakeshop");



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

            <div className="d-flex align-items-center gap3">
                <Button>Bakeshop</Button>
                <Button>Raw mat</Button>
            </div>
        </div>
    )
}