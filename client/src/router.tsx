import { createBrowserRouter } from "react-router-dom";
import GuestDefault from "./views/default";
import GuestIndex from "./views";
import SuperAdminDefault from "./views/superAdmin/supAdDefault";
import SuperAdminIndex from "./views/superAdmin/supAdIndex";
import SuperAdminMenusDefault from "./views/superAdmin/menus/supAdMenusDefault";
import SuperAdminMenusIndex from "./views/superAdmin/menus/supAdMenusIndex";
import SuperAdminAddMenu from "./views/superAdmin/menus/supAdAddMenu";
import SuperAdminViewMenu from "./views/superAdmin/menus/supAdViewMenu";
import SuperAdminAddMenuDish from "./views/superAdmin/menus/supAdAddMenuDish";
import SuperAdminAccountsDefault from "./views/superAdmin/accounts/supAdAccountsDefault";
import SuperAdminAccountsSuperAdmins from "./views/superAdmin/accounts/supAdAccountsSuperAdmins";
import SuperAdminAccountsBranchAdmins from "./views/superAdmin/accounts/supAdAccountsBranchAdmins";
import SuperAdminAccountsBranchManagers from "./views/superAdmin/accounts/supAdAccountsBranchManagers";
import SuperAdminAccountsAreaManagers from "./views/superAdmin/accounts/supAdAccountsAreaManagers";
import SuperAdminAccountsCommissaryWorkers from "./views/superAdmin/accounts/supAdAccountsCommissaryWorkers";
import SuperAdminBranchesIndex from "./views/superAdmin/branches/supAdBranchesIndex";
import BranchManagerDefault from "./views/branchManager/braManDefault";
import BranchManagerIndex from "./views/branchManager/braManIndex";
import BranchManagerAddOrder from "./views/branchManager/orders/braManAddOrder";
import BranchManagerOrdersIndex from "./views/branchManager/orders/braManOrdersIndex";

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
                element: <SuperAdminIndex/>
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
             * Branches
             */
            {
                path: "Branches",
                element: <SuperAdminBranchesIndex/>
            },



            /**
             * Accounts
             */
            {
                path: "Accounts",
                element: <SuperAdminAccountsDefault/>,
                children: [
                    {
                        index: true,
                        element: <SuperAdminAccountsSuperAdmins/>
                    },
                    {
                        path: "BranchAdmins",
                        element: <SuperAdminAccountsBranchAdmins/>
                    },
                    {
                        path: "BranchManagers",
                        element: <SuperAdminAccountsBranchManagers/>
                    },
                    {
                        path: "AreaManagers",
                        element: <SuperAdminAccountsAreaManagers/>
                    },
                    {
                        path: "CommissaryWorkers",
                        element: <SuperAdminAccountsCommissaryWorkers/>
                    },
                ]
            },
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
            }
        ]
    }
]);

export default router;