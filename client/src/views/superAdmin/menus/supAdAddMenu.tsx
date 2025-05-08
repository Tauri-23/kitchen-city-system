import { Breadcrumb, Button, Checkbox, Input, Select, Upload, UploadFile, UploadProps } from "antd";
import { ChangeEvent, FormEvent, useEffect, useState } from "react";
import { useSuperAdminContext } from "../../../contexts/SuperAdminContext";
import axiosClient from "../../../axios-client";
import { isEmptyOrSpaces, notify } from "../../../assets/lib/utils";
import { Link } from "react-router-dom";
import { InboxOutlined } from '@ant-design/icons';
import * as XLSX from 'xlsx';

export default function SuperAdminAddMenu() {
    const { setActiveSideNavLink } = useSuperAdminContext();

    const menuDays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    const mealTypes = ["Breakfast", "Lunch", "Snack", "Dinner", "Midnight Lunch", "Midnight Snack"];
    const menuSizes = ["XL", "Large", "Medium", "Medium Frying", "Small", "Small Frying"];

    const [menuIn, setMenuIn] = useState({
        menuName: "",
        menuWeek: "",
        menuDay: "",
        mealType: "",
        menuSize: "",
    });

    const isSubmitDisabled = isEmptyOrSpaces(menuIn.menuName) || menuIn.menuWeek === "" || 
    isEmptyOrSpaces(menuIn.menuDay) || isEmptyOrSpaces(menuIn.mealType) || isEmptyOrSpaces(menuIn.menuSize);
    
    const [isUploadExcelFile, setIsUploadExcelFile] = useState<boolean>(false);
    const [fileList, setFileList] = useState<UploadFile[]>([]);
    const [excelData, setExcelData] = useState<object[] | null>(null);

    const { Dragger } = Upload;



    /**
     * Onmount
     */
    useEffect(() => {
        setActiveSideNavLink("Menus");
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
        setMenuIn(prev => ({...prev, [e.target.name]: e.target.value}));
    }

    const clearFields = () => {
        setMenuIn({
            menuName: "",
            menuWeek: "",
            menuDay: "",
            mealType: "",
            menuSize: "",
        });
    }

    const handleSubmit = (e: FormEvent<HTMLFormElement>) => {
        e.preventDefault();
        
        const formData = new FormData();
        formData.append("menuIn", JSON.stringify(menuIn));

        axiosClient.post("/create-menus", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);

            if(data.status === 200) {
                clearFields();
            }
        })
        .catch((error) => {
            console.error(error);
            notify("error", "Server Error", "top-center", 3000);
        });
    }

    const handleAddViaExcel = () => {
        const formData = new FormData();
        formData.append("excelData", JSON.stringify(excelData));

        axiosClient.post("/create-menus-via-excel", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);

            if(data.status === 200) {
                clearFields();
            }
        })
        .catch((error) => {
            console.error(error);
            notify("error", "Server Error", "top-center", 3000);
        });
    }



    /**
     * Render
     */
    return(
        <div className="content1 compressed">
            <Breadcrumb
            className="mar-bottom-1 text-m2"
            items={[
                {
                  title: <Link to={`/KCSuperAdmin/Menus`}>Menus</Link>,
                },
                {
                  title: "Add Menu",
                },
            ]}
            />

            <h3 className="fw-bold mar-bottom-1">Add Menu</h3>

            <Checkbox 
            className="text-m1 mar-bottom-1"
            onChange={(e) => setIsUploadExcelFile(e.target.checked)}>
                Upload Excel File Instead
            </Checkbox>

            {/* Form */}
            {!isUploadExcelFile && (
                <form
                style={{width: 500}}
                onSubmit={handleSubmit}>
                    {/* Menu Name */}
                    <div className="mar-bottom-2">
                        <label htmlFor="menuName" className="mar-bottom-4">Menu Name</label>
                        <Input
                        size="large"
                        id="menuName"
                        name="menuName"
                        placeholder="e.g. Menu 1"
                        value={menuIn.menuName}
                        onChange={handleInputChange}/>
                    </div>
    
                    {/* Menu Week */}
                    <div className="mar-bottom-2">
                        <label htmlFor="menuWeek" className="mar-bottom-4">Menu Week</label>
                        <Select
                        size="large"
                        id="menuWeek"
                        className="w-100"
                        value={menuIn.menuWeek}
                        onChange={(val) => handleInputChange({target: {name: "menuWeek", value: val}}as any)}
                        options={[
                            {label: "Select menu day", value: ""},
                            { label: "Week 1", value: 1 },
                            { label: "Week 2", value: 2 },
                            { label: "Week 3", value: 3 },
                            { label: "Week 4", value: 4 },
                        ]}/>
                    </div>
    
                    {/* Menu Day */}
                    <div className="mar-bottom-1">
                        <label htmlFor="menuDay" className="mar-bottom-4">Menu Day</label>
    
                        <Select
                        size="large"
                        id="menuDay"
                        className="w-100"
                        value={menuIn.menuDay}
                        onChange={(val) => handleInputChange({target: {name: "menuDay", value: val}}as any)}
                        options={[
                            {label: "Select menu day", value: ""},
                            ...menuDays.map((menuDay) => ({label: menuDay, value: menuDay}))
                        ]}/>
                    </div>
    
                    {/* Meal Types */}
                    <div className="mar-bottom-1">
                        <label htmlFor="mealType" className="mar-bottom-4">Meal Type</label>
    
                        <Select
                        size="large"
                        id="mealType"
                        className="w-100"
                        value={menuIn.mealType}
                        onChange={(val) => handleInputChange({target: {name: "mealType", value: val}}as any)}
                        options={[
                            {label: "Select meal type", value: ""},
                            ...mealTypes.map((mealType) => ({label: mealType, value: mealType}))
                        ]}/>
                    </div>
    
                    {/* Menu Size */}
                    <div className="mar-bottom-1">
                        <label htmlFor="menuSize" className="mar-bottom-4">Menu Size</label>
    
                        <Select
                        size="large"
                        id="menuSize"
                        className="w-100"
                        value={menuIn.menuSize}
                        onChange={(val) => handleInputChange({target: {name: "menuSize", value: val}}as any)}
                        options={[
                            {label: "Select menu size", value: ""},
                            ...menuSizes.map((menuSize) => ({label: menuSize, value: menuSize}))
                        ]}/>
                    </div>
    
                    {/* Buttons */}
                    <div className="d-flex gap3 align-items-center">
                        <Button 
                        size="large"
                        type="primary"
                        htmlType="submit"
                        disabled={isSubmitDisabled}
                        >
                            Add Menu
                        </Button>
    
                        <Button 
                        size="large"
                        type="primary"
                        ghost
                        onClick={clearFields}
                        >
                            Clear
                        </Button>
                    </div>
                </form>
            )}

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
                        onClick={handleAddViaExcel}
                        disabled={!excelData || fileList.length < 1}>
                            Add Menu
                        </Button>
                    </div>
                </>
            )}
        </div>
    )
}