import axiosClient from "../axios-client"

export const fetchAllMenuProductions = async() => {
    try {
        const response = await axiosClient.get(`/get-all-menu-productions`);
        return response.data;
    } catch(error) {
        console.error(error);
        throw error;
    }
}