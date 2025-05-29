import { useOutletContext } from "react-router-dom"
import { SupAdMarketListActivePageTypes } from "./supAdMarketListsDefault";
import { useEffect } from "react";
import { Button, Table } from "antd";
import { RiFileExcel2Line } from "react-icons/ri";

interface OutletContextTypes {
    setSupAdMarketListActivePage: (val: SupAdMarketListActivePageTypes) => void;
}

export default function SuperAdminMarketListsBakeshop() {
    const { setSupAdMarketListActivePage } = useOutletContext<OutletContextTypes>();



    /**
     * Onmount
     */
    useEffect(() => {
        setSupAdMarketListActivePage("Bakeshop");
    }, []);



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
            />
        </>
    )
}
