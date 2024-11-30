import React, { useState, useEffect } from 'react';
import Layout from "@/Layouts/layout/layout.jsx";
import { DataTable } from 'primereact/datatable';
import { Column } from 'primereact/column';
import { InputText } from 'primereact/inputtext';
import { Button } from 'primereact/button';
import { Toolbar } from 'primereact/toolbar';
import { Dialog } from 'primereact/dialog';
import PropTypes from 'prop-types';
import '../../css/listorder.css';

const ListOrder = ({ orders = [], drivers = [], trucks = [], vendors = [] }) => {
    const [globalFilter, setGlobalFilter] = useState('');
    const [activePopup, setActivePopup] = useState(null);
    const [selectedOrder, setSelectedOrder] = useState(null);
    const [selectedDriver, setSelectedDriver] = useState(null);
    const [selectedTruck, setSelectedTruck] = useState(null);
    const [selectedVendor, setSelectedVendor] = useState(null);
    const [driverDialogVisible, setDriverDialogVisible] = useState(false);
    const [truckDialogVisible, setTruckDialogVisible] = useState(false);
    const [vendorDialogVisible, setVendorDialogVisible] = useState(false);

    useEffect(() => {
        const handleClickOutside = (event) => {
            if (activePopup && !event.target.closest('.popup') && !event.target.closest('.popup-anchor')) {
                setActivePopup(null);
            }
        };

        document.addEventListener('click', handleClickOutside);

        return () => {
            document.removeEventListener('click', handleClickOutside);
        };
    }, [activePopup]);

    useEffect(() => {
        if (selectedDriver || selectedTruck || selectedVendor) {
            console.log('Selected driver:', selectedDriver);
            console.log('Selected truck:', selectedTruck);
            console.log('Selected vendor:', selectedVendor);
        }
    }, [selectedDriver, selectedTruck, selectedVendor]);

    const leftToolbarTemplate = () => {
        return (
            <Button label="Create Order" icon="pi pi-plus" className="p-button-add" onClick={() => window.location.href='/orders/create'} />
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

    const numberBodyTemplate = (rowData, column) => {
        return column.rowIndex + 1;
    };

    const liveTrackingTemplate = (rowData) => {
        return (
            <Button
                label="Track"
                icon="pi pi-map"
                onClick={() => window.location.href = `/monitoring-order/${rowData.id}`}
            />
        );
    };

    const addressPopupTemplate = (rowData, column, fieldName) => {
        const addressData = rowData[fieldName.replace('_name', '_address')] || [];
        return (
            <div className="popup-anchor">
                <span onClick={() => setActivePopup(rowData.id + fieldName)}>{rowData[fieldName]}</span>
                {addressData.length > 0 && (
                    <div className={`popup ${activePopup === (rowData.id + fieldName) ? 'show' : ''}`}>
                        {addressData.map((address, index) => (
                            <div key={index}>
                                <strong>{address.name}</strong>
                                <p>{address.address}</p>
                            </div>
                        ))}
                    </div>
                )}
            </div>
        );
    };

    const unloadAddressesTemplate = (rowData) => {
        const unloadAddresses = rowData.unload_addresses_names || [];
        return (
            <ul className="bullet-number">
                {unloadAddresses.map((address, index) => (
                    <li key={index}>
                        <div className="popup-anchor">
                            <span onClick={() => setActivePopup(rowData.id + index)}>{address.name}</span>
                            <div className={`popup ${activePopup === (rowData.id + index) ? 'show' : ''}`}>
                                <strong>{address.name}</strong>
                                <p>{address.address}</p>
                            </div>
                        </div>
                    </li>
                ))}
            </ul>
        );
    };

    const assignDriverTemplate = (rowData) => {
        return (
            <span className="popup-anchor">
                <a href="#" onClick={(e) => {
                    e.preventDefault();
                    setSelectedOrder(rowData);
                    setSelectedDriver(null); // Reset selected driver
                    setDriverDialogVisible(true);
                }} className="assign-link">
                    {rowData.driver_name || 'Assign Driver'}
                </a>
            </span>
        );
    };

    const assignTruckTemplate = (rowData) => {
        return (
            <span className="popup-anchor">
                <a href="#" onClick={(e) => {
                    e.preventDefault();
                    setSelectedOrder(rowData);
                    setSelectedTruck(null); // Reset selected truck
                    setTruckDialogVisible(true);
                }} className="assign-link">
                    {rowData.truck_licensePlate || 'Assign Truck'}
                </a>
            </span>
        );
    };

    const assignVendorTemplate = (rowData) => {
        return (
            <span className="popup-anchor">
                <a href="#" onClick={(e) => {
                    e.preventDefault();
                    setSelectedOrder(rowData);
                    setSelectedVendor(null); // Reset selected vendor
                    setVendorDialogVisible(true);
                }} className="assign-link">
                    {rowData.vendor_name || 'Assign Vendor'}
                </a>
            </span>
        );
    };

    const assignDriver = () => {
        if (!selectedDriver) {
            alert('Please select a driver.');
            return;
        }

        fetch(`/orders/${selectedOrder.id}/assign-driver`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
            },
            body: JSON.stringify({ driver_id: selectedDriver })
        }).then(response => {
            if (response.ok) {
                window.location.reload();
            } else {
                alert('Failed to assign driver.');
            }
        }).catch(error => {
            console.error('Error assigning driver:', error);
            alert('An error occurred while assigning the driver.');
        });
    };

    const assignTruck = () => {
        if (!selectedTruck) {
            alert('Please select a truck.');
            return;
        }

        fetch(`/orders/${selectedOrder.id}/assign-truck`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
            },
            body: JSON.stringify({ truck_id: selectedTruck })
        }).then(response => {
            if (response.ok) {
                window.location.reload();
            } else {
                alert('Failed to assign truck.');
            }
        }).catch(error => {
            console.error('Error assigning truck:', error);
            alert('An error occurred while assigning the truck.');
        });
    };

    const assignVendor = () => {
        if (!selectedVendor) {
            alert('Please select a vendor.');
            return;
        }

        fetch(`/orders/${selectedOrder.id}/assign-vendor`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
            },
            body: JSON.stringify({ vendor_id: selectedVendor })
        }).then(response => {
            if (!response.ok) {
                return response.json().then(err => { throw new Error(err.message) });
            }
            return response.json();
        }).then(data => {
            console.log(data.message);
            window.location.reload();
        }).catch(error => {
            console.error('Error assigning vendor:', error.message);
            alert('An error occurred while assigning the vendor.');
        });
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
                            <DataTable value={orders} scrollable scrollHeight="576px" className="p-datatable-sm" globalFilter={globalFilter}>
                                <Column header="No" body={numberBodyTemplate} headerClassName="listorder-header" className="listorder-table-cell listorder-column-number" style={{ minWidth: '50px' }} />
                                <Column field="nomor_order" header="Nomor Order" headerClassName="listorder-header" className="listorder-table-cell" style={{ minWidth: '170px' }} />
                                <Column field="customer_name" header="Customer" sortable filter filterPlaceholder="Search by customer" headerClassName="listorder-header" className="listorder-table-cell" style={{ minWidth: '150px' }} />
                                <Column field="service_name" header="Servis" sortable filter filterPlaceholder="Search by service" headerClassName="listorder-header" className="listorder-table-cell" style={{ minWidth: '120px' }} />
                                <Column field="load_address_name" header="Lokasi Muat" body={(rowData, column) => addressPopupTemplate(rowData, column, 'load_address_name')} headerClassName="listorder-header" className="listorder-table-cell" style={{ minWidth: '170px' }} />
                                <Column header="Lokasi Bongkar" body={unloadAddressesTemplate} headerClassName="listorder-header" className="listorder-table-cell" style={{ minWidth: '250px' }} />
                                <Column field="typetrucks_name" header="Tipe Truk" headerClassName="listorder-header" className="listorder-table-cell" style={{ minWidth: '100px' }} />
                                <Column field="tanggal_muat" header="Tanggal Muat" body={row => new Date(row.tanggal_muat).toLocaleDateString()} sortable filter filterPlaceholder="Search by tanggal muat" headerClassName="listorder-header" className="listorder-table-cell" style={{ minWidth: '160px' }} />
                                <Column field="jumlah_armada" header="Jumlah Armada" headerClassName="listorder-header" className="listorder-table-cell" style={{ minWidth: '120px' }} />
                                <Column field="nama_muatan" header="Nama Muatan" headerClassName="listorder-header" className="listorder-table-cell" style={{ minWidth: '150px' }} />
                                <Column field="berat_muatan" header="Berat" headerClassName="listorder-header" className="listorder-table-cell" style={{ minWidth: '100px' }} />
                                <Column field="volume_muatan" header="Volume" headerClassName="listorder-header" className="listorder-table-cell" style={{ minWidth: '100px' }} />
                                <Column field="jumlah_barang" header="Jumlah Barang" headerClassName="listorder-header" className="listorder-table-cell" style={{ minWidth: '120px' }} />
                                <Column field="uang_jalan" header="Uang Jalan" headerClassName="listorder-header" className="listorder-table-cell" style={{ minWidth: '100px' }} />
                                <Column field="uang_tol" header="Uang Tol" headerClassName="listorder-header" className="listorder-table-cell" style={{ minWidth: '100px' }} />
                                <Column field="catatan" header="Catatan" headerClassName="listorder-header" className="listorder-table-cell" style={{ minWidth: '200px' }} />
                                <Column header="Driver" body={assignDriverTemplate} headerClassName="listorder-header" className="listorder-table-cell" style={{ minWidth: '150px' }} />
                                <Column header="Truck" body={assignTruckTemplate} headerClassName="listorder-header" className="listorder-table-cell" style={{ minWidth: '150px' }} />
                                <Column header="Vendor" body={assignVendorTemplate} headerClassName="listorder-header" className="listorder-table-cell" style={{ minWidth: '150px' }} />
                                <Column field="current_status" header="Current Status" headerClassName="listorder-header" className="listorder-table-cell" style={{ minWidth: '150px', textAlign: 'center' }} />
                                <Column header="Live Tracking" body={liveTrackingTemplate} headerClassName="listorder-header" className="listorder-table-cell" style={{ minWidth: '150px' }} />
                            </DataTable>
                        </div>
                    </div>
                </div>
            </div>

            <Dialog header="Select Driver" visible={driverDialogVisible} style={{ width: '50vw' }} modal onHide={() => setDriverDialogVisible(false)}>
                <div className="p-grid">
                    {drivers.map(driver => (
                        <div key={driver.id} className="p-col-12 p-md-4">
                            <div className={`driver-item ${selectedDriver === driver.id ? 'selected' : ''}`} onClick={() => setSelectedDriver(driver.id)}>
                                <h4>{driver.name}</h4>
                                <p>ID: {driver.id}</p>
                            </div>
                        </div>
                    ))}
                </div>
                <div className="p-d-flex p-jc-end">
                    <Button label="Cancel" icon="pi pi-times" className="p-button-text p-mr-2" onClick={() => setDriverDialogVisible(false)} />
                    <Button label="Assign" icon="pi pi-check" className="p-button-primary" onClick={assignDriver} />
                </div>
            </Dialog>

            <Dialog header="Select Truck" visible={truckDialogVisible} style={{ width: '50vw' }} modal onHide={() => setTruckDialogVisible(false)}>
                <div className="p-grid">
                    {trucks.map(truck => (
                        <div key={truck.id} className="p-col-12 p-md-4">
                            <div className={`truck-item ${selectedTruck === truck.id ? 'selected' : ''}`} onClick={() => setSelectedTruck(truck.id)}>
                                <h4>{truck.licensePlate}</h4>
                                <p>ID: {truck.id}</p>
                            </div>
                        </div>
                    ))}
                </div>
                <div className="p-d-flex p-jc-end">
                    <Button label="Cancel" icon="pi pi-times" className="p-button-text p-mr-2" onClick={() => setTruckDialogVisible(false)} />
                    <Button label="Assign" icon="pi pi-check" className="p-button-primary" onClick={assignTruck} />
                </div>
            </Dialog>

            <Dialog header="Select Vendor" visible={vendorDialogVisible} style={{ width: '50vw' }} modal onHide={() => setVendorDialogVisible(false)}>
                <div className="p-grid">
                    {vendors.map(vendor => (
                        <div key={vendor.id} className="p-col-12 p-md-4">
                            <div 
                                className={`vendor-item ${selectedVendor === vendor.id ? 'selected' : ''}`} 
                                onClick={() => setSelectedVendor(vendor.id)}
                                style={{ cursor: 'pointer', padding: '10px', border: '1px solid #ccc', borderRadius: '5px', marginBottom: '10px' }}
                            >
                                <h4>{vendor.name}</h4>
                                <p>ID: {vendor.id}</p>
                            </div>
                        </div>
                    ))}
                </div>
                <div className="p-d-flex p-jc-end">
                    <Button label="Cancel" icon="pi pi-times" className="p-button-text p-mr-2" onClick={() => setVendorDialogVisible(false)} />
                    <Button label="Assign" icon="pi pi-check" className="p-button-primary" onClick={assignVendor} />
                </div>
            </Dialog>
        </Layout>
    );
};

ListOrder.propTypes = {
    orders: PropTypes.array,
    drivers: PropTypes.array,
    trucks: PropTypes.array,
    vendors: PropTypes.array,
};

export default ListOrder;
