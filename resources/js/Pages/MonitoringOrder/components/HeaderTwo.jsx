import React from 'react';
import { Typography, IconButton } from '@mui/material';
import ArrowBackIcon from '@mui/icons-material/ArrowBack';

const Header = () => {
  const handleBackClick = () => {
    window.history.back(); // Fungsi untuk kembali ke halaman sebelumnya
  };

  return (
    <div className="header">
      <IconButton
        edge="start"
        color="inherit"
        aria-label="back"
        className="icon-button"
        onClick={handleBackClick} // Tambahkan onClick untuk menangani klik pada ikon back
      >
        <ArrowBackIcon />
      </IconButton>
      <Typography variant="h6" style={{ fontSize: '1rem', fontWeight: 'bold' }}>
        Update Status Trip
      </Typography>
    </div>
  );
};

export default Header;
