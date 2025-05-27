import { Calendar, Badge, Button } from "antd";
import type { CalendarProps } from "antd";
import dayjs, { Dayjs } from "dayjs";
import { useEffect, useState } from "react";

export default function SuperAdminSettingsWeekManagement() {
    const [selectedDatesByWeek, setSelectedDatesByWeek] = useState<{
        [weekLabel: string]: Dayjs[];
    }>({
        week1: [],
        week2: [],
        week3: [],
        week4: [],
    });

    const [activeWeek, setActiveWeek] = useState<"week1" | "week2" | "week3" | "week4">("week1");



    /**
     * Debugging
     */
    useEffect(() => {
        console.log(selectedDatesByWeek);
    }, [selectedDatesByWeek]);



    /**
     * Handlers
     */
    const handleDateSelect = (date: Dayjs) => {
        const weekDates = selectedDatesByWeek[activeWeek] || [];

        const isAlreadySelected = weekDates.some((d) => d.isSame(date, "day"));

        let updatedWeekDates = isAlreadySelected
            ? weekDates.filter((d) => !d.isSame(date, "day"))
            : [...weekDates, date];

        // Limit to 7 dates max
        if (updatedWeekDates.length > 7) return;

        setSelectedDatesByWeek((prev) => ({
            ...prev,
            [activeWeek]: updatedWeekDates,
        }));
    };

    const dateFullCellRender = (date: Dayjs) => {
        const selectedDates = selectedDatesByWeek[activeWeek] || [];
        const isSelected = selectedDates.some((d) => d.isSame(date, "day"));
        const isTwoWeeksEarlier = selectedDates.some((d) => date.isSame(d.subtract(2, "week"), "day"));

        let backgroundColor;
        let borderColor;

        if (isSelected) {
            backgroundColor = "#fe8d027c";
            borderColor = "#FE8E02";
        } else if (isTwoWeeksEarlier) {
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
                fontWeight: isSelected || isTwoWeeksEarlier ? "bold" : "normal",
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
                <Button size="large" type="primary">Save</Button>
            </div>
        </>
    )
}