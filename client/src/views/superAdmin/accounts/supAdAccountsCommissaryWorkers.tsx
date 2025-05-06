import { useOutletContext } from "react-router-dom";
import { SuperAdminAccountsOutletContextType } from "./supAdAccountsDefault";
import { useEffect } from "react";

export default function SuperAdminAccountsCommissaryWorkers() {
    const { setActiveLink } = useOutletContext<SuperAdminAccountsOutletContextType>();



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
