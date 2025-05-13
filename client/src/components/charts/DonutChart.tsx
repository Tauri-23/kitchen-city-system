// components/charts/DonutChart.tsx
import React from 'react';
import {
  Chart as ChartJS,
  ArcElement,
  Tooltip,
  Legend,
  ChartOptions,
  ChartData,
} from 'chart.js';
import { Doughnut } from 'react-chartjs-2';

ChartJS.register(ArcElement, Tooltip, Legend);

type DonutChartProps = {
  data: ChartData<'doughnut'>;
  options?: ChartOptions<'doughnut'>;
  className?: string;
};

const DonutChart: React.FC<DonutChartProps> = ({ data, options, className }) => {
  return <Doughnut data={data} options={options} className={className} />;
};

export default DonutChart;
