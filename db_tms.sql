-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 30, 2024 at 12:28 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_tms`
--

-- --------------------------------------------------------

--
-- Table structure for table `claims`
--

CREATE TABLE `claims` (
  `id_claim` bigint(20) UNSIGNED NOT NULL,
  `orders_id` bigint(20) UNSIGNED NOT NULL,
  `nama_muatan` bigint(20) UNSIGNED NOT NULL,
  `jumlah_barang` bigint(20) UNSIGNED NOT NULL,
  `status_muatan` enum('Rusak','Hilang','Kurang','Lebih') NOT NULL,
  `nama_muatan_claim` varchar(255) NOT NULL,
  `jumlah_muatan_claim` int(11) NOT NULL,
  `catatan_muatan` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `email`, `phone`, `created_at`, `updated_at`) VALUES
(1, 'PT. Rusli Vinilon Sakti', 'rjs@gmail.com', '02145789648', '2024-07-29 07:16:50', '2024-07-29 07:16:50'),
(2, 'Jon Stewart Doe', 'test@example.us', '6019521325', '2024-07-29 00:18:44', '2024-07-29 00:18:44');

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `orders_id` bigint(20) UNSIGNED NOT NULL,
  `unload_address_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `document_type` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `documents`
--

INSERT INTO `documents` (`id`, `orders_id`, `unload_address_id`, `type`, `document_type`, `file_path`, `created_at`, `updated_at`) VALUES
(165, 36, NULL, 'loading', 'surat_jalan', 'WvttayjGMeT6yU6M94W9SQhvWjfjukdwVYtY6Nwe.jpg', '2024-09-28 11:30:06', '2024-11-24 20:45:42'),
(166, 36, NULL, 'loading', 'packing_list', 'anJUlegkDjJ83NVVK0M2ZIkCJm2P9oqOt3QXqZ7k.png', '2024-09-28 11:30:06', '2024-09-28 11:30:06'),
(167, 36, NULL, 'loading', 'dokumen_lain', 'D4wEWiRNI5HUtToRBdOAN8pnsMg2qG2VmIWLIh4C.png', '2024-09-28 11:30:06', '2024-09-28 11:30:06'),
(168, 36, NULL, 'loading', 'proses_muat', 'uPiCJ5tHMpB5NueFSFYhJP3OD64SV3vC6Cl41e0e.png', '2024-09-28 11:30:06', '2024-09-28 11:30:06'),
(169, 36, 37, 'unloading', 'surat_jalan', 'f24MwRQt2chRgWuvWiR086P4jQ3ohYGmCleCfwHV.png', '2024-09-28 11:30:35', '2024-09-28 11:30:35'),
(170, 36, 37, 'unloading', 'proses_bongkar', 't6qVVzxT2vG9su4rDbjhM74gRHcLGrH5SSFGCTvU.png', '2024-09-28 11:30:36', '2024-09-28 11:30:36'),
(171, 36, 37, 'unloading', 'packing_list', 'RTHfbXtXj9aKw9dchaOhsPNvu7Y0o3Riln0Wdm0w.png', '2024-09-28 11:30:36', '2024-09-28 11:30:36'),
(172, 36, 37, 'unloading', 'dokumen_lain', 'XwqchMqNfTnVywKrbduRFUR2AcqPBbIjHN0cmRG4.png', '2024-09-28 11:30:36', '2024-09-28 11:30:36'),
(173, 38, NULL, 'loading', 'surat_jalan', 'lKijtpSrZHnT59mhSY2eXvtGpQjatjpXwptKTFn8.png', '2024-09-28 11:37:14', '2024-09-28 11:37:14'),
(174, 38, NULL, 'loading', 'proses_muat', 'rOr5aIIX8ew7RVz0qbO29Xkj7TegKl96WUp7wuEM.png', '2024-09-28 11:37:14', '2024-09-28 11:37:14'),
(175, 38, NULL, 'loading', 'packing_list', '80yTCTLjkLkP7aJkMWg6LKAhKxRBNkp6LahRFVBk.png', '2024-09-28 11:37:15', '2024-09-28 11:37:15'),
(176, 38, NULL, 'loading', 'dokumen_lain', 'OzjWQOFsF23GLimCsEnmUsgVpRwZfRg1j3CTO1PN.png', '2024-09-28 11:37:15', '2024-09-28 11:37:15'),
(177, 38, 36, 'unloading', 'surat_jalan', 'UC9Ntk662iardeds3osmAE2i9iiux8K7kZZJNA2V.png', '2024-09-28 11:43:22', '2024-09-28 11:43:22'),
(178, 38, 36, 'unloading', 'proses_bongkar', 'wYV6oxNSkSs3V6c3NFoqKslbJQMIrKDfuvzIZelw.png', '2024-09-28 11:43:22', '2024-09-28 11:43:22'),
(179, 38, 36, 'unloading', 'packing_list', 'iuVyAes5Hp1D3JZKLBQobnmBkieogjLnrN5zOktD.png', '2024-09-28 11:43:22', '2024-09-28 11:43:22'),
(180, 38, 36, 'unloading', 'dokumen_lain', 'arxeRgnxo7KBQF0kLRWhx42UX5UpvH3oeH65TaBK.png', '2024-09-28 11:43:22', '2024-09-28 11:43:22'),
(181, 38, 38, 'unloading', 'surat_jalan', 'KwJECcTmNJLJQUcOwRb5iT03WkKkGncI5Y9TEOb2.png', '2024-09-28 11:44:11', '2024-09-28 11:44:11'),
(182, 38, 38, 'unloading', 'proses_bongkar', 'Qf0Xm1kEyFXIu6VdbyqirPiop3fBW8dkenlmtJgI.png', '2024-09-28 11:44:12', '2024-09-28 11:44:12'),
(183, 38, 38, 'unloading', 'packing_list', '5dNwxaJx076smFwdfa6zKrbqwECmLbgSqihdprtS.png', '2024-09-28 11:44:12', '2024-09-28 11:44:12'),
(184, 38, 38, 'unloading', 'dokumen_lain', 'eyUmYbFxNi6jvsfT3nncJwKDtU96gCzoutm4lpjL.png', '2024-09-28 11:44:12', '2024-09-28 11:44:12'),
(185, 35, NULL, 'loading', 'surat_jalan', 'SqomOzFgfi0WqwnetfW5U9qDTxFlr6pNkFdSCcDb.png', '2024-09-30 22:40:54', '2024-09-30 22:40:54'),
(186, 35, NULL, 'loading', 'proses_muat', 'tplNSH7zbTkqB703dIDNAWnlxg04AE2lwzOZqwbY.png', '2024-09-30 22:40:54', '2024-09-30 22:40:54'),
(187, 35, NULL, 'loading', 'packing_list', 'Z5KUKRdvvVDjLaD5I262K570XprYDMZInX4sXhfR.png', '2024-09-30 22:40:55', '2024-09-30 22:40:55'),
(188, 35, NULL, 'loading', 'dokumen_lain', 'dBUPWDJ3f5Gm6DwBoYvxdeFJtctQcyGSTBYBoW52.png', '2024-09-30 22:40:55', '2024-09-30 22:40:55'),
(189, 35, 31, 'unloading', 'surat_jalan', 'otf2WUpnQpOWfJzNTqP2qLBy9B8HDlis7hDCBVm7.png', '2024-09-30 22:41:30', '2024-09-30 22:41:30'),
(190, 35, 31, 'unloading', 'proses_bongkar', 'NAESAOOakjWoC4zt0DHMyO3Oaf4fyQ4q5gqDtiN5.jpg', '2024-09-30 22:41:30', '2024-09-30 22:41:30'),
(191, 35, 31, 'unloading', 'packing_list', '5dyc6ouh9MsZKc45AyXISbLyq6xAlqt1rfTb17Lj.jpg', '2024-09-30 22:41:31', '2024-09-30 22:41:31'),
(192, 35, 31, 'unloading', 'dokumen_lain', 'sw1AWzkzh8JDUuVtY3abBu3vtPOCW2N9fsjA3w9r.png', '2024-09-30 22:41:31', '2024-09-30 22:41:31'),
(193, 34, NULL, 'loading', 'surat_jalan', 'pOSdEPTXwOgJFxL7DEof29bxRvFoCi4GQ6PZfNFG.jpg', '2024-11-22 17:35:13', '2024-11-22 17:35:13');

-- --------------------------------------------------------

--
-- Table structure for table `drivers`
--

