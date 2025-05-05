import { Outlet } from "react-router-dom";
import { useSuperAdminContext } from "../../../contexts/SuperAdminContext";
import { useEffect } from "react";

export default function SuperAdminBranchesDefault() {
    const { setActiveSideNavLink } = useSuperAdminContext();



    /**
     * Onmount
     */
    useEffect(() => {
        setActiveSideNavLink("Branches");
    }, []);



    /**
     * Render
     */
    return(
        <div className="content1 compressed">
            <Outlet/>
        </div>
    )
}