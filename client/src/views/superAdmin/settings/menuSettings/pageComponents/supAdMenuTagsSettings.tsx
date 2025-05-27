import { Button, Input, Popconfirm, Spin, Table, TableColumnsType } from "antd";
import { MenuTagStructure } from "../../../../../types/menuTagStructure";
import { useGeneralContext } from "../../../../../contexts/GeneralContext";
import { useState } from "react";
import { isEmptyOrSpaces, notify } from "../../../../../assets/lib/utils";
import { LuSquareCheckBig, LuSquarePen, LuTrash2 } from "react-icons/lu";
import { GiCancel } from "react-icons/gi";
import axiosClient from "../../../../../axios-client";

interface SuperAdminMenuTagSettingsTypes {
    menuTags: MenuTagStructure[] | null;
    setMenuTags: React.Dispatch<React.SetStateAction<MenuTagStructure[]>>
}

const SuperAdminMenuTagSettings: React.FC<SuperAdminMenuTagSettingsTypes> = ({menuTags, setMenuTags}) => {
    const { showModal } = useGeneralContext();
    const [editMenuTagIn, setEditMenutagIn] = useState({
        id: 0,
        tag: ""
    })

    const isEditMenuTagSubmitDisabled = (selectedMenuTag: MenuTagStructure) => {
        return isEmptyOrSpaces(editMenuTagIn.tag) || (editMenuTagIn.tag === selectedMenuTag.tag)
    }



    /**
     * Setup Columns
     */
    const menuTagsColumns: TableColumnsType<MenuTagStructure> = [
        {
            title: "Menu Tag",
            render: (_, row) => {
                if(editMenuTagIn.id === row.id) {
                    return(
                        <Input
                        size="small"
                        value={editMenuTagIn.tag}
                        onChange={(e) => setEditMenutagIn(prev => ({...prev, tag: e.target.value}))}
                        />
                    )
                }

                return row.tag
            },
            width: "90%"
        },
        {
            title: "Actions",
            render: (_, row) => {
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
                                    onClick={() => setEditMenutagIn({ id: 0, tag: "" })}
                                />
                            </>
                        )
                        : (
                            <>
                                <Button
                                size="small"
                                icon={<LuSquarePen />}
                                onClick={() => setEditMenutagIn({ id: row.id, tag: row.tag })}
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
            },
            width: "10%"
        }
    ]



    /**
     * Handlers
     */
    const handleAddMenuTag = () => {
        showModal("SuperAdminAddMenuTagModal", {
            setMenuTags
        });
    }

    const handleEditMenuTag = () => {
        const formData = new FormData();
        formData.append("editMenuTagIn", JSON.stringify(editMenuTagIn));

        axiosClient.post("/update-menu-tag", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);
            if(data.status === 200) {
                setMenuTags(data.updated_menu_tags);
                setEditMenutagIn({
                    id: 0,
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
                setMenuTags((prev) => prev.filter(tag => tag.id !== id));
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
            {!menuTags
            ? (<Spin size="large"/>)
            : (
                <div>
                    <div className="d-flex align-items-center justify-content-between mar-bottom-3">
                        <h4 className="fw-bold">Sub-Categories</h4>
                        <Button
                        type="primary"
                        onClick={handleAddMenuTag}>
                            Add Menu Tag
                        </Button>
                    </div>

                    <Table
                    size="small"
                    columns={menuTagsColumns}
                    dataSource={menuTags}
                    pagination={{pageSize: 10}}
                    bordered/>
                </div>
            )}
        </>
    );
}

export default SuperAdminMenuTagSettings;