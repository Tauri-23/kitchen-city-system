import { Button, Input, Modal, Select } from "antd";
import { ChangeEvent, FormEvent, useState } from "react";
import axiosClient from "../../axios-client";
import { isEmptyOrSpaces, notify } from "../../assets/lib/utils";
import { BranchStructure } from "../../types/branchStructure";
import { BranchManagerStructure } from "../../types/branchManagerSturcture";

interface SuperAdminAddBranchManagerModalTypes {
    setBranchManagers: (value: BranchManagerStructure[]) => void;
    setFilteredBranchManagers: (value: BranchManagerStructure[]) => void;
    branches: BranchStructure[];
    onClose: () => void;
}

const SuperAdminAddBranchManagerModal: React.FC<SuperAdminAddBranchManagerModalTypes> = ({
    setBranchManagers,
    setFilteredBranchManagers,
    branches, 
    onClose
}) => {
    const [branchManagerIn, setBranchManagerIn] = useState({
        branchId: "",
        fname: "",
        mname: "",
        lname: "",
        email: "",
        username: "",
        password: "",
    });

    const [isAdding, setIsAdding] = useState<boolean>(false);

    const isSubmitBtnDisabled = branchManagerIn.branchId === "" || isEmptyOrSpaces(branchManagerIn.fname) || 
    isEmptyOrSpaces(branchManagerIn.lname) || isEmptyOrSpaces(branchManagerIn.email) || 
    isEmptyOrSpaces(branchManagerIn.username) || isEmptyOrSpaces(branchManagerIn.password);



    /**
     * Handlers
     */
    const handleInputChange = (e: ChangeEvent<HTMLInputElement>) => {
        setBranchManagerIn(prev => ({...prev, [e.target.name]: e.target.value}));
    }

    const clearFields = () => {
        setBranchManagerIn({
            branchId: "",
            fname: "",
            mname: "",
            lname: "",
            email: "",
            username: "",
            password: "",
        })
    }

    const handleSubmit = (e: FormEvent<HTMLFormElement>) => {
        e.preventDefault();

        if(isSubmitBtnDisabled) return;

        setIsAdding(true);

        const formData = new FormData();
        formData.append("branchManagerIn", JSON.stringify(branchManagerIn));

        axiosClient.post("/create-branch-manager", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);
            if(data.status === 200) {
                clearFields();
                setBranchManagers(data.branchManagers)
                setFilteredBranchManagers(data.branchManagers)
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



    /**
     * Render
     */
    return(
        <Modal
        title="Add Branch Manager"
        open={true}
        onCancel={onClose}
        footer={null}
        width={650}
        >
            <form onSubmit={handleSubmit} className="mar-top-1">
                {/* Select Branch */}
                <div className="mar-bottom-3">
                    <label htmlFor="branchId">Branch</label>
                    <Select
                    className="w-100"
                    size="large"
                    id="branchId"
                    value={branchManagerIn.branchId}
                    onChange={(val) => handleInputChange({target: {name: "branchId", value: val}} as ChangeEvent<HTMLInputElement>)}
                    options={[
                        {label: "Select a Branch", value: ""},
                        ...branches.map((branch) => ({label: `${branch.name} (${branch.address})`, value: branch.id}))
                    ]}/>
                </div>

                {/* Name */}
                <div className="d-flex gap3 align-items-center mar-bottom-3">
                    <div>
                        <label htmlFor="fname">Firstname</label>
                        <Input
                        size="large"
                        id="fname"
                        name="fname"
                        placeholder="e.g. John"
                        value={branchManagerIn.fname}
                        onChange={handleInputChange}/>
                    </div>

                    <div>
                        <label htmlFor="mname">Middlename (optional)</label>
                        <Input
                        size="large"
                        id="mname"
                        name="mname"
                        placeholder="e.g. Paul"
                        value={branchManagerIn.mname}
                        onChange={handleInputChange}/>
                    </div>

                    <div>
                        <label htmlFor="lname">Lastname</label>
                        <Input
                        size="large"
                        id="lname"
                        name="lname"
                        placeholder="e.g. Gaultier"
                        value={branchManagerIn.lname}
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
                    value={branchManagerIn.email}
                    onChange={handleInputChange}/>
                </div>

                {/* Credentials */}
                <div className="d-flex align-items-center gap3 mar-bottom-1">
                    <div className="w-100">
                        <label htmlFor="username">Username</label>
                        <Input
                        size="large"
                        id="username"
                        name="username"
                        placeholder="e.g. John123"
                        value={branchManagerIn.username}
                        onChange={handleInputChange}/>
                    </div>

                    <div className="w-100">
                        <label htmlFor="password">Password</label>
                        <Input.Password
                        size="large"
                        id="password"
                        name="password"
                        value={branchManagerIn.password}
                        onChange={handleInputChange}/>
                    </div>
                </div>

                {/* Buttons */}
                <div className="d-flex justify-content-end gap3 align-items-center">
                    <Button
                    size="large"
                    onClick={onClose}
                    >
                        Cancel
                    </Button>

                    <Button 
                    size="large"
                    type="primary"
                    ghost
                    onClick={clearFields}
                    >
                        Clear
                    </Button>

                    <Button 
                    size="large"
                    type="primary"
                    loading={isAdding}
                    disabled={isSubmitBtnDisabled}
                    htmlType="submit"
                    >
                        Add
                    </Button>
                </div>
            </form>
        </Modal>
    )
}

export default SuperAdminAddBranchManagerModal;