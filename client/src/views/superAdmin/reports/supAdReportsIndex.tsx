import { useEffect } from "react";
import { useSuperAdminContext } from "../../../contexts/SuperAdminContext";

export default function SuperAdminReportIndex() {
    const { setActiveSideNavLink } = useSuperAdminContext();



    /**
     * Onmount
     */
    useEffect(() => {
        setActiveSideNavLink("Reports");
    }, []); 



    /**
     * Render
     */
    return(
        <div className="content1 compressed">
            <h3 className="fw-bold mar-bottom-1">Reports</h3>
        </div>
    );
}