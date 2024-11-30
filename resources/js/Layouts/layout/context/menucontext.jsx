import React, { createContext, useReducer, useEffect } from 'react';

export const MenuContext = createContext({});

const menuReducer = (state, action) => {
    switch (action.type) {
        case 'SET_ACTIVE_MENU':
            return {
                ...state,
                activeMenu: action.payload
            };
        case 'TOGGLE_SUBMENU':
            return {
                ...state,
                activeSubMenus: {
                    ...state.activeSubMenus,
                    [action.payload]: !state.activeSubMenus[action.payload]
                }
            };
        case 'LOAD_STATE':
            return {
                ...state,
                activeSubMenus: action.payload.activeSubMenus,
                activeMenu: action.payload.activeMenu
            };
        default:
            return state;
    }
};

export const MenuProvider = ({ children }) => {
    const [state, dispatch] = useReducer(menuReducer, {
        activeMenu: '',
        activeSubMenus: {}
    });

    useEffect(() => {
        const savedState = localStorage.getItem('menuState');
        if (savedState) {
            dispatch({ type: 'LOAD_STATE', payload: JSON.parse(savedState) });
        }
    }, []);

    useEffect(() => {
        localStorage.setItem('menuState', JSON.stringify(state));
    }, [state]);

    const setActiveMenu = (key) => {
        dispatch({ type: 'SET_ACTIVE_MENU', payload: key });
    };

    const toggleSubMenu = (key) => {
        dispatch({ type: 'TOGGLE_SUBMENU', payload: key });
    };

    const value = {
        activeMenu: state.activeMenu,
        setActiveMenu,
        activeSubMenus: state.activeSubMenus,
        toggleSubMenu
    };

    return <MenuContext.Provider value={value}>{children}</MenuContext.Provider>;
};
