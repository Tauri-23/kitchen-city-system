import { useEffect } from "react";
import { useSuperAdminContext } from "../../../contexts/SuperAdminContext";
import { Outlet } from "react-router-dom";

export default function SuperAdminMenusDefault() {
    const { setActiveSideNavLink } = useSuperAdminContext();



    /**
     * Onmount
     */
    useEffect(() => {
        setActiveSideNavLink("Menus");
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