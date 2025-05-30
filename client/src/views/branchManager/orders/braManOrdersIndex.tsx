import { useEffect, useState } from "react";
import { useBranchManagerContext } from "../../../contexts/BranchManagerContext"
import { Button, Input, Table, TableColumnsType, Tag } from "antd";
import { useNavigate } from "react-router-dom";
import { fetchAllOrdersWith } from "../../../services/ordersServices";
import { OrderStructure } from "../../../types/orderSturcture";
import { formatToPhilPeso } from "../../../assets/lib/utils";

export default function BranchManagerOrdersIndex() {
    const { setActiveSideNavLink } = useBranchManagerContext();

    const [orders, setOrders] = useState<OrderStructure[] | null>(null);

    const {Search} = Input;
    const navigate = useNavigate();
    const statusColors = {
        Open: "blue",
        Pending: "orange",
        Completed: "green",
        Cancelled: "red",
    }



    /**
     * Oumount
     */
    useEffect(() => {
        setActiveSideNavLink("Orders");

        const getAll = async() => {
            const data = await fetchAllOrdersWith(["order_items"]);
            setOrders(data);
        }

        getAll();
    }, []);



    /**
     * Setup Columns
     */
    const orderColumns: TableColumnsType<OrderStructure> = [
        {
            title: "Order ID",
            dataIndex: "id"
        },
        {
            title: "Dishes Ordered",
            render: (_, row) => `${row.order_items.length} Dishes`
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
     * Handlers
     */
    const handleSearch = (val: string) => {
        console.log(val);
    }



    /**
     * Render
     */
    return (
        <div className="content1 compressed">
            <h3 className="fw-bold mar-bottom-1">Orders</h3>

            <div className="d-flex align-items-center justify-content-between mar-bottom-1">
                <Search 
                size="large"
                placeholder="input search text" 
                onSearch={handleSearch} enterButton
                style={{width: 300}} 
                />

                <Button
                size="large"
                type="primary"
                onClick={() => navigate("/KCBranchManager/AddOrder")}>
                    Add Orders
                </Button>
            </div>

            <Table
            columns={orderColumns}
            loading={!orders}
            dataSource={orders?.map((item, index) => ({...item, key: index}))}
            bordered
            onRow={(row) => ({
                onDoubleClick: () => navigate(`../ViewOrder/${row.id}`)
            })}/>
            
        </div>
    )
}
