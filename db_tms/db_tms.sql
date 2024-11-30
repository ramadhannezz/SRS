-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 25, 2024 at 06:21 AM
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
(46, 36, 37, 'unloading', 'surat_jalan', 'eF4j5GhXcTDWkGCjpBxEuPMQsD2JwhHojrgISVss.png', '2024-09-24 07:41:04', '2024-09-24 07:41:04'),
(47, 36, 37, 'unloading', 'packing_list', 'pvlxlHV4HyYqKAgQ8CsbOwa3eU4y5t2BAE0kWP4k.png', '2024-09-24 07:41:05', '2024-09-24 07:41:05'),
(48, 36, 37, 'unloading', 'dokumen_lain', 'UMakNG1ePf2MXs7s9S9di9LhQD1cZql2Y2TbrY5h.png', '2024-09-24 07:41:05', '2024-09-24 07:41:05'),
(49, 34, 28, 'unloading', 'surat_jalan', 'utgp59bQDBKtq47Urb790C31v3guEJitqhsjjM5G.png', '2024-09-24 07:44:09', '2024-09-24 07:44:09'),
(50, 34, 28, 'unloading', 'proses_bongkar', 'kGZ6Sd1kxKuHWtKa0fnkuI1glgZcnL1JOzLPY5wN.png', '2024-09-24 07:44:10', '2024-09-24 07:44:10'),
(51, 34, 28, 'unloading', 'packing_list', 'Qgbp3ZtkIS5cIotlrYxGHah5luU0932GBOibsmdT.png', '2024-09-24 07:44:10', '2024-09-24 07:44:10'),
(52, 34, 28, 'unloading', 'dokumen_lain', 'FG9D6DRUh6WMcbG64hhFTXqFQMVWqF7u6BuPTEO4.png', '2024-09-24 07:44:10', '2024-09-24 07:44:10'),
(53, 35, NULL, 'loading', 'surat_jalan', '7UTZiY8xy3gIc5m8qErKEdtvRLN3dEccgC1xRBtU.png', '2024-09-24 08:09:29', '2024-09-24 08:09:29'),
(54, 35, NULL, 'loading', 'proses_muat', '3nxMprKmnDmqUPHu3h22NqnxpL6SE1khOAzKHvPa.png', '2024-09-24 08:09:29', '2024-09-24 08:09:29'),
(55, 35, NULL, 'loading', 'packing_list', 'BxSQPDf5aSly8wnt0NNvAfBs7SEAy5fdpKKFZGF3.png', '2024-09-24 08:09:30', '2024-09-24 08:09:30'),
(56, 35, NULL, 'loading', 'dokumen_lain', 'fzDqpL41myNJd7KPOgBy83QRd7JaR3zsf49aAnFr.png', '2024-09-24 08:09:30', '2024-09-24 08:09:30'),
(57, 35, 31, 'unloading', 'surat_jalan', 'zDgBeF0yoB8QbmcxSBQYfcsgsXRIBPBEifDch8Mx.png', '2024-09-24 08:10:46', '2024-09-24 08:10:46'),
(58, 35, 31, 'unloading', 'proses_bongkar', 'SIIg0ZP1JnAImfK2iWbE71Y28Ai8CjRGStHRFdrQ.png', '2024-09-24 08:10:46', '2024-09-24 08:10:46'),
(59, 35, 31, 'unloading', 'packing_list', 'vzIzHF1eN4qLXyajyJONrFrP5FjAd0Jk3Nz3nCNU.png', '2024-09-24 08:10:46', '2024-09-24 08:10:46'),
(60, 35, 31, 'unloading', 'dokumen_lain', 'yJEwFZCl7FbmkW9GHpspZI5FkhdxAq03n1YvGBPy.png', '2024-09-24 08:10:46', '2024-09-24 08:10:46'),
(61, 37, NULL, 'loading', 'surat_jalan', 'Kxa5kZHKpd1wwQ4tWh6jY7oPvpJOrq8bT5hOi7by.png', '2024-09-24 11:21:04', '2024-09-24 11:21:04'),
(62, 37, NULL, 'loading', 'proses_muat', 'IhTs5HyIu3GzTuUMMIZfvCsUkrmyjv8bfGE153DU.png', '2024-09-24 11:21:04', '2024-09-24 11:21:04'),
(63, 37, NULL, 'loading', 'packing_list', 'thlxvaBzke3tF5it5Z9BijYvO7zgwp7wV5X5h3Z5.png', '2024-09-24 11:21:04', '2024-09-24 11:21:04'),
(64, 37, NULL, 'loading', 'dokumen_lain', 'jYwQxn3fIoo0VYi1VPtV1Wem45Gc7HozQ9M04GjP.png', '2024-09-24 11:21:05', '2024-09-24 11:21:05');

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
(2, 'Ramkative', '', '', '085721207992', 0, '3208150801000002', '789456123', '2024-07-22 02:32:13', '2024-07-22 02:32:13');

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
(49, '2024_09_09_091750_create_otp_codes_table', 30);

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
(34, 'SRS15092024000001', 1, 1, '2024-09-15', 1, NULL, NULL, NULL, 1, 'Pipa Besi AW 1/2', 11000, 12, 10000, 200000, 2000000, 'Haha', '2024-09-15 08:43:23', '2024-09-24 07:44:10', '{\"id\":1,\"name\":\"PT. Rusli Vinilon Sakti\",\"address\":\"PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820\",\"kotas_id\":1,\"coordinate\":\"-6.3506041,106.9696443\",\"kategori_lokasi_id\":5,\"created_at\":\"2024-06-10T04:03:31.000000Z\",\"updated_at\":\"2024-06-10T04:03:31.000000Z\"}', '[{\"id\":28,\"name\":\"Aneka Elektro I\",\"address\":\"Aneka Elektro I - Jl. Raya Pasar Minggu No.83 7, RT.2\\/RW.1, Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12510\",\"kotas_id\":5,\"coordinate\":\"-6.2832999,106.8444239\",\"kategori_lokasi_id\":5,\"created_at\":\"2024-06-19T04:56:12.000000Z\",\"updated_at\":\"2024-06-19T04:56:12.000000Z\"}]', '[{\"lat\":-6.3507166,\"lng\":106.974842},{\"lat\":-6.284407499999999,\"lng\":106.8445221}]', 'Selesai Bongkar'),
(35, 'SRS15092024000002', 1, 1, '2024-09-15', 2, NULL, NULL, NULL, 1, 'Pipa Besi AW 1/2', 1200, 1200, 10000, 20000, 2000000, 'Haghahsa', '2024-09-15 08:47:10', '2024-09-24 08:10:47', '{\"id\":1,\"name\":\"PT. Rusli Vinilon Sakti\",\"address\":\"PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820\",\"kotas_id\":1,\"coordinate\":\"-6.3506041,106.9696443\",\"kategori_lokasi_id\":5,\"created_at\":\"2024-06-10T04:03:31.000000Z\",\"updated_at\":\"2024-06-10T04:03:31.000000Z\"}', '[{\"id\":31,\"name\":\"Bangun Indah Gemilang(Psr Mgg)\",\"address\":\"Bangun Indah Gemilang(Psr Mgg) - 12, Jl. Taman Margasatwa Raya No.2, RT.12\\/RW.5, Jati Padang, Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12540\",\"kotas_id\":5,\"coordinate\":\"-6.292806,106.8228914\",\"kategori_lokasi_id\":5,\"created_at\":\"2024-06-19T04:56:12.000000Z\",\"updated_at\":\"2024-06-19T04:56:12.000000Z\"}]', '[{\"lat\":-6.3507166,\"lng\":106.974842},{\"lat\":-6.293070699999999,\"lng\":106.8230966}]', 'Selesai Bongkar'),
(36, 'SRS15092024000003', 2, 1, '2024-09-15', 1, NULL, NULL, NULL, 1, 'Pipa Besi AW 1/2', 12, 12, 120000, 20000, 2000000, 'Bawa bom nuklir ya', '2024-09-15 08:50:12', '2024-09-24 07:41:05', '{\"id\":1,\"name\":\"PT. Rusli Vinilon Sakti\",\"address\":\"PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820\",\"kotas_id\":1,\"coordinate\":\"-6.3506041,106.9696443\",\"kategori_lokasi_id\":5,\"created_at\":\"2024-06-10T04:03:31.000000Z\",\"updated_at\":\"2024-06-10T04:03:31.000000Z\"}', '[{\"id\":37,\"name\":\"Bumi Mas (Nawi), TB\",\"address\":\"Bumi Mas (Nawi), TB - No. 29 B, Jl. H. Nawi Raya, RT.7\\/RW.2, Gandaria Sel., Kec. Cilandak, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12420\",\"kotas_id\":5,\"coordinate\":\"-6.2643107,106.7917814\",\"kategori_lokasi_id\":6,\"created_at\":\"2024-06-19T04:56:12.000000Z\",\"updated_at\":\"2024-06-19T04:56:12.000000Z\"}]', '[{\"lat\":-6.3507166,\"lng\":106.974842},{\"lat\":-6.2637247,\"lng\":106.7935374}]', 'Mulai Bongkar'),
(37, 'SRS24092024000001', 1, 1, '2024-09-24', 1, NULL, NULL, NULL, 1, 'Pipa Paralon AW 1/2', 11000, 12, 100, 200000, 200000, 'Jangan lupa bawa keluarga ya sekalian piknik', '2024-09-23 21:15:29', '2024-09-24 11:22:33', '{\"id\":1,\"name\":\"PT. Rusli Vinilon Sakti\",\"address\":\"PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820\",\"kotas_id\":1,\"coordinate\":\"-6.3506041,106.9696443\",\"kategori_lokasi_id\":5,\"created_at\":\"2024-06-10T04:03:31.000000Z\",\"updated_at\":\"2024-06-10T04:03:31.000000Z\"}', '[{\"id\":33,\"name\":\"Bangun Jaya ( Pasar Minggu )\",\"address\":\"Bangun Jaya ( Pasar Minggu ) - Jl. Raya Ps. Minggu No.43, Pejaten Timur, Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12510\",\"kotas_id\":5,\"coordinate\":\"-6.2836997,106.8424994\",\"kategori_lokasi_id\":6,\"created_at\":\"2024-06-19T04:56:12.000000Z\",\"updated_at\":\"2024-06-19T04:56:12.000000Z\"},{\"id\":38,\"name\":\"ZXC Rama\",\"address\":\"ZXC Rama - Gg. 1 No.2 K, RT.2\\/RW.6, Tomang, Grogol petamburan\",\"kotas_id\":1,\"coordinate\":\"-6.2224125,106.8588638\",\"kategori_lokasi_id\":4,\"created_at\":\"2024-06-19T04:56:27.000000Z\",\"updated_at\":\"2024-06-19T04:56:27.000000Z\"}]', '[{\"lat\":-6.3507166,\"lng\":106.974842},{\"lat\":-6.2723612,\"lng\":106.8466045},{\"lat\":-6.170450799999999,\"lng\":106.7970057}]', 'Mulai Bongkar'),
(38, 'SRS24092024000002', 2, 2, '2024-09-24', 1, NULL, NULL, NULL, 1, 'Pipa Paralon AW 1/2', 11000, 11, 100, 200000, 200000, 'Jangan lupa bawa terpal karena musim ujan', '2024-09-23 21:17:29', '2024-09-23 21:17:29', '{\"id\":1,\"name\":\"PT. Rusli Vinilon Sakti\",\"address\":\"PT. Rusli Vinilon Sakti - Jl. Raya Narogong No.KM 15, RW.5, Limus Nunggal, Kec. Cileungsi, Kabupaten Bogor, Jawa Barat 16820\",\"kotas_id\":1,\"coordinate\":\"-6.3506041,106.9696443\",\"kategori_lokasi_id\":5,\"created_at\":\"2024-06-10T04:03:31.000000Z\",\"updated_at\":\"2024-06-10T04:03:31.000000Z\"}', '[{\"id\":36,\"name\":\"Bintang Terang (Pasar Minggu), TB\",\"address\":\"Bintang Terang (Pasar Minggu), TB - No. 22 A, Jl. Raya Rw. Bambu, RT.13\\/RW.5, Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12520\",\"kotas_id\":5,\"coordinate\":\"-6.2928865,106.838721\",\"kategori_lokasi_id\":6,\"created_at\":\"2024-06-19T04:56:12.000000Z\",\"updated_at\":\"2024-06-19T04:56:12.000000Z\"},{\"id\":38,\"name\":\"ZXC Rama\",\"address\":\"ZXC Rama - Gg. 1 No.2 K, RT.2\\/RW.6, Tomang, Grogol petamburan\",\"kotas_id\":1,\"coordinate\":\"-6.2224125,106.8588638\",\"kategori_lokasi_id\":4,\"created_at\":\"2024-06-19T04:56:27.000000Z\",\"updated_at\":\"2024-06-19T04:56:27.000000Z\"}]', '[{\"lat\":-6.3507166,\"lng\":106.974842},{\"lat\":-6.2924897,\"lng\":106.8415971},{\"lat\":-6.170450799999999,\"lng\":106.7970057}]', 'Dijadwalkan Berangkat');

