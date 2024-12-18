// import './bootstrap';
// import '../css/app.css';

// import "primereact/resources/themes/lara-light-indigo/theme.css";
// import "primereact/resources/primereact.min.css";
// import "primeicons/primeicons.css";
// import 'primeflex/primeflex.css';
// import "@nextui-org/react/styles.css";


// import '../css/layout.css';

// import { createRoot } from 'react-dom/client';
// import { createInertiaApp } from '@inertiajs/react';
// import { resolvePageComponent } from 'laravel-vite-plugin/inertia-helpers';
// import { LayoutProvider } from "@/Layouts/layout/context/layoutcontext.jsx";
// import { PrimeReactProvider } from "primereact/api";
// import AppWithLoader from './AppWithLoader'; // Tambahkan impor AppWithLoader

// const appName = import.meta.env.VITE_APP_NAME || 'Laravel';

// createInertiaApp({
//     title: (title) => `${title} - ${appName}`,
//     resolve: (name) => resolvePageComponent(`./Pages/${name}.jsx`, import.meta.glob('./Pages/**/*.jsx')),
//     setup({ el, App, props }) {
//         const root = createRoot(el);

//         root.render(
//             <PrimeReactProvider>
//                 <LayoutProvider>
//                     <AppWithLoader App={App} props={props} /> {/* Ganti App dengan AppWithLoader */}
//                 </LayoutProvider>
//             </PrimeReactProvider>
//         );
//     },
//     progress: {
//         color: '#4B5563',
//     },
// });

import './bootstrap';
import '../css/app.css';

import "primereact/resources/themes/lara-light-indigo/theme.css";
import "primereact/resources/primereact.min.css";
import "primeicons/primeicons.css";
import 'primeflex/primeflex.css';

import '../css/layout.css';

// Next.UI
import { NextUIProvider } from "@nextui-org/react";

import { createRoot } from 'react-dom/client';
import { createInertiaApp } from '@inertiajs/react';
import { resolvePageComponent } from 'laravel-vite-plugin/inertia-helpers';

// PrimeReact
import { LayoutProvider } from "@/Layouts/layout/context/layoutcontext.jsx";
import { PrimeReactProvider } from "primereact/api";

import AppWithLoader from './AppWithLoader';

const appName = import.meta.env.VITE_APP_NAME || 'Laravel';

createInertiaApp({
    title: (title) => `${title} - ${appName}`,
    resolve: (name) => resolvePageComponent(`./Pages/${name}.jsx`, import.meta.glob('./Pages/**/*.jsx')),
    setup({ el, App, props }) {
        const root = createRoot(el);

        root.render(
            <NextUIProvider> {/* NextUI Context */}
                <PrimeReactProvider>
                    <LayoutProvider>
                        <AppWithLoader App={App} props={props} />
                    </LayoutProvider>
                </PrimeReactProvider>
            </NextUIProvider>
        );
    },
    progress: {
        color: '#4B5563',
    },
});
