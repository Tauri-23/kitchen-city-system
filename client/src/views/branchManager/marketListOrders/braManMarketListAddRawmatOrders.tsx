import { Breadcrumb, Button, Table, TableColumnsType } from "antd";
import { Link, useNavigate } from "react-router-dom";
import { useLoggedUserContext } from "../../../contexts/LoggedUserContext";
import { useBranchManagerContext } from "../../../contexts/BranchManagerContext";
import { useEffect, useState } from "react";
import { formatToPhilPeso } from "../../../assets/lib/utils";
import { useGeneralContext } from "../../../contexts/GeneralContext";
import MlRawmatItemStructure from "../../../types/mlRawmatItemStructure";
import { fetchAllMlRawmatItems } from "../../../services/mlRawmatItemServices";
import BranchManagerAddRawmatOrderQtyInput from "./components/braManAddRawmatOrderQtyInput";

export type SelectedRawmatItemsInType = {
    ml_rawmat_item_id: string;
    ml_rawmat_item: MlRawmatItemStructure;
    qty_selected: number;
};

export default function BranchManagerMarketListAddRawmatOrders() {
    const { user } = useLoggedUserContext();
    const { showModal } = useGeneralContext();

    const navigate = useNavigate();

    const { setActiveSideNavLink } = useBranchManagerContext();

    const [rawmatItems, setRawmatItems] = useState<MlRawmatItemStructure[] | null>(null);
    const [selectedRawmatItemsIn, setSelectedRawmatItemsIn] = useState<SelectedRawmatItemsInType[]>([]);



    /**
     * Onmount
     */
    useEffect(() => {
        setActiveSideNavLink("Market Lists Orders");

        const getAll = async() => {
            const [rawmatItemsData] = await Promise.all([
                fetchAllMlRawmatItems()
            ]);
            setRawmatItems(rawmatItemsData);
            setSelectedRawmatItemsIn(rawmatItemsData.map((rawmat: MlRawmatItemStructure) => ({
                ml_rawmat_item_id: rawmat.id,
                ml_rawmat_item: rawmat,
                qty_selected: 0
            })));
        }

        getAll();
    }, []);

 

    /**
     * Columns
     */
    const addRawmatOrderColumn: TableColumnsType<SelectedRawmatItemsInType> = [
        {
            title: "Name",
            render: (_, row) => row.ml_rawmat_item.name
        },
        {
            title: "Category",
            render: (_, row) => row.ml_rawmat_item.ml_rawmat_category?.category || "N/A"
        },
        {
            title: "Unit Cost",
            render: (_, row) => formatToPhilPeso(row.ml_rawmat_item.unit_cost)
        },
        {
            title: "QTY Ordered",
            render: (_, row) => {
                return <BranchManagerAddRawmatOrderQtyInput 
                row={row} 
                setSelectedRawmatItemsIn={setSelectedRawmatItemsIn as React.Dispatch<React.SetStateAction<SelectedRawmatItemsInType[]>>} 
                />;
            },
            width: 100,
        }
    ]


    /**
     * Handlers
     */
    const handleCheckout = () => {
        showModal("BranchManagerMlRawmatOrderCheckoutModal", {
            selectedRawmatItemsIn: selectedRawmatItemsIn.filter(x => x.qty_selected > 0),
            onSuccess: () => navigate("/KCBranchManager/MarketListsOrders/Rawmat")
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
                        title: <Link to={`/KCBranchManager/MarketListsOrders`}>Rawmat</Link>,
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
                disabled={!selectedRawmatItemsIn || selectedRawmatItemsIn.filter(x => x.qty_selected > 0).length < 1}
                onClick={handleCheckout}>
                    Proceed Checkout
                </Button>
            </div>

            <Table
            columns={addRawmatOrderColumn}
            dataSource={selectedRawmatItemsIn.map((dish, index) => ({...dish, key: index}))}
            size="small"
            bordered
            pagination={false}
            loading={!rawmatItems}
            />
        </div>
    )
}
