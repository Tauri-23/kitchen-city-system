import axiosClient from "../axios-client"

export const fetchAllMenuTags = async() => {
    try {
        const response = await axiosClient.get(`/get-all-menu-tags`);
        return response.data;
    } catch(error) {
        console.error(error);
        throw error;
    }
}