import React, { useEffect, useState } from "react";
import { Modal, Form, Input, Select, DatePicker, Button, Spin } from "antd";
import { Inertia } from "@inertiajs/inertia";
import { message } from "antd";
import dayjs from "dayjs";

const { Option } = Select;

const ClaimFormModal = ({ visible, onClose, orders, editingClaim }) => {
    const [form] = Form.useForm();
    const [loading, setLoading] = useState(false);
    const [selectedOrderData, setSelectedOrderData] = useState({
      nama_muatan: "",
      jumlah_barang: "",
    });
  
    // **Tambahkan useEffect untuk inisialisasi data saat Edit**
    useEffect(() => {
      if (editingClaim) {
        // Jika mode Edit, isi form dengan data yang dikirim
        form.setFieldsValue({
          orders_id: editingClaim.orders_id,
          nama_muatan_claim: editingClaim.nama_muatan_claim,
          jumlah_muatan_claim: editingClaim.jumlah_muatan_claim,
          catatan_muatan: editingClaim.catatan_muatan,
          status_muatan: editingClaim.status_muatan,
          created_at: dayjs(editingClaim.created_at),
        });
  
        // Set read-only data nama_muatan dan jumlah_barang
        setSelectedOrderData({
          nama_muatan_display: editingClaim.nama_muatan,
          jumlah_barang_display: editingClaim.jumlah_barang,
        });
      } else {
        // Jika mode Tambah, reset form
        form.resetFields();
        setSelectedOrderData({
          nama_muatan_display: "",
          jumlah_barang_display: "",
        });
      }
    }, [editingClaim, form]);
  
    useEffect(() => {
        if (!visible) {
          form.resetFields(); // Reset form saat modal ditutup
        }
      }, [visible, form]);
      

  // Handle ketika user memilih Order ID
  const handleOrderChange = (orderId) => {
    const selectedOrder = orders.find((order) => order.id === orderId);
  
    if (selectedOrder) {
      // Set nilai ID ke nama_muatan dan jumlah_barang untuk dikirim ke backend
      form.setFieldsValue({
        nama_muatan: selectedOrder.id,       // Kirim ID order ke nama_muatan
        jumlah_barang: selectedOrder.id,     // Kirim ID order ke jumlah_barang
      });
  
      // Simpan data aktual hanya untuk tampilan (read-only)
      setSelectedOrderData({
        nama_muatan_display: selectedOrder.nama_muatan,
        jumlah_barang_display: selectedOrder.jumlah_barang,
      });
    }
  };

  const handleSave = () => {
    form.validateFields().then((values) => {
      setLoading(true);
  
      // Dapatkan selectedOrder untuk logika tambah
      const selectedOrder = orders.find((order) => order.id === values.orders_id);
  
      // Siapkan payload (data yang dikirim ke backend)
      const payload = {
        orders_id: selectedOrder ? selectedOrder.id : editingClaim.orders_id,
        nama_muatan: selectedOrder ? selectedOrder.id : editingClaim.nama_muatan, // ID order di mode Tambah/Edit
        jumlah_barang: selectedOrder ? selectedOrder.id : editingClaim.jumlah_barang, // ID order di mode Tambah/Edit
        status_muatan: values.status_muatan,
        nama_muatan_claim: values.nama_muatan_claim,
        jumlah_muatan_claim: values.jumlah_muatan_claim,
        catatan_muatan: values.catatan_muatan,
        created_at: values.created_at
          ? values.created_at.format("YYYY-MM-DD HH:mm:ss")
          : null,
      };
  
      console.log("Payload yang dikirim ke backend:", payload);
  
      if (editingClaim) {
        // **Mode Edit**: Kirim PUT request
        Inertia.put(`/claims/${editingClaim.id_claim}`, payload, {
          onSuccess: () => {
            message.success("Data berhasil diperbarui!");
            form.resetFields(); // Reset form
            onClose();
          },
          onError: (errors) => {
            console.error("Terjadi kesalahan:", errors);
            setLoading(false);
          },
          onFinish: () => {
            setLoading(false);
            form.resetFields(); // Reset form
            console.log("Edit selesai.");
            onClose();
            message.success("Data berhasil disimpan!"); // Tampilkan alert sukses
          },
        });
      } else {
        // **Mode Tambah**: Kirim POST request
        Inertia.post("/claims", payload, {
          onSuccess: () => {
            message.success("Data berhasil disimpan!");
            onClose();
            form.resetFields(); // Reset form
            message.success("Data berhasil disimpan!"); // Tampilkan alert sukses
          },
          onError: (errors) => {
            console.error("Terjadi kesalahan:", errors);
            setLoading(false);
          },
          onFinish: () => {
            setLoading(false);
            form.resetFields(); // Reset form
            console.log("Tambah selesai.");
            onClose();
            message.success("Data berhasil disimpan!"); // Tampilkan alert sukses
          },
        });
      }
    });
  };
  
  
  

  return (
<Modal
  title={editingClaim ? "Edit Claim" : "Tambah Claim Baru"}
  visible={visible}
  onCancel={onClose}
  footer={[
    <Button key="cancel" onClick={onClose}>
      Batal
    </Button>,
    <Button key="save" type="primary" onClick={handleSave} loading={loading}>
      {editingClaim ? "Update" : "Simpan"}
    </Button>,
  ]}
    >
      <Spin spinning={loading} tip="Menyimpan data...">
        <Form form={form} layout="vertical">
          {/* Dropdown Order ID */}
          <Form.Item
            name="orders_id"
            label="Order ID"
            rules={[{ required: true, message: "Order ID wajib dipilih" }]}
          >
            <Select
              placeholder="Pilih Nomor Order"
              onChange={handleOrderChange}
            >
              {orders.map((order) => (
                <Option key={order.id} value={order.id}>
                  {order.nomor_order}
                </Option>
              ))}
            </Select>
          </Form.Item>

            {/* Input ID nama_muatan (Hidden) */}
            <Form.Item name="nama_muatan" style={{ display: "none" }}>
            <Input type="hidden" />
            </Form.Item>

            {/* Input Read-Only Nama Muatan */}
            <Form.Item label="Nama Barang">
            <Input value={selectedOrderData.nama_muatan_display} readOnly />
            </Form.Item>

            {/* Input ID jumlah_barang (Hidden) */}
            <Form.Item name="jumlah_barang" style={{ display: "none" }}>
            <Input type="hidden" />
            </Form.Item>

            {/* Input Read-Only Jumlah Barang */}
            <Form.Item label="Jumlah Barang">
            <Input value={selectedOrderData.jumlah_barang_display} readOnly />
            </Form.Item>


          {/* Status Muatan */}
          <Form.Item
            name="status_muatan"
            label="Status Barang"
            rules={[{ required: true, message: "Status Muatan wajib dipilih" }]}
          >
            <Select placeholder="Pilih Status Barang">
              <Option value="Rusak">Rusak</Option>
              <Option value="Hilang">Hilang</Option>
              <Option value="Kurang">Kurang</Option>
              <Option value="Lebih">Lebih</Option>
            </Select>
          </Form.Item>

          <Form.Item name="nama_muatan_claim" label="Nama Barang Claim" rules={[{ required: true, message: "Nama barang yang di klaim wajib di isi" }]}>
            <Input placeholder="Masukkan Nama Barang Claim" />
          </Form.Item>

          <Form.Item name="jumlah_muatan_claim" label="Jumlah Barang Claim" rules={[{ required: true, message: "Jumlah barang yang di klaim wajib di isi" }]}>
            <Input type="number" placeholder="Masukkan Jumlah Barang Claim" />
          </Form.Item>

          <Form.Item name="catatan_muatan" label="Kronologi Kejadian" rules={[{ required: true, message: "Kronologi kejadian yang di klaim wajib di isi" }]}>
            <Input.TextArea rows={3} placeholder="Masukkan Catatan Barang" />
          </Form.Item>

          <Form.Item name="created_at" label="Waktu Kejadian" rules={[{ required: true, message: "Waktu kejadian wajib di isi" }]}>
            <DatePicker
              showTime
              placeholder="Pilih Waktu Kejadian"
              format="YYYY-MM-DD HH:mm:ss"
            />
          </Form.Item>
        </Form>
      </Spin>
    </Modal>
  );
};

export default ClaimFormModal;