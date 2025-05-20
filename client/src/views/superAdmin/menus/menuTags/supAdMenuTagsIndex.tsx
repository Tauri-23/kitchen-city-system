import { useOutletContext } from "react-router-dom";
import { useGeneralContext } from "../../../../contexts/GeneralContext";
import { SuperAdminMenuActivePageTypes } from "../supAdMenusDefault";
import { useEffect, useState } from "react";
import { MenuSubCategoryStructure } from "../../../../types/menuSubCategoryStucture";
import { fetchAllMenuSubCategories } from "../../../../services/menuSubCategoriesServices";
import { Button, Input, Popconfirm, Select, Spin, Table, TableColumnsType } from "antd";
import { MenuClassStructure } from "../../../../types/menuClassStructure";
import { fetchAllMenuClasses } from "../../../../services/menuClassesServices";
import { LuSquareCheckBig, LuSquarePen, LuTrash2 } from "react-icons/lu";
import { isEmptyOrSpaces, notify } from "../../../../assets/lib/utils";
import { MenuTagStructure } from "../../../../types/menuTagStructure";
import { GiCancel } from "react-icons/gi";
import axiosClient from "../../../../axios-client";

interface OutletContextTypes {
    setSupAdMenuActivePage: (value: SuperAdminMenuActivePageTypes) => void;
}

