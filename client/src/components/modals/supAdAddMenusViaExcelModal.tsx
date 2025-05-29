import { Button, Modal, UploadProps } from "antd";
import { useState } from "react";
import { notify } from "../../assets/lib/utils";
import axiosClient from "../../axios-client";
import Dragger from "antd/es/upload/Dragger";
import { InboxOutlined } from '@ant-design/icons';
import * as XLSX from 'xlsx';
import { MenuStructure } from "../../types/menuStructure";

interface SuperAdminAddMenusViaExcelModalTypes {
    onClose: () => void;
}

const SuperAdminAddMenusViaExcelModal: React.FC<SuperAdminAddMenusViaExcelModalTypes> = ({onClose}) => {
    const [isAdding, setIsAdding] = useState<boolean>(false);

    const [menusIn, setMenusIn] = useState<MenuStructure[] | null>(null);



    /**
     * Handlers
     */
    const handleSubmit = () => {
        setIsAdding(true);

        const formData = new FormData();
        formData.append("menusIn", JSON.stringify(menusIn));

        axiosClient.post("/create-menu-via-excel", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);

            if(data.status === 200) {
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
                        menu_week: data["WEEK"]?.toString().trim() || null,
                        menu_size: data["SIZE"]?.toString().trim() || null,
                        menu_shift: data["SHIFT"]?.toString().trim() || null,
                        menu_day: data["DAY"]?.toString().trim() || null,
                        dish_menu_tag: data["MENU TAG"]?.toString().trim() || null,
                        dish_system_desc: data["SYSTEM DESCRIPTION"]?.toString().trim() || null,
                        dish_category: data["CATEGORY"]?.toString().trim() || null,
                    }));

                    setMenusIn(fixedData as unknown as MenuStructure[]);
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
        title="Add Menus"
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
                disabled={!menusIn}
                loading={isAdding}
                >
                    Submit
                </Button>
            </div>
            
        </Modal>
    )
}

export default SuperAdminAddMenusViaExcelModal;