CREATE TABLE `drivers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `otp` int(4) NOT NULL,
  `ktp` varchar(20) NOT NULL,
  `sim` varchar(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `drivers`
--

INSERT INTO `drivers` (`id`, `name`, `email`, `password`, `phone`, `otp`, `ktp`, `sim`, `created_at`, `updated_at`) VALUES
(1, 'Ramadhan', '', '', '081119932111', 0, '3208150801000002', '123456789', '2024-07-22 02:29:18', '2024-07-22 02:31:23'),
(2, 'Ramkative', '', '', '085721207991', 0, '3208150801000002', '789456123', '2024-07-22 02:32:13', '2024-07-22 02:32:13'),
(3, 'Rama', 'rama@waresix.com', 'ramadan10', '085721207992', 0, '3208150801000009', '12345678', '2024-09-29 06:02:45', '2024-09-29 06:02:45');

-- --------------------------------------------------------

--
-- Table structure for table `driver_locations`
--

CREATE TABLE `driver_locations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `driver_id` int(11) NOT NULL,
  `latitude` decimal(10,7) NOT NULL,
  `longitude` decimal(10,7) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `driver_locations`
--

INSERT INTO `driver_locations` (`id`, `driver_id`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES
(1, 3, 37.4219983, -122.0840000, '2024-10-01 03:26:29', '2024-10-01 03:26:29'),
(2, 3, 37.4219983, -122.0840000, '2024-10-01 04:01:08', '2024-10-01 04:01:08'),
(3, 3, -6.3742210, 106.8958040, '2024-11-16 17:57:00', '2024-11-16 17:57:00');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `queue`, `payload`, `attempts`, `reserved_at`, `available_at`, `created_at`) VALUES
(5, 'default', '{\"uuid\":\"c360e5b5-a545-45ed-beed-5d68bba1e01d\",\"displayName\":\"App\\\\Events\\\\LocationUpdated\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\",\"command\":\"O:38:\\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\\":14:{s:5:\\\"event\\\";O:26:\\\"App\\\\Events\\\\LocationUpdated\\\":3:{s:9:\\\"driver_id\\\";i:3;s:8:\\\"latitude\\\";d:37.4219983;s:9:\\\"longitude\\\";d:-122.084;}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:7:\\\"backoff\\\";N;s:13:\\\"maxExceptions\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1731805022, 1731805022);

-- --------------------------------------------------------

--
-- Table structure for table `kategori_lokasi`
--

CREATE TABLE `kategori_lokasi` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `icon` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kategori_lokasi`
--

INSERT INTO `kategori_lokasi` (`id`, `name`, `icon`, `created_at`, `updated_at`) VALUES
(4, 'Gudang', 'icons/eWB68hxvUP5pkOX6dGNdgQYj6BgVwHkPOjV7gPqm.png', '2024-06-09 21:01:45', '2024-08-25 22:22:54'),
(5, 'Pabrik', 'icons/uhCkDPJKL5X1GhcJxVnyv7250ilNc6Vw2ymLUjiz.png', '2024-06-09 21:02:53', '2024-08-25 22:22:47'),
(6, 'Toko', 'icons/owlbx69xrcHoG0CRFkAJqwL1siwM2LRIuLMygD3h.png', '2024-06-10 00:46:40', '2024-08-25 22:22:59');

-- --------------------------------------------------------

--
-- Table structure for table `kotas`
--

CREATE TABLE `kotas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `region` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kotas`
--

INSERT INTO `kotas` (`id`, `name`, `region`, `created_at`, `updated_at`) VALUES
(1, 'Jakarta Timur', 'DKI Jakarta', '2024-06-09 20:55:14', '2024-06-09 20:55:14'),
(2, 'Jakarta Utara', 'DKI Jakarta', '2024-06-09 20:55:26', '2024-06-09 20:55:26'),
(3, 'Bogor', 'Jawa Barat', '2024-06-09 21:03:45', '2024-06-09 21:03:45'),
(4, 'Jakarta Pusat', 'DKI Jakarta', '2024-06-10 00:46:54', '2024-06-10 00:46:54'),
(5, 'Jakarta Selatan', 'DKI Jakarta', '2024-06-10 00:47:03', '2024-06-10 00:47:03'),
(6, 'Jakarta Barat', 'DKI Jakarta', '2024-06-10 00:47:11', '2024-06-10 00:47:11'),
(7, 'Tangerang', 'Banten', '2024-06-10 00:47:20', '2024-06-10 00:47:20'),
(8, 'Tangerang Selatan', 'Banten', '2024-06-10 00:47:28', '2024-06-10 00:47:28'),
(9, 'Bekasi', 'Jawa Barat', '2024-06-10 00:47:42', '2024-06-10 00:47:42'),
(10, 'Depok', 'Jawa Barat', '2024-06-27 08:48:33', '2024-06-27 08:48:33'),
(11, 'Karawang', 'Jawa Barat', '2024-06-27 08:49:03', '2024-06-27 08:49:03'),
(12, 'Pandeglang', 'Banten', '2024-06-27 08:49:22', '2024-06-27 08:49:22');

-- --------------------------------------------------------

--
-- Table structure for table `lokasi_bongkar`
--

CREATE TABLE `lokasi_bongkar` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `kotas_id` bigint(20) UNSIGNED NOT NULL,
  `coordinate` varchar(255) NOT NULL,
  `kategori_lokasi_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lokasi_bongkar`
--

INSERT INTO `lokasi_bongkar` (`id`, `name`, `address`, `kotas_id`, `coordinate`, `kategori_lokasi_id`, `created_at`, `updated_at`) VALUES
(27, 'Bumi Mas (Nawi), TB', 'No. 29 B, Jl. H. Nawi Raya, RT.7/RW.2, Gandaria Sel., Kec. Cilandak, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12420', 5, '\"-6.2643107,106.7917814\"', 6, '2024-06-18 21:55:42', '2024-06-18 21:55:42'),
(28, 'Aneka Elektro I', 'Jl. Raya Pasar Minggu No.83 7, RT.2/RW.1, Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12510', 5, '\"-6.2832999,106.8444239\"', 5, '2024-06-18 21:56:12', '2024-06-18 21:56:12'),
(29, 'Aneka Jaya (Pasar Minggu), TB', 'Jl. H. Samali No.9 4, RT.1/RW.4, Kalibata, Kec. Pancoran, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12740', 5, '\"-6.2661731,106.8405662\"', 5, '2024-06-18 21:56:12', '2024-06-18 21:56:12'),
(30, 'Arteri Jaya', 'Jl. Tentara Pelajar, No. 10 Rt 3/8, Patal Senayan, Jakarta, RT.1/RW.7, North Grogol, Kebayoran Lama, South Jakarta City, Jakarta 12210', 5, '\"-6.2178056,106.7895403\"', 5, '2024-06-18 21:56:12', '2024-06-18 21:56:12'),
(31, 'Bangun Indah Gemilang(Psr Mgg)', '12, Jl. Taman Margasatwa Raya No.2, RT.12/RW.5, Jati Padang, Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12540', 5, '\"-6.292806,106.8228914\"', 5, '2024-06-18 21:56:12', '2024-06-18 21:56:12'),
(32, 'Bangun Jaya ( Amil )', 'Jl. H. Amil No.25, Pejaten Bar., Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12520', 5, '\"-6.2728878,106.8334344\"', 5, '2024-06-18 21:56:12', '2024-06-18 21:56:12'),
(33, 'Bangun Jaya ( Pasar Minggu )', 'Jl. Raya Ps. Minggu No.43, Pejaten Timur, Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12510', 5, '\"-6.2836997,106.8424994\"', 6, '2024-06-18 21:56:12', '2024-06-18 21:56:12'),
(34, 'Bintang Makmur (Lebak Bulus), TB', 'Jl. Lb. Bulus III No.40 8, RT.8/RW.7, Pd. Labu, Kec. Cilandak, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12450', 5, '\"-6.3021439,106.7894435\"', 6, '2024-06-18 21:56:12', '2024-06-18 21:56:12'),
(35, 'Bintang Terang ( Bangka )', '12, Jl. Bangka IX C No.37, RT.10/RW.10, Pela Mampang, Kec. Mampang Prpt., Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12720', 5, '\"-6.2534176,106.819636\"', 6, '2024-06-18 21:56:12', '2024-06-18 21:56:12'),
(36, 'Bintang Terang (Pasar Minggu), TB', 'No. 22 A, Jl. Raya Rw. Bambu, RT.13/RW.5, Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12520', 5, '\"-6.2928865,106.838721\"', 6, '2024-06-18 21:56:12', '2024-06-18 21:56:12'),
(37, 'Bumi Mas (Nawi), TB', 'No. 29 B, Jl. H. Nawi Raya, RT.7/RW.2, Gandaria Sel., Kec. Cilandak, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12420', 5, '\"-6.2643107,106.7917814\"', 6, '2024-06-18 21:56:12', '2024-06-18 21:56:12'),
(38, 'ZXC Rama', 'Gg. 1 No.2 K, RT.2/RW.6, Tomang, Grogol petamburan', 1, '\"-6.2224125,106.8588638\"', 4, '2024-06-18 21:56:27', '2024-06-18 21:56:27');

-- --------------------------------------------------------

--
-- Table structure for table `lokasi_muat`
--

CREATE TABLE `lokasi_muat` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `kotas_id` bigint(20) UNSIGNED NOT NULL,
  `coordinate` varchar(255) NOT NULL,
  `kategori_lokasi_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lokasi_muat`
--

INSERT INTO `lokasi_muat` (`id`, `name`, `address`, `kotas_id`, `coordinate`, `kategori_lokasi_id`, `created_at`, `updated_at`) VALUES
(1, 'PT. Rusli Vinilon Sakti', 'Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820', 1, '\"-6.3506041,106.9696443\"', 5, '2024-06-09 21:03:31', '2024-06-09 21:03:31');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2024_05_31_035853_create_kotas_table', 1),
(6, '2024_06_03_073112_create_kategori_lokasi_table', 1),
(7, '2024_06_03_103705_create_lokasi_muat_table', 1),
(8, '2024_06_03_160519_create_lokasi_bongkar_table', 1),
(9, '2024_06_05_030016_create_lokasi_table', 1),
(10, '2024_06_06_044555_create_routes_table', 1),
(11, '2024_06_19_095101_create_customers_table', 2),
(12, '2024_06_19_095204_create_customer_table', 3),
(13, '2024_06_19_095544_create_service_table', 3),
(14, '2024_06_19_095617_create_truck_table', 3),
(15, '2024_06_19_095625_create_orders_table', 4),
(16, '2024_06_20_035841_create_customers_table', 5),
(17, '2024_06_20_035841_create_services_table', 5),
(18, '2024_06_20_035842_create_trucks_table', 5),
(19, '2024_06_20_071728_create_orders_table', 6),
(20, '2024_07_22_080616_create_drivers_table', 7),
(21, '2024_07_22_130808_create_trucks_table', 8),
(22, '2024_07_22_142302_create_trucks_table', 9),
(23, '2024_07_22_171410_create_trucks_table', 10),
(24, '2024_07_29_071111_create_customers_table', 11),
(25, '2024_07_30_030350_add_route_to_orders_table', 12),
(26, '2024_07_30_033047_update_orders_table_for_routes', 13),
(27, '2024_07_30_054945_update_orders_table_for_routes', 14),
(28, '2024_07_31_022353_update_orders_table_for_smartrouting', 15),
(29, '2024_07_31_033838_update_orders_table_for_smartrouting', 16),
(30, '2024_08_02_130438_add_truck_and_driver_to_orders_table', 17),
(31, '2024_08_10_032753_create_vendors_table', 18),
(32, '2024_08_10_134352_add_vendor_id_to_orders_table', 19),
(33, '2024_08_11_043931_add_current_status_to_orders_table', 20),
(34, '2024_08_16_034539_create_order_status_logs_table', 21),
(35, '2024_08_16_040215_create_claims_table', 21),
(36, '2024_08_16_040649_create_surat_jalan_table', 21),
(39, '2024_08_16_052601_create_claims_table', 22),
(40, '2024_08_24_171435_create_order_status_logs_table', 23),
(41, '2024_08_25_085703_update_nomor_order_to_orders_id_in_surat_jalan_table', 24),
(42, '2024_08_25_085839_update_nomor_order_to_orders_id_in_claims_table', 24),
(43, '2024_08_25_155654_create_surat_jalan_table', 25),
(44, '2024_08_25_155740_create_unload_addresses_table', 25),
(45, '2024_08_25_174946_create_documents_table', 26),
(46, '2024_08_25_183558_create_documents_table', 27),
(47, '2024_08_26_050832_create_documents_table', 28),
(48, '2024_08_26_062254_add_unload_address_id_to_documents_table', 29),
(49, '2024_09_09_091750_create_otp_codes_table', 30),
(50, '2024_09_27_044603_add_document_and_cargo_data_to_order_status_logs_table', 31),
(51, '2024_09_29_065712_add_drivers_id_to_otp_codes_table', 32),
(52, '2024_10_01_062430_create_driver_locations_table', 33),
(53, '2024_10_01_110645_create_jobs_table', 34);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nomor_order` varchar(255) DEFAULT NULL,
  `customers_id` bigint(20) UNSIGNED NOT NULL,
  `services_id` bigint(20) UNSIGNED NOT NULL,
  `tanggal_muat` date NOT NULL,
  `typetrucks_id` bigint(20) UNSIGNED NOT NULL,
  `truck_id` bigint(20) UNSIGNED DEFAULT NULL,
  `vendor_id` bigint(20) UNSIGNED DEFAULT NULL,
  `driver_id` bigint(20) UNSIGNED DEFAULT NULL,
  `jumlah_armada` int(11) NOT NULL,
  `nama_muatan` varchar(255) NOT NULL,
  `berat_muatan` int(11) NOT NULL,
  `volume_muatan` int(11) NOT NULL,
  `jumlah_barang` int(11) NOT NULL,
  `uang_jalan` int(11) NOT NULL,
  `uang_tol` int(11) NOT NULL,
  `catatan` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `load_address` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`load_address`)),
  `unload_addresses` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`unload_addresses`)),
  `routes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`routes`)),
  `current_status` enum('Dijadwalkan Berangkat','Menuju Lokasi Muat','Sampai Lokasi Muat','Mulai Muat','Selesai Muat','Menuju Lokasi Bongkar','Sampai Lokasi Bongkar','Mulai Bongkar','Selesai Bongkar') NOT NULL DEFAULT 'Dijadwalkan Berangkat'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `nomor_order`, `customers_id`, `services_id`, `tanggal_muat`, `typetrucks_id`, `truck_id`, `vendor_id`, `driver_id`, `jumlah_armada`, `nama_muatan`, `berat_muatan`, `volume_muatan`, `jumlah_barang`, `uang_jalan`, `uang_tol`, `catatan`, `created_at`, `updated_at`, `load_address`, `unload_addresses`, `routes`, `current_status`) VALUES
(34, 'SRS15092024000001', 1, 1, '2024-09-15', 1, 1, NULL, 3, 1, 'Pipa Besi AW 1/2', 1100, 12, 1000, 200000, 2000000, 'Haha', '2024-09-15 08:43:23', '2024-11-22 18:11:14', '{\"id\":1,\"name\":\"PT. Rusli Vinilon Sakti\",\"address\":\"PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820\",\"kotas_id\":1,\"coordinate\":\"-6.3506041,106.9696443\",\"kategori_lokasi_id\":5,\"created_at\":\"2024-06-10T04:03:31.000000Z\",\"updated_at\":\"2024-06-10T04:03:31.000000Z\"}', '[{\"id\":28,\"name\":\"Aneka Elektro I\",\"address\":\"Aneka Elektro I - Jl. Raya Pasar Minggu No.83 7, RT.2\\/RW.1, Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12510\",\"kotas_id\":5,\"coordinate\":\"-6.2832999,106.8444239\",\"kategori_lokasi_id\":5,\"created_at\":\"2024-06-19T04:56:12.000000Z\",\"updated_at\":\"2024-06-19T04:56:12.000000Z\"}]', '[{\"lat\":-6.3507166,\"lng\":106.974842},{\"lat\":-6.284407499999999,\"lng\":106.8445221}]', 'Mulai Bongkar'),
(35, 'SRS15092024000002', 1, 1, '2024-09-15', 2, 1, NULL, 3, 1, 'Pipa Besi AW 1/2', 1200, 1200, 1000, 20000, 2000000, 'Haghahsa', '2024-09-15 08:47:10', '2024-11-22 17:57:57', '{\"id\":1,\"name\":\"PT. Rusli Vinilon Sakti\",\"address\":\"PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820\",\"kotas_id\":1,\"coordinate\":\"-6.3506041,106.9696443\",\"kategori_lokasi_id\":5,\"created_at\":\"2024-06-10T04:03:31.000000Z\",\"updated_at\":\"2024-06-10T04:03:31.000000Z\"}', '[{\"id\":31,\"name\":\"Bangun Indah Gemilang(Psr Mgg)\",\"address\":\"Bangun Indah Gemilang(Psr Mgg) - 12, Jl. Taman Margasatwa Raya No.2, RT.12\\/RW.5, Jati Padang, Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12540\",\"kotas_id\":5,\"coordinate\":\"-6.292806,106.8228914\",\"kategori_lokasi_id\":5,\"created_at\":\"2024-06-19T04:56:12.000000Z\",\"updated_at\":\"2024-06-19T04:56:12.000000Z\"}]', '[{\"lat\":-6.3507166,\"lng\":106.974842},{\"lat\":-6.293070699999999,\"lng\":106.8230966}]', 'Menuju Lokasi Muat'),
(36, 'SRS15092024000003', 2, 1, '2024-09-15', 1, 1, NULL, 3, 1, 'Pipa Besi AW 1/2', 120, 120, 120, 20000, 2000000, 'Bawa bom nuklir ya', '2024-09-15 08:50:12', '2024-11-24 20:46:01', '{\"id\":1,\"name\":\"PT. Rusli Vinilon Sakti\",\"address\":\"PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820\",\"kotas_id\":1,\"coordinate\":\"-6.3506041,106.9696443\",\"kategori_lokasi_id\":5,\"created_at\":\"2024-06-10T04:03:31.000000Z\",\"updated_at\":\"2024-06-10T04:03:31.000000Z\"}', '[{\"id\":37,\"name\":\"Bumi Mas (Nawi), TB\",\"address\":\"Bumi Mas (Nawi), TB - No. 29 B, Jl. H. Nawi Raya, RT.7\\/RW.2, Gandaria Sel., Kec. Cilandak, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12420\",\"kotas_id\":5,\"coordinate\":\"-6.2643107,106.7917814\",\"kategori_lokasi_id\":6,\"created_at\":\"2024-06-19T04:56:12.000000Z\",\"updated_at\":\"2024-06-19T04:56:12.000000Z\"}]', '[{\"lat\":-6.3507166,\"lng\":106.974842},{\"lat\":-6.2637247,\"lng\":106.7935374}]', 'Menuju Lokasi Bongkar'),
(37, 'SRS24092024000001', 1, 1, '2024-09-24', 1, NULL, NULL, 3, 1, 'Pipa HDPE', 100, 100, 10000, 200000, 200000, 'Jangan lupa bawa keluarga ya sekalian piknik', '2024-09-23 21:15:29', '2024-10-01 00:46:16', '{\"id\":1,\"name\":\"PT. Rusli Vinilon Sakti\",\"address\":\"PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820\",\"kotas_id\":1,\"coordinate\":\"-6.3506041,106.9696443\",\"kategori_lokasi_id\":5,\"created_at\":\"2024-06-10T04:03:31.000000Z\",\"updated_at\":\"2024-06-10T04:03:31.000000Z\"}', '[{\"id\":33,\"name\":\"Bangun Jaya ( Pasar Minggu )\",\"address\":\"Bangun Jaya ( Pasar Minggu ) - Jl. Raya Ps. Minggu No.43, Pejaten Timur, Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12510\",\"kotas_id\":5,\"coordinate\":\"-6.2836997,106.8424994\",\"kategori_lokasi_id\":6,\"created_at\":\"2024-06-19T04:56:12.000000Z\",\"updated_at\":\"2024-06-19T04:56:12.000000Z\"},{\"id\":38,\"name\":\"ZXC Rama\",\"address\":\"ZXC Rama - Gg. 1 No.2 K, RT.2\\/RW.6, Tomang, Grogol petamburan\",\"kotas_id\":1,\"coordinate\":\"-6.2224125,106.8588638\",\"kategori_lokasi_id\":4,\"created_at\":\"2024-06-19T04:56:27.000000Z\",\"updated_at\":\"2024-06-19T04:56:27.000000Z\"}]', '[{\"lat\":-6.3507166,\"lng\":106.974842},{\"lat\":-6.2723612,\"lng\":106.8466045},{\"lat\":-6.170450799999999,\"lng\":106.7970057}]', 'Dijadwalkan Berangkat'),
(38, 'SRS24092024000002', 2, 2, '2024-09-24', 1, NULL, NULL, NULL, 1, 'Pipa Paralon AW 1/2', 1100, 25, 1000, 200000, 200000, 'Jangan lupa bawa terpal karena musim ujan', '2024-09-23 21:17:29', '2024-09-28 11:44:13', '{\"id\":1,\"name\":\"PT. Rusli Vinilon Sakti\",\"address\":\"PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820\",\"kotas_id\":1,\"coordinate\":\"-6.3506041,106.9696443\",\"kategori_lokasi_id\":5,\"created_at\":\"2024-06-10T04:03:31.000000Z\",\"updated_at\":\"2024-06-10T04:03:31.000000Z\"}', '[{\"id\":36,\"name\":\"Bintang Terang (Pasar Minggu), TB\",\"address\":\"Bintang Terang (Pasar Minggu), TB - No. 22 A, Jl. Raya Rw. Bambu, RT.13\\/RW.5, Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12520\",\"kotas_id\":5,\"coordinate\":\"-6.2928865,106.838721\",\"kategori_lokasi_id\":6,\"created_at\":\"2024-06-19T04:56:12.000000Z\",\"updated_at\":\"2024-06-19T04:56:12.000000Z\"},{\"id\":38,\"name\":\"ZXC Rama\",\"address\":\"ZXC Rama - Gg. 1 No.2 K, RT.2\\/RW.6, Tomang, Grogol petamburan\",\"kotas_id\":1,\"coordinate\":\"-6.2224125,106.8588638\",\"kategori_lokasi_id\":4,\"created_at\":\"2024-06-19T04:56:27.000000Z\",\"updated_at\":\"2024-06-19T04:56:27.000000Z\"}]', '[{\"lat\":-6.3507166,\"lng\":106.974842},{\"lat\":-6.2924897,\"lng\":106.8415971},{\"lat\":-6.170450799999999,\"lng\":106.7970057}]', 'Dijadwalkan Berangkat');

-- --------------------------------------------------------

--
-- Table structure for table `order_status_logs`
--

CREATE TABLE `order_status_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `orders_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('Dijadwalkan Berangkat','Menuju Lokasi Muat','Sampai Lokasi Muat','Mulai Muat','Selesai Muat','Menuju Lokasi Bongkar','Sampai Lokasi Bongkar','Mulai Bongkar','Selesai Bongkar') NOT NULL DEFAULT 'Dijadwalkan Berangkat',
  `location_id` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_status_logs`
