import axiosClient from "../axios-client"

export const fetchAllMenuDishes= async() => {
    try {
        const response = await axiosClient.get(`/get-all-menu-dishes`);
        return response.data;
    } catch(error) {
        console.error(error);
        throw error;
    }
}