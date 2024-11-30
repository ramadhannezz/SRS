import React, { useState, useEffect } from 'react';
import axios from 'axios';
import DetailTrip from './components/DetailTrip';
import StatusTrip from './components/StatusTrip';
import PenerimaTugasRute from './components/PenerimaTugasRute';
import Header from './components/Header';
import UploadSuratJalanModal from './components/UploadSuratJalanModal';
import './UpdateStatusTrip.css';

const UpdateStatusTrip = ({ orderId }) => {
  const [statuses, setStatuses] = useState([]);
  const [suratJalanMuat, setSuratJalanMuat] = useState([]);
  const [suratJalanBongkar, setSuratJalanBongkar] = useState([]);
  const [showUploadModal, setShowUploadModal] = useState(false);
  const [uploadType, setUploadType] = useState('');
  const [showFooter, setShowFooter] = useState(false); // State untuk menampilkan footer

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await axios.get(`/orders/${orderId}/data`);
        const orderData = response.data;

        const loadStatuses = [
          { id: 1, name: 'Menuju Lokasi Muat', checked: false, date: '', muatan: '', location_id: orderData.load_address.id },
          { id: 2, name: 'Sampai Lokasi Muat', checked: false, date: '', muatan: '', location_id: orderData.load_address.id },
          { id: 3, name: 'Mulai Muat', checked: false, date: '', muatan: '', location_id: orderData.load_address.id },
          { id: 4, name: 'Selesai Muat', checked: false, date: '', muatan: '', location_id: orderData.load_address.id },
        ];

        const unloadStatuses = orderData.unload_addresses.map((unload, idx) => {
          return [
            { id: 5 + idx * 4, name: 'Menuju Lokasi Bongkar', checked: false, date: '', muatan: '', location_id: unload.id },
            { id: 6 + idx * 4, name: 'Sampai Lokasi Bongkar', checked: false, date: '', muatan: '', location_id: unload.id },
            { id: 7 + idx * 4, name: 'Mulai Bongkar', checked: false, date: '', muatan: '', location_id: unload.id },
            { id: 8 + idx * 4, name: 'Selesai Bongkar', checked: false, date: '', muatan: '', location_id: unload.id },
          ];
        }).flat();

        const allStatuses = [...loadStatuses, ...unloadStatuses];

        orderData.orderStatusLogs.forEach(log => {
          const statusIndex = allStatuses.findIndex(status => status.name === log.status && status.location_id === log.location_id);
          if (statusIndex !== -1) {
            allStatuses[statusIndex].checked = true;
            allStatuses[statusIndex].date = log.timestamp;
          }
        });

        setStatuses(allStatuses);

        setSuratJalanMuat(orderData.surat_jalan_muat || []);
        setSuratJalanBongkar(orderData.surat_jalan_bongkar || []);
      } catch (error) {
        console.error("Ada kesalahan dalam pengambilan data order:", error);
      }
    };

    fetchData();
  }, [orderId]);

  useEffect(() => {
    const handleScroll = () => {
      const isBottom = window.innerHeight + window.scrollY >= document.documentElement.scrollHeight;
      setShowFooter(isBottom);
    };

    window.addEventListener('scroll', handleScroll);
    return () => {
      window.removeEventListener('scroll', handleScroll);
    };
  }, []);

  const handleSave = async () => {
    try {
      const formData = new FormData();
      formData.append('status', JSON.stringify(statuses));

      if (suratJalanMuat.length > 0) {
        suratJalanMuat.forEach(file => {
          formData.append('surat_jalan_muat[]', file);
        });
      }
      if (suratJalanBongkar.length > 0) {
        suratJalanBongkar.forEach(file => {
          formData.append('surat_jalan_bongkar[]', file);
        });
      }

      const response = await axios.post(`/orders/${orderId}/update-status`, formData);
      console.log("Response:", response.data);
      localStorage.removeItem('statuses');
    } catch (error) {
      console.error('Error Response:', error.response);
    }
  };

  const handleUploadSuratJalanClick = (type) => {
    setUploadType(type);
    setShowUploadModal(true);
  };

  const handleFileUpload = (type, files) => {
    if (type === 'muat') {
      setSuratJalanMuat(files);
    } else if (type === 'bongkar') {
      setSuratJalanBongkar(files);
    }
    setShowUploadModal(false);
  };

  const handleFileDelete = (type, index) => {
    if (type === 'muat') {
      const newFiles = [...suratJalanMuat];
      newFiles.splice(index, 1);
      setSuratJalanMuat(newFiles);
    } else if (type === 'bongkar') {
      const newFiles = [...suratJalanBongkar];
      newFiles.splice(index, 1);
      setSuratJalanBongkar(newFiles);
    }
  };

  return (
    <div className="update-status-trip-container">
      <Header />
      <div className="update-status-trip">
        <div className="left-panel">
          <DetailTrip orderId={orderId} />
          <PenerimaTugasRute orderId={orderId} />
        </div>
        <div className="right-panel">
          <StatusTrip 
            orderId={orderId}
            statuses={statuses}
            onStatusChange={(index, field, value) => {
              const newStatuses = [...statuses];
              newStatuses[index][field] = value;
              setStatuses(newStatuses);
            }}
            onUploadSuratJalanClick={handleUploadSuratJalanClick}
            onSave={handleSave}
            suratJalanMuat={suratJalanMuat}
            suratJalanBongkar={suratJalanBongkar}
            onDeleteFile={handleFileDelete}
          />
        </div>
      </div>

      {showFooter && (
        <div className="footer">
          <button
            className="save-button"
            onClick={async () => {
              await handleSave();
              window.location.href = `/orders`;
            }}
          >
            Simpan Perubahan
          </button>
        </div>
      )}

      {showUploadModal && (
        <UploadSuratJalanModal
          orderId={orderId}
          type={uploadType}
          onClose={() => setShowUploadModal(false)}
          onSave={handleFileUpload}
        />
      )}
    </div>
  );
};

export default UpdateStatusTrip;
