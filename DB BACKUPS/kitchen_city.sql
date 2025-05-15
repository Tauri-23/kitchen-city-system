-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 15, 2025 at 12:48 PM
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
-- Database: `kitchen_city`
--

-- --------------------------------------------------------

--
-- Table structure for table `area_managers`
--

CREATE TABLE `area_managers` (
  `id` varchar(20) NOT NULL,
  `fname` varchar(50) NOT NULL,
  `mname` varchar(50) DEFAULT NULL,
  `lname` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `status` enum('Active','Suspended','Deleted') NOT NULL DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `area_managers`
--

INSERT INTO `area_managers` (`id`, `fname`, `mname`, `lname`, `email`, `status`, `created_at`, `updated_at`) VALUES
('97lu6HECbJyXFjZ8LN4f', 'Emily', '', 'Welsh', 'emilywelsh@gmail.com', 'Active', '2025-05-05 20:03:01', '2025-05-05 20:03:01'),
('nLO4rfS1nlaWWRTnk7bq', 'Michelle', '', 'Santos', 'chelleSan@gmail.com', 'Active', '2025-05-06 21:55:10', '2025-05-06 21:55:10'),
('Sxt3ngvFU4jKw0CLwqyG', 'John', '', 'Kalingkingan', 'johnkalingkingan@gmail.com', 'Active', '2025-05-06 21:57:57', '2025-05-06 21:57:57');

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `id` varchar(20) NOT NULL,
  `branch_code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `area_manager_id` varchar(20) DEFAULT NULL,
  `size` enum('XL','Large','Medium','Medium Frying','Small','Small Frying') NOT NULL,
  `status` enum('Active','Suspended','Discontinued') NOT NULL DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `branch_code`, `name`, `address`, `area_manager_id`, `size`, `status`, `created_at`, `updated_at`) VALUES
('DKTLQzdjrPHHWDgVJrfr', 'KC-0001', 'John Deli', 'BGC Taguig', '97lu6HECbJyXFjZ8LN4f', 'XL', 'Active', '2025-05-05 21:41:35', '2025-05-15 02:47:13'),
('EGj9rFHlwSl5zO7Xl86t', 'KC-0003', 'Al Fredo s', 'Mckinley Taguig', 'nLO4rfS1nlaWWRTnk7bq', 'Large', 'Active', '2025-05-15 01:44:43', '2025-05-15 02:44:20'),
('YT2Bc7EmqaUHRfB4EOnm', 'KC-0002', 'John Deli', 'SM Moa', '97lu6HECbJyXFjZ8LN4f', 'Medium', 'Active', '2025-05-05 21:46:19', '2025-05-15 08:39:58');

-- --------------------------------------------------------

--
-- Table structure for table `branch_managers`
--

CREATE TABLE `branch_managers` (
  `id` varchar(20) NOT NULL,
  `branch_id` varchar(20) DEFAULT NULL,
  `fname` varchar(50) NOT NULL,
  `mname` varchar(50) DEFAULT NULL,
  `lname` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(50) NOT NULL,
  `status` enum('Active','Suspended','Deleted') NOT NULL DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `branch_managers`
--

INSERT INTO `branch_managers` (`id`, `branch_id`, `fname`, `mname`, `lname`, `username`, `password`, `email`, `status`, `created_at`, `updated_at`) VALUES
('34WDVdLVEuLAWr5bJ6XY', 'DKTLQzdjrPHHWDgVJrfr', 'Jose', '', 'Black', 'jose123', '$2y$12$5QMBzyz.Vxo72KIVeGNpTep0Ehejn647R.w9lJjIXcmR3/3o4kVXG', 'joseblack@gmail.com', 'Active', '2025-05-05 23:23:44', '2025-05-05 23:23:44'),
('YgdlEev4fsPxNxD4b93X', 'YT2Bc7EmqaUHRfB4EOnm', 'John', '', 'Santos', 'johnsan123', '$2y$12$KRSJYiYUnr48.QRN0m58H.DMDxWRjmFqMuxYW5uYJMCS7gOxx73BG', 'johnSantos@gmail.com', 'Active', '2025-05-06 22:00:50', '2025-05-06 22:00:50');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` varchar(20) NOT NULL,
  `menu_name` varchar(255) DEFAULT NULL,
  `menu_week` int(11) NOT NULL,
  `menu_day` enum('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday') NOT NULL,
  `meal_type` enum('Breakfast','Lunch','Snack','Dinner','Midnight Lunch','Midnight Snack') NOT NULL,
  `menu_size` enum('XL','Large','Medium','Medium Frying','Small','Small Frying') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `menu_name`, `menu_week`, `menu_day`, `meal_type`, `menu_size`, `created_at`, `updated_at`) VALUES
