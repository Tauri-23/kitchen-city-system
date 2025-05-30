import { Button, Modal } from "antd";
import { useState } from "react";
import { formatToPhilPeso, notify } from "../../assets/lib/utils";
import Table, { ColumnsType as TableColumnsType } from "antd/es/table";
import axiosClient from "../../axios-client";
import { useLoggedUserContext } from "../../contexts/LoggedUserContext";
import { SelectedBakeshopItemsInType } from "../../views/branchManager/marketListOrders/braManMarketListAddBakeshopOrders";

interface BranchManagerMlBakeshopOrderCheckoutModalTypes {
    selectedBakeshopItemsIn: SelectedBakeshopItemsInType[];
    onSuccess: () => void;
    onClose: () => void;
}

const BranchManagerMlBakeshopOrderCheckoutModal: React.FC<BranchManagerMlBakeshopOrderCheckoutModalTypes> = ({
    selectedBakeshopItemsIn, 
    onSuccess, 
    onClose
}) => {
    const { user } = useLoggedUserContext();

    const [isSubmitLoading, setIsSubmitLoading] = useState<boolean>(false);

    const totalCost = selectedBakeshopItemsIn.reduce((sum, dish) => {
        return sum + (dish.qty_selected * dish.ml_bakeshop_item.unit_cost);
    }, 0);



    /**
     * Setup Columns
     */
    const orderCols: TableColumnsType<SelectedBakeshopItemsInType> = [
        {
            title: "Name",
            render: (_, row) => row.ml_bakeshop_item.name
        },
        {
            title: "Category",
            render: (_, row) => row.ml_bakeshop_item.ml_bakeshop_category?.category || "N/A"
        },
        {
            title: "Unit Cost",
            render: (_, row) => formatToPhilPeso(row.ml_bakeshop_item.unit_cost)
        },
        {
            title: "Order Price",
            render: (_, row) => formatToPhilPeso(row.qty_selected * row.ml_bakeshop_item.unit_cost)
        },
        {
            title: "QTY Ordered",
            dataIndex: "qty_selected"
        }
    ];



    /**
     * Handlers
     */
    const handleCheckout = () => {
        if(user) {
            setIsSubmitLoading(true)

            const formData = new FormData();
            formData.append("selectedBakeshopItemsIn", JSON.stringify(selectedBakeshopItemsIn));
            formData.append("branchManager", user.id);
            formData.append("totalCost", String(totalCost));

            axiosClient.post("/create-mlbakeshop-order", formData)
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
                dataSource={selectedBakeshopItemsIn.map((dish, index) => ({...dish, key: index}))}
                bordered
                />

                <h5>Total Cost: {formatToPhilPeso(totalCost)}</h5>
            </div>

        </Modal>
    )
}

export default BranchManagerMlBakeshopOrderCheckoutModal;