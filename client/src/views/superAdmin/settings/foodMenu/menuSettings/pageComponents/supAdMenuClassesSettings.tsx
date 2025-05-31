import { useState } from "react";
import { isEmptyOrSpaces, notify } from "../../../../../../assets/lib/utils";
import axiosClient from "../../../../../../axios-client";
import { useGeneralContext } from "../../../../../../contexts/GeneralContext";
import { MenuClassStructure } from "../../../../../../types/menuClassStructure";
import { Button, Input, Popconfirm, Table, TableColumnsType } from "antd";
import { LuSquareCheckBig, LuSquarePen, LuTrash2 } from "react-icons/lu";
import { GiCancel } from "react-icons/gi";

interface SuperAdminMenuClassesSettingsTypes {
    menuClasses: MenuClassStructure[];
    setMenuClasses: React.Dispatch<React.SetStateAction<MenuClassStructure[]>>;
}

const SuperAdminMenuClassesSettings: React.FC<SuperAdminMenuClassesSettingsTypes> = ({menuClasses, setMenuClasses}) => {
    const { showModal } = useGeneralContext();

    const [editMenuClassIn, setEditMenuClassIn] = useState({
        id: 0,
        class: ""
    });



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
                setMenuClasses(data.menu_classes);
                setEditMenuClassIn({id: 0, class: ""})
            }
        })
        .catch(error => {
            console.error(error);
            notify("error", "Server Error", "top-center", 3000);
        });
    }



    /**
     * Setup table columns
     */
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
     * Render
     */
    return(
        <>
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
    );
}

export default SuperAdminMenuClassesSettings;