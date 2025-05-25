import { useEffect, useState } from "react";
import { useBranchManagerContext } from "../../../contexts/BranchManagerContext"
import { Link, useParams } from "react-router-dom";
import { OrderStructure } from "../../../types/orderSturcture";
import { fetchOrderInformation } from "../../../services/ordersServices";
import { Breadcrumb, Spin, Table, Tag } from "antd";
import "../../../assets/css/viewOrder.css";
import { formatToPhilPeso } from "../../../assets/lib/utils";
import { ColumnsType as TableColumnsType } from "antd/es/table";
import { OrderItemStructure } from "../../../types/orderItemSturcture";

export default function BranchManagerViewOrder() {
    const { setActiveSideNavLink } = useBranchManagerContext();

    const [order, setOrder] = useState<OrderStructure | null>(null);

    const params = useParams();
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
        setActiveSideNavLink("Orders");

        const getAll = async() => {
            const data = await fetchOrderInformation(["order_items"], String(params.id));
            setOrder(data);
        }

        getAll();
    }, [params.id]);



    /**
     * Setup Columns
     */
    const orderColumns: TableColumnsType<OrderItemStructure> = [
        {
            title: "Id",
            dataIndex: "id"
        },
        {
            title: "Dish",
            render: (_, row) => `${row.menu_dish.name}`
        },
        {
            title: "Cost",
            render: (_ ,row) => formatToPhilPeso(row.unit_cost)
        },
        {
            title: "Ordered Quantity",
            render: (_, row) => `${row.qty} ${row.qty > 1 ? "pcs" : "pc"}`
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
        <div className="content1 compressed">

            <Breadcrumb
            className="mar-bottom-1 text-m2"
            items={[
                {
                  title: <Link to={`/KCBranchManager/Orders`}>Orders</Link>,
                },
                {
                  title: "View Order",
                },
            ]}
            />

            <h3 className="mar-bottom-1 fw-bold">View Order</h3>

            {!order
            ? (<Spin size="large"/>)
            : (
                <>
                    <div className="view-order-cont1 w-100 d-flex flex-direction-y gap3 mar-bottom-1">
                        <div className="d-flex align-items-center">
                            <span className="text-m1 fw-bold" style={{width: 100}}>Order ID</span>
                            <span>: {order.id}</span>
                        </div>

                        <div className="d-flex align-items-center">
                            <span className="text-m1 fw-bold" style={{width: 100}}>Total Cost</span>
                            <span>: {formatToPhilPeso(order.total_cost)}</span>
                        </div>

                        <div className="d-flex align-items-center">
                            <span className="text-m1 fw-bold" style={{width: 100}}>Status</span>
                            <span>: {order.status}</span>
                        </div>
                    </div>

                    <Table
                    columns={orderColumns}
                    dataSource={order.order_items.map((item, index) => ({...item, key: index}))}
                    bordered
                    />
                </>
            )}
        </div>
    )
}