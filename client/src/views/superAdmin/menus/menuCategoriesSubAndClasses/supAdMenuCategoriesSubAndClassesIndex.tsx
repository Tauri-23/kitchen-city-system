import { useEffect, useState } from "react"
import { MenuCategoryStructure } from "../../../../types/menuCategoryStructure"
import { useOutletContext } from "react-router-dom";
import { SuperAdminMenuActivePageTypes } from "../supAdMenusDefault";
import { MenuSubCategoryStructure } from "../../../../types/menuSubCategoryStucture";
import { Select, Spin } from "antd";
import { fetchAllMenuCategories } from "../../../../services/menuCategoriesServices";
import { fetchAllMenuSubCategories } from "../../../../services/menuSubCategoriesServices";
import { MenuClassStructure } from "../../../../types/menuClassStructure";
import { fetchAllMenuClasses } from "../../../../services/menuClassesServices";
import SuperAdminMenuCategories from "./components/supAdMenuCategories";
import SuperAdminMenuSubCategories from "./components/supAdMenuSubCategories";
import SuperAdminMenuClasses from "./components/supAdMenuClasses";

interface OutletContextTypes {
    setSupAdMenuActivePage: (value: SuperAdminMenuActivePageTypes) => void;
}

export default function SuperAdminMenuCategoriesSubAndClassesIndex() {
    const { setSupAdMenuActivePage } = useOutletContext<OutletContextTypes>();

    const [menuCategories, setMenuCategories] = useState<MenuCategoryStructure[] | null>(null);
    const [menuSubCategories, setMenuSubCategories] = useState<MenuSubCategoryStructure[] | null>(null);
    const [menuClasses, setMenuClasses] = useState<MenuClassStructure[] | null>(null);

    const pages = ["Categories", "Sub-Categories", "Classes"];
    const [selectedPage, setSelectedPage] = useState<string>(pages[0]);



    /**
     * Onmount
     */
    useEffect(() => {
        setSupAdMenuActivePage("Categories, Sub-Categories And Classes");

        const getAll = async() => {
            const [menuCategoreiesData, menuSubCategoriesData, menuClassesData] = await Promise.all([
                fetchAllMenuCategories(),
                fetchAllMenuSubCategories(),
                fetchAllMenuClasses()
            ]);

            setMenuCategories(menuCategoreiesData);
            setMenuSubCategories(menuSubCategoriesData);
            setMenuClasses(menuClassesData);
        }

        getAll();
    }, []);



    /**
     * Render
     */
    return(
        <>
            <h3 className="fw-bold mar-bottom-1">Categories, Sub-Categories & Classes</h3>

            {(!menuCategories || !menuSubCategories || !menuClasses)
            ? (<Spin size="large"/>)
            : (
                <>
                    <Select
                    size="large"
                    className="mar-bottom-1"
                    options={pages.map(page => ({label: page, value: page}))}
                    value={selectedPage}
                    onChange={(val) => setSelectedPage(val)}
                    style={{width: 200}}/>
                    


                    {/* Categories */}
                    {(selectedPage === "Categories") && (
                        <SuperAdminMenuCategories
                        menuCategories={menuCategories}
                        setMenuCategories={setMenuCategories as React.Dispatch<React.SetStateAction<MenuCategoryStructure[]>>}
                        />
                    )}
                    


                    {/* Sub Categories */}
                    {(selectedPage === "Sub-Categories") && (
                        <SuperAdminMenuSubCategories
                        menuSubCategories={menuSubCategories}
                        setMenuSubCategories={setMenuSubCategories as React.Dispatch<React.SetStateAction<MenuSubCategoryStructure[]>>}
                        />
                    )}



                    {/* Classes */}
                    {(selectedPage === "Classes") && (
                        <SuperAdminMenuClasses
                        menuClasses={menuClasses as MenuClassStructure[]}
                        setMenuClasses={setMenuClasses as React.Dispatch<React.SetStateAction<MenuClassStructure[]>>}
                        />
                    )}
                </>
            )}
        </>
    )
}