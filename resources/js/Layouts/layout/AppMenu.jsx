import React, { useContext } from 'react';
import AppMenuitem from './AppMenuitem';
import { LayoutContext } from './context/layoutcontext';
import { MenuProvider } from './context/menucontext';
import {Link} from "@inertiajs/react";

const AppMenu = () => {
    const { layoutConfig } = useContext(LayoutContext);



    const model = [
        {
            label: 'Home',
            items: [
                { label: 'Dashboard', icon: 'pi pi-fw pi-home', to: route('dashboard') },
                // { label: 'Button', icon: 'pi pi-fw pi-id-card', to: route('button') },
                {
                    label: 'Master Data', icon: 'pi pi-fw pi-database',
                    items: [
                { label: 'Customer', icon: 'pi pi-fw pi-users', to: route('customer.index') },
                { label: 'Vendor', icon: 'pi pi-fw pi-user', to: route('vendor.index') },
                { label: 'City', icon: 'pi pi-fw pi-building', to: route('kota') },
                { label: 'Category', icon: 'pi pi-fw pi-tags', to: route('kategori-lokasi.index') },
                { label: 'Pickup Location', icon: 'pi pi-fw pi-window-maximize', to: route('lokasiMuat.index') },
                { label: 'Delivery Location', icon: 'pi pi-fw pi-window-minimize', to: route('lokasiBongkar.index') },
                    ]
                },
                {
                    label: 'Fleet Management', icon: 'pi pi-fw pi-car',
                    items: [
                        { label: 'Driver', icon: 'pi pi-fw pi-users', to: route('drivers.index') },
                        { label: 'Truck', icon: 'pi pi-fw pi-truck', to: route('trucks.index') },
                    ]
                },
                {
                    label: 'Order Management', icon: 'pi pi-fw pi-th-large',
                    items: [
                { label: 'Smart Routing', icon: 'pi pi-fw pi-directions', to: route('smart-routing') },
                { label: 'List Order', icon: 'pi pi-fw pi-list', to: route('orders.index') },
                    ]
                },
                { label: 'Claim Management', icon: 'pi pi-fw pi-shield', to: route('claim-management') },
            ]
        },
    ];

    return (
        <MenuProvider>
            <ul className="layout-menu">
                {model.map((item, i) => {
                    return !item?.seperator ? <AppMenuitem item={item} root={true} index={i} key={item.label} /> : <li className="menu-separator"></li>;
                })}


            </ul>
        </MenuProvider>
    );
};

export default AppMenu;
