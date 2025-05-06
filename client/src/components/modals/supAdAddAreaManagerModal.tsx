import { Button, Input, Modal } from "antd";
import { ChangeEvent, useState } from "react";
import axiosClient from "../../axios-client";
import { isEmptyOrSpaces, notify } from "../../assets/lib/utils";
import { AreaManagerStructure } from "../../types/areaManagerSturcture";

interface SuperAdminAddAreaManagerModalTypes {
    setAreaManagers: (value: AreaManagerStructure[]) => void;
    onClose: () => void;
}

const SuperAdminAddAreaManagerModal: React.FC<SuperAdminAddAreaManagerModalTypes> = ({setAreaManagers, onClose}) => {
    const [areaManagerIn, setAreaManagerIn] = useState({
        fname: "",
        mname: "",
        lname: "",
        email: "",
    });

    const [isAdding, setIsAdding] = useState<boolean>(false);

    const isSubmitBtnDisabled = isEmptyOrSpaces(areaManagerIn.fname) || isEmptyOrSpaces(areaManagerIn.lname) || isEmptyOrSpaces(areaManagerIn.email);



    /**
     * Handlers
     */
    const handleInputChange = (e: ChangeEvent<HTMLInputElement>) => {
        setAreaManagerIn(prev => ({...prev, [e.target.name]: e.target.value}));
    }

    const clearFields = () => {
        setAreaManagerIn({
            fname: "",
            mname: "",
            lname: "",
            email: "",
        })
    }

    const handleSubmit = () => {
        setIsAdding(true);
        const formData = new FormData();
        formData.append("areaManagerIn", JSON.stringify(areaManagerIn));

        axiosClient.post("/create-area-manager", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);
            if(data.status === 200) {
                clearFields();
                setAreaManagers(data.areaManagers);
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
                        value={areaManagerIn.fname}
                        onChange={handleInputChange}/>
                    </div>

                    <div>
                        <label htmlFor="mname">Middlename (optional)</label>
                        <Input
                        size="large"
                        id="mname"
                        name="mname"
                        placeholder="e.g. Paul"
                        value={areaManagerIn.mname}
                        onChange={handleInputChange}/>
                    </div>

                    <div>
                        <label htmlFor="lname">Lastname</label>
                        <Input
                        size="large"
                        id="lname"
                        name="lname"
                        placeholder="e.g. Gaultier"
                        value={areaManagerIn.lname}
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
                    value={areaManagerIn.email}
                    onChange={handleInputChange}/>
                </div>
            </form>
        </Modal>
    )
}

export default SuperAdminAddAreaManagerModal;