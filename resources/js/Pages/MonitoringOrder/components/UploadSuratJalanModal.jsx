import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './UploadSuratJalanModal.css';
import ImageModal from './ImageModal'; // Import modal untuk menampilkan gambar

const UploadSuratJalanModal = ({ orderId, show, onClose, type, onSave }) => {
  const [documents, setDocuments] = useState({
    surat_jalan: null,
    proses: null,
    packing_list: null,
    bukti_timbang: null,
    dokumen_lain: null,
  });

  const [selectedImage, setSelectedImage] = useState(null); // Untuk menyimpan gambar yang diklik

  useEffect(() => {
    if (show) {
      axios.get(`/orders/${orderId}/documents?type=${type}`)
        .then(response => {
          const data = response.data;
          setDocuments({
            surat_jalan: data.surat_jalan ? { file: null, url: `/storage/documents/${orderId}/${data.surat_jalan}` } : null,
            proses: data.proses ? { file: null, url: `/storage/documents/${orderId}/${data.proses}` } : null,
            packing_list: data.packing_list ? { file: null, url: `/storage/documents/${orderId}/${data.packing_list}` } : null,
            bukti_timbang: data.bukti_timbang ? { file: null, url: `/storage/documents/${orderId}/${data.bukti_timbang}` } : null,
            dokumen_lain: data.dokumen_lain ? { file: null, url: `/storage/documents/${orderId}/${data.dokumen_lain}` } : null,
          });
        })
        .catch(error => {
          console.error("Error fetching documents:", error);
        });
    }
  }, [show, orderId, type]);

  const handleFileChange = (e, field) => {
    const file = e.target.files[0];
    setDocuments(prev => ({ ...prev, [field]: { file, url: URL.createObjectURL(file) } }));
  };

  const handleRemoveFile = (field) => {
    setDocuments(prev => ({ ...prev, [field]: null }));
  };

  const handleSave = () => {
    const formData = new FormData();
    for (const [key, value] of Object.entries(documents)) {
      if (value && value.file) {
        formData.append(key, value.file);
      }
    }

    axios.post(`/orders/${orderId}/upload-documents?type=${type}`, formData)
      .then(response => {
        alert('Dokumen berhasil diupload.');
        onSave();
        onClose();
      })
      .catch(error => {
        console.error("Error uploading documents:", error);
        alert('Gagal mengupload dokumen.');
      });
  };

  const handleImageClick = (imageUrl) => {
    setSelectedImage(imageUrl); // Set gambar yang diklik untuk ditampilkan di modal
  };

  return (
    <>
      <div className={`modal ${show ? 'show' : ''}`} style={{ display: show ? 'block' : 'none' }}>
        <div className="modal-content">
          <div className="modal-header">
            <h5 className="modal-title">{type === 'muat' ? 'Dokumen Selesai Muat' : 'Dokumen Selesai Bongkar'}</h5>
            <button type="button" className="close" onClick={onClose}>×</button>
          </div>
          <div className="modal-body">
            <p>Format file yang didukung: PDF, JPEG, dan PNG (Maksimum 5 MB)</p>
            <div className="upload-section">
              <label>Surat Jalan</label>
              <input 
                type="file" 
                accept=".pdf,.jpeg,.png" 
                onChange={(e) => handleFileChange(e, 'surat_jalan')} 
              />
              {documents.surat_jalan && (
                <div className="uploaded-file">
                  <img src={documents.surat_jalan.url} alt="Surat Jalan" onClick={() => handleImageClick(documents.surat_jalan.url)} />
                  <button onClick={() => handleRemoveFile('surat_jalan')}>Remove</button>
                </div>
              )}
            </div>

            {/* Repeat similar blocks for other documents */}
            <div className="upload-section">
              <label>Proses {type === 'muat' ? 'Muat' : 'Bongkar'}</label>
              <input 
                type="file" 
                accept=".pdf,.jpeg,.png" 
                onChange={(e) => handleFileChange(e, 'proses')} 
              />
              {documents.proses && (
                <div className="uploaded-file">
                  <img src={documents.proses.url} alt="Proses" onClick={() => handleImageClick(documents.proses.url)} />
                  <button onClick={() => handleRemoveFile('proses')}>Remove</button>
                </div>
              )}
            </div>

            <div className="upload-section">
              <label>Packing List</label>
              <input 
                type="file" 
                accept=".pdf,.jpeg,.png" 
                onChange={(e) => handleFileChange(e, 'packing_list')} 
              />
              {documents.packing_list && (
                <div className="uploaded-file">
                  <img src={documents.packing_list.url} alt="Packing List" onClick={() => handleImageClick(documents.packing_list.url)} />
                  <button onClick={() => handleRemoveFile('packing_list')}>Remove</button>
                </div>
              )}
            </div>

            <div className="upload-section">
              <label>Bukti Timbang atau Uji Ukur (Opsional)</label>
              <input 
                type="file" 
                accept=".pdf,.jpeg,.png" 
                onChange={(e) => handleFileChange(e, 'bukti_timbang')} 
              />
              {documents.bukti_timbang && (
                <div className="uploaded-file">
                  <img src={documents.bukti_timbang.url} alt="Bukti Timbang" onClick={() => handleImageClick(documents.bukti_timbang.url)} />
                  <button onClick={() => handleRemoveFile('bukti_timbang')}>Remove</button>
                </div>
              )}
            </div>

            <div className="upload-section">
              <label>Dokumen Lain (Opsional)</label>
              <input 
                type="file" 
                accept=".pdf,.jpeg,.png" 
                onChange={(e) => handleFileChange(e, 'dokumen_lain')} 
              />
              {documents.dokumen_lain && (
                <div className="uploaded-file">
                  <img src={documents.dokumen_lain.url} alt="Dokumen Lain" onClick={() => handleImageClick(documents.dokumen_lain.url)} />
                  <button onClick={() => handleRemoveFile('dokumen_lain')}>Remove</button>
                </div>
              )}
            </div>
          </div>
          <div className="modal-footer">
            <button type="button" className="btn btn-secondary" onClick={onClose}>Batal</button>
            <button type="button" className="btn btn-primary" onClick={handleSave}>Simpan</button>
          </div>
        </div>
      </div>

      {/* Image Modal for Zoom */}
      {selectedImage && (
        <ImageModal imageUrl={selectedImage} onClose={() => setSelectedImage(null)} />
      )}
    </>
  );
};

export default UploadSuratJalanModal;
