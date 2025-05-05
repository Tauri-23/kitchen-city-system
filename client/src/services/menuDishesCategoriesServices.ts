import axiosClient from "../axios-client"

export const fetchAllMenuDishesCategories = async() => {
    try {
        const response = await axiosClient.get('/get-all-menu-dishes-categories');
        return response.data;
    } catch(error) {
        console.error(error);
        throw error;
    }
}