import axiosClient from "../axios-client"

export const fetchAllSuperAdminsWhereNotId = async(id: string) => {
    try {
        const response = await axiosClient.get(`/get-all-super-admins-wherenot-id/${id}`);
        return response.data;
    } catch(error) {
        console.error(error);
        throw error;
    }
}