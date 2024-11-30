import React from 'react';
import { GoogleMap, Marker } from '@react-google-maps/api';

const styles = {
  mapContainer: {
    height: '375px', // Atur tinggi peta sesuai kebutuhan
    width: '100%', // Lebar peta mengikuti elemen induk
  },
};

const PetaTrip = () => {
  // Pusat peta di Jakarta
  const center = {
    lat: -6.2088, // Latitude Jakarta
    lng: 106.8456, // Longitude Jakarta
  };

  return (
    <div>
      <GoogleMap
        mapContainerStyle={styles.mapContainer} // Gunakan gaya untuk mengatur tinggi dan lebar
        center={center} // Pusatkan peta di Jakarta
        zoom={12} // Zoom level default
      >
        {/* Tambahkan marker di pusat peta */}
        <Marker position={center} />
      </GoogleMap>
    </div>
  );
};

export default PetaTrip;
