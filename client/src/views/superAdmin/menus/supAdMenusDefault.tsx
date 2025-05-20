import { useEffect, useState } from "react";
import { useSuperAdminContext } from "../../../contexts/SuperAdminContext";
import { Outlet, useNavigate } from "react-router-dom";
import { Button } from "antd";

export type SuperAdminMenuActivePageTypes = "Menu" | "Dishes" | "Categories, Sub-Categories And Classes" | "Menu Tags" | "Menu Form Builder";

export default function SuperAdminMenusDefault() {
    const { setActiveSideNavLink } = useSuperAdminContext();
    const [supAdMenuActivePage, setSupAdMenuActivePage] = useState<SuperAdminMenuActivePageTypes>("Menu");

    const navigate = useNavigate();



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
            <div className="d-flex flex-wrap align-items-center gap3 mar-bottom-1">
                <Button
                color="primary"
                variant={supAdMenuActivePage === "Menu" ? "solid" : "outlined"}
                onClick={() => navigate("")}>
                    Menus
                </Button>

                <Button
                color="primary"
                variant={supAdMenuActivePage === "Dishes" ? "solid" : "outlined"}
                onClick={() => navigate("MenuDishes")}>
                    Dishes
                </Button>

                <Button
                color="primary"
                variant={supAdMenuActivePage === "Categories, Sub-Categories And Classes" ? "solid" : "outlined"}
                onClick={() => navigate("MenuCategoriesSubAndClasses")}>
                    Categories, Sub-Categories & Classes
                </Button>
                
                <Button
                color="primary"
                variant={supAdMenuActivePage === "Menu Tags" ? "solid" : "outlined"}
                onClick={() => navigate("MenuTags")}>
                    Menu Tags
                </Button>

                <Button
                color="primary"
                variant={supAdMenuActivePage === "Menu Form Builder" ? "solid" : "outlined"}
                onClick={() => navigate("MenuFormBuilder")}>
                    Menu Form Builder
                </Button>
            </div>
            <Outlet
            context={{
                setSupAdMenuActivePage
            }}/>
        </div>
    )
}