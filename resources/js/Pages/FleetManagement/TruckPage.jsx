import React, { useState, useRef } from "react";
import { Inertia } from "@inertiajs/inertia";
import Layout from "@/Layouts/layout/layout.jsx";
import { DataTable } from "primereact/datatable";
import { Column } from "primereact/column";
import { InputText } from "primereact/inputtext";
import { Button } from "primereact/button";
import { Dialog } from "primereact/dialog";
import { Toolbar } from "primereact/toolbar";
import { Toast } from 'primereact/toast';  // Import Toast
import '../../../css/FleetManagement/truck.css/';  // Import CSS khusus untuk halaman Driver

const TruckPage = ({ trucks }) => {
    const [licensePlate, setLicensePlate] = useState('');
    const [truckType, setTruckType] = useState('');  // Tambahkan state untuk Truck Type
    const [typeYear, setTypeYear] = useState('');
    const [status, setStatus] = useState('');
    const [stnk, setStnk] = useState('');
    const [kir, setKir] = useState('');
    const [gps, setGps] = useState('');
    const [filteredTrucks, setFilteredTrucks] = useState([]);
    const [editingTruck, setEditingTruck] = useState(null);
    const [dialogVisible, setDialogVisible] = useState(false);
    const [confirmVisible, setConfirmVisible] = useState(false);
    const [truckToDelete, setTruckToDelete] = useState(null);
    const [globalFilter, setGlobalFilter] = useState('');
    const [errors, setErrors] = useState({});
    const toast = useRef(null);

    const handleSubmit = (e) => {
        e.preventDefault();
        if (editingTruck) {
            Inertia.put(`/trucks/${editingTruck.id}`, { licensePlate, truckType, typeYear, status, stnk, kir, gps }, {
                onError: (errors) => {
                    setErrors(errors);
                    showError(errors);
                }
            });
        } else {
            Inertia.post('/trucks', { licensePlate, truckType, typeYear, status, stnk, kir, gps }, {
                onError: (errors) => {
                    setErrors(errors);
                    showError(errors);
                }
            });
        }
        setLicensePlate('');
        setTruckType('');  // Reset state Truck Type
        setTypeYear('');
        setStatus('');
        setStnk('');
        setKir('');
        setGps('');
        setEditingTruck(null);
        setDialogVisible(false);
    };

    const showError = (errors) => {
        Object.keys(errors).forEach((key) => {
            toast.current.show({ severity: 'error', summary: 'Error', detail: errors[key], life: 3000 });
        });
    };

    const handleEdit = (truck) => {
        setEditingTruck(truck);
        setLicensePlate(truck.licensePlate);
        setTruckType(truck.truckType);  // Set state Truck Type
        setTypeYear(truck.typeYear);
        setStatus(truck.status);
        setStnk(truck.stnk);
        setKir(truck.kir);
        setGps(truck.gps);
        setDialogVisible(true);
    };

    const handleDelete = (id) => {
        setTruckToDelete(id);
        setConfirmVisible(true);
    };

    const confirmDelete = () => {
        Inertia.delete(`/trucks/${truckToDelete}`, {
            onSuccess: () => {
                window.location.reload();
            }
        });
        setConfirmVisible(false);
    };

    const leftToolbarTemplate = () => {
        return (
            <Button label="Tambah Truk" icon="pi pi-plus" className="p-button-add" onClick={() => setDialogVisible(true)} />
        );
    };

    const rightToolbarTemplate = () => {
        return (
            <span className="p-input-icon-left">
                <i className="pi pi-search" />
                <InputText type="search" onInput={(e) => setGlobalFilter(e.target.value)} placeholder="Cari No. Polisi, Tipe, Tahun..." />
            </span>
        );
    };

    const actionBodyTemplate = (rowData) => {
        return (
            <div className="truck-action-cell">
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
            <Toast ref={toast} /> {/* Tambahkan Toast */}
            <div className="content-container">
                <div className="p-grid">
                    <div className="p-col-12">
                        <div className="toolbar-container">
                            <Toolbar className="p-mb-4" left={leftToolbarTemplate} right={rightToolbarTemplate} />
                        </div>
                        <div className="table-menu-container">
                            <DataTable value={trucks} scrollable scrollHeight="576px" className="p-datatable-sm" globalFilter={globalFilter}>
                                <Column header="No" body={numberBodyTemplate} headerClassName="colom-header-content" className="truck-table-cell truck-column-number" />
                                <Column field="licensePlate" header="No. Polisi" filter filterPlaceholder="Search by No. Polisi" headerClassName="colom-header-content" className="truck-table-cell" />
                                <Column field="truckType" header="Truck Type" headerClassName="colom-header-content" className="truck-table-cell" /> {/* Tambahkan kolom Truck Type */}
                                <Column field="typeYear" header="Tipe & Tahun Truk" headerClassName="colom-header-content" className="truck-table-cell" />
                                <Column field="status" header="Status Truk" headerClassName="colom-header-content" className="truck-table-cell" />
                                <Column field="stnk" header="STNK" headerClassName="colom-header-content" className="truck-table-cell" />
                                <Column field="kir" header="KIR" headerClassName="colom-header-content" className="truck-table-cell" />
                                <Column field="gps" header="GPS" headerClassName="colom-header-content" className="truck-table-cell" />
                                <Column
                                    body={actionBodyTemplate}
                                    header="Aksi"
                                    headerClassName="colom-header-content"
                                    className="truck-table-cell"
                                />
                            </DataTable>
                        </div>
                    </div>
                </div>

                <Dialog header="Detail Truk" visible={dialogVisible} style={{ width: '30vw' }} modal onHide={() => setDialogVisible(false)}>
                    <form onSubmit={handleSubmit} className="p-fluid">
                        <div className="p-field">
                            <h6><label htmlFor="licensePlate">No. Polisi</label></h6>
                            <InputText id="licensePlate" value={licensePlate} onChange={(e) => setLicensePlate(e.target.value)} />
                        </div>
                        <div className="p-field">
                            <h6><label htmlFor="truckType">Truck Type</label></h6> {/* Tambahkan input Truck Type */}
                            <InputText id="truckType" value={truckType} onChange={(e) => setTruckType(e.target.value)} />
                        </div>
                        <div className="p-field">
                            <h6><label htmlFor="typeYear">Tipe & Tahun Truk</label></h6>
                            <InputText id="typeYear" value={typeYear} onChange={(e) => setTypeYear(e.target.value)} />
                        </div>
                        <div className="p-field">
                            <h6><label htmlFor="status">Status Truk</label></h6>
                            <InputText id="status" value={status} onChange={(e) => setStatus(e.target.value)} />
                        </div>
                        <div className="p-field">
                            <h6><label htmlFor="stnk">STNK</label></h6>
                            <InputText id="stnk" value={stnk} onChange={(e) => setStnk(e.target.value)} />
                        </div>
                        <div className="p-field">
                            <h6><label htmlFor="kir">KIR</label></h6>
                            <InputText id="kir" value={kir} onChange={(e) => setKir(e.target.value)} />
                        </div>
                        <div className="p-field">
                            <h6><label htmlFor="gps">GPS</label></h6>
                            <InputText id="gps" value={gps} onChange={(e) => setGps(e.target.value)} />
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
            </div>
        </Layout>
    );
};

export default TruckPage;
