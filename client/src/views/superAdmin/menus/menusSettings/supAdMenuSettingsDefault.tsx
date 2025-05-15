import { useEffect, useState } from "react";
import { useOutletContext } from "react-router-dom";
import { SuperAdminMenuActivePageTypes } from "../supAdMenusDefault";
import { MenuShiftStructure } from "../../../../types/menuShiftStructure";
import { fetchAllMenuShiftsFull } from "../../../../services/menuShiftsServices";
import { Spin, Table, TableColumnsType } from "antd";

interface OutletContextTypes {
    setSupAdMenuActivePage: (value: SuperAdminMenuActivePageTypes) => void;
}

export default function SuperAdminMenuSettingsDefault() {
    const {setSupAdMenuActivePage} = useOutletContext<OutletContextTypes>();

    const [shifts, setShifts] = useState<MenuShiftStructure[] | null>(null);



    /**
     * Onmount
     */
    useEffect(() => {
        setSupAdMenuActivePage("Menu Settings");

        const getAll = async() => {
            const [shiftsData] = await Promise.all([
                fetchAllMenuShiftsFull()
            ]);
            console.log(shiftsData.flatMap((x: MenuShiftStructure) => {
                    return [{
                        shift: x.shift,
                    }, ...x.categories.flatMap(cat => cat)]
                }))
            setShifts(shiftsData);
        }

        getAll();
    }, []);



    /**
     * Setup Columns
     */
    const menuSettingsColumns: TableColumnsType<any> = [
        {
            render: (_, row) => {
                return row.category || row.shift
            },
            onCell: (row) => ({
                style: {
                    backgroundColor: row.shift ? 'orange' : undefined,
                },
            })
        }
    ]



    /**
     * Render
     */
    return(
        <>
            <h3 className="fw-bold mar-bottom-1">Menu Settings</h3>

            {!shifts
            ? (<Spin size="large"/>)
            : (
                <>
                    <Table
                    columns={menuSettingsColumns}
                    dataSource={
                        shifts.flatMap((x: MenuShiftStructure) => {
                            return [{
                                shift: x.shift,
                            }, ...x.categories.flatMap(cat => cat)]
                        })
                    }
                    size="small"
                    bordered
                    pagination={false}
                    />

                </>
            )}
        </>
    );
}