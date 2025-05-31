import { Calendar, Button } from "antd";
import { Dayjs } from "dayjs";
import { useState } from "react";
import axiosClient from "../../../../../axios-client";
import { notify } from "../../../../../assets/lib/utils";

export default function SuperAdminSettingsWeekManagement() {
    const [selectedMenuDates, setSelectedMenuDates] = useState<{
        [weekLabel: string]: Dayjs[];
    }>({
        week1: [],
        week2: [],
        week3: [],
        week4: [],
    });

    const [orderWindows, setOrderWindows] = useState<{
        [weekLabel: string]: Dayjs[];
    }>({
        week1: [],
        week2: [],
        week3: [],
        week4: [],
    })

    const [activeWeek, setActiveWeek] = useState<"week1" | "week2" | "week3" | "week4">("week1");



    /**
     * Handlers
     */
    const handleDateSelect = (date: Dayjs) => {
        const weekDates = selectedMenuDates[activeWeek] || [];

        const isAlreadySelected = weekDates.some((d) => d.isSame(date, "day"));

        let updatedWeekDates = isAlreadySelected
            ? weekDates.filter((d) => !d.isSame(date, "day"))
            : [...weekDates, date];

        // Remove duplicates
        updatedWeekDates = updatedWeekDates.filter(
            (d, index, self) => index === self.findIndex((t) => t.isSame(d, "day"))
        );

        // Limit to 7 dates max
        if (updatedWeekDates.length > 7) return;

        // Compute 2-weeks-earlier weekdays
        const pastWeekdays = updatedWeekDates
            .map((d) => d.subtract(2, "week"))
            .filter((d) => !["Saturday", "Sunday"].includes(d.format("dddd")));

        // Remove duplicates again just in case
        const uniquePastWeekdays = pastWeekdays.filter(
            (d, index, self) => index === self.findIndex((t) => t.isSame(d, "day"))
        );

        // Update both selected menu dates and order windows
        setSelectedMenuDates((prev) => ({
            ...prev,
            [activeWeek]: updatedWeekDates,
        }));

        setOrderWindows((prev) => ({
            ...prev,
            [activeWeek]: uniquePastWeekdays,
        }));
    };

    const handleSave = () => {
        const formData = new FormData();
        formData.append("selectedMenuDates", JSON.stringify(selectedMenuDates));
        formData.append("orderWindows", JSON.stringify(orderWindows));

        axiosClient.post("/create-menu-week-cycle", formData)
        .then(({data}) => {
            notify(data.status === 200 ? "success" : "error", data.message, "top-center", 3000);
        })
        .catch(error => {
            console.error(error);
            notify("error", "Server Error", "top-center", 3000);
        });
    }



    /**
     * Other Functions
     */
    const dateFullCellRender = (date: Dayjs) => {
        const selectedDates = selectedMenuDates[activeWeek] || [];
        const selectedWindows = orderWindows[activeWeek] || [];
        const isSelected = selectedDates.some((d) => d.isSame(date, "day"));
        const isOrderWindow = selectedWindows.some((d) => d.isSame(date, "day"));

        let backgroundColor;
        let borderColor;

        if (isSelected) {
            backgroundColor = "#fe8d027c";
            borderColor = "#FE8E02";
        } else if (isOrderWindow) {
            backgroundColor = "#d9f7be";
            borderColor = "#52c41a";
        }

        return (
            <div
            style={{
                height: 60,
                padding: 5,
                background: backgroundColor,
                border: borderColor ? `2px solid ${borderColor}` : undefined,
                borderRadius: 6,
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                fontWeight: isSelected || isOrderWindow ? "bold" : "normal",
            }}
            >
            {date.date()}
            </div>
        );
    };





    /**
     * Render
     */
    return(
        <>
            <div className="d-flex align-items-center gap3 mar-bottom-1">
                {["week1", "week2", "week3", "week4"].map((w) => (
                    <Button
                    key={w}
                    type={activeWeek === w ? "primary" : "default"}
                    onClick={() => setActiveWeek(w as any)}
                    >
                    {w.toUpperCase()}
                    </Button>
                ))}
            </div>
            
            {/* Legend */}
            <div className="mar-bottom-3 d-flex gap3 align-items-center">
                <div className="d-flex align-items-center gap3">
                    <div
                        style={{
                            width: 16,
                            height: 16,
                            backgroundColor: "#fe8d027c",
                            border: "2px solid #FE8E02",
                            borderRadius: 4,
                        }}
                    />
                    <span>Selected Date</span>
                </div>
                <div style={{ display: "flex", alignItems: "center", gap: 8 }}>
                    <div
                    style={{
                        width: 16,
                        height: 16,
                        backgroundColor: "#d9f7be",
                        border: "2px solid #52c41a",
                        borderRadius: 4,
                    }}
                    />
                    <span>Order Window</span>
                </div>
            </div>

            {/* Calendar */}
            <Calendar
            className="mar-bottom-1"
            fullscreen={false}
            onSelect={handleDateSelect}
            fullCellRender={dateFullCellRender}
            />

            {/* Buttons */}
            <div className="d-flex gap3 justify-content-end">
                <Button size="large" type="primary" onClick={handleSave}>Save</Button>
            </div>
        </>
    )
}