import React, { useEffect, useState } from 'react';

const RouteInfoLegend = ({ distance, duration, driverLocation }) => {
  const [address, setAddress] = useState(null); // State untuk menyimpan alamat

  // Fungsi untuk mendapatkan alamat dari koordinat
  const fetchAddress = async (latitude, longitude) => {
    const apiKey = "AIzaSyAx0wSnTzVVOZRgToHnWJnLh9djaD41yoE"; // Ganti dengan API Key Google Anda
    const url = `https://maps.googleapis.com/maps/api/geocode/json?latlng=${latitude},${longitude}&key=${apiKey}`;

    try {
      const response = await fetch(url);
      const data = await response.json();

      if (data.status === "OK" && data.results.length > 0) {
        setAddress(data.results[0].formatted_address); // Simpan alamat dalam state
      } else {
        console.error("Gagal mendapatkan alamat:", data.status);
        setAddress("Alamat tidak ditemukan");
      }
    } catch (error) {
      console.error("Error fetching address:", error);
      setAddress("Gagal mendapatkan alamat");
    }
  };

  // Panggil Geocoding API setiap kali lokasi driver berubah
  useEffect(() => {
    if (driverLocation) {
      fetchAddress(driverLocation.latitude, driverLocation.longitude);
    }
  }, [driverLocation]);

  return (
    <div style={styles.legendContainer}>
      <h4 style={styles.header}>Informasi Rute</h4>
      <div style={styles.infoItem}>
        <strong>Jarak Tempuh :</strong> {distance || 'N/A'}
      </div>
      <div style={styles.infoItem}>
        <strong>Waktu Tempuh :</strong> {duration || 'N/A'}
      </div>
      {driverLocation && (
        <>

          <div style={styles.infoItem}>
            <strong>Lokasi Driver :</strong>
            <div>{address || 'Sedang memuat alamat...'}</div>
            <div style={styles.infoItem}>
            <div>Latitude : {driverLocation.latitude}</div>
            <div>Longitude : {driverLocation.longitude}</div>
          </div>
          </div>
        </>
      )}
    </div>
  );
};

const styles = {
  legendContainer: {
    position: 'absolute',
    bottom: '25px',
    right: '65px',
    backgroundColor: 'rgba(255, 255, 255, 0.9)',
    padding: '15px',
    borderRadius: '8px',
    boxShadow: '0 4px 8px rgba(0, 0, 0, 0.2)',
    zIndex: 1000,
    fontSize: '12px',
    lineHeight: '1.5',
    width: '250px',
  },
  header: {
    margin: '0 0 10px 0',
    fontSize: '16px',
    textAlign: 'center',
    fontWeight: 'bold',
  },
  infoItem: {
    marginBottom: '10px',
    marginTop: '5px',
  },
};

export default RouteInfoLegend;
