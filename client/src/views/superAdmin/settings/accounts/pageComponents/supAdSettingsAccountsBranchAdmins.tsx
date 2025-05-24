import { activeLinkTypes } from "../supAdSettingsAccounts";
import { useEffect } from "react";

interface SuperAdminSettingsAccountsBranchAdmins {
    setActiveLink: (value: activeLinkTypes) => void;
}

const SuperAdminSettingsAccountsBranchAdmins: React.FC<SuperAdminSettingsAccountsBranchAdmins> = ({setActiveLink}) => {
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

export default SuperAdminSettingsAccountsBranchAdmins;