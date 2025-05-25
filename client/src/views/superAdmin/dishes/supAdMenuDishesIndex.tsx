import { useEffect, useState } from "react"
import { fetchAllMenuDishes } from "../../../services/menuDishesServices";
import { MenuDishStructure } from "../../../types/menuDishStructure";
import { Button, Input, InputNumber, Popconfirm, Select, Spin, Table, TableColumnsType } from "antd";
import { useGeneralContext } from "../../../contexts/GeneralContext";
import { formatToPhilPeso, isEmptyOrSpaces, notify } from "../../../assets/lib/utils";
import { LuSquareCheckBig, LuSquarePen, LuTrash2 } from "react-icons/lu";
import { GiCancel } from "react-icons/gi";
import { MenuSubCategoryStructure } from "../../../types/menuSubCategoryStucture";
import { fetchAllMenuSubCategories } from "../../../services/menuSubCategoriesServices";
import { fetchAllMenuCategories } from "../../../services/menuCategoriesServices";
import { MenuCategoryStructure } from "../../../types/menuCategoryStructure";
import { fetchAllMenuClasses } from "../../../services/menuClassesServices";
import { MenuClassStructure } from "../../../types/menuClassStructure";
import axiosClient from "../../../axios-client";
import { useSuperAdminContext } from "../../../contexts/SuperAdminContext";

