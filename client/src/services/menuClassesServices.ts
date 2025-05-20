import axiosClient from "../axios-client"

export const fetchAllMenuClasses = async() => {
    try {
        const response = await axiosClient.get(`/get-all-menu-classes`);
        return response.data;
    } catch(error) {
        console.error(error);
        throw error;
    }
}