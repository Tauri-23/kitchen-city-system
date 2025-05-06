import { Navigate, Outlet, useLocation } from "react-router-dom";
import { useLoggedUserContext } from "../../contexts/LoggedUserContext";
import { useEffect, useState } from "react";
import axiosClient from "../../axios-client";
import { ToastContainer } from "react-toastify";
import BranchManagerNav from "../../components/navigations/branchManagerNav";
import BranchManagerSideNav from "../../components/navigations/branchManagerSideNav";
import { BranchManagerProvider } from "../../contexts/BranchManagerContext";

export default function BranchManagerDefault() {
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
    if (!token || userType !== 'Branch Manager') {
        return <Navigate to="/" />;
    }

    

    /**
     * Render
     */
    return (
        <BranchManagerProvider>
            <div className="w-100 h-100 position-relative">
                <BranchManagerSideNav/>
                <BranchManagerNav isLoggingOut={isLoggingOut} onLogout={onLogout}/>
                <Outlet/>
                <ToastContainer/>
            </div>
        </BranchManagerProvider>
    )
}
