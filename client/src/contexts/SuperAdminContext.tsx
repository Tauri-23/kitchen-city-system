import { createContext, ReactNode, useContext, useState } from "react";

type activeSideNavLinkTypes = "Dashboard" | "Menus" | "Dishes" | "Reports" | "Settings";

interface SuperAdminContextType {
    activeSideNavLink: activeSideNavLinkTypes,
    setActiveSideNavLink: (value: activeSideNavLinkTypes) => void;
}

const SuperAdminContext = createContext<SuperAdminContextType | undefined>(undefined);


export const SuperAdminProvider = ({children}: {children: ReactNode}) => {
    const [activeSideNavLink, setActiveSideNavLink] = useState<activeSideNavLinkTypes>("Dashboard");




    /**
     * Render
     */
    return(
        <SuperAdminContext.Provider
        value={{
            activeSideNavLink, 
            setActiveSideNavLink
        }}>
            {children}
        </SuperAdminContext.Provider>
    )
}


export const useSuperAdminContext = () => {
    const context = useContext(SuperAdminContext);

    if(!context) {
        throw new Error("useSuperAdminContext must be used within a SuperAdminProvider");
    }

    return context;
}