import React, { useState, useEffect } from 'react';
import axios from 'axios';

const UpdateMuatanModal = ({ orderId, show, onClose, onSave }) => {
  const [claims, setClaims] = useState({
    status_muatan: '',
    nama_muatan_claim: '',
    jumlah_muatan_claim: '',
    catatan_muatan: ''
  });

  useEffect(() => {
    if (show) {
      // Fetch data claims dari backend untuk ditampilkan pada form
      axios.get(`/orders/${orderId}/claims`)
        .then(response => {
          setClaims(response.data);
        })
        .catch(error => {
          console.error("Ada kesalahan dalam pengambilan data claims:", error);
        });
    }
  }, [show, orderId]);

  const handleChange = (e) => {
    setClaims({
      ...claims,
      [e.target.name]: e.target.value
    });
  };

  const handleSave = () => {
    axios.post(`/orders/${orderId}/update-claims`, claims)
      .then(response => {
        onSave();
        onClose();
      })
      .catch(error => {
        console.error("Ada kesalahan dalam penyimpanan claims:", error);
      });
  };

  if (!show) {
    return null;
  }

  return (
    <div className="modal">
      <div className="modal-content">
        <h2>Update Muatan</h2>
        <form>
          <div className="form-group">
            <label>Status Muatan</label>
            <select name="status_muatan" value={claims.status_muatan} onChange={handleChange}>
              <option value="Rusak">Rusak</option>
              <option value="Hilang">Hilang</option>
              <option value="Kurang">Kurang</option>
              <option value="Lebih">Lebih</option>
            </select>
          </div>
          <div className="form-group">
            <label>Nama Muatan Klaim</label>
            <input type="text" name="nama_muatan_claim" value={claims.nama_muatan_claim} onChange={handleChange} />
          </div>
          <div className="form-group">
            <label>Jumlah Muatan Klaim</label>
            <input type="number" name="jumlah_muatan_claim" value={claims.jumlah_muatan_claim} onChange={handleChange} />
          </div>
          <div className="form-group">
            <label>Catatan Muatan</label>
            <textarea name="catatan_muatan" value={claims.catatan_muatan} onChange={handleChange}></textarea>
          </div>
          <button type="button" onClick={handleSave}>Simpan</button>
          <button type="button" onClick={onClose}>Batal</button>
        </form>
      </div>
    </div>
  );
};

export default UpdateMuatanModal;
