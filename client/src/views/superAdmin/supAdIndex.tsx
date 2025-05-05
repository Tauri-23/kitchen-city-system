import { useEffect } from "react";
import { useSuperAdminContext } from "../../contexts/SuperAdminContext";

export default function SuperAdminIndex() {
    const { setActiveSideNavLink } = useSuperAdminContext();



    /**
     * Onmount
     */
    useEffect(() => {
        setActiveSideNavLink("Dashboard");
    }, []);



    /**
     * Render
     */
    return(
        <div className="content1 compressed">
            <h3 className="fw-bold">Dashboard</h3>
        </div>
    )
}