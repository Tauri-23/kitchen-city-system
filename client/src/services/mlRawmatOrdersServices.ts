import axiosClient from "../axios-client"
import qs from "qs";

type OrdersRelationships = "ml_rawmat_order_items" | "branch";

export const fetchAllMlRawmatOrdersWith = async(withParam: OrdersRelationships[]) => {
    try {
        const response = await axiosClient.get(`/get-all-mlrawmat-orders-with`, {
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

export const fetchMlRawmatOrderInformation = async(withParam: OrdersRelationships[] | null, idParam: string) => {
    try {
        const response = await axiosClient.get(`/get-mlbakeshop-order-informations`, {
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