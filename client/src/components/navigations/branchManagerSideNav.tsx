import { MdDashboard, MdOutlineDashboard } from "react-icons/md"
import { Link } from "react-router-dom";
import { BiPackage, BiSolidPackage } from "react-icons/bi";
import { useBranchManagerContext } from "../../contexts/BranchManagerContext";
import { IoStorefront, IoStorefrontOutline } from "react-icons/io5";

export default function BranchManagerSideNav() {
    const { activeSideNavLink } = useBranchManagerContext();
    const links = [
        {
            title: "Dashboard",
            icon: <MdOutlineDashboard size={30}/>,
            iconActive: <MdDashboard size={30}/>,
            activeAt: "Dashboard",
            to: "/"
        },
        {
            title: "Orders",
            icon: <BiPackage size={30}/>,
            iconActive: <BiSolidPackage size={30}/>,
            activeAt: "Orders",
            to: "Orders"
        },
        {
            title: "Market Lists Orders",
            icon: <IoStorefrontOutline size={30}/>,
            iconActive: <IoStorefront size={30}/>,
            activeAt: "Market Lists Orders",
            to: "MarketListsOrders"
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