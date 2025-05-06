import { useEffect, useState } from "react";
import { useBranchManagerContext } from "../../../contexts/BranchManagerContext"
import { getWeekOfMonthFixed4 } from "../../../assets/lib/utils";
import { MenuStructure } from "../../../types/menuStructure";
import { fetchAllMenusWhereWeek } from "../../../services/menusServices";
import { Spin } from "antd";

export default function BranchManagerAddOrder() {
    const { setActiveSideNavLink } = useBranchManagerContext();

    const [menus, setMenus] = useState<MenuStructure[] | null>(null);
    
    const weekNow = getWeekOfMonthFixed4(new Date())



    /**
     * Onmount
     */
    useEffect(() => {
        setActiveSideNavLink("Orders");

        const getAll = async() => {
            const data = await fetchAllMenusWhereWeek(weekNow);
            setMenus(data);
        }

        getAll();
    }, []);



    /**
     * Render
     */
    return(
        <div className="content1 compressed">
            <h3 className="fw-bold mar-bottom-1">Add Orders</h3>

            <span className="mar-bottom-2">Avaliable menus (Week {weekNow})</span>

            <div className="d-flex flex-direction-y gap3">
                {!menus
                ? (<Spin size="large"/>)
                : (menus.map((menu, index) => (
                    <div key={index}>
                        {menu.menu_name}
                    </div>
                )))}
            </div>

        </div>
    )
}