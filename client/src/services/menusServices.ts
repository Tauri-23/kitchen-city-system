import axiosClient from "../axios-client"

export const fetchAllMenus = async() => {
    try {
        const response = await axiosClient.get('/get-all-menus');
        return response.data;
    } catch(error) {
        console.error(error);
        throw error;
    }
}


export const fetchAllMenusWhereWeek = async(week: string) => {
    try {
        const response = await axiosClient.get(`/get-all-menus-where-week/${week}`);
        return response.data;
    } catch(error) {
        console.error(error);
        throw error;
    }
}


export const fetchMenuById = async(id: string) => {
    try {
        const response = await axiosClient.get(`/get-menu-by-id/${id}`);
        return response.data;
    } catch(error) {
        console.error(error);
        throw error;
    }
}