import React from 'react';
import { List, Typography, Alert, Divider } from '@mui/material';
import { styled } from '@mui/material/styles';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell, { tableCellClasses } from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';

const styles = {
  headerTextTable: {
    fontWeight: 'bold', // Membuat teks header tabel tebal
    fontSize: '14px', // Ukuran teks header tabel
    textAlign: 'center', // Posisikan teks di tengah
    marginBottom: '15px', // Jarak bawah
  },
};

const StyledTableCell = styled(TableCell)(({ theme }) => ({
  [`&.${tableCellClasses.head}`]: {
    backgroundColor: '#7a888f', // Ubah background color untuk kolom header "Nama Muatan"
    color: theme.palette.common.white,
    fontSize: '10px', // Memperkecil ukuran teks judul tabel
    padding: '5px 0px', // Atur padding atas/bawah dan kiri/kanan
    textAlign: 'center', // Membuat teks menjadi center
  },
  [`&.${tableCellClasses.body}`]: {
    fontSize: 9,
    backgroundColor: '#eee', // Ubah background color untuk baris muatan
    padding: '15px 0px', // Atur padding atas/bawah dan kiri/kanan untuk baris body
    textAlign: 'center', // Membuat teks menjadi center untuk baris body
  },
}));

const StyledTableRow = styled(TableRow)(({ theme }) => ({
  '&:nth-of-type(odd)': {
    backgroundColor: theme.palette.action.hover,
  },
  // hide last border
  '&:last-child td, &:last-child th': {
    border: 0,
  },
}));

const InfoTrip = ({ order }) => (
  <div>
    <Alert severity="info" className="alert">Pelacakan trip ini belum menggunakan live tracking. Segera hubungi admin untuk info lebih lanjut.</Alert>
    <Divider className="divider" />
    <List>
      <div className="list-item">
        <span>No. DO</span>
        <span>: {order.nomor_order}</span>
      </div>
      <div className="list-item">
        <span>No. PO</span>
        <span>:  -</span>
      </div>
      <div className="list-item">
        <span>Customer</span>
        <span>: {order.customer_name}</span>
      </div>
      <div className="list-item">
        <span>No. TO</span>
        <span>: -</span>
      </div>
      <div className="list-item">
        <span>Vendor</span>
        <span>: {order.vendor_name}</span>
      </div>
      <br />
      <Divider className="divider" />
      <br />
      <div className="driver-truck">
        <div className="list-item">
          <span>Driver</span>
          <span>: {order.driver_name}</span>
        </div>
        <div className="list-item">
          <span>Truk</span>
          <span>: {order.truck_licensePlate}</span>
        </div>
        <div className="list-item">
          <span>Truk Type</span>
          <span>: {order.typetruck_name}</span>
        </div>
        <br />
      </div>
    </List>
    <Divider className="divider" />
    <br />
    <div style={styles.headerTextTable}>Detail Muatan</div>
    <TableContainer component={Paper}>
      <Table sx={{ minWidth: 5 }} aria-label="customized table">
        <TableHead>
          <TableRow>
            <StyledTableCell>Nama Muatan</StyledTableCell>
            <StyledTableCell align="right">Muatan Planning</StyledTableCell>
            <StyledTableCell align="right">Muatan Muat</StyledTableCell>
            <StyledTableCell align="right">Muatan Bongkar</StyledTableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          <StyledTableRow>
            <StyledTableCell component="th" scope="row">
              {order.nama_muatan}
            </StyledTableCell>
            <StyledTableCell align="right">{order.berat_muatan}</StyledTableCell>
            <StyledTableCell align="right">{order.berat_muatan}</StyledTableCell>
            <StyledTableCell align="right">{order.berat_muatan}</StyledTableCell>
          </StyledTableRow>
        </TableBody>
      </Table>
    </TableContainer>
  </div>
);

export default InfoTrip;
