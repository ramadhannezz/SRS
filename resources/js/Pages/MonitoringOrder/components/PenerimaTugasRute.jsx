import React, { useState, useEffect } from 'react';
import PetaTrip from './PetaTrip';

const PenerimaTugasRute = ({ orderId }) => {
  const [orderData, setOrderData] = useState(null);

  useEffect(() => {
    // Fetch order data from the backend
    fetch(`/api/orders/${orderId}`)
      .then(response => response.json())
      .then(data => setOrderData(data))
      .catch(error => console.error('Error fetching order data:', error));
  }, [orderId]);

  return (
    <div className="penerima-tugas-rute">
      <h2>Penerima Tugas dan Rute Perjalanan</h2>
      <hr className="divider" />
      {orderData && (
        <div className="penerima-tugas-rute-content">
  <p><span className="label">Status Terakhir</span> <br /> <span className="value">{orderData.current_status || '-'}</span></p>
  <p><span className="label">Vendor</span> <br /> <span className="value">{orderData.vendor_name || '-'}</span></p>
  <p><span className="label">Driver</span> <br /> <span className="value">{orderData.driver_name || '-'}</span></p>
  <p><span className="label">No. Telepon</span> <br /> <span className="value">{orderData.driver_phone || '-'}</span></p>
  <p><span className="label">Truk</span> <br /> <span className="value">{orderData.truck_licensePlate || '-'}</span></p>
  <p><span className="label">Type Truk</span> <br /> <span className="value">{orderData.typetrucks_name || '-'}</span></p>
  <br />
  <PetaTrip />
</div>

      )}
    </div>
  );
};

export default PenerimaTugasRute;
