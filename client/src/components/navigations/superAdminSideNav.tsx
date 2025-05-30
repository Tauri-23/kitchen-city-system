import { MdDashboard, MdOutlineDashboard } from "react-icons/md"
import { useSuperAdminContext } from "../../contexts/SuperAdminContext"
import { IoSettings, IoSettingsOutline, IoStorefront, IoStorefrontOutline } from "react-icons/io5";
import { Link } from "react-router-dom";
import { BiDish, BiFoodMenu, BiSolidDish, BiSolidFoodMenu } from "react-icons/bi";
import { HiDocumentReport, HiOutlineDocumentReport } from "react-icons/hi";

export default function SuperAdminSideNav() {
    const { activeSideNavLink } = useSuperAdminContext();
    const links = [
        {
            title: "Dashboard",
            icon: <MdOutlineDashboard size={30}/>,
            iconActive: <MdDashboard size={30}/>,
            activeAt: "Dashboard",
            to: ""
        },
        {
            title: "Menus",
            icon: <BiFoodMenu size={30}/>,
            iconActive: <BiSolidFoodMenu size={30}/>,
            activeAt: "Menus",
            to: "Menus"
        },
        {
            title: "Dishes",
            icon: <BiDish size={30}/>,
            iconActive: <BiSolidDish size={30}/>,
            activeAt: "Dishes",
            to: "Dishes"
        },
        {
            title: "Market Lists",
            icon: <IoStorefrontOutline size={30}/>,
            iconActive: <IoStorefront size={30}/>,
            activeAt: "Market Lists",
            to: "MarketLists"
        },
        {
            title: "Reports",
            icon: <HiOutlineDocumentReport size={30}/>,
            iconActive: <HiDocumentReport size={30}/>,
            activeAt: "Reports",
            to: "Reports"
        },
        {
            title: "Settings",
            icon: <IoSettingsOutline size={30}/>,
            iconActive: <IoSettings size={30}/>,
            activeAt: "Settings",
            to: "Settings"
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
                    <Link to={link.to} key={index} className={`sidenav1-link ${activeSideNavLink === link.activeAt ? "active" : ""}`}>
                        {activeSideNavLink === link.activeAt ? link.iconActive : link.icon}
                        {link.title}
                    </Link>
                ))}
            </div>
        </aside>
    )
}