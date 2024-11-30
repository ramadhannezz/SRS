import React, { useState } from 'react';
import { Inertia } from '@inertiajs/inertia';
import { Dialog } from 'primereact/dialog';
import { Button } from 'primereact/button';
import { InputText } from 'primereact/inputtext';
import { FileUpload } from 'primereact/fileupload';
import { DataTable } from 'primereact/datatable';
import { Column } from 'primereact/column';
import { Toolbar } from 'primereact/toolbar';
import { ConfirmDialog, confirmDialog } from 'primereact/confirmdialog';
import Layout from '@/Layouts/layout/layout.jsx';
import '../../../css/kategorilokasi.css';  // Import CSS khusus untuk halaman Kategori Lokasi

const KategoriLokasiPage = ({ kategoriLokasi }) => {
    const [displayDialog, setDisplayDialog] = useState(false);
    const [name, setName] = useState('');
    const [icon, setIcon] = useState(null);
    const [previewIcon, setPreviewIcon] = useState(null);
    const [editing, setEditing] = useState(false);
    const [editId, setEditId] = useState(null);
    const [globalFilter, setGlobalFilter] = useState('');

    const openNew = () => {
        setName('');
        setIcon(null);
        setPreviewIcon(null);
        setEditing(false);
        setDisplayDialog(true);
    }

    const hideDialog = () => {
        setDisplayDialog(false);
    }

    const saveData = () => {
        const formData = new FormData();
        formData.append('name', name);
        if (icon) {
            formData.append('icon', icon);
        }

        if (editing) {
            Inertia.post(`/kategori-lokasi/${editId}`, formData, {
                method: 'put',
                headers: {
                    'X-HTTP-Method-Override': 'PUT'
                }
            });
        } else {
            Inertia.post('/kategori-lokasi', formData);
        }

        hideDialog();
    }

    const editData = (rowData) => {
        setName(rowData.name);
        setPreviewIcon(`/storage/${rowData.icon}`);
        setEditing(true);
        setEditId(rowData.id);
        setDisplayDialog(true);
    }

    const deleteData = (id) => {
        confirmDialog({
            message: 'Apakah Anda yakin ingin menghapus data ini?',
            header: 'Konfirmasi Penghapusan',
            icon: 'pi pi-exclamation-triangle',
            accept: () => {
                Inertia.post(`/kategori-lokasi/${id}`, {
                    _method: 'delete'
                });
            }
        });
    }

    const onIconSelect = (e) => {
        const file = e.files[0];
        setIcon(file);
        const reader = new FileReader();
        reader.onload = (e) => {
            setPreviewIcon(e.target.result);
        };
        reader.readAsDataURL(file);
    }

    const actionBodyTemplate = (rowData) => {
        return (
            <div className="kota-action-cell">
                <Button label="Edit" onClick={() => editData(rowData)} className="p-button-warning-edit" />
                <Button label="Delete" onClick={() => deleteData(rowData.id)} className="p-button-danger" />
            </div>
        );
    }

    const indexBodyTemplate = (rowData, props) => {
        return props.rowIndex + 1;
    }

    const leftToolbarTemplate = () => {
        return (
            <Button label="Tambah" icon="pi pi-plus" className="p-button-add" onClick={openNew} />
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

    return (
        <Layout>
            <div className="content-container">
                <div className="p-grid">
                    <div className="p-col-12">
                        <div className="toolbar-container">
                            <Toolbar className="p-mb-4" left={leftToolbarTemplate} right={rightToolbarTemplate} />
                        </div>
                        <div className="table-menu-container">
                            <DataTable value={kategoriLokasi} scrollable scrollHeight="576px" className="p-datatable-sm" globalFilter={globalFilter}>
                                <Column header="No" body={indexBodyTemplate} headerClassName="colom-header-content" className="kota-table-cell kota-column-number" />
                                <Column field="name" header="Nama" filter filterPlaceholder="Search by name" headerClassName="colom-header-content" className="kota-table-cell" />
                                <Column field="icon" header="Icon" body={(data) => { console.log(`/storage/${data.icon}`); return <img src={`/storage/${data.icon}`} alt={data.name} width="50" /> }} headerClassName="colom-header-content" className="kota-table-cell" />
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

                <Dialog header={editing ? "Edit Kategori Lokasi" : "Tambah Kategori Lokasi"} visible={displayDialog} style={{ width: '30vw' }} modal onHide={hideDialog}>
                    <form onSubmit={saveData} className="p-fluid">
                        <div className="p-field">
                            <h6><label htmlFor="name">Nama</label></h6>
                            <InputText id="name" value={name} onChange={(e) => setName(e.target.value)} />
                        </div><br />
                        <div className="p-field">
                            <h6><label htmlFor="icon">Icon</label></h6>
                            <FileUpload mode="basic" name="icon" accept="image/*" maxFileSize={1000000} onSelect={onIconSelect} className="p-mb-2" />
                            {previewIcon && <img src={previewIcon} alt="Preview" width="100" className="p-mt-2" />}
                        </div><br></br>
                        <Button type="submit" label="Simpan" className="p-mt-2" />
                    </form>
                </Dialog>

                <ConfirmDialog />
            </div>
        </Layout>
    );
}

export default KategoriLokasiPage;
