export interface MenuWeekCycleStructure {
    id: number;
    month: "Jan" | "Feb" | "Mar" | "Apr" | "May" | "Jun" | "Jul" | "Aug" | "Sep" | "Oct" | "Nov" | "Dec";
    date: Date;
    day: "Monday" | "Tuesday" | "Wednesday" | "Thursday" | "Friday" | "Saturday" | "Sunday";
    count: number;
    week: string;
    open_date: Date;
    closing_date: Date;
    created_at: string | Date;
    updated_at: string | Date;
}