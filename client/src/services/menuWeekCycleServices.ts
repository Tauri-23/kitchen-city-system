import axiosClient from "../axios-client"

export const fetchAllMenuWeekCyclesWhereOrderWindow = async(date: string) => {
    try {
        const response = await axiosClient.get(`/create-menu-week-cycle-where-order-window/${String(date)}`);
        return response.data;
    } catch(error) {
        console.error(error);
        throw error;
    }
}