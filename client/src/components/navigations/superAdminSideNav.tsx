import { MdDashboard, MdOutlineDashboard } from "react-icons/md"
import { useSuperAdminContext } from "../../contexts/SuperAdminContext"
import { IoFastFood, IoFastFoodOutline, IoStorefront, IoStorefrontOutline } from "react-icons/io5";
import { PiUsersFour, PiUsersFourFill } from "react-icons/pi";

export default function SuperAdminSideNav() {
    const { activeSideNavLink } = useSuperAdminContext();
    const links = [
        {
            title: "Dashboard",
            icon: <MdOutlineDashboard size={30}/>,
            iconActive: <MdDashboard size={30}/>,
            activeAt: "Dashboard"
        },
        {
            title: "Menus",
            icon: <IoFastFoodOutline size={30}/>,
            iconActive: <IoFastFood size={30}/>,
            activeAt: "Menus"
        },
        {
            title: "Branches",
            icon: <IoStorefrontOutline size={30}/>,
            iconActive: <IoStorefront size={30}/>,
            activeAt: "Branches"
        },
        {
            title: "Accounts",
            icon: <PiUsersFour size={30}/>,
            iconActive: <PiUsersFourFill size={30}/>,
            activeAt: "Accounts"
        },
    ]



    /**
     * Render
     */
    return(
        <aside className="sidenav1">
            {/* LOGO */}
            <div className="sidenav1-logo">
                <img src="/media/logos/kc-logo1.webp" alt="logo" />
                <span>Kitchen City</span>
            </div>

            {/* Links */}
            <div className="sidenav1-links">
                {links.map((link, index) => (
                    <div key={index} className={`sidenav1-link ${activeSideNavLink === link.activeAt ? "active" : ""}`}>
                        {activeSideNavLink === link.activeAt ? link.iconActive : link.icon}
                        {link.title}
                    </div>
                ))}
            </div>
        </aside>
    )
}