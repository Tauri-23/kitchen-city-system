import { createBrowserRouter } from "react-router-dom";
import GuestDefault from "./views/default";
import GuestIndex from "./views";
import SuperAdminDefault from "./views/superAdmin/supAdDefault";
import SuperAdminIndex from "./views/superAdmin/supAdIndex";
import SuperAdminMenusDefault from "./views/superAdmin/menus/supAdMenusDefault";
import SuperAdminMenusIndex from "./views/superAdmin/menus/supAdMenusIndex";
import SuperAdminAddMenu from "./views/superAdmin/menus/supAdAddMenu";

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
            }
        ]
    }
]);

export default router;