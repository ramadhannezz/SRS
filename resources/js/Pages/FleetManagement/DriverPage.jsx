import React, { useState } from "react";
import { Inertia } from "@inertiajs/inertia";
import Layout from "@/Layouts/layout/layout.jsx";
import { DataTable } from "primereact/datatable";
import { Column } from "primereact/column";
import { InputText } from "primereact/inputtext";
import { Button } from "primereact/button";
import { Dialog } from "primereact/dialog";
import { Toolbar } from "primereact/toolbar";
import '../../../css/FleetManagement/driver.css/';  // Import CSS khusus untuk halaman Driver

const DriverPage = ({ drivers }) => {
    const [name, setName] = useState('');
    const [phone, setPhone] = useState('');
    const [ktp, setKtp] = useState('');
    const [sim, setSim] = useState('');
    const [filteredDrivers, setFilteredDrivers] = useState([]);
    const [editingDriver, setEditingDriver] = useState(null);
    const [dialogVisible, setDialogVisible] = useState(false);
    const [confirmVisible, setConfirmVisible] = useState(false);
    const [driverToDelete, setDriverToDelete] = useState(null);
    const [globalFilter, setGlobalFilter] = useState('');
    const [errors, setErrors] = useState({});
    const [errorDialogVisible, setErrorDialogVisible] = useState(false);

    const handleSubmit = (e) => {
        e.preventDefault();
        if (editingDriver) {
            Inertia.put(`/drivers/${editingDriver.id}`, { name, phone, ktp, sim }, {
                onError: (errors) => {
                    setErrors(errors);
                    setErrorDialogVisible(true);
                }
            });
        } else {
            Inertia.post('/drivers', { name, phone, ktp, sim }, {
                onError: (errors) => {
                    setErrors(errors);
                    setErrorDialogVisible(true);
                }
            });
        }
        setName('');
        setPhone('');
        setKtp('');
        setSim('');
        setEditingDriver(null);
        setDialogVisible(false);
    };

    const handleEdit = (driver) => {
        setEditingDriver(driver);
        setName(driver.name);
        setPhone(driver.phone);
        setKtp(driver.ktp);
        setSim(driver.sim);
        setDialogVisible(true);
    };

    const handleDelete = (id) => {
        setDriverToDelete(id);
        setConfirmVisible(true);
    };

    const confirmDelete = () => {
        Inertia.delete(`/drivers/${driverToDelete}`, {
            onSuccess: () => {
                window.location.reload();
            }
        });
        setConfirmVisible(false);
    };

    const leftToolbarTemplate = () => {
        return (
            <Button label="Tambah Driver" icon="pi pi-plus" className="p-button-add" onClick={() => setDialogVisible(true)} />
        );
    };

    const rightToolbarTemplate = () => {
        return (
            <span className="p-input-icon-left">
                <i className="pi pi-search" />
                <InputText type="search" onInput={(e) => setGlobalFilter(e.target.value)} placeholder="Cari nama driver, no. telepon..." />
            </span>
        );
    };

    const actionBodyTemplate = (rowData) => {
        return (
            <div className="driver-action-cell">
                <Button label="Edit" onClick={() => handleEdit(rowData)} className="p-button-warning-edit" />
                <Button label="Delete" onClick={() => handleDelete(rowData.id)} className="p-button-danger" />
            </div>
        );
    };

    const numberBodyTemplate = (rowData, column) => {
        return column.rowIndex + 1;
    };

    return (
        <Layout>
            <div className="content-container">
                <div className="p-grid">
                    <div className="p-col-12">
                        <div className="toolbar-container">
                            <Toolbar className="p-mb-4" left={leftToolbarTemplate} right={rightToolbarTemplate} />
                        </div>
                        <div className="table-menu-container">
                            <DataTable value={drivers} scrollable scrollHeight="576px" className="p-datatable-sm" globalFilter={globalFilter}>
                                <Column header="No" body={numberBodyTemplate} headerClassName="colom-header-content" className="driver-table-cell driver-column-number" />
                                <Column field="name" header="Nama Driver" filter filterPlaceholder="Search by name" headerClassName="colom-header-content" className="driver-table-cell" />
                                <Column field="phone" header="No. Telepon" headerClassName="colom-header-content" className="driver-table-cell" />
                                <Column field="ktp" header="No. KTP" headerClassName="colom-header-content" className="driver-table-cell" />
                                <Column field="sim" header="No. SIM" headerClassName="colom-header-content" className="driver-table-cell" />
                                <Column
                                    body={actionBodyTemplate}
                                    header="Aksi"
                                    headerClassName="colom-header-content"
                                    className="driver-table-cell"
                                />
                            </DataTable>
                        </div>
                    </div>
                </div>

                <Dialog header="Detail Driver" visible={dialogVisible} style={{ width: '30vw' }} modal onHide={() => setDialogVisible(false)}>
                    <form onSubmit={handleSubmit} className="p-fluid">
                        <div className="p-field">
                            <h6><label htmlFor="name">Nama Driver</label></h6>
                            <InputText id="name" value={name} onChange={(e) => setName(e.target.value)} />
                            {errors.name && <small className="p-error">{errors.name}</small>}
                        </div>
                        <div className="p-field">
                            <h6><label htmlFor="phone">No. Telepon</label></h6>
                            <InputText id="phone" value={phone} onChange={(e) => setPhone(e.target.value)} />
                            {errors.phone && <small className="p-error">{errors.phone}</small>}
                        </div>
                        <div className="p-field">
                            <h6><label htmlFor="ktp">No. KTP</label></h6>
                            <InputText id="ktp" value={ktp} onChange={(e) => setKtp(e.target.value)} />
                            {errors.ktp && <small className="p-error">{errors.ktp}</small>}
                        </div>
                        <div className="p-field">
                            <h6><label htmlFor="sim">No. SIM</label></h6>
                            <InputText id="sim" value={sim} onChange={(e) => setSim(e.target.value)} />
                            {errors.sim && <small className="p-error">{errors.sim}</small>}
                        </div>
                        <Button type="submit" label="Save" className="p-mt-2" />
                    </form>
                </Dialog>

                <Dialog header="Konfirmasi Penghapusan" visible={confirmVisible} style={{ width: '30vw' }} modal onHide={() => setConfirmVisible(false)}>
                    <p>Apakah Anda yakin ingin menghapus data ini?</p>
                    <div className="p-d-flex p-jc-end">
                        <Button label="Tidak" icon="pi pi-times" className="p-button-text p-mr-2" onClick={() => setConfirmVisible(false)} />
                        <Button label="Ya" icon="pi pi-check" className="p-button-danger" onClick={confirmDelete} />
                    </div>
                </Dialog>

                <Dialog header="Error" visible={errorDialogVisible} style={{ width: '30vw' }} modal onHide={() => setErrorDialogVisible(false)}>
                    <ul>
                        {Object.keys(errors).map((key) => (
                            <li key={key} className="p-error">{errors[key]}</li>
                        ))}
                    </ul>
                    <div className="p-d-flex p-jc-end">
                        <Button label="Ok" icon="pi pi-check" onClick={() => setErrorDialogVisible(false)} />
                    </div>
                </Dialog>
            </div>
        </Layout>
    );
};

