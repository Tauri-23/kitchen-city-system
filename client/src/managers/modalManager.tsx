import SuperAdminAddAreaManagerModal from "../components/modals/supAdAddAreaManagerModal";
import SuperAdminAddBranchManagerModal from "../components/modals/supAdAddBranchManagerModal";
import SuperAdminAddBranchModal from "../components/modals/supAdAddBranchModal";
import SuperAdminAddSuperAdminModal from "../components/modals/supAdAddSuperAdminModal";
import { useGeneralContext } from "../contexts/GeneralContext"
import { AreaManagerStructure } from "../types/areaManagerSturcture";
import { BranchManagerStructure } from "../types/branchManagerSturcture";
import { BranchStructure } from "../types/branchStructure";
import { SuperAdminStructure } from "../types/superAdminSturcture";

const ModalManager = () => {
    const { modalState, hideModal } = useGeneralContext();
    const { type, props } = modalState;



    const renderModal = () => {
        switch(type) {
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