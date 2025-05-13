import { ChartData, ChartOptions } from "chart.js";
import BarChart from "../../../../components/charts/BarChart";
import DonutChart from "../../../../components/charts/DonutChart";
import LineChart from "../../../../components/charts/LineChart";
import { BranchStructure } from "../../../../types/branchStructure";

interface SuperAdminDashboardAllContentTypes {
    branches: BranchStructure[] | null
}

export default function SuperAdminDashboardAllContent({branches}: SuperAdminDashboardAllContentTypes) {

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
                label: 'Branch 1',
                data: [500, 1000, 3000, 12000, 5000, 13000],
                borderColor: '#4BC0C0',
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
            },
            {
                label: 'Branch 2',
                data: [500, 1200, 3000, 10030, 8000, 10000],
                borderColor: '#4B10C0',
                backgroundColor: 'rgba(12, 89, 255, 0.2)',
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

    const donutChartData = {
        labels: branches?.map(branch => `${branch.name} (${branch.address})`),
        datasets: [
            {
                label: 'Orders',
                data: [300, 200, 100],
                backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56'],
                borderWidth: 1,
            },
        ],
    };
    const donutChartOptions = {
        responsive: true,
        plugins: {
            legend: {
            position: 'bottom' as const,
            },
            title: {
            display: true,
            text: 'Vote Distribution',
            },
        },
    };



    /**
     * Render
     */
    return(
        <>
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
                    <DonutChart
                    data={donutChartData}
                    options={donutChartOptions}
                    className="w-100"/>
                </div>
                <div className="dash-box1"></div>
            </div>
        </>
    )
}