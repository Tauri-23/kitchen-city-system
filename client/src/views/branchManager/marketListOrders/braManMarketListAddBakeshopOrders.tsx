import { Breadcrumb, Button, Table, TableColumnsType } from "antd";
import { Link, useNavigate } from "react-router-dom";
import { useLoggedUserContext } from "../../../contexts/LoggedUserContext";
import { useBranchManagerContext } from "../../../contexts/BranchManagerContext";
import { useEffect, useState } from "react";
import MlBakeshopItemStructure from "../../../types/mlBakeshopItemStructure";
import { fetchAllMlBakeshopItems } from "../../../services/mlBakeshopItemServices";
import { formatToPhilPeso } from "../../../assets/lib/utils";
import BranchManagerAddBakeshopOrderQtyInput from "./components/braManAddBakeshopOrderQtyInput";
import { useGeneralContext } from "../../../contexts/GeneralContext";

export type SelectedBakeshopItemsInType = {
    ml_bakeshop_item_id: string;
    ml_bakeshop_item: MlBakeshopItemStructure;
    qty_selected: number;
};

export default function BranchManagerMarketListAddBakeshopOrders() {
    const { user } = useLoggedUserContext();
    const { showModal } = useGeneralContext();

    const navigate = useNavigate();

    const { setActiveSideNavLink } = useBranchManagerContext();

    const [bakeshopItems, setBakeshopItems] = useState<MlBakeshopItemStructure[] | null>(null);
    const [selectedBakeshopItemsIn, setSelectedBakeshopItemsIn] = useState<SelectedBakeshopItemsInType[]>([]);



    /**
     * Onmount
     */
    useEffect(() => {
        setActiveSideNavLink("Market Lists Orders");

        const getAll = async() => {
            const [bakeshopItemsData] = await Promise.all([
                fetchAllMlBakeshopItems()
            ]);
            setBakeshopItems(bakeshopItemsData);
            setSelectedBakeshopItemsIn(bakeshopItemsData.map((bakeshop: MlBakeshopItemStructure) => ({
                ml_bakeshop_item_id: bakeshop.id,
                ml_bakeshop_item: bakeshop,
                qty_selected: 0
            })));
        }

        getAll();
    }, []);

 

    /**
     * Columns
     */
    const addBakeshopOrderColumn: TableColumnsType<SelectedBakeshopItemsInType> = [
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
            title: "QTY Ordered",
            render: (_, row) => {
                return <BranchManagerAddBakeshopOrderQtyInput 
                row={row} 
                setSelectedBakeshopItemsIn={setSelectedBakeshopItemsIn as React.Dispatch<React.SetStateAction<SelectedBakeshopItemsInType[]>>} 
                />;
            },
            width: 100,
        }
    ]


    /**
     * Handlers
     */
    const handleCheckout = () => {
        showModal("BranchManagerMlBakeshopOrderCheckoutModal", {
            selectedBakeshopItemsIn: selectedBakeshopItemsIn.filter(x => x.qty_selected > 0),
            onSuccess: () => navigate("/KCBranchManager/MarketListsOrders")
        })
    }



    /**
     * Render
     */
    return (
        <div className="content1 compressed">
            <div className="d-flex justify-content-between align-items-center">
                <Breadcrumb
                className="mar-bottom-1 text-m1 fw-bold"
                items={[
                    {
                        title: <Link to={`/KCBranchManager/MarketListsOrders`}>Bakeshop</Link>,
                    },
                    {
                        title: `Add Order / ${user?.branch?.size || ""}`,
                    },
                ]}
                />

                <p 
                style={{color: "red"}}
                className="text-m1">Ordering start date (date) - Ordering end date (date)</p>
            </div>

            <div className="d-flex align-items-center justify-content-end mar-bottom-1">
                <Button
                size="large"
                type="primary"
                disabled={!selectedBakeshopItemsIn || selectedBakeshopItemsIn.filter(x => x.qty_selected > 0).length < 1}
                onClick={handleCheckout}>
                    Proceed Checkout
                </Button>
            </div>

            <Table
            columns={addBakeshopOrderColumn}
            dataSource={selectedBakeshopItemsIn.map((dish, index) => ({...dish, key: index}))}
            size="small"
            bordered
            pagination={false}
            loading={!bakeshopItems}
            />
        </div>
    )
}
