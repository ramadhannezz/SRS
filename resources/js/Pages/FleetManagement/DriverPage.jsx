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
