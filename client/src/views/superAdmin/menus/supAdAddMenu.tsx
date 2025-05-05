import { Button, Input, Select } from "antd";
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
        menuWeek: "",
        menuDay: "",
        mealType: "",
        menuSize: "",
    });

    const isSubmitDisabled = isEmptyOrSpaces(menuIn.menuName) || isEmptyOrSpaces(menuIn.menuWeek) || 
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
            menuWeek: "",
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
                    size="large"
                    id="menuName"
                    name="menuName"
                    placeholder="e.g. Menu 1"
                    value={menuIn.menuName}
                    onChange={handleInputChange}/>
                </div>

                {/* Menu Week */}
                <div className="mar-bottom-2">
                    <label htmlFor="menuWeek" className="mar-bottom-4">Menu Week</label>
                    <Select
                    size="large"
                    id="menuWeek"
                    className="w-100"
                    value={menuIn.menuWeek}
                    onChange={(val) => handleInputChange({target: {name: "menuWeek", value: val}}as any)}
                    options={[
                        {label: "Select menu day", value: ""},
                        { label: "Week 1", value: 1 },
                        { label: "Week 2", value: 2 },
                        { label: "Week 3", value: 3 },
                        { label: "Week 4", value: 4 },
                    ]}/>
                </div>

                {/* Menu Day */}
                <div className="mar-bottom-1">
                    <label htmlFor="menuDay" className="mar-bottom-4">Menu Day</label>

                    <Select
                    size="large"
                    id="menuDay"
                    className="w-100"
                    value={menuIn.menuDay}
                    onChange={(val) => handleInputChange({target: {name: "menuDay", value: val}}as any)}
                    options={[
                        {label: "Select menu day", value: ""},
                        ...menuDays.map((menuDay) => ({label: menuDay, value: menuDay}))
                    ]}/>
                </div>

                {/* Meal Types */}
                <div className="mar-bottom-1">
                    <label htmlFor="mealType" className="mar-bottom-4">Meal Type</label>

                    <Select
                    size="large"
                    id="mealType"
                    className="w-100"
                    value={menuIn.mealType}
                    onChange={(val) => handleInputChange({target: {name: "mealType", value: val}}as any)}
                    options={[
                        {label: "Select meal type", value: ""},
                        ...mealTypes.map((mealType) => ({label: mealType, value: mealType}))
                    ]}/>
                </div>

                {/* Menu Size */}
                <div className="mar-bottom-1">
                    <label htmlFor="menuSize" className="mar-bottom-4">Menu Size</label>

                    <Select
                    size="large"
                    id="menuSize"
                    className="w-100"
                    value={menuIn.menuSize}
                    onChange={(val) => handleInputChange({target: {name: "menuSize", value: val}}as any)}
                    options={[
                        {label: "Select menu size", value: ""},
                        ...menuSizes.map((menuSize) => ({label: menuSize, value: menuSize}))
                    ]}/>
                </div>

                {/* Buttons */}
                <div className="d-flex gap3 align-items-center">
                    <Button 
                    size="large"
                    type="primary"
                    htmlType="submit"
                    disabled={isSubmitDisabled}
                    >
                        Add Menu
                    </Button>

                    <Button 
                    size="large"
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