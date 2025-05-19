import { useOutletContext } from "react-router-dom";
import { useGeneralContext } from "../../../../contexts/GeneralContext";
import { SuperAdminMenuActivePageTypes } from "../supAdMenusDefault";
import { useEffect, useState } from "react";
import { MenuCategoryStructure } from "../../../../types/menuCategoryStructure";
import { MenuSubCategoryStructure } from "../../../../types/menuSubCategoryStucture";
import { fetchAllMenuCategories } from "../../../../services/menuCategoriesServices";
import { fetchAllMenuSubCategories } from "../../../../services/menuSubCategoriesServices";
import { Button, Spin, Table, TableColumnsType } from "antd";

interface OutletContextTypes {
    setSupAdMenuActivePage: (value: SuperAdminMenuActivePageTypes) => void;
}

export default function SuperAdminMenuTagsIndex() {
    const { showModal } = useGeneralContext();
    const { setSupAdMenuActivePage } = useOutletContext<OutletContextTypes>();

    const [menuCategories, setMenuCategories] = useState<MenuCategoryStructure[] | null>(null);
    const [menuSubCategories, setMenuSubCategories] = useState<MenuSubCategoryStructure[] | null>(null);



    /**
     * Onmount
     */
    useEffect(() => {
        setSupAdMenuActivePage("Menu Tags");

        const getAll = async() => {
            const [menuCategoreiesData, menuSubCategoriesData] = await Promise.all([
                fetchAllMenuCategories(),
                fetchAllMenuSubCategories()
            ]);

            setMenuCategories(menuCategoreiesData);
            setMenuSubCategories(menuSubCategoriesData);
        }

        getAll();
    });



    /**
     * Transformed Data for Table
     */
    const transformedTagsPerCategories = menuCategories?.map((category) => ({
        key: `shift-${category.id}`,
        id: category.id,
        category: category.category,
        type: "category",
        children: category.menu_tags.map(tag => ({
            key: `category-${tag.id}`,
            id: tag.id,
            tag: tag.tag,
            subCategory: tag.sub_category,
            type: "tag"
        }))
    })) || [];



    /**
     * Setup Columns
     */
    const menuTagsColumns: TableColumnsType<any> = [
        {
            title: "Menu Tag",
            render: (_, row) => {
                return row.type === "category" ? row.category : row.tag
            },
            onCell: (row) => ({
                style: {
                    backgroundColor: row.type === "category" ? 'orange' : undefined,
                },
            })
        },
        {
            title: "Actions",
            render: (_, row) => {
                if(row.type === "category") {
                    return (
                        <Button
                        size="small"
                        type="primary">
                            Add Menu Tag
                        </Button>
                    )
                }
            },
            width: 200
        }
    ]



    /**
     * Render
     */
    return(
        <>
            <h3 className="mar-bottom-1 fw-bold">Menu Tags</h3>

            {!menuCategories || !menuSubCategories
            ? (<Spin size="large"/>)
            : (
                <>
                    <Table
                    size="small"
                    columns={menuTagsColumns}
                    dataSource={transformedTagsPerCategories}
                    bordered/>
                </>
            )}
        </>
    )
}