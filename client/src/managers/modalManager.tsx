import BranchManagerMlBakeshopOrderCheckoutModal from "../components/modals/braManMlBakeshopOrderCheckoutModal";
import BranchManagerMlRawmatOrderCheckoutModal from "../components/modals/braManMlRawmatOrderCheckoutModal";
import BranchManagerOrderCheckoutModal from "../components/modals/braManOrderCheckoutModal";
import SuperAdminAddAreaManagerModal from "../components/modals/supAdAddAreaManagerModal";
import SuperAdminAddBranchManagerModal from "../components/modals/supAdAddBranchManagerModal";
import SuperAdminAddBranchModal from "../components/modals/supAdAddBranchModal";
import SuperAdminAddMenuCategoryModal from "../components/modals/supAdAddMenuCategoryModal";
import SuperAdminAddMenuClassModal from "../components/modals/supAdAddMenuClassModal";
import SuperAdminAddMenuDishModal from "../components/modals/supAdAddMenuDishModal";
import SuperAdminAddMenuDishViaExcelModal from "../components/modals/supAdAddMenuDishViaExcelModal";
import SuperAdminAddMenuFormElementModal from "../components/modals/supAdAddMenuFormElementModal";
import SuperAdminAddMenuShiftModal from "../components/modals/supAdAddMenuShiftModal";
import SuperAdminAddMenuSubCategoryModal from "../components/modals/supAdAddMenuSubCategoryModal";
import SuperAdminAddMenusViaExcelModal from "../components/modals/supAdAddMenusViaExcelModal";
import SuperAdminAddMenuTagModal from "../components/modals/supAdAddMenuTagModal";
import SuperAdminAddSuperAdminModal from "../components/modals/supAdAddSuperAdminModal";
import { useGeneralContext } from "../contexts/GeneralContext"
import { AreaManagerStructure } from "../types/areaManagerSturcture";
import { BranchManagerStructure } from "../types/branchManagerSturcture";
import { BranchStructure } from "../types/branchStructure";
import { MenuCategoryStructure } from "../types/menuCategoryStructure";
import { MenuClassStructure } from "../types/menuClassStructure";
import { MenuDishStructure } from "../types/menuDishStructure";
import { MenuFormElementStructure } from "../types/menuFormElementStructure";
import { MenuShiftStructure } from "../types/menuShiftStructure";
import { MenuSubCategoryStructure } from "../types/menuSubCategoryStucture";
import { MenuTagStructure } from "../types/menuTagStructure";
import { SuperAdminStructure } from "../types/superAdminSturcture";
import { SelectedBakeshopItemsInType } from "../views/branchManager/marketListOrders/braManMarketListAddBakeshopOrders";
import { SelectedRawmatItemsInType } from "../views/branchManager/marketListOrders/braManMarketListAddRawmatOrders";
import { SelectedMenusType } from "../views/branchManager/orders/braManAddOrder";

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
                setMenuTags={props.setMenuTags as React.Dispatch<React.SetStateAction<MenuTagStructure[] | null>>}
                onClose={hideModal}
                />

            case "SuperAdminAddMenuCategoryModal":
                return <SuperAdminAddMenuCategoryModal
                setMenuCategories={props.setMenuCategories as React.Dispatch<React.SetStateAction<MenuCategoryStructure[] | null>>}
                onClose={hideModal}
                />

            case "SuperAdminAddMenuSubCategoryModal":
                return <SuperAdminAddMenuSubCategoryModal
                setMenuSubCategories={props.setMenuSubCategories as React.Dispatch<React.SetStateAction<MenuSubCategoryStructure[] | null>>}
                onClose={hideModal}
                />
            
            case "SuperAdminAddMenuShiftModal":
                return <SuperAdminAddMenuShiftModal
                setShifts={props.setShifts as React.Dispatch<React.SetStateAction<MenuShiftStructure[] | null>>}
                onClose={hideModal}
                />

            case "SuperAdminAddMenuDishModal":
                return <SuperAdminAddMenuDishModal
                menuClasses={props.menuClasses as MenuClassStructure[]}
                menuCategories={props.menuCategories as MenuCategoryStructure[]}
                menuSubCategories={props.menuSubCategories as MenuSubCategoryStructure[] | null}
                setMenuDishes={props.setMenuDishes as React.Dispatch<React.SetStateAction<MenuDishStructure[] | null>>}
                onClose={hideModal}
                />

            case "SuperAdminAddMenuDishViaExcelModal":
                return <SuperAdminAddMenuDishViaExcelModal
                setMenuDishes={props.setMenuDishes as React.Dispatch<React.SetStateAction<MenuDishStructure[] | null>>}
                onClose={hideModal}
                />

            case "SuperAdminAddMenusViaExcelModal":
                return <SuperAdminAddMenusViaExcelModal
                onClose={hideModal}
                />

            case "SuperAdminAddMenuClassModal":
                return <SuperAdminAddMenuClassModal
                setMenuClasses={props.setMenuClasses as React.Dispatch<React.SetStateAction<MenuClassStructure[] | null>>}
                onClose={hideModal}
                />

            case "SuperAdminAddMenuFormElementModal":
                return <SuperAdminAddMenuFormElementModal
                setmenuFormElements={props.setmenuFormElements as React.Dispatch<React.SetStateAction<MenuFormElementStructure[] | null>>}
                selectedShift={props.selectedShift as MenuShiftStructure}
                menuClasses={props.menuClasses as MenuClassStructure[]}
                onClose={hideModal}
                />




            /**
             * Branch Manager
             */
            case "BranchManagerOrderCheckoutModal":
                return <BranchManagerOrderCheckoutModal
                selectedMenusIn={props.selectedMenusIn as SelectedMenusType[]}
                onSuccess={props.onSuccess as () => void}
                onClose={hideModal}
                />

            case "BranchManagerMlBakeshopOrderCheckoutModal":
                return <BranchManagerMlBakeshopOrderCheckoutModal
                selectedBakeshopItemsIn={props.selectedBakeshopItemsIn as SelectedBakeshopItemsInType[]}
                onSuccess={props.onSuccess as () => void}
                onClose={hideModal}
                />

            case "BranchManagerMlRawmatOrderCheckoutModal":
                return <BranchManagerMlRawmatOrderCheckoutModal
                selectedRawmatItemsIn={props.selectedRawmatItemsIn as SelectedRawmatItemsInType[]}
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