import axiosClient from "../axios-client"

export const fetchAllAreaManagers = async() => {
    try {
        const response = await axiosClient.get(`/get-all-area-managers`);
        return response.data;
    } catch(error) {
        console.error(error);
        throw error;
    }
}