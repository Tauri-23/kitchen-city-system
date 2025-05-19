import { useEffect, useState } from "react"
import { fetchAllUniqueMenuToDishTags } from "../../../../services/menuTagsServices";
import { useOutletContext } from "react-router-dom";
import { SuperAdminMenuActivePageTypes } from "../supAdMenusDefault";
import { fetchAllMenuDishes } from "../../../../services/menuDishesServices";
import { MenuDishStructure } from "../../../../types/menuDishStructure";
import { Button, Input, InputNumber, Select, Spin, Table, TableColumnsType } from "antd";
import { useGeneralContext } from "../../../../contexts/GeneralContext";
import { formatToPhilPeso, isEmptyOrSpaces } from "../../../../assets/lib/utils";
import { LuSquareCheckBig, LuSquarePen } from "react-icons/lu";
import { GiCancel } from "react-icons/gi";
import { MenuSubCategoryStructure } from "../../../../types/menuSubCategoryStucture";
import { fetchAllMenuSubCategories } from "../../../../services/menuSubCategoriesServices";

interface OutletContextTypes {
    setSupAdMenuActivePage: (value: SuperAdminMenuActivePageTypes) => void;
}

export default function SuperAdminMenuDishesIndex() {
    const { showModal } = useGeneralContext();
    const { setSupAdMenuActivePage } = useOutletContext<OutletContextTypes>();
    
    const [uniqueMenuToDishTag, setUniqueMenuToDishTags] = useState<{value: string | any}[] | null>(null);
    const [menuDishes, setMenuDishes] = useState<MenuDishStructure[] | null>(null);
    const [menuSubCategories, setMenuSubCategories] = useState<MenuSubCategoryStructure[] | null>(null);

    const [selectedUniqueTag, setSelectedUniqueTag] = useState<string>("");

    const productionTypes = ["Commis", "Commis Cooked", "On Site"];

    const [editMenuDishIn, setEditMenuDishIn] = useState({
        id: "",
        name: "",
        sub_category_id: 0,
        unit_cost: 0,
        production: "",
        status: "",
    });

    const isSaveEditMenuDishDisabled = (selectedMenuDish: MenuDishStructure) => {
        return  isEmptyOrSpaces(editMenuDishIn.name) || editMenuDishIn.production === "" || editMenuDishIn.sub_category_id === 0 ||
        (
            editMenuDishIn.name === selectedMenuDish.name && editMenuDishIn.production === selectedMenuDish.production &&
            editMenuDishIn.unit_cost === selectedMenuDish.unit_cost && editMenuDishIn.status === selectedMenuDish.status &&
            editMenuDishIn.sub_category_id === selectedMenuDish.sub_category_id
        )
    };



    /**
     * Onmount
     */
    useEffect(() => {
        setSupAdMenuActivePage("Dishes");

        const getAll = async() => {
            const [uniqueMenuToDishTagData, menuDishesData, menuSubCatData] = await Promise.all([
                fetchAllUniqueMenuToDishTags(),
                fetchAllMenuDishes(),
                fetchAllMenuSubCategories()
            ]);

            setUniqueMenuToDishTags(uniqueMenuToDishTagData);
            setMenuDishes(menuDishesData);
            setSelectedUniqueTag(String(uniqueMenuToDishTagData[0].value));
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
            width: 200
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
            width: 200
        },
        {
            title: "Sub Category",
            render: (_, row) => {
                if(editMenuDishIn.id === row.id) {
                    return(
                        <Select
                        size="small"
                        className="w-100"
                        options={menuSubCategories?.map(subCat => ({label: subCat.sub_category, value: subCat.id}))}
                        value={editMenuDishIn.sub_category_id}
                        onChange={(val) => setEditMenuDishIn(prev => ({...prev, sub_category_id: val}))}/>
                    )
                }

                return row.sub_category?.sub_category || "N/A"
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
            width: 200
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
                                            sub_category_id: 0,
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
                                    sub_category_id: row.sub_category_id,
                                    unit_cost: row.unit_cost,
                                    production: row.production,
                                    status: row.status,
                                })}
                                color="blue"
                                variant="solid"
                                />
                            </>
                        )}
                    </div>
                )
            },
            width: 200
        }
    ];



    /**
     * Handlers
     */
    const handleAddDish = (menuToDishtag: string) => {
        showModal("SuperAdminAddMenuDishModal", {
            menuSubCategories,
            menuToDishtag,
            setMenuDishes
        })
    }

    const handleEditMenuDishSave = () => {
        
    }



    /**
     * Render
     */
    return(
        <>
            <h3 className="fw-bold mar-bottom-1">Dishes</h3>

            {!uniqueMenuToDishTag || !menuDishes
            ? (
                <Spin size="large"/>
            )
            : (
                <>
                    <div className="d-flex align-items-center justify-content-between mar-bottom-1">
                        <div className="d-flex gap3">
                            <Select
                            style={{width: 200}}
                            size="large"
                            options={uniqueMenuToDishTag.map(item => ({label: item.value, value: item.value}))}
                            value={selectedUniqueTag}
                            onChange={(val) => setSelectedUniqueTag(val)}
                            />
                        </div>

                        <Button
                        size="large"
                        type="primary"
                        onClick={() => handleAddDish(selectedUniqueTag)}>
                            Add Dish
                        </Button>
                    </div>

                    <Table
                    size="small"
                    columns={menuDishesColumns}
                    dataSource={menuDishes?.filter(x => x.menu_to_dish_tag === selectedUniqueTag).map((item, index) => ({...item, key: index}))}
                    bordered/>
                </>
            )}
        </>
    )
}