export default function SuperAdminMenuDishesIndex() {
    const { showModal } = useGeneralContext();
    const { setActiveSideNavLink } = useSuperAdminContext();
    
    const [menuDishes, setMenuDishes] = useState<MenuDishStructure[] | null>(null);
    const [menuClasses, setMenuClasses] = useState<MenuClassStructure[] | null>(null);
    const [menuCategories, setMenuCategories] = useState<MenuCategoryStructure[] | null>(null);
    const [menuSubCategories, setMenuSubCategories] = useState<MenuSubCategoryStructure[] | null>(null);

    const [selectedCategory, setSelectedCategory] = useState<string | number>("");
    const [selectedSubCategory, setSelectedSubCategory] = useState<string | number>("");

    const productionTypes = ["Commis", "Commis Cooked", "On Site"];

    const [editMenuDishIn, setEditMenuDishIn] = useState({
        id: "",
        name: "",
        menu_class_id: 0,
        menu_category_id: 0,
        menu_sub_category_id: 0,
        unit_cost: 0,
        production: "",
        status: "",
    });

    const isSaveEditMenuDishDisabled = (selectedMenuDish: MenuDishStructure) => {
        return  isEmptyOrSpaces(editMenuDishIn.name) || editMenuDishIn.production === "" || editMenuDishIn.menu_sub_category_id === 0 ||
        (
            editMenuDishIn.name === selectedMenuDish.name && editMenuDishIn.production === selectedMenuDish.production &&
            editMenuDishIn.unit_cost === selectedMenuDish.unit_cost && editMenuDishIn.status === selectedMenuDish.status &&
            editMenuDishIn.menu_sub_category_id === selectedMenuDish.menu_sub_category_id
        )
    };



    /**
     * Onmount
     */
    useEffect(() => {
        setActiveSideNavLink("Dishes");

        const getAll = async() => {
            const [menuDishesData, menuClassesData, menuCategoriesData, menuSubCatData] = await Promise.all([
                fetchAllMenuDishes(),
                fetchAllMenuClasses(),
                fetchAllMenuCategories(),
                fetchAllMenuSubCategories()
            ]);

            setMenuDishes(menuDishesData);
            setMenuClasses(menuClassesData);
            setMenuCategories(menuCategoriesData);
            setMenuSubCategories(menuSubCatData);
        }
        getAll();
    }, []);



    /**
     * Setup table columns
     */
    const menuDishesColumns: TableColumnsType<MenuDishStructure> = [
        {
            title: "Dish Code",
            render: (_, row) => row.dish_code,
            width: 150
        },
        {
            title: "Dish Name",
            render: (_, row) => {
                if(editMenuDishIn.id === row.id) {
                    return (
                        <Input
                            size="small"
                            value={editMenuDishIn.name}
                            onChange={(e) => setEditMenuDishIn(prev => ({ ...prev, name: e.target.value }))}
                        />
                    );
                }

                return row.name
            }
        },
        {
            title: "Unit Cost",
            render: (_, row) => {
                if(editMenuDishIn.id === row.id) {
                    return (
                        <InputNumber
                        className="w-100"
                        size="small"
                        value={editMenuDishIn.unit_cost}
                        onChange={(val) => setEditMenuDishIn(prev => ({...prev, unit_cost: val as number}))}/>
                    )
                }
                return formatToPhilPeso(row.unit_cost)
            },
            width: 100
        },
        {
            title: "SRP",
            render: (_,  row) => {
                return formatToPhilPeso(row.srp)
            },
            width: 50
        },
        {
            title: "Category",
            render: (_, row) => {
                if(editMenuDishIn.id === row.id) {
                    return(
                        <Select
                        size="small"
                        className="w-100"
                        options={menuCategories?.map(category => ({label: category.category, value: category.id}))}
                        value={editMenuDishIn.menu_category_id}
                        onChange={(val) => setEditMenuDishIn(prev => ({...prev, menu_category_id: val}))}/>
                    )
                }

                return row.menu_category?.category || "N/A"
            },
            width: 200
        },
        {
            title: "Sub-Category",
            render: (_, row) => {
                if(editMenuDishIn.id === row.id) {
                    return(
                        <Select
                        size="small"
                        className="w-100"
                        options={menuSubCategories?.map(subCat => ({label: subCat.sub_category, value: subCat.id}))}
                        value={editMenuDishIn.menu_sub_category_id}
                        onChange={(val) => setEditMenuDishIn(prev => ({...prev, menu_sub_category_id: val}))}/>
                    )
                }

                return row.menu_sub_category?.sub_category || "N/A"
            },
            width: 200
        },
        {
            title: "Production",
            render: (_, row) => {
                if(editMenuDishIn.id === row.id) {
                    return(
                        <Select
                        className="w-100"
                        size="small"
                        id="production"
                        options={productionTypes.map(prod => ({label: prod, value: prod}))}
                        value={editMenuDishIn.production}
                        onChange={(val) => setEditMenuDishIn(prev => ({...prev, production: val}))}/>
                    )
                }
                return row.production
            },
            width: 180
        },
        {
            title: "Actions",
            render:(_, row) => {
                return(
                    <div className="d-flex gap3">
                        {editMenuDishIn.id === row.id
                        ? (
                            <>
                                <Button
                                size="small"
                                icon={<LuSquareCheckBig />}
                                color="green"
                                variant="solid"
                                disabled={isSaveEditMenuDishDisabled(row)}
                                onClick={handleEditMenuDishSave}
                                />
                                <Button
                                size="small"
                                    icon={<GiCancel />}
                                    onClick={() => setEditMenuDishIn({
                                        id: "",
                                        name: "",
                                        menu_class_id: 0,
                                        menu_category_id: 0,
                                        menu_sub_category_id: 0,
                                        unit_cost: 0,
                                        production: "",
                                        status: "",
                                })}
                                />
                            </>
                        )
                        : (
                            <>
                                <Button
                                size="small"
                                icon={<LuSquarePen />}
                                onClick={() => setEditMenuDishIn({
                                    id: row.id,
                                    name: row.name,
                                    menu_class_id: row.menu_class_id,
                                    menu_category_id: row.menu_category_id,
                                    menu_sub_category_id: row.menu_sub_category_id,
                                    unit_cost: row.unit_cost,
                                    production: row.production,
                                    status: row.status,
                                })}
                                color="blue"
                                variant="solid"
                                />

                                <Popconfirm
                                    title="Delete this dish"
                                    onConfirm={() => handleDeleteMenuDish(row.id)}
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
            width: 100
        }
    ];



    /**
     * Handlers
     */
    const handleAddDish = () => {
        showModal("SuperAdminAddMenuDishModal", {
            menuClasses,
            menuCategories,
            menuSubCategories,
            setMenuDishes
        })
    }

    const handleEditMenuDishSave = () => {
        const formData = new FormData();
        formData.append("editMenuDishIn", JSON.stringify(editMenuDishIn));

        axiosClient.post("/update-menu-dish", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);

            if(data.status === 200) {
                setMenuDishes(data.menuDishes);
                setEditMenuDishIn({
                    id: "",
                    name: "",
                    menu_class_id: 0,
                    menu_category_id: 0,
                    menu_sub_category_id: 0,
                    unit_cost: 0,
                    production: "",
                    status: "",
                })
            }
        })
        .catch(error => {
            console.error(error);
            notify("error", "Server Error", "top-center", 3000);
        })
    }

    const handleDeleteMenuDish = (id: string) => {
        const formData = new FormData();
        formData.append("id", id);

        axiosClient.post("/delete-menu-dish",  formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);

            if(data.status === 200) {
                setMenuDishes(prev => prev?.filter((dish: MenuDishStructure) => dish.id !== id) || []);
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
        <div className="content1 compressed">
            <h3 className="fw-bold mar-bottom-1">Dishes</h3>

            {(!menuClasses || !menuCategories || !menuSubCategories || !menuDishes)
            ? (
                <Spin size="large"/>
            )
            : (
                <>
                    <div className="d-flex align-items-center justify-content-between mar-bottom-1">
                        <div className="d-flex gap3">
                            <Select
                            style={{width: 250}}
                            size="large"
                            options={[
                                {label: "All menu categories", value: ""},
                                ...menuCategories.map(item => ({label: item.category, value: item.id}))
                            ]}
                            value={selectedCategory}
                            onChange={(val) => setSelectedCategory(val)}
                            showSearch
                            filterOption={(input, option) => 
                                (option?.label ?? "")
                                    .toString()
                                    .toLowerCase()
                                    .includes(input.toLowerCase())
                            }
                            />

                            <Select
                            style={{width: 250}}
                            size="large"
                            options={[
                                {label: "All menu sub-categories", value: ""},
                                ...menuSubCategories.map(item => ({label: item.sub_category, value: item.id}))
                            ]}
                            value={selectedSubCategory}
                            onChange={(val) => setSelectedSubCategory(val)}
                            showSearch
                            filterOption={(input, option) => 
                                (option?.label ?? "")
                                    .toString()
                                    .toLowerCase()
                                    .includes(input.toLowerCase())
                            }
                            />
                        </div>

                        <Button
                        size="large"
                        type="primary"
                        onClick={() => handleAddDish()}>
                            Add Dish
                        </Button>
                    </div>

                    <Table
                    size="small"
                    columns={menuDishesColumns}
                    dataSource={
                        menuDishes?.filter(x => 
                            (selectedCategory !== "" ? x.menu_category_id === selectedCategory : true) &&
                            (selectedSubCategory !== "" ? x.menu_sub_category_id === selectedSubCategory : true)
                        ).map((item, index) => ({...item, key: index}))}
                    bordered/>
                </>
            )}
        </div>
    )
}