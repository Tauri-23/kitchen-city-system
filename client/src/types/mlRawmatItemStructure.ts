import MlRawmatCategoryStructure from "./mlRawmatCategoryStructure";

export default interface MlRawmatItemStructure {
    id: string;

    name: string;
    ml_rawmat_category_id: number | null;
    unit_cost: number;
    srp: number;

    created_at: Date | null;
    updated_at: Date | null;



    /**
     * Foreign Joins
     */
    ml_rawmat_category: MlRawmatCategoryStructure;
}