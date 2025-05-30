import axiosClient from "../axios-client"

export const fetchAllMlRawmatItems = async() => {
    try {
        const response = await axiosClient.get(`/get-all-mlrawmat-items`);
        return response.data;
    } catch(error) {
        console.error(error);
        throw error;
    }
}