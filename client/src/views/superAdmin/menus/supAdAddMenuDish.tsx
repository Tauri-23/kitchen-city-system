import { ChangeEvent, FormEvent, useEffect, useState } from "react";
import { useSuperAdminContext } from "../../../contexts/SuperAdminContext"
import { Breadcrumb, Button, Checkbox, Input, InputNumber, Select, Spin, Upload, UploadFile, UploadProps } from "antd";
import { Link, useParams } from "react-router-dom";
import { MenuStructure } from "../../../types/menuStructure";
import { fetchMenuById } from "../../../services/menusServices";
import { MenuDishesCategoryStructure } from "../../../types/menuDishesCategoryStucture";
import { fetchAllMenuDishesCategories } from "../../../services/menuDishesCategoriesServices";
import { isEmptyOrSpaces, notify } from "../../../assets/lib/utils";
import axiosClient from "../../../axios-client";
import { InboxOutlined } from '@ant-design/icons';
import * as XLSX from 'xlsx';

export default function SuperAdminAddMenuDish() {
    const { setActiveSideNavLink } = useSuperAdminContext();
    const [menu, setMenu] = useState<MenuStructure | null>(null);
    const [categories, setCategories] = useState<MenuDishesCategoryStructure[] | null>(null);
    const productions = ["Commis", "Commis Cooked", "On Site"];

    const [menuDishIn, setMenuDishIn] = useState({
        name: "",
        odooName: "",
        categoryId: "",
        unitCost: 1,
        production: "",
    });

    const param = useParams();
    const isSubmitDisabled = isEmptyOrSpaces(menuDishIn.name) || isEmptyOrSpaces(menuDishIn.odooName) || menuDishIn.production === "";

    const [isUploadExcelFile, setIsUploadExcelFile] = useState<boolean>(false);
    const [fileList, setFileList] = useState<UploadFile[]>([]);
    const [excelData, setExcelData] = useState<object[] | null>(null);

    const { Dragger } = Upload;



    /**
     * Onmount
     */
    useEffect(() => {
        setActiveSideNavLink("Menus");

        const getAll = async() => {
            const [menuData, categoryData] = await Promise.all([
                fetchMenuById(String(param.menuId)),
                fetchAllMenuDishesCategories()
            ]);
            setMenu(menuData);
            setCategories(categoryData);
        }
        
        getAll();
    }, []);



    /**
     * Props for Upload Excel File
     */
    const excelUploadProps: UploadProps = {
        name: 'file',
        multiple: false,
        accept: '.xls,.xlsx',
        fileList,
        customRequest: ({ onSuccess }) => {
            setTimeout(() => {
                onSuccess?.("ok");
            }, 0);
        },
        beforeUpload(file) {
            const isExcel =
              file.type ===
                "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" ||
              file.type === "application/vnd.ms-excel";
      
            if (!isExcel) {
              notify("error", "Only Excel files are allowed (.xls, .xlsx)!", "top-center", 3000);
              return Upload.LIST_IGNORE;
            }
      
            if (fileList.length >= 1) {
              notify("error", "You can only upload one file.", "top-center", 3000);
              return Upload.LIST_IGNORE;
            }
      
            return true;
        },
        onChange(info) {
            const newFileList = info.fileList.slice(-1); // keep only the last one
            setFileList(newFileList);
      
            const file = info.file.originFileObj;
            if (!file) return;
      
            const reader = new FileReader();
            reader.onload = (e) => {
                const data = new Uint8Array(e.target?.result as ArrayBuffer);
                const workbook = XLSX.read(data, { type: "array" });
        
                const firstSheetName = workbook.SheetNames[0];
                const worksheet = workbook.Sheets[firstSheetName];
        
                const jsonData = XLSX.utils.sheet_to_json(worksheet);
                setExcelData(jsonData as object[]);
            };
            reader.readAsArrayBuffer(file);
        },
        onRemove() {
            setFileList([]);
            setExcelData(null);
        }
    };



    /**
     * Handlers
     */
    const handleInputChange = (e: ChangeEvent<HTMLInputElement>) => {
        setMenuDishIn(prev => ({...prev, [e.target.name]: e.target.value}));
    }

    const clearFields = () => {
        setMenuDishIn({
            name: "",
            odooName: "",
            categoryId: "",
            unitCost: 1,
            production: "",
        });
    }

    const handleSubmit = (e: FormEvent<HTMLFormElement>) => {
        e.preventDefault();

        if(menu)
        {
            const formData = new FormData();
            formData.append("menuDishIn", JSON.stringify(menuDishIn));
            formData.append("menuId", menu.id);

            axiosClient.post("/create-menu-dish", formData)
            .then(({data}) => {
                if(data.status === 200) {
                    clearFields();
                }
                notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);
            })
            .catch((error) => {
                console.error(error);
                notify("error", "Server Error", "top-center", 3000);
            })
        }
    }



    /**
     * Render
     */
    return(
        <div className="content1 compressed">
            {!menu || !categories 
            ? (
                <Spin size="large"/>
            )
            : (
                Object.keys(menu).length === 0
                ? (
                    <>
                        <h3 className="mar-bottom-1">Invalid Menu</h3>
                        <Button
                        type="primary"
                        ghost
                        href="../Menus"
                        >
                            Return to Menus
                        </Button>
                    </>
                )
                : (
                    <>
                        <Breadcrumb
                        className="mar-bottom-1 text-m2"
                        items={[
                            {
                                title: <Link to={`/KCSuperAdmin/Menus`}>Menus</Link>,
                            },
                            {
                                title: <Link to={`/KCSuperAdmin/ViewMenu/${menu.id}`}>{menu.menu_name}</Link>,
                            },
                            {
                                title: "Add Menu Dish",
                            },
                        ]}
                        />

                        <h3 className="fw-bold mar-bottom-1">Add Dish</h3>

                        <Checkbox 
                        className="text-m1 mar-bottom-1"
                        onChange={(e) => setIsUploadExcelFile(e.target.checked)}>
                            Upload Excel File Instead
                        </Checkbox>

                        {/* FORM */}
                        {!isUploadExcelFile && (
                            <form 
                            style={{width: 500}}
                            onSubmit={handleSubmit}>
                                {/* Dish Name */}
                                <div className="mar-bottom-2">
                                    <label htmlFor="name" className="mar-bottom-4">Dish Name</label>
                                    <Input
                                    size="large"
                                    id="name"
                                    name="name"
                                    placeholder="e.g. Dish 1"
                                    value={menuDishIn.name}
                                    onChange={handleInputChange}/>
                                </div>
    
                                {/* Odoo Name */}
                                <div className="mar-bottom-2">
                                    <label htmlFor="odooName" className="mar-bottom-4">Odoo Name</label>
                                    <Input
                                    size="large"
                                    id="odooName"
                                    name="odooName"
                                    placeholder="e.g. Dish 1"
                                    value={menuDishIn.odooName}
                                    onChange={handleInputChange}/>
                                </div>
    
                                {/* Category */}
                                <div className="mar-bottom-2 d-flex flex-direction-y">
                                    <label htmlFor="categoryId" className="mar-bottom-4">Category</label>
                                    <Select
                                    size="large"
                                    id="categoryId"
                                    value={menuDishIn.categoryId}
                                    onChange={(val) => handleInputChange({target: {name: "categoryId", value: val}} as any)}
                                    options={[
                                        {label: "Select category", value: ""},
                                        ...categories.map((category) => ({label: category.category, value: category.id}))
                                    ]}
                                    />
                                </div>
    
                                {/* Unit Cost */}
                                <div className="mar-bottom-2 d-flex flex-direction-y">
                                    <label htmlFor="unitCost" className="mar-bottom-4">Unit Cost</label>
                                    <InputNumber
                                    size="large"
                                    id="unitCost"
                                    name="unitCost"
                                    className="w-100"
                                    min={1}
                                    value={menuDishIn.unitCost}
                                    onChange={(val) => handleInputChange({target: {name: "unitCost", value: val}} as any)}/>
                                </div>
    
                                {/* Production */}
                                <div className="mar-bottom-1 d-flex flex-direction-y">
                                    <label htmlFor="production" className="mar-bottom-4">Production</label>
                                    <Select
                                    size="large"
                                    id="production"
                                    value={menuDishIn.production}
                                    onChange={(val) => handleInputChange({target: {name: "production", value: val}} as any)}
                                    options={[
                                        {label: "Select production", value: ""},
                                        ...productions.map((production) => ({label: production, value: production}))
                                    ]}
                                    />
                                </div>
    
                                {/* Buttons */}
                                <div className="d-flex align-items-center gap3">
                                    <Button
                                    type="primary"
                                    size="large"
                                    htmlType="submit"
                                    disabled={isSubmitDisabled}>
                                        Add Item
                                    </Button>
    
                                    <Button
                                    type="primary"
                                    size="large"
                                    onClick={clearFields}
                                    ghost>
                                        Clear
                                    </Button>
                                </div>
                            </form>
                        )}

                        {/* Upload Excel File */}
                        {isUploadExcelFile && (
                            <>
                                <Dragger {...excelUploadProps}>
                                    <p className="ant-upload-drag-icon">
                                        <InboxOutlined />
                                    </p>
                                    <p className="ant-upload-text">Click or drag file to this area to upload</p>
                                    <p className="ant-upload-hint">
                                        You can only upload 1 excel file only !
                                    </p>
                                </Dragger>
            
                                <div className="d-flex align-items-center gap3 mar-top-1">
                                    <Button
                                    size="large"
                                    type="primary"
                                    ghost
                                    onClick={() => {setFileList([]); setExcelData(null)}}>
                                        Clear Input
                                    </Button>
            
                                    <Button
                                    size="large"
                                    type="primary"
                                    // onClick={handleAddViaExcel}
                                    disabled={!excelData || fileList.length < 1}>
                                        Add Menu
                                    </Button>
                                </div>
                            </>
                        )}
                    </>
                )
            )}
        </div>
    )
}