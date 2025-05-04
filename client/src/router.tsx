import { createBrowserRouter } from "react-router-dom";
import GuestDefault from "./views/default";
import GuestIndex from "./views";

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
]);

export default router;