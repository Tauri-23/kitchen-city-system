import Table, { ColumnsType as TableColumnsType } from "antd/es/table";
import { MenuSubCategoryStructure } from "../../../../../types/menuSubCategoryStucture";
import { Button } from "antd";

interface SuperAdminMenuSubCategoriesTypes {
    menuSubCategories: MenuSubCategoryStructure[];
    setMenuSubCategories: React.Dispatch<React.SetStateAction<MenuSubCategoryStructure[]>>;
}

const SuperAdminMenuSubCategories: React.FC<SuperAdminMenuSubCategoriesTypes> = ({menuSubCategories, setMenuSubCategories}) => {
    /**
     * Setup table columns
     */
    const menuSubCategoriesColumns: TableColumnsType<MenuSubCategoryStructure> = [
        {
            title: "Category",
            dataIndex: "sub_category"
        }
    ];



    /**
     * Render
     */
    return(
        <>
            <div className="d-flex align-items-center justify-content-between mar-bottom-3">
                <h4 className="fw-bold">Sub-Categories</h4>
                <Button
                type="primary">
                    Add Sub-Category
                </Button>
            </div>
            <Table
            className="mar-bottom-1"
            size="small"
            columns={menuSubCategoriesColumns}
            dataSource={menuSubCategories.map((item, index) => ({...item, key: index}))}
            bordered
            pagination={{pageSize: 10}}/>
        </>
    );
}

export default SuperAdminMenuSubCategories;