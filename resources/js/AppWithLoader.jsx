// resources/js/AppWithLoader.jsx
import React, { useState, useEffect } from 'react';
import { Inertia } from '@inertiajs/inertia';
import { PrimeReactProvider } from 'primereact/api';
import { LayoutProvider } from '@/Layouts/layout/context/layoutcontext.jsx';
import Loader from '@/Components/Loader';

const AppWithLoader = ({ App, props }) => {
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    Inertia.on('start', () => setLoading(true));
    Inertia.on('finish', () => setLoading(false));

    return () => {
      Inertia.off('start', () => setLoading(true));
      Inertia.off('finish', () => setLoading(false));
    };
  }, []);

  return (
    <PrimeReactProvider>
      <LayoutProvider>
        {loading && <Loader />}
        <App {...props} />
      </LayoutProvider>
    </PrimeReactProvider>
  );
};

export default AppWithLoader;
