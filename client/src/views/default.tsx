import { Outlet } from "react-router-dom";
import { ToastContainer } from "react-toastify";

export default function GuestDefault() {
    return(
        <div className="w-100 h-100 position-relative">
            <Outlet/>
            <ToastContainer/>
        </div>
    );
}