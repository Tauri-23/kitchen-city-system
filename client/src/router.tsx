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
import SuperAdminBranchesDefault from "./views/superAdmin/branches/supAdBranchesDefault";
import SuperAdminBranchesIndex from "./views/superAdmin/branches/supAdBranchesIndex";
import SuperAdminAccountsDefault from "./views/superAdmin/accounts/supAdAccountsDefault";
import SuperAdminAccountsIndex from "./views/superAdmin/accounts/supAdAccountsIndex";

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
                element: <SuperAdminBranchesDefault/>,
                children: [
                    {
                        index: true,
                        element: <SuperAdminBranchesIndex/>
                    }
                ]
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
                        element: <SuperAdminAccountsIndex/>
                    }
                ]
            },
        ]
    }
]);

export default router;