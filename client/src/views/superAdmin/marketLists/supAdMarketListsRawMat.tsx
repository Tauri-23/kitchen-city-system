import { useOutletContext } from "react-router-dom"
import { SupAdMarketListActivePageTypes } from "./supAdMarketListsDefault";
import { useEffect, useState } from "react";
import { Button, Table, TableColumnsType } from "antd";
import { RiFileExcel2Line } from "react-icons/ri";
import MlRawmatItemStructure from "../../../types/mlRawmatItemStructure";
import { fetchAllMlRawmatItems } from "../../../services/mlRawmatItemServices";
import { formatToPhilPeso } from "../../../assets/lib/utils";

interface OutletContextTypes {
    setSupAdMarketListActivePage: (val: SupAdMarketListActivePageTypes) => void;
}

export default function SuperAdminMarketListsRawMat() {
    const { setSupAdMarketListActivePage } = useOutletContext<OutletContextTypes>();

    const [mlRawmatItems, setMlRawmatItems] = useState<MlRawmatItemStructure[] | null>(null);



    /**
     * Onmount
     */
    useEffect(() => {
        setSupAdMarketListActivePage("Raw Mat");
        
        const getAll = async() => {
            const data = await fetchAllMlRawmatItems();
            setMlRawmatItems(data);
        }

        getAll();
    }, []);



    /**
     * Setup Columns
     */
    const MlRawmatCols: TableColumnsType<MlRawmatItemStructure> = [
        {
            title: "Name",
            dataIndex: "name"
        },
        {
            title: "Category",
            render: (_, row) => row.ml_rawmat_category?.category || "N/A"
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
                <Button type="primary">Add raw mat Items</Button>
                <Button variant="solid" color="green" icon={<RiFileExcel2Line/>}>Add raw mat items (Excel)</Button>
            </div>

            <Table
            bordered
            loading={!mlRawmatItems}
            columns={MlRawmatCols}
            dataSource={mlRawmatItems || []}
            />
        </>
    )
}
