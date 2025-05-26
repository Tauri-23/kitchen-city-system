import { useEffect } from "react";
import { useSuperAdminContext } from "../../../contexts/SuperAdminContext";
import { Collapse, CollapseProps } from "antd";
import SuperAdminSettingsMenuSettings from "./menuSettings/supAdSettingsMenuSettings";
import SuperAdminSettingsMenuFormBuilder from "./menuFormBuilder/supAdSettingsMenuFormBuilder";
import SuperAdminSettingsBranches from "./branches/supAdSettingsBranches";
import SuperAdminSettingsAccounts from "./accounts/supAdSettingsAccounts";
import SuperAdminSettingsWeekManagement from "./weekManagement/supAdSettingsWeekManagement";

export default function SuperAdminSettingsDefault() {
    const { setActiveSideNavLink } = useSuperAdminContext();



    /**
     * Onmount
     */
    useEffect(() => {
        setActiveSideNavLink("Settings");
    }, []);



    /**
     * Setup collapse items
     */
    const collapseItems: CollapseProps["items"] = [
        {
            key: 1,
            label: "Menu Settings",
            children: <SuperAdminSettingsMenuSettings/>
        },
        {
            key: 2,
            label: "Menu Form Builder",
            children: <SuperAdminSettingsMenuFormBuilder/>
        },
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
    ]


    
    /**
     * Render
     */
    return (
        <div className="content1 compressed">
            <h3 className="fw-bold mar-bottom-1">Settings</h3>

            <Collapse items={collapseItems}/>
        </div>
    );
}