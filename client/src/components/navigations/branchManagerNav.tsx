import { Button } from "antd";
import { useLoggedUserContext } from "../../contexts/LoggedUserContext";

export default function BranchManagerNav({onLogout, isLoggingOut}: {onLogout: () => void, isLoggingOut: boolean}) {
    const { user } = useLoggedUserContext();



    /**
     * Render
     */
    return (
        <nav className="nav1">
            <span className="text-l2 fw-bold">Branch Manager Panel ({user?.branch?.name || ""} {user?.branch?.size || ""})</span>
            
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
