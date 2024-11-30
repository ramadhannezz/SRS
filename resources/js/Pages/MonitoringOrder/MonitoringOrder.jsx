import React, { useState } from 'react';
import { Tabs, Tab, Box, Paper, Divider, Typography } from '@mui/material';
import InfoTrip from './components/InfoTrip';
import DetailStatus from './components/DetailStatus';
import MapContainer from './components/MapContainer';
import Legend from './components/Legend';
import Header from './components/Header'; 
import './MonitoringOrder.css';

const MonitoringOrder = ({ order }) => {
    // Tambahkan logging untuk memastikan data driverLocation diterima
    console.log("Driver Location diterima di MonitoringOrder :", order.driverLocation);
    console.log("Routes diteruskan ke MapContainer:", order.routes);

  const [value, setValue] = useState(0);

  const handleChange = (event, newValue) => {
      setValue(newValue);
  };

  const styles = {
    noTrip: {
      fontWeight: 'bold', // Membuat teks header tabel tebal
      fontSize: '16px', // Ukuran teks header tabel
      textAlign: 'left', // Posisikan teks di tengah
      marginBottom: '10px',
    },
    noText: {
        fontWeight: 'normal', // Membuat teks header tabel tebal
        fontSize: '12px', // Ukuran teks header tabel
        textAlign: 'left', // Posisikan teks di tengah
        marginTop: '5px',
      },
    statusTrip: {
        fontWeight: 'bold', // Membuat teks header tabel tebal
        fontSize: '15px', // Ukuran teks header tabel
        textAlign: 'left', // Posisikan teks di tengah
        marginTop: '20px',
      },
      statusText: {
        fontWeight: 'normal', // Membuat teks header tabel tebal
        fontSize: '12px', // Ukuran teks header tabel
        textAlign: 'left', // Posisikan teks di tengah
        marginTop: '5px',
      },
  };

  return (
      <div className="monitoring-order-container">
          <Header />
          <div className="content">
              <Paper elevation={3} className="sticky-sidebar scrollbar-minimal">
                  <Box className="trip-info">
                  <div style={styles.noTrip}>No Trip {order.nomor_order}</div>
               
                      <div style={styles.statusTrip}>Status Trip <div style={styles.statusText}>{order.current_status}</div></div>
                  </Box>
     
                  <Box className="tabs-container">
                      <Tabs value={value} onChange={handleChange} aria-label="simple tabs example" variant="fullWidth">
                          <Tab label="Info Trip" />
                          <Tab label="Detail Status" />
                          <Tab label="Riwayat Lokasi Trip" />
                      </Tabs>
                  </Box>
                  <Divider className="divider" />
                  <Box className="tabs-content">
                      {value === 0 && <InfoTrip order={order} style={{ minHeight: '500px' }} />}
                      {value === 1 && <DetailStatus order={order} style={{ minHeight: '500px' }} />}
                      {value === 2 && <div style={{ minHeight: '500px' }}>Riwayat Lokasi Trip</div>}
                  </Box>
              </Paper>
              <div className="map-container">
                  <MapContainer 
                      routes={order.routes} 
                      driverLocation={order.driverLocation} 
                  />
                  <Legend />
              </div>
          </div>
      </div>
  );
};

export default MonitoringOrder;
