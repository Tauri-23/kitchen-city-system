import { toast } from 'react-toastify';



/*
|----------------------------------------
| Empty or spaces string checker
|----------------------------------------
*/
export function isEmptyOrSpaces(str: string) {
    return str === null || str.match(/^ *$/) !== null;
}





/*
|----------------------------------------
| Format Date MM dd, YYYY && MM dd, YYYY h:s a
|----------------------------------------
*/
export const formatDate = (date: string | number | Date): string => {
    const realDate = new Date(date);
    const options: Intl.DateTimeFormatOptions = {
        month: 'short',
        day: '2-digit',
        year: 'numeric'
    };
    return realDate.toLocaleDateString('en-PH', options);
};

export const formatDateTime = (dateTime: string | number | Date): string => {
    const realDateTime = new Date(dateTime);

    const timeOptions: Intl.DateTimeFormatOptions = {
        hour: 'numeric',
        minute: 'numeric',
        hour12: true
    };
    const formattedTime = realDateTime.toLocaleTimeString('en-PH', timeOptions);

    return `${formatDate(realDateTime)} ${formattedTime}`;
};

export const formatTime = (time: string): string => {
    const [hours, minutes, seconds] = time.split(':').map(Number);

    const realDateTime = new Date();
    realDateTime.setHours(hours, minutes, seconds || 0);

    const timeOptions: Intl.DateTimeFormatOptions = {
        hour: 'numeric',
        minute: 'numeric',
        hour12: true
    };

    return realDateTime.toLocaleTimeString('en-PH', timeOptions);
};

export const getTimeAgo = (timestamp: string | number | Date): string => {
    const date = new Date(timestamp);
    const now = new Date();
    const timeDifference = now.getTime() - date.getTime(); // milliseconds

    const seconds = Math.floor(timeDifference / 1000);
    const minutes = Math.floor(seconds / 60);
    const hours = Math.floor(minutes / 60);

    if (minutes < 1) return "Just now";
    if (minutes < 60) return `${minutes}m`;
    if (hours < 24) return `${hours}h`;

    const days = Math.floor(hours / 24);
    return `${days}d`;
};





/*
|----------------------------------------
| Format Currency to
|----------------------------------------
*/
export const formatToPhilPeso = (value: number) => {
    return new Intl.NumberFormat('en-PH', {style: 'currency', currency: 'PHP'}).format(value);
}

export const formatNumbersTwoDec = (value: number) => {
    return Number(value).toLocaleString('en-PH', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
};





/*
|----------------------------------------
| Toast and Modals
|----------------------------------------
*/
export function notify(
    type: "success" | "default" | "error", 
    message: string, 
    position: "top-left" | "top-center" | "top-right" | "bottom-left" | "bottom-center" | "bottom-right", 
    ms: number,
) {
    if(type == 'success') {
        toast.success(message, {
            position: position,
            autoClose: ms,
            hideProgressBar: false,
            closeOnClick: true,
            pauseOnHover: true,
            draggable: true,
            progress: undefined,
            theme: "light",
        });
    }
    else if(type === 'default') {
        toast(message, {
            position: position,
            autoClose: ms,
            hideProgressBar: true,
            closeOnClick: true,
            pauseOnHover: true,
            draggable: true,
            progress: undefined,
            theme: "light",
        });
    }
    else if(type === 'error') {
        toast.error(message, {
            position: position,
            autoClose: ms,
            hideProgressBar: false,
            closeOnClick: true,
            pauseOnHover: true,
            draggable: true,
            progress: undefined,
            theme: "light",
        });
    }
}





/*
|----------------------------------------
| Weeks For Orders
|----------------------------------------
*/
export const getWeekOfMonthFixed4 = (date = new Date()): number => {
    const year = date.getFullYear();
    const month = date.getMonth(); // 0 = Jan
  
    const firstDayOfMonth = new Date(year, month, 1);
    const totalDays = new Date(year, month + 1, 0).getDate(); // last day of month
    const dayOfMonth = date.getDate();
  
    // Weeks 1-3 are 7 days each
    if (dayOfMonth <= 7) return 1;
    if (dayOfMonth <= 14) return 2;
    if (dayOfMonth <= 21) return 3;
  
    // All remaining days go to week 4
    return 4;
}