--

INSERT INTO `order_status_logs` (`id`, `orders_id`, `status`, `location_id`, `timestamp`, `created_at`, `updated_at`) VALUES
(261, 35, 'Menuju Lokasi Muat', 0, '2024-09-30 22:39:55', '2024-09-30 22:39:55', '2024-09-30 22:39:55'),
(262, 35, 'Sampai Lokasi Muat', 0, '2024-09-30 22:40:26', '2024-09-30 22:40:26', '2024-09-30 22:40:26'),
(263, 35, 'Mulai Muat', 0, '2024-09-30 22:40:29', '2024-09-30 22:40:29', '2024-09-30 22:40:29'),
(264, 35, 'Selesai Muat', 0, '2024-09-30 22:40:55', '2024-09-30 22:40:55', '2024-09-30 22:40:55'),
(265, 35, 'Menuju Lokasi Bongkar', 0, '2024-09-30 22:40:57', '2024-09-30 22:40:57', '2024-09-30 22:40:57'),
(266, 35, 'Sampai Lokasi Bongkar', 0, '2024-09-30 22:41:00', '2024-09-30 22:41:00', '2024-09-30 22:41:00'),
(267, 35, 'Mulai Bongkar', 0, '2024-09-30 22:41:02', '2024-09-30 22:41:02', '2024-09-30 22:41:02'),
(268, 35, 'Selesai Bongkar', 0, '2024-09-30 22:41:31', '2024-09-30 22:41:31', '2024-09-30 22:41:31'),
(269, 36, 'Menuju Lokasi Muat', 0, '2024-09-30 23:33:52', '2024-09-30 23:33:52', '2024-09-30 23:33:52'),
(270, 37, 'Menuju Lokasi Muat', 0, '2024-09-30 23:38:15', '2024-09-30 23:38:15', '2024-09-30 23:38:15'),
(271, 36, 'Menuju Lokasi Muat', 0, '2024-09-30 23:55:09', '2024-09-30 23:55:09', '2024-09-30 23:55:09'),
(272, 37, 'Menuju Lokasi Muat', 0, '2024-10-01 00:27:03', '2024-10-01 00:27:03', '2024-10-01 00:27:03'),
(273, 36, 'Menuju Lokasi Muat', 0, '2024-10-01 00:37:22', '2024-10-01 00:37:22', '2024-10-01 00:37:22'),
(274, 37, 'Menuju Lokasi Muat', 0, '2024-10-01 00:46:16', '2024-10-01 00:46:16', '2024-10-01 00:46:16'),
(275, 34, 'Menuju Lokasi Muat', 0, '2024-11-22 17:23:21', '2024-11-22 17:23:21', '2024-11-22 17:23:21'),
(276, 34, 'Sampai Lokasi Muat', 0, '2024-11-22 17:23:49', '2024-11-22 17:23:49', '2024-11-22 17:23:49'),
(277, 34, 'Mulai Muat', 0, '2024-11-22 17:24:07', '2024-11-22 17:24:07', '2024-11-22 17:24:07'),
(278, 34, 'Selesai Muat', 0, '2024-11-22 17:35:15', '2024-11-22 17:35:15', '2024-11-22 17:35:15'),
(279, 35, 'Menuju Lokasi Muat', 1, '2024-11-23 00:57:00', '2024-11-22 17:57:57', '2024-11-22 17:57:57'),
(280, 35, 'Sampai Lokasi Muat', 1, '2024-11-23 00:57:00', '2024-11-22 17:57:57', '2024-11-22 17:57:57'),
(281, 34, 'Menuju Lokasi Bongkar', 0, '2024-11-22 18:10:51', '2024-11-22 18:10:51', '2024-11-22 18:10:51'),
(282, 34, 'Sampai Lokasi Bongkar', 0, '2024-11-22 18:11:03', '2024-11-22 18:11:03', '2024-11-22 18:11:03'),
(283, 34, 'Mulai Bongkar', 0, '2024-11-22 18:11:14', '2024-11-22 18:11:14', '2024-11-22 18:11:14'),
(284, 36, 'Menuju Lokasi Muat', 0, '2024-11-24 20:43:53', '2024-11-24 20:43:53', '2024-11-24 20:43:53'),
(285, 36, 'Sampai Lokasi Muat', 0, '2024-11-24 20:44:36', '2024-11-24 20:44:36', '2024-11-24 20:44:36'),
(286, 36, 'Mulai Muat', 0, '2024-11-24 20:44:42', '2024-11-24 20:44:42', '2024-11-24 20:44:42'),
(287, 36, 'Selesai Muat', 0, '2024-11-24 20:45:45', '2024-11-24 20:45:45', '2024-11-24 20:45:45'),
(288, 36, 'Menuju Lokasi Bongkar', 0, '2024-11-24 20:46:01', '2024-11-24 20:46:01', '2024-11-24 20:46:01');

