import { Button } from "antd";
import { useState } from "react";
import SuperAdminSettingsAccountsSuperAdmins from "./pageComponents/supAdSettingsAccountsSuperAdmins";
import SuperAdminSettingsAccountsBranchManagers from "./pageComponents/supAdSettingsAccountsBranchManagers";
import SuperAdminSettingsAccountsAreaManagers from "./pageComponents/supAdSettingsAccountsAreaManagers";
import SuperAdminSettingsAccountsCommissaryWorkers from "./pageComponents/supAdSettingsAccountsCommissaryWorkers";

export type activeLinkTypes = "Super Admins" | "Branch Admins" | "Branch Managers" | "Area Managers" | "Commissary Workers";

export default function SuperAdminSettingsAccounts() {
    const accountTypes = [
        {
            title: "Super Admins",
        }, 
        {
            title: "Branch Admins",
        }, 
        {
            title: "Branch Managers",
        }, 
        {
            title: "Area Managers",
        }, 
        {
            title: "Commissary Workers",
        }
    ];
    const [activeLink, setActiveLink] = useState<activeLinkTypes>("Super Admins");



    /**
     * Render Functions
     */
    const renderContent = () => {
        switch(activeLink) {
            case "Super Admins":
                return <SuperAdminSettingsAccountsSuperAdmins setActiveLink={setActiveLink}/>
            case "Branch Managers":
                return <SuperAdminSettingsAccountsBranchManagers setActiveLink={setActiveLink}/>
            case "Area Managers":
                return <SuperAdminSettingsAccountsAreaManagers setActiveLink={setActiveLink}/>
            case "Commissary Workers":
                return <SuperAdminSettingsAccountsCommissaryWorkers setActiveLink={setActiveLink}/>
            case "Branch Admins":
                return <SuperAdminSettingsAccountsBranchManagers setActiveLink={setActiveLink}/>
            default: 
                return null
        }
    }



    /**
     * Render
     */
    return(
        <>
            <div className="d-flex align-items-center gap3 mar-bottom-1">
                {accountTypes.map((type, index) => (
                    <Button
                    className="text-decoration-none"
                    key={index}
                    type="primary"
                    onClick={() => setActiveLink(type.title as activeLinkTypes)}
                    ghost={type.title !== activeLink}>
                        {type.title}
                    </Button>
                ))}
            </div>

            {renderContent()}
        </>
    );
}