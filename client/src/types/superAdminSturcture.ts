export interface SuperAdminStructure {
    id: string;
    fname: string;
    mname: string | null;
    lname: string;
    username: string;
    password: string;
    email: string;
    status: "Active" | "Suspended" | "Deleted";
    created_at: string | Date;
    updated_at: string | Date;
}