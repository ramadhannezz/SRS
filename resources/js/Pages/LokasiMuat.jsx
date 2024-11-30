import React, { useState } from 'react';
import { Inertia } from '@inertiajs/inertia';
import Layout from "@/Layouts/layout/layout.jsx";
import { DataTable } from 'primereact/datatable';
import { Column } from 'primereact/column';
import { Button } from 'primereact/button';
import { Dialog } from 'primereact/dialog';
import { InputText } from 'primereact/inputtext';
import { Dropdown } from 'primereact/dropdown';
import { GoogleMap, LoadScript, Marker } from '@react-google-maps/api';
import { Toolbar } from 'primereact/toolbar';
import { ConfirmDialog, confirmDialog } from 'primereact/confirmdialog';  // Tambahkan import ini
import '../../css/lokasimuat.css';  // Import CSS khusus untuk halaman Lokasi Muat

const LokasiMuat = ({ lokasiMuat, kotas, kategoriLokasi, googleMapsApiKey }) => {
    const [displayDialog, setDisplayDialog] = useState(false);
    const [deleteDialog, setDeleteDialog] = useState(false);
    const [searchQuery, setSearchQuery] = useState("");
    const [currentLokasi, setCurrentLokasi] = useState({
        id: null, name: '', address: '', kotas_id: '', coordinate: '', kategori_lokasi_id: ''
    });
    const [selectedLokasi, setSelectedLokasi] = useState(null);

    // Convert kota and kategoriLokasi data to dropdown format
    const kotaOptions = kotas.map(kota => ({ label: kota.name, value: kota.id }));
    const kategoriLokasiOptions = kategoriLokasi.map(kategori => ({ label: kategori.name, value: kategori.id }));

    const openNew = () => {
        setCurrentLokasi({ id: null, name: '', address: '', kotas_id: '', coordinate: '', kategori_lokasi_id: '' });
        setDisplayDialog(true);
    };

    const saveLokasi = (e) => {
        e.preventDefault();
        if (currentLokasi.id) {
            Inertia.put(route('lokasiMuat.update', currentLokasi.id), currentLokasi);
        } else {
            Inertia.post(route('lokasiMuat.store'), currentLokasi);
        }
        setDisplayDialog(false);
    };

    const editLokasi = (lokasi) => {
        setCurrentLokasi({ ...lokasi });
        setDisplayDialog(true);
    };

    const confirmDeleteLokasi = (lokasi) => {
        setSelectedLokasi(lokasi);
        setDeleteDialog(true);
    };

    const deleteLokasi = () => {
        Inertia.delete(route('lokasiMuat.destroy', selectedLokasi.id));
        setDeleteDialog(false);
    };

    const onInputChange = (e, name) => {
        const val = (e.target && e.target.value) || '';
        let _lokasi = { ...currentLokasi };
        _lokasi[`${name}`] = val;

        setCurrentLokasi(_lokasi);
    };

    const leftToolbarTemplate = () => {
        return (
            <Button label="Tambah" icon="pi pi-plus" className="p-button-add" onClick={openNew} />
        );
    };

    const rightToolbarTemplate = () => {
        return (
            <span className="p-input-icon-left">
                <i className="pi pi-search" />
                <InputText type="search" onInput={(e) => setSearchQuery(e.target.value)} placeholder="Search..." />
            </span>
        );
    };

    const actionBodyTemplate = (rowData) => {
        return (
            <div className="kota-action-cell">
                <Button label="Edit" onClick={() => editLokasi(rowData)} className="p-button-warning-edit" />
                <Button label="Delete" onClick={() => confirmDeleteLokasi(rowData)} className="p-button-danger" />
            </div>
        );
    };

    const indexBodyTemplate = (rowData, props) => {
        return props.rowIndex + 1;
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
                            <DataTable value={lokasiMuat.data} paginator rows={10} globalFilter={searchQuery} emptyMessage="No records found" scrollable scrollHeight="576px" className="p-datatable-sm">
                                <Column header="No" body={indexBodyTemplate} headerClassName="colom-header-content" className="kota-table-cell kota-column-number" />
                                <Column field="name" header="Name" filter filterPlaceholder="Search by name" headerClassName="colom-header-content" className="kota-table-cell" />
                                <Column field="address" header="Address" headerClassName="colom-header-content" className="kota-table-cell" />
                                <Column field="kota.name" header="City" headerClassName="colom-header-content" className="kota-table-cell" />
                                <Column field="coordinate" header="Coordinate" headerClassName="colom-header-content" className="kota-table-cell" />
                                <Column field="kategori_lokasi.name" header="Category" headerClassName="colom-header-content" className="kota-table-cell" />
                                <Column body={actionBodyTemplate} header="Action" headerClassName="colom-header-content" className="kota-table-cell" />
                            </DataTable>
                        </div>
                    </div>
                </div>

                <Dialog header={currentLokasi.id ? "Edit Lokasi" : "Tambah Lokasi"} visible={displayDialog} style={{ width: '30vw' }} modal onHide={() => setDisplayDialog(false)}>
                    <form onSubmit={saveLokasi} className="p-fluid">
                        <div className="p-field">
                            <h6><label htmlFor="name">Name</label></h6>
                            <InputText id="name" value={currentLokasi.name} onChange={(e) => onInputChange(e, 'name')} />
                        </div>
                        <div className="p-field">
                            <h6><label htmlFor="address">Address</label></h6>
                            <InputText id="address" value={currentLokasi.address} onChange={(e) => onInputChange(e, 'address')} />
                        </div>
                        <div className="p-field">
                            <h6><label htmlFor="kotas_id">City</label></h6>
                            <Dropdown id="kotas_id" value={currentLokasi.kotas_id} options={kotaOptions} onChange={(e) => onInputChange(e, 'kotas_id')} placeholder="Select a City" />
                        </div>
                        <div className="p-field">
                            <h6><label htmlFor="coordinate">Coordinate</label></h6>
                            <InputText id="coordinate" value={currentLokasi.coordinate} onChange={(e) => onInputChange(e, 'coordinate')} />
                        </div>
                        <div className="p-field">
                            <h6><label htmlFor="kategori_lokasi_id">Category</label></h6>
                            <Dropdown id="kategori_lokasi_id" value={currentLokasi.kategori_lokasi_id} options={kategoriLokasiOptions} onChange={(e) => onInputChange(e, 'kategori_lokasi_id')} placeholder="Select a Category" />
                        </div>
                        <Button type="submit" label="Save" className="p-mt-2" />
                    </form>
                </Dialog>

                <Dialog header="Confirm" visible={deleteDialog} style={{ width: '350px' }} modal onHide={() => setDeleteDialog(false)} footer={
                    <div className="p-d-flex p-jc-end">
                        <Button label="No" icon="pi pi-times" onClick={() => setDeleteDialog(false)} className="p-button-text p-mr-2" />
                        <Button label="Yes" icon="pi pi-check" onClick={deleteLokasi} className="p-button-danger" />
                    </div>
                }>
                    <div className="confirmation-content">
                        <i className="pi pi-exclamation-triangle mr-3" style={{ fontSize: '2rem' }} />
                        {selectedLokasi && <span>Are you sure you want to delete <b>{selectedLokasi.name}</b>?</span>}
                    </div>
                </Dialog>

                <ConfirmDialog />
            </div>

            <div className="content-container" style={{ marginTop: '20px' }}>
                <GoogleMap
                    mapContainerStyle={{ height: '400px', width: '100%' }}
                    center={{ lat: -6.200000, lng: 106.816666 }}
                    zoom={13}
                >
                    {lokasiMuat.data.map((lokasi) => {
                    const [lat, lng] = lokasi.coordinate.split(',').map(coord => parseFloat(coord.trim()));
                    return (
                        <Marker key={lokasi.id} position={{ lat, lng }} />
                    );
                    })}
                </GoogleMap>
            </div>
        </Layout>
    );
};

export default LokasiMuat;
