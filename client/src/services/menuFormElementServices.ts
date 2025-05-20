import axiosClient from "../axios-client"

export const fetchAllMenuFormElements = async() => {
    try {
        const response = await axiosClient.get(`/get-all-menu-form-elements`);
        return response.data;
    } catch(error) {
        console.error(error);
        throw error;
    }
}