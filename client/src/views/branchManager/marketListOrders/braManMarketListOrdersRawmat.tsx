import { useNavigate, useOutletContext } from "react-router-dom";
import { mlOrdersActivePageTypes } from "./braManMarketListOrdersDefault";
import { useEffect, useState } from "react";
import { Button, Table, TableColumnsType, Tag } from "antd";
import { formatToPhilPeso } from "../../../assets/lib/utils";
import { fetchAllMlRawmatOrdersWith } from "../../../services/mlRawmatOrdersServices";
import MlRawmatOrderStructure from "../../../types/mlRawmatOrderStructure";

interface OutletContextTypes {
    setMlOrdersActivePage: (val: mlOrdersActivePageTypes) => void
}

export default function BranchManagerMarketListOrdersRawmat() {
    const { setMlOrdersActivePage } = useOutletContext<OutletContextTypes>();

    const [orders, setOrders] = useState<MlRawmatOrderStructure[] | null>(null);

    const navigate = useNavigate();

    const statusColors = {
        Open: "blue",
        Pending: "orange",
        Completed: "green",
        Cancelled: "red",
    }



    /**
     * Onmount
     */
    useEffect(() => {
        setMlOrdersActivePage("Rawmat");

        const getAll = async() => {
            const data = await fetchAllMlRawmatOrdersWith(["ml_rawmat_order_items"]);
            
            setOrders(data);
        }

        getAll();
    }, []);



    /**
     * Setup Columns
     */
    const orderColumns: TableColumnsType<MlRawmatOrderStructure> = [
        {
            title: "Order ID",
            dataIndex: "id"
        },
        {
            title: "Dishes Ordered",
            render: (_, row) => `${row.ml_rawmat_order_items.length} Dishes`
        },
        {
            title: "Total Cost",
            render: (_, row) => formatToPhilPeso(row.total_cost)
        },
        {
            title: "Status",
            render: (_, row) => <Tag color={statusColors[row.status]}>{row.status}</Tag>
        },
    ]



    /**
     * Render
     */
    return (
        <>
            <div className="d-flex align-items-center justify-content-end mar-bottom-1">
                <Button
                type="primary"
                onClick={() => navigate("/KCBranchManager/AddMlRawmatOrder")}>
                    Add Rawmat Orders
                </Button>
            </div>

            <Table
            columns={orderColumns}
            loading={!orders}
            dataSource={orders?.map((item, index) => ({...item, key: index}))}
            bordered
            onRow={(row) => ({
                onDoubleClick: () => navigate(`../ViewMlRawmatOrder/${row.id}`)
            })}/>
        </>
    );
}
