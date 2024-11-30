import { Ripple } from 'primereact/ripple';
import { classNames } from 'primereact/utils';
import React, { useEffect, useContext } from 'react';
import { CSSTransition } from 'react-transition-group';
import { MenuContext } from './context/menucontext';
import { Link } from "@inertiajs/react";
import '../../../css/Layouts/AppMenu.css';

const AppMenuitem = (props) => {
    const pathname = route(route().current());
    const { activeMenu, setActiveMenu, activeSubMenus, toggleSubMenu } = useContext(MenuContext);
    const item = props.item;
    const key = props.parentKey ? props.parentKey + '-' + props.index : String(props.index);
    const isActiveRoute = item.to && pathname === item.to;
    const isSubMenuActive = activeSubMenus[key];

    const onRouteChange = (url) => {
        if (item.to && item.to === url) {
            setActiveMenu(key);
        }
    };

    useEffect(() => {
        onRouteChange(pathname);
    }, [pathname]);

    const itemClick = (event) => {
        if (item.disabled) {
            event.preventDefault();
            return;
        }

        if (item.command) {
            item.command({ originalEvent: event, item: item });
        }

        if (item.items) {
            toggleSubMenu(key);
        } else {
            setActiveMenu(key);
        }
    };

    const subMenu = item.items && item.visible !== false && (
        <CSSTransition timeout={{ enter: 1000, exit: 450 }} classNames="layout-submenu" in={isSubMenuActive} key={item.label}>
            <ul>
                {item.items.map((child, i) => {
                    return <AppMenuitem item={child} index={i} className={child.badgeClass} parentKey={key} key={child.label} />;
                })}
            </ul>
        </CSSTransition>
    );

    return (
        <li className={classNames({ 'layout-root-menuitem': props.root, 'active-menuitem': isActiveRoute })}>
            {props.root && item.visible !== false && <div className="layout-menuitem-root-text">{item.label}</div>}
            {(!item.to || item.items) && item.visible !== false ? (
                <a href={item.url} onClick={(e) => itemClick(e)} className={classNames(item.class, 'p-ripple')} target={item.target} tabIndex={0}>
                    <i className={classNames('layout-menuitem-icon', item.icon)}></i>
                    <span className="layout-menuitem-text">{item.label}</span>
                    {item.items && <i className={classNames('pi pi-fw', 'pi-angle-down', 'layout-submenu-toggler', { 'open': isSubMenuActive })}></i>}
                    <Ripple />
                </a>
            ) : null}

            {item.to && !item.items && item.visible !== false ? (
                <Link href={item.to} replace={item.replaceUrl} target={item.target} onClick={(e) => itemClick(e)} className={classNames(item.class, 'p-ripple', { 'active-route': isActiveRoute })} tabIndex={0}>
                    <i className={classNames('layout-menuitem-icon', item.icon)}></i>
                    <span className="layout-menuitem-text">{item.label}</span>
                    <Ripple />
                </Link>
            ) : null}

            {subMenu}
        </li>
    );
};

export default AppMenuitem;
