import { Button } from "antd";

export default function SuperAdminNav({onLogout}: {onLogout: () => void}) {
    return (
        <nav className="nav1">
            <Button
            size="large"
            type="primary"
            ghost
            onClick={onLogout}>
                Logout
            </Button>
        </nav>
    )
}
