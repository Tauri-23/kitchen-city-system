import axiosClient from "../axios-client"

export const fetchAllMenuShifts = async() => {
    try {
        const response = await axiosClient.get(`/get-all-menu-shifts`);
        return response.data;
    } catch(error) {
        console.error(error);
        throw error;
    }
}