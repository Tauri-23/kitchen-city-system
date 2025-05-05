import { Navigate, Outlet, useLocation } from "react-router-dom";
import { ToastContainer } from "react-toastify";
import { useLoggedUserContext } from "../contexts/LoggedUserContext";
import { useEffect } from "react";
import axiosClient from "../axios-client";

export default function GuestDefault() {
    const {token, userType, setUser, setToken, setUserType} = useLoggedUserContext();

    const location = useLocation();



    /**
     * Scroll up every change location
     */
    useEffect(() => {
        window.scrollTo(0, 0);
    }, [location.pathname]);



    /**
     * For protected access
     */
    useEffect(() => {
        if(token) {
            axiosClient.get('/user')
            .then(({data}) => {
                setUser(data.user);
                setUserType(data.userType);
            })
            .catch((error) => {
                console.error(error);
                setUserType(null);
                setUser(null);
                setToken(null);
            })
        }
    }, []);



    // Render based on userType
    if(token) {
        if(userType === "Super Admin") {
            return <Navigate to="/KCSuperAdmin"/>
        }
    }



    /**
     * Render
     */
    return(
        <div className="w-100 h-100 position-relative">
            <Outlet/>
            <ToastContainer/>
        </div>
    );
}