import axiosClient from "../axios-client"

export const fetchAllBranchManagers = async() => {
    try {
        const response = await axiosClient.get(`/get-all-branch-managers`);
        return response.data;
    } catch(error) {
        console.error(error);
        throw error;
    }
}