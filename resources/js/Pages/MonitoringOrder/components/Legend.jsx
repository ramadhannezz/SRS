import React from 'react';
import { List, ListItem, ListItemIcon } from '@mui/material';
import LocalShippingIcon from '@mui/icons-material/LocalShipping';
import StoreMallDirectoryIcon from '@mui/icons-material/StoreMallDirectory';
import SwapHorizIcon from '@mui/icons-material/SwapHoriz';

const styles = {
  
  list: {
    fontSize: '0.8rem',
  },
  listItem: {
    padding: '4px 8px',
  },
  listItemIcon: {
    minWidth: '30px',
  },
  localShippingIcon: {
    color: 'blue',
    fontSize: '1.2rem',
  },
  storeMallDirectoryIcon: {
    color: 'gray',
    fontSize: '1.2rem',
  },
  swapHorizIcon: {
    color: 'darkblue',
    fontSize: '1.2rem',
  },
  textBlue: {
    color: 'blue',
    fontWeight: 'bold',
  },
  textGray: {
    color: 'gray',
    fontWeight: 'bold',
  },
  textDarkBlue: {
    color: 'darkblue',
    fontWeight: 'bold',
  },
};

const Legend = () => (
  <div className="legend">
    <List style={styles.list}> {/* Menggunakan style dari objek */}
      <ListItem style={styles.listItem}> {/* Tambahkan margin bottom */}
        <ListItemIcon style={styles.listItemIcon}>
          <LocalShippingIcon style={styles.localShippingIcon} />
        </ListItemIcon>
        <span style={styles.textBlue}>Muat</span>
      </ListItem>
      <ListItem style={styles.listItem}>
        <ListItemIcon style={styles.listItemIcon}>
          <StoreMallDirectoryIcon style={styles.storeMallDirectoryIcon} />
        </ListItemIcon>
        <span style={styles.textGray}>Bongkar</span>
      </ListItem>
      <ListItem style={styles.listItem}>
        <ListItemIcon style={styles.listItemIcon}>
          <SwapHorizIcon style={styles.swapHorizIcon} />
        </ListItemIcon>
        <span style={styles.textDarkBlue}>Bongkar - Muat</span>
      </ListItem>
    </List>
  </div>
);

export default Legend;
