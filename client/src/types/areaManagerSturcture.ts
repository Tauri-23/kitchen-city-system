export interface AreaManagerStructure {
    id: string;
    fname: string;
    mname: string | null;
    lname: string;
    email: string;
    status: "Active" | "Suspended" | "Deleted";
    created_at: string | Date;
    updated_at: string | Date;
}