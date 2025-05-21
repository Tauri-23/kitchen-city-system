import { Breadcrumb, Checkbox, Upload, UploadFile, UploadProps } from "antd";
import { useEffect, useState } from "react";
import { useSuperAdminContext } from "../../../contexts/SuperAdminContext";
import { notify } from "../../../assets/lib/utils";
import { Link } from "react-router-dom";
import * as XLSX from 'xlsx';

export default function SuperAdminAddMenu() {
    const { setActiveSideNavLink } = useSuperAdminContext();

    const menuDays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    const mealTypes = ["Breakfast", "Lunch", "Snack", "Dinner", "Midnight Lunch", "Midnight Snack"];
    const menuSizes = ["XL", "Large", "Medium", "Medium Frying", "Small", "Small Frying"];
    
    const [isUploadExcelFile, setIsUploadExcelFile] = useState<boolean>(false);
    const [fileList, setFileList] = useState<UploadFile[]>([]);
    const [excelData, setExcelData] = useState<object[] | null>(null);



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
            {/* {!isUploadExcelFile && (
                
            )} */}
        </div>
    )
}