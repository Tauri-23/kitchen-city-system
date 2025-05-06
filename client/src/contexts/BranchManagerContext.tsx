import { createContext, ReactNode, useContext, useState } from "react";

type activeSideNavLinkTypes = "Dashboard" | "Orders" | "Branch";

interface BranchManagerContextType {
    activeSideNavLink: activeSideNavLinkTypes,
    setActiveSideNavLink: (value: activeSideNavLinkTypes) => void;
}

const BranchManagerContext = createContext<BranchManagerContextType | undefined>(undefined);


export const BranchManagerProvider = ({children}: {children: ReactNode}) => {
    const [activeSideNavLink, setActiveSideNavLink] = useState<activeSideNavLinkTypes>("Dashboard");




    /**
     * Render
     */
    return(
        <BranchManagerContext.Provider
        value={{
            activeSideNavLink, 
            setActiveSideNavLink
        }}>
            {children}
        </BranchManagerContext.Provider>
    )
}


export const useBranchManagerContext = () => {
    const context = useContext(BranchManagerContext);

    if(!context) {
        throw new Error("useBranchManagerContext must be used within a BranchManagerProvider");
    }

    return context;
}