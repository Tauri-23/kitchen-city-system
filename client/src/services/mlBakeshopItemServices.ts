import axiosClient from "../axios-client"

export const fetchAllMlBakeshopItems = async() => {
    try {
        const response = await axiosClient.get(`/get-all-mlbakeshop-items`);
        return response.data;
    } catch(error) {
        console.error(error);
        throw error;
    }
}