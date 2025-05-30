import { useOutletContext } from "react-router-dom"
import { SupAdMarketListActivePageTypes } from "./supAdMarketListsDefault";
import { useEffect, useState } from "react";
import { Button, Table, TableColumnsType } from "antd";
import { RiFileExcel2Line } from "react-icons/ri";
import MlBakeshopItemStructure from "../../../types/mlBakeshopItemStructure";
import { fetchAllMlBakeshopItems } from "../../../services/mlBakeshopItemServices";
import { formatToPhilPeso } from "../../../assets/lib/utils";

interface OutletContextTypes {
    setSupAdMarketListActivePage: (val: SupAdMarketListActivePageTypes) => void;
}

export default function SuperAdminMarketListsBakeshop() {
    const { setSupAdMarketListActivePage } = useOutletContext<OutletContextTypes>();

    const [mlBakeshopItems, setMlBakeshopItems] = useState<MlBakeshopItemStructure[] | null>(null);



    /**
     * Onmount
     */
    useEffect(() => {
        setSupAdMarketListActivePage("Bakeshop");

        const getAll = async() => {
            const data = await fetchAllMlBakeshopItems();
            setMlBakeshopItems(data);
        }

        getAll();
    }, []);



    /**
     * Setup Columns
     */
    const MlBakeshopCols: TableColumnsType<MlBakeshopItemStructure> = [
        {
            title: "Name",
            dataIndex: "name"
        },
        {
            title: "Category",
            render: (_, row) => row.ml_bakeshop_category?.category || "N/A"
        },
        {
            title: "Unit Cost",
            render: (_, row) => formatToPhilPeso(row.unit_cost)
        },
        {
            title: "SRP",
            render: (_, row) => formatToPhilPeso(row.srp)
        },
    ];



    /**
     * Render
     */
    return (
        <>
            <div className="d-flex gap3 justify-content-end mar-bottom-1">
                <Button type="primary">Add Bakeshop Items</Button>
                <Button variant="solid" color="green" icon={<RiFileExcel2Line/>}>Add Bakeshop Items (Excel)</Button>
            </div>

            <Table
            bordered
            loading={!mlBakeshopItems}
            columns={MlBakeshopCols}
            dataSource={mlBakeshopItems || []}
            />
        </>
    )
}
