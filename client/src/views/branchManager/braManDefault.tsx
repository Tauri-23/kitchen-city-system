import { Navigate, Outlet, useLocation } from "react-router-dom";
import { useLoggedUserContext } from "../../contexts/LoggedUserContext";
import { useEffect } from "react";
import axiosClient from "../../axios-client";
import { ToastContainer } from "react-toastify";
import BranchManagerNav from "../../components/navigations/branchManagerNav";

export default function BranchManagerDefault() {
    const { userType, token, setUserType, setUser, setToken } = useLoggedUserContext();

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
        axiosClient.post('/logout')
            .then(() => {
                setUser(null);
                setToken(null);
                setUserType(null);
            });
        // window.location.href="/";
    };

    console.log(token);

    // Handle redirection in the component body
    if (!token || userType !== 'Branch Manager') {
        return <Navigate to="/" />;
    }

    

    /**
     * Render
     */
    return (
        <div className="w-100 h-100 position-relative">
            <BranchManagerNav onLogout={onLogout}/>
            <Outlet/>
            <ToastContainer/>
        </div>
    )
}
