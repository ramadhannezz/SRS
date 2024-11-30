import React, { useState, useEffect } from 'react';
import UpdateMuatanModal from './UpdateMuatanModal';
import UploadSuratJalanModal from './UploadSuratJalanModal';
import axios from 'axios';

const StatusTrip = ({ orderId, statuses, onStatusChange, onUpdateMuatanClick, onUploadSuratJalanClick, onSave }) => {
  const [orderData, setOrderData] = useState({});
  const [showUpdateMuatanModal, setShowUpdateMuatanModal] = useState(false);
  const [showUploadSuratJalanModal, setShowUploadSuratJalanModal] = useState(false);
  const [suratJalanType, setSuratJalanType] = useState('');
  const [suratJalanMuat, setSuratJalanMuat] = useState([]);
  const [suratJalanBongkar, setSuratJalanBongkar] = useState([]);
  const [currentUnloadIndex, setCurrentUnloadIndex] = useState(null);

  useEffect(() => {
    axios.get(`/orders/${orderId}/data`)
      .then(response => {
        setOrderData(response.data);
        console.log('Order Data Loaded:', response.data);

        // Load previously uploaded documents
        setSuratJalanMuat(response.data.surat_jalan_muat || []);
        setSuratJalanBongkar(response.data.surat_jalan_bongkar || []);
      })
      .catch(error => {
        console.error("Ada kesalahan dalam pengambilan data order:", error);
      });
  }, [orderId]);

  const handleUploadSuratJalanClick = (type, index = null) => {
    setSuratJalanType(type);
    setCurrentUnloadIndex(index);
    setShowUploadSuratJalanModal(true);
  };

  const handleFileUpload = (type, files) => {
    if (type === 'muat') {
      setSuratJalanMuat(files);
    } else if (type === 'bongkar' && currentUnloadIndex !== null) {
      const newBongkarFiles = [...suratJalanBongkar];
      newBongkarFiles[currentUnloadIndex] = files;
      setSuratJalanBongkar(newBongkarFiles);
    }
    setShowUploadSuratJalanModal(false);
  };

  const handleFileDelete = (type, fileIndex) => {
    if (type === 'muat') {
      const newFiles = [...suratJalanMuat];
      newFiles.splice(fileIndex, 1);
      setSuratJalanMuat(newFiles);
    } else if (type === 'bongkar' && currentUnloadIndex !== null) {
      const newFiles = [...suratJalanBongkar];
      newFiles[currentUnloadIndex].splice(fileIndex, 1);
      setSuratJalanBongkar(newFiles);
    }
  };

  return (
    <div className="status-trip">
      {/* Header Section */}
      <div className="status-trip-header">
        <h2>Status Trip</h2>
        <a href="#" className="view-detail-link">Lihat Detail Status</a>
      </div>
      <hr className="divider" />

      {/* Section Status Muat */}
      <div className="head-content-box">
        <h5><b>Muat</b></h5>
        <p><b>{orderData.load_address?.name}</b></p>
        <p>{orderData.load_address?.address}</p>
        <p>Estimasi Waktu : {orderData.tanggal_muat}</p>
      </div>
      <div className="content-box">
        <table>
          <thead>
            <tr>
              <th>Status</th>
              <th>Tanggal & Waktu</th>
              <th>Muatan</th>
              <th>Lampiran</th>
            </tr>
          </thead>
          <tbody>
            {statuses.slice(0, 4).map((status, index) => (
              <tr key={status.id}>
                <td>
                  <input
                    type="checkbox"
                    checked={status.checked}
                    onChange={(e) => onStatusChange(index, 'checked', e.target.checked)}
                  />
                  {status.name}
                </td>
                <td>
                  <input
                    type="datetime-local"
                    value={status.date}
                    onChange={(e) => onStatusChange(index, 'date', e.target.value)}
                  />
                </td>
                <td>
                  {index === 3 && (
                    <a href="#" onClick={onUpdateMuatanClick} className="update-muatan-link">Update Muatan</a>
                  )}
                </td>
                <td>
                  {index === 3 && (
                    <>
                      <button onClick={() => handleUploadSuratJalanClick('muat')} className="upload-button">Upload</button>
                      <div className="uploaded-files">
                        {suratJalanMuat.map((file, idx) => (
                          <div key={idx}>
                            <img src={URL.createObjectURL(file)} alt={`Surat Jalan Muat ${idx + 1}`} />
                            <button onClick={() => handleFileDelete('muat', idx)}>Hapus</button>
                          </div>
                        ))}
                      </div>
                    </>
                  )}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      <hr className="divider" />

      {/* Section Status Bongkar */}
      {orderData.unload_addresses && orderData.unload_addresses.map((unloadAddress, idx) => (
        <div key={idx}>
          <div className="head-content-box">
            <h5><b>Bongkar </b></h5>
            <p><b>{unloadAddress.name}</b></p>
            <p>{unloadAddress.address}</p>
            <p>Estimasi Waktu: {orderData.tanggal_bongkar}</p>
          </div>
          <div className="content-box">
            <table>
              <thead>
                <tr>
                  <th>Status</th>
                  <th>Tanggal & Waktu</th>
                  <th>Muatan</th>
                  <th>Lampiran</th>
                </tr>
              </thead>
              <tbody>
                {statuses.slice(4 + idx * 4, 8 + idx * 4).map((status, index) => (
                  <tr key={status.id}>
                    <td>
                      <input
                        type="checkbox"
                        checked={status.checked}
                        onChange={(e) => onStatusChange(index + 4 + idx * 4, 'checked', e.target.checked)}
                      />
                      {status.name}
                    </td>
                    <td>
                      <input
                        type="datetime-local"
                        value={status.date}
                        onChange={(e) => onStatusChange(index + 4 + idx * 4, 'date', e.target.value)}
                      />
                    </td>
                    <td>
                      {index === 3 && (
                        <a href="#" onClick={onUpdateMuatanClick} className="update-muatan-link">Update Muatan</a>
                      )}
                    </td>
                    <td>
                      {index === 3 && (
                        <>
                          <button onClick={() => handleUploadSuratJalanClick('bongkar', idx)} className="upload-button">Upload</button>
                          <div className="uploaded-files">
                            {suratJalanBongkar[idx] && suratJalanBongkar[idx].map((file, fileIdx) => (
                              <div key={fileIdx}>
                                <img src={URL.createObjectURL(file)} alt={`Surat Jalan Bongkar ${fileIdx + 1}`} />
                                <button onClick={() => handleFileDelete('bongkar', fileIdx)}>Hapus</button>
                              </div>
                            ))}
                          </div>
                        </>
                      )}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
          <hr className="divider" />
        </div>
      ))}

      {/* Modals */}
      <UpdateMuatanModal
        orderId={orderId}
        show={showUpdateMuatanModal}
        onClose={() => setShowUpdateMuatanModal(false)}
        onSave={onSave}
      />
      <UploadSuratJalanModal
        orderId={orderId} // <-- Pastikan ini dilewatkan dengan benar
        type={suratJalanType}
        show={showUploadSuratJalanModal}
        onClose={() => setShowUploadSuratJalanModal(false)}
        onSave={handleFileUpload}
      />
    </div>
  );
};

export default StatusTrip;
