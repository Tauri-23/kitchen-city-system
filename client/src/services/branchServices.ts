import axiosClient from "../axios-client"

export const fetchAllBranches = async() => {
    try {
        const response = await axiosClient.get(`/get-all-branches`);
        return response.data;
    } catch(error) {
        console.error(error);
        throw error;
    }
}