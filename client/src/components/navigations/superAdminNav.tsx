import { Button } from "antd";

export default function SuperAdminNav({onLogout, isLoggingOut}: {onLogout: () => void, isLoggingOut: boolean}) {
    /**
     * Render
     */
    return (
        <nav className="nav1">
            <span className="text-l2 fw-bold">Super Admin Panel</span>

            <Button
            size="large"
            type="primary"
            ghost
            onClick={() => onLogout()}
            loading={isLoggingOut}>
                Logout
            </Button>
        </nav>
    )
}
