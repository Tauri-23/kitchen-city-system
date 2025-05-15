import { Button, Input, Modal, Select } from "antd";
import { ChangeEvent, FormEvent, useState } from "react";
import axiosClient from "../../axios-client";
import { isEmptyOrSpaces, notify } from "../../assets/lib/utils";
import { AreaManagerStructure } from "../../types/areaManagerSturcture";
import { BranchStructure } from "../../types/branchStructure";

interface SuperAdminAddBranchModalTypes {
    setBranches: (value: BranchStructure[]) => void;
    setFilteredBranches: (value: BranchStructure[]) => void;
    areaManagers: AreaManagerStructure[];
    onClose: () => void;
}

const SuperAdminAddBranchModal: React.FC<SuperAdminAddBranchModalTypes> = ({setBranches, setFilteredBranches, areaManagers, onClose}) => {
    const branchSizes = ["XL", "Large", "Medium", "Medium Frying", "Small", "Small Frying"];

    const [branchIn, setBranchIn] = useState({
        branchCode: "",
        name: "",
        address: "",
        areaManagerId: "",
        size: ""
    });

    const [isAdding, setIsAdding] = useState<boolean>(false);

    const isSubmitBtnDisabled = isEmptyOrSpaces(branchIn.branchCode) || isEmptyOrSpaces(branchIn.name) || 
    isEmptyOrSpaces(branchIn.address) || branchIn.areaManagerId === "" || branchIn.size === "";



    /**
     * Handlers
     */
    const handleInputChange = (e: ChangeEvent<HTMLInputElement>) => {
        setBranchIn(prev => ({...prev, [e.target.name]: e.target.value}));
    }

    const clearFields = () => {
        setBranchIn({
            branchCode: "",
            name: "",
            address: "",
            areaManagerId: "",
            size: ""
        })
    }

    const handleSubmit = (e: FormEvent<HTMLFormElement>) => {
        e.preventDefault();

        if(isSubmitBtnDisabled) return;

        setIsAdding(true);
        const formData = new FormData();
        formData.append("branchIn", JSON.stringify(branchIn));

        axiosClient.post("/create-branch", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);
            if(data.status === 200) {
                clearFields();
                setBranches(data.branches);
                setFilteredBranches(data.branches);
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
        title="Add Area Manager"
        open={true}
        onCancel={onClose}
        footer={null}
        width={650}
        >
            <form onSubmit={handleSubmit} className="mar-top-1">
                {/* Branch Code */}
                <div className="mar-bottom-3">
                    <label htmlFor="branchCode">Branch Code</label>
                    <Input
                    size="large"
                    id="branchCode"
                    name="branchCode"
                    placeholder="KC-XXXX"
                    value={branchIn.branchCode}
                    onChange={handleInputChange}/>
                </div>

                {/* Branch Name */}
                <div className="mar-bottom-3">
                    <label htmlFor="name">Branch Name</label>
                    <Input
                    size="large"
                    id="name"
                    name="name"
                    placeholder="e.g. John Deli"
                    value={branchIn.name}
                    onChange={handleInputChange}/>
                </div>

                {/* Branch Address */}
                <div className="mar-bottom-3">
                    <label htmlFor="address">Branch Address</label>
                    <Input
                    size="large"
                    id="address"
                    name="address"
                    placeholder="e.g. BGC Taguig"
                    value={branchIn.address}
                    onChange={handleInputChange}/>
                </div>

                {/* Area Managers */}
                <div className="mar-bottom-3">
                    <label htmlFor="areaManagerId">Area Managers</label>
                    <Select
                    className="w-100"
                    size="large"
                    id="areaManagerId"
                    value={branchIn.areaManagerId}
                    onChange={(value) => handleInputChange({target: {name: "areaManagerId", value: value}} as ChangeEvent<HTMLInputElement>)}
                    options={[
                        {label: "Select Area Manager", value: ""},
                        ...areaManagers.map((manager) => ({label: `${manager.fname} ${manager.lname}`, value: manager.id}))
                    ]}/>
                </div>

                {/* Size */}
                <div className="mar-bottom-1">
                    <label htmlFor="size">Branch Size</label>
                    <Select
                    className="w-100"
                    size="large"
                    id="size"
                    value={branchIn.size}
                    onChange={(value) => handleInputChange({target: {name: "size", value: value}} as ChangeEvent<HTMLInputElement>)}
                    options={[
                        {label: "Select Branch Size", value: ""},
                        ...branchSizes.map((size) => ({label: size, value: size}))
                    ]}/>
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

export default SuperAdminAddBranchModal;