// resources/js/Components/Loader.jsx
import React from 'react';
import { HashLoader } from 'react-spinners';

const Loader = () => (
  <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh' }}>
    <HashLoader size={50} color={"#123abc"} loading={true} />
  </div>
);

export default Loader;
