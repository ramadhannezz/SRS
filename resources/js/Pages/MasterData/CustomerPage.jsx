import React, { useState } from "react";
import { Inertia } from "@inertiajs/inertia";
import Layout from "@/Layouts/layout/layout.jsx";
import { DataTable } from "primereact/datatable";
import { Column } from "primereact/column";
import { InputText } from "primereact/inputtext";
import { Button } from "primereact/button";
import { Dialog } from "primereact/dialog";
import { Toolbar } from "primereact/toolbar";
import { ConfirmDialog } from 'primereact/confirmdialog';
import '../../../css/MasterData/customer.css';  // Import CSS khusus untuk halaman Customer

const CustomerPage = ({ customers }) => {
    const [name, setName] = useState('');
    const [email, setEmail] = useState('');
    const [phone, setPhone] = useState('');
    const [editingCustomer, setEditingCustomer] = useState(null);
    const [dialogVisible, setDialogVisible] = useState(false);
    const [confirmVisible, setConfirmVisible] = useState(false);
    const [customerToDelete, setCustomerToDelete] = useState(null);
    const [globalFilter, setGlobalFilter] = useState('');

    const handleSubmit = (e) => {
        e.preventDefault();
        if (editingCustomer) {
            Inertia.put(`/customer/${editingCustomer.id}`, { name, email, phone });
        } else {
            Inertia.post('/customer', { name, email, phone });
        }
        setName('');
        setEmail('');
        setPhone('');
        setEditingCustomer(null);
        setDialogVisible(false);
    };

    const handleEdit = (customer) => {
        setEditingCustomer(customer);
        setName(customer.name);
        setEmail(customer.email);
        setPhone(customer.phone);
        setDialogVisible(true);
    };

    const handleDelete = (id) => {
        setCustomerToDelete(id);
        setConfirmVisible(true);
    };

    const confirmDelete = () => {
        Inertia.delete(`/customer/${customerToDelete}`, {
            onSuccess: () => {
                window.location.reload();
            }
        });
        setConfirmVisible(false);
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
            <div className="customer-action-cell">
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
                            <DataTable value={customers} scrollable scrollHeight="576px" className="p-datatable-sm" globalFilter={globalFilter}>
                                <Column header="No" body={numberBodyTemplate} headerClassName="colom-header-content" className="customer-table-cell customer-column-number" />
                                <Column field="name" header="Nama" filter filterPlaceholder="Search by name" headerClassName="colom-header-content" className="customer-table-cell" />
                                <Column field="email" header="Email" headerClassName="colom-header-content" className="customer-table-cell" />
                                <Column field="phone" header="Telepon" headerClassName="colom-header-content" className="customer-table-cell" />
                                <Column
                                    body={actionBodyTemplate}
                                    header="Aksi"
                                    headerClassName="colom-header-content"
                                    className="customer-table-cell"
                                />
                            </DataTable>
                        </div>
                    </div>
                </div>

                <Dialog header="Detail Customer" visible={dialogVisible} style={{ width: '30vw' }} modal onHide={() => setDialogVisible(false)}>
                    <form onSubmit={handleSubmit} className="p-fluid">
                        <div className="p-field">
                            <h6><label htmlFor="name">Nama</label></h6>
                            <InputText id="name" value={name} onChange={(e) => setName(e.target.value)} />
                        </div>
                        <div className="p-field">
                            <h6><label htmlFor="email">Email</label></h6>
                            <InputText id="email" value={email} onChange={(e) => setEmail(e.target.value)} />
                        </div>
                        <div className="p-field">
                            <h6><label htmlFor="phone">Telepon</label></h6>
                            <InputText id="phone" value={phone} onChange={(e) => setPhone(e.target.value)} />
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

export default CustomerPage;
