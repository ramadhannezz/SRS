import React, { useState, useEffect } from 'react';
import KeyboardArrowDownTwoToneIcon from '@mui/icons-material/KeyboardArrowDownTwoTone';
import KeyboardArrowUpTwoToneIcon from '@mui/icons-material/KeyboardArrowUpTwoTone';

const DetailTrip = ({ orderId }) => {
  const [isCollapsed, setIsCollapsed] = useState(false);
  const [orderData, setOrderData] = useState(null);

  const toggleCollapse = () => {
    setIsCollapsed(!isCollapsed);
  };

  useEffect(() => {
    // Fetch order data from the backend
    fetch(`/api/orders/${orderId}`)
      .then(response => response.json())
      .then(data => setOrderData(data))
      .catch(error => console.error('Error fetching order data:', error));
  }, [orderId]);

  return (
    <div className="detail-trip">
      <div className="detail-trip-header" onClick={toggleCollapse}>
        <h2>Detail Trip</h2>
        <span className={`arrow-icon ${isCollapsed ? 'collapsed' : ''}`}>
          {isCollapsed ? <KeyboardArrowDownTwoToneIcon /> : <KeyboardArrowUpTwoToneIcon />}
        </span>
      </div>
      <hr className="divider" />
      {!isCollapsed && orderData && (
        <div className="detail-trip-content">
        <p><span className="label">Nomor Trip</span> <br /><span className="value">{orderData.nomor_trip || '-'}</span></p>
        {/* <p><span className="label">Nomor DO</span> <br /><span className="value">{orderData.nomor_do || '-'}</span></p> */}
        <p><span className="label">Customer</span> <br /><span className="value">{orderData.customer_name || '-'}</span></p>
        {/* <p><span className="label">Nomor TO</span> <br /><span className="value">{orderData.nomor_to || '-'}</span></p> */}
        {/* Tambahkan detail lainnya di sini */}
        </div>

      )}
    </div>
  );
};

export default DetailTrip;
