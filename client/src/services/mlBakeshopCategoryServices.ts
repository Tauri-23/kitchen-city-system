import axiosClient from "../axios-client"

export const fetchAllMlBakeshopCategories = async() => {
    try {
        const response = await axiosClient.get(`/get-all-mlbakeshop-categories`);
        return response.data;
    } catch(error) {
        console.error(error);
        throw error;
    }
}