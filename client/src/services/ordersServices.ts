import axiosClient from "../axios-client"
import qs from "qs";

type OrdersRelationships = "order_items" | "branch";

export const fetchAllOrdersWith = async(withParam: OrdersRelationships[]) => {
    try {
        const response = await axiosClient.get(`/get-all-orders-with`, {
            params: {
                with: withParam
            },
            paramsSerializer: params => qs.stringify(params, { arrayFormat: "brackets"})
        });
        return response.data;
    } catch(error) {
        console.error(error);
        throw error;
    }
}

export const fetchOrderInformation = async(withParam: OrdersRelationships[] | null, idParam: string) => {
    try {
        const response = await axiosClient.get(`/get-order-informations`, {
            params: {
                with: withParam,
                id: idParam
            },
            paramsSerializer: params => qs.stringify(params, { arrayFormat: "brackets"})
        });
        return response.data;
    } catch(error) {
        console.error(error);
        throw error;
    }
}