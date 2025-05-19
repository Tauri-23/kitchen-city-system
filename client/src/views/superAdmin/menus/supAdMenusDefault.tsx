import { useEffect, useState } from "react";
import { useSuperAdminContext } from "../../../contexts/SuperAdminContext";
import { Outlet, useNavigate } from "react-router-dom";
import { Button } from "antd";

export type SuperAdminMenuActivePageTypes = "Menu" | "Dishes" | "Categories & Sub-Categories" | "Menu Tags" | "Menu Settings";

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
            <div className="d-flex align-items-center gap3 mar-bottom-1">
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
                variant={supAdMenuActivePage === "Categories & Sub-Categories" ? "solid" : "outlined"}
                onClick={() => navigate("MenuCategoriesAndSubCategories")}>
                    Categories & Sub-Categories
                </Button>
                
                <Button
                color="primary"
                variant={supAdMenuActivePage === "Menu Tags" ? "solid" : "outlined"}
                onClick={() => navigate("MenuTags")}>
                    Menu Tags
                </Button>

                <Button
                color="primary"
                variant={supAdMenuActivePage === "Menu Settings" ? "solid" : "outlined"}
                onClick={() => navigate("MenuSettings")}>
                    Menu Form Settings
                </Button>
            </div>
            <Outlet
            context={{
                setSupAdMenuActivePage
            }}/>
        </div>
    )
}