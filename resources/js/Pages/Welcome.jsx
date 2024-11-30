import { Link, Head } from '@inertiajs/react';
import { LayoutContext, LayoutProvider } from "@/Layouts/layout/context/layoutcontext.jsx";
import { PrimeReactProvider } from "primereact/api";
import { Button } from "primereact/button";
import React, { useContext } from "react";

export default function Welcome({ auth, laravelVersion, phpVersion }) {
    const { layoutConfig } = useContext(LayoutContext);
    return (
        <>
            <PrimeReactProvider>
                <LayoutProvider>
                    <Head title="Welcome" />
                    <div className="relative sm:flex sm:justify-center sm:items-center min-h-screen bg-dots-darker bg-center bg-gray-100 dark:bg-dots-lighter dark:bg-gray-900 selection:bg-red-500 selection:text-white">
                        <div className="sm:fixed sm:top-0 sm:left-0 p-6">

                            <div className="flex align-items-center">
                                <img src={`/images/logo/-${layoutConfig.colorScheme !== 'light' ? 'white' : 'dark'}.svg`} width="100.22px" height={'35px'} alt="logo" className="mr-3" />
                            </div>
                        </div>

                        <div className="grid grid-nogutter surface-0 text-800">
                            <div className="col-12 md:col-6 p-6 text-center md:text-left flex align-items-center">
                                <section>
                                    <span className="block text-6xl font-bold mb-1">Smart Routing System</span>
                                    <div className="text-6xl text-primary font-bold mb-3">Optimalkan Rute Pengiriman Barang, Hemat Waktu dan Biaya</div>
                                    <p className="mt-0 mb-4 text-700 line-height-3">Smart Routing adalah solusi pintar untuk pengiriman barang yang memungkinkan pengoptimalan rute pengiriman menjadi lebih efisien. Dengan algoritma cerdas, Kita dapat menemukan rute terpendek dan tercepat untuk setiap pengiriman, serta menghemat waktu dan biaya operasional.</p>

                                    <Button label="Login" type="button" className="mr-3 p-button-raised" onClick={() => window.location.href = route('login')} />
                                    <Button label="Register" type="button" className="p-button-outlined" onClick={() => window.location.href = route('register')} />
                                </section>
                            </div>
                            <div className="col-12 md:col-6 overflow-hidden">
                                <img src="\images\hero\hero-4.jpg" alt="hero-4" className="md:ml-auto block w-full h-full object-cover" />
                            </div>
                        </div>
                    </div>
                </LayoutProvider>
            </PrimeReactProvider>
        </>
    );
}
