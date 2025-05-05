import { Button, Input } from "antd";
import { useState } from "react";
import axiosClient from "../axios-client";
import { notify } from "../assets/lib/utils";

import "../assets/css/signinup.css";
import { useLoggedUserContext } from "../contexts/LoggedUserContext";

interface loginTypes {
    username: string;
    password: string;
}

export default function GuestIndex() {
    const { setUser, setToken, setUserType } = useLoggedUserContext();
    const [userIn, setUserIn] = useState<loginTypes>({
        username: "",
        password: ""
    });



    /**
     * Handlers
     */
    const handleInput = (e: React.ChangeEvent<HTMLInputElement>) => {
        setUserIn(prev => ({...prev, [e.target.name]: e.target.value}));
    }

    const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
        e.preventDefault();

        const formData = new FormData();
        formData.append("loginCredentials", JSON.stringify(userIn));

        axiosClient.post("/login", formData)
        .then(({data}) => {
            console.log(data.status);
            if(data?.status === 200) {
                setUser(data.user);
                setToken(data.token);
                setUserType(data.userType);
            }
            notify(data?.status === 200 ? "success" : "error", data.message, "top-center", 3000);
        })
        .catch((error) => {
            console.error(error);
            notify("error", "Server Error", "top-center", 3000);
        });
    }



    /**
     * Render
     */
    return(
        <div className="sign-in-up-content">
            <form className="sign-in-form" onSubmit={handleSubmit}>
                <h3 className="mar-bottom-2">Login</h3>
                <div className="mar-bottom-3">
                    <label htmlFor="username">Username</label>
                    <Input
                    id="username"
                    name="username"
                    placeholder="e.g. john123"
                    value={userIn.username}
                    onChange={handleInput}
                    />
                </div>

                <div className="mar-bottom-2">
                    <label htmlFor="password">Password</label>
                    <Input.Password
                    id="password"
                    name="password"
                    value={userIn.password}
                    onChange={handleInput}
                    />
                </div>

                <Button className="w-100" type="primary" htmlType="submit">Login</Button>
            </form>
        </div>
    );
}