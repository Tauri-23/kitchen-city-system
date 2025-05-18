import axiosClient from "../axios-client"
import { MenuTagStructure } from "../types/menuTagStructure";

export const fetchAllMenuTags = async() => {
    try {
        const response = await axiosClient.get(`/get-all-menu-tags`);
        return response.data;
    } catch(error) {
        console.error(error);
        throw error;
    }
}

export const fetchAllUniqueMenuToDishTags = async () => {
    try {
        const response = await fetchAllMenuTags();

        // Extract all values
        const allTags = response.map((menuTag: MenuTagStructure) => menuTag.menu_to_dish_tag);

        // Get unique values using Set
        const uniqueTags = Array.from(new Set(allTags)).map(tag => ({ value: tag }));

        return uniqueTags;
    } catch (error) {
        console.error(error);
        throw error;
    }
};