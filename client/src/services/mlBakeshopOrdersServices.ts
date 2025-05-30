import axiosClient from "../axios-client"
import qs from "qs";

type OrdersRelationships = "ml_bakeshop_order_items" | "branch";

export const fetchAllMlBakeshopOrdersWith = async(withParam: OrdersRelationships[]) => {
    try {
        const response = await axiosClient.get(`/get-all-mlbakeshop-orders-with`, {
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