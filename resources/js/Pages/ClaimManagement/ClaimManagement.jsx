import React, { useState } from "react";
import { Inertia } from "@inertiajs/inertia";
import Layout from "@/Layouts/layout/layout.jsx";
import { Table, Button, Modal, Input, Space, Popconfirm, Spin } from "antd";
import { createStyles } from "antd-style";
import dayjs from "dayjs";
import { Tooltip } from "antd";
import { FileTextOutlined, 
        DropboxOutlined, 
        NumberOutlined, 
        ProductOutlined , 
        SolutionOutlined, 
        CalendarOutlined, 
        CheckCircleOutlined, 
        OrderedListOutlined,
        PlusCircleOutlined,
} from "@ant-design/icons";
import ClaimFormModal from "./ClaimFormModal";

const useStyle = createStyles(({ css, token }) => {
    const { antCls } = token;
    return {
      customTable: css`
        ${antCls}-table-container {
          ${antCls}-table-body {
            scrollbar-width: thin;
            scrollbar-color: #eaeaea transparent;
            scrollbar-gutter: stable;
          }
          ${antCls}-table-content {
            overflow-x: auto;
          }
        }
        .centered-column {
          text-align: center;
        }
        thead > tr > th {
          text-align: center !important;
        }
      `,
    };
  });