-- --------------------------------------------------------

--
-- Table structure for table `otp_codes`
--

CREATE TABLE `otp_codes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `drivers_id` bigint(20) UNSIGNED DEFAULT NULL,
  `phone_number` varchar(255) NOT NULL,
  `otp_code` varchar(255) NOT NULL,
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `is_logged_in` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `otp_codes`
--

INSERT INTO `otp_codes` (`id`, `drivers_id`, `phone_number`, `otp_code`, `expires_at`, `is_logged_in`, `created_at`, `updated_at`) VALUES
(99, 3, '085721207992', '4640', '2024-10-01 03:54:20', 1, '2024-09-30 20:29:20', '2024-09-30 20:54:20'),
(100, 3, '085721207992', '1267', '2024-10-01 03:29:33', 1, '2024-09-30 20:29:20', '2024-09-30 20:29:33'),
(101, 3, '085721207992', '2512', '2024-10-01 03:42:23', 0, '2024-09-30 20:42:23', '2024-09-30 20:42:23'),
(102, 3, '085721207992', '6997', '2024-10-01 03:54:05', 0, '2024-09-30 20:54:05', '2024-09-30 20:54:05'),
(103, 3, '085721207992', '8621', '2024-10-01 05:06:24', 1, '2024-09-30 22:06:10', '2024-09-30 22:06:24'),
(104, 3, '085721207992', '1111', '2024-11-25 03:37:31', 1, '2024-09-30 22:24:01', '2024-11-24 20:37:31'),
(105, 3, '085721207992', '5373', '2024-10-01 05:31:10', 0, '2024-09-30 22:31:10', '2024-09-30 22:31:10'),
(106, 3, '085721207992', '3283', '2024-10-01 05:31:47', 0, '2024-09-30 22:31:47', '2024-09-30 22:31:47'),
(107, 3, '085721207992', '4477', '2024-10-01 05:35:54', 0, '2024-09-30 22:35:54', '2024-09-30 22:35:54'),
(108, 3, '085721207992', '8594', '2024-10-01 06:07:45', 0, '2024-09-30 23:07:45', '2024-09-30 23:07:45'),
(109, 3, '085721207992', '1921', '2024-10-01 06:33:16', 0, '2024-09-30 23:33:16', '2024-09-30 23:33:16'),
(110, 3, '085721207992', '9303', '2024-10-01 06:37:42', 0, '2024-09-30 23:37:42', '2024-09-30 23:37:42'),
(111, 3, '085721207992', '1648', '2024-10-01 06:54:09', 0, '2024-09-30 23:54:09', '2024-09-30 23:54:09'),
(112, 3, '085721207992', '6055', '2024-10-01 07:26:21', 0, '2024-10-01 00:26:21', '2024-10-01 00:26:21'),
(113, 3, '085721207992', '2124', '2024-10-01 07:35:50', 0, '2024-10-01 00:35:50', '2024-10-01 00:35:50'),
(114, 3, '085721207992', '8893', '2024-10-01 07:45:58', 0, '2024-10-01 00:45:58', '2024-10-01 00:45:58'),
(115, 3, '085721207992', '2433', '2024-10-01 07:45:58', 0, '2024-10-01 00:45:58', '2024-10-01 00:45:58'),
(116, 3, '085721207992', '7158', '2024-10-01 08:15:41', 0, '2024-10-01 01:15:41', '2024-10-01 01:15:41'),
(117, 3, '085721207992', '7614', '2024-10-01 08:35:14', 0, '2024-10-01 01:35:14', '2024-10-01 01:35:14'),
(118, 3, '085721207992', '6676', '2024-10-01 08:45:13', 0, '2024-10-01 01:45:13', '2024-10-01 01:45:13'),
(119, 3, '085721207992', '2194', '2024-10-01 09:21:32', 0, '2024-10-01 02:21:32', '2024-10-01 02:21:32'),
(120, 3, '085721207992', '8303', '2024-10-01 09:42:32', 0, '2024-10-01 02:42:32', '2024-10-01 02:42:32'),
(121, 3, '085721207992', '8758', '2024-10-01 09:53:22', 0, '2024-10-01 02:53:22', '2024-10-01 02:53:22'),
(122, 3, '085721207992', '3251', '2024-10-01 09:57:04', 0, '2024-10-01 02:57:04', '2024-10-01 02:57:04'),
(123, 3, '085721207992', '3398', '2024-10-01 10:04:58', 0, '2024-10-01 03:04:58', '2024-10-01 03:04:58'),
(124, 3, '085721207992', '8445', '2024-10-01 11:00:56', 0, '2024-10-01 04:00:56', '2024-10-01 04:00:56'),
(125, 3, '085721207992', '6180', '2024-11-17 00:56:43', 0, '2024-11-16 17:56:43', '2024-11-16 17:56:43'),
(126, 3, '085721207992', '1435', '2024-11-21 15:15:22', 0, '2024-11-21 08:15:22', '2024-11-21 08:15:22'),
(127, 3, '085721207992', '6091', '2024-11-23 00:21:35', 0, '2024-11-22 17:21:35', '2024-11-22 17:21:35'),
(128, 3, '085721207992', '6593', '2024-11-23 00:21:39', 0, '2024-11-22 17:21:39', '2024-11-22 17:21:39'),
(129, 3, '085721207992', '2502', '2024-11-25 03:38:46', 1, '2024-11-24 20:37:02', '2024-11-24 20:38:46'),
(130, 3, '085721207992', '2828', '2024-11-25 03:42:51', 1, '2024-11-24 20:42:10', '2024-11-24 20:42:51');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `routes`
--

CREATE TABLE `routes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `load_address` varchar(255) NOT NULL,
  `unload_addresses` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`unload_addresses`)),
  `route` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`route`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `routes`
