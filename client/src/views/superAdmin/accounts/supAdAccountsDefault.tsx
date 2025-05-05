import { Outlet } from "react-router-dom";
import { useSuperAdminContext } from "../../../contexts/SuperAdminContext";
import { useEffect, useState } from "react";
import { Button } from "antd";

export default function SuperAdminAccountsDefault() {
    const { setActiveSideNavLink } = useSuperAdminContext();
    const accountTypes = [
        {
            title: "Super Admins",
            to: ""
        }, 
        {
            title: "Branch Admins",
            to: "BranchAdmins"
        }, 
        {
            title: "Area Managers",
            to: "AreaManagers"
        }, 
        {
            title: "Commissary Workers",
            to: "CommissaryWorkers"
        }
    ];
    const [activeLink, setActiveLink] = useState<"Super Admins" | "Branch Admins" | "Area Managers" | "Commissary Workers">("Super Admins")



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
                    size="large"
                    type="primary"
                    href={type.to}
                    ghost={type.title !== activeLink}>
                        {type.title}
                    </Button>
                ))}
            </div>

            <Outlet/>
        </div>
    )
}
