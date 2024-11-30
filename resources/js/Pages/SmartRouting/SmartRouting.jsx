// SmartRouting.jsx
import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { Dropdown } from 'primereact/dropdown';
import { Button } from 'primereact/button';
import { Card } from 'primereact/card';
import { DragDropContext, Droppable, Draggable } from 'react-beautiful-dnd';
import '../../../css/smartrouting.css';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faGripVertical } from '@fortawesome/free-solid-svg-icons';

const SmartRouting = ({ lokasiMuat, lokasiBongkar, kotas = [], kategoriLokasi = [], onRoutingData }) => {
    const [selectedLoadAddress, setSelectedLoadAddress] = useState(null);
    const [unloadAddresses, setUnloadAddresses] = useState([null]);
    const [map, setMap] = useState(null);
    const [directionsService, setDirectionsService] = useState(null);
    const [directionsRenderer, setDirectionsRenderer] = useState(null);
    const [errors, setErrors] = useState({});

    useEffect(() => {
        if (!map) {
            initMap();
        }
    }, [map]);

    const initMap = () => {
        const map = new google.maps.Map(document.getElementById('map'), {
            center: { lat: -6.200000, lng: 106.816666 },
            zoom: 10,
        });
        setMap(map);

        const directionsService = new google.maps.DirectionsService();
        setDirectionsService(directionsService);

        const directionsRenderer = new google.maps.DirectionsRenderer();
        directionsRenderer.setMap(map);
        setDirectionsRenderer(directionsRenderer);
    };

    const addUnloadAddress = () => {
        setUnloadAddresses([...unloadAddresses, null]);
    };

    const handleUnloadAddressChange = (index, value) => {
        const newUnloadAddresses = [...unloadAddresses];
        newUnloadAddresses[index] = value;
        setUnloadAddresses(newUnloadAddresses);
    };

    const removeUnloadAddress = (index, event) => {
        event.stopPropagation();
        event.preventDefault();
        const newUnloadAddresses = [...unloadAddresses];
        newUnloadAddresses.splice(index, 1);
        setUnloadAddresses(newUnloadAddresses);
    };

    const handleGenerateRouting = async (e) => {
        e.preventDefault();

        const data = {
            load_address: selectedLoadAddress,
            unload_addresses: unloadAddresses.filter(address => address !== null),
        };

        console.log('Data sent to backend:', data);

        try {
            const response = await axios.post('/smart-routing/generate', data);
            console.log('Full response from backend:', response.data);

            const routeData = response.data.routes;
            console.log('Route data extracted from backend:', routeData);

            if (!Array.isArray(routeData)) {
                console.error('Invalid route data format:', routeData);
                throw new Error('Invalid route data format received from backend');
            }

            const waypoints = routeData.slice(1, -1).map(point => ({
                location: new google.maps.LatLng(point.lat, point.lng),
                stopover: true,
            }));

            console.log('Waypoints:', waypoints);

            const request = {
                origin: new google.maps.LatLng(routeData[0].lat, routeData[0].lng),
                destination: new google.maps.LatLng(routeData[routeData.length - 1].lat, routeData[routeData.length - 1].lng),
                waypoints: waypoints,
                optimizeWaypoints: true,
                travelMode: 'DRIVING',
            };

            console.log('Google Maps API request:', request);

            directionsService.route(request, (result, status) => {
                if (status === 'OK') {
                    directionsRenderer.setDirections(result);
                } else {
                    console.error('Error fetching directions', result);
                }
            });

            onRoutingData(selectedLoadAddress, unloadAddresses.filter(address => address !== null), routeData);
        } catch (error) {
            console.error('There was an error generating the route!', error);
            if (error.response && error.response.status === 422) {
                setErrors(error.response.data.errors);
                console.log('Validation errors:', error.response.data.errors);
            }
        }
    };

    const handleAutoPlanRouting = async (e) => {
        e.preventDefault();

        const data = {
            load_address: selectedLoadAddress,
            unload_addresses: unloadAddresses.filter(address => address !== null),
        };

        console.log('Data sent to auto-plan backend:', data);

        try {
            const response = await axios.post('/auto-plan-routing', data);
            console.log('Full response from auto-plan backend:', response.data);

            const sortedUnloadAddresses = response.data.sorted_unload_addresses;
            console.log('Sorted unload addresses:', sortedUnloadAddresses);

            setUnloadAddresses(sortedUnloadAddresses);
        } catch (error) {
            console.error('There was an error auto-planning the route!', error);
            if (error.response && error.response.status === 422) {
                setErrors(error.response.data.errors);
                console.log('Validation errors:', error.response.data.errors);
            }
        }
    };

    const onDragEnd = (result) => {
        if (!result.destination) return;

        const items = Array.from(unloadAddresses);
        const [reorderedItem] = items.splice(result.source.index, 1);
        items.splice(result.destination.index, 0, reorderedItem);

        setUnloadAddresses(items);
    };

    const getCityName = (id) => {
        const city = kotas.find(city => city.id === id);
        return city ? city.name : 'Unknown';
    };

    const getCategoryName = (id) => {
        const category = kategoriLokasi.find(category => category.id === id);
        return category ? category.name : 'Unknown';
    };

    return (
        <form>
            <div className="p-grid">
                <div className="p-col-12 p-lg-4 smart-routing-container">
                    <div className="card">
                        <h5>Load Address</h5>
                        <Dropdown
                            value={selectedLoadAddress}
                            options={lokasiMuat.map(lm => ({
                                ...lm,
                                address: `${lm.name} - ${lm.address}`
                            }))}
                            onChange={e => setSelectedLoadAddress(e.value)}
                            placeholder="Select Load Address"
                            optionLabel="address"
                            className="w-100"
                        />
                        {selectedLoadAddress && (
                            <Card className="p-mt-2">
                                <p><strong>Location:</strong> {selectedLoadAddress.name}</p>
                                <p><strong>Address:</strong> {selectedLoadAddress.address}</p>
                                <p><strong>City:</strong> {getCityName(selectedLoadAddress.kotas_id)}</p>
                                <p><strong>Category:</strong> {getCategoryName(selectedLoadAddress.kategori_lokasi_id)}</p>
                            </Card>
                        )}
                        {errors.load_address && <span className="error">{errors.load_address}</span>}
                    </div>
                    <div className="card">
                        <h5>Unload Addresses</h5>
                        <DragDropContext onDragEnd={onDragEnd}>
                            <Droppable droppableId="unloadAddresses">
                                {(provided) => (
                                    <div {...provided.droppableProps} ref={provided.innerRef}>
                                        {unloadAddresses.map((address, index) => (
                                            <Draggable key={index} draggableId={`item-${index}`} index={index}>
                                                {(provided) => (
                                                    <div ref={provided.innerRef} {...provided.draggableProps} {...provided.dragHandleProps} className="p-mb-2 smart-routing-container">
                                                        <Card>
                                                            <div className="drag-handle">
                                                                <FontAwesomeIcon icon={faGripVertical} />
                                                            </div>
                                                            <Dropdown
                                                                value={address}
                                                                options={lokasiBongkar.map(lb => ({
                                                                    ...lb,
                                                                    address: `${lb.name} - ${lb.address}`
                                                                }))}
                                                                onChange={e => handleUnloadAddressChange(index, e.value)}
                                                                placeholder="Select Unload Address"
                                                                optionLabel="address"
                                                                className="w-100"
                                                            />
                                                            {address && (
                                                                <>
                                                                    <p><strong>Location:</strong> {address.name}</p>
                                                                    <p><strong>Address:</strong> {address.address}</p>
                                                                    <p><strong>City:</strong> {getCityName(address.kotas_id)}</p>
                                                                    <p><strong>Category:</strong> {getCategoryName(address.kategori_lokasi_id)}</p>
                                                                    <Button
                                                                        icon="pi pi-trash"
                                                                        className="p-button-danger p-button-outlined p-mt-2"
                                                                        onClick={(e) => { removeUnloadAddress(index, e); }}
                                                                    />
                                                                </>
                                                            )}
                                                        </Card>
                                                    </div>
                                                )}
                                            </Draggable>
                                        ))}
                                        {provided.placeholder}
                                    </div>
                                )}
                            </Droppable>
                        </DragDropContext>
                        {errors.unload_addresses && <span className="error">{errors.unload_addresses}</span>}
                        <div className="button-group"> {/* Tambahkan kontainer untuk tombol */}
                            <Button
                                label="Add Unload Address"
                                icon="pi pi-plus"
                                onClick={addUnloadAddress}
                                type="button"
                            />
                            <Button
                                label="Auto Plan Routing"
                                icon="pi pi-map"
                                onClick={handleAutoPlanRouting}
                                type="button"
                            />
                            <Button
                                label="Generate Smart Routing"
                                icon="pi pi-check"
                                onClick={handleGenerateRouting}
                                type="submit"
                            />
                        </div>
                    </div>
                </div>
                <div className="p-col-12 p-lg-8">
                    <div id="map" style={{ height: '500px' }}></div>
                </div>
            </div>
        </form>
    );
};

export default SmartRouting;