export default function SuperAdminMenuTagsIndex() {
    const { showModal } = useGeneralContext();
    const { setSupAdMenuActivePage } = useOutletContext<OutletContextTypes>();

    const [menuClasses, setMenuClasses] = useState<MenuClassStructure[] | null>(null);
    const [menuSubCategories, setMenuSubCategories] = useState<MenuSubCategoryStructure[] | null>(null);

    const [editMenuTagIn, setEditMenutagIn] = useState({
        id: 0,
        menu_sub_category_id: 0,
        tag: ""
    })

    const isEditMenuTagSubmitDisabled = (selectedMenuTag: MenuTagStructure) => {
        return isEmptyOrSpaces(editMenuTagIn.tag) || 
        (editMenuTagIn.tag === selectedMenuTag.tag && editMenuTagIn.menu_sub_category_id === selectedMenuTag.menu_sub_category_id)
    }



    /**
     * Onmount
     */
    useEffect(() => {
        setSupAdMenuActivePage("Menu Tags");

        const getAll = async() => {
            const [menuClassesData, menuSubCategoriesData] = await Promise.all([
                fetchAllMenuClasses(),
                fetchAllMenuSubCategories()
            ]);

            setMenuClasses(menuClassesData);
            setMenuSubCategories(menuSubCategoriesData);
        }

        getAll();
    }, []);



    /**
     * Transformed Data for Table
     */
    const transformedTagsPerCategories = menuClasses?.map((menuClass) => ({
        key: `class-${menuClass.id}`,
        id: menuClass.id,
        class: menuClass.class,
        type: "class",
        children: menuClass.menu_tags.map(tag => ({
            key: `tag-${tag.id}`,
            id: tag.id,
            class: tag.menu_class,
            subCategory: tag.sub_category,
            tag: tag.tag,
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
                if(editMenuTagIn.id === row.id && row.type === "tag") {
                    return(
                        <Input
                        size="small"
                        value={editMenuTagIn.tag}
                        onChange={(e) => setEditMenutagIn(prev => ({...prev, tag: e.target.value}))}
                        />
                    )
                }

                return row.type === "class" ? row.class : row.tag
            },
            onCell: (row) => ({
                style: {
                    backgroundColor: row.type === "class" ? 'orange' : undefined,
                    alignItems: row.type === "tag" ? "center": undefined,
                    display: row.type === "tag" ? "flex": undefined
                },
                colSpan: row.type === "class" ? 2 : 1
            }),
            width: "60%"
        },
        {
            title: "Sub Category",
            render: (_, row) => {
                if(editMenuTagIn.id === row.id && row.type === "tag") {
                    return(
                        <Select
                        size="small"
                        className="w-100"
                        options={menuSubCategories?.map(item => ({label: item.sub_category, value: item.id}))}
                        value={editMenuTagIn.menu_sub_category_id}
                        onChange={(val) => setEditMenutagIn(prev => ({...prev, menu_sub_category_id: val}))}
                        showSearch
                        filterOption={(input, option) =>
                            (option?.label ?? "")
                                .toString()
                                .toLowerCase()
                                .includes(input.toLowerCase())
                        }
                        />
                    )
                }

                return row.type === "tag" ? row.subCategory.sub_category : ""
            },
            onCell: (row) => ({
                colSpan: row.type === "class" ? 0 : 1
            })
        },
        {
            title: "Actions",
            render: (_, row) => {
                if(row.type === "class") {
                    return (
                        <Button
                        size="small"
                        onClick={() => handleAddMenuTag(row)}>
                            Add Menu Tag
                        </Button>
                    )
                }

                if(row.type === "tag") {
                    return(
                        <div className="d-flex gap3">
                            {editMenuTagIn.id === row.id
                            ? (
                                <>
                                    <Button
                                        size="small"
                                        icon={<LuSquareCheckBig />}
                                        color="green"
                                        variant="solid"
                                        disabled={isEditMenuTagSubmitDisabled(row)}
                                        onClick={handleEditMenuTag}
                                    />
                                    <Button
                                        size="small"
                                        icon={<GiCancel />}
                                        onClick={() => setEditMenutagIn({ id: 0, menu_sub_category_id: 0, tag: "" })}
                                    />
                                </>
                            )
                            : (
                                <>
                                    <Button
                                    size="small"
                                    icon={<LuSquarePen />}
                                    onClick={() => setEditMenutagIn({ id: row.id, menu_sub_category_id: row.subCategory.id, tag: row.tag })}
                                    color="blue"
                                    variant="solid"
                                    />

                                    <Popconfirm
                                        title="Delete this tag"
                                        onConfirm={() => handleDeleteMenuTag(row.id)}
                                    >
                                        <Button
                                        size="small"
                                        icon={<LuTrash2 />}
                                        color="red"
                                        variant="solid"
                                        />
                                    </Popconfirm>
                                </>
                            )}
                        </div>
                    )
                }
            },
            onCell: (row) => ({
                style: {
                    backgroundColor: row.type === "class" ? 'orange' : undefined,
                },
            }),
            width: 200
        }
    ]



    /**
     * Handlers
     */
    const handleAddMenuTag = (menuClass: MenuClassStructure) => {
        showModal("SuperAdminAddMenuTagModal", {
            menuSubCategories, 
            menuClass, 
            setMenuClasses
        });
    }

    const handleEditMenuTag = () => {
        const formData = new FormData();
        formData.append("editMenuTagIn", JSON.stringify(editMenuTagIn));

        axiosClient.post("/update-menu-tag", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);
            if(data.status === 200) {
                setMenuClasses(data.updated_menu_classes);
                setEditMenutagIn({
                    id: 0,
                    menu_sub_category_id: 0,
                    tag: ""
                })
            }
        })
        .catch(error => {
            console.error(error);
            notify("error", "Server Error", "top-center", 3000);
        })
    }

    const handleDeleteMenuTag = (id: number) => {
        const formData = new FormData();
        formData.append("id", String(id));

        axiosClient.post("/delete-menu-tag", formData)
        .then(async ({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);

            if(data.status === 200) {
                setMenuClasses((prev) => {
                    if (!prev) return prev;

                    const updated = prev.map(menuClassPrev => ({
                        ...menuClassPrev,
                        menu_tags: menuClassPrev.menu_tags.filter(menuTag => menuTag.id !== id)
                    }));

                    return updated;
                });
            }
        })
        .catch(error => {
            console.error(error);
            notify("error", "Server Error", "top-center", 3000);
        })
    }



    /**
     * Render
     */
    return(
        <>
            <h3 className="mar-bottom-1 fw-bold">Menu Tags</h3>

            {!menuClasses || !menuSubCategories
            ? (<Spin size="large"/>)
            : (
                <>
                    <Table
                    size="small"
                    columns={menuTagsColumns}
                    dataSource={transformedTagsPerCategories}
                    pagination={false}
                    bordered/>
                </>
            )}
        </>
    )
}