import { Button } from "antd";

export default function BranchManagerNav({onLogout, isLoggingOut}: {onLogout: () => void, isLoggingOut: boolean}) {
    return (
        <nav className="nav1">
            <span className="text-l2 fw-bold">Branch Manager Panel</span>
            
            <Button
            size="large"
            type="primary"
            ghost
            onClick={onLogout}
            loading={isLoggingOut}>
                Logout
            </Button>
        </nav>
    )
}
