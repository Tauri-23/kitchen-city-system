import MlBakeshopCategoryStructure from "./mlBakeshopCategoryStructure";

export default interface MlBakeshopItemStructure {
    id: string;

    name: string;
    ml_bakeshop_category_id: number | null;
    unit_cost: number;
    srp: number;

    created_at: Date | null;
    updated_at: Date | null;



    /**
     * Foreign Joins
     */
    ml_bakeshop_category: MlBakeshopCategoryStructure;
}