export default DriverPage;

// import React, { useState } from "react";
// import { Inertia } from "@inertiajs/inertia";
// import Layout from "@/Layouts/layout/layout.jsx";
// import {
//   Table,
//   Button,
//   Modal,
//   Input,
//   Space,
//   Popconfirm,
//   message,
//   Spin,
//   Tooltip,
// } from "antd";
// import {
//   SolutionOutlined,
//   PhoneOutlined,
//   IdcardOutlined,
//   CarOutlined,
//   NumberOutlined,
//   FileTextOutlined,
//   DropboxOutlined,
//   ProductOutlined,
//   CheckCircleOutlined,
//   CalendarOutlined,
//   PlusOutlined,
//   PlusCircleOutlined,
// } from "@ant-design/icons";
// import DriverFormModal from "./DriverFormModal";
// import { createStyles } from "antd-style";
// import dayjs from "dayjs";

// const useStyle = createStyles(({ css, token }) => {
//   const { antCls } = token;
//   return {
//     customTable: css`
//       ${antCls}-table-container {
//         ${antCls}-table-body {
//           scrollbar-width: thin;
//           scrollbar-color: #eaeaea transparent;
//           scrollbar-gutter: stable;
//         }
//         ${antCls}-table-content {
//           overflow-x: auto;
//         }
//       }
//       .centered-column {
//         text-align: center;
//       }
//       thead > tr > th {
//         text-align: center !important;
//       }
//     `,
//   };
// });

// const DriverPage = ({ drivers }) => {
//   const { styles } = useStyle();
//   const [editingDriver, setEditingDriver] = useState(null);
//   const [modalVisible, setModalVisible] = useState(false);
//   const [loading, setLoading] = useState(false);
//   const [searchQuery, setSearchQuery] = useState("");
//   const [pagination, setPagination] = useState({ current: 1, pageSize: 10 });

//   const filteredDrivers = drivers.filter((driver) =>
//     ["name", "phone", "ktp", "sim"].some((key) =>
//       driver[key]?.toString().toLowerCase().includes(searchQuery.toLowerCase())
//     )
//   );

