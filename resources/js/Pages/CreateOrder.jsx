// CreateOrder.jsx
import React, { useState } from 'react';
import { Inertia } from '@inertiajs/inertia';
import Layout from "@/Layouts/layout/layout.jsx";
import axios from 'axios';
import '../../css/createorder.css';
import { Button } from 'primereact/button';
import { InputText } from 'primereact/inputtext';
import { Dropdown } from 'primereact/dropdown';
import { InputNumber } from 'primereact/inputnumber';
import { InputTextarea } from 'primereact/inputtextarea';
import { Card } from 'primereact/card';
import { ToggleButton } from 'primereact/togglebutton';
import { Checkbox } from 'primereact/checkbox';
import { Dialog } from 'primereact/dialog';
import { AdapterDayjs } from '@mui/x-date-pickers/AdapterDayjs';
import { LocalizationProvider } from '@mui/x-date-pickers/LocalizationProvider';
import { StaticDateTimePicker } from '@mui/x-date-pickers/StaticDateTimePicker';
import dayjs from 'dayjs';
import SmartRouting from '../Pages/SmartRouting/SmartRouting'; // Import komponen SmartRouting

const CreateOrder = ({ customers, services, typetrucks, lokasiMuat, lokasiBongkar, kotas, kategoriLokasi }) => {
    const [formData, setFormData] = useState({
        nomor_order: '',
        customers_id: '',
        services_id: '',
        typetrucks_id: '',
        tanggal_muat: new Date(),
        jumlah_armada: 1,
        nama_muatan: '',
        berat_muatan: null,
        volume_muatan: null,
        jumlah_barang: '',
        uang_jalan: null,
        uang_tol: null,
        catatan: '',
        isFavorite: false,
        load_address: null,  // Tambah state untuk load address
        unload_addresses: [],  // Tambah state untuk unload addresses
        routes: []  // Tambah state untuk rute yang dihasilkan
    });

    const [useSystemOrderNumber, setUseSystemOrderNumber] = useState(false);
    const [popupVisible, setPopupVisible] = useState(false);
    const [splitOrder, setSplitOrder] = useState(false);

    const handleChange = (e) => {
        setFormData({ ...formData, [e.target.name]: e.target.value });
    };

    const handleDateChange = (date) => {
        setFormData({ ...formData, tanggal_muat: date });
    };

    const handleToggleChange = (e) => {
        setSplitOrder(e.value);
    };

    const handleCheckboxChange = async (e) => {
        setUseSystemOrderNumber(e.checked);
        if (e.checked) {
            try {
                const response = await axios.get('/orders/generate-order-number');
                setFormData({ ...formData, nomor_order: response.data.nomor_order });
            } catch (error) {
                console.error("There was an error generating the order number!", error);
            }
        } else {
            setFormData({ ...formData, nomor_order: '' });
        }
    };

    const handleRoutingData = (loadAddress, unloadAddresses, routes) => {
        setFormData({
            ...formData,
            load_address: loadAddress,
            unload_addresses: unloadAddresses,
            routes: routes
        });
    };

    const handleSubmit = (e) => {
        e.preventDefault();
     
        if (splitOrder && formData.jumlah_armada > 1) {
            const orders = [];
            for (let i = 0; i < formData.jumlah_armada; i++) {
                orders.push({
                    ...formData,
                    nomor_order: `${formData.nomor_order}-${i + 1}`
                });
            }
     
            orders.forEach(order => {
                Inertia.post('/orders', order, {
                    onSuccess: () => {
                        // Tidak menggunakan Inertia, melainkan window.location.href
                        window.location.href = '/orders';
                    },
                    onError: (errors) => console.error("Request failed with errors:", errors)
                });
            });
        } else {
            Inertia.post('/orders', formData, {
                onSuccess: () => {
                    // Tidak menggunakan Inertia, melainkan window.location.href
                    window.location.href = '/orders';
                },
                onError: (errors) => console.error("Request failed with errors:", errors)
            });
        }
    };
    
    

    const customerOptions = customers.map(customer => ({ label: customer.name, value: customer.id }));
    const serviceOptions = services.map(service => ({ label: service.name, value: service.id }));
    const typetruckOptions = typetrucks.map(truck => ({ label: truck.name, value: truck.id }));

    return (
        <Layout>
            <div className="content-main">
                <div className="content-container">
                    <div className="p-grid">
                        <div className="p-col-12">
                            <form onSubmit={handleSubmit} className="p-fluid">
                                <Card title="Informasi Awal" className="mb-3">
                                    <div className="p-fluid form-flex-container">
                                        <div className="p-field p-col-12 p-md-4">
                                            <label htmlFor="nomor_order">Nomor Order</label>
                                            <InputText id="nomor_order" name="nomor_order" value={formData.nomor_order} onChange={handleChange} className="small-input" disabled={useSystemOrderNumber} />
                                            <div className="p-field-checkbox">
                                                <Checkbox inputId="useSystemOrderNumber" checked={useSystemOrderNumber} onChange={handleCheckboxChange} />
                                                <label htmlFor="useSystemOrderNumber">Gunakan Nomor Order by Sistem</label>
                                            </div>
                                        </div>
                                        <div className="p-field p-col-12 p-md-4">
                                            <label htmlFor="customers_id">Nama Customer</label>
                                            <Dropdown id="customers_id" name="customers_id" value={formData.customers_id} options={customerOptions} onChange={handleChange} placeholder="Pilih Customer" className="small-input" />
                                        </div>
                                        <div className="p-field p-col-12 p-md-4">
                                            <label htmlFor="services_id">Tipe Servis</label>
                                            <Dropdown id="services_id" name="services_id" value={formData.services_id} options={serviceOptions} onChange={handleChange} placeholder="Pilih Servis" className="small-input" />
                                        </div>
                                    </div>
                                </Card>

                                <Card title="Estimasi Waktu" className="mb-3">
                                    <div className="p-field p-grid">
                                        <label htmlFor="tanggal_muat" className="p-col-12 p-md-2">Estimasi Muat</label>
                                        <div className="p-col-12 p-md-10">
                                            <InputText id="tanggal_muat" value={dayjs(formData.tanggal_muat).format('YYYY-MM-DD HH:mm')} readOnly onClick={() => setPopupVisible(true)} />
                                        </div>
                                    </div>
                                </Card>

                                <Card title="Rute" className="mb-3">
                                    <SmartRouting
                                        lokasiMuat={lokasiMuat}
                                        lokasiBongkar={lokasiBongkar}
                                        kotas={kotas}
                                        kategoriLokasi={kategoriLokasi}
                                        onRoutingData={handleRoutingData}
                                    />
                                </Card>

                                <Card title="Armada" className="mb-3">
                                    <div className="p-fluid form-flex-container">
                                        <div className="p-field p-col-12 p-md-6">
                                            <label htmlFor="typetrucks_id">Tipe Truk</label>
                                            <Dropdown id="typetrucks_id" name="typetrucks_id" value={formData.typetrucks_id} options={typetruckOptions} onChange={handleChange} placeholder="Pilih Tipe Truk" className="small-input" />
                                        </div>
                                        <div className="p-field p-col-12 p-md-6">
                                            <label htmlFor="jumlah_armada">Jumlah Armada</label>
                                            <InputNumber id="jumlah_armada" name="jumlah_armada" value={formData.jumlah_armada} onValueChange={(e) => setFormData({ ...formData, jumlah_armada: e.value })} className="small-input" />
                                        </div>
                                    </div>
                                    <div className="p-field-checkbox">
                                        <ToggleButton onLabel="Gabung" offLabel="Pisah" checked={splitOrder} onChange={handleToggleChange} />
                                    </div>
                                </Card>

                                <Card title="Muatan" className="mb-3">
                                    <div className="p-field p-grid">
                                        <label htmlFor="nama_muatan" className="p-col-12 p-md-2">Nama Muatan</label>
                                        <div className="p-col-12 p-md-10">
                                            <InputText id="nama_muatan" name="nama_muatan" value={formData.nama_muatan} onChange={handleChange} placeholder="Masukkan nama muatan" />
                                        </div>
                                    </div>
                                    <div className="p-field p-grid">
                                        <label htmlFor="berat_muatan" className="p-col-12 p-md-2">Berat</label>
                                        <div className="p-col-12 p-md-10">
                                            <InputNumber id="berat_muatan" name="berat_muatan" value={formData.berat_muatan} onValueChange={(e) => setFormData({ ...formData, berat_muatan: e.value })} suffix=" kg" placeholder="Masukkan berat dalam kg" />
                                        </div>
                                    </div>
                                    <div className="p-field p-grid">
                                        <label htmlFor="volume_muatan" className="p-col-12 p-md-2">Volume</label>
                                        <div className="p-col-12 p-md-10">
                                            <InputNumber id="volume_muatan" name="volume_muatan" value={formData.volume_muatan} onValueChange={(e) => setFormData({ ...formData, volume_muatan: e.value })} suffix=" m³" placeholder="Masukkan volume dalam m³" />
                                        </div>
                                    </div>
                                    <div className="p-field p-grid">
                                        <label htmlFor="jumlah_barang" className="p-col-12 p-md-2">Jumlah Barang</label>
                                        <div className="p-col-12 p-md-10">
                                            <InputNumber id="jumlah_barang" name="jumlah_barang" value={formData.jumlah_barang} onValueChange={(e) => setFormData({ ...formData, jumlah_barang: e.value })} showButtons buttonLayout="horizontal" placeholder="Masukkan jumlah barang" />
                                        </div>
                                    </div>
                                </Card>

                                <Card title="Harga Pengiriman" className="mb-3">
                                    <div className="p-field p-grid">
                                        <label htmlFor="uang_jalan" className="p-col-12 p-md-2">Uang Jalan</label>
                                        <div className="p-col-12 p-md-10">
                                            <InputNumber id="uang_jalan" name="uang_jalan" value={formData.uang_jalan} onValueChange={(e) => setFormData({ ...formData, uang_jalan: e.value })} mode="currency" currency="IDR" locale="id-ID" placeholder="Rp. 0" />
                                        </div>
                                    </div>
                                    <div className="p-field p-grid">
                                        <label htmlFor="uang_tol" className="p-col-12 p-md-2">Uang Tol</label>
                                        <div className="p-col-12 p-md-10">
                                            <InputNumber id="uang_tol" name="uang_tol" value={formData.uang_tol} onValueChange={(e) => setFormData({ ...formData, uang_tol: e.value })} mode="currency" currency="IDR" locale="id-ID" placeholder="Rp. 0" />
                                        </div>
                                    </div>
                                </Card>

                                <Card title="Permintaan Khusus" className="mb-3">
                                    <div className="p-field p-grid">
                                        <label htmlFor="catatan" className="p-col-12 p-md-2">Catatan</label>
                                        <div className="p-col-12 p-md-10">
                                            <InputTextarea id="catatan" name="catatan" value={formData.catatan} onChange={handleChange} autoResize placeholder="Masukkan catatan" />
                                        </div>
                                    </div>
                                </Card>

                                <Button type="submit" label="Buat Order" className="p-button-primary" onClick={() => window.location.href = '/orders'}/>

                            </form>
                        </div>
                    </div>
                </div>
                <div className="content-container-second">
                    <div className="floating-summary">
                        <Card title="Ringkasan Order">
                            <div className="p-card-body">
                                <p>Nomor Order: {formData.nomor_order}</p>
                                <p>Customer: {customers.find(c => c.id == formData.customers_id)?.name}</p>
                                <p>Servis: {services.find(s => s.id == formData.services_id)?.name}</p>
                                <p>Lokasi Muat: {formData.load_address?.name}</p>
                                {formData.unload_addresses.map((address, index) => (
                                    <p key={index}>Lokasi Bongkar {index + 1}: {address.name}</p>
                                ))}
                                <p>Truk: {typetrucks.find(t => t.id == formData.typetrucks_id)?.name}</p>
                                <p>Tanggal Muat: {formData.tanggal_muat.toLocaleDateString()}</p>
                                <p>Jumlah Armada: {formData.jumlah_armada}</p>
                                <p>Nama Muatan: {formData.nama_muatan}</p>
                                <p>Berat: {formData.berat_muatan}</p>
                                <p>Volume: {formData.volume_muatan}</p>
                                <p>Jumlah Barang: {formData.jumlah_barang}</p>
                                <p>Uang Jalan: {formData.uang_jalan}</p>
                                <p>Uang Tol: {formData.uang_tol}</p>
                                <p>Catatan: {formData.catatan}</p>
                            </div>
                        </Card>
                    </div>
                </div>

                <Dialog header="Pilih Tanggal dan Waktu" visible={popupVisible} style={{ width: '50vw' }} onHide={() => setPopupVisible(false)}>
                    <LocalizationProvider dateAdapter={AdapterDayjs}>
                        <StaticDateTimePicker
                            orientation="landscape"
                            value={dayjs(formData.tanggal_muat)}
                            onChange={(date) => {
                                handleDateChange(date.toDate());
                            }}
                            onAccept={() => setPopupVisible(false)}
                            onClose={() => setPopupVisible(false)}
                        />
                    </LocalizationProvider>
                </Dialog>
            </div>
        </Layout>
    );
};

export default CreateOrder;