('08JXqR0jSZXZXZRLXtrB', 'Saturday Week 4 Bfast Large', 4, 'Saturday', 'Breakfast', 'Large', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('09N3BD981VmoU1cNpBmY', 'Tuesday Week 1 Bfast Medium Frying', 1, 'Tuesday', 'Breakfast', 'Medium Frying', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('0A6pdjApVC3uzjGhg4PV', 'Thursday Week 3 Midnight Snack Large', 3, 'Thursday', 'Midnight Snack', 'Large', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('0AjAS2rIBehD80fAs7lM', 'Thursday Week 3 Snack Medium', 3, 'Thursday', 'Snack', 'Medium', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('0g05kBSQcGXWOZj4LfjP', 'Monday Week 3 Midnight Snack Large', 3, 'Monday', 'Midnight Snack', 'Large', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('0GxnriX7X4lleJLmSVp5', 'Wednesday Week 4 Midnight Snack Large', 4, 'Wednesday', 'Midnight Snack', 'Large', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('0iFE41lWYcqr0JLW5asQ', 'Thursday Week 4 Snack Medium', 4, 'Thursday', 'Snack', 'Medium', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('0NNpPcoPXguoYHTI8SO6', 'Monday Week 3 Midnight Snack XL', 3, 'Monday', 'Midnight Snack', 'XL', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('0OcmwS1u3Ey7QxLFZ2rF', 'Wednesday Week 4 Snack Small Frying', 4, 'Wednesday', 'Snack', 'Small Frying', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('0PBt7Ptwjzw6wDbF37Av', 'Thursday Week 1 Bfast Medium Frying', 1, 'Thursday', 'Breakfast', 'Medium Frying', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('0ps92xwoftGMslS6Slwa', 'Friday Week 4 Midnight Lunch Small Frying', 4, 'Friday', 'Midnight Lunch', 'Small Frying', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('0syY0zdv2vQPDUKeOl6w', 'Sunday Week 4 Lunch Small', 4, 'Sunday', 'Lunch', 'Small', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('10SfpvkUOUBJ5UkC8ZPk', 'Wednesday Week 3 Dinner Medium Frying', 3, 'Wednesday', 'Dinner', 'Medium Frying', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('12hradhyEhR38AcolxHa', 'Saturday Week 4 Dinner XL', 4, 'Saturday', 'Dinner', 'XL', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('14yD30NzWci4EUEVrljJ', 'Tuesday Week 1 Snack XL', 1, 'Tuesday', 'Snack', 'XL', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('187NsYR5U3rpR4waH8od', 'Saturday Week 2 Lunch Small', 2, 'Saturday', 'Lunch', 'Small', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('18JNj1YOdIZqmE8dEc2n', 'Wednesday Week 1 Midnight Lunch Large', 1, 'Wednesday', 'Midnight Lunch', 'Large', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('1CseihSyEQsO71UjTJmo', 'Thursday Week 3 Midnight Lunch Medium', 3, 'Thursday', 'Midnight Lunch', 'Medium', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('1h7jq98VaApyR17X3ar9', 'Thursday Week 4 Midnight Lunch Large', 4, 'Thursday', 'Midnight Lunch', 'Large', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('1KltmdG8o6CVcGJdcWa5', 'Saturday Week 1 Midnight Lunch XL', 1, 'Saturday', 'Midnight Lunch', 'XL', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('1NlD3WipIcagsJYoFq1L', 'Monday Week 4 Dinner Medium Frying', 4, 'Monday', 'Dinner', 'Medium Frying', '2025-05-10 07:48:53', '2025-05-10 07:48:53'),
('1Nux38g5dRE0uE7EVbLt', 'Tuesday Week 3 Midnight Snack XL', 3, 'Tuesday', 'Midnight Snack', 'XL', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('1p0GOQeLhQfTMCBR6E5l', 'Saturday Week 1 Lunch Large', 1, 'Saturday', 'Lunch', 'Large', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('1QBVDU9Yt0swxmJ1LE2K', 'Saturday Week 1 Dinner Medium', 1, 'Saturday', 'Dinner', 'Medium', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('1qt2CrtLbdfqaNdmhFCV', 'Wednesday Week 4 Midnight Snack XL', 4, 'Wednesday', 'Midnight Snack', 'XL', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('1Rl6tp41OlOITDuk8xB8', 'Friday Week 3 Midnight Snack Small Frying', 3, 'Friday', 'Midnight Snack', 'Small Frying', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('1UY1Oa36dvg3Cf409Ntp', 'Sunday Week 1 Midnight Snack Medium Frying', 1, 'Sunday', 'Midnight Snack', 'Medium Frying', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('1VQsoi7ieV0uiZwYYrbp', 'Thursday Week 2 Dinner Medium', 2, 'Thursday', 'Dinner', 'Medium', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('1xnSvdzSpNaMvy5HpzUx', 'Wednesday Week 2 Dinner Medium Frying', 2, 'Wednesday', 'Dinner', 'Medium Frying', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('1xwQ37zO0zwvLCUqd65L', 'Monday Week 4 Midnight Lunch XL', 4, 'Monday', 'Midnight Lunch', 'XL', '2025-05-10 07:48:53', '2025-05-10 07:48:53'),
('21ODR9HM2T3UxRhxBIBd', 'Saturday Week 1 Midnight Lunch Medium Frying', 1, 'Saturday', 'Midnight Lunch', 'Medium Frying', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('27aGe3Erz8DeTiaPM3l3', 'Monday Week 4 Dinner Small Frying', 4, 'Monday', 'Dinner', 'Small Frying', '2025-05-10 07:48:53', '2025-05-10 07:48:53'),
('2BIFEFtNgH7MyWVkTU2o', 'Wednesday Week 1 Snack Medium', 1, 'Wednesday', 'Snack', 'Medium', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('2BTRD4QEOn2GDRvPAQgP', 'Saturday Week 4 Midnight Lunch Medium', 4, 'Saturday', 'Midnight Lunch', 'Medium', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('2EtMr4naQ9HGBrgvM84v', 'Saturday Week 2 Midnight Snack Large', 2, 'Saturday', 'Midnight Snack', 'Large', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('2MNCddBeRFOuE0duGD8L', 'Wednesday Week 2 Dinner Small Frying', 2, 'Wednesday', 'Dinner', 'Small Frying', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('2osJbnUgFi5vQOI41EPB', 'Sunday Week 1 Midnight Lunch Small Frying', 1, 'Sunday', 'Midnight Lunch', 'Small Frying', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('2p3xyCVndnhLnlLHZGcM', 'Thursday Week 4 Dinner Small Frying', 4, 'Thursday', 'Dinner', 'Small Frying', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('2piWDNdpJJ5qNjjGfGL0', 'Wednesday Week 2 Snack XL', 2, 'Wednesday', 'Snack', 'XL', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('2sA84aqgcw71dJwwEgPM', 'Friday Week 2 Bfast XL', 2, 'Friday', 'Breakfast', 'XL', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('2yLYej5JN6MPTJdmHS8f', 'Thursday Week 4 Lunch Medium', 4, 'Thursday', 'Lunch', 'Medium', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('2YqJRGc7QNWuK9DO1uVH', 'Sunday Week 2 Midnight Lunch Large', 2, 'Sunday', 'Midnight Lunch', 'Large', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('32L0q7MHHwmx9QFYHTNZ', 'Sunday Week 4 Midnight Lunch Small Frying', 4, 'Sunday', 'Midnight Lunch', 'Small Frying', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('3CwQ9o1krbSoYzw3O5Dw', 'Saturday Week 1 Midnight Snack Small Frying', 1, 'Saturday', 'Midnight Snack', 'Small Frying', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('3digtywW83q2CJsIipFB', 'Thursday Week 1 Snack Small', 1, 'Thursday', 'Snack', 'Small', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('3dtb5AWhXrIqgQWqAAkk', 'Sunday Week 3 Snack Small Frying', 3, 'Sunday', 'Snack', 'Small Frying', '2025-05-07 17:28:59', '2025-05-07 17:28:59'),
('3iH1ekofuvF17mpwDeSQ', 'Wednesday Week 3 Midnight Lunch XL', 3, 'Wednesday', 'Midnight Lunch', 'XL', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('3KIn0JExh9svvJcfvVWN', 'Thursday Week 2 Lunch XL', 2, 'Thursday', 'Lunch', 'XL', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('3osbTEjneyeUhcy4rLUR', 'Tuesday Week 1 Dinner XL', 1, 'Tuesday', 'Dinner', 'XL', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('3QVXeReiSLR4hXStWmVH', 'Monday Week 4 Snack Small Frying', 4, 'Monday', 'Snack', 'Small Frying', '2025-05-10 07:48:52', '2025-05-10 07:48:52'),
('3WIBpL7Ldu3OmRbeJjHJ', 'Friday Week 3 Bfast Medium', 3, 'Friday', 'Breakfast', 'Medium', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('42r1tA9qH0W4Cv54TLFC', 'Wednesday Week 1 Midnight Snack Small', 1, 'Wednesday', 'Midnight Snack', 'Small', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('433w41VvAnBrcYJSFMTB', 'Tuesday Week 4 Lunch Small Frying', 4, 'Tuesday', 'Lunch', 'Small Frying', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('44BTatJfCbNeVr1kr3fj', 'Monday Week 4 Snack Medium Frying', 4, 'Monday', 'Snack', 'Medium Frying', '2025-05-10 07:48:52', '2025-05-10 07:48:52'),
('4bPYAXpakuUHHAcqjnKv', 'Saturday Week 1 Midnight Lunch Small Frying', 1, 'Saturday', 'Midnight Lunch', 'Small Frying', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('4CePhg6BrigTSycz39K1', 'Friday Week 1 Midnight Lunch Medium', 1, 'Friday', 'Midnight Lunch', 'Medium', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('4cwNzPGcoT8EOguN9DBM', 'Sunday Week 4 Dinner Small', 4, 'Sunday', 'Dinner', 'Small', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('4fxA5NTriOsVoMjtMWob', 'Monday Week 4 Lunch Small Frying', 4, 'Monday', 'Lunch', 'Small Frying', '2025-05-10 07:48:52', '2025-05-10 07:48:52'),
('4OpsW1BMrxxCG6v3ovrj', 'Friday Week 4 Midnight Lunch XL', 4, 'Friday', 'Midnight Lunch', 'XL', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('4rs6XLrKlpKGDIgk114H', 'Wednesday Week 3 Snack Medium', 3, 'Wednesday', 'Snack', 'Medium', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('4ShEhSC1BTMg1mRMB2BD', 'Monday Week 3 Dinner Large', 3, 'Monday', 'Dinner', 'Large', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('4YDYxTrOWmTU4YuSmtOW', 'Thursday Week 4 Lunch XL', 4, 'Thursday', 'Lunch', 'XL', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('50ZpWhFDmhI2izzPMuDs', 'Monday Week 3 Dinner Small', 3, 'Monday', 'Dinner', 'Small', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('5ACo0gq2NduPdG3OmP2u', 'Monday Week 1 Snack Small', 1, 'Monday', 'Snack', 'Small', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('5cjOskLbu1f8D0NGP1EQ', 'Friday Week 1 Lunch Small Frying', 1, 'Friday', 'Lunch', 'Small Frying', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('5cm4z6C7B0OED85TRbnF', 'Sunday Week 2 Bfast Large', 2, 'Sunday', 'Breakfast', 'Large', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('5gFY2YYPc4Jj7oBE50pp', 'Friday Week 2 Midnight Lunch XL', 2, 'Friday', 'Midnight Lunch', 'XL', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('5gOquur8yS8pUCVp9Ygt', 'Saturday Week 3 Bfast XL', 3, 'Saturday', 'Breakfast', 'XL', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('5GwnpGAgPKoJIbARsruB', 'Saturday Week 3 Midnight Lunch Large', 3, 'Saturday', 'Midnight Lunch', 'Large', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('5N9QKjCOxXsyr0X18CJv', 'Wednesday Week 1 Snack XL', 1, 'Wednesday', 'Snack', 'XL', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('5NHOS1mBpfjaOOJpYxLx', 'Tuesday Week 3 Lunch Medium Frying', 3, 'Tuesday', 'Lunch', 'Medium Frying', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('5NJiTrheXYqTENqJ6CE5', 'Saturday Week 3 Midnight Snack Small', 3, 'Saturday', 'Midnight Snack', 'Small', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('5OzSIdNlXBW5Ld2VzFFC', 'Wednesday Week 3 Midnight Snack Large', 3, 'Wednesday', 'Midnight Snack', 'Large', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('5PVqdI6Js5fSXnI0yIIF', 'Saturday Week 2 Bfast Large', 2, 'Saturday', 'Breakfast', 'Large', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('5TWWK92pLtee7AtDDcUT', 'Tuesday Week 4 Midnight Lunch Large', 4, 'Tuesday', 'Midnight Lunch', 'Large', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('5UTfa6q0vRYePU3FbbqW', 'Tuesday Week 1 Snack Small', 1, 'Tuesday', 'Snack', 'Small', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('5zELpCX74dDdFfMrTOXY', 'Friday Week 4 Midnight Snack Small', 4, 'Friday', 'Midnight Snack', 'Small', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('61TzQievclOskhB4MqXr', 'Sunday Week 1 Dinner Medium Frying', 1, 'Sunday', 'Dinner', 'Medium Frying', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('62bNhYcaB2jSP3DYlAcd', 'Thursday Week 1 Midnight Snack XL', 1, 'Thursday', 'Midnight Snack', 'XL', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('65ABkTtuuMS6vcXRXskz', 'Saturday Week 1 Dinner Medium Frying', 1, 'Saturday', 'Dinner', 'Medium Frying', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('6BKTWwWbr8Twy0GX7BCk', 'Sunday Week 4 Bfast Large', 4, 'Sunday', 'Breakfast', 'Large', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('6CxZDd0CjGUNkDaXP4fI', 'Sunday Week 3 Dinner Small', 3, 'Sunday', 'Dinner', 'Small', '2025-05-07 17:28:59', '2025-05-07 17:28:59'),
('6fv3Q2UjpDE9IpfpZMfN', 'Wednesday Week 1 Midnight Snack Small Frying', 1, 'Wednesday', 'Midnight Snack', 'Small Frying', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('6jOrF3G4y0Xx6SGxtash', 'Saturday Week 3 Snack Medium Frying', 3, 'Saturday', 'Snack', 'Medium Frying', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('6kFqqkNYrSenyiKLwtHa', 'Tuesday Week 2 Lunch Medium Frying', 2, 'Tuesday', 'Lunch', 'Medium Frying', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('6lPiqbXbskmCQEdiHatR', 'Friday Week 1 Lunch Medium', 1, 'Friday', 'Lunch', 'Medium', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('6MZWApjSZ5vx77yenbKh', 'Wednesday Week 2 Snack Small Frying', 2, 'Wednesday', 'Snack', 'Small Frying', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('6NKNeNfRcSDkZw72myJ7', 'Saturday Week 3 Lunch Medium', 3, 'Saturday', 'Lunch', 'Medium', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('6nQFeYpeiddK0fqFgpjW', 'Sunday Week 2 Snack Small Frying', 2, 'Sunday', 'Snack', 'Small Frying', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('6rr69YK3sK1yjx4WIADd', 'Friday Week 1 Dinner XL', 1, 'Friday', 'Dinner', 'XL', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('6rwCHKJXkw9aeHFCLXxz', 'Tuesday Week 3 Dinner Medium Frying', 3, 'Tuesday', 'Dinner', 'Medium Frying', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('6wVzNu4iEDbUNOnlISxU', 'Monday Week 2 Dinner XL', 2, 'Monday', 'Dinner', 'XL', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('6Xiyarsvornrm5SZbMIq', 'Monday Week 3 Lunch Medium', 3, 'Monday', 'Lunch', 'Medium', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('71XT7Y1vaIs6kjm8LZfQ', 'Monday Week 4 Bfast Large', 4, 'Monday', 'Breakfast', 'Large', '2025-05-10 07:48:52', '2025-05-10 07:48:52'),
('78WyNRO9Tdcy8fzegvGj', 'Wednesday Week 4 Dinner Large', 4, 'Wednesday', 'Dinner', 'Large', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('7adRVEjqDYEh7f92C5z4', 'Monday Week 2 Midnight Lunch Small Frying', 2, 'Monday', 'Midnight Lunch', 'Small Frying', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('7Co4xGetEdskTDAO5uix', 'Sunday Week 2 Midnight Snack Large', 2, 'Sunday', 'Midnight Snack', 'Large', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('7dnroBYmfVC1fylBxrxb', 'Tuesday Week 3 Midnight Snack Small Frying', 3, 'Tuesday', 'Midnight Snack', 'Small Frying', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('7e4Ds5A75hA2bZKwG3Xt', 'Saturday Week 4 Lunch Large', 4, 'Saturday', 'Lunch', 'Large', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('7hUtHfqnlcffSqR7aTSw', 'Wednesday Week 3 Midnight Lunch Medium Frying', 3, 'Wednesday', 'Midnight Lunch', 'Medium Frying', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('7IFQZq0KNTTlkrYS2oQg', 'Wednesday Week 2 Midnight Snack Medium', 2, 'Wednesday', 'Midnight Snack', 'Medium', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('7M4sPOGt9tbbyXkDlDLn', 'Sunday Week 2 Midnight Lunch XL', 2, 'Sunday', 'Midnight Lunch', 'XL', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('7M5ZsYCfLxoyO2oNpaVV', 'Tuesday Week 2 Midnight Snack Large', 2, 'Tuesday', 'Midnight Snack', 'Large', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('7qVkPElP5PeEyOuReYW7', 'Thursday Week 2 Bfast Small', 2, 'Thursday', 'Breakfast', 'Small', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('7rgqlbDRq4tHG9BnR173', 'Wednesday Week 1 Bfast Medium Frying', 1, 'Wednesday', 'Breakfast', 'Medium Frying', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('7RhCCik738yh7SCaYBsR', 'Monday Week 2 Lunch Medium Frying', 2, 'Monday', 'Lunch', 'Medium Frying', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('7ruhtllL9YlS2vliMJ7a', 'Monday Week 3 Midnight Snack Small', 3, 'Monday', 'Midnight Snack', 'Small', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('7ssOzWtm2AnIrKQXxrWd', 'Sunday Week 1 Bfast XL', 1, 'Sunday', 'Breakfast', 'XL', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('7ubE2h2AHlRcl3VRYxwV', 'Wednesday Week 4 Dinner Medium Frying', 4, 'Wednesday', 'Dinner', 'Medium Frying', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('7UiB4YoXVbeeJ081EDjv', 'Sunday Week 4 Snack Small Frying', 4, 'Sunday', 'Snack', 'Small Frying', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('80FNyovjTMBMUL6xK9uH', 'Sunday Week 2 Lunch XL', 2, 'Sunday', 'Lunch', 'XL', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('87oBVdJ1wc0tMVFiXOSl', 'Wednesday Week 2 Midnight Snack XL', 2, 'Wednesday', 'Midnight Snack', 'XL', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('88IPIxvOffbeZskxDCiO', 'Saturday Week 4 Dinner Large', 4, 'Saturday', 'Dinner', 'Large', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('8A9bWpwheA79AXoxpNzz', 'Wednesday Week 1 Midnight Snack Medium', 1, 'Wednesday', 'Midnight Snack', 'Medium', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('8bHuu38FJJ3lu4k6wgbP', 'Wednesday Week 4 Snack XL', 4, 'Wednesday', 'Snack', 'XL', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('8CXVOLfZI7zLwnyqpZlW', 'Tuesday Week 4 Snack Medium Frying', 4, 'Tuesday', 'Snack', 'Medium Frying', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('8eIKyupFSgBfhqqzeeFR', 'Sunday Week 2 Dinner Medium', 2, 'Sunday', 'Dinner', 'Medium', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('8GALk2K71oBVr7tUh3Qd', 'Friday Week 3 Midnight Lunch Medium Frying', 3, 'Friday', 'Midnight Lunch', 'Medium Frying', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('8gBaHFSQzSxraak6sQt4', 'Saturday Week 2 Bfast XL', 2, 'Saturday', 'Breakfast', 'XL', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('8Gg7wp4pNmdvcWMabEI5', 'Thursday Week 3 Snack Small Frying', 3, 'Thursday', 'Snack', 'Small Frying', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('8h3TcfIJoR7WSkUPiQWL', 'Thursday Week 3 Midnight Snack Small', 3, 'Thursday', 'Midnight Snack', 'Small', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('8hE5OcFChqiur0JAPn08', 'Thursday Week 2 Midnight Lunch Small Frying', 2, 'Thursday', 'Midnight Lunch', 'Small Frying', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('8i0k6P28FXbIP8MUX2eP', 'Saturday Week 2 Midnight Lunch Large', 2, 'Saturday', 'Midnight Lunch', 'Large', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('8l4WO6o41KLCXPyzO2mw', 'Sunday Week 2 Snack Medium', 2, 'Sunday', 'Snack', 'Medium', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('8mD9FRzObVC3e1fL26wd', 'Friday Week 1 Bfast Medium', 1, 'Friday', 'Breakfast', 'Medium', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('8Pjzqgdb6oEiMdMzuDWS', 'Friday Week 3 Lunch Small', 3, 'Friday', 'Lunch', 'Small', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('8rbneyZUsTmU5p1lcbHY', 'Wednesday Week 1 Snack Small Frying', 1, 'Wednesday', 'Snack', 'Small Frying', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('8u6WYdnR6iiM0vXaZND1', 'Saturday Week 4 Midnight Snack Small Frying', 4, 'Saturday', 'Midnight Snack', 'Small Frying', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('94WjgOugf0PenvE9jrYb', 'Sunday Week 2 Bfast Small Frying', 2, 'Sunday', 'Breakfast', 'Small Frying', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('9GwsLrvv2sfYuPpXKDiU', 'Friday Week 2 Lunch XL', 2, 'Friday', 'Lunch', 'XL', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('9hhCkPzynADnpeeAVpyQ', 'Thursday Week 2 Midnight Snack Medium', 2, 'Thursday', 'Midnight Snack', 'Medium', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('9IiG0xjxFNuoMozcBYij', 'Monday Week 1 Midnight Snack Small', 1, 'Monday', 'Midnight Snack', 'Small', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('9J5tTQPj3Nn6eNDZ07JF', 'Monday Week 3 Dinner Medium', 3, 'Monday', 'Dinner', 'Medium', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('9KzwYj5OOl0XbEVYvvO4', 'Monday Week 1 Midnight Lunch Medium Frying', 1, 'Monday', 'Midnight Lunch', 'Medium Frying', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('9lJzi4gsbW0bmoiXEwFj', 'Thursday Week 3 Lunch Medium', 3, 'Thursday', 'Lunch', 'Medium', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('9Nw1T9x1GleKw9rsbCtK', 'Sunday Week 2 Midnight Snack Medium', 2, 'Sunday', 'Midnight Snack', 'Medium', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('9R0gstcGkiBiqkU3vu4D', 'Monday Week 1 Dinner Large', 1, 'Monday', 'Dinner', 'Large', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('9rfVPU0RRvhHiiGzeznv', 'Tuesday Week 2 Dinner Large', 2, 'Tuesday', 'Dinner', 'Large', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('9SV1WjvHD4O92OWufTdl', 'Sunday Week 1 Snack Small Frying', 1, 'Sunday', 'Snack', 'Small Frying', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('9szZg5uSxVpaJcgD2h7C', 'Tuesday Week 3 Lunch Large', 3, 'Tuesday', 'Lunch', 'Large', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('9wVgq1cqLUjRcww0Nkws', 'Wednesday Week 3 Bfast Small', 3, 'Wednesday', 'Breakfast', 'Small', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('9XZfyulJS2kgxFxVf0hr', 'Wednesday Week 1 Dinner Large', 1, 'Wednesday', 'Dinner', 'Large', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('9zH132md3zwr60AFbleu', 'Saturday Week 2 Bfast Medium', 2, 'Saturday', 'Breakfast', 'Medium', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('A1Xcjrybn9fbZBzam0Ao', 'Sunday Week 4 Midnight Snack Small', 4, 'Sunday', 'Midnight Snack', 'Small', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('a3LtZUQbeYQqh7eoM7US', 'Saturday Week 3 Snack Small', 3, 'Saturday', 'Snack', 'Small', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('A44cgGqR7gijVTaba7KF', 'Saturday Week 2 Dinner Small Frying', 2, 'Saturday', 'Dinner', 'Small Frying', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('a6RnuYuz6YWA9Lb7f4rO', 'Wednesday Week 3 Bfast Small Frying', 3, 'Wednesday', 'Breakfast', 'Small Frying', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('A7JTITJyhUZhcKNq85oV', 'Thursday Week 1 Dinner Small Frying', 1, 'Thursday', 'Dinner', 'Small Frying', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('A9lIHtBpJqCORbLzOfxh', 'Sunday Week 2 Midnight Lunch Medium Frying', 2, 'Sunday', 'Midnight Lunch', 'Medium Frying', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('aaXpkU2HKJQE7TTpV4De', 'Saturday Week 2 Midnight Snack Small Frying', 2, 'Saturday', 'Midnight Snack', 'Small Frying', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('adFjGafRIp2zaf3arclG', 'Tuesday Week 2 Snack XL', 2, 'Tuesday', 'Snack', 'XL', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('aFRuOyGsdaEcSyLP2KsF', 'Thursday Week 4 Dinner Large', 4, 'Thursday', 'Dinner', 'Large', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('aGwqPaOtu6TnfBaXitwc', 'Monday Week 4 Midnight Snack Small Frying', 4, 'Monday', 'Midnight Snack', 'Small Frying', '2025-05-10 07:48:53', '2025-05-10 07:48:53'),
('ahHXv0yzwdcEkzJHE7FH', 'Friday Week 3 Midnight Lunch XL', 3, 'Friday', 'Midnight Lunch', 'XL', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('aHYVF5DPj4bJJ80A2TYH', 'Wednesday Week 4 Midnight Lunch XL', 4, 'Wednesday', 'Midnight Lunch', 'XL', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('aiZkRe4lLjfP5OtviWDz', 'Tuesday Week 2 Midnight Lunch Medium', 2, 'Tuesday', 'Midnight Lunch', 'Medium', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('akCIh9b2vIK4to0wjEnI', 'Saturday Week 4 Midnight Lunch XL', 4, 'Saturday', 'Midnight Lunch', 'XL', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('aljJYa5Bee4eEfvmMAhW', 'Monday Week 2 Snack Medium Frying', 2, 'Monday', 'Snack', 'Medium Frying', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('aM0xbxTRxH8t0Qw1XbZz', 'Monday Week 1 Midnight Snack Medium', 1, 'Monday', 'Midnight Snack', 'Medium', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('am29SAvxXf2EMuteq17d', 'Friday Week 3 Lunch Large', 3, 'Friday', 'Lunch', 'Large', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('amRctjxKovuVaJOFqkPz', 'Friday Week 4 Lunch Large', 4, 'Friday', 'Lunch', 'Large', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('AnHJOTOTlh2zpLQPUSEF', 'Saturday Week 3 Bfast Medium Frying', 3, 'Saturday', 'Breakfast', 'Medium Frying', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('Anxldq3PU5wgMFmAr6vk', 'Saturday Week 2 Lunch Large', 2, 'Saturday', 'Lunch', 'Large', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('aoPW55A5WxmE6PP1K840', 'Thursday Week 3 Bfast Medium Frying', 3, 'Thursday', 'Breakfast', 'Medium Frying', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('APUlGL3fwJsDsVR6S3VK', 'Thursday Week 1 Lunch Medium', 1, 'Thursday', 'Lunch', 'Medium', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('AqJAPYdGhWBXhnfMIVeY', 'Tuesday Week 4 Lunch Medium', 4, 'Tuesday', 'Lunch', 'Medium', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('aRboKzByyJc3ZojqppNi', 'Saturday Week 1 Midnight Lunch Medium', 1, 'Saturday', 'Midnight Lunch', 'Medium', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('As0vG2MrP3SswbUu1rSO', 'Saturday Week 3 Midnight Snack Medium Frying', 3, 'Saturday', 'Midnight Snack', 'Medium Frying', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('aS4rtloKp9EK8dgf6FZi', 'Thursday Week 4 Snack Small', 4, 'Thursday', 'Snack', 'Small', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('AsanMxDEANKzh7CIwaQm', 'Saturday Week 2 Dinner Medium Frying', 2, 'Saturday', 'Dinner', 'Medium Frying', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('ate4BUKZ7JFQBLEoXlmp', 'Friday Week 1 Bfast Small', 1, 'Friday', 'Breakfast', 'Small', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('aU3CFyLMnfv1SJLbdqjA', 'Sunday Week 2 Lunch Medium Frying', 2, 'Sunday', 'Lunch', 'Medium Frying', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('auGjVOJ493dhiZ37tGAa', 'Friday Week 1 Midnight Snack Medium', 1, 'Friday', 'Midnight Snack', 'Medium', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('AWE2vxcqnuXY10mNvdV8', 'Monday Week 4 Bfast Small', 4, 'Monday', 'Breakfast', 'Small', '2025-05-10 07:48:52', '2025-05-10 07:48:52'),
('AWqdwMYKH3gWtZ8Y8xn0', 'Wednesday Week 3 Lunch Medium Frying', 3, 'Wednesday', 'Lunch', 'Medium Frying', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('AX4rMyU7J21AHdQAAGrX', 'Tuesday Week 3 Midnight Lunch Small Frying', 3, 'Tuesday', 'Midnight Lunch', 'Small Frying', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('aYqQyGzihypo1qbMejE2', 'Friday Week 2 Bfast Large', 2, 'Friday', 'Breakfast', 'Large', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('b0m1pfiPJPcyxCqhi7mc', 'Monday Week 2 Midnight Snack Medium', 2, 'Monday', 'Midnight Snack', 'Medium', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('b1ToTKuXeES2rwEzzzza', 'Friday Week 1 Snack XL', 1, 'Friday', 'Snack', 'XL', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('b2Md0WGWXtM3vqmTntUR', 'Thursday Week 1 Bfast Small Frying', 1, 'Thursday', 'Breakfast', 'Small Frying', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('B5rAu90zAfwCNGYPHd0Y', 'Sunday Week 4 Dinner Medium Frying', 4, 'Sunday', 'Dinner', 'Medium Frying', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('Baz7LGdBGVpuVqinDKN0', 'Saturday Week 3 Bfast Small', 3, 'Saturday', 'Breakfast', 'Small', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('BbpcENpq7S7nHUVLJMaM', 'Saturday Week 4 Snack Large', 4, 'Saturday', 'Snack', 'Large', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('bBvP3Lxc9ZPHNEPWwoOc', 'Friday Week 1 Lunch Medium Frying', 1, 'Friday', 'Lunch', 'Medium Frying', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('Bd63MHJrUnPTAgPBarrs', 'Saturday Week 3 Midnight Lunch XL', 3, 'Saturday', 'Midnight Lunch', 'XL', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('BGXC8OGqsf1NoNhw6HF6', 'Saturday Week 2 Dinner XL', 2, 'Saturday', 'Dinner', 'XL', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('BHpu4c4m6eFZyxNsXUez', 'Saturday Week 3 Dinner Small Frying', 3, 'Saturday', 'Dinner', 'Small Frying', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('BHv3Wr2b8iJb0PN5rUmL', 'Saturday Week 2 Snack Large', 2, 'Saturday', 'Snack', 'Large', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('bKoRYhnGGS7ezw8qN7Bg', 'Tuesday Week 1 Snack Small Frying', 1, 'Tuesday', 'Snack', 'Small Frying', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('blF0vfec3Ztu4AHEaoLa', 'Wednesday Week 1 Lunch XL', 1, 'Wednesday', 'Lunch', 'XL', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('blFwbv70mqp50ghTwQxG', 'Monday Week 4 Snack Medium', 4, 'Monday', 'Snack', 'Medium', '2025-05-10 07:48:52', '2025-05-10 07:48:52'),
('BLJbKUXrr7ogvuIzoRLM', 'Monday Week 3 Snack Small Frying', 3, 'Monday', 'Snack', 'Small Frying', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('blOwLfYXtQbBwqbDk9AM', 'Tuesday Week 4 Midnight Lunch Medium Frying', 4, 'Tuesday', 'Midnight Lunch', 'Medium Frying', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('BNvoEl0VDlw8jiekIhNP', 'Monday Week 2 Lunch XL', 2, 'Monday', 'Lunch', 'XL', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('bOKSEKWPRDVvT45j6FYU', 'Sunday Week 4 Snack Medium', 4, 'Sunday', 'Snack', 'Medium', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('Boz3BF3UzE03qTK3PZ2q', 'Tuesday Week 4 Snack XL', 4, 'Tuesday', 'Snack', 'XL', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('BPgFrJh8aBOdcVi7vufN', 'Wednesday Week 1 Midnight Lunch Small', 1, 'Wednesday', 'Midnight Lunch', 'Small', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('BpMAXhD7cToCzSARDRb1', 'Thursday Week 2 Midnight Snack Medium Frying', 2, 'Thursday', 'Midnight Snack', 'Medium Frying', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('BQozoWsCnQOUYzwrzkuj', 'Saturday Week 2 Midnight Lunch XL', 2, 'Saturday', 'Midnight Lunch', 'XL', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('BsTejqB5hsj9UX0ZPziX', 'Friday Week 1 Dinner Medium Frying', 1, 'Friday', 'Dinner', 'Medium Frying', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('butcKYhiJQu8IqDV4kPy', 'Thursday Week 4 Midnight Lunch Small Frying', 4, 'Thursday', 'Midnight Lunch', 'Small Frying', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('BUuDvkbONCbBbl0TksXB', 'Thursday Week 1 Bfast XL', 1, 'Thursday', 'Breakfast', 'XL', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('BUXBDZjoUDI0drwhNqsD', 'Wednesday Week 2 Lunch Medium Frying', 2, 'Wednesday', 'Lunch', 'Medium Frying', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('BvKd6t4iVFPzn1sdvh0L', 'Tuesday Week 1 Midnight Lunch Medium', 1, 'Tuesday', 'Midnight Lunch', 'Medium', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('BVrzfJv1pvDltIHZ5Fjk', 'Monday Week 4 Midnight Lunch Large', 4, 'Monday', 'Midnight Lunch', 'Large', '2025-05-10 07:48:53', '2025-05-10 07:48:53'),
('bxs06RjJ9GTu9JOkGYdw', 'Monday Week 2 Snack Small Frying', 2, 'Monday', 'Snack', 'Small Frying', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('ByfaYiPQOrITf8oVQ6M3', 'Friday Week 3 Midnight Lunch Small Frying', 3, 'Friday', 'Midnight Lunch', 'Small Frying', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('bYGp2I4wN2E5mRBhndL9', 'Saturday Week 3 Bfast Medium', 3, 'Saturday', 'Breakfast', 'Medium', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('BYOuZwIwT9wj1GWq57le', 'Thursday Week 3 Dinner Small Frying', 3, 'Thursday', 'Dinner', 'Small Frying', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('C08BV1wEEo9ljuY0eNw1', 'Friday Week 2 Dinner Large', 2, 'Friday', 'Dinner', 'Large', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('c150CnaO1MKIC1cit8Do', 'Thursday Week 4 Snack Medium Frying', 4, 'Thursday', 'Snack', 'Medium Frying', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('c2FJWnT9qqFpSOZUlLxE', 'Sunday Week 1 Lunch Medium', 1, 'Sunday', 'Lunch', 'Medium', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('c8BHvtkKwCQohlAUo7X0', 'Thursday Week 3 Lunch Small Frying', 3, 'Thursday', 'Lunch', 'Small Frying', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('Ca4PGYa2ODynLSFCPuw6', 'Tuesday Week 2 Bfast Small', 2, 'Tuesday', 'Breakfast', 'Small', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('cd9hpI3s72is8Rw7Fy7A', 'Sunday Week 1 Bfast Medium Frying', 1, 'Sunday', 'Breakfast', 'Medium Frying', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('cDmgNWpv7kM4zYkobinf', 'Saturday Week 1 Lunch Medium Frying', 1, 'Saturday', 'Lunch', 'Medium Frying', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('CedJHwupBHFwUkgF0LZE', 'Wednesday Week 2 Bfast Medium Frying', 2, 'Wednesday', 'Breakfast', 'Medium Frying', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('Cei20PLRQRrhxIJQVnig', 'Monday Week 1 Midnight Lunch Medium', 1, 'Monday', 'Midnight Lunch', 'Medium', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('ChpBlVae2gAkz0rTwfZr', 'Tuesday Week 1 Lunch Small', 1, 'Tuesday', 'Lunch', 'Small', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('cjBJ4m8n7O9fvKJXPAMG', 'Friday Week 2 Snack XL', 2, 'Friday', 'Snack', 'XL', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('CKEa89XDamhsXifOJ7gq', 'Wednesday Week 1 Bfast Small Frying', 1, 'Wednesday', 'Breakfast', 'Small Frying', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('CKZflpPMT3nZ32AxtoNo', 'Friday Week 3 Midnight Lunch Small', 3, 'Friday', 'Midnight Lunch', 'Small', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('clerMbT2D11wJEyIZXtI', 'Monday Week 3 Lunch Small', 3, 'Monday', 'Lunch', 'Small', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('ClwABNrAh2zLkZATuPmF', 'Friday Week 4 Bfast Medium Frying', 4, 'Friday', 'Breakfast', 'Medium Frying', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('Cn5s2WNjhHDdxG8GcJou', 'Sunday Week 2 Dinner Medium Frying', 2, 'Sunday', 'Dinner', 'Medium Frying', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('cnaCELvNoTs1jU3DGuM3', 'Thursday Week 1 Midnight Lunch Large', 1, 'Thursday', 'Midnight Lunch', 'Large', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('CnaUSLgR8VSzMvulTWT4', 'Saturday Week 4 Lunch XL', 4, 'Saturday', 'Lunch', 'XL', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('CNBTKuKjeydHFfWcRyJv', 'Wednesday Week 2 Midnight Lunch Small', 2, 'Wednesday', 'Midnight Lunch', 'Small', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('cnlZjXBRjIX2etNeDTXc', 'Saturday Week 3 Midnight Snack XL', 3, 'Saturday', 'Midnight Snack', 'XL', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('cOLF6lx1DjOIEAKKdbAg', 'Sunday Week 4 Midnight Snack Large', 4, 'Sunday', 'Midnight Snack', 'Large', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('CPYORd3jGSzrLrV3Z573', 'Wednesday Week 4 Midnight Snack Small', 4, 'Wednesday', 'Midnight Snack', 'Small', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('CQ16iiX9WkMgxYjFRhJM', 'Sunday Week 1 Bfast Small Frying', 1, 'Sunday', 'Breakfast', 'Small Frying', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('CqUEI27b8COCcaklO9ws', 'Friday Week 3 Bfast Large', 3, 'Friday', 'Breakfast', 'Large', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('crCjpRoHe8RKL1Mrx54u', 'Tuesday Week 1 Dinner Medium', 1, 'Tuesday', 'Dinner', 'Medium', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('cT6LHAIHUyLgwicEmiKE', 'Thursday Week 3 Midnight Snack Small Frying', 3, 'Thursday', 'Midnight Snack', 'Small Frying', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('CtIXGEsUMaCknILKxDrv', 'Friday Week 2 Midnight Snack Small Frying', 2, 'Friday', 'Midnight Snack', 'Small Frying', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('ctoxiJHd7TXzWkyqWvXJ', 'Tuesday Week 1 Midnight Lunch Large', 1, 'Tuesday', 'Midnight Lunch', 'Large', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('cu5C9MFVLxj7tWnVOLJb', 'Sunday Week 3 Lunch Medium Frying', 3, 'Sunday', 'Lunch', 'Medium Frying', '2025-05-07 17:28:59', '2025-05-07 17:28:59'),
('cVsQZmtMLO74PZt6n3g6', 'Monday Week 1 Lunch Medium Frying', 1, 'Monday', 'Lunch', 'Medium Frying', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('CWCB8SusMAQdtmVyHn7k', 'Monday Week 1 Bfast Small', 1, 'Monday', 'Breakfast', 'Small', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('cz1NQ8Xz4glfx6avWUj7', 'Monday Week 4 Snack XL', 4, 'Monday', 'Snack', 'XL', '2025-05-10 07:48:52', '2025-05-10 07:48:52'),
('czTOHMYoolSz3gl3KUfu', 'Saturday Week 4 Bfast XL', 4, 'Saturday', 'Breakfast', 'XL', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('d0smjad4GPkuh6PEohz3', 'Wednesday Week 3 Lunch Large', 3, 'Wednesday', 'Lunch', 'Large', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('D6qp2HirC1tp49miAWLn', 'Friday Week 3 Dinner Small', 3, 'Friday', 'Dinner', 'Small', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('d8fu0h57AifAvYruux60', 'Sunday Week 2 Midnight Snack Small Frying', 2, 'Sunday', 'Midnight Snack', 'Small Frying', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('D9Hx39kUe0yq4JloArF9', 'Friday Week 2 Snack Small Frying', 2, 'Friday', 'Snack', 'Small Frying', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('Dbn6RR0ikBOzfht5Pv5I', 'Tuesday Week 3 Midnight Lunch Medium', 3, 'Tuesday', 'Midnight Lunch', 'Medium', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('Dcrc9aw61A2ymFpR0afi', 'Saturday Week 2 Snack Small', 2, 'Saturday', 'Snack', 'Small', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('dErnOZud0xIIhtQnJiEu', 'Friday Week 1 Lunch Large', 1, 'Friday', 'Lunch', 'Large', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('DFwPIjLtwPpIqsEhGsVJ', 'Friday Week 1 Midnight Snack XL', 1, 'Friday', 'Midnight Snack', 'XL', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('DFxzKYf6dRvMSuMRm1GS', 'Tuesday Week 1 Midnight Snack Small', 1, 'Tuesday', 'Midnight Snack', 'Small', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('dgBuvREdgO77atkHjZZD', 'Thursday Week 2 Midnight Lunch Large', 2, 'Thursday', 'Midnight Lunch', 'Large', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('dgvm2369GPnC3GFveBvz', 'Monday Week 1 Bfast XL', 1, 'Monday', 'Breakfast', 'XL', '2025-05-05 03:27:02', '2025-05-05 03:27:02'),
('DHvtjJGChL8UO2ljqMXW', 'Friday Week 2 Snack Medium', 2, 'Friday', 'Snack', 'Medium', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('DHYoUtticHaMevc9pJmF', 'Sunday Week 4 Lunch Small Frying', 4, 'Sunday', 'Lunch', 'Small Frying', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('DIOoLm43shG6ACq9VoJJ', 'Saturday Week 1 Bfast Medium', 1, 'Saturday', 'Breakfast', 'Medium', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('dodrJngcqYlJyni4hebo', 'Friday Week 3 Midnight Snack XL', 3, 'Friday', 'Midnight Snack', 'XL', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('dodvJyQec3gVGx2uQvEY', 'Tuesday Week 2 Bfast XL', 2, 'Tuesday', 'Breakfast', 'XL', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('DomS4NKqZOLHD2I8455p', 'Monday Week 3 Lunch Small Frying', 3, 'Monday', 'Lunch', 'Small Frying', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('DPEZDNhv3TXITjY73Nn0', 'Sunday Week 1 Dinner XL', 1, 'Sunday', 'Dinner', 'XL', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('dQRlxBPRVQuhqHBNAXi8', 'Thursday Week 4 Lunch Large', 4, 'Thursday', 'Lunch', 'Large', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('drXXlMWbMkHULiz5bTu2', 'Tuesday Week 3 Snack Small', 3, 'Tuesday', 'Snack', 'Small', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('dTBCWReIMK3TidaQxzHb', 'Tuesday Week 1 Midnight Lunch Medium Frying', 1, 'Tuesday', 'Midnight Lunch', 'Medium Frying', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('duAJirZBDfMKNwroz4KG', 'Saturday Week 1 Lunch Small Frying', 1, 'Saturday', 'Lunch', 'Small Frying', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('DUoG47SouvgAn7ACvmpL', 'Thursday Week 1 Lunch Small', 1, 'Thursday', 'Lunch', 'Small', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('DUXNHtVMWaaE4oTsO3c6', 'Friday Week 4 Midnight Snack Medium', 4, 'Friday', 'Midnight Snack', 'Medium', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('dV7xgXVw9aWqmh8q9rnR', 'Sunday Week 1 Snack Small', 1, 'Sunday', 'Snack', 'Small', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('dvS6WkOKmydaRVRPpTMz', 'Thursday Week 4 Bfast Large', 4, 'Thursday', 'Breakfast', 'Large', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('DWdVnlTT02WCCSd23gqt', 'Thursday Week 4 Midnight Snack Medium', 4, 'Thursday', 'Midnight Snack', 'Medium', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('dx3w5uRam2qgK8SKluae', 'Saturday Week 1 Dinner Small', 1, 'Saturday', 'Dinner', 'Small', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('DXN0Toy9MG0wQ1aZsUNE', 'Saturday Week 2 Midnight Snack Small', 2, 'Saturday', 'Midnight Snack', 'Small', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('dyhiiPwEJVsUd50OwKrY', 'Sunday Week 3 Midnight Snack Large', 3, 'Sunday', 'Midnight Snack', 'Large', '2025-05-07 17:29:00', '2025-05-07 17:29:00'),
('e24gKldTp17xPygYWqWe', 'Wednesday Week 4 Bfast XL', 4, 'Wednesday', 'Breakfast', 'XL', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('E7f5q1NixNMRzN2hLKSR', 'Wednesday Week 2 Dinner XL', 2, 'Wednesday', 'Dinner', 'XL', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('e8AUqbgx2wgeKjlBkUTk', 'Tuesday Week 4 Midnight Snack Large', 4, 'Tuesday', 'Midnight Snack', 'Large', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('E9q7i6nn8RlZPQOd3sOp', 'Friday Week 3 Snack Medium', 3, 'Friday', 'Snack', 'Medium', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('eAMTur6FtvPjMvnlwsjH', 'Thursday Week 4 Midnight Lunch Medium Frying', 4, 'Thursday', 'Midnight Lunch', 'Medium Frying', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('eBeC963N8XHgtXiFvKYT', 'Friday Week 3 Lunch Medium Frying', 3, 'Friday', 'Lunch', 'Medium Frying', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('ecEhSHj2ITvZmIUZsICr', 'Thursday Week 2 Midnight Lunch XL', 2, 'Thursday', 'Midnight Lunch', 'XL', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('EdCnUQasW45TbrnIxeba', 'Saturday Week 2 Midnight Lunch Small', 2, 'Saturday', 'Midnight Lunch', 'Small', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('eDmlfmhAiRVMmW1cJVgL', 'Thursday Week 4 Midnight Snack Small', 4, 'Thursday', 'Midnight Snack', 'Small', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('eDpHzCGeH7LGCrHlMKld', 'Friday Week 1 Snack Small', 1, 'Friday', 'Snack', 'Small', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('EER737qjbhbHIWwKSRUv', 'Sunday Week 2 Bfast Medium', 2, 'Sunday', 'Breakfast', 'Medium', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('eFGmy1EcnK6NOfdZmwFG', 'Wednesday Week 4 Bfast Large', 4, 'Wednesday', 'Breakfast', 'Large', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('eGJmJMai30b8eIXrKwTv', 'Friday Week 1 Lunch XL', 1, 'Friday', 'Lunch', 'XL', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('eJhERILxiipt1gCBooaB', 'Friday Week 4 Lunch XL', 4, 'Friday', 'Lunch', 'XL', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('ejp3qhaSwsf9cmwmUCvC', 'Friday Week 4 Bfast Large', 4, 'Friday', 'Breakfast', 'Large', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('EKcSY7gFcwiXNGYizwOT', 'Wednesday Week 3 Dinner Large', 3, 'Wednesday', 'Dinner', 'Large', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('EkD8W47wYPgn0D2zyu3Y', 'Tuesday Week 4 Dinner Medium Frying', 4, 'Tuesday', 'Dinner', 'Medium Frying', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('EKeLKbTLvYp2YukWnhuz', 'Sunday Week 4 Bfast Medium', 4, 'Sunday', 'Breakfast', 'Medium', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('EKxyVGyg2F50oIeHSc3y', 'Friday Week 1 Bfast Medium Frying', 1, 'Friday', 'Breakfast', 'Medium Frying', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('eM86Zi7SsXyhNUoeBlbE', 'Wednesday Week 4 Bfast Small Frying', 4, 'Wednesday', 'Breakfast', 'Small Frying', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('EmSyVAw17AwOXJUbejnV', 'Friday Week 2 Dinner Medium Frying', 2, 'Friday', 'Dinner', 'Medium Frying', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('EmtQ4l31SehR7paA6qf9', 'Tuesday Week 2 Snack Medium', 2, 'Tuesday', 'Snack', 'Medium', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('EmXylM2XXTJFGkEHoXqv', 'Thursday Week 2 Dinner Small', 2, 'Thursday', 'Dinner', 'Small', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('EngfE4tCRH0igO4g1tYQ', 'Wednesday Week 2 Dinner Medium', 2, 'Wednesday', 'Dinner', 'Medium', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('eo08xwc2ra1LLxqsrgf1', 'Friday Week 3 Midnight Snack Large', 3, 'Friday', 'Midnight Snack', 'Large', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('epUqgSKxlWrtzfnqZuxT', 'Thursday Week 1 Midnight Lunch Medium Frying', 1, 'Thursday', 'Midnight Lunch', 'Medium Frying', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('ErvRHVMaRnLoz3Ew5gPA', 'Sunday Week 4 Dinner Medium', 4, 'Sunday', 'Dinner', 'Medium', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('ESWJPhEWL9EN7xTSLjH0', 'Saturday Week 3 Midnight Lunch Medium Frying', 3, 'Saturday', 'Midnight Lunch', 'Medium Frying', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('eTZfvcIdCQ7p9IbeamAL', 'Saturday Week 1 Midnight Snack Small', 1, 'Saturday', 'Midnight Snack', 'Small', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('eVZEDp2RLozXRPbQ833s', 'Sunday Week 4 Midnight Lunch Medium', 4, 'Sunday', 'Midnight Lunch', 'Medium', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('eX9AjvESnsi1fFLG3I7n', 'Thursday Week 3 Midnight Snack XL', 3, 'Thursday', 'Midnight Snack', 'XL', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('EyK376Y89DZwBbK6IYyo', 'Friday Week 3 Snack Small', 3, 'Friday', 'Snack', 'Small', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('eYwol9eKtT68fOUdi3hC', 'Sunday Week 3 Lunch XL', 3, 'Sunday', 'Lunch', 'XL', '2025-05-07 17:28:59', '2025-05-07 17:28:59'),
('ez5pVOcpUwQ7spoPYEu3', 'Monday Week 2 Lunch Small Frying', 2, 'Monday', 'Lunch', 'Small Frying', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('EzfZ7Hdgg7VlPfWSTXmZ', 'Monday Week 2 Snack XL', 2, 'Monday', 'Snack', 'XL', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('ezgd68vUv8Sy5ErelmHa', 'Monday Week 3 Bfast Large', 3, 'Monday', 'Breakfast', 'Large', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('EzkuPO9uwVOaLoRzL3lw', 'Tuesday Week 4 Lunch Large', 4, 'Tuesday', 'Lunch', 'Large', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('F7MjiiFIpqJQC8FoEBMu', 'Sunday Week 4 Midnight Lunch Large', 4, 'Sunday', 'Midnight Lunch', 'Large', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('FALge2lia1HzbHB5fBQy', 'Saturday Week 3 Dinner Medium Frying', 3, 'Saturday', 'Dinner', 'Medium Frying', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('Faq1Ye1Tf6koi4EBM1JM', 'Tuesday Week 4 Bfast Large', 4, 'Tuesday', 'Breakfast', 'Large', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('fD1vs3TASulIcnoduH95', 'Friday Week 1 Bfast XL', 1, 'Friday', 'Breakfast', 'XL', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('fDUezRMAxuq6NVVK9Lkh', 'Tuesday Week 4 Snack Medium', 4, 'Tuesday', 'Snack', 'Medium', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('Fedg0KALjvApsuJ6x1cG', 'Thursday Week 3 Snack Large', 3, 'Thursday', 'Snack', 'Large', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('fi1KFSbrXq4tXIGToLyM', 'Saturday Week 1 Lunch XL', 1, 'Saturday', 'Lunch', 'XL', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('fJHSgaK4GVVzG9SRv0FS', 'Tuesday Week 1 Midnight Snack XL', 1, 'Tuesday', 'Midnight Snack', 'XL', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('FKrXmiIRjjuW6Xd5DZ8L', 'Tuesday Week 1 Dinner Medium Frying', 1, 'Tuesday', 'Dinner', 'Medium Frying', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('FkX4aggadLWJDqIjo2Uy', 'Saturday Week 1 Midnight Lunch Small', 1, 'Saturday', 'Midnight Lunch', 'Small', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('fnyN64v5AIaXL3kdvTX8', 'Saturday Week 3 Midnight Lunch Small', 3, 'Saturday', 'Midnight Lunch', 'Small', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('FOUWyPHGkcHVTzMiOZsF', 'Sunday Week 4 Lunch XL', 4, 'Sunday', 'Lunch', 'XL', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('Fq3WupK6wfRWNomaNHsd', 'Sunday Week 3 Snack Large', 3, 'Sunday', 'Snack', 'Large', '2025-05-07 17:28:59', '2025-05-07 17:28:59'),
('fSAOwyn7W9SnaydGnrqi', 'Thursday Week 1 Midnight Snack Medium Frying', 1, 'Thursday', 'Midnight Snack', 'Medium Frying', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('fssaspEsWjSe0iKPfetY', 'Wednesday Week 3 Snack Small', 3, 'Wednesday', 'Snack', 'Small', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('ftxloXbFW1bgj5h4uCIO', 'Wednesday Week 3 Lunch Small', 3, 'Wednesday', 'Lunch', 'Small', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('Fv6YWY0FPAXPqQgjgan6', 'Sunday Week 3 Bfast Medium', 3, 'Sunday', 'Breakfast', 'Medium', '2025-05-07 17:28:59', '2025-05-07 17:28:59'),
('fwy0nczdnbPHTRK28OcS', 'Saturday Week 1 Bfast XL', 1, 'Saturday', 'Breakfast', 'XL', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('fxoyE034O5HxLZRYy4UM', 'Monday Week 2 Dinner Large', 2, 'Monday', 'Dinner', 'Large', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('fXuyx9rPhS8YyPze7Ilv', 'Monday Week 3 Dinner Small Frying', 3, 'Monday', 'Dinner', 'Small Frying', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('FYDgLnHq86ZkNkeySMDQ', 'Thursday Week 3 Dinner Large', 3, 'Thursday', 'Dinner', 'Large', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('FZD8NRUQ7vNYghbJIdGt', 'Monday Week 2 Bfast Small', 2, 'Monday', 'Breakfast', 'Small', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('FZS8xa41VTiUI5GIogMK', 'Monday Week 3 Snack XL', 3, 'Monday', 'Snack', 'XL', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('fZwWlRKBnDtCPBCjSYaj', 'Saturday Week 3 Bfast Small Frying', 3, 'Saturday', 'Breakfast', 'Small Frying', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('g8wbCLLSnJ3YKEzOhlzO', 'Thursday Week 3 Bfast Small Frying', 3, 'Thursday', 'Breakfast', 'Small Frying', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('G90gTzooWUHIChAFLddc', 'Saturday Week 1 Bfast Large', 1, 'Saturday', 'Breakfast', 'Large', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('G9ok3UOPRuc0pXZmEUek', 'Sunday Week 1 Midnight Lunch Medium Frying', 1, 'Sunday', 'Midnight Lunch', 'Medium Frying', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('Gb1GXzPPCcmN8qc34ZDc', 'Tuesday Week 3 Dinner Large', 3, 'Tuesday', 'Dinner', 'Large', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('gbDvBaLhH1V9F5Cfox6P', 'Tuesday Week 4 Bfast Medium', 4, 'Tuesday', 'Breakfast', 'Medium', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('GBjUUtc1u2xOwOqpLDTu', 'Monday Week 3 Snack Medium Frying', 3, 'Monday', 'Snack', 'Medium Frying', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('getlPzQaSD9dgvXEegzI', 'Saturday Week 1 Bfast Small', 1, 'Saturday', 'Breakfast', 'Small', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('GFbyJGpoHuUvJoCIplyE', 'Tuesday Week 1 Snack Medium', 1, 'Tuesday', 'Snack', 'Medium', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('gFRfKNjtTFTrgBocJOqu', 'Monday Week 1 Lunch XL', 1, 'Monday', 'Lunch', 'XL', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('Ghmim1uH2q4ZV6u4VLHh', 'Wednesday Week 4 Lunch Medium', 4, 'Wednesday', 'Lunch', 'Medium', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('giwJFErynQociRacFnNt', 'Saturday Week 1 Snack Small Frying', 1, 'Saturday', 'Snack', 'Small Frying', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('Gjlo9Qx1qYESuRjDY5wU', 'Tuesday Week 2 Dinner Medium', 2, 'Tuesday', 'Dinner', 'Medium', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('gK6LymxuDAdRTlyQdCaD', 'Saturday Week 4 Lunch Medium', 4, 'Saturday', 'Lunch', 'Medium', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('GmF2Ax3SJyyCY6F9JwYo', 'Wednesday Week 3 Midnight Snack Small', 3, 'Wednesday', 'Midnight Snack', 'Small', '2025-05-07 17:29:30', '2025-05-07 17:29:30');
INSERT INTO `menus` (`id`, `menu_name`, `menu_week`, `menu_day`, `meal_type`, `menu_size`, `created_at`, `updated_at`) VALUES
('gMiL0iosO3uhsXILsDs6', 'Sunday Week 3 Midnight Lunch Medium Frying', 3, 'Sunday', 'Midnight Lunch', 'Medium Frying', '2025-05-07 17:29:00', '2025-05-07 17:29:00'),
('GmSGdUWam9JWc5zVGcgS', 'Sunday Week 3 Snack Small', 3, 'Sunday', 'Snack', 'Small', '2025-05-07 17:28:59', '2025-05-07 17:28:59'),
('GPnjATkCLP4yMZgZ65tR', 'Wednesday Week 2 Midnight Lunch XL', 2, 'Wednesday', 'Midnight Lunch', 'XL', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('GQJTfsyOi2cVRHGMELUl', 'Monday Week 2 Bfast Large', 2, 'Monday', 'Breakfast', 'Large', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('GqUqRInw5rKszXsQ9RuL', 'Tuesday Week 2 Snack Small', 2, 'Tuesday', 'Snack', 'Small', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('GrXcQvG3YcfQsLzwF0sn', 'Sunday Week 4 Dinner Large', 4, 'Sunday', 'Dinner', 'Large', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('gSCrwsfDaWBandXi7b19', 'Tuesday Week 4 Dinner Small', 4, 'Tuesday', 'Dinner', 'Small', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('gSeMTE3m5z2qkg5kMv9b', 'Thursday Week 2 Bfast Large', 2, 'Thursday', 'Breakfast', 'Large', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('gtGGZCznp9d0C3zW8fYk', 'Friday Week 2 Lunch Small Frying', 2, 'Friday', 'Lunch', 'Small Frying', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('gtr9tK8L2razNvIiH0Ml', 'Sunday Week 3 Midnight Snack XL', 3, 'Sunday', 'Midnight Snack', 'XL', '2025-05-07 17:29:00', '2025-05-07 17:29:00'),
('GvbT01WdoHT9yDWYPnkX', 'Sunday Week 2 Lunch Small', 2, 'Sunday', 'Lunch', 'Small', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('Gx7k12PCQZCj8vMQqAYz', 'Tuesday Week 4 Midnight Lunch Small Frying', 4, 'Tuesday', 'Midnight Lunch', 'Small Frying', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('GxgYEjyL0MBbuebb5sGd', 'Saturday Week 1 Dinner Large', 1, 'Saturday', 'Dinner', 'Large', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('gXr9nVq0UM6QBJuvfTR6', 'Friday Week 3 Midnight Snack Small', 3, 'Friday', 'Midnight Snack', 'Small', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('GyEff7welQ8fgyLLiJOB', 'Saturday Week 1 Midnight Snack XL', 1, 'Saturday', 'Midnight Snack', 'XL', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('GyuuujL2Lfchv7T1QXGl', 'Friday Week 1 Snack Large', 1, 'Friday', 'Snack', 'Large', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('gz6aEscr5rCj0ny4ir8J', 'Tuesday Week 2 Dinner Small Frying', 2, 'Tuesday', 'Dinner', 'Small Frying', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('gZGzXOluYG25rUUK2OXo', 'Saturday Week 3 Midnight Snack Large', 3, 'Saturday', 'Midnight Snack', 'Large', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('GzO38rbwZ9cRQbep5c5n', 'Wednesday Week 4 Dinner Small', 4, 'Wednesday', 'Dinner', 'Small', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('gzPK00rdcH6f0ci1vfhW', 'Friday Week 3 Dinner XL', 3, 'Friday', 'Dinner', 'XL', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('h0xEt7vAiMayn4m0DLmf', 'Monday Week 2 Lunch Large', 2, 'Monday', 'Lunch', 'Large', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('h47ZoKSk8wPB0tcshu9H', 'Wednesday Week 3 Midnight Lunch Small', 3, 'Wednesday', 'Midnight Lunch', 'Small', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('h5NLAkSik1aWTFkWYsK2', 'Saturday Week 4 Lunch Small', 4, 'Saturday', 'Lunch', 'Small', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('H6f25s7FzQ9ZHUjmfaiv', 'Saturday Week 1 Dinner XL', 1, 'Saturday', 'Dinner', 'XL', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('H7kaSZjfVVlYt0r9d1VK', 'Thursday Week 1 Midnight Lunch Small', 1, 'Thursday', 'Midnight Lunch', 'Small', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('H8d0KpkoCx6YsnT8zMaz', 'Monday Week 3 Bfast Medium Frying', 3, 'Monday', 'Breakfast', 'Medium Frying', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('hcxUo3avlA13tpmmzwR5', 'Thursday Week 4 Dinner Small', 4, 'Thursday', 'Dinner', 'Small', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('hdBsWhl7SBcKufoJMM52', 'Tuesday Week 1 Midnight Lunch Small', 1, 'Tuesday', 'Midnight Lunch', 'Small', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('hDjL4lYCSMvUDaEPPsAW', 'Saturday Week 2 Midnight Lunch Medium', 2, 'Saturday', 'Midnight Lunch', 'Medium', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('HFLppdzyfpUEvxKr5SSm', 'Thursday Week 1 Midnight Snack Small Frying', 1, 'Thursday', 'Midnight Snack', 'Small Frying', '2025-05-07 08:02:09', '2025-05-07 08:02:09'),
('HGGqtOtYVoiaNIYEfatF', 'Friday Week 4 Dinner Large', 4, 'Friday', 'Dinner', 'Large', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('HHxI2dLnBg8DrVmpLWHC', 'Tuesday Week 2 Midnight Snack Small Frying', 2, 'Tuesday', 'Midnight Snack', 'Small Frying', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('HiXa3eDHmvfFpAHEzq0E', 'Tuesday Week 3 Bfast Medium', 3, 'Tuesday', 'Breakfast', 'Medium', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('hlgkbMT8HoMFsFtI3oBC', 'Monday Week 2 Bfast Small Frying', 2, 'Monday', 'Breakfast', 'Small Frying', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('hLvHfh4PC7a0H9LbonAP', 'Sunday Week 3 Lunch Small', 3, 'Sunday', 'Lunch', 'Small', '2025-05-07 17:28:59', '2025-05-07 17:28:59'),
('htEd1FCZe03rpwgtzfoM', 'Thursday Week 2 Snack Medium Frying', 2, 'Thursday', 'Snack', 'Medium Frying', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('HtrlMG5BfDGKovH3MLmw', 'Saturday Week 1 Bfast Medium Frying', 1, 'Saturday', 'Breakfast', 'Medium Frying', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('HWSxj2LbdHALj5L7cr51', 'Saturday Week 4 Midnight Lunch Medium Frying', 4, 'Saturday', 'Midnight Lunch', 'Medium Frying', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('HXjoXGRx710kTPjHlUtI', 'Wednesday Week 1 Dinner Small Frying', 1, 'Wednesday', 'Dinner', 'Small Frying', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('HXVvqSaBkKNTosEs8XzF', 'Wednesday Week 3 Bfast Medium Frying', 3, 'Wednesday', 'Breakfast', 'Medium Frying', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('hy8ft4b55piynEKsTrFh', 'Friday Week 2 Lunch Medium Frying', 2, 'Friday', 'Lunch', 'Medium Frying', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('hy8oIKFewSjr8KXeWd2W', 'Friday Week 2 Lunch Medium', 2, 'Friday', 'Lunch', 'Medium', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('hyJCtEFASqvrTe0ieirb', 'Tuesday Week 3 Midnight Lunch Medium Frying', 3, 'Tuesday', 'Midnight Lunch', 'Medium Frying', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('hYt8GR8kvmpPFRfKvkQi', 'Sunday Week 2 Dinner XL', 2, 'Sunday', 'Dinner', 'XL', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('Hz6WlDlSmVss8jkRngRW', 'Monday Week 4 Midnight Lunch Medium', 4, 'Monday', 'Midnight Lunch', 'Medium', '2025-05-10 07:48:53', '2025-05-10 07:48:53'),
('hzFJ1ZjVR0FJFwGVOTvq', 'Monday Week 2 Lunch Medium', 2, 'Monday', 'Lunch', 'Medium', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('I1HiHKtXLWvf3vBiz3z9', 'Sunday Week 1 Midnight Lunch Medium', 1, 'Sunday', 'Midnight Lunch', 'Medium', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('I1nAJftmPFktNkmp8Z9D', 'Sunday Week 3 Lunch Small Frying', 3, 'Sunday', 'Lunch', 'Small Frying', '2025-05-07 17:28:59', '2025-05-07 17:28:59'),
('I2RSFtHKlIrAgE1tKpMc', 'Saturday Week 4 Snack Small', 4, 'Saturday', 'Snack', 'Small', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('i5LZ3VNGz82Jxm3UvBIE', 'Saturday Week 2 Midnight Lunch Small Frying', 2, 'Saturday', 'Midnight Lunch', 'Small Frying', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('i5oQ1w4un69zzN8GGImB', 'Tuesday Week 1 Midnight Snack Medium Frying', 1, 'Tuesday', 'Midnight Snack', 'Medium Frying', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('I6I0WrHZKPSTDHG1tCDb', 'Saturday Week 2 Snack Medium Frying', 2, 'Saturday', 'Snack', 'Medium Frying', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('iBlmOomCfg3u7xsXw0MK', 'Wednesday Week 1 Lunch Small', 1, 'Wednesday', 'Lunch', 'Small', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('iCEG5dLOlGzAMmViNpQW', 'Monday Week 4 Midnight Snack XL', 4, 'Monday', 'Midnight Snack', 'XL', '2025-05-10 07:48:53', '2025-05-10 07:48:53'),
('icSnJcMc10th3ujBmVKb', 'Thursday Week 4 Bfast Small Frying', 4, 'Thursday', 'Breakfast', 'Small Frying', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('IE5xsvGsVaE2foxyDqA1', 'Monday Week 3 Midnight Snack Medium Frying', 3, 'Monday', 'Midnight Snack', 'Medium Frying', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('ieFRFM8AkGJkT5A9ixfH', 'Sunday Week 2 Dinner Small', 2, 'Sunday', 'Dinner', 'Small', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('igNiRkwC719OUPyafKYv', 'Tuesday Week 3 Midnight Snack Medium', 3, 'Tuesday', 'Midnight Snack', 'Medium', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('IhGTbcuuOOvUSD5ub5OL', 'Saturday Week 2 Dinner Small', 2, 'Saturday', 'Dinner', 'Small', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('IJrQ2pSO1J2G8J7NuIHF', 'Monday Week 4 Dinner XL', 4, 'Monday', 'Dinner', 'XL', '2025-05-10 07:48:52', '2025-05-10 07:48:52'),
('iJweNW5cGGnyIgV3Ruan', 'Wednesday Week 4 Midnight Lunch Medium Frying', 4, 'Wednesday', 'Midnight Lunch', 'Medium Frying', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('IkPUoRXOpp3ebgkhjNno', 'Friday Week 3 Midnight Lunch Large', 3, 'Friday', 'Midnight Lunch', 'Large', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('iKulUSMgx8N3BZXl1IiN', 'Monday Week 3 Midnight Snack Medium', 3, 'Monday', 'Midnight Snack', 'Medium', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('iLsRLeaxLl3SZbfWVEjH', 'Wednesday Week 1 Snack Large', 1, 'Wednesday', 'Snack', 'Large', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('im28Z19uX4HVGhCyOwDW', 'Wednesday Week 4 Snack Medium Frying', 4, 'Wednesday', 'Snack', 'Medium Frying', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('ImAUgysqQ6QwcUIz8w3S', 'Friday Week 2 Midnight Lunch Large', 2, 'Friday', 'Midnight Lunch', 'Large', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('IOPxXyTGSJtknNoNEPT1', 'Friday Week 1 Dinner Large', 1, 'Friday', 'Dinner', 'Large', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('iPZ0nt508E9A84Co8ckD', 'Monday Week 4 Lunch Small', 4, 'Monday', 'Lunch', 'Small', '2025-05-10 07:48:52', '2025-05-10 07:48:52'),
('IrvatQxb2a7b9WQBYfzD', 'Monday Week 2 Midnight Lunch Small', 2, 'Monday', 'Midnight Lunch', 'Small', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('ISk7pKSSOhBJQrNRnm4q', 'Tuesday Week 4 Bfast Medium Frying', 4, 'Tuesday', 'Breakfast', 'Medium Frying', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('it7n17fmLCgj9wQ4qceC', 'Saturday Week 3 Dinner Medium', 3, 'Saturday', 'Dinner', 'Medium', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('iU4J3kj1v7WySZfua1mb', 'Tuesday Week 4 Bfast Small', 4, 'Tuesday', 'Breakfast', 'Small', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('IuhUHhYvzZPZ9RBBrQg4', 'Friday Week 3 Snack Medium Frying', 3, 'Friday', 'Snack', 'Medium Frying', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('iX08zSvk0WuFflyIBdKq', 'Saturday Week 4 Bfast Small', 4, 'Saturday', 'Breakfast', 'Small', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('IXBWqcfffRXS3c7nWp7L', 'Wednesday Week 3 Midnight Lunch Large', 3, 'Wednesday', 'Midnight Lunch', 'Large', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('Ixq5GKch6JEsWQrks4AT', 'Monday Week 4 Lunch Medium', 4, 'Monday', 'Lunch', 'Medium', '2025-05-10 07:48:52', '2025-05-10 07:48:52'),
('iY4ZbfBgZ0xHxGg8TQ4M', 'Wednesday Week 4 Midnight Snack Small Frying', 4, 'Wednesday', 'Midnight Snack', 'Small Frying', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('iYqp30ARkjoaTxtX4tsV', 'Thursday Week 1 Lunch XL', 1, 'Thursday', 'Lunch', 'XL', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('J3XloQmphW45rDzAdV7f', 'Monday Week 4 Dinner Small', 4, 'Monday', 'Dinner', 'Small', '2025-05-10 07:48:53', '2025-05-10 07:48:53'),
('J4XQJIKbxdx4pvSW0AD7', 'Wednesday Week 4 Bfast Medium Frying', 4, 'Wednesday', 'Breakfast', 'Medium Frying', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('J65DWj6egBpBdPkkiYEM', 'Thursday Week 4 Midnight Snack Medium Frying', 4, 'Thursday', 'Midnight Snack', 'Medium Frying', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('j6GLakZQcKLNK3U6stNu', 'Monday Week 2 Midnight Snack Large', 2, 'Monday', 'Midnight Snack', 'Large', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('J8wfRRcbSoeBrJUWwJgJ', 'Tuesday Week 2 Lunch XL', 2, 'Tuesday', 'Lunch', 'XL', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('JCSET3K07TdXjDMefE0d', 'Thursday Week 2 Dinner Medium Frying', 2, 'Thursday', 'Dinner', 'Medium Frying', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('je7F8zhfTdKpHt3XL3H2', 'Friday Week 2 Dinner Small', 2, 'Friday', 'Dinner', 'Small', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('Jh4XDysQiRzZTFYER9m0', 'Saturday Week 4 Dinner Small', 4, 'Saturday', 'Dinner', 'Small', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('JHuXGsLSscZeh8oSnM2M', 'Tuesday Week 2 Dinner XL', 2, 'Tuesday', 'Dinner', 'XL', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('JinxuOQA6VffekfVQ0hX', 'Sunday Week 4 Midnight Snack XL', 4, 'Sunday', 'Midnight Snack', 'XL', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('jLPCzOEnXYOSPlc4KFef', 'Tuesday Week 3 Dinner Small', 3, 'Tuesday', 'Dinner', 'Small', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('JMi6XHZWafCKZl81hr6T', 'Sunday Week 2 Lunch Medium', 2, 'Sunday', 'Lunch', 'Medium', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('JOodb2wozWR6nZblQ2Dv', 'Tuesday Week 1 Bfast XL', 1, 'Tuesday', 'Breakfast', 'XL', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('jOT5psDtj3Gt9eWhsyvv', 'Thursday Week 2 Snack Small', 2, 'Thursday', 'Snack', 'Small', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('JoVYhGkhMEJ1D6ecdqg8', 'Wednesday Week 1 Bfast XL', 1, 'Wednesday', 'Breakfast', 'XL', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('jQ6dxFZpdYTlglbDuIzK', 'Thursday Week 4 Dinner Medium', 4, 'Thursday', 'Dinner', 'Medium', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('jQXNS66wZCy82q7ViLzd', 'Saturday Week 3 Dinner Large', 3, 'Saturday', 'Dinner', 'Large', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('jseZHo8YQgeDwnQ7PBKz', 'Saturday Week 4 Snack Medium Frying', 4, 'Saturday', 'Snack', 'Medium Frying', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('JsleygZdgmAmOasbM5fM', 'Tuesday Week 4 Midnight Snack Small', 4, 'Tuesday', 'Midnight Snack', 'Small', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('jStEH6KRDVBTNOvgnNjd', 'Thursday Week 1 Midnight Snack Small', 1, 'Thursday', 'Midnight Snack', 'Small', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('jTb9jbjTgd0Nk8tBzxVk', 'Friday Week 4 Lunch Medium', 4, 'Friday', 'Lunch', 'Medium', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('jTNAI58kc0HsV851mLLT', 'Thursday Week 2 Midnight Snack Small', 2, 'Thursday', 'Midnight Snack', 'Small', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('jUkF1lJfcix6cZ1YLctk', 'Tuesday Week 4 Snack Small', 4, 'Tuesday', 'Snack', 'Small', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('jUpVStnF6jUfkD4oulim', 'Tuesday Week 3 Bfast XL', 3, 'Tuesday', 'Breakfast', 'XL', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('jv5hRrExEO3oM4LjCm7r', 'Friday Week 1 Dinner Small Frying', 1, 'Friday', 'Dinner', 'Small Frying', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('JwqgsDzz3NVBh7Em0Xmm', 'Sunday Week 3 Midnight Lunch XL', 3, 'Sunday', 'Midnight Lunch', 'XL', '2025-05-07 17:29:00', '2025-05-07 17:29:00'),
('JWTInpcdnrjRifulf4mZ', 'Thursday Week 1 Lunch Small Frying', 1, 'Thursday', 'Lunch', 'Small Frying', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('JX7XcfteyQGL2mrDdJTt', 'Tuesday Week 2 Midnight Snack Small', 2, 'Tuesday', 'Midnight Snack', 'Small', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('JxRxEyxKPbddl1LOTBpS', 'Thursday Week 3 Midnight Snack Medium', 3, 'Thursday', 'Midnight Snack', 'Medium', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('jXvOZkatyhQl3h9DalwW', 'Sunday Week 4 Midnight Snack Medium Frying', 4, 'Sunday', 'Midnight Snack', 'Medium Frying', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('jyKtEuf40MQ81eRR7Wa9', 'Saturday Week 1 Midnight Snack Medium', 1, 'Saturday', 'Midnight Snack', 'Medium', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('jZSpHfNOhGMhZqRJD8Mm', 'Saturday Week 4 Bfast Small Frying', 4, 'Saturday', 'Breakfast', 'Small Frying', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('k0rcMUqkydDIxlo6NNpd', 'Saturday Week 2 Bfast Small', 2, 'Saturday', 'Breakfast', 'Small', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('K2lanekY87pXvyQUl8RZ', 'Tuesday Week 3 Dinner Medium', 3, 'Tuesday', 'Dinner', 'Medium', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('K3OmFe4ycCyuVs2RUCW6', 'Sunday Week 3 Snack XL', 3, 'Sunday', 'Snack', 'XL', '2025-05-07 17:28:59', '2025-05-07 17:28:59'),
('K862EeygxX4Tf2TY5AXQ', 'Thursday Week 3 Dinner Medium Frying', 3, 'Thursday', 'Dinner', 'Medium Frying', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('k8GHUPIiX3wbydhaATTo', 'Monday Week 2 Dinner Medium Frying', 2, 'Monday', 'Dinner', 'Medium Frying', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('k9dVHShnsKj7SKWlmt0r', 'Tuesday Week 1 Bfast Medium', 1, 'Tuesday', 'Breakfast', 'Medium', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('kbcE6cTMzfJImknSEZDT', 'Sunday Week 1 Lunch Large', 1, 'Sunday', 'Lunch', 'Large', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('KbeQuhzsM07h8RvM5xGU', 'Friday Week 1 Midnight Lunch Large', 1, 'Friday', 'Midnight Lunch', 'Large', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('KCIz0N8pxwiz975jWdzH', 'Thursday Week 3 Lunch XL', 3, 'Thursday', 'Lunch', 'XL', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('KDBlbOWNQjwa8629RXfD', 'Tuesday Week 2 Lunch Large', 2, 'Tuesday', 'Lunch', 'Large', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('KE6iM0g6MnPl7wqYSl6Y', 'Wednesday Week 3 Midnight Lunch Medium', 3, 'Wednesday', 'Midnight Lunch', 'Medium', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('KgR6Kk1tDwv9cXtHo7TT', 'Thursday Week 4 Dinner XL', 4, 'Thursday', 'Dinner', 'XL', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('ki7eRForoWHAOW2aryx6', 'Tuesday Week 4 Dinner Medium', 4, 'Tuesday', 'Dinner', 'Medium', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('KJdBjBw1m8JcEQ46h0kd', 'Thursday Week 1 Snack Large', 1, 'Thursday', 'Snack', 'Large', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('kKhuhveeG85nqOKCtDMZ', 'Monday Week 1 Midnight Snack Medium Frying', 1, 'Monday', 'Midnight Snack', 'Medium Frying', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('Kkiu7t358q8ggIMYxWdm', 'Friday Week 2 Lunch Small', 2, 'Friday', 'Lunch', 'Small', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('KlTW7X0SxShITNDZAzLe', 'Sunday Week 1 Snack Large', 1, 'Sunday', 'Snack', 'Large', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('kM1afXskehBLorv32Ox2', 'Monday Week 2 Midnight Lunch XL', 2, 'Monday', 'Midnight Lunch', 'XL', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('KN28nzqPZCuorBDWxXys', 'Sunday Week 4 Snack XL', 4, 'Sunday', 'Snack', 'XL', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('KO1nBMCJtRIfyEZZ45iF', 'Sunday Week 1 Lunch Small', 1, 'Sunday', 'Lunch', 'Small', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('KoQPrYAel4cIjafuVsGo', 'Friday Week 1 Snack Medium', 1, 'Friday', 'Snack', 'Medium', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('KpMz1H1YIKDkSHzgVdmx', 'Sunday Week 1 Lunch Small Frying', 1, 'Sunday', 'Lunch', 'Small Frying', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('kqkVPbCimFvLIBnd86lB', 'Friday Week 4 Midnight Snack Medium Frying', 4, 'Friday', 'Midnight Snack', 'Medium Frying', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('kQrtKlBRi486RKLCj2uL', 'Saturday Week 3 Midnight Lunch Medium', 3, 'Saturday', 'Midnight Lunch', 'Medium', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('Kqz3LUVOpl8if0l5wqJx', 'Thursday Week 3 Lunch Small', 3, 'Thursday', 'Lunch', 'Small', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('krU946wjCjWvkfGmCQs9', 'Monday Week 1 Dinner XL', 1, 'Monday', 'Dinner', 'XL', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('kU3LdBC6PZkjSbTxLQbp', 'Thursday Week 3 Dinner XL', 3, 'Thursday', 'Dinner', 'XL', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('kvme3ArP3M3xJEuG3DVg', 'Friday Week 3 Lunch XL', 3, 'Friday', 'Lunch', 'XL', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('KVNXdJPONpTRLgLOTyH5', 'Tuesday Week 2 Bfast Large', 2, 'Tuesday', 'Breakfast', 'Large', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('kWyQRI6cCXSjLMWlRLDl', 'Tuesday Week 1 Dinner Small Frying', 1, 'Tuesday', 'Dinner', 'Small Frying', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('KXS5G0EEg7PYw3grYcG4', 'Saturday Week 1 Midnight Lunch Large', 1, 'Saturday', 'Midnight Lunch', 'Large', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('L067sb6fB97nVYWyRzUg', 'Sunday Week 2 Bfast Small', 2, 'Sunday', 'Breakfast', 'Small', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('l5F8P6DnHpPuGJf2khGU', 'Wednesday Week 1 Bfast Small', 1, 'Wednesday', 'Breakfast', 'Small', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('L652Bgrq6l9nqbikk16P', 'Sunday Week 1 Snack XL', 1, 'Sunday', 'Snack', 'XL', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('l968MlkZ70pb9QuFdl1H', 'Thursday Week 1 Midnight Lunch XL', 1, 'Thursday', 'Midnight Lunch', 'XL', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('LAdC65XGNqAa3eOiNiY3', 'Wednesday Week 3 Bfast Medium', 3, 'Wednesday', 'Breakfast', 'Medium', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('lbNJ2o8xzNoUJsFUrGxe', 'Sunday Week 1 Dinner Large', 1, 'Sunday', 'Dinner', 'Large', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('lC0m1KWoAbZhMy95YDyu', 'Sunday Week 1 Midnight Lunch Large', 1, 'Sunday', 'Midnight Lunch', 'Large', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('LcLGChHIgrzkOlrj1obT', 'Sunday Week 4 Bfast Medium Frying', 4, 'Sunday', 'Breakfast', 'Medium Frying', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('LD0IP8DYssa6CC6fReHQ', 'Tuesday Week 1 Midnight Snack Large', 1, 'Tuesday', 'Midnight Snack', 'Large', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('LepowSbfYHddFQMtsenY', 'Thursday Week 2 Lunch Large', 2, 'Thursday', 'Lunch', 'Large', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('lGAN3tBvlxUz4v6n7Svd', 'Wednesday Week 2 Midnight Snack Large', 2, 'Wednesday', 'Midnight Snack', 'Large', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('LgCgXG41E98pEMRibrGu', 'Tuesday Week 3 Lunch Small Frying', 3, 'Tuesday', 'Lunch', 'Small Frying', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('LgcPKN6XCI6pvkmjdvh3', 'Wednesday Week 4 Snack Large', 4, 'Wednesday', 'Snack', 'Large', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('lgFbXgMsGh8zZdY48vk7', 'Friday Week 1 Dinner Small', 1, 'Friday', 'Dinner', 'Small', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('lIVnVTOCirhNjq9T6Dkx', 'Thursday Week 1 Midnight Lunch Medium', 1, 'Thursday', 'Midnight Lunch', 'Medium', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('ljdavOrYOwZl8i4Pu5Me', 'Tuesday Week 2 Snack Medium Frying', 2, 'Tuesday', 'Snack', 'Medium Frying', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('ljYXxSQfCW1BPTp9myBg', 'Friday Week 2 Bfast Small Frying', 2, 'Friday', 'Breakfast', 'Small Frying', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('LKjB2qqFde0B9Oz0t9A1', 'Wednesday Week 4 Dinner Small Frying', 4, 'Wednesday', 'Dinner', 'Small Frying', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('lLscCmU64rsAOxR9qbJ6', 'Wednesday Week 1 Lunch Medium Frying', 1, 'Wednesday', 'Lunch', 'Medium Frying', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('LlZDi959eBRGsfxefWcc', 'Friday Week 4 Dinner XL', 4, 'Friday', 'Dinner', 'XL', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('lm1uA7OL8NYGumOvGTH7', 'Friday Week 4 Midnight Lunch Large', 4, 'Friday', 'Midnight Lunch', 'Large', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('Ln0Vba3ZRsUtg3ZcJ4Mg', 'Saturday Week 3 Snack Large', 3, 'Saturday', 'Snack', 'Large', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('lo22cZEmpaziHCApsFN9', 'Wednesday Week 1 Lunch Medium', 1, 'Wednesday', 'Lunch', 'Medium', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('LpE8p8TbyLB0tKvUpn5c', 'Friday Week 2 Midnight Snack Medium Frying', 2, 'Friday', 'Midnight Snack', 'Medium Frying', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('lqnAVxnvZiU6TDD0258Z', 'Friday Week 3 Snack Small Frying', 3, 'Friday', 'Snack', 'Small Frying', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('LR2lhd6WTPDwDBwtcaeu', 'Wednesday Week 3 Midnight Snack Small Frying', 3, 'Wednesday', 'Midnight Snack', 'Small Frying', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('lt2kiC9a5Zc1eS8NqR3s', 'Sunday Week 1 Bfast Medium', 1, 'Sunday', 'Breakfast', 'Medium', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('lTEnM3GiWjfUQOiy00Q0', 'Saturday Week 3 Bfast Large', 3, 'Saturday', 'Breakfast', 'Large', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('LtFwIk8IIt5zMwUJLX3j', 'Thursday Week 3 Midnight Lunch Small Frying', 3, 'Thursday', 'Midnight Lunch', 'Small Frying', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('LVB2rpWAfJ6rjbYp9YmS', 'Sunday Week 3 Snack Medium', 3, 'Sunday', 'Snack', 'Medium', '2025-05-07 17:28:59', '2025-05-07 17:28:59'),
('lvNJ0I3MeXtbBWpgnlGx', 'Monday Week 1 Dinner Medium', 1, 'Monday', 'Dinner', 'Medium', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('LWnG3NodYgD3Lr2MTYeV', 'Friday Week 4 Bfast Small Frying', 4, 'Friday', 'Breakfast', 'Small Frying', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('Lxe3Uj9caAb5LM9viUUC', 'Thursday Week 3 Snack XL', 3, 'Thursday', 'Snack', 'XL', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('LY0mm1xPheDTMEvHrPJS', 'Sunday Week 4 Lunch Medium Frying', 4, 'Sunday', 'Lunch', 'Medium Frying', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('lygDkMWhVfU47vLhDv3g', 'Wednesday Week 2 Snack Large', 2, 'Wednesday', 'Snack', 'Large', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('lYI2MCSoptk9UJE4qb2V', 'Tuesday Week 3 Lunch Medium', 3, 'Tuesday', 'Lunch', 'Medium', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('lZ98hhCbOJTXzM23WMA1', 'Wednesday Week 4 Midnight Lunch Large', 4, 'Wednesday', 'Midnight Lunch', 'Large', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('LZ9T2GMK9Jcls5CO1waz', 'Tuesday Week 4 Midnight Snack Small Frying', 4, 'Tuesday', 'Midnight Snack', 'Small Frying', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('lZvGGqMTd4hxWxPrGaPs', 'Saturday Week 1 Snack Small', 1, 'Saturday', 'Snack', 'Small', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('M1YlDcHcF3bdQi8PbVnR', 'Saturday Week 2 Lunch XL', 2, 'Saturday', 'Lunch', 'XL', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('m2fczRlr633cOHIUa9CO', 'Friday Week 4 Midnight Snack XL', 4, 'Friday', 'Midnight Snack', 'XL', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('M3sDqDXwRcw0Rw3icFxq', 'Friday Week 1 Midnight Lunch Small Frying', 1, 'Friday', 'Midnight Lunch', 'Small Frying', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('M3vTSjplVytXWAKlclrw', 'Wednesday Week 1 Midnight Lunch Small Frying', 1, 'Wednesday', 'Midnight Lunch', 'Small Frying', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('M4dIDVUxsFdnbQWzeax7', 'Saturday Week 1 Snack Large', 1, 'Saturday', 'Snack', 'Large', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('M7x7T5KlwsAha9mEddAK', 'Friday Week 1 Midnight Snack Small Frying', 1, 'Friday', 'Midnight Snack', 'Small Frying', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('mCmI3XjWxUCaEEaReWas', 'Sunday Week 2 Bfast Medium Frying', 2, 'Sunday', 'Breakfast', 'Medium Frying', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('me0WnOzBTOLB6evNNLfq', 'Wednesday Week 1 Bfast Large', 1, 'Wednesday', 'Breakfast', 'Large', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('MG0oUr159jM9HMtOckmq', 'Saturday Week 3 Snack XL', 3, 'Saturday', 'Snack', 'XL', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('MGGrtWFUJINmXRpBDLDa', 'Friday Week 2 Midnight Lunch Small Frying', 2, 'Friday', 'Midnight Lunch', 'Small Frying', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('MGyDuJV8hhLBwk4TnQvU', 'Thursday Week 4 Snack Large', 4, 'Thursday', 'Snack', 'Large', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('mH5gPvb641WNgltlMnR9', 'Wednesday Week 3 Bfast Large', 3, 'Wednesday', 'Breakfast', 'Large', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('MIjGzf7R5Qeq06biPWjm', 'Monday Week 2 Midnight Lunch Medium Frying', 2, 'Monday', 'Midnight Lunch', 'Medium Frying', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('mjxJh1alzY5TrFSVHBb6', 'Friday Week 4 Lunch Small', 4, 'Friday', 'Lunch', 'Small', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('mKT3wEzEpaOKtI5202MT', 'Tuesday Week 1 Lunch Small Frying', 1, 'Tuesday', 'Lunch', 'Small Frying', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('ML5wgeI2VmlpGO1unSjH', 'Tuesday Week 2 Midnight Lunch Medium Frying', 2, 'Tuesday', 'Midnight Lunch', 'Medium Frying', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('MMgleC3mNQG08fVL4pB2', 'Sunday Week 4 Midnight Lunch XL', 4, 'Sunday', 'Midnight Lunch', 'XL', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('MOM3OxLuni17O5YytGF9', 'Friday Week 4 Midnight Lunch Medium Frying', 4, 'Friday', 'Midnight Lunch', 'Medium Frying', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('MOtUOOyqndFdKdAkPNml', 'Friday Week 1 Snack Small Frying', 1, 'Friday', 'Snack', 'Small Frying', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('MpQ5KwupUmZCEr52voiw', 'Saturday Week 4 Midnight Snack Large', 4, 'Saturday', 'Midnight Snack', 'Large', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('mQdGJVVulRYYUZbEWziq', 'Friday Week 3 Snack Large', 3, 'Friday', 'Snack', 'Large', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('mRg0KPO0jtDI6wLcn9Cr', 'Friday Week 2 Midnight Lunch Medium Frying', 2, 'Friday', 'Midnight Lunch', 'Medium Frying', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('MrwDjyDNh6RoF8Qomzlx', 'Saturday Week 4 Snack Medium', 4, 'Saturday', 'Snack', 'Medium', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('mSmpFMFlynTm3L9hyMOQ', 'Tuesday Week 2 Midnight Lunch Large', 2, 'Tuesday', 'Midnight Lunch', 'Large', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('msTUGpJclyrFPgakUY0T', 'Friday Week 2 Midnight Lunch Medium', 2, 'Friday', 'Midnight Lunch', 'Medium', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('MTqodqNjGlCgWHDHvUWH', 'Monday Week 1 Dinner Small Frying', 1, 'Monday', 'Dinner', 'Small Frying', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('MUVxMgQb0wIcNRKcnNRH', 'Tuesday Week 4 Lunch Medium Frying', 4, 'Tuesday', 'Lunch', 'Medium Frying', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('muz1KaKBVwmihggqRJHs', 'Sunday Week 1 Midnight Lunch Small', 1, 'Sunday', 'Midnight Lunch', 'Small', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('mvCGFHuXg82KbFCzpJqN', 'Sunday Week 1 Midnight Snack Large', 1, 'Sunday', 'Midnight Snack', 'Large', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('mW4YAnZTNeTukSeQZFsf', 'Tuesday Week 2 Dinner Small', 2, 'Tuesday', 'Dinner', 'Small', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('mX79mTqwbLFNQ9YwX3LK', 'Tuesday Week 4 Midnight Snack Medium Frying', 4, 'Tuesday', 'Midnight Snack', 'Medium Frying', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('my0OLP1ImYFfKmveOMzZ', 'Saturday Week 3 Lunch XL', 3, 'Saturday', 'Lunch', 'XL', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('mZQQ5lXwxbPc3PCN0p0C', 'Friday Week 3 Snack XL', 3, 'Friday', 'Snack', 'XL', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('N075dabWkZ5oBiQZ5xSa', 'Wednesday Week 3 Midnight Snack XL', 3, 'Wednesday', 'Midnight Snack', 'XL', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('n0fPQVisEERpmSvLn215', 'Tuesday Week 3 Snack Large', 3, 'Tuesday', 'Snack', 'Large', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('N0R6AcSS6eF8Vg9MFOVC', 'Friday Week 1 Bfast Large', 1, 'Friday', 'Breakfast', 'Large', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('N1KDUOPwk5uYbGIGK4vL', 'Thursday Week 4 Midnight Lunch Medium', 4, 'Thursday', 'Midnight Lunch', 'Medium', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('n2yGzSjBmZopW0YBiUQw', 'Saturday Week 2 Lunch Small Frying', 2, 'Saturday', 'Lunch', 'Small Frying', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('N5aSPoQ5bPQzQK8q759t', 'Friday Week 3 Midnight Snack Medium Frying', 3, 'Friday', 'Midnight Snack', 'Medium Frying', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('N632JqcoCfnpDzys1Egl', 'Sunday Week 1 Dinner Small Frying', 1, 'Sunday', 'Dinner', 'Small Frying', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('n6rsf0W1jzCAy4czME8D', 'Monday Week 3 Midnight Lunch Medium Frying', 3, 'Monday', 'Midnight Lunch', 'Medium Frying', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('n6Y9UBU6D0WqaP6y8gNU', 'Friday Week 4 Snack Small Frying', 4, 'Friday', 'Snack', 'Small Frying', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('N9iO3o80QiNJwQtrxetz', 'Sunday Week 3 Lunch Large', 3, 'Sunday', 'Lunch', 'Large', '2025-05-07 17:28:59', '2025-05-07 17:28:59'),
('nAONOz1hntEEfJ5RQj28', 'Monday Week 2 Dinner Small Frying', 2, 'Monday', 'Dinner', 'Small Frying', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('NC3XKKb3YkXaZSj9p3WA', 'Monday Week 3 Snack Large', 3, 'Monday', 'Snack', 'Large', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('nDjaeBfOAVXsxhsq4Xas', 'Wednesday Week 1 Dinner Small', 1, 'Wednesday', 'Dinner', 'Small', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('NDpE8UrRg5wRKu8jUWBs', 'Tuesday Week 2 Midnight Lunch Small', 2, 'Tuesday', 'Midnight Lunch', 'Small', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('neDjGb6O282XP0n5WgSh', 'Monday Week 3 Midnight Lunch Large', 3, 'Monday', 'Midnight Lunch', 'Large', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('Nekf7OB2zYFF0BRWaTJf', 'Thursday Week 1 Snack Small Frying', 1, 'Thursday', 'Snack', 'Small Frying', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('NFQJSw3GxaC1FET4Rtmt', 'Sunday Week 2 Bfast XL', 2, 'Sunday', 'Breakfast', 'XL', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('nFrorHPUWcfa89nyaTMp', 'Tuesday Week 4 Snack Small Frying', 4, 'Tuesday', 'Snack', 'Small Frying', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('NGglbTteAufaxkAd4TSC', 'Sunday Week 4 Midnight Lunch Medium Frying', 4, 'Sunday', 'Midnight Lunch', 'Medium Frying', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('NgIp2ar2HJNn4QiV6kKj', 'Wednesday Week 4 Bfast Small', 4, 'Wednesday', 'Breakfast', 'Small', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('nGKVWzIE2fwiAoKWrOlw', 'Sunday Week 4 Snack Medium Frying', 4, 'Sunday', 'Snack', 'Medium Frying', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('ngTVPfzM2qjBRsIO2a1j', 'Monday Week 1 Midnight Snack XL', 1, 'Monday', 'Midnight Snack', 'XL', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('ngYJADRrxIRyuMlLlPOY', 'Friday Week 3 Lunch Small Frying', 3, 'Friday', 'Lunch', 'Small Frying', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('nhNwSvlKB52a1uRbxRAB', 'Sunday Week 3 Bfast Small', 3, 'Sunday', 'Breakfast', 'Small', '2025-05-07 17:28:59', '2025-05-07 17:28:59'),
('nHO9epM3XqGYTrCknyXI', 'Monday Week 1 Bfast Large', 1, 'Monday', 'Breakfast', 'Large', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('NhWIU0VNLciwZbeWflwv', 'Thursday Week 3 Midnight Snack Medium Frying', 3, 'Thursday', 'Midnight Snack', 'Medium Frying', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('NiTOiSGHEfsaLyiEakt1', 'Friday Week 2 Midnight Snack XL', 2, 'Friday', 'Midnight Snack', 'XL', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('nja0E1r4GQgPcpQIVZ0N', 'Sunday Week 4 Bfast Small', 4, 'Sunday', 'Breakfast', 'Small', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('nKsUzzQH6zZbd1wJkPyS', 'Monday Week 1 Dinner Small', 1, 'Monday', 'Dinner', 'Small', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('NMwsk1EyIk53iwhf1KTn', 'Monday Week 2 Midnight Snack Small', 2, 'Monday', 'Midnight Snack', 'Small', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('nn9aQX9OjAktJWvj2lYt', 'Sunday Week 4 Midnight Snack Small Frying', 4, 'Sunday', 'Midnight Snack', 'Small Frying', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('nO3nWZ6yQ2psAA7pGRnZ', 'Tuesday Week 3 Midnight Lunch Small', 3, 'Tuesday', 'Midnight Lunch', 'Small', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('nPA2ZrGGloub8b2lnHtW', 'Wednesday Week 2 Lunch Small', 2, 'Wednesday', 'Lunch', 'Small', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('NpeKOw8rxTAGgdnYkJ2Y', 'Friday Week 2 Dinner Small Frying', 2, 'Friday', 'Dinner', 'Small Frying', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('NPkp5mygpObQgGhd8TyP', 'Sunday Week 2 Snack Large', 2, 'Sunday', 'Snack', 'Large', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('Nramp3TloWtTOX2sBQS2', 'Wednesday Week 2 Bfast Small Frying', 2, 'Wednesday', 'Breakfast', 'Small Frying', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('NTivRubdJS2fz7tCKOMm', 'Monday Week 2 Midnight Lunch Large', 2, 'Monday', 'Midnight Lunch', 'Large', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('nVkz1k6RBYirzgTNa4xk', 'Thursday Week 1 Bfast Large', 1, 'Thursday', 'Breakfast', 'Large', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('NvnweX2CepXV539Ac4h8', 'Saturday Week 3 Snack Small Frying', 3, 'Saturday', 'Snack', 'Small Frying', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('nWdYPQzQwJIoJvZG7daX', 'Monday Week 3 Dinner XL', 3, 'Monday', 'Dinner', 'XL', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('NWfgKk4HqowWex6zLPqS', 'Wednesday Week 2 Bfast Small', 2, 'Wednesday', 'Breakfast', 'Small', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('nXWgLX4g3kJJGMdbGl8R', 'Monday Week 1 Bfast Medium', 1, 'Monday', 'Breakfast', 'Medium', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('nyxle8g6jM3cbqXMTmei', 'Friday Week 3 Dinner Medium Frying', 3, 'Friday', 'Dinner', 'Medium Frying', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('Nza8MWbNp5AqilmWjiyc', 'Tuesday Week 3 Midnight Snack Large', 3, 'Tuesday', 'Midnight Snack', 'Large', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('O1WuQJSnDRJ548n6YEZ5', 'Friday Week 2 Snack Medium Frying', 2, 'Friday', 'Snack', 'Medium Frying', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('o2vOVHP5RlwtwmOnhWd7', 'Friday Week 1 Midnight Snack Large', 1, 'Friday', 'Midnight Snack', 'Large', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('o3J7b6xW0KS89vaYhnt8', 'Monday Week 3 Lunch XL', 3, 'Monday', 'Lunch', 'XL', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('O4j1DteSrqHwYqsdwwqd', 'Thursday Week 2 Lunch Small', 2, 'Thursday', 'Lunch', 'Small', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('o5IIUY01ieQV1WL4eDeU', 'Wednesday Week 1 Snack Medium Frying', 1, 'Wednesday', 'Snack', 'Medium Frying', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('O7lptjiNhfafj90H1k0G', 'Tuesday Week 4 Dinner Large', 4, 'Tuesday', 'Dinner', 'Large', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('o9jyerAZwXoDdMatyZt1', 'Thursday Week 2 Snack Small Frying', 2, 'Thursday', 'Snack', 'Small Frying', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('O9s7GxHvNxDTRmKHzWyI', 'Friday Week 2 Snack Small', 2, 'Friday', 'Snack', 'Small', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('oaVJz2vNOJbxsXtbctE8', 'Tuesday Week 3 Dinner XL', 3, 'Tuesday', 'Dinner', 'XL', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('ObkZaHiNoofjrmb8ubr1', 'Friday Week 4 Bfast XL', 4, 'Friday', 'Breakfast', 'XL', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('obwye1DoT4Ilo91qjU8A', 'Tuesday Week 2 Snack Small Frying', 2, 'Tuesday', 'Snack', 'Small Frying', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('OdlPgCaaUe9FY1W9eqvC', 'Friday Week 1 Midnight Snack Medium Frying', 1, 'Friday', 'Midnight Snack', 'Medium Frying', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('Odmx3byn1aWB6jw9J3NT', 'Sunday Week 4 Snack Large', 4, 'Sunday', 'Snack', 'Large', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('oFz5fCCevKTlAOALweIP', 'Friday Week 3 Bfast Small Frying', 3, 'Friday', 'Breakfast', 'Small Frying', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('oGiwBaPsZb8uKJEOsdnp', 'Monday Week 1 Midnight Snack Small Frying', 1, 'Monday', 'Midnight Snack', 'Small Frying', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('Oi7YegYjQNXueiU9MwW8', 'Saturday Week 4 Midnight Snack XL', 4, 'Saturday', 'Midnight Snack', 'XL', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('oiFny3eMdkIrUvlOpU6L', 'Sunday Week 3 Midnight Snack Small Frying', 3, 'Sunday', 'Midnight Snack', 'Small Frying', '2025-05-07 17:29:00', '2025-05-07 17:29:00'),
('OIIlKchT08XJT9sPAWIF', 'Saturday Week 2 Midnight Snack Medium', 2, 'Saturday', 'Midnight Snack', 'Medium', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('oiM67f3l8eT3HjQfy8VB', 'Saturday Week 4 Midnight Lunch Large', 4, 'Saturday', 'Midnight Lunch', 'Large', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('oJadOzaUXiTGTXcV2IsG', 'Friday Week 1 Midnight Lunch Small', 1, 'Friday', 'Midnight Lunch', 'Small', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('OjuvSD5b0yA0z8ZA65cV', 'Sunday Week 1 Dinner Medium', 1, 'Sunday', 'Dinner', 'Medium', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('OK0onUweGp2LZD5hDx0W', 'Thursday Week 3 Midnight Lunch XL', 3, 'Thursday', 'Midnight Lunch', 'XL', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('okntdjPPLaGzCG1kbmgL', 'Wednesday Week 4 Midnight Snack Medium Frying', 4, 'Wednesday', 'Midnight Snack', 'Medium Frying', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('OoCxNwchNS71Mk9XSjN1', 'Monday Week 2 Snack Large', 2, 'Monday', 'Snack', 'Large', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('oOZVSeU26sjw1I2i21hI', 'Saturday Week 2 Midnight Snack XL', 2, 'Saturday', 'Midnight Snack', 'XL', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('opkt2wX6sX9LDutQT9E5', 'Tuesday Week 3 Dinner Small Frying', 3, 'Tuesday', 'Dinner', 'Small Frying', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('oTcPYg9jEusw9z2Vhdg6', 'Thursday Week 2 Snack XL', 2, 'Thursday', 'Snack', 'XL', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('oum79QVG0fXEuZ6YWDIy', 'Tuesday Week 2 Dinner Medium Frying', 2, 'Tuesday', 'Dinner', 'Medium Frying', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('oVghUnNYgCxZZCNpBvVZ', 'Wednesday Week 4 Bfast Medium', 4, 'Wednesday', 'Breakfast', 'Medium', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('ovKo1sTqyHQXwQVifwqZ', 'Sunday Week 1 Midnight Lunch XL', 1, 'Sunday', 'Midnight Lunch', 'XL', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('Ovt5dlhcxciduJLlJPnp', 'Tuesday Week 3 Lunch XL', 3, 'Tuesday', 'Lunch', 'XL', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('OZCXGF4Q7SSIrEN0ZVMG', 'Wednesday Week 3 Dinner XL', 3, 'Wednesday', 'Dinner', 'XL', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('OZUldauw0xgNJmmVjz24', 'Tuesday Week 1 Midnight Lunch XL', 1, 'Tuesday', 'Midnight Lunch', 'XL', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('P5yujIOaEX6vg0WClT5b', 'Tuesday Week 1 Snack Medium Frying', 1, 'Tuesday', 'Snack', 'Medium Frying', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('p7yS8UzkZVEBEQfoCcfr', 'Monday Week 2 Bfast Medium Frying', 2, 'Monday', 'Breakfast', 'Medium Frying', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('P9czbDtuGmfjrZQZGf12', 'Sunday Week 3 Midnight Lunch Small', 3, 'Sunday', 'Midnight Lunch', 'Small', '2025-05-07 17:29:00', '2025-05-07 17:29:00'),
('P9nQPgxnYfRoidkKyNax', 'Wednesday Week 3 Snack Medium Frying', 3, 'Wednesday', 'Snack', 'Medium Frying', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('p9td1Sd3RRgIUDy7lwUQ', 'Sunday Week 2 Lunch Large', 2, 'Sunday', 'Lunch', 'Large', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('PaNDlQbUizHHeYV48Q70', 'Sunday Week 4 Bfast XL', 4, 'Sunday', 'Breakfast', 'XL', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('paYqpIlCB4gc1BGnahlU', 'Tuesday Week 4 Dinner XL', 4, 'Tuesday', 'Dinner', 'XL', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('PbkPzthnY01PcnMxaNKW', 'Friday Week 1 Dinner Medium', 1, 'Friday', 'Dinner', 'Medium', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('PcFrOtm1BOAhUss2EM8R', 'Sunday Week 3 Midnight Lunch Medium', 3, 'Sunday', 'Midnight Lunch', 'Medium', '2025-05-07 17:29:00', '2025-05-07 17:29:00'),
('PfZVJKE7mTAHUYlIcfg3', 'Friday Week 4 Snack Small', 4, 'Friday', 'Snack', 'Small', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('PIr9fm6mxsTwaZNFr8ki', 'Saturday Week 1 Midnight Snack Medium Frying', 1, 'Saturday', 'Midnight Snack', 'Medium Frying', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('PkGXxrF3iy1OSfepg5I1', 'Monday Week 3 Midnight Lunch Small Frying', 3, 'Monday', 'Midnight Lunch', 'Small Frying', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('PKQh9v7YDSIfydsHef2X', 'Saturday Week 4 Dinner Medium Frying', 4, 'Saturday', 'Dinner', 'Medium Frying', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('plN8R6vnAU9XSh3mm96A', 'Monday Week 2 Midnight Snack Small Frying', 2, 'Monday', 'Midnight Snack', 'Small Frying', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('PmSCrblAOj77LeFOK4em', 'Sunday Week 3 Dinner Medium Frying', 3, 'Sunday', 'Dinner', 'Medium Frying', '2025-05-07 17:28:59', '2025-05-07 17:28:59'),
('POJV4qD8NhPOE4HQ3JMl', 'Monday Week 1 Midnight Lunch Large', 1, 'Monday', 'Midnight Lunch', 'Large', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('PpejG9hIBFcej8c9wb04', 'Saturday Week 1 Snack Medium', 1, 'Saturday', 'Snack', 'Medium', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('PPkHNd3diyREgkOeiOre', 'Saturday Week 2 Lunch Medium Frying', 2, 'Saturday', 'Lunch', 'Medium Frying', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('pPO66SdAQ3zCPHbwVZ5m', 'Thursday Week 2 Midnight Snack Large', 2, 'Thursday', 'Midnight Snack', 'Large', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('pRB0vytOIcQv5wLqpCXx', 'Tuesday Week 1 Dinner Large', 1, 'Tuesday', 'Dinner', 'Large', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('psLspDVjbvkZZSFf4B57', 'Monday Week 4 Midnight Snack Medium', 4, 'Monday', 'Midnight Snack', 'Medium', '2025-05-10 07:48:53', '2025-05-10 07:48:53'),
('pSTulUZQT5MFrnfKZmOT', 'Tuesday Week 3 Midnight Lunch Large', 3, 'Tuesday', 'Midnight Lunch', 'Large', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('ptODbC0t0uN2EmmffCKC', 'Thursday Week 1 Lunch Large', 1, 'Thursday', 'Lunch', 'Large', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('pUeKthivt3aE03m5Ni93', 'Sunday Week 3 Snack Medium Frying', 3, 'Sunday', 'Snack', 'Medium Frying', '2025-05-07 17:28:59', '2025-05-07 17:28:59'),
('pUQI0qgYnE0ztHWCS0VS', 'Wednesday Week 2 Lunch Large', 2, 'Wednesday', 'Lunch', 'Large', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('PvkAPa6AxA5kNL7zMN8O', 'Monday Week 4 Bfast Small Frying', 4, 'Monday', 'Breakfast', 'Small Frying', '2025-05-10 07:48:52', '2025-05-10 07:48:52'),
('PW8Mvg08NbhQ57pnA69C', 'Thursday Week 2 Midnight Lunch Medium', 2, 'Thursday', 'Midnight Lunch', 'Medium', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('pxLtOoUGnmVI5YzTw26H', 'Friday Week 4 Snack Medium', 4, 'Friday', 'Snack', 'Medium', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('pxnEc63Vrd6hlJN79g0H', 'Tuesday Week 4 Lunch XL', 4, 'Tuesday', 'Lunch', 'XL', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('pYBtDpQYaWvauEOS8ay2', 'Saturday Week 4 Bfast Medium', 4, 'Saturday', 'Breakfast', 'Medium', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('PYLO76z2C0eqwdrYYJMj', 'Monday Week 3 Lunch Large', 3, 'Monday', 'Lunch', 'Large', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('pZDPiyuiyqVibe85g7gj', 'Thursday Week 3 Bfast Medium', 3, 'Thursday', 'Breakfast', 'Medium', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('pzrS5EoyoBkrbpxFm5V2', 'Wednesday Week 3 Snack Small Frying', 3, 'Wednesday', 'Snack', 'Small Frying', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('Q6UYGjNrJvCoWFumdtdX', 'Monday Week 2 Midnight Lunch Medium', 2, 'Monday', 'Midnight Lunch', 'Medium', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('q7VX0sQ0ptGM4Jmk3dr4', 'Thursday Week 4 Snack Small Frying', 4, 'Thursday', 'Snack', 'Small Frying', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('Q8U7DCecJHQCqIeCgddE', 'Tuesday Week 4 Bfast Small Frying', 4, 'Tuesday', 'Breakfast', 'Small Frying', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('QahknhA6CIHOZMk8hAae', 'Thursday Week 1 Snack Medium', 1, 'Thursday', 'Snack', 'Medium', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('QbjCu5z7Yaqh6rM2Y3zS', 'Sunday Week 1 Midnight Snack Medium', 1, 'Sunday', 'Midnight Snack', 'Medium', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('QcUu3t5zobvyxJDNNVLG', 'Friday Week 2 Bfast Medium', 2, 'Friday', 'Breakfast', 'Medium', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('qeBdcM0H1GDUwE1zCIRV', 'Tuesday Week 1 Midnight Lunch Small Frying', 1, 'Tuesday', 'Midnight Lunch', 'Small Frying', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('qeEuFgCt2QeMo52hVGtq', 'Thursday Week 4 Bfast XL', 4, 'Thursday', 'Breakfast', 'XL', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('QfNIxpC3e8ASaUV37MPO', 'Thursday Week 3 Midnight Lunch Small', 3, 'Thursday', 'Midnight Lunch', 'Small', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('QFTvHMpZ6Vg7LG9kzYSl', 'Wednesday Week 2 Midnight Lunch Small Frying', 2, 'Wednesday', 'Midnight Lunch', 'Small Frying', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('qGUArsIUolnXVjxBqbUs', 'Monday Week 1 Lunch Medium', 1, 'Monday', 'Lunch', 'Medium', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('qjKznfAZNwH2ynpJpoV4', 'Sunday Week 4 Bfast Small Frying', 4, 'Sunday', 'Breakfast', 'Small Frying', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('qOCb2pXeGi3mZ70HVtrz', 'Monday Week 3 Snack Medium', 3, 'Monday', 'Snack', 'Medium', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('QPETglvBCEs4qALWeVQn', 'Monday Week 2 Lunch Small', 2, 'Monday', 'Lunch', 'Small', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('qq9ctkOQJZOTPJp6utd4', 'Friday Week 2 Bfast Medium Frying', 2, 'Friday', 'Breakfast', 'Medium Frying', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('qqdePUN2zxs9YeHhDjcT', 'Tuesday Week 3 Bfast Large', 3, 'Tuesday', 'Breakfast', 'Large', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('qQZiJjxAy5OZ04MBcOmx', 'Sunday Week 2 Snack Small', 2, 'Sunday', 'Snack', 'Small', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('QXFcx5Jzn4OG9Ng4pw6T', 'Thursday Week 2 Dinner XL', 2, 'Thursday', 'Dinner', 'XL', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('qXpmm3GcIDe3CAqlMVU6', 'Saturday Week 2 Bfast Small Frying', 2, 'Saturday', 'Breakfast', 'Small Frying', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('QyeE7CmqZSHEGYlE79RE', 'Monday Week 1 Snack Medium Frying', 1, 'Monday', 'Snack', 'Medium Frying', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('QywFo1DdFMwIFbrp2S0e', 'Saturday Week 2 Snack XL', 2, 'Saturday', 'Snack', 'XL', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('R0Lc2YYhm0AeFFcsh5Qr', 'Sunday Week 2 Snack Medium Frying', 2, 'Sunday', 'Snack', 'Medium Frying', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('r2kaHIQawSO863vDUBbw', 'Saturday Week 1 Bfast Small Frying', 1, 'Saturday', 'Breakfast', 'Small Frying', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('r2mXosm1Akq2dCZ38QWX', 'Thursday Week 2 Snack Large', 2, 'Thursday', 'Snack', 'Large', '2025-05-07 08:05:30', '2025-05-07 08:05:30');
INSERT INTO `menus` (`id`, `menu_name`, `menu_week`, `menu_day`, `meal_type`, `menu_size`, `created_at`, `updated_at`) VALUES
('R3zTKW8DNmK4oeqpm3is', 'Sunday Week 1 Lunch XL', 1, 'Sunday', 'Lunch', 'XL', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('RbQdXymtz2hVFVghzEW4', 'Sunday Week 1 Midnight Snack Small Frying', 1, 'Sunday', 'Midnight Snack', 'Small Frying', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('RBszANbqAIF4Pp0cWzJp', 'Friday Week 4 Midnight Lunch Small', 4, 'Friday', 'Midnight Lunch', 'Small', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('rdNcfR2D1xrND5QlnQcX', 'Wednesday Week 2 Snack Medium Frying', 2, 'Wednesday', 'Snack', 'Medium Frying', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('rEhoTDktYOXd8CR7i65B', 'Friday Week 4 Snack XL', 4, 'Friday', 'Snack', 'XL', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('rEJ7ueA2FnGTpXtMjtOR', 'Thursday Week 2 Midnight Snack XL', 2, 'Thursday', 'Midnight Snack', 'XL', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('rENrZPnUBeV4kg3pjzHc', 'Thursday Week 1 Dinner Large', 1, 'Thursday', 'Dinner', 'Large', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('rEQLbTcemg356sCrs3ru', 'Thursday Week 4 Midnight Lunch Small', 4, 'Thursday', 'Midnight Lunch', 'Small', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('ReuLHlzf7ULAyxUZbCZZ', 'Thursday Week 2 Bfast Medium', 2, 'Thursday', 'Breakfast', 'Medium', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('Rfp0jM1ALy3jbfGd2MT9', 'Wednesday Week 3 Lunch XL', 3, 'Wednesday', 'Lunch', 'XL', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('rggg31FaG80pui5wlOEt', 'Saturday Week 2 Bfast Medium Frying', 2, 'Saturday', 'Breakfast', 'Medium Frying', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('rgwvKa3jBOLCRKBsYgGB', 'Thursday Week 3 Dinner Small', 3, 'Thursday', 'Dinner', 'Small', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('RhuSAL33S2v4hLlvjdd1', 'Sunday Week 2 Midnight Lunch Small Frying', 2, 'Sunday', 'Midnight Lunch', 'Small Frying', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('RI2L9Ac72719LIsRk78Q', 'Friday Week 2 Midnight Snack Small', 2, 'Friday', 'Midnight Snack', 'Small', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('RIa6AMUthm13owm0GSb5', 'Monday Week 2 Dinner Medium', 2, 'Monday', 'Dinner', 'Medium', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('rIrOTaoVxhliD0ckzzJZ', 'Thursday Week 4 Lunch Medium Frying', 4, 'Thursday', 'Lunch', 'Medium Frying', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('RIV6YVbM5aYX6UNp1EkZ', 'Monday Week 2 Bfast Medium', 2, 'Monday', 'Breakfast', 'Medium', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('rjFSAcgxiCCu8XZKA9Kw', 'Wednesday Week 2 Midnight Lunch Medium', 2, 'Wednesday', 'Midnight Lunch', 'Medium', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('RJGHWSiE0dxYcMNvJQKv', 'Wednesday Week 4 Midnight Snack Medium', 4, 'Wednesday', 'Midnight Snack', 'Medium', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('RJIxjQLPkP1Djw2QVdGk', 'Friday Week 4 Midnight Lunch Medium', 4, 'Friday', 'Midnight Lunch', 'Medium', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('RkNQLg9b9FP7y11hpi3A', 'Sunday Week 4 Dinner XL', 4, 'Sunday', 'Dinner', 'XL', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('rl8FHjmYj0zGo2Qw9V4I', 'Tuesday Week 2 Midnight Snack XL', 2, 'Tuesday', 'Midnight Snack', 'XL', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('RLkU5DxDeWtA5An7mnJ3', 'Wednesday Week 4 Dinner XL', 4, 'Wednesday', 'Dinner', 'XL', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('RmctHaRy8F8VNHdcRPXC', 'Tuesday Week 1 Lunch Large', 1, 'Tuesday', 'Lunch', 'Large', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('RMcXAdN42wXEy02nKqij', 'Thursday Week 1 Snack Medium Frying', 1, 'Thursday', 'Snack', 'Medium Frying', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('RMeMYJrUXMInk5kAsAB0', 'Monday Week 2 Midnight Snack Medium Frying', 2, 'Monday', 'Midnight Snack', 'Medium Frying', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('Rp1SDx7yh6q2mK7m09wq', 'Tuesday Week 4 Bfast XL', 4, 'Tuesday', 'Breakfast', 'XL', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('rQ5f852XVDj6UP4i5aIj', 'Sunday Week 4 Dinner Small Frying', 4, 'Sunday', 'Dinner', 'Small Frying', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('RSCRTi8B63SpERW9DSet', 'Sunday Week 3 Midnight Snack Small', 3, 'Sunday', 'Midnight Snack', 'Small', '2025-05-07 17:29:00', '2025-05-07 17:29:00'),
('rScSmR0yXYHi2pqxJsX9', 'Sunday Week 1 Snack Medium Frying', 1, 'Sunday', 'Snack', 'Medium Frying', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('rSerC5Tecjl1VxgLEMwq', 'Thursday Week 4 Bfast Medium Frying', 4, 'Thursday', 'Breakfast', 'Medium Frying', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('rt9d8rxbntbo2cewi9vN', 'Monday Week 4 Snack Large', 4, 'Monday', 'Snack', 'Large', '2025-05-10 07:48:52', '2025-05-10 07:48:52'),
('RuNRQzPaDDU9IHIoeyZ5', 'Thursday Week 4 Bfast Small', 4, 'Thursday', 'Breakfast', 'Small', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('RWYIE7InVnVycfxDEcv2', 'Saturday Week 2 Dinner Medium', 2, 'Saturday', 'Dinner', 'Medium', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('RY355SN0QGO5vllGHbzZ', 'Friday Week 1 Midnight Snack Small', 1, 'Friday', 'Midnight Snack', 'Small', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('ryedF78g6P6vgG08HEnM', 'Friday Week 2 Midnight Lunch Small', 2, 'Friday', 'Midnight Lunch', 'Small', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('S3FjvWVoK9Ex0wfDY9w4', 'Sunday Week 1 Lunch Medium Frying', 1, 'Sunday', 'Lunch', 'Medium Frying', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('s5Yo1l3noTRXY7f6mjRG', 'Thursday Week 1 Lunch Medium Frying', 1, 'Thursday', 'Lunch', 'Medium Frying', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('S8IoyLDZxvVshZ2Hs3sn', 'Friday Week 4 Snack Large', 4, 'Friday', 'Snack', 'Large', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('s8S9BCPpNhb76eRX6VKO', 'Monday Week 4 Midnight Snack Large', 4, 'Monday', 'Midnight Snack', 'Large', '2025-05-10 07:48:53', '2025-05-10 07:48:53'),
('SAhGnErqZKf8oSK7WheX', 'Friday Week 1 Midnight Lunch Medium Frying', 1, 'Friday', 'Midnight Lunch', 'Medium Frying', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('SbtclPhX0aW9wdkmjKHp', 'Friday Week 4 Midnight Snack Large', 4, 'Friday', 'Midnight Snack', 'Large', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('sCK1UrAwRT51LTbCLH6K', 'Saturday Week 4 Lunch Medium Frying', 4, 'Saturday', 'Lunch', 'Medium Frying', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('ScLhxAK7DXH3l9aCxg6T', 'Wednesday Week 1 Midnight Lunch Medium Frying', 1, 'Wednesday', 'Midnight Lunch', 'Medium Frying', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('sCPCmaBiWTkTgenMj1rT', 'Friday Week 4 Dinner Small Frying', 4, 'Friday', 'Dinner', 'Small Frying', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('SCZoZqKL0eKRtUw38Pzo', 'Thursday Week 3 Bfast Small', 3, 'Thursday', 'Breakfast', 'Small', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('sEFHBD4xrSFda6LwcyuT', 'Sunday Week 4 Midnight Snack Medium', 4, 'Sunday', 'Midnight Snack', 'Medium', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('SfBPrWrJ31gTJE8HKtmd', 'Monday Week 1 Midnight Lunch Small', 1, 'Monday', 'Midnight Lunch', 'Small', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('sFIIDdrwoosEUlVGCxdp', 'Monday Week 3 Bfast XL', 3, 'Monday', 'Breakfast', 'XL', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('SGgV7zx5s97ctSaiLB2O', 'Sunday Week 4 Lunch Medium', 4, 'Sunday', 'Lunch', 'Medium', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('SgoDXekh7CyVrFZGoB85', 'Wednesday Week 3 Lunch Small Frying', 3, 'Wednesday', 'Lunch', 'Small Frying', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('sGtdKQymRVCXlAibtu89', 'Tuesday Week 2 Midnight Snack Medium Frying', 2, 'Tuesday', 'Midnight Snack', 'Medium Frying', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('sHgxLpLqVfoNNEX5kdFX', 'Saturday Week 4 Bfast Medium Frying', 4, 'Saturday', 'Breakfast', 'Medium Frying', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('SjQf39hEUsnUebz6L19r', 'Monday Week 1 Midnight Snack Large', 1, 'Monday', 'Midnight Snack', 'Large', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('sK6i1YCqDWPNqtYMHCAF', 'Thursday Week 2 Bfast Medium Frying', 2, 'Thursday', 'Breakfast', 'Medium Frying', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('SldYuFsNTlkc5J31dwUZ', 'Wednesday Week 1 Midnight Lunch XL', 1, 'Wednesday', 'Midnight Lunch', 'XL', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('SlLzRjWqJHdSe3VMuRRB', 'Thursday Week 1 Bfast Medium', 1, 'Thursday', 'Breakfast', 'Medium', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('sLr04ZjqdvJeMLHlEzmv', 'Saturday Week 1 Midnight Snack Large', 1, 'Saturday', 'Midnight Snack', 'Large', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('SlZ2bfqbMq2amFx2bYfq', 'Monday Week 3 Dinner Medium Frying', 3, 'Monday', 'Dinner', 'Medium Frying', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('smTqnP7thk90Dsxhc4er', 'Monday Week 4 Bfast Medium Frying', 4, 'Monday', 'Breakfast', 'Medium Frying', '2025-05-10 07:48:52', '2025-05-10 07:48:52'),
('sN1Vhx9AJ6Na4uVAUxAL', 'Wednesday Week 2 Bfast Medium', 2, 'Wednesday', 'Breakfast', 'Medium', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('SNvyDEKwrROIt2qOijUw', 'Friday Week 3 Lunch Medium', 3, 'Friday', 'Lunch', 'Medium', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('sTFRLJniGSPRhjchgp1W', 'Friday Week 2 Snack Large', 2, 'Friday', 'Snack', 'Large', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('stIoXfl35j2fZWOJi6yz', 'Tuesday Week 1 Lunch Medium Frying', 1, 'Tuesday', 'Lunch', 'Medium Frying', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('StLXZtES6DxTVaQ7lbxJ', 'Wednesday Week 3 Bfast XL', 3, 'Wednesday', 'Breakfast', 'XL', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('svBFTTGAZGYPjiKie7T1', 'Tuesday Week 3 Midnight Lunch XL', 3, 'Tuesday', 'Midnight Lunch', 'XL', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('SwC8v8sORHN0MBWzuhVg', 'Saturday Week 3 Midnight Lunch Small Frying', 3, 'Saturday', 'Midnight Lunch', 'Small Frying', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('SWQb9wjnOxgE7Ssp6AoI', 'Tuesday Week 2 Midnight Snack Medium', 2, 'Tuesday', 'Midnight Snack', 'Medium', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('t0QxTPET7JWov8PTwMHj', 'Wednesday Week 4 Dinner Medium', 4, 'Wednesday', 'Dinner', 'Medium', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('t2ZPxmNQ70DDPsNJ68bA', 'Tuesday Week 1 Bfast Small', 1, 'Tuesday', 'Breakfast', 'Small', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('T3gWwvTqlSK1wgaxOfxS', 'Saturday Week 3 Snack Medium', 3, 'Saturday', 'Snack', 'Medium', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('T4C6DUXeKYw6HVcOzGQ2', 'Wednesday Week 1 Snack Small', 1, 'Wednesday', 'Snack', 'Small', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('T6UJib8FaOQ74lsc9eEJ', 'Monday Week 4 Dinner Large', 4, 'Monday', 'Dinner', 'Large', '2025-05-10 07:48:52', '2025-05-10 07:48:52'),
('T9bX7ymedq55xxp3vsFS', 'Thursday Week 4 Midnight Snack Large', 4, 'Thursday', 'Midnight Snack', 'Large', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('TcicuVl2tdvK0NPMvgK5', 'Wednesday Week 4 Snack Medium', 4, 'Wednesday', 'Snack', 'Medium', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('tD2Za9mPcecBvspSAmLw', 'Monday Week 3 Bfast Medium', 3, 'Monday', 'Breakfast', 'Medium', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('tEANwqgNNbm5lwKGMPus', 'Wednesday Week 1 Midnight Snack XL', 1, 'Wednesday', 'Midnight Snack', 'XL', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('TIpdl7kSZdfsl3q3eRus', 'Wednesday Week 4 Lunch Small Frying', 4, 'Wednesday', 'Lunch', 'Small Frying', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('tJpoZFI5kgVZ12WD8vqH', 'Tuesday Week 4 Lunch Small', 4, 'Tuesday', 'Lunch', 'Small', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('TjW3ewZaMSiZ3h6kCQmh', 'Tuesday Week 3 Snack Medium Frying', 3, 'Tuesday', 'Snack', 'Medium Frying', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('TkeI1xP20TAgFkFhlTbd', 'Thursday Week 2 Bfast XL', 2, 'Thursday', 'Breakfast', 'XL', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('TLAps7ic2NezIhTV1ylS', 'Sunday Week 3 Bfast Medium Frying', 3, 'Sunday', 'Breakfast', 'Medium Frying', '2025-05-07 17:28:59', '2025-05-07 17:28:59'),
('tn0cHds8vqVQvKlVybM4', 'Thursday Week 1 Midnight Lunch Small Frying', 1, 'Thursday', 'Midnight Lunch', 'Small Frying', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('TN0v6v075OILprm7U3YA', 'Friday Week 2 Dinner Medium', 2, 'Friday', 'Dinner', 'Medium', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('TnjJ7Rs5aObCrIwyY2Gb', 'Wednesday Week 1 Bfast Medium', 1, 'Wednesday', 'Breakfast', 'Medium', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('TNojKZDtdwNXBSdb1pUc', 'Thursday Week 2 Dinner Large', 2, 'Thursday', 'Dinner', 'Large', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('tnpZnmBAQh8kPadUmzTC', 'Thursday Week 2 Lunch Small Frying', 2, 'Thursday', 'Lunch', 'Small Frying', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('tnxF9wJFNgZGEI9sFsPt', 'Wednesday Week 1 Midnight Snack Large', 1, 'Wednesday', 'Midnight Snack', 'Large', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('ToIYv0x6unHjGMWvxRGV', 'Monday Week 3 Lunch Medium Frying', 3, 'Monday', 'Lunch', 'Medium Frying', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('TP0GiMDES3gkQRFO8J66', 'Thursday Week 1 Midnight Snack Medium', 1, 'Thursday', 'Midnight Snack', 'Medium', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('trvvGjzuuY268OaRWZGJ', 'Tuesday Week 4 Midnight Lunch XL', 4, 'Tuesday', 'Midnight Lunch', 'XL', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('ttHWBxolUFJDa6Z7wguT', 'Saturday Week 3 Lunch Medium Frying', 3, 'Saturday', 'Lunch', 'Medium Frying', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('tTtommRcZ4InafOSQtay', 'Sunday Week 1 Bfast Small', 1, 'Sunday', 'Breakfast', 'Small', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('TUS120Sj54gQsJKah9Bl', 'Sunday Week 2 Midnight Snack Medium Frying', 2, 'Sunday', 'Midnight Snack', 'Medium Frying', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('TVIuJFGVbK8rBwpq5S5y', 'Monday Week 3 Snack Small', 3, 'Monday', 'Snack', 'Small', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('TVU3TtnNjej61SnUo119', 'Sunday Week 3 Bfast XL', 3, 'Sunday', 'Breakfast', 'XL', '2025-05-07 17:28:59', '2025-05-07 17:28:59'),
('tVZtRnn2KxjOPLc15aBZ', 'Tuesday Week 1 Lunch XL', 1, 'Tuesday', 'Lunch', 'XL', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('TW8ySILUsnvNtIYvHFUz', 'Friday Week 3 Bfast Small', 3, 'Friday', 'Breakfast', 'Small', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('TZhMMFMkGRTYPd9u4zx0', 'Friday Week 3 Midnight Snack Medium', 3, 'Friday', 'Midnight Snack', 'Medium', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('u0LV19vBR8EkV3UzPBeh', 'Wednesday Week 4 Lunch Small', 4, 'Wednesday', 'Lunch', 'Small', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('U0Yl5Eg5BnbkwP9WYM8I', 'Thursday Week 4 Bfast Medium', 4, 'Thursday', 'Breakfast', 'Medium', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('U10pfO9xTFf80mjEQHDq', 'Friday Week 4 Dinner Medium', 4, 'Friday', 'Dinner', 'Medium', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('u2LaXO3ZCAvcSwAnHTJc', 'Saturday Week 4 Midnight Snack Medium Frying', 4, 'Saturday', 'Midnight Snack', 'Medium Frying', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('U2wBcLMykvOipaDGusdk', 'Monday Week 2 Midnight Snack XL', 2, 'Monday', 'Midnight Snack', 'XL', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('U5b9A6EQrPz2ux1SE0Vz', 'Thursday Week 3 Snack Medium Frying', 3, 'Thursday', 'Snack', 'Medium Frying', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('u87P080d4z6QHAWMSkTo', 'Thursday Week 1 Bfast Small', 1, 'Thursday', 'Breakfast', 'Small', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('U9cLmAY9wTUK6HiaYpJF', 'Wednesday Week 2 Midnight Snack Medium Frying', 2, 'Wednesday', 'Midnight Snack', 'Medium Frying', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('uA7UuUWBjGarZy3GW0oj', 'Tuesday Week 2 Bfast Medium Frying', 2, 'Tuesday', 'Breakfast', 'Medium Frying', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('Ub5htsJwLCTTldbZfG4n', 'Wednesday Week 4 Midnight Lunch Small Frying', 4, 'Wednesday', 'Midnight Lunch', 'Small Frying', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('uCKJAAzJK7vgRrGkZQll', 'Friday Week 1 Midnight Lunch XL', 1, 'Friday', 'Midnight Lunch', 'XL', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('UcVgmjHQdUQTyL2getBO', 'Tuesday Week 3 Bfast Small', 3, 'Tuesday', 'Breakfast', 'Small', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('uD9lYUTilKaenIanSDfb', 'Saturday Week 3 Dinner XL', 3, 'Saturday', 'Dinner', 'XL', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('uGpO2R4QjHXN8ZQStRJQ', 'Sunday Week 3 Lunch Medium', 3, 'Sunday', 'Lunch', 'Medium', '2025-05-07 17:28:59', '2025-05-07 17:28:59'),
('UHludv3UuZnBCABI56mr', 'Wednesday Week 2 Lunch Medium', 2, 'Wednesday', 'Lunch', 'Medium', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('uhWe7HisH4lqk9rveln4', 'Thursday Week 4 Lunch Small', 4, 'Thursday', 'Lunch', 'Small', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('Uj1CSSRwbcfEszDjjj1D', 'Tuesday Week 3 Snack XL', 3, 'Tuesday', 'Snack', 'XL', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('umVFp8KZdUPrXBeKrXyN', 'Sunday Week 1 Snack Medium', 1, 'Sunday', 'Snack', 'Medium', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('uNl74dlCkFq44QzP4X92', 'Monday Week 4 Bfast Medium', 4, 'Monday', 'Breakfast', 'Medium', '2025-05-10 07:48:52', '2025-05-10 07:48:52'),
('uP0pra0qPdLoEaSPlhGe', 'Wednesday Week 2 Snack Small', 2, 'Wednesday', 'Snack', 'Small', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('uQEhfi4cakBH02psFqhT', 'Friday Week 4 Lunch Medium Frying', 4, 'Friday', 'Lunch', 'Medium Frying', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('uR0NamYCpc1w7HM5b6bS', 'Friday Week 2 Midnight Snack Medium', 2, 'Friday', 'Midnight Snack', 'Medium', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('uTshgQpTBOqvdE87xYOZ', 'Friday Week 4 Snack Medium Frying', 4, 'Friday', 'Snack', 'Medium Frying', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('UvFJZ0JdAKS9gO76gPQ6', 'Tuesday Week 3 Snack Small Frying', 3, 'Tuesday', 'Snack', 'Small Frying', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('UxdQQxMysmvoK6okOgZt', 'Wednesday Week 1 Lunch Small Frying', 1, 'Wednesday', 'Lunch', 'Small Frying', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('uyXashmSVmXaiq6X2YF2', 'Wednesday Week 2 Midnight Lunch Medium Frying', 2, 'Wednesday', 'Midnight Lunch', 'Medium Frying', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('UzeohY3TgAI8S0NX5A04', 'Thursday Week 3 Bfast Large', 3, 'Thursday', 'Breakfast', 'Large', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('uzy0QAQQEKprNJUUecYs', 'Friday Week 4 Bfast Medium', 4, 'Friday', 'Breakfast', 'Medium', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('v0QVsm3QHKOlTEnITdQb', 'Thursday Week 4 Snack XL', 4, 'Thursday', 'Snack', 'XL', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('V2R6mV8HxRSxXTVtCQRR', 'Wednesday Week 1 Dinner XL', 1, 'Wednesday', 'Dinner', 'XL', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('V5DkQPF8c5wAjrsDSgOJ', 'Tuesday Week 4 Dinner Small Frying', 4, 'Tuesday', 'Dinner', 'Small Frying', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('V6FF73U8zL9AbN89MBQx', 'Friday Week 2 Midnight Snack Large', 2, 'Friday', 'Midnight Snack', 'Large', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('VbWkux5VsrgVWe7HjOFc', 'Wednesday Week 1 Dinner Medium', 1, 'Wednesday', 'Dinner', 'Medium', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('VD0O3FBxlz4P0piIYavx', 'Wednesday Week 3 Dinner Small Frying', 3, 'Wednesday', 'Dinner', 'Small Frying', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('VdfpY6QqLpvA2szp1vk1', 'Monday Week 3 Midnight Snack Small Frying', 3, 'Monday', 'Midnight Snack', 'Small Frying', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('VDGN7pB9XLQOTUrmIhJz', 'Wednesday Week 4 Midnight Lunch Medium', 4, 'Wednesday', 'Midnight Lunch', 'Medium', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('vdpK5dm4i0AxZZgqxCwr', 'Monday Week 4 Snack Small', 4, 'Monday', 'Snack', 'Small', '2025-05-10 07:48:52', '2025-05-10 07:48:52'),
('VE40sFkSbwcJ1PDgvGyP', 'Friday Week 3 Bfast XL', 3, 'Friday', 'Breakfast', 'XL', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('VeQ0zz2xNhbbFGCXoUEI', 'Saturday Week 2 Midnight Snack Medium Frying', 2, 'Saturday', 'Midnight Snack', 'Medium Frying', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('veYDw9cNAEyfVVItZixa', 'Tuesday Week 2 Bfast Medium', 2, 'Tuesday', 'Breakfast', 'Medium', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('Vf62KRXRtF2aloqqOwPy', 'Monday Week 1 Lunch Large', 1, 'Monday', 'Lunch', 'Large', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('vFEQpjpD5LDjAEb9KpUE', 'Monday Week 3 Midnight Lunch Small', 3, 'Monday', 'Midnight Lunch', 'Small', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('vhFy1ie5KTuNjPXNipTn', 'Sunday Week 1 Midnight Snack Small', 1, 'Sunday', 'Midnight Snack', 'Small', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('vJGPClx4jlRpzx8RaCUK', 'Tuesday Week 4 Midnight Lunch Medium', 4, 'Tuesday', 'Midnight Lunch', 'Medium', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('VJlOqwbe5HMPxhH3y4mx', 'Saturday Week 3 Midnight Snack Medium', 3, 'Saturday', 'Midnight Snack', 'Medium', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('Vl8olnh9rWinXhNIEHvi', 'Thursday Week 4 Dinner Medium Frying', 4, 'Thursday', 'Dinner', 'Medium Frying', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('vlE6dB4VwRf8Si9gkYGw', 'Monday Week 3 Bfast Small', 3, 'Monday', 'Breakfast', 'Small', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('VLSczCNVhUruuai7eeH3', 'Thursday Week 4 Midnight Snack XL', 4, 'Thursday', 'Midnight Snack', 'XL', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('VN1E0C89n7GPS5TyuTjo', 'Thursday Week 2 Dinner Small Frying', 2, 'Thursday', 'Dinner', 'Small Frying', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('vn1E3uV3jWF3aBJ8ibvk', 'Monday Week 2 Snack Medium', 2, 'Monday', 'Snack', 'Medium', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('Vn7qW1ar4aKVSrQxkzdU', 'Friday Week 4 Lunch Small Frying', 4, 'Friday', 'Lunch', 'Small Frying', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('VnlLDPjq2Xgs7GQQdDm3', 'Wednesday Week 3 Dinner Small', 3, 'Wednesday', 'Dinner', 'Small', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('vOp2gyqWcNoYo8Fx4PK9', 'Saturday Week 2 Dinner Large', 2, 'Saturday', 'Dinner', 'Large', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('VRJuBX579nNOarfIqt0l', 'Tuesday Week 3 Bfast Medium Frying', 3, 'Tuesday', 'Breakfast', 'Medium Frying', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('Vs9vs19hA2SqbNW5kAnh', 'Thursday Week 1 Snack XL', 1, 'Thursday', 'Snack', 'XL', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('vwfcDsmmUy3mcAem3z7L', 'Monday Week 1 Snack XL', 1, 'Monday', 'Snack', 'XL', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('VWHSRYexPsDSfw3GQbVP', 'Wednesday Week 3 Lunch Medium', 3, 'Wednesday', 'Lunch', 'Medium', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('vx2uIvhAtnlJQjhucnxk', 'Saturday Week 4 Snack Small Frying', 4, 'Saturday', 'Snack', 'Small Frying', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('VxM4lwSgfJEcj4MM4Eba', 'Sunday Week 3 Midnight Lunch Small Frying', 3, 'Sunday', 'Midnight Lunch', 'Small Frying', '2025-05-07 17:29:00', '2025-05-07 17:29:00'),
('w3Wgnsbf13U4C3GVr089', 'Saturday Week 1 Lunch Small', 1, 'Saturday', 'Lunch', 'Small', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('w4ajjlLeFXwmtoXU0pHc', 'Thursday Week 2 Midnight Lunch Small', 2, 'Thursday', 'Midnight Lunch', 'Small', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('w5tCrQYZcbmz0J5RgGvr', 'Saturday Week 4 Midnight Snack Medium', 4, 'Saturday', 'Midnight Snack', 'Medium', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('w5wtCPlOMLVz4w7h3mrG', 'Saturday Week 3 Dinner Small', 3, 'Saturday', 'Dinner', 'Small', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('W9YopToBm1hJYFa8WszL', 'Friday Week 2 Dinner XL', 2, 'Friday', 'Dinner', 'XL', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('WawhzXcQAEF3uIGKdv9k', 'Tuesday Week 4 Snack Large', 4, 'Tuesday', 'Snack', 'Large', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('Wb9JRhWJSiFrWTEvA7J9', 'Tuesday Week 2 Midnight Lunch Small Frying', 2, 'Tuesday', 'Midnight Lunch', 'Small Frying', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('WCnV7T4Qr2J9KWLdCzrU', 'Monday Week 1 Snack Large', 1, 'Monday', 'Snack', 'Large', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('WDd2Ewau4BFgd1Ah7NJl', 'Wednesday Week 2 Snack Medium', 2, 'Wednesday', 'Snack', 'Medium', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('wDPbz740VLXmZGzZtaRi', 'Saturday Week 1 Lunch Medium', 1, 'Saturday', 'Lunch', 'Medium', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('wdwg0uWUdT9K3aROENMh', 'Monday Week 4 Midnight Snack Medium Frying', 4, 'Monday', 'Midnight Snack', 'Medium Frying', '2025-05-10 07:48:53', '2025-05-10 07:48:53'),
('wf9iLVwFiaCyVGMlvFWg', 'Tuesday Week 2 Snack Large', 2, 'Tuesday', 'Snack', 'Large', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('WflrgESEvwZUtDKdIXXz', 'Monday Week 2 Dinner Small', 2, 'Monday', 'Dinner', 'Small', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('WFu6Kve6JRINoK2CeTet', 'Tuesday Week 1 Lunch Medium', 1, 'Tuesday', 'Lunch', 'Medium', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('WGihnJg3EpJ00ReZUCAU', 'Sunday Week 2 Midnight Snack Small', 2, 'Sunday', 'Midnight Snack', 'Small', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('WgLKncZNKc3v6K0HNd3j', 'Saturday Week 3 Lunch Small Frying', 3, 'Saturday', 'Lunch', 'Small Frying', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('wh1TFjVLGOFL51NtuYOc', 'Monday Week 1 Snack Small Frying', 1, 'Monday', 'Snack', 'Small Frying', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('whKgobFkUnUyxa8UgGod', 'Wednesday Week 1 Dinner Medium Frying', 1, 'Wednesday', 'Dinner', 'Medium Frying', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('wIrtyC2hwMQkrK7e5IYC', 'Sunday Week 1 Bfast Large', 1, 'Sunday', 'Breakfast', 'Large', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('WIZSIDxeYnKVaRWAZMPL', 'Thursday Week 2 Lunch Medium', 2, 'Thursday', 'Lunch', 'Medium', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('Wj9I6EfxU4vAkCx1hQZ7', 'Monday Week 3 Bfast Small Frying', 3, 'Monday', 'Breakfast', 'Small Frying', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('WJTiTRH1O1flNHdfb9to', 'Sunday Week 4 Lunch Large', 4, 'Sunday', 'Lunch', 'Large', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('wJvJAthmfjqCziiW1tDQ', 'Wednesday Week 4 Lunch Medium Frying', 4, 'Wednesday', 'Lunch', 'Medium Frying', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('wkRcpFdEM5NDnuGdz8TJ', 'Thursday Week 1 Dinner Medium', 1, 'Thursday', 'Dinner', 'Medium', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('wl9AmTQK9a1PxgB2OqSY', 'Tuesday Week 2 Lunch Small', 2, 'Tuesday', 'Lunch', 'Small', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('WLNvxYk0YOrmA0oIRBun', 'Friday Week 3 Dinner Large', 3, 'Friday', 'Dinner', 'Large', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('WLrnaShgIR0n4Uxc9wJr', 'Wednesday Week 1 Lunch Large', 1, 'Wednesday', 'Lunch', 'Large', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('WMlGcyfNclUUJN9XTUkA', 'Tuesday Week 4 Midnight Snack XL', 4, 'Tuesday', 'Midnight Snack', 'XL', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('wnosRv3ZQOwsbzM7N9k0', 'Tuesday Week 2 Midnight Lunch XL', 2, 'Tuesday', 'Midnight Lunch', 'XL', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('WoSmkvv6tV00cDvEjmYX', 'Monday Week 4 Lunch Medium Frying', 4, 'Monday', 'Lunch', 'Medium Frying', '2025-05-10 07:48:52', '2025-05-10 07:48:52'),
('wpst4YY2FKkPP3j2OLsT', 'Wednesday Week 1 Midnight Snack Medium Frying', 1, 'Wednesday', 'Midnight Snack', 'Medium Frying', '2025-05-07 08:02:19', '2025-05-07 08:02:19'),
('wQm0sOiOkTP4HSbygTZh', 'Friday Week 2 Bfast Small', 2, 'Friday', 'Breakfast', 'Small', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('wqmRLhUnQfvokC2kazHx', 'Sunday Week 2 Midnight Snack XL', 2, 'Sunday', 'Midnight Snack', 'XL', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('wTjAYdEmjkxRJZZyvP7T', 'Thursday Week 3 Midnight Lunch Medium Frying', 3, 'Thursday', 'Midnight Lunch', 'Medium Frying', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('WtqyT90sWk5RDPRdWfaT', 'Thursday Week 1 Midnight Snack Large', 1, 'Thursday', 'Midnight Snack', 'Large', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('WTs05rGn2dqk1kCbGOjf', 'Monday Week 3 Midnight Lunch XL', 3, 'Monday', 'Midnight Lunch', 'XL', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('wTXoUF5dzbCexrD76sF2', 'Tuesday Week 2 Lunch Medium', 2, 'Tuesday', 'Lunch', 'Medium', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('wuU0r6h9AiYjsx0qwFiX', 'Sunday Week 3 Midnight Lunch Large', 3, 'Sunday', 'Midnight Lunch', 'Large', '2025-05-07 17:29:00', '2025-05-07 17:29:00'),
('wvaWfsz3ZpScPuoUSkFO', 'Thursday Week 3 Lunch Medium Frying', 3, 'Thursday', 'Lunch', 'Medium Frying', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('wwumkQZGI6dakiUkpKiS', 'Monday Week 4 Dinner Medium', 4, 'Monday', 'Dinner', 'Medium', '2025-05-10 07:48:52', '2025-05-10 07:48:52'),
('wxYnP7X5d4qOyY2tup6U', 'Sunday Week 2 Dinner Large', 2, 'Sunday', 'Dinner', 'Large', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('WZ2qdRFRSWXgvoqfRPTT', 'Wednesday Week 3 Midnight Snack Medium Frying', 3, 'Wednesday', 'Midnight Snack', 'Medium Frying', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('wzT71QAl0BcmiomTzZXs', 'Friday Week 2 Lunch Large', 2, 'Friday', 'Lunch', 'Large', '2025-05-07 08:03:59', '2025-05-07 08:03:59'),
('x06uchURZfoMw3DuyPxa', 'Sunday Week 3 Dinner XL', 3, 'Sunday', 'Dinner', 'XL', '2025-05-07 17:28:59', '2025-05-07 17:28:59'),
('X0o50uA3pic66yXm48Jg', 'Friday Week 4 Dinner Small', 4, 'Friday', 'Dinner', 'Small', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('x46It8HZHbs94rlrGQZB', 'Monday Week 1 Bfast Medium Frying', 1, 'Monday', 'Breakfast', 'Medium Frying', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('x5i4yTj2r1ewXoDCKdET', 'Monday Week 2 Bfast XL', 2, 'Monday', 'Breakfast', 'XL', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('X5wR54cnVO2ni5MaLwSq', 'Wednesday Week 4 Lunch Large', 4, 'Wednesday', 'Lunch', 'Large', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('X6CDOSLmVZllDFyymaOW', 'Thursday Week 4 Midnight Snack Small Frying', 4, 'Thursday', 'Midnight Snack', 'Small Frying', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('X6mUyh6BLcWAhHnPdxFP', 'Sunday Week 3 Bfast Large', 3, 'Sunday', 'Breakfast', 'Large', '2025-05-07 17:28:59', '2025-05-07 17:28:59'),
('X8yFhhHiw665gmqHskx9', 'Monday Week 1 Lunch Small', 1, 'Monday', 'Lunch', 'Small', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('xAi1KMDTTaRWRXWNhJoP', 'Friday Week 4 Midnight Snack Small Frying', 4, 'Friday', 'Midnight Snack', 'Small Frying', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('xaNHP6dbNy9YMOJrtpLv', 'Tuesday Week 1 Midnight Snack Small Frying', 1, 'Tuesday', 'Midnight Snack', 'Small Frying', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('xbFthudmRVgW1jSK1Zem', 'Wednesday Week 3 Dinner Medium', 3, 'Wednesday', 'Dinner', 'Medium', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('xBjlR9Ak3Rf5NTsDFlWY', 'Tuesday Week 1 Dinner Small', 1, 'Tuesday', 'Dinner', 'Small', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('XBNarjFB10Ki6ZTCX5mI', 'Wednesday Week 3 Midnight Lunch Small Frying', 3, 'Wednesday', 'Midnight Lunch', 'Small Frying', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('XcHVoOH6yTWGyFGQcjrj', 'Monday Week 4 Midnight Lunch Small', 4, 'Monday', 'Midnight Lunch', 'Small', '2025-05-10 07:48:53', '2025-05-10 07:48:53'),
('xd5g5sNTJyx3evUurSHJ', 'Tuesday Week 1 Midnight Snack Medium', 1, 'Tuesday', 'Midnight Snack', 'Medium', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('Xd9T9B4APoJwjyVw82lo', 'Saturday Week 2 Midnight Lunch Medium Frying', 2, 'Saturday', 'Midnight Lunch', 'Medium Frying', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('xdblphPB8AYa0frm3Pyb', 'Sunday Week 2 Lunch Small Frying', 2, 'Sunday', 'Lunch', 'Small Frying', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('XEBWJf7PsfT2A206TMDQ', 'Saturday Week 4 Lunch Small Frying', 4, 'Saturday', 'Lunch', 'Small Frying', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('xEHb8yGufFm8JHyziYrr', 'Friday Week 3 Dinner Medium', 3, 'Friday', 'Dinner', 'Medium', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('XeKdSym4mo78jpOooXst', 'Saturday Week 1 Snack XL', 1, 'Saturday', 'Snack', 'XL', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('XgQh0jJgLqLCEQ9DhiJP', 'Tuesday Week 3 Midnight Snack Small', 3, 'Tuesday', 'Midnight Snack', 'Small', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('xGWK0w4NJMZqUXAHw4so', 'Friday Week 1 Snack Medium Frying', 1, 'Friday', 'Snack', 'Medium Frying', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('xHmPw3moi6vRGVDJwF59', 'Sunday Week 3 Bfast Small Frying', 3, 'Sunday', 'Breakfast', 'Small Frying', '2025-05-07 17:28:59', '2025-05-07 17:28:59'),
('XhPk0sbV7lQ2E8QDr8hd', 'Wednesday Week 3 Snack XL', 3, 'Wednesday', 'Snack', 'XL', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('Xhv7bdKeFO0Xz9q9wFNa', 'Saturday Week 2 Snack Small Frying', 2, 'Saturday', 'Snack', 'Small Frying', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('xhzDR30m0ULAqOi7Xvyf', 'Sunday Week 3 Dinner Large', 3, 'Sunday', 'Dinner', 'Large', '2025-05-07 17:28:59', '2025-05-07 17:28:59'),
('xHzX1THMWPY4ZfJohU2w', 'Thursday Week 4 Lunch Small Frying', 4, 'Thursday', 'Lunch', 'Small Frying', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('xIvPfPSHLIlHIvywK5oq', 'Wednesday Week 2 Midnight Snack Small', 2, 'Wednesday', 'Midnight Snack', 'Small', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('XKD7HbJQRzk4sMoKob5F', 'Saturday Week 1 Dinner Small Frying', 1, 'Saturday', 'Dinner', 'Small Frying', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('XknqBRtv5bpLv7kHNdfb', 'Friday Week 1 Bfast Small Frying', 1, 'Friday', 'Breakfast', 'Small Frying', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('XMkWemX1DTw55NwKFkin', 'Saturday Week 3 Midnight Snack Small Frying', 3, 'Saturday', 'Midnight Snack', 'Small Frying', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('XNPKkq1PGlFCGYWbe2fF', 'Saturday Week 3 Lunch Small', 3, 'Saturday', 'Lunch', 'Small', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('XOeGigzyG7Vgfg0Xt4PY', 'Wednesday Week 4 Snack Small', 4, 'Wednesday', 'Snack', 'Small', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('xoJoWOA5pb76OGA74N3O', 'Sunday Week 2 Snack XL', 2, 'Sunday', 'Snack', 'XL', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('XQUlC2wwgiURzlCig7PA', 'Wednesday Week 2 Dinner Large', 2, 'Wednesday', 'Dinner', 'Large', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('XT2b3WAIX7AIT9qI10Gj', 'Monday Week 2 Snack Small', 2, 'Monday', 'Snack', 'Small', '2025-05-07 08:04:04', '2025-05-07 08:04:04'),
('xXqje85NK5iqqIPgz8nB', 'Wednesday Week 2 Midnight Snack Small Frying', 2, 'Wednesday', 'Midnight Snack', 'Small Frying', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('xxWBJI6GwEu70pSLf0jH', 'Monday Week 4 Lunch XL', 4, 'Monday', 'Lunch', 'XL', '2025-05-10 07:48:52', '2025-05-10 07:48:52'),
('XY34IL15HjCvCS3RQTgZ', 'Sunday Week 3 Midnight Snack Medium', 3, 'Sunday', 'Midnight Snack', 'Medium', '2025-05-07 17:29:00', '2025-05-07 17:29:00'),
('Xy7nJBBWe5Eq9T9gPeEl', 'Sunday Week 4 Snack Small', 4, 'Sunday', 'Snack', 'Small', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('xYCFbyTEsfO5r41O1rEo', 'Wednesday Week 2 Dinner Small', 2, 'Wednesday', 'Dinner', 'Small', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('xYCFd5kYRKENQQvopOHg', 'Thursday Week 1 Dinner Medium Frying', 1, 'Thursday', 'Dinner', 'Medium Frying', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('xyGf00VspJBDOSHEjkgb', 'Wednesday Week 4 Midnight Lunch Small', 4, 'Wednesday', 'Midnight Lunch', 'Small', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('xyTw8jFwiYi3ZSvub0JT', 'Friday Week 4 Dinner Medium Frying', 4, 'Friday', 'Dinner', 'Medium Frying', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('y2dF1HkrgZ0c359CjXWJ', 'Saturday Week 4 Dinner Small Frying', 4, 'Saturday', 'Dinner', 'Small Frying', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('y7LvjrOEJ55vMynxhe1O', 'Saturday Week 1 Snack Medium Frying', 1, 'Saturday', 'Snack', 'Medium Frying', '2025-05-07 08:01:56', '2025-05-07 08:01:56'),
('y9VcDjuKdTlskU6BgM8L', 'Monday Week 1 Midnight Lunch Small Frying', 1, 'Monday', 'Midnight Lunch', 'Small Frying', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('YAO4baBNrlo2cyc41UNm', 'Tuesday Week 4 Midnight Snack Medium', 4, 'Tuesday', 'Midnight Snack', 'Medium', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('YcMQkmyKusPqYdq87GW9', 'Sunday Week 3 Dinner Medium', 3, 'Sunday', 'Dinner', 'Medium', '2025-05-07 17:28:59', '2025-05-07 17:28:59'),
('Yf5nXj23sUqAWbBBMSPZ', 'Thursday Week 2 Bfast Small Frying', 2, 'Thursday', 'Breakfast', 'Small Frying', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('Yf9QBEuBooaU83qrAGqN', 'Monday Week 1 Midnight Lunch XL', 1, 'Monday', 'Midnight Lunch', 'XL', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('yfuhyKyC1CzBAhpjZB0y', 'Sunday Week 2 Dinner Small Frying', 2, 'Sunday', 'Dinner', 'Small Frying', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('YiaGpOku2ROZOUCa8s3B', 'Sunday Week 3 Midnight Snack Medium Frying', 3, 'Sunday', 'Midnight Snack', 'Medium Frying', '2025-05-07 17:29:00', '2025-05-07 17:29:00'),
('YklCBLvQUk5IjEMnJMWM', 'Thursday Week 1 Dinner XL', 1, 'Thursday', 'Dinner', 'XL', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('yNfdYQB15I41MiF5iZnL', 'Thursday Week 2 Snack Medium', 2, 'Thursday', 'Snack', 'Medium', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('YNSoUQS9yS48UNkh6ag2', 'Thursday Week 4 Midnight Lunch XL', 4, 'Thursday', 'Midnight Lunch', 'XL', '2025-05-10 07:49:23', '2025-05-10 07:49:23'),
('YoXgdOKWFlvl1gLJWeIn', 'Monday Week 1 Snack Medium', 1, 'Monday', 'Snack', 'Medium', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('yoynzN5QnAO3aI2G7LTE', 'Thursday Week 2 Lunch Medium Frying', 2, 'Thursday', 'Lunch', 'Medium Frying', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('yPdI109HkgtGNpiTcpnH', 'Saturday Week 3 Lunch Large', 3, 'Saturday', 'Lunch', 'Large', '2025-05-07 17:28:54', '2025-05-07 17:28:54'),
('YPDurPfXDPyenVNNshop', 'Thursday Week 1 Dinner Small', 1, 'Thursday', 'Dinner', 'Small', '2025-05-07 08:02:08', '2025-05-07 08:02:08'),
('yPiStRjBcUI5UQ17rMrs', 'Tuesday Week 2 Lunch Small Frying', 2, 'Tuesday', 'Lunch', 'Small Frying', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('ypwzpY0RIF5TezgOGoiP', 'Thursday Week 3 Dinner Medium', 3, 'Thursday', 'Dinner', 'Medium', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('YqSp3iefDyVYet5aoBcp', 'Wednesday Week 2 Bfast Large', 2, 'Wednesday', 'Breakfast', 'Large', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('YQv9flDzA87WYd1P1RCD', 'Saturday Week 4 Midnight Lunch Small', 4, 'Saturday', 'Midnight Lunch', 'Small', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('YSgUoJVK4OK2zFK6HEkW', 'Saturday Week 4 Snack XL', 4, 'Saturday', 'Snack', 'XL', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('ysIyz0ZjTNZaGuCVC1hQ', 'Friday Week 3 Dinner Small Frying', 3, 'Friday', 'Dinner', 'Small Frying', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('ytt8aaGfbQUP2eNadE7M', 'Monday Week 4 Midnight Snack Small', 4, 'Monday', 'Midnight Snack', 'Small', '2025-05-10 07:48:53', '2025-05-10 07:48:53'),
('yu69DmiHc0tETgKhuFDC', 'Friday Week 1 Lunch Small', 1, 'Friday', 'Lunch', 'Small', '2025-05-07 07:54:39', '2025-05-07 07:54:39'),
('yuIPtEWDP2IRIG5tT7Kw', 'Saturday Week 4 Midnight Snack Small', 4, 'Saturday', 'Midnight Snack', 'Small', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('Yxbu7lINIdxiZ38IJzQn', 'Sunday Week 1 Dinner Small', 1, 'Sunday', 'Dinner', 'Small', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('Z0qXtrAouQNvRJKuuqCa', 'Tuesday Week 1 Snack Large', 1, 'Tuesday', 'Snack', 'Large', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('Z4xRVj9RRJAJ4sp64kSt', 'Thursday Week 3 Bfast XL', 3, 'Thursday', 'Breakfast', 'XL', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('z5SfPV5PSxvZZ2RD7TZ9', 'Monday Week 1 Bfast Small Frying', 1, 'Monday', 'Breakfast', 'Small Frying', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('Z5xHFjhuteRFoMkpzZxQ', 'Friday Week 3 Midnight Lunch Medium', 3, 'Friday', 'Midnight Lunch', 'Medium', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('Z6qK96krXUhPzaY5Bg9W', 'Sunday Week 2 Midnight Lunch Small', 2, 'Sunday', 'Midnight Lunch', 'Small', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('Z7NFOylcTzXCuKrJmgDE', 'Wednesday Week 2 Lunch Small Frying', 2, 'Wednesday', 'Lunch', 'Small Frying', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('z9cP2ELJyAWoaZuFQYcZ', 'Sunday Week 1 Midnight Snack XL', 1, 'Sunday', 'Midnight Snack', 'XL', '2025-05-07 08:02:02', '2025-05-07 08:02:02'),
('z9hJqC4mnA68n6rLAFkH', 'Wednesday Week 3 Midnight Snack Medium', 3, 'Wednesday', 'Midnight Snack', 'Medium', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('Za8m3ntqg0xkZBRqcJX0', 'Friday Week 4 Bfast Small', 4, 'Friday', 'Breakfast', 'Small', '2025-05-09 06:36:09', '2025-05-09 06:36:09'),
('zbJ63mPIcKwmOMDhacxs', 'Wednesday Week 3 Snack Large', 3, 'Wednesday', 'Snack', 'Large', '2025-05-07 17:29:30', '2025-05-07 17:29:30'),
('zBVUsPjwOJnNvipMK6i5', 'Tuesday Week 3 Midnight Snack Medium Frying', 3, 'Tuesday', 'Midnight Snack', 'Medium Frying', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('zc8bL686kzHRQvEF29N2', 'Friday Week 3 Bfast Medium Frying', 3, 'Friday', 'Breakfast', 'Medium Frying', '2025-05-07 17:28:40', '2025-05-07 17:28:40'),
('zcdx7Rg4IOcTkmhBJCTM', 'Thursday Week 3 Midnight Lunch Large', 3, 'Thursday', 'Midnight Lunch', 'Large', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('ZdVrfmk6Rz8wrkRNRoMg', 'Monday Week 1 Dinner Medium Frying', 1, 'Monday', 'Dinner', 'Medium Frying', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('ZeK6ZL49n6AmRRDI3hzs', 'Tuesday Week 1 Bfast Small Frying', 1, 'Tuesday', 'Breakfast', 'Small Frying', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('Zekl7qmSPG9vMOC8g2DT', 'Saturday Week 4 Dinner Medium', 4, 'Saturday', 'Dinner', 'Medium', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('ZgobkQjcipy8RHCfYBjT', 'Thursday Week 3 Lunch Large', 3, 'Thursday', 'Lunch', 'Large', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('Zh6SZ21aDyuLx51DTXr6', 'Saturday Week 4 Midnight Lunch Small Frying', 4, 'Saturday', 'Midnight Lunch', 'Small Frying', '2025-05-10 07:49:07', '2025-05-10 07:49:07'),
('ZhN1A5fAW5anDqAU9fRs', 'Monday Week 4 Midnight Lunch Small Frying', 4, 'Monday', 'Midnight Lunch', 'Small Frying', '2025-05-10 07:48:53', '2025-05-10 07:48:53'),
('Zhog90J5AGgU7vQS5bvL', 'Monday Week 4 Midnight Lunch Medium Frying', 4, 'Monday', 'Midnight Lunch', 'Medium Frying', '2025-05-10 07:48:53', '2025-05-10 07:48:53'),
('ZiBEkJ0thsk8hNTtL8WG', 'Monday Week 1 Lunch Small Frying', 1, 'Monday', 'Lunch', 'Small Frying', '2025-05-07 08:01:49', '2025-05-07 08:01:49'),
('ZiLZDXGtdCV0UnESaazE', 'Monday Week 4 Bfast XL', 4, 'Monday', 'Breakfast', 'XL', '2025-05-10 07:48:52', '2025-05-10 07:48:52'),
('zISQrmcpHLIgZNFBThb0', 'Tuesday Week 3 Bfast Small Frying', 3, 'Tuesday', 'Breakfast', 'Small Frying', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('zjmbzoDYYkoktcLkGZB4', 'Tuesday Week 3 Lunch Small', 3, 'Tuesday', 'Lunch', 'Small', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('ZleM5keoV8omMG5bCVbl', 'Monday Week 3 Midnight Lunch Medium', 3, 'Monday', 'Midnight Lunch', 'Medium', '2025-05-07 17:28:46', '2025-05-07 17:28:46'),
('Zmp3oGrBhmr5cLGP64xJ', 'Wednesday Week 2 Midnight Lunch Large', 2, 'Wednesday', 'Midnight Lunch', 'Large', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('zNfLThDYMfyC8gP98Qvl', 'Tuesday Week 3 Snack Medium', 3, 'Tuesday', 'Snack', 'Medium', '2025-05-07 17:29:17', '2025-05-07 17:29:17'),
('ZnJhH0QafhBVZ52Hj1wi', 'Wednesday Week 4 Lunch XL', 4, 'Wednesday', 'Lunch', 'XL', '2025-05-10 07:49:37', '2025-05-10 07:49:37'),
('zp3A0ZELFRqM0CwAByNv', 'Wednesday Week 2 Bfast XL', 2, 'Wednesday', 'Breakfast', 'XL', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('ZpcyxOVOHwoL62bsVjZa', 'Sunday Week 2 Midnight Lunch Medium', 2, 'Sunday', 'Midnight Lunch', 'Medium', '2025-05-07 08:04:17', '2025-05-07 08:04:17'),
('ZqbHvitqD2edCVDeU47B', 'Tuesday Week 1 Bfast Large', 1, 'Tuesday', 'Breakfast', 'Large', '2025-05-07 08:02:14', '2025-05-07 08:02:14'),
('zqI5MczS8vpxEmofdN9r', 'Tuesday Week 2 Bfast Small Frying', 2, 'Tuesday', 'Breakfast', 'Small Frying', '2025-05-07 08:05:35', '2025-05-07 08:05:35'),
('ZqMYjFCPhJUDWzFJ34BF', 'Thursday Week 2 Midnight Snack Small Frying', 2, 'Thursday', 'Midnight Snack', 'Small Frying', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('ZQzgBGYJzz4uGNTqd1IM', 'Sunday Week 4 Midnight Lunch Small', 4, 'Sunday', 'Midnight Lunch', 'Small', '2025-05-10 07:49:17', '2025-05-10 07:49:17'),
('ZrSeE9vCLq1jreA7UnIO', 'Thursday Week 3 Snack Small', 3, 'Thursday', 'Snack', 'Small', '2025-05-07 17:29:11', '2025-05-07 17:29:11'),
('zRXV2c6939T7zc6l8luM', 'Sunday Week 3 Dinner Small Frying', 3, 'Sunday', 'Dinner', 'Small Frying', '2025-05-07 17:29:00', '2025-05-07 17:29:00'),
('zTqgXTyhxoxvjg2LOu2A', 'Tuesday Week 4 Midnight Lunch Small', 4, 'Tuesday', 'Midnight Lunch', 'Small', '2025-05-10 07:49:31', '2025-05-10 07:49:31'),
('zuAuvLZ6k8Fq8QyypoJ0', 'Saturday Week 2 Lunch Medium', 2, 'Saturday', 'Lunch', 'Medium', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('Zvxbiz3DoYr3SiHAjGs2', 'Saturday Week 2 Snack Medium', 2, 'Saturday', 'Snack', 'Medium', '2025-05-07 08:04:11', '2025-05-07 08:04:11'),
('ZYjPEnh7JDPw1T0F7pyx', 'Thursday Week 2 Midnight Lunch Medium Frying', 2, 'Thursday', 'Midnight Lunch', 'Medium Frying', '2025-05-07 08:05:30', '2025-05-07 08:05:30'),
('zYKat582oi7uBUSzRLMh', 'Monday Week 4 Lunch Large', 4, 'Monday', 'Lunch', 'Large', '2025-05-10 07:48:52', '2025-05-10 07:48:52'),
('ZyNUOCsUTyK4Thzsz4eK', 'Wednesday Week 2 Lunch XL', 2, 'Wednesday', 'Lunch', 'XL', '2025-05-07 08:05:41', '2025-05-07 08:05:41'),
('ZyvbQjV62sSGZvrHe6lb', 'Wednesday Week 1 Midnight Lunch Medium', 1, 'Wednesday', 'Midnight Lunch', 'Medium', '2025-05-07 08:02:19', '2025-05-07 08:02:19');

-- --------------------------------------------------------

--
-- Table structure for table `menu_dishes`
--

CREATE TABLE `menu_dishes` (
  `id` varchar(20) NOT NULL,
  `menu_id` varchar(20) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `odoo_name` varchar(255) NOT NULL,
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `unit_cost` double NOT NULL DEFAULT 0,
  `production` enum('Commis','Commis Cooked','On Site') NOT NULL,
  `status` enum('Active','Discontinued') NOT NULL DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_dishes`
--

INSERT INTO `menu_dishes` (`id`, `menu_id`, `name`, `odoo_name`, `category_id`, `unit_cost`, `production`, `status`, `created_at`, `updated_at`) VALUES
('01pmDEhZIHgkkUBIDoyA', 'JoVYhGkhMEJ1D6ecdqg8', 'Salad', 'CMC 3 Vegetables Regular : Ensaladang Labanos', 5, 12.98, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('0j6vlwN7aSC2dGLwDKqz', 'fi1KFSbrXq4tXIGToLyM', 'Vegetable Regular', 'CMC 3 Vegetables Regular : Gisadong Patola', 2, 10.63, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('0kHpPojlSFZpUNn1eU0g', 'dgvm2369GPnC3GFveBvz', 'Flavored Rice', 'Garlic Rice', 1, 4.85, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('0X8dC1xhhO8NTqaJWStb', 'eGJmJMai30b8eIXrKwTv', 'Dessert', 'Almond Jelly', 14, 16.3, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('127pbSKIPeZbNOpqBK8a', 'JOodb2wozWR6nZblQ2Dv', 'Salad', 'CMC 3 Vegetables Regular : Ensaladang Camote Tops', 5, 13.87, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('1DaO5zbedFmyWHYSlz67', '7ssOzWtm2AnIrKQXxrWd', 'Freshly Baked Breads', ' CMC BS : Pandesal ', 14, 2.49, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('1lZsuqRntmvRRMhKLELM', 'gFRfKNjtTFTrgBocJOqu', 'Pork Special', 'CMC 3 Pork Special : Pork Bicol Express', 3, 31, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('1mtTO5SFl8TlKbLQ3kQe', 'JoVYhGkhMEJ1D6ecdqg8', 'Cold Cuts', 'Fried Sweet Ham (2 Pcs)', 1, 13.01, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('1pRozcpyGcAkZ9PzNwfb', 'JOodb2wozWR6nZblQ2Dv', 'Canned Goods', 'Fried Spam', 1, 31.3, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('24YV33r6guY393EFxSIH', 'JoVYhGkhMEJ1D6ecdqg8', 'Breakfast Mainstay', 'Breakfast Cereals (Kokokrunch, Corn Flakes, Fruit Loops)', 14, 16.84, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('2casXHrhLASwfj56neT8', 'iYqp30ARkjoaTxtX4tsV', 'Vegetable Regular', 'CMC 3 Vegetables Regular : Gisadong Kalabasa At Sitaw', 2, 12.31, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('2lfUG8fWkbP0eP6ovJ6O', 'dgvm2369GPnC3GFveBvz', 'Pork Regular', 'CMC 3 Pork Regular : Pork Menudillo', 2, 26.27, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('2Qk9XjohMJNzYGGdYmuz', 'BUuDvkbONCbBbl0TksXB', 'Egg', 'Scrambled Egg W/ Ham', 1, 16.71, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('2wxPVA17knZicReHJ93R', 'tVZtRnn2KxjOPLc15aBZ', 'Seafood Special', 'CMC 3 Seafoods Special : Fish Fillet w/ Tofu & Black Beans Sauce', 1, 32.83, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('3LHyE9IfGSJqtHq13mMK', 'fD1vs3TASulIcnoduH95', 'Dessert', 'Banana', 6, 0, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('3N6HbhS0xlrsFpQq0d98', 'gFRfKNjtTFTrgBocJOqu', 'Pinoy Favorite Mainstay', 'Halo-Halo', 14, 19.12, 'On Site', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('3pezWatCCznTbKBY9mZu', 'fD1vs3TASulIcnoduH95', 'Breakfast Mainstay', 'Breakfast Cereals (Kokokrunch, Corn Flakes, Fruit Loops)', 14, 16.84, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('3qgTUD5VI6GehhGMDJLm', 'dgvm2369GPnC3GFveBvz', 'Breakfast Mainstay', 'Breakfast Cereals (Kokokrunch, Corn Flakes, Fruit Loops)', 14, 16.84, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('3rp7GQNXadklLljQF8D6', 'tVZtRnn2KxjOPLc15aBZ', 'Delicacies', 'Nilupak', 14, 5.55, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('3SGE6oxVnFINS76n9Eas', 'fD1vs3TASulIcnoduH95', 'Pork Regular', 'CMC 3 Pork Regular : Pork Meatballs w/ Sweet & Sour Sauce', 3, 27.36, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('3wB6KyiULLZaLeuk7p4r', 'BUuDvkbONCbBbl0TksXB', 'Breakfast Mainstay', 'Breakfast Cereals (Kokokrunch, Corn Flakes, Fruit Loops)', 14, 16.84, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('3Y6wRq7d2PBsnZGz2Gw7', 'R3zTKW8DNmK4oeqpm3is', 'Free Soup', 'Miswa Soup', 7, 1.64, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('3YZMdUGcGeeN8wQRC1lM', 'JoVYhGkhMEJ1D6ecdqg8', 'Plant Based', 'CMC 3 Plant Based : Corned Beef', 2, 35, 'Commis Cooked', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('429a89QToPlGSBAqqVqG', 'fD1vs3TASulIcnoduH95', 'Egg', 'Scrambled Egg W/ Potato', 1, 9.19, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('4AjdLsLHzvZXeqPwNSbS', 'tVZtRnn2KxjOPLc15aBZ', 'Flavored Rice', 'Yang Chow Fried Rice', 14, 8.51, 'On Site', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('4BVCUyMhY88SnxtE4abi', 'tVZtRnn2KxjOPLc15aBZ', 'Plant Based', 'CMC 3 Plant Based : Meatballs Teriyaki', 2, 35, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('4faZWStCyy1kniE7Lw3v', 'dgvm2369GPnC3GFveBvz', 'Egg', 'CMC 3 Egg : Poached Egg', 4, 7, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('4HZMCVUou4BIZhXORgAq', 'tVZtRnn2KxjOPLc15aBZ', 'Beef Executive', 'CMC 3 Beef Executive : Beef Caldereta w/ Black Olives', 3, 48.5, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('4iRZc55aGXKie8Cz1tNB', 'tVZtRnn2KxjOPLc15aBZ', 'Pinoy Favorite Mainstay', 'Halo-Halo', 14, 19.12, 'On Site', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('4jvhOvtOkDIDGiWdoCQm', 'fi1KFSbrXq4tXIGToLyM', 'Pinoy Favorite Mainstay', 'Fruit Cups', 14, 10.99, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('4WGRqrqhHmpVzLZFisCC', 'fi1KFSbrXq4tXIGToLyM', 'Seafood Regular', 'CMC 3 Seafoods Regular : Kinamatisang Hiwas', 2, 19.57, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('57wu0Jxh5oppW0m9rfge', 'R3zTKW8DNmK4oeqpm3is', 'Delicacies', 'CMC BS : Biko', 14, 12.31, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('5dY6fZw8Dd30dx6MB2bJ', 'iYqp30ARkjoaTxtX4tsV', 'Dessert', 'CMC BS : Fruit Salad', 14, 0, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('61f7FdAS9IYunPlTyFLN', 'eGJmJMai30b8eIXrKwTv', 'Vegetable Regular', 'CMC 3 Vegetables Regular : Gisadong Monggo w/ Ampalaya Leaves', 7, 10.13, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('6a1KmkJ7mMDf01OuegPQ', 'iYqp30ARkjoaTxtX4tsV', 'Pork Regular', 'CMC 3 Pork Regular : Pork Kilawin', 2, 16.15, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('6hOornWohwClCG106kmv', 'fwy0nczdnbPHTRK28OcS', 'Egg', 'CMC 3 Egg : Poached Egg', 4, 7, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('6IfycpZW9nLAbGqp0waZ', 'eGJmJMai30b8eIXrKwTv', 'Delicacies', 'Camote Butchi', 14, 0, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('6QuIe3fM6NBOwyAaygI0', 'blF0vfec3Ztu4AHEaoLa', 'Delicacies', 'CMC BS : Biko', 14, 12.31, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('6t9ur77CN4kBFVRvNHYm', 'eGJmJMai30b8eIXrKwTv', 'Chicken Regular', 'CMC 3 Chicken Regular : Sinampalukang Manok', 7, 24.48, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('6WPf9SoZIWvYtHR6VpLX', 'BUuDvkbONCbBbl0TksXB', 'Egg', 'CMC 3 Egg : Fried Egg', 1, 7.81, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('79Alt8tK54yCoYzR0uCl', 'dgvm2369GPnC3GFveBvz', 'Delicacies', 'CMC BS : Maja Ube', 14, 13.42, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('7Ncii549wZA7vgRK6aMr', 'dgvm2369GPnC3GFveBvz', 'Delicacies', 'Bibingka Bigas', 14, 0, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('7P4VtFtyvBMbmuziQWH8', 'iYqp30ARkjoaTxtX4tsV', 'Pork Special', 'CMC 3 Pork Special : Pork Nilaingan', 3, 33.17, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('7rAziybqSZXpFLFu9fpW', 'tVZtRnn2KxjOPLc15aBZ', 'Dessert', ' CMC BS : Leche Flan ', 14, 11.67, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('7UsCl8mhFulzvacRDKNY', '7ssOzWtm2AnIrKQXxrWd', 'Vegetable Regular', 'CMC 3 Vegetables Regular : Gisadong Sardines w/ Papaya', 2, 10.4, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('7vLKnizPK5RVwPjfxByL', 'JOodb2wozWR6nZblQ2Dv', 'Pork Regular', 'CMC 3 Pork Regular : Tokwat Baboy', 2, 23.51, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('7VNb078TKOEFQ4wVrl5Q', 'eGJmJMai30b8eIXrKwTv', 'Chicken Executive', 'CMC 3 Chicken Executive : Chicken Breast w/ Caper Cream Sauce', 17, 38.06, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('8hBMmGDse0ARcnIIVWE9', 'gFRfKNjtTFTrgBocJOqu', 'Vegetable Executive', 'CMC 3 Vegetables Special : Chopsuey w/ Quail Egg', 2, 17.45, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('8jS0N2kiN11YlmsFqRum', 'JOodb2wozWR6nZblQ2Dv', 'Dessert', 'Apple', 6, 0, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('8jY6fkG3VWCpMViZztdP', 'BUuDvkbONCbBbl0TksXB', 'Cold Cuts', 'Frank Further', 1, 50.85, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('8K3UYR1U26RPlI8LFHbk', 'dgvm2369GPnC3GFveBvz', 'Free Soup', 'Sinigang Soup', 7, 79.92, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('8oaSKkHmg4D8x4slMK9L', 'JoVYhGkhMEJ1D6ecdqg8', 'Egg', 'Scrambled Egg W/ Hotdog', 1, 13.09, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('8SmUyECm7JSsQztGlzie', 'fi1KFSbrXq4tXIGToLyM', 'On The Spot', 'Pork', 14, 26.98, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('8vBjeOGzgwSqCVTKkLkM', 'R3zTKW8DNmK4oeqpm3is', 'Seafood Regular', 'CMC 3 Seafoods Regular : Escabecheng Hasa-Hasa', 3, 24.83, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('975qr4uFu34MadssGsQU', 'tVZtRnn2KxjOPLc15aBZ', 'Vegetable Regular', 'CMC 3 Vegetables Regular : Gisadong Kalabasa At Sayote', 2, 8.47, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('98okhN0stkWqnSF5jANV', 'fD1vs3TASulIcnoduH95', 'Delicacies', 'Bibingka Bigas', 14, 0, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('99JA1NgF5tkeJQL3lXZR', 'tVZtRnn2KxjOPLc15aBZ', 'Chicken Special', 'CMC 3 Chicken Special : Chicken Marengo', 11, 25.29, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('9CCgyC8T6rFEnWqAJT5T', 'fD1vs3TASulIcnoduH95', 'Canned Goods', 'CMC 3 Coldcuts : Luncheon Meat', 1, 16.15, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('9nck5DS0V44Tq7SH859w', 'eGJmJMai30b8eIXrKwTv', 'Vegetable Special', 'CMC 3 Vegetables Regular : Ginataang Kalabasa At Malunggay', 16, 13.81, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('9P11Nx7Mgq00KGahHoFd', 'fD1vs3TASulIcnoduH95', 'Freshly Baked Breads', 'CMC BS: Malunggay Pandesal', 13, 3.18, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('9QL1mzVVtrX6yHYk7clo', 'JoVYhGkhMEJ1D6ecdqg8', 'Dessert', 'Orange', 6, 0, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('9RmueObxe0SOraHZ9JfU', 'JOodb2wozWR6nZblQ2Dv', 'Chicken Regular', 'CMC 3 Chicken Regular : Chicken Torta', 1, 16.37, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('9Z9FZuIpFijb3D2RhnG5', 'tVZtRnn2KxjOPLc15aBZ', 'Delicacies', ' CMC BS : Pichi Pichi ', 14, 10.5, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('AgJw90QS6TWdKWlkMpwD', 'dgvm2369GPnC3GFveBvz', 'Freshly Baked Breads', 'CMC BS: Malunggay Pandesal', 14, 3.18, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('akDT76NRKbFHjjE4Dy0a', 'JOodb2wozWR6nZblQ2Dv', 'Egg', 'CMC 3 Egg : Poached Egg', 4, 7, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('AkJvEXNfWDzRtLPtUwBt', 'gFRfKNjtTFTrgBocJOqu', 'Dessert', 'CMC BS : Fruit Tart', 14, 7.04, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('aP072Db5VyBZYZl3E22J', 'R3zTKW8DNmK4oeqpm3is', 'Chicken Regular', 'CMC 3 Chicken Regular : Giniling Na Manok w/ Potato', 2, 14.82, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('ARpnSvfphmueqhs5pSkE', 'gFRfKNjtTFTrgBocJOqu', 'Vegetable Special', 'CMC 3 Vegetables Regular : Ginataang Kalabasa At Sitaw', 2, 13.89, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('AUm7TOkOflHxWeioRvG7', 'tVZtRnn2KxjOPLc15aBZ', 'Plant Based', 'CMC 3 Plant Based : Meatballs W/ Sweet & Sour Sauce', 2, 35, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('AZceeAxn7DYKGjawzs98', 'eGJmJMai30b8eIXrKwTv', 'Beef Special', 'CMC 3 Beef Executive : Beef Kare-Kare', 3, 42.32, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('B0ZWwPYNVtd9LmtzjgwT', 'blF0vfec3Ztu4AHEaoLa', 'Vegetable Executive', 'CMC 3 Vegetables Special : Herbed Roasted Vegetabless', 11, 16.26, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('b47ByPR10hGM49bfictj', 'fwy0nczdnbPHTRK28OcS', 'Vegetable Regular', 'CMC 3 Vegetables Regular : Gisadong Papaya', 2, 7.24, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('b8TAOJub9ER6H0SvVlLm', 'JOodb2wozWR6nZblQ2Dv', 'Flavored Rice', 'Garlic Rice', 1, 4.85, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('bckO6pITtNbMExZ6tN0g', 'BUuDvkbONCbBbl0TksXB', 'Flavored Rice', 'Garlic Rice', 1, 4.85, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('bDCbVPBCKsANUh7iBfZW', 'R3zTKW8DNmK4oeqpm3is', 'Chicken Special', 'CMC 3 Chicken Special : Baked Chicken w/ Marinara Sauce', 13, 27.36, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('bgmEZMUxNljrIXlsZ6pr', 'fwy0nczdnbPHTRK28OcS', 'Chicken Regular', 'CMC 3 Coldcuts : Fried Chicken Nuggets', 1, 8.6, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('BHNn193kLM3H9NfDDVaA', 'blF0vfec3Ztu4AHEaoLa', 'Salad', 'Tossed Mixed Greens w/ Roasted Sesame Dressing', 5, 33.5, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('BjS1DsVIkACYI2G6qjKp', 'iYqp30ARkjoaTxtX4tsV', 'On The Spot', 'Beef', 14, 35.31, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('BKIcwHoPMtu7MbXkJevC', 'gFRfKNjtTFTrgBocJOqu', 'Delicacies', 'Bibingka Bigas', 14, 0, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('bMBsfloYMqFSyeMTBR9z', 'JOodb2wozWR6nZblQ2Dv', 'Vegetable Regular', 'CMC 3 Vegetables Regular : Gisadong Ampalaya', 2, 14.25, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('bmRWkL55y9yU6RLgDEq8', 'tVZtRnn2KxjOPLc15aBZ', 'On The Spot', 'Monggolian Rice', 9, 0, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('bNDM23yTLQleTGxXf1JF', 'blF0vfec3Ztu4AHEaoLa', 'Dessert', 'CMC 3 Vegetables Special : Potato Salad', 14, 17.74, 'On Site', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('bo4VKgE9hpuMWWMPAMKI', 'JoVYhGkhMEJ1D6ecdqg8', 'On The Spot', 'Vegetable Omelette', 1, 12.9, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('brCf8ObME28PnUBisnO0', 'JoVYhGkhMEJ1D6ecdqg8', 'Egg', 'CMC 3 Egg : Poached Egg', 4, 7, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('brCywAAK8Fh0WPMcIh0k', 'R3zTKW8DNmK4oeqpm3is', 'On The Spot', 'Pork', 14, 16.05, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('bzMg01gncKkgoogXnq3l', '7ssOzWtm2AnIrKQXxrWd', 'Cold Cuts', 'Fried Ham', 1, 13.01, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('c0QMc4KIjhd55JLutFQR', 'fi1KFSbrXq4tXIGToLyM', 'Chicken Regular', 'CMC 3 Chicken Regular : Chicken Humba', 3, 22.78, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('C8wx7T6Oii0uwaTmZ8Aj', 'BUuDvkbONCbBbl0TksXB', 'Delicacies', ' CMC BS : Pichi Pichi ', 14, 10.5, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('CCpch4DMt7Lbvb79iAIz', 'tVZtRnn2KxjOPLc15aBZ', 'Delicacies', ' CMC BS : Kutsinta ', 14, 3.04, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('CFx0ya82FBjKZgbWFkeY', '7ssOzWtm2AnIrKQXxrWd', 'Cold Cuts', 'Hotdog Sautee', 2, 11.23, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('CJm8C9tNm6oGDoXbL9Pj', 'gFRfKNjtTFTrgBocJOqu', 'Dessert', 'Almond Jelly', 14, 16.3, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('cKf1hI9OHdFDo3GYiZtq', 'iYqp30ARkjoaTxtX4tsV', 'Vegetable Executive', 'CMC 3 Vegetables Special : Sauteed Broccoli & Carrots', 2, 21.25, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('ClPmhiNvu2MwDzQe5b5S', 'iYqp30ARkjoaTxtX4tsV', 'Pinoy Favorite Mainstay', 'Saba Con Yelo w/ Sago', 14, 22.29, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('cmFKdQeV7MvdcAIkbXBB', 'gFRfKNjtTFTrgBocJOqu', 'Dessert', 'CMC BS : Mango Pannacotta', 14, 19.95, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('CmMW7eMaNoZIjzbGcTyC', 'JoVYhGkhMEJ1D6ecdqg8', 'Flavored Rice', 'Garlic Rice', 1, 4.85, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('CR9SigHHar28EwV687rI', 'JOodb2wozWR6nZblQ2Dv', 'Delicacies', ' CMC BS : Kutsinta ', 14, 3.04, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('CtXt5pK9KyykUJcSni7N', '7ssOzWtm2AnIrKQXxrWd', 'Chicken Regular', 'CMC 3 Chicken Regular : Chicken Tapa', 2, 23.32, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('cUIsGDMcnF9KihGVStgA', 'JOodb2wozWR6nZblQ2Dv', 'Cold Cuts', 'CMC 3 Coldcuts : Fried Cheesedog', 1, 19.96, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('CVbhhZCMtp6TUGjFGLd8', 'tVZtRnn2KxjOPLc15aBZ', 'Pinoy Favorite Mainstay', 'Fruit Cups', 14, 10.99, 'On Site', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('d2jofOKVcMst1P3Du9y5', 'eGJmJMai30b8eIXrKwTv', 'Pinoy Favorite Mainstay', 'Halo-Halo', 14, 19.12, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('d4ilI5FlbA1sUz2BFBEX', 'fD1vs3TASulIcnoduH95', 'Egg', 'CMC 3 Egg : Poached Egg', 4, 7, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('dDNaWW63Zdhr1xQJlaM2', 'blF0vfec3Ztu4AHEaoLa', 'Seafood Regular', 'CMC 3 Seafoods Regular : Fried Galunggong', 1, 20.37, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('DEhbpHeQWMYhYW3mLpR3', 'JoVYhGkhMEJ1D6ecdqg8', 'Free Soup', 'Vegetable Soup', 7, 4.19, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('deP1ddrzBSArC6ZOQPka', '7ssOzWtm2AnIrKQXxrWd', 'Delicacies', 'CMC BS : Biko', 14, 12.31, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('Df31usKiXbG3s0BhD8yt', '7ssOzWtm2AnIrKQXxrWd', 'Breakfast Mainstay', 'Breakfast Cereals (Kokokrunch, Corn Flakes, Fruit Loops)', 14, 16.84, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('Df9qqzJJyCZcUSHVz75Y', 'gFRfKNjtTFTrgBocJOqu', 'Pinoy Favorite Mainstay', 'Saba Con Yelo w/ Sago', 14, 22.29, 'On Site', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('DisKSTJVVRNOIEQbrkOy', 'BUuDvkbONCbBbl0TksXB', 'Dessert', 'Apple', 6, 0, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('dJOzTbAwTrMvAnslKbnZ', '7ssOzWtm2AnIrKQXxrWd', 'Egg', 'CMC 3 Egg : Poached Egg', 4, 7, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('dM1I6i9ppksJZUj2cN3l', 'fD1vs3TASulIcnoduH95', 'Dessert', 'Orange', 6, 0, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('DMKzjTt1AbQtx6ttu1TV', 'JoVYhGkhMEJ1D6ecdqg8', 'Canned Goods', 'CMC 3 Coldcuts : Fried Vienna Sausage', 15, 16.45, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('dmWCWl9fak4s3YAnmD1g', 'BUuDvkbONCbBbl0TksXB', 'Canned Goods', 'Fried Spam', 1, 31.3, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('DOFPUAA4dBOEjB5QfFhH', 'JoVYhGkhMEJ1D6ecdqg8', 'Cold Cuts', 'Fried Cocktail Hotdog', 1, 19.39, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('DpDtoQ0YmCEUe3YGSE32', 'iYqp30ARkjoaTxtX4tsV', 'Seafood Regular', 'CMC 3 Seafoods Regular : Paksiw Na Hasa-Hasa', 7, 21.22, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('DQJTGxQOWgm1rFTdJyVG', 'fwy0nczdnbPHTRK28OcS', 'Freshly Baked Breads', ' CMC BS : Ube Pandesal ', 14, 10.67, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('DriQD9Pmq3agcUMcgP1s', '7ssOzWtm2AnIrKQXxrWd', 'Dessert', 'Banana', 6, 0, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('DtWkTAENpdVDsrRpY47z', 'fi1KFSbrXq4tXIGToLyM', 'On The Spot', 'Chicken', 14, 24.71, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('dukPN6pnW7fjSpBCZf50', 'eGJmJMai30b8eIXrKwTv', 'Pork Executive', 'CMC 3 Pork Executive : Caribbean Pork Stew', 3, 32.34, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('DVIPHv0Tuhj4devsV61v', 'blF0vfec3Ztu4AHEaoLa', 'Pinoy Favorite Mainstay', 'Halo-Halo', 14, 19.12, 'On Site', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('dWoF6u5DxZPEXBkAvHpI', 'iYqp30ARkjoaTxtX4tsV', 'Plant Based', 'CMC 3 Plant Based : Salisburry Steak', 14, 35, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('DY36om9mdcHKPiEbAGqB', 'BUuDvkbONCbBbl0TksXB', 'Seafood Regular', 'CMC 3 Seafoods Regular : Sarciadong Hasa-Hasa', 3, 25.01, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('DzZVV2RUbE0EP8LuYaEM', 'iYqp30ARkjoaTxtX4tsV', 'Plant Based', 'CMC 3 Plant Based : Meat Afritada', 14, 35, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('E5BEfCotowmQrxeU87vi', 'fwy0nczdnbPHTRK28OcS', 'Seafood Regular', 'CMC 3 Seafoods Regular : Fried Hiwas', 1, 18.28, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('E6ZA22N15erkQgpkwSL8', 'gFRfKNjtTFTrgBocJOqu', 'Free Soup', 'Sinigang Soup', 7, 79.92, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('e9GPMz2OyEzZLkK43NYz', 'iYqp30ARkjoaTxtX4tsV', 'On The Spot', 'Monggolian Rice', 9, 0, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('eAZGIrpiFpOev9WrRYXF', 'eGJmJMai30b8eIXrKwTv', 'Seafood Regular', 'CMC 3 Seafoods Regular : Fried Hasa-hasa', 1, 21.08, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('EEA12VMXrrmGwtxcqmWA', 'gFRfKNjtTFTrgBocJOqu', 'Pork Executive', 'CMC 3 Pork Executive : Orange Spiced Pork Loin', 3, 43.5, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('EF4GsIKvVf4qKyBIJnbd', 'blF0vfec3Ztu4AHEaoLa', 'Vegetable Special', 'CMC 3 Vegetables Special : Diningding', 2, 16.04, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('Eiq9TV7hmnngiIEpjmFi', 'fwy0nczdnbPHTRK28OcS', 'Delicacies', 'Palitaw w/ Latik', 15, 10.35, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('eIVckb1QDNE60DKVAj47', 'eGJmJMai30b8eIXrKwTv', 'Seafood Special', 'CMC 3 Seafoods Special : Binusog Na Tilapia', 3, 32.59, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('eqlXPnAVjl6lZmEAfAZC', 'gFRfKNjtTFTrgBocJOqu', 'Pinoy Favorite Mainstay', 'Fruit Cups', 14, 10.99, 'On Site', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('EsfgUR42kbYBrp4gPFdh', 'fi1KFSbrXq4tXIGToLyM', 'On The Spot', 'Beef', 14, 35.31, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('ETwmvFCTFdefTBK9aOVY', '7ssOzWtm2AnIrKQXxrWd', 'Pork Regular', 'CMC 3 Pork Regular : Pork Lumpiang Shanghai w/ sweer & sour sauce', 1, 22.89, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('EU9YFfzJ6WCslvGV7O9Z', 'iYqp30ARkjoaTxtX4tsV', 'Free Soup', 'Nilaga Soup', 7, 26.56, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('eURACYKhrSJ7Xob3MKnB', 'fi1KFSbrXq4tXIGToLyM', 'Pinoy Favorite Mainstay', 'Saba Con Yelo w/ Sago', 14, 22.29, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('eUsz05Q7gGUf1rSLXDQa', 'tVZtRnn2KxjOPLc15aBZ', 'Chicken Executive', 'CMC 3 Chicken Executive : Chicken Stroganoff', 3, 32.82, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('eyeQQYgUZm09L2DYlu7x', 'fD1vs3TASulIcnoduH95', 'Seafood Regular', 'CMC 3 Seafoods Regular : Kinamatisang Mackerel', 2, 19.57, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('eyj5CMiIwWqHIVJRVrQS', 'R3zTKW8DNmK4oeqpm3is', 'Dessert', 'CMC BS : Buko Pandan', 14, 18.39, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('EYneuQNDIqBtl8YVzP7F', 'BUuDvkbONCbBbl0TksXB', 'Cold Cuts', 'Fried Jumbo Hotdog', 1, 14.19, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('f0KIsurVIvigQ6gxZnEm', 'dgvm2369GPnC3GFveBvz', 'Dessert', 'Banana', 6, 0, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('F5esSxFUqSK7sG3OYNFy', 'fwy0nczdnbPHTRK28OcS', 'Free Soup', 'Tinola Soup', 7, 40.49, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('F6ERrvRX8kzPGIzMkq0B', 'blF0vfec3Ztu4AHEaoLa', 'Chicken Special', 'CMC 3 Chicken Special : Chicken Mechado', 3, 25.31, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('fbN6BVDM6RIfTNOIZIvU', 'eGJmJMai30b8eIXrKwTv', 'On The Spot', 'Sisig On The Spot', 9, 0, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('fcG2neec6YVpZvzXVpWf', 'eGJmJMai30b8eIXrKwTv', 'Seafoods Executive', 'CMC 3 Seafoods Executive : Grilled Tuna w/ Mango Salsa', 18, 56, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('fiJttKLW4Jnj2hXJWtLH', 'dgvm2369GPnC3GFveBvz', 'Plant Based', 'CMC 3 Plant Based : Corned Beef', 2, 35, 'Commis Cooked', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('FsouQT62EH8VDvw4y3oz', 'tVZtRnn2KxjOPLc15aBZ', 'Chicken Regular', 'CMC 3 Chicken Regular : Chicken Tinola', 7, 22.41, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('fUvzicXULktWZOuKlg3o', 'gFRfKNjtTFTrgBocJOqu', 'On The Spot', 'Pork', 14, 16.05, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('fVFFJFg0aEVD6YLrFDfY', 'iYqp30ARkjoaTxtX4tsV', 'On The Spot', 'Chicken', 14, 24.71, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('Fw8BofMc8CuYUT6m1QMx', 'gFRfKNjtTFTrgBocJOqu', 'Chicken Special', 'CMC 3 Chicken Special : Chicken Caldereta', 3, 24.21, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('FWlA04RLazqPlhDGkpAJ', 'BUuDvkbONCbBbl0TksXB', 'Pork Regular', 'CMC 3 Pork Regular : Pork Embutido', 8, 24.78, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('FXqdfbVxNqrb40vMpHK1', 'BUuDvkbONCbBbl0TksXB', 'Plant Based', 'CMC 3 Plant Based : Tapa', 2, 35, 'Commis Cooked', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('g0vUxPpS0yF4Ir7f54hZ', 'eGJmJMai30b8eIXrKwTv', 'Delicacies', 'Bibingka Bigas', 14, 0, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('G6NmvMfHpfE0kugLZkn3', 'blF0vfec3Ztu4AHEaoLa', 'Delicacies', ' CMC BS : Sapin Sapin ', 14, 16.47, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('gBngKHOiZ59asJXNd5vy', 'fwy0nczdnbPHTRK28OcS', 'Breakfast Mainstay', 'Breakfast Cereals (Kokokrunch, Corn Flakes, Fruit Loops)', 14, 16.84, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('GGnZl6Rrw1YUbXJulTs3', 'gFRfKNjtTFTrgBocJOqu', 'On The Spot', 'Sisig On The Spot', 9, 0, 'On Site', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('GHgQrLsVGJLTJdsv6PLm', 'iYqp30ARkjoaTxtX4tsV', 'Flavored Rice', 'Adobo Rice', 14, 8.08, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('gJa2jFiSymRyGZoFCljy', 'dgvm2369GPnC3GFveBvz', 'On The Spot', 'Ham & Cheese Omelette', 1, 18.1, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('gjRXycg5MqiYPwRwhnrc', 'fwy0nczdnbPHTRK28OcS', 'Canned Goods', 'CMC 3 Beef Special : Corned Beef w/ Cabbage', 2, 25.89, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('gjTNWvfN0o6NUXmBnh51', 'gFRfKNjtTFTrgBocJOqu', 'Beef Executive', 'CMC 3 Beef Executive : Beef w/ Brocolli', 3, 39.74, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('goQXeKd9mmjL9cJgayYp', 'eGJmJMai30b8eIXrKwTv', 'On The Spot', 'Pork', 14, 16.05, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('GpnXmoAJoAF9X2Vhkf4f', 'fD1vs3TASulIcnoduH95', 'Chicken Regular', 'CMC 3 Chicken Regular : Fried Chicken w/ Gravy', 1, 21.76, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('grCGYQh9M5nntG4yXJjV', 'tVZtRnn2KxjOPLc15aBZ', 'On The Spot', 'Beef', 14, 35.31, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('grn1wBIRbLMgXkKApmS1', 'BUuDvkbONCbBbl0TksXB', 'Delicacies', ' CMC BS : Puto Ube ', 14, 0, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('gVutDYLJC22MyKSu6Iu5', 'fD1vs3TASulIcnoduH95', 'Cold Cuts', 'CMC 3 Coldcuts : Fried Hungarian Sausage', 1, 36.35, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('gWyrdymDDcenbqNu7eZg', 'R3zTKW8DNmK4oeqpm3is', 'Pork Regular', 'CMC 3 Pork Regular : Pork Bopiz', 2, 26.56, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('H3fsdoj5TmGv1LUMUFN8', 'iYqp30ARkjoaTxtX4tsV', 'Delicacies', ' CMC BS : Puto Ube ', 14, 0, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('h7Bu76K0RYVLVDyGLwHU', 'gFRfKNjtTFTrgBocJOqu', 'Delicacies', 'CMC BS : Maja Ube', 14, 13.42, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('h9wbC4ZFMCeTWguEWHS7', 'blF0vfec3Ztu4AHEaoLa', 'Beef Special', 'CMC 3 Beef Special : Korean Beef Stew', 3, 35.36, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('hhItKABGhcS4dDI8Uii5', 'JOodb2wozWR6nZblQ2Dv', 'Dessert', 'Orange', 6, 0, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('hLgMgjcpUp7ZlYuxqlDY', 'BUuDvkbONCbBbl0TksXB', 'Dessert', 'Orange', 6, 0, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('hlZ5Ep267fTij9nUxAxY', 'gFRfKNjtTFTrgBocJOqu', 'Delicacies', 'Camote Butchi', 14, 0, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('hrwWHQXoaYVus3HyIGMR', 'blF0vfec3Ztu4AHEaoLa', 'Dessert', 'CMC BS :Buko Lychee', 14, 19.95, 'On Site', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('hWPfCb0tZOhaRy9OV4mP', 'tVZtRnn2KxjOPLc15aBZ', 'Salad', 'Caesar Salad', 5, 0, 'On Site', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('hxzrH3eAvyI2TplCOwVQ', 'fi1KFSbrXq4tXIGToLyM', 'Chicken Special', 'CMC 3 Chicken Special : Korean Chicken Stew', 3, 24, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('HYY69O6DAiiae0Jh9rvG', 'fi1KFSbrXq4tXIGToLyM', 'Dessert', 'CMC BS : Ube Macapuno Jelly', 14, 0, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('i8Bu9Teect844HvshDdY', 'JOodb2wozWR6nZblQ2Dv', 'Dessert', 'Banana', 6, 0, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('I90rFQ4NU9tTxJ2rLFF3', 'blF0vfec3Ztu4AHEaoLa', 'On The Spot', 'Sisig On The Spot', 9, 0, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('IcRhFgCy4a41p8IgbxTH', 'dgvm2369GPnC3GFveBvz', 'Egg', 'Scrambled Egg W/ Potato', 1, 9.19, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('iCZlBrmB5bRkBMbTreuo', 'iYqp30ARkjoaTxtX4tsV', 'Dessert', 'Corn Jelly', 14, 13.95, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('iELm3CloThGmBFQmDDpy', 'JoVYhGkhMEJ1D6ecdqg8', 'Chicken Regular', 'CMC 3 Chicken Regular : Chicken Meatloaf', 1, 18.51, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('iizB8z7db7gEnzrPIZRF', 'tVZtRnn2KxjOPLc15aBZ', 'Pork Executive', 'CMC 3 Pork Executive : Roast Pork Loin w/ Apple Sauce', 11, 37.08, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('imzJANk7Dte9OfJSMxSb', 'iYqp30ARkjoaTxtX4tsV', 'Beef Special', 'CMC 3 Beef Special : Beef Arroz Ala Cubana', 12, 33.7, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('iRsvlwYZHpgYleq6dmVR', 'gFRfKNjtTFTrgBocJOqu', 'Seafoods Executive', 'CMC 3 Seafoods Executive : Mixed Seafoods Marinara', 3, 33.12, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('ITfk5njCLvwSUnoefNYQ', 'JOodb2wozWR6nZblQ2Dv', 'Freshly Baked Breads', 'CMC BS: Malunggay Pandesal', 14, 3.18, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('iyAgrvgLetm2P9JEJLwh', 'gFRfKNjtTFTrgBocJOqu', 'Plant Based', 'CMC 3 Plant Based : Adobo Flakes ', 2, 35, 'Commis Cooked', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('IyDV6LTulyKo3kvLbZM7', 'R3zTKW8DNmK4oeqpm3is', 'Pork Executive', 'CMC 3 Pork Executive : Pork Ala Kieve', 13, 39.97, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('J53pYVq1YPgCIVzW7RHv', 'blF0vfec3Ztu4AHEaoLa', 'On The Spot', 'Chicken', 14, 19.99, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('Jdo5of9pPw5dyHG3MVHz', 'dgvm2369GPnC3GFveBvz', 'Vegetable Regular', 'CMC 3 Vegetables Regular : Gisadong Carrots at Sayote', 2, 11.52, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('JeZPnWPXlasbXLRLqrWW', '7ssOzWtm2AnIrKQXxrWd', 'Flavored Rice', 'Garlic Rice', 1, 4.85, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('JML9y1dOJctDtBvp20kO', 'eGJmJMai30b8eIXrKwTv', 'Vegetable Executive', 'CMC 3 Vegetables Special : Roasted Zucchini & Carrots', 11, 15.37, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('jPmb9yVlUMxKNsTlosUK', 'gFRfKNjtTFTrgBocJOqu', 'Beef Special', 'CMC 3 Beef Special : Beef Curry', 3, 35.78, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('Js4K2LtDHvqo9gFInLZm', 'fwy0nczdnbPHTRK28OcS', 'Cold Cuts', 'Chicken Hotdog', 1, 36.35, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('JsmHRARAmBMYLViT3BWk', 'dgvm2369GPnC3GFveBvz', 'Egg', 'CMC 3 Egg : Fried Egg', 1, 7.81, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('K2k66v2WLc0bICuKDzuL', 'tVZtRnn2KxjOPLc15aBZ', 'Pork Special', 'CMC 3 Pork Special : Pork Kare-Kare', 3, 33.45, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('k4PlB9vb5LEX37AXN4hj', 'tVZtRnn2KxjOPLc15aBZ', 'Dessert', 'CMC BS : Buko Pandan', 14, 18.39, 'On Site', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('k62hIp1SO20BjH9JeJUs', 'JoVYhGkhMEJ1D6ecdqg8', 'Freshly Baked Breads', ' CMC BS : Ube Pandesal ', 14, 10.67, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('KcfKb1w6kGg9NZebyH0r', 'iYqp30ARkjoaTxtX4tsV', 'On The Spot', 'Pork', 14, 26.98, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('kd2jConmTtvQQmbHrIkj', 'iYqp30ARkjoaTxtX4tsV', 'Seafood Special', 'CMC 3 Seafoods Special : Sinanglay Na Tilapia', 3, 32.65, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('KEoYnfZHjoHAE0TIVjvo', 'fwy0nczdnbPHTRK28OcS', 'Pork Regular', 'CMC 3 Pork Regular : Pork Almondigas', 7, 25.12, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('KMd3WHj9aCYNY2qnueAu', 'R3zTKW8DNmK4oeqpm3is', 'Seafoods Executive', 'CMC 3 Seafoods Executive : Almond Crusted Fish Fillet', 13, 35.2, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('KXoGy5FCCRRBDsBM2Dyb', 'R3zTKW8DNmK4oeqpm3is', 'Chicken Executive', 'CMC 3 Chicken Executive : Chicken Flambe', 3, 38.21, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('KYb9BvbovZ1gvUpNW7F2', 'JOodb2wozWR6nZblQ2Dv', 'Canned Goods', 'CMC 3 Vegetables Regular : Gisadong Tuna w/ Cabbage', 3, 34.07, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('l0H1VbORGkrI4N766lX9', 'blF0vfec3Ztu4AHEaoLa', 'Pork Regular', 'CMC 3 Pork Regular : Pork Menudillo', 3, 26.27, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('L6tUQgLJ0YbvG3TSgMGO', 'BUuDvkbONCbBbl0TksXB', 'Freshly Baked Breads', ' CMC BS : Pandesal ', 13, 2.49, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('L7b7ZIil50PQWgPKMwXN', 'gFRfKNjtTFTrgBocJOqu', 'Flavored Rice', 'Vegetable Rice', 14, 3.08, 'On Site', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('L7g8M9ltMcM40XMy5af2', 'fD1vs3TASulIcnoduH95', 'Canned Goods', 'Gisadong Sardines W/ Miswa', 2, 16.86, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('l8C33vVDGVqIMDw6N5iS', 'R3zTKW8DNmK4oeqpm3is', 'Pinoy Favorite Mainstay', 'Fruit Cups', 14, 10.99, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('LbHiN2fsQEpyJAxyIWrF', 'JOodb2wozWR6nZblQ2Dv', 'Egg', 'CMC 3 Egg : Fried Egg', 1, 7.81, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('lckzrnzuZtQApF2WAUFA', 'R3zTKW8DNmK4oeqpm3is', 'Salad', 'Vegetable Salad', 14, 0, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('LdJ2EUEmrbpI2TqctisH', 'iYqp30ARkjoaTxtX4tsV', 'Pinoy Favorite Mainstay', 'Halo-Halo', 14, 19.12, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('LJaaXpJCzT80wNZ2okHK', 'dgvm2369GPnC3GFveBvz', 'Dessert', 'Apple', 6, 0, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('LJaqT84YRcnDZ2TFN08K', 'blF0vfec3Ztu4AHEaoLa', 'On The Spot', 'Bangus', 14, 21.67, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('LkIBVnGcGXxwW7bHjHxZ', 'tVZtRnn2KxjOPLc15aBZ', 'Pork Regular', 'CMC 3 Pork Regular : Pork Liver Steak', 3, 15.9, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('LP1bi0cPqvBwhhPMQaly', 'iYqp30ARkjoaTxtX4tsV', 'Dessert', 'CMC BS : Window Cathedral', 14, 11.18, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('lqZbHeJh2NX1fA3wz3mt', 'fwy0nczdnbPHTRK28OcS', 'Flavored Rice', 'Garlic Rice', 1, 4.85, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('lu7JWpvJPCzXoETJ5SyB', 'fD1vs3TASulIcnoduH95', 'Cold Cuts', 'CMC 3 Coldcuts : Fried German Franks', 1, 26.62, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('lYNqEMAK0GAo9z8qeJnv', 'BUuDvkbONCbBbl0TksXB', 'Egg', 'CMC 3 Egg : Poached Egg', 4, 7, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('mAVbSio60x5jFmIduGtd', 'tVZtRnn2KxjOPLc15aBZ', 'Free Soup', 'Tinola Soup', 7, 0, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('MbxKdAaRdTdHuU5Z92hl', 'R3zTKW8DNmK4oeqpm3is', 'On The Spot', 'Chicken', 14, 19.99, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('mcXnyEm7jetKWBLjtJz3', 'eGJmJMai30b8eIXrKwTv', 'Pinoy Favorite Mainstay', 'Fruit Cups', 14, 10.99, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('mhpn1uU0zyj8dE0liKMY', 'gFRfKNjtTFTrgBocJOqu', 'On The Spot', 'Chicken', 14, 19.99, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('MIGgW2c02oLDHin7Ppjs', '7ssOzWtm2AnIrKQXxrWd', 'Egg', 'CMC 3 Egg : Fried Egg', 1, 7.81, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('miz0S9H8ZohFBsgOk3IK', 'iYqp30ARkjoaTxtX4tsV', 'Seafoods Executive', 'CMC 3 Seafoods Executive : Tanigue Salpicao', 3, 54.09, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('MkADGnYtQBfqIZfSYRO1', 'blF0vfec3Ztu4AHEaoLa', 'On The Spot', 'Pork', 14, 16.05, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('mSQ2E8i8H6x0BDjNv2GC', 'eGJmJMai30b8eIXrKwTv', 'Delicacies', 'CMC BS : Maja Ube', 14, 13.42, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('mVn9SjswwFnr2EEEYhfo', 'eGJmJMai30b8eIXrKwTv', 'Pork Special', 'CMC 3 Pork Special : Roast Pork Hamonado', 11, 32.57, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('n3T9nxmIAUhv6VbM3mRg', 'BUuDvkbONCbBbl0TksXB', 'On The Spot', 'Mushroom Omelette', 1, 10.16, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('n6sHc7uFFbgI4pGUV3Im', 'gFRfKNjtTFTrgBocJOqu', 'Pork Regular', 'Place Holder', 7, 26.1, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('n7JB7zdroakSAQDNBhD2', 'fi1KFSbrXq4tXIGToLyM', 'Salad', 'Vegetable Salad', 14, 0, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('nH17vbU52diys7U2fPk4', 'iYqp30ARkjoaTxtX4tsV', 'Chicken Regular', 'CMC 3 Chicken Regular : Chicken Embutido', 8, 18.97, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('Nw1IKDM8PZUytxVqwh9A', 'tVZtRnn2KxjOPLc15aBZ', 'Vegetable Special', 'CMC 3 Vegetables Special : Chopsuey', 9, 11.52, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('NxaEcdxzTjIjd6ylxyKH', 'fi1KFSbrXq4tXIGToLyM', 'Delicacies', ' CMC BS : Cassava Cake ', 14, 21.14, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('NXyJMTP0Qf8HJWoNoD9B', 'blF0vfec3Ztu4AHEaoLa', 'Chicken Executive', 'CMC 3 Chicken Executive : Iberian Roast Chicken', 3, 42.4, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('O1IgSqf2Puy02eKVo4xz', 'fD1vs3TASulIcnoduH95', 'Flavored Rice', 'Garlic Rice', 1, 4.85, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('O87Wdvw9xbGeuOZ0ulKz', 'JOodb2wozWR6nZblQ2Dv', 'Seafood Regular', 'CMC 3 Seafoods Regular : Pinangat Na Alumahan', 8, 20.29, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('OhqYmYQ8ewFRnXrmLs3P', 'iYqp30ARkjoaTxtX4tsV', 'Pork Executive', 'CMC 3 Pork Executive : Pork Roulade w/ Spinach & Bell Pepper', 11, 36.7, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('OijWuL5rLYr7uDwpQ7O1', 'fwy0nczdnbPHTRK28OcS', 'Egg', 'CMC 3 Egg : Fried Egg', 1, 7.81, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('OiSABc7Wrt02MfdBQoHP', 'eGJmJMai30b8eIXrKwTv', 'Plant Based', 'CMC 3 Plant Based : Meatballs Caldereta', 14, 35, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('OJyty4UReUWzvFC90eC4', 'fD1vs3TASulIcnoduH95', 'Free Soup', 'Sinigang Soup', 7, 79.92, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('OL7heXBlwGcS29mLveBJ', 'JOodb2wozWR6nZblQ2Dv', 'Plant Based', 'CMC 3 Plant Based : Tapa', 2, 35, 'Commis Cooked', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('omv32gYq4W7vLdPOin8V', 'fi1KFSbrXq4tXIGToLyM', 'Free Soup', 'Tinola Soup', 7, 40.49, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('OScYTjZ90nwYQx666hCq', 'R3zTKW8DNmK4oeqpm3is', 'Dessert', ' CMC BS : Leche Flan ', 14, 11.67, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('OvxTTLtXMTEAGf0uO5xf', 'blF0vfec3Ztu4AHEaoLa', 'Beef Executive', 'CMC 3 Beef Executive : Beef Stroganoff', 3, 42.75, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('OzJ31fQBtGyHo9O2ljLn', 'tVZtRnn2KxjOPLc15aBZ', 'Dessert', 'CMC BS : Macaroni Salad', 5, 9.49, 'On Site', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('P0vkyfp8UTZIZIByzEyV', 'iYqp30ARkjoaTxtX4tsV', 'Chicken Special', 'CMC 3 Chicken Special : Chicken Pastel', 3, 24.44, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('p3TpxSBiprfX5q0Rfqsb', '7ssOzWtm2AnIrKQXxrWd', 'Dessert', 'Apple', 6, 0, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('pMDAkWPzbGSvB2c77L3V', 'dgvm2369GPnC3GFveBvz', 'Dessert', 'Orange', 6, 0, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('pnanZubk0jcYwFPlaEdz', 'blF0vfec3Ztu4AHEaoLa', 'Pork Special', 'Cmc 3 Pork Regular: Pork Afritada', 3, 32.98, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('pnj6ZdJtnPjGKuCHXEhl', 'iYqp30ARkjoaTxtX4tsV', 'Beef Executive', 'CMC 3 Beef Executive : Beef Rendang', 3, 40.77, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('qhiMCUVI6dQnnj3ni4Qb', 'JoVYhGkhMEJ1D6ecdqg8', 'Dessert', 'Banana', 6, 0, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('QHy2D8A0WtWFhSeUq48Q', 'gFRfKNjtTFTrgBocJOqu', 'Vegetable Regular', 'CMC 3 Vegetables Regular : Gisadong Cabbage At Carrots', 2, 12.83, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('QNl2lcUuJwKJkFqH2q7b', 'tVZtRnn2KxjOPLc15aBZ', 'Beef Special', 'CMC 3 Beef Special : Beef Meatballs w/ Hungarian Sauce', 3, 32.89, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('QnNxzA1djvBbHPEaG789', 'blF0vfec3Ztu4AHEaoLa', 'Vegetable Regular', 'CMC 3 Vegetables Regular : Gisadong Papaya', 2, 7.24, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('QOJRrO6NAZljsebCDgvq', 'gFRfKNjtTFTrgBocJOqu', 'Seafood Special', 'CMC 3 Seafoods Special : Fish Fillet w/ Tofu & Black Beans Sauce', 8, 29.83, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('qqT36Czj2Qk25CDBe5QW', '7ssOzWtm2AnIrKQXxrWd', 'Egg', 'Scrambled Egg Malunggay', 1, 0, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('QVMvER2HTuHkfDpmVOiE', 'fwy0nczdnbPHTRK28OcS', 'Delicacies', ' CMC BS : Cassava Cake ', 13, 21.14, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('QXC2ofatYIzflcYFsn5S', 'fD1vs3TASulIcnoduH95', 'Plant Based', 'CMC 3 Plant Based : Corned Beef', 2, 35, 'Commis Cooked', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('rA8sKWijOECWN7LF8yqt', 'tVZtRnn2KxjOPLc15aBZ', 'Seafood Regular', 'CMC 3 Seafoods Regular : Kinamatisang Alumahan', 3, 23.32, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('Rbka5fnsrTQu4BC5Jsbj', 'eGJmJMai30b8eIXrKwTv', 'Dessert', 'CMC BS : Mango Pannacotta', 14, 19.95, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('Rej6hbAZVKjR1UMl6zOk', 'BUuDvkbONCbBbl0TksXB', 'Canned Goods', 'CMC 3 Pork Special : Fried Argentina Meatloaf', 1, 23, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('rfPdmPJv9wcNgcGjdyzo', 'JOodb2wozWR6nZblQ2Dv', 'Free Soup', 'Tinola Soup', 7, 0, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('RFVuHwxEF1y1ZqJFSSTX', 'JOodb2wozWR6nZblQ2Dv', 'Breakfast Mainstay', 'Breakfast Cereals (Kokokrunch, Corn Flakes, Fruit Loops)', 14, 16.84, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('rkmoeMhDqBGx8ZU0AUzw', 'fi1KFSbrXq4tXIGToLyM', 'Seafood Special', 'CMC 3 Seafoods Special : Garlic Hot Mixed Seafood', 9, 37.97, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('RmNhfi1iKiceDZSIHVtp', 'eGJmJMai30b8eIXrKwTv', 'Salad', 'CMC 3 Vegetables Special : Garden Salad w/ Balsamic Vinaigrette', 14, 29.58, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('rvKUG8rbdq8i1dKkPqgB', 'JoVYhGkhMEJ1D6ecdqg8', 'Pork Regular', 'CMC 3 Pork Regular : Pork Tapa', 2, 29.49, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('rXbjUQYEdmHoADwj7dqC', 'fi1KFSbrXq4tXIGToLyM', 'On The Spot', 'Monggolian Rice', 9, 0, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('sFacnVTR7PoE04ZVXCea', 'fD1vs3TASulIcnoduH95', 'Salad', 'CMC 3 Vegetables Regular : Ensaladang Pinoy', 5, 11.11, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('sGgm11RutgKS4NHvyorG', 'tVZtRnn2KxjOPLc15aBZ', 'Seafoods Executive', 'CMC 3 Seafoods Special : Baked Fish Fillet w/ Lemon Butter Sauce', 1, 39.53, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('sGT2OVbfmzLG3MXljy42', 'blF0vfec3Ztu4AHEaoLa', 'Seafood Special', 'CMC 3 Seafoods Special : Escabecheng Local Salmon', 2, 30.81, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('si8mBVtEyaAekqdnPCm5', 'iYqp30ARkjoaTxtX4tsV', 'Pinoy Favorite Mainstay', 'Fruit Cups', 14, 10.99, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('StuzrsokVl3vKYsVUkbu', '7ssOzWtm2AnIrKQXxrWd', 'Delicacies', 'CMC BS : Puto Pao', 14, 0, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('sy13ImVRNQOIR05hvSAl', 'blF0vfec3Ztu4AHEaoLa', 'Pinoy Favorite Mainstay', 'Fruit Cups', 14, 10.99, 'On Site', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('sYUoK9Io3ZN2cNdatxek', 'eGJmJMai30b8eIXrKwTv', 'On The Spot', 'Bangus', 14, 21.67, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('T3eBgoPd1vTV42Czab9V', '7ssOzWtm2AnIrKQXxrWd', 'Seafood Regular', 'CMC 3 Seafoods Regular : Paksiw Na Matambaka', 7, 24.74, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('T8qtZCL6v5QlVH4OVgUR', 'eGJmJMai30b8eIXrKwTv', 'Chicken Special', 'CMC 3 Chicken Special : Kung Pao Chicken', 3, 27.45, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('tA9KZ8EGwNnjU34RK02j', 'eGJmJMai30b8eIXrKwTv', 'Plant Based', 'CMC 3 Plant Based : Meatballs W/ Sweet & Sour Sauce', 14, 35, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('tapEB0aD9giY6uUyJMQD', 'dgvm2369GPnC3GFveBvz', 'Canned Goods', 'Gisadong Sardines W/ Miswa', 2, 16.86, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('TdyplkemlV0G5yLoQAwz', 'fi1KFSbrXq4tXIGToLyM', 'Dessert', 'CMC BS : Fruit Jello', 14, 12.92, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('TE7hXnnsMPcU1xoAAHZE', 'R3zTKW8DNmK4oeqpm3is', 'On The Spot', 'Sisig On The Spot', 9, 0, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('tetAnW26WsbCxQPjNGsS', 'BUuDvkbONCbBbl0TksXB', 'Salad', 'CMC 3 Vegetables Special : Ensaladang Ampalaya', 5, 16.69, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('tj6ikA8wtflufwii2u0H', 'gFRfKNjtTFTrgBocJOqu', 'Salad', 'Vegetable Salad', 5, 0, 'On Site', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('tJYaQKmhKsl1ILYZGwG6', 'R3zTKW8DNmK4oeqpm3is', 'Seafood Special', 'CMC 3 Seafoods Special : Sinigang Na Bangus', 7, 23.94, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('TL70H3ebHdXyRpj5U3cE', 'blF0vfec3Ztu4AHEaoLa', 'Chicken Regular', 'CMC 3 Chicken Regular : Chicken Asado', 3, 27.23, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('TPNjPZSPeAxt8DgYui6K', 'JoVYhGkhMEJ1D6ecdqg8', 'Vegetable Regular', 'CMC 3 Vegetables Regular : Adobong Sitaw', 3, 11.35, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('tRMWy2Ref4LP9op1PHCV', 'dgvm2369GPnC3GFveBvz', 'Cold Cuts', 'CMC 3 Coldcuts : Fried German Franks', 1, 26.62, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('TTiZ8zlvXXznTLjpgDJG', 'R3zTKW8DNmK4oeqpm3is', 'Pinoy Favorite Mainstay', 'Saba Con Yelo w/ Sago', 14, 22.29, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('TV3onEO2oQuM5tBisJkD', 'BUuDvkbONCbBbl0TksXB', 'Vegetable Regular', 'CMC 3 Vegetables Regular : Gisadong Upo', 2, 12.08, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('tZcS3MEMYimAgH2AZ4AZ', 'fwy0nczdnbPHTRK28OcS', 'Dessert', 'Banana', 6, 0, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('U059QN2ZC6YuPJ6OkPSE', 'JoVYhGkhMEJ1D6ecdqg8', 'Egg', 'CMC 3 Egg : Fried Egg', 1, 7.81, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('U1DTLRYV9b0JvMx9lHF0', 'R3zTKW8DNmK4oeqpm3is', 'On The Spot', 'Bangus', 14, 21.67, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('U4TN96r3La2LnXOER9tB', 'blF0vfec3Ztu4AHEaoLa', 'Free Soup', 'Vegetable Soup', 7, 4.19, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24');
INSERT INTO `menu_dishes` (`id`, `menu_id`, `name`, `odoo_name`, `category_id`, `unit_cost`, `production`, `status`, `created_at`, `updated_at`) VALUES
('U5GwSZORKSFMsBuKNNa9', 'gFRfKNjtTFTrgBocJOqu', 'Chicken Executive', 'CMC 3 Chicken Executive : Roast Chicken w/ Demi Glaze Sauce', 11, 29.16, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('U5XudFlRWpSc0PGOEd2Z', 'BUuDvkbONCbBbl0TksXB', 'Dessert', 'Banana', 6, 0, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('u7h6EXDnwZ1UD5hxHcWZ', 'fD1vs3TASulIcnoduH95', 'Egg', 'CMC 3 Egg : Fried Egg', 1, 7.81, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('uE1GbKM3Ax0NgdcSRAh0', 'iYqp30ARkjoaTxtX4tsV', 'Chicken Executive', 'CMC 3 Chicken Executive : Roast Chicken w/ Chimichurri Sauce', 11, 39.74, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('UGdZn1NeFUjk1Ig87h1I', 'fD1vs3TASulIcnoduH95', 'On The Spot', 'Ham & Cheese Omelette', 1, 18.1, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('ugjoXa9r6tQsPvtU22Fp', 'gFRfKNjtTFTrgBocJOqu', 'Chicken Regular', 'CMC 3 Chicken Regular : Chicken Adobo', 3, 22.22, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('UjCaGme4eJNTMFxEByKw', 'R3zTKW8DNmK4oeqpm3is', 'Vegetable Special', 'CMC 3 Vegetables Special : Ginataang Sitaw', 2, 16.25, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('UkQlQnvIHJBN1cESCjrT', 'fD1vs3TASulIcnoduH95', 'Vegetable Regular', 'CMC 3 Vegetables Regular : Sayote Picadillo', 2, 8.15, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('UnA1BYxS3TswyS2WRwKe', 'blF0vfec3Ztu4AHEaoLa', 'Pinoy Favorite Mainstay', 'Saba Con Yelo w/ Sago', 14, 22.29, 'On Site', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('UqA9G4TVq8mSLkBmHCV9', 'fD1vs3TASulIcnoduH95', 'Delicacies', 'CMC BS : Maja Ube', 14, 13.42, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('URla3P8fOZCr8VRDQLXq', 'JoVYhGkhMEJ1D6ecdqg8', 'Canned Goods', 'CMC 3 Seafoods Regular : Sauteed Spanish Sardines', 2, 24.05, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('vAhIenSXHqBFHzj2hFTi', 'iYqp30ARkjoaTxtX4tsV', 'Delicacies', ' CMC BS : Pichi Pichi ', 14, 10.5, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('VaVyeONTOL4TMngJHb6v', 'dgvm2369GPnC3GFveBvz', 'Chicken Regular', 'CMC 3 Chicken Regular : Chicken Tocino', 2, 23.69, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('VbnYLpT974XsKSfOccdp', 'gFRfKNjtTFTrgBocJOqu', 'Plant Based', 'CMC 3 Plant Based : Meat Ala King ', 2, 35, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('VGtiWienlc5zEC6njidf', 'tVZtRnn2KxjOPLc15aBZ', 'On The Spot', 'Chicken', 14, 24.71, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('VKPQs3RaGryA03EPHiK4', 'blF0vfec3Ztu4AHEaoLa', 'Plant Based', 'CMC 3 Plant Based : Bistek Tagalog', 14, 35, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('Vqk6RL3V4t4HJV5a56eK', 'dgvm2369GPnC3GFveBvz', 'Cold Cuts', 'CMC 3 Coldcuts : Fried Hungarian Sausage', 1, 36.35, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('vsN2xOQv8jFicoh4Mw6O', 'iYqp30ARkjoaTxtX4tsV', 'Salad', 'Kani Mango Salad W/ Mango Dressing', 14, 26.95, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('VVn0ysUouUukUd0I5IZF', '7ssOzWtm2AnIrKQXxrWd', 'Free Soup', 'Miswa Soup', 7, 1.64, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('vYJiqNmScxGK1uCku44w', 'gFRfKNjtTFTrgBocJOqu', 'On The Spot', 'Bangus', 14, 21.67, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('Vz1iBZkUKRFuX4xz0N3r', 'fwy0nczdnbPHTRK28OcS', 'Egg', 'Scrambled Egg W/ Tomato & Onion', 1, 13.39, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('vZResHtQh5qB1Fbyi7Bv', 'eGJmJMai30b8eIXrKwTv', 'Flavored Rice', 'Vegetable Rice', 14, 3.08, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('wc6baWjJAJYLSHiklCfm', '7ssOzWtm2AnIrKQXxrWd', 'On The Spot', 'Tuna & Bellpepper Omelette', 1, 22.85, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('wcw66AyHyZxIW1zImCcR', 'R3zTKW8DNmK4oeqpm3is', 'Delicacies', 'CMC BS : Puto Pao', 14, 0, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('WGcj0HNYyPQRMTC18GbP', 'JoVYhGkhMEJ1D6ecdqg8', 'Seafood Regular', 'CMC 3 Seafoods Regular : Fried Daing Na Galunggong', 1, 19.34, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('WIs8F08FAFNMUQzd3D7y', 'BUuDvkbONCbBbl0TksXB', 'Free Soup', 'Nilaga Soup', 7, 26.56, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('WJyweYrCvlNEdUcbhNRn', 'JoVYhGkhMEJ1D6ecdqg8', 'Dessert', 'Apple', 6, 0, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('Wm8s5klICuRzbtg1MPED', 'JOodb2wozWR6nZblQ2Dv', 'Egg', 'Scrambled Egg w/ Cabbage', 1, 0, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('wVhr9IK8dbwoOoeQTemN', 'eGJmJMai30b8eIXrKwTv', 'Beef Executive', 'CMC 3 Beef Executive : Beef Goulash', 3, 44.7, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('wYRzT9vM9RzYVClVVBAm', 'blF0vfec3Ztu4AHEaoLa', 'Plant Based', 'CMC 3 Plant Based : Meat Pastel', 14, 35, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('x0bnfDZfCa9hvmttvmxe', 'R3zTKW8DNmK4oeqpm3is', 'Flavored Rice', 'Egg Fried Rice', 14, 1.59, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('x6dIbrPhezUkLBFrKtf8', 'gFRfKNjtTFTrgBocJOqu', 'Seafood Regular', 'CMC 3 Seafoods Regular : Escabecheng Matambaka', 3, 24.39, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('x6sbSdjEtvDYl0xgoSdR', 'fD1vs3TASulIcnoduH95', 'Dessert', 'Apple', 6, 0, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('XcBXa3TmUjTVSVwY4o1L', 'blF0vfec3Ztu4AHEaoLa', 'Seafoods Executive', 'CMC 3 Seafoods Executive : Buttered Shrimp', 9, 62.51, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('XHejzbGOhfErl6NDklvD', 'fwy0nczdnbPHTRK28OcS', 'Dessert', 'Apple', 6, 0, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('Xl7pqG1YS6wdvbic6ahd', 'fi1KFSbrXq4tXIGToLyM', 'Flavored Rice', 'Chao Fan Rice', 9, 2.96, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('XlkNagzrq6Gu3z7oD137', 'eGJmJMai30b8eIXrKwTv', 'Free Soup', 'Sinigang Soup', 7, 79.92, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('xRIrL3l6B8FWOrwkfs0F', 'blF0vfec3Ztu4AHEaoLa', 'Pork Executive', 'CMC 3 Pork Executive : Cajun Pork Chop', 3, 38.41, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('XsvzpsUxYQp7C5ys8UKr', 'JOodb2wozWR6nZblQ2Dv', 'Delicacies', 'Nilupak', 14, 5.55, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('XsY0RWdIloI9wwgLDZ6L', 'fwy0nczdnbPHTRK28OcS', 'On The Spot', 'Corned Beef Omelette', 1, 22.01, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('XXCsfESC8YpJG6tbxEVf', 'fi1KFSbrXq4tXIGToLyM', 'Delicacies', 'Palitaw w/ Latik', 14, 10.35, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('XYHPCr27pktuysY40Ryv', 'eGJmJMai30b8eIXrKwTv', 'On The Spot', 'Chicken', 14, 19.99, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('xyVsvR2afhir91G28y7H', 'dgvm2369GPnC3GFveBvz', 'Canned Goods', 'CMC 3 Coldcuts : Luncheon Meat', 1, 16.15, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('Y0wlaXRkjh1KlSTOdglX', 'eGJmJMai30b8eIXrKwTv', 'Dessert', 'CMC BS : Fruit Tart', 14, 7.04, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('Y0WzGU0tIZw66T7c7EHa', 'R3zTKW8DNmK4oeqpm3is', 'Vegetable Regular', 'CMC 3 Vegetables Regular : Gisadong Sitaw', 2, 11.15, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('YCVMkAx8mhq4keUtO6So', 'JoVYhGkhMEJ1D6ecdqg8', 'Delicacies', ' CMC BS : Sapin Sapin ', 14, 16.47, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('YDjeLvPGYIXALlpV34AJ', 'tVZtRnn2KxjOPLc15aBZ', 'Pinoy Favorite Mainstay', 'Saba Con Yelo w/ Sago', 14, 22.29, 'On Site', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('YLhio7ECOTioMAf9qUrR', 'JoVYhGkhMEJ1D6ecdqg8', 'Delicacies', 'Camote Balls', 14, 19.38, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('YnCUFfuMkRXYPXpMXkCa', 'eGJmJMai30b8eIXrKwTv', 'Pinoy Favorite Mainstay', 'Saba Con Yelo w/ Sago', 14, 22.29, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('YNMGstGHSYAzKc82X944', 'blF0vfec3Ztu4AHEaoLa', 'Flavored Rice', 'Shawarma Rice', 14, 0, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('YQdCCUVCzzTF4rbc9hdT', 'JOodb2wozWR6nZblQ2Dv', 'On The Spot', 'Spanish Omelette', 1, 14.23, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('YSbrPnmlCuYCa9VNFA2r', 'dgvm2369GPnC3GFveBvz', 'Seafood Regular', 'CMC 3 Seafoods Regular : Adobong Galunggong', 3, 18.31, 'Commis', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('yzDG3zeQfFONolCqTV1f', 'BUuDvkbONCbBbl0TksXB', 'Chicken Regular', 'CMC 3 Chicken Regular : Chicken Shanghai w/ sweet chili sauce', 1, 17.73, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('YzrBf4Tw01hpL63n1I3M', 'blF0vfec3Ztu4AHEaoLa', 'Dessert', 'Mango Graham', 14, 24.56, 'On Site', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('z36tIFt8pBL5MymorTh3', 'R3zTKW8DNmK4oeqpm3is', 'Pinoy Favorite Mainstay', 'Halo-Halo', 14, 19.12, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('z3o4qqikJGaZI9lwNAxJ', 'iYqp30ARkjoaTxtX4tsV', 'Vegetable Special', 'CMC 3 Vegetables Special : Ginataang Langka', 16, 16, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('zctN9nRr0JxYRry3JCUB', 'blF0vfec3Ztu4AHEaoLa', 'Delicacies', 'Camote Balls', 14, 19.38, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('ZEiDi6K7ylWlx8Ouxgdd', 'JOodb2wozWR6nZblQ2Dv', 'Cold Cuts', 'CMC 3 Coldcuts : Fried Bologna', 1, 21.91, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('zFalKMwJ8JZ2XjkJunkP', 'tVZtRnn2KxjOPLc15aBZ', 'On The Spot', 'Pork', 14, 26.98, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('Zfxhfi7NWdoVuJRP5yma', 'R3zTKW8DNmK4oeqpm3is', 'Pork Special', 'CMC 3 Pork Special : Pork Lechon Paksiw', 7, 33.96, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('ZGWWOu2aIBEbFMiSE6tw', 'fi1KFSbrXq4tXIGToLyM', 'Pork Special', 'CMC 3 Pork Special : Pork Mechado', 3, 30.26, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('ZhWbe7Cb1YsrKDurtKRg', '7ssOzWtm2AnIrKQXxrWd', 'Dessert', 'Orange', 6, 0, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('ZKhbcpbNAy9g9WBQmNbY', 'iYqp30ARkjoaTxtX4tsV', 'Delicacies', ' CMC BS : Cassava Cake ', 14, 21.14, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('ZKHsnOEepzZwHdx7rLA1', 'tVZtRnn2KxjOPLc15aBZ', 'Vegetable Executive', 'CMC 3 Vegetables Special : Garden Fresh Vegetables', 2, 20.79, 'Commis', 'Active', '2025-05-12 22:10:24', '2025-05-12 22:10:24'),
('ZnovaSsklPYmkvEKDAXf', 'fi1KFSbrXq4tXIGToLyM', 'Pork Regular', 'CMC 3 Pork Regular : Pork Igado', 2, 28.44, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('zrP6J2htGCz30ZkAXlBc', 'eGJmJMai30b8eIXrKwTv', 'Pork Regular', 'CMC 3 Pork Regular : Pork Sinangag', 2, 21.93, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('Zs8G9SLzFUKrPsddpPzN', 'fi1KFSbrXq4tXIGToLyM', 'Pinoy Favorite Mainstay', 'Halo-Halo', 14, 19.12, 'On Site', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25'),
('ZVw2yMgg1F6o8V2JPl4J', 'fwy0nczdnbPHTRK28OcS', 'Dessert', 'Orange', 6, 0, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('zXx4jGz5AlL6Uu9vDs9Y', 'dgvm2369GPnC3GFveBvz', 'Salad', 'CMC 3 Vegetables Regular : Ensaladang Pinoy', 5, 11.11, 'On Site', 'Active', '2025-05-10 08:58:58', '2025-05-10 08:58:58'),
('ZySz18N9Kmvkx3V2GX6U', 'fi1KFSbrXq4tXIGToLyM', 'Vegetable Special', 'CMC 3 Vegetables Regular : Ginataang Papaya at Malunggay', 16, 13.56, 'Commis', 'Active', '2025-05-12 22:10:25', '2025-05-12 22:10:25');

-- --------------------------------------------------------

--
-- Table structure for table `menu_dishes_categories`
--

CREATE TABLE `menu_dishes_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_dishes_categories`
--

INSERT INTO `menu_dishes_categories` (`id`, `category`, `created_at`, `updated_at`) VALUES
(1, 'Fried', '2025-05-05 11:58:58', '2025-05-05 11:58:58'),
(2, 'Sautee', '2025-05-05 11:58:58', '2025-05-05 11:58:58'),
(3, 'Stew', '2025-05-05 11:58:58', '2025-05-05 11:58:58'),
(4, 'Boiled', '2025-05-05 11:58:58', '2025-05-05 11:58:58'),
(5, 'Salad', '2025-05-05 11:58:58', '2025-05-05 11:58:58'),
(6, 'Fruits', '2025-05-05 11:58:58', '2025-05-05 11:58:58'),
(7, 'Soup', '2025-05-05 11:58:58', '2025-05-05 11:58:58'),
(8, 'Steam', '2025-05-05 11:58:58', '2025-05-05 11:58:58'),
(9, 'Stir Fry', '2025-05-05 11:58:58', '2025-05-05 11:58:58'),
(10, 'Teppan', '2025-05-05 11:58:58', '2025-05-05 11:58:58'),
(11, 'Roast', '2025-05-05 11:58:58', '2025-05-05 11:58:58'),
(12, 'Braised', '2025-05-05 11:58:58', '2025-05-05 11:58:58'),
(13, 'Baked', '2025-05-05 11:58:58', '2025-05-05 11:58:58'),
(14, 'Others', '2025-05-08 04:57:24', '2025-05-08 04:57:24'),
(15, 'Steamed', '2025-05-10 16:53:29', '2025-05-10 16:53:29'),
(16, 'Simmer', '2025-05-13 06:04:09', '2025-05-13 06:04:09'),
(17, 'Pan Seared', '2025-05-13 06:05:05', '2025-05-13 06:05:05'),
(18, 'Grilled', '2025-05-13 06:05:53', '2025-05-13 06:05:53');

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
(17, '0001_01_01_000000_create_users_table', 1),
(18, '0001_01_01_000001_create_cache_table', 1),
(19, '0001_01_01_000002_create_jobs_table', 1),
(20, '2025_05_04_151003_create_super_admins_table', 1),
(21, '2025_05_05_015138_create_personal_access_tokens_table', 2),
(27, '2025_05_05_075641_create_menus_table', 3),
(28, '2025_05_05_115102_create_menu_dishes_categories_table', 4),
(31, '2025_05_05_120656_create_menu_dishes_table', 5),
(33, '2025_05_06_032016_create_area_managers_table', 6),
(36, '2025_05_06_040908_create_branches_table', 7),
(37, '2025_05_06_063459_create_branch_managers_table', 8),
(40, '2025_05_06_102734_create_orders_table', 9),
(44, '2025_05_06_110018_create_order_items_table', 10);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` varchar(20) NOT NULL,
  `branch_id` varchar(20) DEFAULT NULL,
  `deadline` datetime DEFAULT NULL,
  `total_cost` double NOT NULL DEFAULT 0,
  `status` enum('Open','Pending','Completed','Cancelled') NOT NULL DEFAULT 'Open',
  `completed_at` timestamp NULL DEFAULT NULL,
  `cancelled_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` varchar(20) NOT NULL,
  `order_id` varchar(20) DEFAULT NULL,
  `menu_dish_id` varchar(20) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `unit_cost` double NOT NULL DEFAULT 0,
  `total_cost` double NOT NULL DEFAULT 0,
  `status` enum('Open','Pending','Completed','Cancelled') NOT NULL DEFAULT 'Open',
  `completed_at` timestamp NULL DEFAULT NULL,
  `cancelled_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `tokenable_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(34, 'App\\Models\\branch_managers', '34WDVdLVEuLAWr5bJ6XY', 'Branch Manager', '23674e6fa018f983f12551f507613275f8a8d27bcd216b4f38526dee7bfb135a', '[\"*\"]', '2025-05-06 03:58:25', NULL, '2025-05-06 03:58:24', '2025-05-06 03:58:25'),
(49, 'App\\Models\\super_admins', 'X4r9KxLtQz7UeGvW2Fjd', 'Super Admin', 'd846575624f6d60027f0998f6c2004ec5842e3aff6b3850aee0ed26cba87471f', '[\"*\"]', '2025-05-10 08:44:31', NULL, '2025-05-10 07:41:26', '2025-05-10 08:44:31'),
(51, 'App\\Models\\super_admins', 'X4r9KxLtQz7UeGvW2Fjd', 'Super Admin', '65751f3609c377d66f01e7fe73473784a0138db4831775b3175343c8fc55bbc4', '[\"*\"]', '2025-05-13 23:51:48', NULL, '2025-05-12 04:48:38', '2025-05-13 23:51:48'),
(54, 'App\\Models\\super_admins', 'X4r9KxLtQz7UeGvW2Fjd', 'Super Admin', 'a057aacc3e05b01ec6a736a0101ea1f630e376373bae3b512feb6c02fc97f7fd', '[\"*\"]', '2025-05-12 22:42:55', NULL, '2025-05-12 22:26:55', '2025-05-12 22:42:55'),
(57, 'App\\Models\\super_admins', 'X4r9KxLtQz7UeGvW2Fjd', 'Super Admin', 'dd4076934eab545082b7d8dee0494540e7ff7e0ca01fb363e821009d1a8369a8', '[\"*\"]', '2025-05-15 02:48:37', NULL, '2025-05-14 18:49:54', '2025-05-15 02:48:37');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('tsHsTlZtT4m3iaWwnxdvHTzRSTVOqBAC7JYBsmxB', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicFZHak5KdVRUd2JBaXVMSWs5bHJXV3huOFgwckpGa2tJQ055aFJpQyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746411628);

-- --------------------------------------------------------

--
-- Table structure for table `super_admins`
--

CREATE TABLE `super_admins` (
  `id` varchar(20) NOT NULL,
  `fname` varchar(50) NOT NULL,
  `mname` varchar(50) DEFAULT NULL,
  `lname` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(50) NOT NULL,
  `status` enum('Active','Suspended','Deleted') NOT NULL DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `super_admins`
--

INSERT INTO `super_admins` (`id`, `fname`, `mname`, `lname`, `username`, `password`, `email`, `status`, `created_at`, `updated_at`) VALUES
('we9w99nXjcjRz2fLl9on', 'Test', '', 'test', 'test123', '$2y$12$SJzXsG4kShKhSP9ZLWUu8.Nzur9jE8dBYmQ2iBq9bprV47.U7HT9C', 'testsupad@gmail.com', 'Active', '2025-05-05 19:24:29', '2025-05-05 19:24:29'),
('X4r9KxLtQz7UeGvW2Fjd', 'Airich', NULL, 'Diawan', 'adiawan', '$2y$12$0yvf43PEvEq.Xc7/F/s3ouzn1t8yyfI9wOR/zk4.tGAs120GjGQai', 'airichjaydiawan@gmail.com', 'Active', '2025-05-04 15:41:12', '2025-05-04 15:41:12');

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
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `area_managers`
--
ALTER TABLE `area_managers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `area_managers_email_unique` (`email`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `branches_branch_code_unique` (`branch_code`),
  ADD KEY `branches_area_manager_id_foreign` (`area_manager_id`);

--
-- Indexes for table `branch_managers`
--
ALTER TABLE `branch_managers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `branch_managers_username_unique` (`username`),
  ADD UNIQUE KEY `branch_managers_email_unique` (`email`),
  ADD KEY `branch_managers_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

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
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu_dishes`
--
ALTER TABLE `menu_dishes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menu_dishes_menu_id_foreign` (`menu_id`),
  ADD KEY `menu_dishes_category_id_foreign` (`category_id`);

--
-- Indexes for table `menu_dishes_categories`
--
ALTER TABLE `menu_dishes_categories`
  ADD PRIMARY KEY (`id`);

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
  ADD KEY `orders_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_items_order_id_foreign` (`order_id`),
  ADD KEY `order_items_menu_dish_id_foreign` (`menu_dish_id`);

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
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `super_admins`
--
ALTER TABLE `super_admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `super_admins_email_unique` (`email`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menu_dishes_categories`
--
ALTER TABLE `menu_dishes_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `branches`
--
ALTER TABLE `branches`
  ADD CONSTRAINT `branches_area_manager_id_foreign` FOREIGN KEY (`area_manager_id`) REFERENCES `area_managers` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `branch_managers`
--
ALTER TABLE `branch_managers`
  ADD CONSTRAINT `branch_managers_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `menu_dishes`
--
ALTER TABLE `menu_dishes`
  ADD CONSTRAINT `menu_dishes_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `menu_dishes_categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `menu_dishes_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_menu_dish_id_foreign` FOREIGN KEY (`menu_dish_id`) REFERENCES `menu_dishes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
