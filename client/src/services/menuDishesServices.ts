import axiosClient from "../axios-client"

export const fetchAllMenuDishesWhereWeek = async(week: string) => {
    try {
        const response = await axiosClient.get(`/get-all-menu-dishes-where-week/${week}`);
        return response.data;
    } catch(error) {
        console.error(error);
        throw error;
    }
}