import { useEffect, useState } from "react";
import { useSuperAdminContext } from "../../contexts/SuperAdminContext";
import { Button, DatePicker, Select, Spin } from "antd";
import { BranchStructure } from "../../types/branchStructure";
import LineChart from "../../components/charts/LineChart";
import { ChartData, ChartOptions } from "chart.js";
import { fetchAllBranches } from "../../services/branchServices";
import BarChart from "../../components/charts/BarChart";

export default function SuperAdminIndex() {
    const { setActiveSideNavLink } = useSuperAdminContext();

    const [branches, setBranches] = useState<BranchStructure[] | null>(null);

    const [selectedBranch, setSelectedBranch] = useState<BranchStructure | null>(null);

    const {RangePicker} = DatePicker;



    /**
     * Onmount
     */
    useEffect(() => {
        setActiveSideNavLink("Dashboard");
        const getAll = async() => {
            const [branchesData] = await Promise.all([
                fetchAllBranches()
            ]);

            setBranches(branchesData);
        }

        getAll();
    }, []);



    /**
     * Setup Charts Data
     */
    const ordersPerBranchChartData: ChartData<'bar'> = {
        labels: branches?.map(branch => `${branch.name} (${branch.address})`),
        datasets: [
            {
            label: 'Orders',
            data: [500, 1000],
            borderColor: '#4BC0C0',
            backgroundColor: 'rgba(75, 192, 192, 0.2)',
            },
        ],
    };
    const ordersPerBranchChartOptions: ChartOptions<'bar'> = {
        responsive: true,
        plugins: {
            title: {
            display: true,
            text: 'Branch Orders (All)',
            },
            legend: {
            position: 'bottom',
            },
        },
    };

    const totalOrdersChartData: ChartData<'line'> = {
        labels: [2020, 2021, 2022, 2023, 2024, 2025],
        datasets: [
            {
            label: 'Orders',
            data: [500, 1000, 3000, 12000, 5000, 13000],
            borderColor: '#4BC0C0',
            backgroundColor: 'rgba(75, 192, 192, 0.2)',
            },
        ],
    };
    const totalOrdersChartOptions: ChartOptions<'line'> = {
        responsive: true,
        plugins: {
            title: {
            display: true,
            text: 'Branch Orders (All)',
            },
            legend: {
            position: 'bottom',
            },
        },
    };



    /**
     * Render
     */
    return(
        <div className="content1 compressed">
            {!branches
            ? (
                <Spin size="large"/>
            )
            : (
                <>
                    <h3 className="fw-bold mar-bottom-1">Dashboard</h3>

                    {/* Filters */}
                    <div className="d-flex align-items-center justify-content-between mar-bottom-1">
                        <div className="d-flex align-items-center gap3">
                            <RangePicker
                            size="large"/>
                            
                            <Select
                            size="large"
                            style={{width: 250}}
                            value={selectedBranch?.id || ""}
                            onChange={(val) => {
                                const branch = branches?.find(branch => branch.id === val) || null;;
                                setSelectedBranch(branch)
                            }}
                            options={[
                                {label: "All", value: ""},
                                ...branches?.map(branch => ({label: `${branch.name} (${branch.address})`, value: branch.id}))
                            ]}/>
                        </div>
                        
                        <Button
                        size="large"
                        type="primary">
                            Download Report
                        </Button>
                    </div>
                    
                    {/* KPIS */}
                    <div className="d-flex align-items-center gap1 mar-bottom-1">
                        <div className="dash-kpi-box">
                            Total Orders
                            <h3>0</h3>
                        </div>

                        <div className="dash-kpi-box">
                            Total Branches
                            <h3>{branches?.length}</h3>
                        </div>

                        <div className="dash-kpi-box">
                            Total Orders
                            <h3>0</h3>
                        </div>

                        <div className="dash-kpi-box">
                            Total Orders
                            <h3>0</h3>
                        </div>
                    </div>

                    {/* Other Contents */}
                    <div className="d-flex gap1 mar-bottom-1">
                        <div className="dash-box1">
                            <BarChart
                            data={ordersPerBranchChartData}
                            options={ordersPerBranchChartOptions}
                            className="w-100"/>
                        </div>
                        <div className="dash-box1">
                            <LineChart
                            data={totalOrdersChartData}
                            options={totalOrdersChartOptions}
                            className="w-100"/>
                        </div>
                    </div>

                    <div className="d-flex gap1">
                        <div className="dash-box1">
                        </div>
                        <div className="dash-box1"></div>
                    </div>
                </>
            )}
        </div>
    )
}