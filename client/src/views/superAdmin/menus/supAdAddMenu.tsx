import { Input, Radio } from "antd";
import { ChangeEvent, FormEvent, useEffect, useState } from "react";
import { useSuperAdminContext } from "../../../contexts/SuperAdminContext";

export default function SuperAdminAddMenu() {
    const { setActiveSideNavLink } = useSuperAdminContext();

    const [menuIn, setMenuIn] = useState({
        menuName: "",
        menuWeek: null,
        mealType: "",
    });



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

    const handleSubmit = (e: FormEvent<HTMLFormElement>) => {
        e.preventDefault();
        
        const formData = new FormData();
        formData.append("menuIn", JSON.stringify(menuIn));
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
                <div className="mar-bottom-2">
                    <label htmlFor="menuName" className="mar-bottom-4">Menu Name</label>
                    <Input
                    id="menuName"
                    name="menuName"
                    placeholder="e.g. Menu 1"
                    value={menuIn.menuName}
                    onChange={handleInputChange}/>
                </div>

                <div>
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
            </form>
        </div>
    )
}