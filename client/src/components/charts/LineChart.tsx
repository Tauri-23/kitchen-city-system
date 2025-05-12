import React from 'react';
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend,
  ChartOptions,
  ChartData,
} from 'chart.js';
import { Line } from 'react-chartjs-2';

// Register necessary components
ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend
);

type LineChartProps = {
  data: ChartData<'line'>;
  options?: ChartOptions<'line'>;
  className?: string;
};

const LineChart: React.FC<LineChartProps> = ({ data, options, className }) => {
  return <Line data={data} options={options} className={className} />;
};

export default LineChart;
