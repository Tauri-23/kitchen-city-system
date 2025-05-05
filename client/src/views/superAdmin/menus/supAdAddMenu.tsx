import { Button, Input, Radio } from "antd";
import { ChangeEvent, FormEvent, useEffect, useState } from "react";
import { useSuperAdminContext } from "../../../contexts/SuperAdminContext";
import axiosClient from "../../../axios-client";
import { isEmptyOrSpaces, notify } from "../../../assets/lib/utils";

export default function SuperAdminAddMenu() {
    const { setActiveSideNavLink } = useSuperAdminContext();

    const menuDays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    const mealTypes = ["Breakfast", "Lunch", "Snack", "Dinner", "Midnight Lunch", "Midnight Snack"];
    const menuSizes = ["XL", "Large", "Medium", "Medium Frying", "Small", "Small Frying"];

    const [menuIn, setMenuIn] = useState({
        menuName: "",
        menuWeek: null,
        menuDay: "",
        mealType: "",
        menuSize: "",
    });

    const isSubmitDisabled = isEmptyOrSpaces(menuIn.menuName) || menuIn.menuWeek === null || 
    isEmptyOrSpaces(menuIn.menuDay) || isEmptyOrSpaces(menuIn.mealType) || isEmptyOrSpaces(menuIn.menuSize);



    /**
     * Onmount
     */
    useEffect(() => {
        setActiveSideNavLink("Menus");
    })



    /**
     * Handlers
     */
    const handleInputChange = (e: ChangeEvent<HTMLInputElement>) => {
        setMenuIn(prev => ({...prev, [e.target.name]: e.target.value}));
    }

    const clearFields = () => {
        setMenuIn({
            menuName: "",
            menuWeek: null,
            menuDay: "",
            mealType: "",
            menuSize: "",
        });
    }

    const handleSubmit = (e: FormEvent<HTMLFormElement>) => {
        e.preventDefault();
        
        const formData = new FormData();
        formData.append("menuIn", JSON.stringify(menuIn));

        axiosClient.post("/create-menus", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);

            if(data.status === 200) {
                clearFields();
            }
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
        <div className="content1 compressed">
            <h3 className="fw-bold mar-bottom-1">Add Menu</h3>

            <form
            style={{width: 500}}
            onSubmit={handleSubmit}>
                {/* Menu Name */}
                <div className="mar-bottom-2">
                    <label htmlFor="menuName" className="mar-bottom-4">Menu Name</label>
                    <Input
                    id="menuName"
                    name="menuName"
                    placeholder="e.g. Menu 1"
                    value={menuIn.menuName}
                    onChange={handleInputChange}/>
                </div>

                {/* Menu Week */}
                <div className="mar-bottom-2">
                    <label htmlFor="menuWeek" className="mar-bottom-4">Menu Week</label>
                    <Radio.Group
                    className="d-flex flex-direction-y gap4"
                    id="menuWeek"
                    name="menuWeek"
                    value={menuIn.menuWeek}
                    onChange={(e) =>
                        handleInputChange({
                            target: {
                                name: "menuWeek",
                                value: e.target.value,
                            },
                        } as any)
                    }
                    options={[
                        { label: "Week 1", value: 1 },
                        { label: "Week 2", value: 2 },
                        { label: "Week 3", value: 3 },
                        { label: "Week 4", value: 4 },
                    ]}
                    />
                </div>

                {/* Menu Day */}
                <div className="mar-bottom-1">
                    <label htmlFor="menuDay" className="mar-bottom-4">Select Menu Day</label>

                    <div className="d-flex flex-wrap gap3">
                        {menuDays.map((menuDay, index) => (
                            <Button
                            key={index}
                            type={menuIn.menuDay === menuDay ? "primary" : "default"}
                            ghost={menuIn.menuDay === menuDay}
                            onClick={() => handleInputChange({ target: {
                                    name: "menuDay",
                                    value: menuDay
                            }} as any)}
                            >
                                {menuDay}
                            </Button>
                        ))}
                    </div>
                </div>

                {/* Meal Types */}
                <div className="mar-bottom-1">
                    <label htmlFor="mealType" className="mar-bottom-4">Select Meal Type</label>

                    <div className="d-flex flex-wrap gap3">
                        {mealTypes.map((mealType, index) => (
                            <Button
                            key={index}
                            type={menuIn.mealType === mealType ? "primary" : "default"}
                            ghost={menuIn.mealType === mealType}
                            onClick={() => handleInputChange({ target: {
                                    name: "mealType",
                                    value: mealType
                            }} as any)}
                            >
                                {mealType}
                            </Button>
                        ))}
                    </div>
                </div>

                {/* Menu Size */}
                <div className="mar-bottom-1">
                    <label htmlFor="menuSize" className="mar-bottom-4">Select Menu Size</label>

                    <div className="d-flex flex-wrap gap3">
                        {menuSizes.map((menuSize, index) => (
                            <Button
                            key={index}
                            type={menuIn.menuSize === menuSize ? "primary" : "default"}
                            ghost={menuIn.menuSize === menuSize}
                            onClick={() => handleInputChange({ target: {
                                    name: "menuSize",
                                    value: menuSize
                            }} as any)}
                            >
                                {menuSize}
                            </Button>
                        ))}
                    </div>
                </div>

                {/* Buttons */}
                <div className="d-flex gap3 align-items-center">
                    <Button 
                    type="primary"
                    htmlType="submit"
                    disabled={isSubmitDisabled}
                    >
                        Add Menu
                    </Button>

                    <Button 
                    type="primary"
                    ghost
                    onClick={clearFields}
                    >
                        Clear
                    </Button>
                </div>
            </form>
        </div>
    )
}