//   const columns = [
//     {
//       title: (
//         <span>
//           <NumberOutlined style={{ marginRight: "5px", color: "#1890ff" }} /> No
//         </span>
//       ),
//       key: "no",
//       className: "centered-column",
//       render: (text, record, index) => {
//         const currentPage = pagination.current || 1;
//         const pageSize = pagination.pageSize || 10;
//         return (currentPage - 1) * pageSize + index + 1;
//       },
//     },
//     {
//       title: (
//         <span>
//           <SolutionOutlined
//             style={{ marginRight: "5px", color: "#52c41a" }}
//           />
//           Nama Driver
//         </span>
//       ),
//       dataIndex: "name",
//       key: "name",
//       className: "centered-column",
//     },
//     {
//       title: (
//         <span>
//           <PhoneOutlined style={{ marginRight: "5px", color: "#faad14" }} />
//           No. Telepon
//         </span>
//       ),
//       dataIndex: "phone",
//       key: "phone",
//       className: "centered-column",
//       render: (text) => (
//         <Tooltip title={text}>
//           <span>{text}</span>
//         </Tooltip>
//       ),
//     },
//     {
//       title: (
//         <span>
//           <IdcardOutlined style={{ marginRight: "5px", color: "#1890ff" }} />
//           No. KTP
//         </span>
//       ),
//       dataIndex: "ktp",
//       key: "ktp",
//       className: "centered-column",
//     },
//     {
//       title: (
//         <span>
//           <CarOutlined style={{ marginRight: "5px", color: "#52c41a" }} /> No. SIM
//         </span>
//       ),
//       dataIndex: "sim",
//       key: "sim",
//       className: "centered-column",
//     },
//     {
//       title: (
//         <span>
//           <CheckCircleOutlined
//             style={{ marginRight: "5px", color: "#13c2c2" }}
//           />
//           Status Driver
//         </span>
//       ),
//       dataIndex: "status",
//       key: "status",
//       className: "centered-column",
//       render: (text) => (text ? "Aktif" : "Non-Aktif"),
//     },
//     {
//       title: "Aksi",
//       key: "actions",
//       fixed: "right",
//       width: 100,
//       className: "centered-column",
//       render: (text, record) => (
//         <Space>
//           <Tooltip title="Edit Data">
//             <Button
//               color="primary" variant="filled"
//               type="link"
//               onClick={() => handleEdit(record)}
//             >
//               Edit
//             </Button>
//           </Tooltip>
//           <Tooltip title="Hapus Data">
//             <Popconfirm
//               title="Yakin ingin menghapus data ini?"
//               onConfirm={() => handleDelete(record.id)}
//               okText="Ya"
//               cancelText="Tidak"
//             >
//               <Button color="danger" variant="filled" type="link" danger>
//                 Hapus
//               </Button>
//             </Popconfirm>
//           </Tooltip>
//         </Space>
//       ),
//     },
//   ];

//   const handleEdit = (driver) => {
//     setEditingDriver(driver);
//     setModalVisible(true);
//   };

//   const handleDelete = (id) => {
//     setLoading(true);
//     Inertia.delete(`/drivers/${id}`, {
//       onSuccess: () => {
//         message.success("Data berhasil dihapus!");
//       },
//       onError: () => {
//         message.error("Gagal menghapus data");
//       },
//       onFinish: () => setLoading(false),
//     });
//   };

//   const resetModal = () => {
//     setEditingDriver(null);
//     setModalVisible(false);
//   };

//   return (
//     <Layout>
//       <div
//         style={{
//           padding: "20px",
//           backgroundColor: "#fff",
//           borderRadius: "5px",
//           boxShadow: "0 2px 4px rgba(0, 0, 0, 0.1)",
//         }}
//       >
//         <div
//           style={{
//             marginBottom: "20px",
//             display: "flex",
//             justifyContent: "space-between",
//           }}
//         >
//           <Input.Search
//             placeholder="Cari berdasarkan Nama, No. Telepon..."
//             style={{ width: "300px" }}
//             value={searchQuery}
//             onChange={(e) => setSearchQuery(e.target.value)}
//           />
//     <Button
//       type="primary"
//       icon={<PlusCircleOutlined />} // Tambahkan ikon di sini
//       onClick={() => setModalVisible(true)}
//     >
//       Tambah Driver Baru
//     </Button>
//         </div>

//         <Spin spinning={loading} tip="Memuat...">
//           <Table
//             className={styles.customTable}
//             columns={columns}
//             dataSource={filteredDrivers}
//             rowKey="id"
//             pagination={{
//               ...pagination,
//               onChange: (page, pageSize) =>
//                 setPagination({ current: page, pageSize }),
//             }}
//             scroll={{ x: "max-content" }}
//           />
//         </Spin>

//         <DriverFormModal
//           visible={modalVisible}
//           editingDriver={editingDriver}
//           onClose={resetModal}
//         />
//       </div>
//     </Layout>
//   );
// };

// export default DriverPage;
