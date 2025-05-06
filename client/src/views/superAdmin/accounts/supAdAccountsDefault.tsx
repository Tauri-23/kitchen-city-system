import { Outlet, useNavigate } from "react-router-dom";
import { useSuperAdminContext } from "../../../contexts/SuperAdminContext";
import { useEffect, useState } from "react";
import { Button } from "antd";

export type SuperAdminAccountsOutletContextType = {
    setActiveLink: (value: "Super Admins" | "Branch Admins" | "Branch Managers" | "Area Managers" | "Commissary Workers") => void
}

export default function SuperAdminAccountsDefault() {
    const { setActiveSideNavLink } = useSuperAdminContext();
    const accountTypes = [
        {
            title: "Super Admins",
            to: "/KCSuperAdmin/Accounts/"
        }, 
        {
            title: "Branch Admins",
            to: "/KCSuperAdmin/Accounts/BranchAdmins"
        }, 
        {
            title: "Branch Managers",
            to: "/KCSuperAdmin/Accounts/BranchManagers"
        }, 
        {
            title: "Area Managers",
            to: "/KCSuperAdmin/Accounts/AreaManagers"
        }, 
        {
            title: "Commissary Workers",
            to: "/KCSuperAdmin/Accounts/CommissaryWorkers"
        }
    ];
    const navigate = useNavigate();
    const [activeLink, setActiveLink] = useState<"Super Admins" | "Branch Admins" | "Branch Managers" | "Area Managers" | "Commissary Workers">("Super Admins")



    /**
     * Onmount
     */
    useEffect(() => {
        setActiveSideNavLink("Accounts");
    }, []);



    /**
     * Render
     */
    return (
        <div className="content1 compressed">
            <h3 className="fw-bold mar-bottom-1">Accounts</h3>

            <div className="d-flex align-items-center gap3 mar-bottom-1">
                {accountTypes.map((type, index) => (
                    <Button
                    className="text-decoration-none"
                    key={index}
                    // size="large"
                    type="primary"
                    onClick={() => navigate(type.to)}
                    ghost={type.title !== activeLink}>
                        {type.title}
                    </Button>
                ))}
            </div>

            <Outlet context={{
                setActiveLink
            }}/>
        </div>
    )
}
