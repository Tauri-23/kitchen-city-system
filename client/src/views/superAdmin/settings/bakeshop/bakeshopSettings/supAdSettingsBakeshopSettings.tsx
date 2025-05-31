import { useEffect, useState } from "react";
import MlBakeshopCategoryStructure from "../../../../../types/mlBakeshopCategoryStructure";
import { fetchAllMlBakeshopCategories } from "../../../../../services/mlBakeshopCategoryServices";
import { Select } from "antd";
import SuperAdminBakeshopCategoriesSettings from "./pageComponents/supAdBakeshopCategorySettings";

export default function SuperAdminSettingsBakeshopSettings() {
    const [bakeshopCategories, setBakeshopCategories] = useState<MlBakeshopCategoryStructure[] | null>(null);

    const pages = ["Categories"];
    const [selectedPage, setSelectedPage] = useState<string>(pages[0]);



    /**
     * Onmount
     */
    useEffect(() => {
        const getAll = async() => {
            const [categoriesData] = await Promise.all([
                fetchAllMlBakeshopCategories()
            ]);

            setBakeshopCategories(categoriesData);
        }

        getAll();
    }, []);



    /**
     * Render
     */
    return(
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
                <SuperAdminBakeshopCategoriesSettings
                bakeshopCategories={bakeshopCategories as MlBakeshopCategoryStructure[]}
                setBakeshopCategories={setBakeshopCategories as React.Dispatch<React.SetStateAction<MlBakeshopCategoryStructure[]>>}
                />
            )}
        </>
    );
}