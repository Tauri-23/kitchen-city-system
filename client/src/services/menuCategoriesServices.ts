import axiosClient from "../axios-client"

export const fetchAllMenuCategories = async() => {
    try {
        const response = await axiosClient.get(`/get-all-menu-categories`);
        return response.data;
    } catch(error) {
        console.error(error);
        throw error;
    }
}