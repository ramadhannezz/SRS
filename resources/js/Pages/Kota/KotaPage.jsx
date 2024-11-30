import React, { useState } from "react";
import { Inertia } from "@inertiajs/inertia";
import Layout from "@/Layouts/layout/layout.jsx";
import { DataTable } from "primereact/datatable";
import { Column } from "primereact/column";
import { InputText } from "primereact/inputtext";
import { Button } from "primereact/button";
import { Dialog } from "primereact/dialog";
import { Toolbar } from "primereact/toolbar";
import { ConfirmDialog, confirmDialog } from 'primereact/confirmdialog';
import { AutoComplete } from 'primereact/autocomplete';
import '../../../css/kota.css';  // Import CSS khusus untuk halaman Kota

const KotaPage = ({ kotas }) => {
    const [name, setName] = useState('');
    const [region, setRegion] = useState('');
    const [filteredRegions, setFilteredRegions] = useState([]);
    const [editingKota, setEditingKota] = useState(null);
    const [dialogVisible, setDialogVisible] = useState(false);
    const [confirmVisible, setConfirmVisible] = useState(false);
    const [kotaToDelete, setKotaToDelete] = useState(null);
    const [globalFilter, setGlobalFilter] = useState('');

    const handleSubmit = (e) => {
        e.preventDefault();
        if (editingKota) {
            Inertia.put(`/kota/${editingKota.id}`, { name, region });
        } else {
            Inertia.post('/kota', { name, region });
        }
        setName('');
        setRegion('');
        setEditingKota(null);
        setDialogVisible(false);
    };

    const handleEdit = (kota) => {
        setEditingKota(kota);
        setName(kota.name);
        setRegion(kota.region);
        setDialogVisible(true);
    };

    const handleDelete = (id) => {
        setKotaToDelete(id);
        setConfirmVisible(true);
    };

    const confirmDelete = () => {
        Inertia.delete(`/kota/${kotaToDelete}`, {
            onSuccess: () => {
                window.location.reload();
            }
        });
        setConfirmVisible(false);
    };

    const searchRegion = (event) => {
        setTimeout(() => {
            let filteredRegions = regions.filter((region) => {
                return region.toLowerCase().startsWith(event.query.toLowerCase());
            });
            setFilteredRegions(filteredRegions);
        }, 250);
    };

    const leftToolbarTemplate = () => {
        return (
            <Button label="Tambah" icon="pi pi-plus" className="p-button-add" onClick={() => setDialogVisible(true)} />
        );
    };

    const rightToolbarTemplate = () => {
        return (
            <span className="p-input-icon-left">
                <i className="pi pi-search" />
                <InputText type="search" onInput={(e) => setGlobalFilter(e.target.value)} placeholder="Search..." />
            </span>
        );
    };

    const actionBodyTemplate = (rowData) => {
        return (
            <div className="kota-action-cell">
                <Button label="Edit" onClick={() => handleEdit(rowData)} className="p-button-warning-edit" />
                <Button label="Delete" onClick={() => handleDelete(rowData.id)} className="p-button-danger" />
            </div>
        );
    };

    const regions = ["DKI Jakarta", "Banten", "Jawa Barat", "Jawa Tengah", "Jawa Timur"]; // Daftar contoh region

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
                            <DataTable value={kotas} scrollable scrollHeight="576px" className="p-datatable-sm" globalFilter={globalFilter}>
                                <Column header="No" body={numberBodyTemplate} headerClassName="colom-header-content" className="kota-table-cell kota-column-number" />
                                <Column field="name" header="Kota" filter filterPlaceholder="Search by name" headerClassName="colom-header-content" className="kota-table-cell" />
                                <Column field="region" header="Provinsi" headerClassName="colom-header-content" className="kota-table-cell" />
                                <Column
                                    body={actionBodyTemplate}
                                    header="Aksi"
                                    headerClassName="colom-header-content"
                                    className="kota-table-cell"
                                />
                            </DataTable>
                        </div>
                    </div>
                </div>

                <Dialog header="Detail Kota" visible={dialogVisible} style={{ width: '30vw' }} modal onHide={() => setDialogVisible(false)}>
                    <form onSubmit={handleSubmit} className="p-fluid">
                        <div className="p-field">
                            <h6><label htmlFor="name">Kota</label></h6>
                            <InputText id="name" value={name} onChange={(e) => setName(e.target.value)} />
                        </div>
                        <div className="p-field">
                        <h6><label htmlFor="region">Provinsi</label></h6>
                            <AutoComplete id="region" value={region} suggestions={filteredRegions} completeMethod={searchRegion} onChange={(e) => setRegion(e.value)} />
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

                <ConfirmDialog />
            </div>
        </Layout>
    );
};

export default KotaPage;
