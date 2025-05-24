import { useEffect, useState } from "react";
import { MenuCategoryStructure } from "../../../../types/menuCategoryStructure";
import { MenuSubCategoryStructure } from "../../../../types/menuSubCategoryStucture";
import { MenuClassStructure } from "../../../../types/menuClassStructure";
import { Select, Spin } from "antd";
import { fetchAllMenuCategories } from "../../../../services/menuCategoriesServices";
import { fetchAllMenuSubCategories } from "../../../../services/menuSubCategoriesServices";
import { fetchAllMenuClasses } from "../../../../services/menuClassesServices";
import SuperAdminMenuCategoriesSettings from "./pageComponents/supAdMenuCategoriesSettings";
import SuperAdminMenuClassesSettings from "./pageComponents/supAdMenuClassesSettings";
import SuperAdminMenuSubCategoriesSettings from "./pageComponents/supAdMenuSubCategories";

export default function SuperAdminSettingsMenuSettings() {
    const [menuCategories, setMenuCategories] = useState<MenuCategoryStructure[] | null>(null);
    const [menuSubCategories, setMenuSubCategories] = useState<MenuSubCategoryStructure[] | null>(null);
    const [menuClasses, setMenuClasses] = useState<MenuClassStructure[] | null>(null);
    
    const pages = ["Categories", "Sub-Categories", "Classes"];
    const [selectedPage, setSelectedPage] = useState<string>(pages[0]);



    /**
     * Onmount
     */
    useEffect(() => {
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
    })



    /**
     * Render
     */
    return(
        <>
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
                        <SuperAdminMenuCategoriesSettings
                        menuCategories={menuCategories}
                        setMenuCategories={setMenuCategories as React.Dispatch<React.SetStateAction<MenuCategoryStructure[]>>}
                        />
                    )}
                    


                    {/* Sub Categories */}
                    {(selectedPage === "Sub-Categories") && (
                        <SuperAdminMenuSubCategoriesSettings
                        menuSubCategories={menuSubCategories}
                        setMenuSubCategories={setMenuSubCategories as React.Dispatch<React.SetStateAction<MenuSubCategoryStructure[]>>}
                        />
                    )}



                    {/* Classes */}
                    {(selectedPage === "Classes") && (
                        <SuperAdminMenuClassesSettings
                        menuClasses={menuClasses as MenuClassStructure[]}
                        setMenuClasses={setMenuClasses as React.Dispatch<React.SetStateAction<MenuClassStructure[]>>}
                        />
                    )}
                </>
            )}
        </>
    );
}