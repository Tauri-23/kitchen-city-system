import { useEffect } from "react";
import { activeLinkTypes } from "../supAdSettingsAccounts";

interface SuperAdminSettingsAccountsCommissaryWorkersTypes {
    setActiveLink: (value: activeLinkTypes) => void;
}

const SuperAdminSettingsAccountsCommissaryWorkers: React.FC<SuperAdminSettingsAccountsCommissaryWorkersTypes> = ({setActiveLink}) => {
    /**
     * Onmount
     */
    useEffect(() => {
        setActiveLink("Commissary Workers");
    }, []);



    /**
     * Render
     */
    return (
        <>
            
        </>
    )
}

export default SuperAdminSettingsAccountsCommissaryWorkers;
