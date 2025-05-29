import { Button, Modal, UploadProps } from "antd";
import { useState } from "react";
import { notify } from "../../assets/lib/utils";
import axiosClient from "../../axios-client";
import { MenuDishStructure } from "../../types/menuDishStructure";
import Dragger from "antd/es/upload/Dragger";
import { InboxOutlined } from '@ant-design/icons';
import * as XLSX from 'xlsx';

interface SuperAdminAddMenuDishViaExcelModalTypes {
    setMenuDishes: React.Dispatch<React.SetStateAction<MenuDishStructure[] | null>>
    onClose: () => void;
}

const SuperAdminAddMenuDishViaExcelModal: React.FC<SuperAdminAddMenuDishViaExcelModalTypes> = ({setMenuDishes, onClose}) => {
    const [isAdding, setIsAdding] = useState<boolean>(false);

    const [menuDishesIn, setMenuDishesIn] = useState<MenuDishStructure[] | null>(null);



    /**
     * Handlers
     */
    const handleSubmit = () => {
        setIsAdding(true);

        const formData = new FormData();
        formData.append("menuDishesIn", JSON.stringify(menuDishesIn));

        axiosClient.post("/create-menu-dish-excel", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);

            if(data.status === 200) {
                setMenuDishes(data.menuDishes);
                onClose();
            }
        })
        .catch(error => {
            console.error(error);
            notify("error", "Server Error", "top-center", 3000);
        })
        .finally(() => {
            setIsAdding(false);
        });
    }

    const props: UploadProps = {
        name: 'file',
        multiple: false,
        accept: '.xlsx,.xls',
        customRequest: ({ onSuccess }) => {
            setTimeout(() => {
            onSuccess && onSuccess("ok");
            }, 0);
        },
        onChange(info) {
            const file = info.file.originFileObj;
            if (file) {
                const reader = new FileReader();

                reader.onload = (e) => {
                    const data = new Uint8Array(e.target!.result as ArrayBuffer);
                    const workbook = XLSX.read(data, { type: 'array' });

                    // Assuming you're reading the first sheet
                    const sheetName = workbook.SheetNames[0];
                    const worksheet = workbook.Sheets[sheetName];
                    const jsonData = XLSX.utils.sheet_to_json(worksheet);

                    // FIX THE DATA
                    const fixedData = jsonData.map((data: any) => ({
                        odoo_description: data["ODOO DESCRIPTION"]?.toString().trim() || null,
                        system_description: data["SYSTEM DESCRIPTION"]?.toString().trim() || null,
                        menu_tag: data["MENU TAG"]?.toString().trim() || null,
                        category: data["CATEGORY"]?.toString().trim() || null,
                        sub_category: data["SUB CATEGORY"]?.toString().trim() || null,
                        unit_cost: parseFloat(data["COST"]) || 0,
                        srp: parseFloat(data["SRP"]) || 0,
                        uom: data["UOM"]?.toString().trim() || null,
                        production: data["PRODUCTION"]?.toString().trim() || null,
                        odoo_code: data["ODOO CODE"]?.toString().trim() || null,
                    }));

                    setMenuDishesIn(fixedData as unknown as MenuDishStructure[]);
                };

                reader.readAsArrayBuffer(file);
            }
        },
        onDrop(e) {
            console.log('Dropped files', e.dataTransfer.files);
        },
    };




    /**
     * Render
     */
    return(
        <Modal
        title="Add Menu Dishes"
        open={true}
        onCancel={onClose}
        footer={null}
        width={650}
        >
            <Dragger {...props}>
                <p className="ant-upload-drag-icon">
                    <InboxOutlined />
                </p>
                <p className="ant-upload-text">Click or drag file to this area to upload</p>
                <p className="ant-upload-hint">
                    Upload 1 excel file only
                </p>
            </Dragger>
            
            <div className="d-flex justify-content-end mar-top-1">
                <Button
                type="primary"
                onClick={handleSubmit}
                disabled={!menuDishesIn}
                loading={isAdding}
                >
                    Submit
                </Button>
            </div>
            
        </Modal>
    )
}

export default SuperAdminAddMenuDishViaExcelModal;