import { Button, Modal } from "antd";
import { useState } from "react";
import { formatToPhilPeso, notify } from "../../assets/lib/utils";
import Table, { ColumnsType as TableColumnsType } from "antd/es/table";
import axiosClient from "../../axios-client";
import { useLoggedUserContext } from "../../contexts/LoggedUserContext";
import { SelectedMenusType } from "../../views/branchManager/orders/braManAddOrder";

interface BranchManagerOrderCheckoutModalTypes {
    selectedMenusIn: SelectedMenusType[];
    onSuccess: () => void;
    onClose: () => void;
}

const BranchManagerOrderCheckoutModal: React.FC<BranchManagerOrderCheckoutModalTypes> = ({selectedMenusIn, onSuccess, onClose}) => {
    const { user } = useLoggedUserContext();

    const [isSubmitLoading, setIsSubmitLoading] = useState<boolean>(false);

    const totalCost = selectedMenusIn.reduce((sum, dish) => {
        return sum + (dish.qty_selected * dish.menu_dish.srp);
    }, 0);



    /**
     * Setup Columns
     */
    const orderCols: TableColumnsType<SelectedMenusType> = [
        {
            title: "System Description",
            render: (_, row) => row.menu_dish.system_description
        },
        {
            title: "Category",
            render: (_, row) => row.menu_dish.menu_category.category
        },
        {
            title: "Unit Cost",
            render: (_, row) => formatToPhilPeso(row.menu_dish.unit_cost)
        },
        {
            title: "Production",
            render: (_, row) => row.menu_dish.production?.production || "N/A"
        },
        {
            title: "Order Price",
            render: (_, row) => formatToPhilPeso(row.qty_selected * row.menu_dish.unit_cost)
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
            formData.append("selectedMenusIn", JSON.stringify(selectedMenusIn));
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
                dataSource={selectedMenusIn.map((dish, index) => ({...dish, key: index}))}
                bordered
                />

                <h5>Total Cost: {formatToPhilPeso(totalCost)}</h5>
            </div>

        </Modal>
    )
}

export default BranchManagerOrderCheckoutModal;