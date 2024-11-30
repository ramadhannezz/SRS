import React, { useState } from 'react';
import { List, ListItem, ListItemIcon, ListItemText, Divider } from '@mui/material';
import FiberManualRecordIcon from '@mui/icons-material/FiberManualRecord';
import './../MonitoringOrder.css';

const styles = {
  headerText: {
    fontSize: '18px',
    fontWeight: 'bold',
    marginBottom: '10px',
  },
  subHeaderText: {
    fontSize: '14px',
    fontWeight: 'bold',
    marginBottom: '5px',
  },
  addressText: {
    lineHeight: '1.5',
    fontSize: '12px',
    marginBottom: '10px',
  },
  listItem: {
    padding: '3px 0', // Padding atas dan bawah untuk ListItem
    display: 'flex',
    alignItems: 'center', // Pusatkan konten vertikal
    fontSize: '12px',
  },
  listItemIcon: {
    minWidth: '3px',
    marginRight: '8px', // Tambahkan jarak antara ikon dan teks
  },
  button: {
    display: 'block',
    margin: '0px auto 10px auto',
    padding: '10px 20px',
    backgroundColor: '#1976d2',
    color: 'white',
    fontSize: '14px',
    fontWeight: 'bold',
    border: 'none',
    borderRadius: '5px',
    cursor: 'pointer',
    boxShadow: '0 4px 6px rgba(0, 0, 0, 0.1)',
    transition: 'all 0.3s ease',
  },
  buttonHover: {
    backgroundColor: '#1565c0',
    boxShadow: '0 6px 8px rgba(0, 0, 0, 0.2)',
  },
  body: {
  marginLeft: '10px',
  },
};

const DetailStatus = ({ order }) => {
  const [isHover, setIsHover] = useState(false);

  const statuses = [
    "Menuju Lokasi Muat",
    "Sampai Lokasi Muat",
    "Mulai Muat",
    "Selesai Muat",
    "Menuju Lokasi Bongkar",
    "Sampai Lokasi Bongkar",
    "Mulai Bongkar",
    "Selesai Bongkar"
  ];

  const getLocationStatus = (locationId, status) => {
    const log = order.orderStatusLogs.find(log => log.location_id === locationId && log.status === status);
    return log ? { color: 'grey' } : { color: '#1976d2', fontWeight: 'bold' };
  };

  return (
    <div>
      <List style={styles.body}>
        {order.load_address && (
          <>
            <div style={styles.headerText}>Lokasi Muat</div>
            <div style={styles.subHeaderText}>{order.load_address.name}</div>
            <div style={styles.addressText}>{order.load_address.address}</div>
            {statuses.slice(0, 4).map((status) => (
              <ListItem key={status} style={styles.listItem}>
                <ListItemIcon style={styles.listItemIcon}>
                  <FiberManualRecordIcon style={{ color: getLocationStatus(order.load_address.id, status).color, fontSize: '12px' }} />
                </ListItemIcon>
                <ListItemText primary={status} primaryTypographyProps={{ style: getLocationStatus(order.load_address.id, status), fontSize: '12px' }} />
              </ListItem>
            ))}
            <Divider className="divider" /><br />
          </>
        )}
        {order.unload_addresses && order.unload_addresses.map((unload, index) => (
          <div key={index}>
            <div style={styles.headerText}>Lokasi Bongkar</div>
            <div style={styles.subHeaderText}>{unload.name}</div>
            <div style={styles.addressText}>{unload.address}</div>
            {statuses.slice(4).map((status) => (
              <ListItem key={status} style={styles.listItem}>
                <ListItemIcon style={styles.listItemIcon}>
                  <FiberManualRecordIcon style={{ color: getLocationStatus(unload.id, status).color, fontSize: '12px' }} />
                </ListItemIcon>
                <ListItemText primary={status} primaryTypographyProps={{ style: getLocationStatus(unload.id, status), fontSize: '12px' }} />
              </ListItem>
            ))}
            <br /><Divider className="divider" /><br />
          </div>
        ))}
      </List>
      <button
        style={isHover ? { ...styles.button, ...styles.buttonHover } : styles.button}
        onMouseEnter={() => setIsHover(true)}
        onMouseLeave={() => setIsHover(false)}
        onClick={() => window.location.href = `/orders/${order.id}/update-status`}
      >
        Update Status Trip
      </button>
    </div>
  );
};

export default DetailStatus;