--

INSERT INTO `routes` (`id`, `load_address`, `unload_addresses`, `route`, `created_at`, `updated_at`) VALUES
(104, 'PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820', '\"[\\\"Aneka Jaya (Pasar Minggu), TB - Jl. H. Samali No.9 4, RT.1\\\\\\/RW.4, Kalibata, Kec. Pancoran, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12740\\\",\\\"Bumi Mas (Nawi), TB - No. 29 B, Jl. H. Nawi Raya, RT.7\\\\\\/RW.2, Gandaria Sel., Kec. Cilandak, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12420\\\"]\"', '\"{\\\"0\\\":{\\\"lat\\\":-6.3507166,\\\"lng\\\":106.974842},\\\"1\\\":{\\\"lat\\\":-6.2614927,\\\"lng\\\":106.8105998},\\\"3\\\":{\\\"lat\\\":-6.2637247,\\\"lng\\\":106.7935374}}\"', '2024-07-29 21:59:02', '2024-07-29 21:59:02'),
(105, 'PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820', '\"[\\\"Aneka Jaya (Pasar Minggu), TB - Jl. H. Samali No.9 4, RT.1\\\\\\/RW.4, Kalibata, Kec. Pancoran, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12740\\\",\\\"Arteri Jaya - Jl. Tentara Pelajar, No. 10 Rt 3\\\\\\/8, Patal Senayan, Jakarta, RT.1\\\\\\/RW.7, North Grogol, Kebayoran Lama, South Jakarta City, Jakarta 12210\\\"]\"', '\"{\\\"0\\\":{\\\"lat\\\":-6.3507166,\\\"lng\\\":106.974842},\\\"1\\\":{\\\"lat\\\":-6.2614927,\\\"lng\\\":106.8105998},\\\"3\\\":{\\\"lat\\\":-6.220173,\\\"lng\\\":106.7919362}}\"', '2024-07-29 23:40:34', '2024-07-29 23:40:34'),
(106, 'PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820', '\"[\\\"Bumi Mas (Nawi), TB - No. 29 B, Jl. H. Nawi Raya, RT.7\\\\\\/RW.2, Gandaria Sel., Kec. Cilandak, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12420\\\"]\"', '\"[{\\\"lat\\\":-6.3507166,\\\"lng\\\":106.974842},{\\\"lat\\\":-6.2637247,\\\"lng\\\":106.7935374}]\"', '2024-07-29 23:56:13', '2024-07-29 23:56:13'),
(107, 'PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820', '\"[\\\"Bumi Mas (Nawi), TB - No. 29 B, Jl. H. Nawi Raya, RT.7\\\\\\/RW.2, Gandaria Sel., Kec. Cilandak, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12420\\\"]\"', '\"[{\\\"lat\\\":-6.3507166,\\\"lng\\\":106.974842},{\\\"lat\\\":-6.2637247,\\\"lng\\\":106.7935374}]\"', '2024-07-29 23:57:31', '2024-07-29 23:57:31'),
(108, 'PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820', '\"[\\\"Bumi Mas (Nawi), TB - No. 29 B, Jl. H. Nawi Raya, RT.7\\\\\\/RW.2, Gandaria Sel., Kec. Cilandak, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12420\\\",\\\"Arteri Jaya - Jl. Tentara Pelajar, No. 10 Rt 3\\\\\\/8, Patal Senayan, Jakarta, RT.1\\\\\\/RW.7, North Grogol, Kebayoran Lama, South Jakarta City, Jakarta 12210\\\",\\\"ZXC Rama - Gg. 1 No.2 K, RT.2\\\\\\/RW.6, Tomang, Grogol petamburan\\\"]\"', '\"{\\\"0\\\":{\\\"lat\\\":-6.3507166,\\\"lng\\\":106.974842},\\\"1\\\":{\\\"lat\\\":-6.2637247,\\\"lng\\\":106.7935374},\\\"3\\\":{\\\"lat\\\":-6.220173,\\\"lng\\\":106.7919362},\\\"5\\\":{\\\"lat\\\":-6.170450799999999,\\\"lng\\\":106.7970057}}\"', '2024-07-29 23:58:38', '2024-07-29 23:58:38'),
(109, 'PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820', '\"[\\\"Aneka Elektro I - Jl. Raya Pasar Minggu No.83 7, RT.2\\\\\\/RW.1, Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12510\\\",\\\"Arteri Jaya - Jl. Tentara Pelajar, No. 10 Rt 3\\\\\\/8, Patal Senayan, Jakarta, RT.1\\\\\\/RW.7, North Grogol, Kebayoran Lama, South Jakarta City, Jakarta 12210\\\"]\"', '\"{\\\"0\\\":{\\\"lat\\\":-6.3507166,\\\"lng\\\":106.974842},\\\"1\\\":{\\\"lat\\\":-6.283294,\\\"lng\\\":106.8443004},\\\"3\\\":{\\\"lat\\\":-6.220173,\\\"lng\\\":106.7919362}}\"', '2024-07-30 20:47:42', '2024-07-30 20:47:42'),
(110, 'PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820', '\"[\\\"Bintang Makmur (Lebak Bulus), TB - Jl. Lb. Bulus III No.40 8, RT.8\\\\\\/RW.7, Pd. Labu, Kec. Cilandak, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12450\\\",\\\"Bumi Mas (Nawi), TB - No. 29 B, Jl. H. Nawi Raya, RT.7\\\\\\/RW.2, Gandaria Sel., Kec. Cilandak, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12420\\\",\\\"ZXC Rama - Gg. 1 No.2 K, RT.2\\\\\\/RW.6, Tomang, Grogol petamburan\\\"]\"', '\"{\\\"0\\\":{\\\"lat\\\":-6.3507166,\\\"lng\\\":106.974842},\\\"1\\\":{\\\"lat\\\":-6.3019047,\\\"lng\\\":106.7919424},\\\"3\\\":{\\\"lat\\\":-6.2637247,\\\"lng\\\":106.7935374},\\\"5\\\":{\\\"lat\\\":-6.170450799999999,\\\"lng\\\":106.7970057}}\"', '2024-07-30 21:12:45', '2024-07-30 21:12:45'),
(111, 'PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820', '\"[\\\"Bintang Makmur (Lebak Bulus), TB - Jl. Lb. Bulus III No.40 8, RT.8\\\\\\/RW.7, Pd. Labu, Kec. Cilandak, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12450\\\",\\\"Bumi Mas (Nawi), TB - No. 29 B, Jl. H. Nawi Raya, RT.7\\\\\\/RW.2, Gandaria Sel., Kec. Cilandak, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12420\\\",\\\"ZXC Rama - Gg. 1 No.2 K, RT.2\\\\\\/RW.6, Tomang, Grogol petamburan\\\"]\"', '\"{\\\"0\\\":{\\\"lat\\\":-6.3507166,\\\"lng\\\":106.974842},\\\"1\\\":{\\\"lat\\\":-6.3019047,\\\"lng\\\":106.7919424},\\\"3\\\":{\\\"lat\\\":-6.2637247,\\\"lng\\\":106.7935374},\\\"5\\\":{\\\"lat\\\":-6.170450799999999,\\\"lng\\\":106.7970057}}\"', '2024-07-30 21:18:49', '2024-07-30 21:18:49'),
(112, 'PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820', '\"[\\\"Aneka Elektro I - Jl. Raya Pasar Minggu No.83 7, RT.2\\\\\\/RW.1, Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12510\\\",\\\"Bumi Mas (Nawi), TB - No. 29 B, Jl. H. Nawi Raya, RT.7\\\\\\/RW.2, Gandaria Sel., Kec. Cilandak, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12420\\\",\\\"Arteri Jaya - Jl. Tentara Pelajar, No. 10 Rt 3\\\\\\/8, Patal Senayan, Jakarta, RT.1\\\\\\/RW.7, North Grogol, Kebayoran Lama, South Jakarta City, Jakarta 12210\\\"]\"', '\"{\\\"0\\\":{\\\"lat\\\":-6.3507166,\\\"lng\\\":106.974842},\\\"1\\\":{\\\"lat\\\":-6.284407499999999,\\\"lng\\\":106.8445221},\\\"3\\\":{\\\"lat\\\":-6.2637247,\\\"lng\\\":106.7935374},\\\"5\\\":{\\\"lat\\\":-6.220173,\\\"lng\\\":106.7919362}}\"', '2024-08-10 07:39:27', '2024-08-10 07:39:27'),
(113, 'PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820', '\"[\\\"Bintang Terang (Pasar Minggu), TB - No. 22 A, Jl. Raya Rw. Bambu, RT.13\\\\\\/RW.5, Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12520\\\",\\\"Aneka Elektro I - Jl. Raya Pasar Minggu No.83 7, RT.2\\\\\\/RW.1, Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12510\\\",\\\"Bangun Indah Gemilang(Psr Mgg) - 12, Jl. Taman Margasatwa Raya No.2, RT.12\\\\\\/RW.5, Jati Padang, Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12540\\\",\\\"Bumi Mas (Nawi), TB - No. 29 B, Jl. H. Nawi Raya, RT.7\\\\\\/RW.2, Gandaria Sel., Kec. Cilandak, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12420\\\",\\\"ZXC Rama - Gg. 1 No.2 K, RT.2\\\\\\/RW.6, Tomang, Grogol petamburan\\\"]\"', '\"{\\\"0\\\":{\\\"lat\\\":-6.3507166,\\\"lng\\\":106.974842},\\\"1\\\":{\\\"lat\\\":-6.2924897,\\\"lng\\\":106.8415971},\\\"3\\\":{\\\"lat\\\":-6.284407499999999,\\\"lng\\\":106.8445221},\\\"5\\\":{\\\"lat\\\":-6.293070699999999,\\\"lng\\\":106.8230966},\\\"7\\\":{\\\"lat\\\":-6.2637247,\\\"lng\\\":106.7935374},\\\"9\\\":{\\\"lat\\\":-6.170450799999999,\\\"lng\\\":106.7970057}}\"', '2024-08-11 22:37:38', '2024-08-11 22:37:38'),
(114, 'PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820', '\"[\\\"Aneka Elektro I - Jl. Raya Pasar Minggu No.83 7, RT.2\\\\\\/RW.1, Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12510\\\"]\"', '\"[{\\\"lat\\\":-6.3507166,\\\"lng\\\":106.974842},{\\\"lat\\\":-6.284407499999999,\\\"lng\\\":106.8445221}]\"', '2024-08-11 22:54:36', '2024-08-11 22:54:36'),
(115, 'PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820', '\"[\\\"Aneka Jaya (Pasar Minggu), TB - Jl. H. Samali No.9 4, RT.1\\\\\\/RW.4, Kalibata, Kec. Pancoran, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12740\\\"]\"', '\"[{\\\"lat\\\":-6.3507166,\\\"lng\\\":106.974842},{\\\"lat\\\":-6.2614927,\\\"lng\\\":106.8105998}]\"', '2024-08-11 23:50:52', '2024-08-11 23:50:52'),
(116, 'PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820', '\"[\\\"Arteri Jaya - Jl. Tentara Pelajar, No. 10 Rt 3\\\\\\/8, Patal Senayan, Jakarta, RT.1\\\\\\/RW.7, North Grogol, Kebayoran Lama, South Jakarta City, Jakarta 12210\\\"]\"', '\"[{\\\"lat\\\":-6.3507166,\\\"lng\\\":106.974842},{\\\"lat\\\":-6.220173,\\\"lng\\\":106.7919362}]\"', '2024-08-11 23:56:34', '2024-08-11 23:56:34'),
(117, 'PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820', '\"[\\\"Bintang Terang (Pasar Minggu), TB - No. 22 A, Jl. Raya Rw. Bambu, RT.13\\\\\\/RW.5, Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12520\\\",\\\"Bangun Jaya ( Pasar Minggu ) - Jl. Raya Ps. Minggu No.43, Pejaten Timur, Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12510\\\"]\"', '\"{\\\"0\\\":{\\\"lat\\\":-6.3507166,\\\"lng\\\":106.974842},\\\"1\\\":{\\\"lat\\\":-6.2924897,\\\"lng\\\":106.8415971},\\\"3\\\":{\\\"lat\\\":-6.2723612,\\\"lng\\\":106.8466045}}\"', '2024-08-27 21:30:46', '2024-08-27 21:30:46'),
(118, 'PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820', '\"[\\\"Aneka Elektro I - Jl. Raya Pasar Minggu No.83 7, RT.2\\\\\\/RW.1, Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12510\\\"]\"', '\"[{\\\"lat\\\":-6.3507166,\\\"lng\\\":106.974842},{\\\"lat\\\":-6.284407499999999,\\\"lng\\\":106.8445221}]\"', '2024-09-15 08:43:04', '2024-09-15 08:43:04'),
(119, 'PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820', '\"[\\\"Bangun Indah Gemilang(Psr Mgg) - 12, Jl. Taman Margasatwa Raya No.2, RT.12\\\\\\/RW.5, Jati Padang, Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12540\\\"]\"', '\"[{\\\"lat\\\":-6.3507166,\\\"lng\\\":106.974842},{\\\"lat\\\":-6.293070699999999,\\\"lng\\\":106.8230966}]\"', '2024-09-15 08:46:50', '2024-09-15 08:46:50'),
(120, 'PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820', '\"[\\\"Bumi Mas (Nawi), TB - No. 29 B, Jl. H. Nawi Raya, RT.7\\\\\\/RW.2, Gandaria Sel., Kec. Cilandak, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12420\\\"]\"', '\"[{\\\"lat\\\":-6.3507166,\\\"lng\\\":106.974842},{\\\"lat\\\":-6.2637247,\\\"lng\\\":106.7935374}]\"', '2024-09-15 08:48:24', '2024-09-15 08:48:24'),
(121, 'PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820', '\"[\\\"Bangun Jaya ( Amil ) - Jl. H. Amil No.25, Pejaten Bar., Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12520\\\",\\\"Bintang Terang ( Bangka ) - 12, Jl. Bangka IX C No.37, RT.10\\\\\\/RW.10, Pela Mampang, Kec. Mampang Prpt., Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12720\\\"]\"', '\"[{\\\"lat\\\":-6.3507166,\\\"lng\\\":106.974842},{\\\"lat\\\":-6.2614927,\\\"lng\\\":106.8105998}]\"', '2024-09-23 21:13:53', '2024-09-23 21:13:53'),
(122, 'PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820', '\"[\\\"Bangun Jaya ( Pasar Minggu ) - Jl. Raya Ps. Minggu No.43, Pejaten Timur, Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12510\\\",\\\"ZXC Rama - Gg. 1 No.2 K, RT.2\\\\\\/RW.6, Tomang, Grogol petamburan\\\"]\"', '\"{\\\"0\\\":{\\\"lat\\\":-6.3507166,\\\"lng\\\":106.974842},\\\"1\\\":{\\\"lat\\\":-6.2723612,\\\"lng\\\":106.8466045},\\\"3\\\":{\\\"lat\\\":-6.170450799999999,\\\"lng\\\":106.7970057}}\"', '2024-09-23 21:14:41', '2024-09-23 21:14:41'),
(123, 'PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820', '\"[\\\"Bintang Terang (Pasar Minggu), TB - No. 22 A, Jl. Raya Rw. Bambu, RT.13\\\\\\/RW.5, Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12520\\\",\\\"ZXC Rama - Gg. 1 No.2 K, RT.2\\\\\\/RW.6, Tomang, Grogol petamburan\\\"]\"', '\"{\\\"0\\\":{\\\"lat\\\":-6.3507166,\\\"lng\\\":106.974842},\\\"1\\\":{\\\"lat\\\":-6.2924897,\\\"lng\\\":106.8415971},\\\"3\\\":{\\\"lat\\\":-6.170450799999999,\\\"lng\\\":106.7970057}}\"', '2024-09-23 21:16:53', '2024-09-23 21:16:53');

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `name`) VALUES
(1, 'Domestik FTL'),
(2, 'Domestik LTL');

