import { useOutletContext } from "react-router-dom";
import { SuperAdminAccountsOutletContextType } from "./supAdAccountsDefault";
import { useEffect } from "react";

export default function SuperAdminAccountsBranchAdmins() {
    const { setActiveLink } = useOutletContext<SuperAdminAccountsOutletContextType>();



    /**
     * Onmount
     */
    useEffect(() => {
        setActiveLink("Branch Admins");
    }, []);



    /**
     * Render
     */
    return (
        <>
            
        </>
    )
}