const ClaimManagement = ({ claims, orders }) => {
  const { styles } = useStyle();
  const [editingClaim, setEditingClaim] = useState(null);
  const [modalVisible, setModalVisible] = useState(false);
  const [loading, setLoading] = useState(false);
  const [searchQuery, setSearchQuery] = useState("");
  const [pagination, setPagination] = useState({ current: 1, pageSize: 10 });

  const [formData, setFormData] = useState({
    orders_id: "",
    nama_muatan: "",
    jumlah_barang: "",
    status_muatan: "",
    nama_muatan_claim: "",
    jumlah_muatan_claim: "",
    catatan_muatan: "",
  });

  // Fitur pencarian yang aman
  const filteredClaims = claims.filter((claim) =>
    ["orders_id", "nama_muatan", "status_muatan"].some((key) => {
      const value = claim[key] || ""; // Pastikan nilai ada
      return value.toString().toLowerCase().includes(searchQuery.toLowerCase());
    })
  );

  const columns = [
    {
        title: (
            <span>
              <NumberOutlined style={{ marginRight: "5px", color: "#1890ff" }} />
              No
            </span>
          ),
      key: "no",
      className: "centered-column",
      render: (text, record, index) => {
        const currentPage = pagination.current || 1;
        const pageSize = pagination.pageSize || 10;
        return (currentPage - 1) * pageSize + index + 1;
      },
    },
    {
        title: (
            <span>
              <SolutionOutlined style={{ marginRight: "5px", color: "#52c41a" }} />
              Order ID
            </span>
          ),
      dataIndex: "orders_id",
      key: "orders_id",
      className: "centered-column",
    },
    {
        title: (
            <span>
              <DropboxOutlined style={{ marginRight: "5px", color: "#faad14" }} />
              Nama Barang
            </span>
          ),
      dataIndex: "nama_muatan",
      key: "nama_muatan",
      className: "centered-column",
    },
    {
        title: (
            <span>
              <ProductOutlined style={{ marginRight: "5px", color: "#52c41a" }} />
              Jumlah Barang
            </span>
          ),
      dataIndex: "jumlah_barang",
      key: "jumlah_barang",
      className: "centered-column",
      render: (text) => `${text} Pcs`,
    },
    {
        title: (
          <span>
            <CheckCircleOutlined style={{ marginRight: "5px", color: "#faad14" }} />
            Status Barang
          </span>
        ),
      dataIndex: "status_muatan",
      key: "status_muatan",
      className: "centered-column",
    },
    {
        title: (
            <span>
              <DropboxOutlined style={{ marginRight: "5px", color: "#1890ff" }} />
              Nama Barang Claim
            </span>
          ),
      dataIndex: "nama_muatan_claim",
      key: "nama_muatan_claim",
      className: "centered-column",
    },
    {
        title: (
            <span>
              <ProductOutlined style={{ marginRight: "5px", color: "#13c2c2" }} />
              Jumlah Barang Claim
            </span>
          ),
      dataIndex: "jumlah_muatan_claim",
      key: "jumlah_muatan_claim",
      className: "centered-column",
      render: (text) => `${text} Pcs`,
    },
    {
        title: (
            <span>
              <FileTextOutlined style={{ marginRight: "5px", color: "#ff4d4f" }} />
              Catatan Barang
            </span>
          ),
      dataIndex: "catatan_muatan",
      key: "catatan_muatan",
      className: "centered-column",
      render: (text) => (
        <Tooltip title={text}>
          <span style={{ display: "flex", alignItems: "center", justifyContent: "center" }}>
            <FileTextOutlined style={{ marginRight: "5px", color: "#1890ff" }} />
            <span style={{ cursor: "pointer", color: "#1890ff" }}>Catatan Dari Driver</span>
          </span>
        </Tooltip>
      ),
    },
    {
        title: (
            <span>
              <CalendarOutlined style={{ marginRight: "5px", color: "#13c2c2" }} />
              Waktu Kejadian
            </span>
          ),
      dataIndex: "created_at",
      key: "created_at",
      className: "centered-column",
      render: (text) => (text ? dayjs(text).format("DD MMM YYYY") : "-"),
    },
    {
      title: "Action",
      key: "actions",
      fixed: "right",
      width: 100,
      className: "centered-column",
      render: (text, record) => (
        <Space>
            <Tooltip title="Edit Data">
          <Button color="primary" variant="filled" type="link" onClick={() => handleEdit(record)}>
            Edit
          </Button>
          </Tooltip>
          <Tooltip title="Hapus Data">
          <Popconfirm
            title="Yakin ingin menghapus data ini?"
            onConfirm={() => handleDelete(record.id_claim)}
            okText="Ya"
            cancelText="Tidak"
          >
            <Button color="danger" variant="filled" type="link" danger>
              Delete
            </Button>
          </Popconfirm>
          </Tooltip>
        </Space>
      ),
    },
  ];

  const handleEdit = (claim) => {
    setEditingClaim(claim);
  
    // Pastikan data yang diisi adalah ID, bukan nomor order atau nama
    setFormData({
      orders_id: claim.orders_id, // ID order numerik
      nama_muatan: claim.nama_muatan, // ID nama_muatan
      jumlah_barang: claim.jumlah_barang, // ID jumlah_barang
      status_muatan: claim.status_muatan,
      nama_muatan_claim: claim.nama_muatan_claim,
      jumlah_muatan_claim: claim.jumlah_muatan_claim,
      catatan_muatan: claim.catatan_muatan,
      created_at: claim.created_at ? dayjs(claim.created_at) : null,
    });
  
    setModalVisible(true);
  };
  

  const handleDelete = (id) => {
    setLoading(true);
  
    Inertia.delete(`/claims/${id}`, {
      onSuccess: () => {
        message.success("Data berhasil dihapus!"); // Alert sukses
        Inertia.reload({ only: ['claims'] }); // Reload hanya data 'claims'
      },
      onError: (errors) => {
        console.error("Error saat menghapus data:", errors);
        message.error("Gagal menghapus data."); // Alert error
      },
      onFinish: () => {
        setLoading(false); // Hentikan loading
      },
      preserveScroll: true, // Hindari scroll reset
    });
  };
  

  const handleCloseModal = () => {
    setModalVisible(false);
    setEditingClaim(null); // Reset state editingClaim
  };

  return (
    <Layout>
      <div style={{ padding: "20px", backgroundColor: "#fff", borderRadius: "5px", boxShadow: "0 2px 4px rgba(0, 0, 0, 0.1)" }}>
        <div style={{ marginBottom: "20px", display: "flex", justifyContent: "space-between" }}>
          <Input.Search
            placeholder="Cari berdasarkan ID Klaim, Nama Muatan, Status..."
            style={{ width: "300px" }}
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
          />

    <Button
      type="primary"
      icon={<PlusCircleOutlined />} // Tambahkan ikon di sini
      onClick={() => setModalVisible(true)}
    >
      Tambah Driver Baru
    </Button>
        </div>

        <Table
        className={styles.customTable}
        columns={columns}
        dataSource={filteredClaims}
        rowKey="id_claim"
        pagination={{
            ...pagination,
            onChange: (page, pageSize) => setPagination({ current: page, pageSize }),
        }}
        scroll={{ x: "max-content" }}
        />
        
      {/* Pastikan orders dikirim ke ClaimFormModal */}
      <ClaimFormModal
  visible={modalVisible}
  onClose={handleCloseModal} // Reset modal dan state
  orders={orders}
  editingClaim={editingClaim}
/>




      </div>
    </Layout>
  );
};

export default ClaimManagement;
