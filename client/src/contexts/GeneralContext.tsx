import { useEffect, useState, createContext, useContext, ReactNode } from "react";

interface GeneralContextType {
    screenWidth?: number;
    screenHeight?: number;
}

const GeneralContext = createContext<GeneralContextType | undefined>(undefined);


export const GeneralProvider = ({ children }: { children: ReactNode }) => {
    const [screenWidth, setScreenWidth] = useState<number | undefined>(window.innerWidth || 0);
    const [screenHeight, setScreenHeight] = useState<number | undefined>(window.innerHeight || 0);


    
    /**
     * Onmount
     */
    useEffect(() => {
        const handleResize = () => {
            setScreenWidth(window.innerWidth);
            setScreenHeight(window.innerHeight);
        }

        window.addEventListener("resize", handleResize);

        // Cleanup on unmount
        return () => {
            window.removeEventListener("resize", handleResize);
        }
    }, []);



    /**
     * Render
     */
    return (
        <GeneralContext.Provider 
        value={{
            screenWidth,
            screenHeight
        }}>
            {children}
        </GeneralContext.Provider>
    )
}


export const useGeneralContext = () => {
    const context = useContext(GeneralContext);
    if(!context) {
        throw new Error("useGeneralContext must be used within a GeneralProvider");
    }

    return context;
};