import { Button, Modal } from "antd";
import { useState } from "react";
import { MenuDishStructure } from "../../types/menuDishStructure";
import { formatToPhilPeso, notify } from "../../assets/lib/utils";
import Table, { ColumnsType as TableColumnsType } from "antd/es/table";
import axiosClient from "../../axios-client";
import { useLoggedUserContext } from "../../contexts/LoggedUserContext";

interface BranchManagerOrderCheckoutModalTypes {
    orderedDishes: MenuDishStructure[];
    onSuccess: () => void;
    onClose: () => void;
}

const BranchManagerOrderCheckoutModal: React.FC<BranchManagerOrderCheckoutModalTypes> = ({orderedDishes, onSuccess, onClose}) => {
    const { user } = useLoggedUserContext();

    const [isSubmitLoading, setIsSubmitLoading] = useState<boolean>(false);

    const totalCost = orderedDishes.reduce((sum, dish) => {
        return sum + (dish.qtySelected * dish.unit_cost);
      }, 0);



    /**
     * Setup Columns
     */
    const orderCols: TableColumnsType<MenuDishStructure> = [
        {
            title: "Dish Name",
            dataIndex: "name"
        },
        {
            title: "Odoo Name",
            dataIndex: "odoo_name"
        },
        {
            title: "Category",
            render: (_, row) => row.category?.category
        },
        {
            title: "Unit Cost",
            render: (_, row) => formatToPhilPeso(row.unit_cost)
        },
        {
            title: "Production",
            dataIndex: "production"
        },
        {
            title: "Order Price",
            render: (_, row) => formatToPhilPeso(row.qtySelected * row.unit_cost)
        },
        {
            title: "QTY Ordered",
            dataIndex: "qtySelected"
        }
    ];



    /**
     * Handlers
     */
    const handleCheckout = () => {
        if(user) {
            setIsSubmitLoading(true)

            console.log(orderedDishes);

            const formData = new FormData();
            formData.append("orderedDishes", JSON.stringify(orderedDishes));
            formData.append("branchManager", user.id);
            formData.append("totalCost", String(totalCost));

            axiosClient.post("/create-order", formData)
            .then(({data}) => {
                notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);

                if(data.status === 200) {
                    onSuccess();
                    onClose();
                }
            })
            .catch(error => {
                console.error(error);
                notify("error", "Server Error", "top-center", 3000);
            })
            .finally(() => {
                setIsSubmitLoading(false);
            });
        }
    }



    /**
     * Render
     */
    return(
        <Modal
        title="Order Confirmation"
        open={true}
        onCancel={onClose}
        footer={(_, { CancelBtn }) => (
            <>
                <CancelBtn />

                <Button 
                type="primary"
                htmlType="submit"
                loading={isSubmitLoading}
                onClick={handleCheckout}
                >
                    Checkout
                </Button>
            </>
        )}
        width={"70%"}
        >
            <div className="mar-y-1">
                <h3>Order Details</h3>

                <Table
                columns={orderCols}
                dataSource={orderedDishes.map((dish, index) => ({...dish, key: index}))}
                bordered
                />

                <h5>Total Cost: {formatToPhilPeso(totalCost)}</h5>
            </div>

        </Modal>
    )
}

export default BranchManagerOrderCheckoutModal;