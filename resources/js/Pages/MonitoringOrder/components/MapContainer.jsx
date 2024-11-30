import React, { useEffect, useRef, useState } from 'react';
import { GoogleMap, Marker, DirectionsRenderer } from '@react-google-maps/api';
import RouteInfoLegend from './RouteInfoLegend'; // Import komponen legend

const containerStyle = {
  width: '100%',
  height: '100%',
};

const MapContainer = ({ driverLocation, routes }) => {
  const mapRef = useRef(null);
  const [center, setCenter] = useState({ lat: -6.2, lng: 106.816666 }); // Default Jakarta
  const [directions, setDirections] = useState(null);
  const [routeInfo, setRouteInfo] = useState({ distance: null, duration: null }); // Tambahkan state untuk jarak & waktu

  // Update center jika driverLocation berubah
  useEffect(() => {
    if (driverLocation) {
      setCenter({
        lat: driverLocation.latitude,
        lng: driverLocation.longitude,
      });
    }
  }, [driverLocation]);

  // Render Directions
  useEffect(() => {
    if (routes && routes.length > 1) {
      const directionsService = new window.google.maps.DirectionsService();

      const waypoints = routes.slice(1, -1).map((point) => ({
        location: new window.google.maps.LatLng(point.lat, point.lng),
        stopover: true,
      }));

      const origin = new window.google.maps.LatLng(routes[0].lat, routes[0].lng);
      const destination = new window.google.maps.LatLng(
        routes[routes.length - 1].lat,
        routes[routes.length - 1].lng
      );

      directionsService.route(
        {
          origin,
          destination,
          waypoints,
          travelMode: window.google.maps.TravelMode.DRIVING,
        },
        (result, status) => {
          if (status === window.google.maps.DirectionsStatus.OK) {
            setDirections(result);

            // Dapatkan jarak & waktu tempuh dari result
            const route = result.routes[0].legs[0];
            setRouteInfo({
              distance: route.distance.text,
              duration: route.duration.text,
            });
          } else {
            console.error("Gagal merender rute:", status);
          }
        }
      );
    }
  }, [routes]);

  return (
    <div style={{ height: '100%', width: '100%', position: 'relative' }}>
      <GoogleMap
        mapContainerStyle={containerStyle}
        center={center}
        zoom={12}
        onLoad={(map) => {
          console.log('Google Maps berhasil dimuat.');
          mapRef.current = map;
        }}
        options={{
          mapTypeId: 'roadmap',
          disableDefaultUI: false,
        }}
      >
        {/* Render Directions */}
        {directions && (
          <DirectionsRenderer
            directions={directions}
          />
        )}

        {/* Marker untuk Lokasi Driver */}
        {driverLocation && (
          <Marker
            position={{
              lat: driverLocation.latitude,
              lng: driverLocation.longitude,
            }}
            icon={{
              url: 'http://maps.google.com/mapfiles/ms/icons/truck.png',
              scaledSize: new window.google.maps.Size(35, 35),
            }}
            title="Lokasi Driver"
            onLoad={() => console.log('Marker Truck berhasil dimuat:', driverLocation)}
          />
        )}
      </GoogleMap>

      {/* Tambahkan komponen legend */}
      <RouteInfoLegend
        distance={routeInfo.distance}
        duration={routeInfo.duration}
        driverLocation={driverLocation}
      />
    </div>
  );
};

export default MapContainer;
