import { BranchStructure } from "./branchStructure";

export interface BranchManagerStructure {
    id: string;
    branch_id: string;
    branch: BranchStructure;
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