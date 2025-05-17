import BranchManagerAddOrderModal from "../components/modals/braManAddOrderModal";
import BranchManagerOrderCheckoutModal from "../components/modals/braManOrderCheckoutModal";
import SuperAdminAddAreaManagerModal from "../components/modals/supAdAddAreaManagerModal";
import SuperAdminAddBranchManagerModal from "../components/modals/supAdAddBranchManagerModal";
import SuperAdminAddBranchModal from "../components/modals/supAdAddBranchModal";
import SuperAdminAddMenuTagModal from "../components/modals/supAdAddMenuTagModal";
import SuperAdminAddSuperAdminModal from "../components/modals/supAdAddSuperAdminModal";
import { useGeneralContext } from "../contexts/GeneralContext"
import { AreaManagerStructure } from "../types/areaManagerSturcture";
import { BranchManagerStructure } from "../types/branchManagerSturcture";
import { BranchStructure } from "../types/branchStructure";
import { MenuCategoryStructure } from "../types/menuCategoryStructure";
import { MenuDishStructure } from "../types/menuDishStructure";
import { MenuShiftStructure } from "../types/menuShiftStructure";
import { MenuStructure } from "../types/menuStructure";
import { SuperAdminStructure } from "../types/superAdminSturcture";

const ModalManager = () => {
    const { modalState, hideModal } = useGeneralContext();
    const { type, props } = modalState;



    const renderModal = () => {
        switch(type) {
            /**
             * Super Admin
             */
            case "SupAdAddSuperAdminModal":
                return <SuperAdminAddSuperAdminModal
                setSuperAdmins={props.setSuperAdmins as (value: SuperAdminStructure[]) => void}
                onClose={hideModal}/>

            case "SupAdAddAreaManagerModal":
                return <SuperAdminAddAreaManagerModal
                setAreaManagers={props.setAreaManagers as (value: AreaManagerStructure[]) => void}
                onClose={hideModal}/>

            case "SuperAdminAddBranchModal":
                return <SuperAdminAddBranchModal
                setBranches={props.setBranches as (value: BranchStructure[]) => void}
                setFilteredBranches={props.setFilteredBranches as (value: BranchStructure[]) => void}
                areaManagers={props.areaManagers as AreaManagerStructure[]}
                onClose={hideModal}/>

            case "SuperAdminAddBranchManagerModal":
                return <SuperAdminAddBranchManagerModal
                setBranchManagers={props.setBranchManagers as (value: BranchManagerStructure[]) => void}
                setFilteredBranchManagers={props.setFilteredBranchManagers as (value: BranchManagerStructure[]) => void}
                branches={props.branches as BranchStructure[]}
                onClose={hideModal}/>

            case "SuperAdminAddMenuTagModal": 
                return <SuperAdminAddMenuTagModal
                category={props.category as MenuCategoryStructure}
                shift={props.shift as MenuShiftStructure}
                setShifts={props.setShifts as React.Dispatch<React.SetStateAction<MenuShiftStructure[] | null>>}
                onClose={hideModal}
                />




            /**
             * Branch Manager
             */
            case "BranchManagerAddOrderModal":
                return <BranchManagerAddOrderModal
                menuDish={props.menuDish as MenuDishStructure}
                processedMenus={props.processedMenus as MenuStructure[]}
                setprocessedMenus={props.setprocessedMenus as (value: MenuStructure[]) => void}
                onClose={hideModal}
                />

            case "BranchManagerOrderCheckoutModal":
                return <BranchManagerOrderCheckoutModal
                orderedDishes={props.orderedDishes as MenuDishStructure[]}
                onSuccess={props.onSuccess as () => void}
                onClose={hideModal}
                />



            default:
                return null;
        }
    };



    return(
        <>
            {renderModal()}
        </>
    )
}

export default ModalManager;