-- --------------------------------------------------------

--
-- Table structure for table `surat_jalan`
--

CREATE TABLE `surat_jalan` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `orders_id` bigint(20) UNSIGNED NOT NULL,
  `type` enum('muat','bongkar') NOT NULL,
  `file_type` enum('surat_jalan','proses_muat','packing_list','bukti_timbang','dokumen_lain') NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trucks`
--

CREATE TABLE `trucks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `licensePlate` varchar(255) NOT NULL,
  `truckType` varchar(255) NOT NULL,
  `typeYear` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `stnk` varchar(255) NOT NULL,
  `kir` varchar(255) NOT NULL,
  `gps` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `trucks`
--

INSERT INTO `trucks` (`id`, `licensePlate`, `truckType`, `typeYear`, `status`, `stnk`, `kir`, `gps`, `created_at`, `updated_at`) VALUES
(1, 'BH 1234 AEA', 'CDD Bak', 'Honda - 2020', 'Aktif', '12345678', '12345678', 'Non-Aktif', '2024-07-22 10:16:12', '2024-08-10 02:07:18');

-- --------------------------------------------------------

--
-- Table structure for table `typetrucks`
--

CREATE TABLE `typetrucks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `typetrucks`
--

INSERT INTO `typetrucks` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'CDD Bak', '2024-07-22 14:23:26', '2024-07-22 14:23:26'),
(2, 'CDE Bak', '2024-07-28 15:24:54', '2024-07-28 15:24:59');

-- --------------------------------------------------------

--
-- Table structure for table `unload_addresses`
--

CREATE TABLE `unload_addresses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `orders_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Rama', 'rama@gmail.com', NULL, '$2y$10$HWdyaPSr.xlVNLlUkP0Au.LsFNBTq.bICBvsKuxPaxQWZFBYL5f4O', NULL, '2024-06-18 18:30:34', '2024-06-18 18:30:34'),
(2, 'ZXC Rama', 'rjs@gmail.com', NULL, '$2y$10$DpE49Iz3KSgJK/lfa2ijNusd.icHLBf6YBZmIAZi7zr69TUMf3gEC', NULL, '2024-06-21 03:07:05', '2024-06-21 03:07:05'),
(3, 'ZXC Rama', 'ramadhan8100@gmail.com', NULL, '$2y$10$lt4Wq0P8cntEvC8OF8jysuLLpwdFK34/Emo2eol/7V.Pm5xMV4qkm', NULL, '2024-11-16 17:47:32', '2024-11-16 17:47:32'),
(4, 'Jon Stewart Doe', 'jsd@gmail.com', NULL, '$2y$10$20MtA.NJcyS2NWAIMEJzI.X/6ldjc1emi5pw/ODYKuaeppDzWj1ze', NULL, '2024-11-22 08:22:51', '2024-11-22 08:22:51');

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vendors`
--

