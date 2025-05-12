// src/components/charts/BarChart.tsx
import React from 'react';
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  BarElement,
  Title,
  Tooltip,
  Legend,
  ChartOptions,
  ChartData,
} from 'chart.js';
import { Bar } from 'react-chartjs-2';

ChartJS.register(
  CategoryScale,
  LinearScale,
  BarElement,
  Title,
  Tooltip,
  Legend
);

type BarChartProps = {
  data: ChartData<'bar'>;
  options?: ChartOptions<'bar'>;
  className?: string;
};

const BarChart: React.FC<BarChartProps> = ({ data, options, className }) => {
  return <Bar data={data} options={options} className={className} />;
};

export default BarChart;