-- --------------------------------------------------------

--
-- Table structure for table `order_status_logs`
--

CREATE TABLE `order_status_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `orders_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('Dijadwalkan Berangkat','Menuju Lokasi Muat','Sampai Lokasi Muat','Mulai Muat','Selesai Muat','Menuju Lokasi Bongkar','Sampai Lokasi Bongkar','Mulai Bongkar','Selesai Bongkar') NOT NULL DEFAULT 'Dijadwalkan Berangkat',
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `otp_codes`
--

CREATE TABLE `otp_codes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `otp_code` varchar(255) NOT NULL,
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `otp_codes`
--

INSERT INTO `otp_codes` (`id`, `phone_number`, `otp_code`, `expires_at`, `created_at`, `updated_at`) VALUES
(7, '085721207992', 'hp6Z', '2024-09-10 01:47:44', '2024-09-09 18:47:44', '2024-09-09 18:47:44'),
(8, '085721207990', '4622', '2024-09-10 02:17:50', '2024-09-09 19:17:50', '2024-09-09 19:17:50'),
(9, '085721207991', '1297', '2024-09-10 02:19:51', '2024-09-09 19:19:51', '2024-09-09 19:19:51'),
(10, '085721207992', '4112', '2024-09-10 04:11:08', '2024-09-09 21:11:08', '2024-09-09 21:11:08'),
(11, '085721207992', '8497', '2024-09-12 02:06:03', '2024-09-11 19:06:03', '2024-09-11 19:06:03'),
(12, '085721207992', '4648', '2024-09-12 04:56:26', '2024-09-11 21:56:26', '2024-09-11 21:56:26'),
(13, '085721207992', '1594', '2024-09-12 04:58:52', '2024-09-11 21:58:52', '2024-09-11 21:58:52'),
(14, '1234567889', '9802', '2024-09-12 05:04:42', '2024-09-11 22:04:42', '2024-09-11 22:04:42'),
(15, '1234567890', '1111', '2024-09-12 05:06:20', '2024-09-11 22:06:11', '2024-09-11 22:06:11'),
(16, '1234567890', '1544', '2024-09-12 05:06:52', '2024-09-11 22:06:52', '2024-09-11 22:06:52'),
(17, '1234567890', '2108', '2024-09-12 05:07:27', '2024-09-11 22:07:27', '2024-09-11 22:07:27'),
(18, '1234567890', '9278', '2024-09-12 06:02:04', '2024-09-11 23:02:04', '2024-09-11 23:02:04'),
(19, '1234567890', '2549', '2024-09-12 06:02:31', '2024-09-11 23:02:31', '2024-09-11 23:02:31'),
(20, '1234567890', '8218', '2024-09-13 02:14:21', '2024-09-12 19:14:21', '2024-09-12 19:14:21'),
(21, '1234567890', '2637', '2024-09-13 02:14:21', '2024-09-12 19:14:21', '2024-09-12 19:14:21'),
(22, '1234567890', '7310', '2024-09-13 02:34:16', '2024-09-12 19:34:16', '2024-09-12 19:34:16'),
(23, '1234567890', '9754', '2024-09-13 02:34:16', '2024-09-12 19:34:16', '2024-09-12 19:34:16'),
(24, '1234567890', '3756', '2024-09-13 02:34:16', '2024-09-12 19:34:16', '2024-09-12 19:34:16'),
(25, '1234567890', '5673', '2024-09-14 04:04:23', '2024-09-13 21:04:23', '2024-09-13 21:04:23'),
(26, '1234567890', '3553', '2024-09-14 06:44:11', '2024-09-13 23:44:11', '2024-09-13 23:44:11'),
(27, '1234567890', '2212', '2024-09-14 07:38:23', '2024-09-14 00:38:23', '2024-09-14 00:38:23'),
(28, '1234567890', '8280', '2024-09-14 07:50:21', '2024-09-14 00:50:21', '2024-09-14 00:50:21'),
(29, '1234567890', '6734', '2024-09-15 02:14:55', '2024-09-14 19:14:55', '2024-09-14 19:14:55'),
(30, '1234567890', '6788', '2024-09-15 04:37:08', '2024-09-14 21:37:08', '2024-09-14 21:37:08'),
(31, '1234567890', '3988', '2024-09-15 04:38:02', '2024-09-14 21:38:02', '2024-09-14 21:38:02'),
(32, '1234567890', '1830', '2024-09-15 04:47:28', '2024-09-14 21:47:28', '2024-09-14 21:47:28'),
(33, '1234567890', '3314', '2024-09-15 04:56:50', '2024-09-14 21:56:50', '2024-09-14 21:56:50'),
(34, '1234567890', '3545', '2024-09-15 05:06:33', '2024-09-14 22:06:33', '2024-09-14 22:06:33'),
(35, '1234567890', '5484', '2024-09-15 05:33:35', '2024-09-14 22:33:35', '2024-09-14 22:33:35'),
(36, '1234567890', '8508', '2024-09-15 05:42:41', '2024-09-14 22:42:41', '2024-09-14 22:42:41'),
(37, '1234567890', '3883', '2024-09-15 05:52:12', '2024-09-14 22:52:12', '2024-09-14 22:52:12'),
(38, '1234567890', '9649', '2024-09-15 06:47:47', '2024-09-14 23:47:47', '2024-09-14 23:47:47'),
(39, '1234567890', '2750', '2024-09-15 17:41:36', '2024-09-15 10:41:36', '2024-09-15 10:41:36'),
(40, '1234567890', '2327', '2024-09-15 19:18:24', '2024-09-15 12:18:24', '2024-09-15 12:18:24'),
(41, '1234567890', '8278', '2024-09-15 19:18:24', '2024-09-15 12:18:24', '2024-09-15 12:18:24'),
(42, '1234567890', '3476', '2024-09-16 02:40:52', '2024-09-15 19:40:52', '2024-09-15 19:40:52'),
(43, '1234567890', '7301', '2024-09-16 03:00:34', '2024-09-15 20:00:34', '2024-09-15 20:00:34'),
(44, '1234567890', '2744', '2024-09-16 06:03:02', '2024-09-15 23:03:02', '2024-09-15 23:03:02'),
(45, '1234567890', '7231', '2024-09-16 09:07:53', '2024-09-16 02:07:53', '2024-09-16 02:07:53'),
(46, '1234567890', '9945', '2024-09-16 09:23:38', '2024-09-16 02:23:38', '2024-09-16 02:23:38'),
(47, '1234567890', '5150', '2024-09-16 09:50:36', '2024-09-16 02:50:36', '2024-09-16 02:50:36'),
(48, '1234567890', '8926', '2024-09-16 10:03:01', '2024-09-16 03:03:01', '2024-09-16 03:03:01'),
(49, '1234567890', '2330', '2024-09-16 10:14:00', '2024-09-16 03:14:00', '2024-09-16 03:14:00'),
(50, '1234567890', '9440', '2024-09-16 10:22:58', '2024-09-16 03:22:58', '2024-09-16 03:22:58'),
(51, '1234567890', '2774', '2024-09-16 13:36:19', '2024-09-16 06:36:19', '2024-09-16 06:36:19'),
(52, '1234567890', '7660', '2024-09-16 14:30:07', '2024-09-16 07:30:07', '2024-09-16 07:30:07'),
(53, '1234567890', '5524', '2024-09-16 14:50:06', '2024-09-16 07:50:06', '2024-09-16 07:50:06'),
(54, '1234567890', '8473', '2024-09-17 01:32:26', '2024-09-16 18:32:26', '2024-09-16 18:32:26'),
(55, '1234567890', '9464', '2024-09-17 01:32:26', '2024-09-16 18:32:26', '2024-09-16 18:32:26'),
(56, '1234567890', '5091', '2024-09-17 03:35:31', '2024-09-16 20:35:31', '2024-09-16 20:35:31'),
(57, '1234567890', '4444', '2024-09-17 04:05:34', '2024-09-16 21:05:34', '2024-09-16 21:05:34'),
(58, '1234567890', '7066', '2024-09-17 04:22:59', '2024-09-16 21:22:59', '2024-09-16 21:22:59');

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
(2, 'ZXC Rama', 'rjs@gmail.com', NULL, '$2y$10$DpE49Iz3KSgJK/lfa2ijNusd.icHLBf6YBZmIAZi7zr69TUMf3gEC', NULL, '2024-06-21 03:07:05', '2024-06-21 03:07:05');

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
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

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
  ADD PRIMARY KEY (`id`);

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `drivers`
--
ALTER TABLE `drivers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `order_status_logs`
--
ALTER TABLE `order_status_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT for table `otp_codes`
--
ALTER TABLE `otp_codes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
