import { useOutletContext } from "react-router-dom"
import { SupAdMarketListActivePageTypes } from "./supAdMarketListsDefault";
import { useEffect } from "react";
import { Button, Table } from "antd";
import { RiFileExcel2Line } from "react-icons/ri";

interface OutletContextTypes {
    setSupAdMarketListActivePage: (val: SupAdMarketListActivePageTypes) => void;
}

export default function SuperAdminMarketListsRawMat() {
    const { setSupAdMarketListActivePage } = useOutletContext<OutletContextTypes>();



    /**
     * Onmount
     */
    useEffect(() => {
        setSupAdMarketListActivePage("Raw Mat");
    }, []);



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
            />
        </>
    )
}
