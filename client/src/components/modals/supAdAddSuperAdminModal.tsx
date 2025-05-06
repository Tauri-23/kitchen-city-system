import { Button, Input, Modal } from "antd";
import { ChangeEvent, useState } from "react";
import axiosClient from "../../axios-client";
import { isEmptyOrSpaces, notify } from "../../assets/lib/utils";
import { SuperAdminStructure } from "../../types/superAdminSturcture";
import { useLoggedUserContext } from "../../contexts/LoggedUserContext";

interface SuperAdminAddAdminModalTypes {
    setSuperAdmins: (value: SuperAdminStructure[]) => void;
    onClose: () => void;
}

const SuperAdminAddSuperAdminModal: React.FC<SuperAdminAddAdminModalTypes> = ({setSuperAdmins, onClose}) => {
    const { user } = useLoggedUserContext();
    const [superAdminIn, setSuperAdminIn] = useState({
        fname: "",
        mname: "",
        lname: "",
        email: "",
        username: "",
        password: "",
    });

    const [isAdding, setIsAdding] = useState<boolean>(false);

    const isSubmitBtnDisabled = isEmptyOrSpaces(superAdminIn.fname) || isEmptyOrSpaces(superAdminIn.lname) || 
    isEmptyOrSpaces(superAdminIn.email) || isEmptyOrSpaces(superAdminIn.username) || 
    isEmptyOrSpaces(superAdminIn.password);



    /**
     * Handlers
     */
    const handleInputChange = (e: ChangeEvent<HTMLInputElement>) => {
        setSuperAdminIn(prev => ({...prev, [e.target.name]: e.target.value}));
    }

    const clearFields = () => {
        setSuperAdminIn({
            fname: "",
            mname: "",
            lname: "",
            email: "",
            username: "",
            password: "",
        })
    }

    const handleSubmit = () => {
        setIsAdding(true);
        if(user) {
            const formData = new FormData();
            formData.append("superAdminIn", JSON.stringify(superAdminIn));
            formData.append("superAdminId", user.id);

            axiosClient.post("/create-super-admin", formData)
            .then(({data}) => {
                notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);
                if(data.status === 200) {
                    clearFields();
                    // onClose();
                    setSuperAdmins(data.superAdmins);
                }
            })
            .catch(error => {
                console.error(error);
                notify("error", "Server Error", "top-center", 3000);
            })
            .finally(() => {
                setIsAdding(false);
            });
        }
    }



    /**
     * Render
     */
    return(
        <Modal
        title="Add Super Admin"
        open={true}
        onCancel={onClose}
        footer={(_, { CancelBtn }) => (
            <>
                <CancelBtn />
                <Button 
                type="primary"
                ghost
                onClick={clearFields}
                >
                    Clear
                </Button>

                <Button 
                type="primary"
                loading={isAdding}
                onClick={handleSubmit}
                disabled={isSubmitBtnDisabled}
                >
                    Add
                </Button>
            </>
        )}
        width={650}
        >
            <form className="mar-y-1">
                {/* Name */}
                <div className="d-flex gap3 align-items-center mar-bottom-3">
                    <div>
                        <label htmlFor="fname">Firstname</label>
                        <Input
                        size="large"
                        id="fname"
                        name="fname"
                        placeholder="e.g. John"
                        value={superAdminIn.fname}
                        onChange={handleInputChange}/>
                    </div>

                    <div>
                        <label htmlFor="mname">Middlename (optional)</label>
                        <Input
                        size="large"
                        id="mname"
                        name="mname"
                        placeholder="e.g. Paul"
                        value={superAdminIn.mname}
                        onChange={handleInputChange}/>
                    </div>

                    <div>
                        <label htmlFor="lname">Lastname</label>
                        <Input
                        size="large"
                        id="lname"
                        name="lname"
                        placeholder="e.g. Gaultier"
                        value={superAdminIn.lname}
                        onChange={handleInputChange}/>
                    </div>
                </div>

                {/* Email */}
                <div className="mar-bottom-3">
                    <label htmlFor="email">Email</label>
                    <Input
                    size="large"
                    id="email"
                    name="email"
                    placeholder="e.g. John@domain.com"
                    value={superAdminIn.email}
                    onChange={handleInputChange}/>
                </div>

                {/* Credentials */}
                <div className="d-flex align-items-center gap3">
                    <div className="w-100">
                        <label htmlFor="username">Username</label>
                        <Input
                        size="large"
                        id="username"
                        name="username"
                        placeholder="e.g. John123"
                        value={superAdminIn.username}
                        onChange={handleInputChange}/>
                    </div>

                    <div className="w-100">
                        <label htmlFor="password">Password</label>
                        <Input.Password
                        size="large"
                        id="password"
                        name="password"
                        value={superAdminIn.password}
                        onChange={handleInputChange}/>
                    </div>
                </div>
            </form>
        </Modal>
    )
}

export default SuperAdminAddSuperAdminModal;