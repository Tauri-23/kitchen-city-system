import { Navigate, Outlet, useLocation } from "react-router-dom";
import { ToastContainer } from "react-toastify";
import { useLoggedUserContext } from "../../contexts/LoggedUserContext";
import { useEffect, useState } from "react";
import axiosClient from "../../axios-client";
import SuperAdminSideNav from "../../components/navigations/superAdminSideNav";
import { SuperAdminProvider } from "../../contexts/SuperAdminContext";
import SuperAdminNav from "../../components/navigations/superAdminNav";

export default function SuperAdminDefault() {
    const { userType, token, setUserType, setUser, setToken } = useLoggedUserContext();
    const [isLoggingOut, setIsLoggingOut] = useState<boolean>(false);
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
        if (token) {            
            axiosClient.get('/user')
            .then(({ data }) => {
                setUser(data.user);
            })
            .catch((error) => {
                console.error(error);
                if (error.response && error.response.status === 401) {
                    setUser(null);
                    setToken(null);
                    setUserType(null);
                }
            });
        } else {
            setUser(null); 
            setUserType(null);
        }
    }, []);

    const onLogout = () => {
        setIsLoggingOut(true);
        axiosClient.post('/logout')
        .then(() => {
            setUser(null);
            setToken(null);
            setUserType(null);
        })
        .finally(() => {
            setIsLoggingOut(false);
        });
    };

    // Handle redirection in the component body
    if (!token || userType !== 'Super Admin') {
        return <Navigate to="/" />;
    }




    /**
     * Render
     */
    return(
        <SuperAdminProvider>
            <div className="w-100 h-100 position-relative">
                <SuperAdminSideNav/>
                <SuperAdminNav isLoggingOut={isLoggingOut} onLogout={onLogout}/>
                <Outlet/>
                <ToastContainer/>
            </div>
        </SuperAdminProvider>
    )
}