INSERT INTO `vendors` (`id`, `name`, `email`, `phone`, `created_at`, `updated_at`) VALUES
(1, 'Rama Transport Indonesia', 'rtb@gmail.com', '082122191695', '2024-08-09 21:04:39', '2024-08-09 21:04:39'),
(2, 'ZXC Rama', 'rjs@gmail.com', '6019521325', '2024-08-10 04:58:50', '2024-08-10 04:58:50');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `claims`
--
ALTER TABLE `claims`
  ADD PRIMARY KEY (`id_claim`),
  ADD KEY `claims_nama_muatan_foreign` (`nama_muatan`),
  ADD KEY `claims_jumlah_barang_foreign` (`jumlah_barang`),
  ADD KEY `claims_orders_id_foreign` (`orders_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customers_email_unique` (`email`),
  ADD UNIQUE KEY `customers_phone_unique` (`phone`);

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documents_orders_id_foreign` (`orders_id`);

--
-- Indexes for table `drivers`
--
ALTER TABLE `drivers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `driver_locations`
--
ALTER TABLE `driver_locations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `kategori_lokasi`
--
ALTER TABLE `kategori_lokasi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kotas`
--
ALTER TABLE `kotas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lokasi_bongkar`
--
ALTER TABLE `lokasi_bongkar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lokasi_bongkar_kotas_id_foreign` (`kotas_id`),
  ADD KEY `lokasi_bongkar_kategori_lokasi_id_foreign` (`kategori_lokasi_id`);

--
-- Indexes for table `lokasi_muat`
--
ALTER TABLE `lokasi_muat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lokasi_muat_kotas_id_foreign` (`kotas_id`),
  ADD KEY `lokasi_muat_kategori_lokasi_id_foreign` (`kategori_lokasi_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nomor_order` (`nomor_order`),
  ADD KEY `orders_customers_id_foreign` (`customers_id`),
  ADD KEY `orders_services_id_foreign` (`services_id`),
  ADD KEY `orders_trucks_id_foreign` (`typetrucks_id`),
  ADD KEY `orders_truck_id_foreign` (`truck_id`),
  ADD KEY `orders_driver_id_foreign` (`driver_id`),
  ADD KEY `orders_vendor_id_foreign` (`vendor_id`);

--
-- Indexes for table `order_status_logs`
--
ALTER TABLE `order_status_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_status_logs_orders_id_foreign` (`orders_id`);

--
-- Indexes for table `otp_codes`
--
ALTER TABLE `otp_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `otp_codes_drivers_id_foreign` (`drivers_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `routes`
--
ALTER TABLE `routes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `surat_jalan`
--
ALTER TABLE `surat_jalan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `surat_jalan_orders_id_foreign` (`orders_id`);

--
-- Indexes for table `trucks`
--
ALTER TABLE `trucks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `trucks_licenseplate_unique` (`licensePlate`);

--
-- Indexes for table `typetrucks`
--
ALTER TABLE `typetrucks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `unload_addresses`
--
ALTER TABLE `unload_addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `unload_addresses_orders_id_foreign` (`orders_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `vendors_email_unique` (`email`),
  ADD UNIQUE KEY `vendors_phone_unique` (`phone`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `claims`
--
ALTER TABLE `claims`
  MODIFY `id_claim` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=194;

--
-- AUTO_INCREMENT for table `drivers`
--
ALTER TABLE `drivers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `driver_locations`
--
ALTER TABLE `driver_locations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `kategori_lokasi`
--
ALTER TABLE `kategori_lokasi`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `kotas`
--
ALTER TABLE `kotas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `lokasi_bongkar`
--
ALTER TABLE `lokasi_bongkar`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `lokasi_muat`
--
ALTER TABLE `lokasi_muat`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `order_status_logs`
--
ALTER TABLE `order_status_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=289;

--
-- AUTO_INCREMENT for table `otp_codes`
--
ALTER TABLE `otp_codes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=131;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `routes`
--
ALTER TABLE `routes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=124;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `surat_jalan`
--
ALTER TABLE `surat_jalan`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trucks`
--
ALTER TABLE `trucks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `typetrucks`
--
ALTER TABLE `typetrucks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `unload_addresses`
--
ALTER TABLE `unload_addresses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `claims`
--
ALTER TABLE `claims`
  ADD CONSTRAINT `claims_jumlah_barang_foreign` FOREIGN KEY (`jumlah_barang`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `claims_nama_muatan_foreign` FOREIGN KEY (`nama_muatan`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `claims_orders_id_foreign` FOREIGN KEY (`orders_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `documents_orders_id_foreign` FOREIGN KEY (`orders_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `lokasi_bongkar`
--
ALTER TABLE `lokasi_bongkar`
  ADD CONSTRAINT `lokasi_bongkar_kategori_lokasi_id_foreign` FOREIGN KEY (`kategori_lokasi_id`) REFERENCES `kategori_lokasi` (`id`),
  ADD CONSTRAINT `lokasi_bongkar_kotas_id_foreign` FOREIGN KEY (`kotas_id`) REFERENCES `kotas` (`id`);

--
-- Constraints for table `lokasi_muat`
--
ALTER TABLE `lokasi_muat`
  ADD CONSTRAINT `lokasi_muat_kategori_lokasi_id_foreign` FOREIGN KEY (`kategori_lokasi_id`) REFERENCES `kategori_lokasi` (`id`),
  ADD CONSTRAINT `lokasi_muat_kotas_id_foreign` FOREIGN KEY (`kotas_id`) REFERENCES `kotas` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_customers_id_foreign` FOREIGN KEY (`customers_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `orders_driver_id_foreign` FOREIGN KEY (`driver_id`) REFERENCES `drivers` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `orders_services_id_foreign` FOREIGN KEY (`services_id`) REFERENCES `services` (`id`),
  ADD CONSTRAINT `orders_truck_id_foreign` FOREIGN KEY (`truck_id`) REFERENCES `trucks` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `orders_trucks_id_foreign` FOREIGN KEY (`typetrucks_id`) REFERENCES `typetrucks` (`id`),
  ADD CONSTRAINT `orders_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `order_status_logs`
--
ALTER TABLE `order_status_logs`
  ADD CONSTRAINT `order_status_logs_orders_id_foreign` FOREIGN KEY (`orders_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `otp_codes`
--
ALTER TABLE `otp_codes`
  ADD CONSTRAINT `otp_codes_drivers_id_foreign` FOREIGN KEY (`drivers_id`) REFERENCES `drivers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `surat_jalan`
--
ALTER TABLE `surat_jalan`
  ADD CONSTRAINT `surat_jalan_orders_id_foreign` FOREIGN KEY (`orders_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `unload_addresses`
--
ALTER TABLE `unload_addresses`
  ADD CONSTRAINT `unload_addresses_orders_id_foreign` FOREIGN KEY (`orders_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
