import { useEffect, useState } from "react"
import { MenuCategoryStructure } from "../../../../types/menuCategoryStructure"
import { useOutletContext } from "react-router-dom";
import { SuperAdminMenuActivePageTypes } from "../supAdMenusDefault";
import { MenuSubCategoryStructure } from "../../../../types/menuSubCategoryStucture";
import { Button, Input, Popconfirm, Spin, Table, TableColumnsType } from "antd";
import { fetchAllMenuCategories } from "../../../../services/menuCategoriesServices";
import { fetchAllMenuSubCategories } from "../../../../services/menuSubCategoriesServices";
import { LuSquareCheckBig, LuSquarePen, LuTrash2 } from "react-icons/lu";
import axiosClient from "../../../../axios-client";
import { isEmptyOrSpaces, notify } from "../../../../assets/lib/utils";
import { useGeneralContext } from "../../../../contexts/GeneralContext";
import { GiCancel } from "react-icons/gi";
import { MenuClassStructure } from "../../../../types/menuClassStructure";
import { fetchAllMenuClasses } from "../../../../services/menuClassesServices";

interface OutletContextTypes {
    setSupAdMenuActivePage: (value: SuperAdminMenuActivePageTypes) => void;
}

export default function SuperAdminMenuCategoriesSubAndClassesIndex() {
    const { showModal } = useGeneralContext();
    const { setSupAdMenuActivePage } = useOutletContext<OutletContextTypes>();

    const [menuCategories, setMenuCategories] = useState<MenuCategoryStructure[] | null>(null);
    const [menuSubCategories, setMenuSubCategories] = useState<MenuSubCategoryStructure[] | null>(null);
    const [menuClasses, setMenuClasses] = useState<MenuClassStructure[] | null>(null);

    const [editMenuCategoryIn, setEditMenuCategoryIn] = useState({
        id: 0,
        category: ""
    });

    const [editMenuClassIn, setEditMenuClassIn] = useState({
        id: 0,
        class: ""
    });



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
     * Setup table columns
     */
    const menuCategoriesColumns: TableColumnsType<MenuCategoryStructure> = [
        {
            title: "Category",
            render: (_, row) => {
                if(editMenuCategoryIn.id === row.id) {
                    return(
                        <Input
                        size="small"
                        width={"100%"}
                        value={editMenuCategoryIn.category}
                        onChange={(e) => setEditMenuCategoryIn(prev => ({...prev, category: e.target.value}))}/>
                    )
                }

                return row.category
            }
        },
        {
            title: "Actions",
            render: (_, row) => {
                return(
                    <div className="d-flex gap3">
                        {editMenuCategoryIn.id === row.id
                        ? (
                            <>
                                <Button
                                    size="small"
                                    icon={<LuSquareCheckBig />}
                                    color="green"
                                    variant="solid"
                                    disabled={isEmptyOrSpaces(editMenuCategoryIn.category) || editMenuCategoryIn.category === row.category}
                                    onClick={handleEditMenuCategory}
                                />
                                <Button
                                    size="small"
                                    icon={<GiCancel />}
                                    onClick={() => setEditMenuCategoryIn({ id: 0, category: "" })}
                                />
                            </>
                        )
                        : (
                            <>
                                <Button
                                size="small"
                                icon={<LuSquarePen />}
                                onClick={() => setEditMenuCategoryIn({ id: row.id, category: row.category })}
                                color="blue"
                                variant="solid"
                                />

                                <Popconfirm
                                    title="Delete this shift"
                                    onConfirm={() => handleDeleteMenuCategory(row.id)}
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
            },
            width: 150
        }
    ];
    
    const menuSubCategoriesColumns: TableColumnsType<MenuSubCategoryStructure> = [
        {
            title: "Category",
            dataIndex: "sub_category"
        }
    ];

    const menuClassesColumns: TableColumnsType<MenuClassStructure> = [
        {
            title: "Class",
            render: (_, row) => {
                if(editMenuClassIn.id === row.id) {
                    return(
                        <Input
                        size="small"
                        width={"100%"}
                        value={editMenuClassIn.class}
                        onChange={(e) => setEditMenuClassIn(prev => ({...prev, class: e.target.value}))}/>
                    )
                }

                return row.class
            }
        },
        {
            title: "Actions",
            render: (_, row) => {
                return(
                    <div className="d-flex gap3">
                        {editMenuClassIn.id === row.id
                        ? (
                            <>
                                <Button
                                    size="small"
                                    icon={<LuSquareCheckBig />}
                                    color="green"
                                    variant="solid"
                                    disabled={isEmptyOrSpaces(editMenuClassIn.class) || editMenuClassIn.class === row.class}
                                    onClick={handleEditMenuClass}
                                />
                                <Button
                                    size="small"
                                    icon={<GiCancel />}
                                    onClick={() => setEditMenuClassIn({ id: 0, class: "" })}
                                />
                            </>
                        )
                        : (
                            <>
                                <Button
                                size="small"
                                icon={<LuSquarePen />}
                                onClick={() => setEditMenuClassIn({ id: row.id, class: row.class })}
                                color="blue"
                                variant="solid"
                                />

                                <Popconfirm
                                    title="Delete this class"
                                    onConfirm={() => handleDeleteMenuClass(row.id)}
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
            },
            width: 150
        }
    ]


    
    /**
     * Categories Handlers
     */
    const handleAddMenuCategory = () => {
        showModal("SuperAdminAddMenuCategoryModal", {
            setMenuCategories
        })
    }

    const handleDeleteMenuCategory = (id: number) => {
        const formData = new FormData();

        formData.append("id", String(id));

        axiosClient.post("/delete-menu-category", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);

            if(data.status === 200) {
                setMenuCategories(prev => ((prev || [])?.filter(cat => cat.id !== id)));
            }
        })
        .catch(error => {
            console.error(error);
            notify("error", "Server Error", "top-center", 3000);
        });
    };

    const handleEditMenuCategory = () => {
        const formData = new FormData();
        formData.append("editMenuCategoryIn", JSON.stringify(editMenuCategoryIn));

        axiosClient.post("/update-menu-category", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);

            if(data.status === 200) {
                setMenuCategories(data.menu_categories);
                setEditMenuCategoryIn({id: 0, category: ""})
            }
        })
        .catch(error => {
            console.error(error);
            notify("error", "Server Error", "top-center", 3000);
        });
    }



    /**
     * Class Handlers
     */
    const handleAddMenuClass = () => {
        showModal("SuperAdminAddMenuClassModal", {
            setMenuClasses
        })
    }

    const handleDeleteMenuClass = (id: number) => {
        const formData = new FormData();

        formData.append("id", String(id));

        axiosClient.post("/delete-menu-class", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);

            if(data.status === 200) {
                setMenuClasses(prev => ((prev || [])?.filter(menuClass => menuClass.id !== id)));
            }
        })
        .catch(error => {
            console.error(error);
            notify("error", "Server Error", "top-center", 3000);
        });
    };

    const handleEditMenuClass = () => {
        const formData = new FormData();
        formData.append("editMenuClassIn", JSON.stringify(editMenuClassIn));

        axiosClient.post("/update-menu-class", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);

            if(data.status === 200) {
                setMenuClasses(data.menu_categories);
                setEditMenuClassIn({id: 0, class: ""})
            }
        })
        .catch(error => {
            console.error(error);
            notify("error", "Server Error", "top-center", 3000);
        });
    }



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
                    {/* Categories */}
                    <div className="d-flex align-items-center justify-content-between mar-bottom-3">
                        <h5 className="fw-bold">Categories</h5>
                        <Button
                        type="primary"
                        onClick={handleAddMenuCategory}>
                            Add Category
                        </Button>
                    </div>
                    <Table
                    className="mar-bottom-1"
                    size="small"
                    columns={menuCategoriesColumns}
                    dataSource={menuCategories.map((item, index) => ({...item, key: index}))}
                    bordered
                    pagination={{pageSize: 10}}/>



                    {/* Sub Categories */}
                    <div className="d-flex align-items-center justify-content-between mar-bottom-3">
                        <h4 className="fw-bold">Sub-Categories</h4>
                        <Button
                        type="primary">
                            Add Sub-Category
                        </Button>
                    </div>
                    <Table
                    className="mar-bottom-1"
                    size="small"
                    columns={menuSubCategoriesColumns}
                    dataSource={menuSubCategories.map((item, index) => ({...item, key: index}))}
                    bordered
                    pagination={{pageSize: 10}}/>



                    {/* Classes */}
                    <div className="d-flex align-items-center justify-content-between mar-bottom-3">
                        <h5 className="fw-bold">Classes</h5>
                        <Button
                        type="primary"
                        onClick={handleAddMenuClass}>
                            Add Class
                        </Button>
                    </div>
                    <Table
                    className="mar-bottom-1"
                    size="small"
                    columns={menuClassesColumns}
                    dataSource={menuClasses.map((item, index) => ({...item, key: index}))}
                    bordered
                    pagination={{pageSize: 10}}/>
                </>
            )}
        </>
    )
}