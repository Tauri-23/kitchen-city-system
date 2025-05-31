import { useEffect, useState } from "react";
import { useSuperAdminContext } from "../../../contexts/SuperAdminContext";
import { Button, Collapse, CollapseProps } from "antd";
import SuperAdminSettingsBranches from "./branches/supAdSettingsBranches";
import SuperAdminSettingsAccounts from "./accounts/supAdSettingsAccounts";
import SuperAdminSettingsMenuSettings from "./foodMenu/menuSettings/supAdSettingsMenuSettings";
import SuperAdminSettingsWeekManagement from "./foodMenu/weekManagement/supAdSettingsWeekManagement";
import SuperAdminSettingsBakeshopSettings from "./bakeshop/bakeshopSettings/supAdSettingsBakeshopSettings";

type selectedSettingsTypes = "Food Menu" | "Bakeshop" | "Raw mat";

export default function SuperAdminSettingsDefault() {
    const { setActiveSideNavLink } = useSuperAdminContext();

    const [selectedSettings, setSelectedSettings] = useState<selectedSettingsTypes>("Food Menu");



    /**
     * Onmount
     */
    useEffect(() => {
        setActiveSideNavLink("Settings");
    }, []);



    /**
     * Setup collapse items
     */
    const collapseItemsFoodMenu: CollapseProps["items"] = [
        {
            key: 1,
            label: "Menu Settings",
            children: <SuperAdminSettingsMenuSettings/>
        },
        // {
        //     key: 2,
        //     label: "Menu Form Builder",
        //     children: <SuperAdminSettingsMenuFormBuilder/>
        // },
        {
            key: 3,
            label: "Accounts",
            children: <SuperAdminSettingsAccounts/>
        },
        {
            key: 4,
            label: "Branches",
            children: <SuperAdminSettingsBranches/>
        },
        {
            key: 5,
            label: "Week Settings",
            children: <SuperAdminSettingsWeekManagement/>
        },
    ];

    const collapseItemsBakeshop: CollapseProps["items"] = [
        {
            key: 1,
            label: "Bakeshop Settings",
            children: <SuperAdminSettingsBakeshopSettings/>
        }
    ];

    const collapseItemsRawmat: CollapseProps["items"] = [
        {
            key: 1,
            label: "Raw mat Settings",
        }
    ];



    /**
     * Functions
     */
    const renderCollapseItems = () => {
        switch(selectedSettings) {
            case "Food Menu":
                return collapseItemsFoodMenu;
            case "Bakeshop":
                return collapseItemsBakeshop;
            case "Raw mat":
                return collapseItemsRawmat;
            default:
                return [];
        }
    }


    
    /**
     * Render
     */
    return (
        <div className="content1 compressed">
            <h3 className="fw-bold mar-bottom-1">Settings</h3>

            <div className="d-flex gap3 mar-bottom-1">
                <Button
                variant={selectedSettings === "Food Menu" ? "solid" : "outlined"}
                color="primary"
                onClick={() => setSelectedSettings("Food Menu")}
                >
                    Food Menu
                </Button>

                <Button
                variant={selectedSettings === "Bakeshop" ? "solid" : "outlined"}
                color="primary"
                onClick={() => setSelectedSettings("Bakeshop")}
                >
                    Bakeshop
                </Button>

                <Button
                variant={selectedSettings === "Raw mat" ? "solid" : "outlined"}
                color="primary"
                onClick={() => setSelectedSettings("Raw mat")}
                >
                    Raw mat
                </Button>
            </div>

            <Collapse items={renderCollapseItems()}/>
        </div>
    );
}