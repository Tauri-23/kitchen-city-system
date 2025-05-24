import { createBrowserRouter } from "react-router-dom";
import GuestDefault from "./views/default";
import GuestIndex from "./views";
import SuperAdminDefault from "./views/superAdmin/supAdDefault";
import SuperAdminDashboard from "./views/superAdmin/dashboard/supAdDashboard";
import SuperAdminMenusDefault from "./views/superAdmin/menus/supAdMenusDefault";
import SuperAdminMenusIndex from "./views/superAdmin/menus/supAdMenusIndex";
import SuperAdminAddMenu from "./views/superAdmin/menus/supAdAddMenu";
import SuperAdminViewMenu from "./views/superAdmin/menus/supAdViewMenu";
import SuperAdminAddMenuDish from "./views/superAdmin/menus/supAdAddMenuDish";
import BranchManagerDefault from "./views/branchManager/braManDefault";
import BranchManagerIndex from "./views/branchManager/braManIndex";
import BranchManagerAddOrder from "./views/branchManager/orders/braManAddOrder";
import BranchManagerOrdersIndex from "./views/branchManager/orders/braManOrdersIndex";
import BranchManagerViewOrder from "./views/branchManager/orders/braManViewOrder";
import SuperAdminMenuDishesIndex from "./views/superAdmin/menus/menuDishes/supAdMenuDishesIndex";
import SuperAdminMenuTagsIndex from "./views/superAdmin/menus/menuTags/supAdMenuTagsIndex";
import SuperAdminSettingsDefault from "./views/superAdmin/settings/supAdSettingsDefault";

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
                element: <SuperAdminMenusDefault/>,
                children: [
                    {
                        index: true,
                        element: <SuperAdminMenusIndex/>
                    },
                    {
                        path: "MenuTags",
                        element: <SuperAdminMenuTagsIndex/>
                    },
                    {
                        path: "MenuDishes",
                        element: <SuperAdminMenuDishesIndex/>
                    }
                ]
            },
            {
                path: "AddMenu",
                element: <SuperAdminAddMenu/>
            },
            {
                path: "AddMenuDish/:menuId",
                element: <SuperAdminAddMenuDish/>
            },
            {
                path: "ViewMenu/:id",
                element: <SuperAdminViewMenu/>
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