import { createBrowserRouter } from "react-router-dom";
import GuestDefault from "./views/default";
import GuestIndex from "./views";
import SuperAdminDefault from "./views/superAdmin/supAdDefault";
import SuperAdminDashboard from "./views/superAdmin/dashboard/supAdDashboard";
import SuperAdminMenusIndex from "./views/superAdmin/menus/supAdMenusIndex";
import SuperAdminViewMenu from "./views/superAdmin/menus/supAdViewMenu";
import BranchManagerDefault from "./views/branchManager/braManDefault";
import BranchManagerIndex from "./views/branchManager/braManIndex";
import BranchManagerAddOrder from "./views/branchManager/orders/braManAddOrder";
import BranchManagerOrdersIndex from "./views/branchManager/orders/braManOrdersIndex";
import BranchManagerViewOrder from "./views/branchManager/orders/braManViewOrder";
import SuperAdminMenuDishesIndex from "./views/superAdmin/dishes/supAdMenuDishesIndex";
import SuperAdminSettingsDefault from "./views/superAdmin/settings/supAdSettingsDefault";
import SuperAdminReportIndex from "./views/superAdmin/reports/supAdReportsIndex";
import SuperAdminMarketListsDefault from "./views/superAdmin/marketLists/supAdMarketListsDefault";
import SuperAdminMarketListsBakeshop from "./views/superAdmin/marketLists/supAdMarketListsBakeShop";
import SuperAdminMarketListsRawMat from "./views/superAdmin/marketLists/supAdMarketListsRawMat";

const router = createBrowserRouter([
    /**
     * Guest
     */
    {
        path: "/",
        element: <GuestDefault/>,
        children: [
            {
                index: true,
                element: <GuestIndex/>
            }
        ]
    },





    /**
     * Super Admin
     */
    {
        path: "/KCSuperAdmin",
        element: <SuperAdminDefault/>,
        children: [
            {
                index: true,
                element: <SuperAdminDashboard/>
            },



            /**
             * Menus
             */
            {
                path: "Menus",
                element: <SuperAdminMenusIndex/>,
            },
            {
                path: "ViewMenu/:id",
                element: <SuperAdminViewMenu/>
            },



            /**
             * Dishes
             */
            {
                path: "Dishes", 
                element: <SuperAdminMenuDishesIndex/>
            },



            /**
             * Market Lists
             */
            {
                path: "MarketLists",
                element: <SuperAdminMarketListsDefault/>,
                children: [
                    {
                        index: true,
                        element: <SuperAdminMarketListsBakeshop/>
                    },
                    {
                        path: "RawMat", 
                        element: <SuperAdminMarketListsRawMat/>
                    }
                ]
            },



            /**
             * Reports
             */
            {
                path: "Reports",
                element: <SuperAdminReportIndex/>
            },



            /**
             * Settings
             */
            {
                path: "Settings", 
                element: <SuperAdminSettingsDefault/>
            }
        ]
    },





    /**
     * Branch Manager
     */
    {
        path: "KCBranchManager",
        element: <BranchManagerDefault/>,
        children: [
            {
                index: true,
                element: <BranchManagerIndex/>
            },



            /**
             * Orders
             */
            {
                path: "Orders",
                element: <BranchManagerOrdersIndex/>
            },
            {
                path: "AddOrder",
                element: <BranchManagerAddOrder/>
            },
            {
                path: "ViewOrder/:id",
                element: <BranchManagerViewOrder/>
            }
        ]
    }
]);

export default router;