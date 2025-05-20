-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 20, 2025 at 03:37 PM
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
('YT2Bc7EmqaUHRfB4EOnm', 'KC-0002', 'John Deli', 'SM Moa', '97lu6HECbJyXFjZ8LN4f', 'Medium', 'Active', '2025-05-05 21:46:19', '2025-05-15 06:18:00');

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
-- Table structure for table `menu_categories`
--

CREATE TABLE `menu_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_categories`
--

INSERT INTO `menu_categories` (`id`, `category`, `created_at`, `updated_at`) VALUES
(23, 'Bakeshop', '2025-05-20 01:35:17', '2025-05-20 01:50:12'),
(24, 'Breakfast', '2025-05-20 01:35:21', '2025-05-20 01:35:21'),
(25, 'Canned Goods', '2025-05-20 01:35:26', '2025-05-20 01:35:26'),
(26, 'Cold Cuts', '2025-05-20 01:35:35', '2025-05-20 01:35:35'),
(27, 'Delicacies', '2025-05-20 01:35:40', '2025-05-20 01:35:40'),
(28, 'Dessert', '2025-05-20 01:35:45', '2025-05-20 01:35:45'),
(29, 'Egg', '2025-05-20 01:35:47', '2025-05-20 01:35:47'),
(30, 'Executive', '2025-05-20 01:35:54', '2025-05-20 01:35:54'),
(31, 'Pasta & Noodles', '2025-05-20 01:35:59', '2025-05-20 01:35:59'),
(32, 'Plant Based', '2025-05-20 01:36:04', '2025-05-20 01:36:04'),
(33, 'Porridge', '2025-05-20 01:36:08', '2025-05-20 01:36:08'),
(34, 'Regular', '2025-05-20 01:36:11', '2025-05-20 01:36:11'),
(35, 'Rice', '2025-05-20 01:36:14', '2025-05-20 01:36:14'),
(36, 'Salad', '2025-05-20 01:36:17', '2025-05-20 01:36:17'),
(37, 'Soup', '2025-05-20 01:36:20', '2025-05-20 01:36:20'),
(38, 'Special', '2025-05-20 01:36:23', '2025-05-20 01:36:23'),
(39, 'Themed', '2025-05-20 01:36:26', '2025-05-20 01:36:26');

-- --------------------------------------------------------

--
-- Table structure for table `menu_classes`
--

CREATE TABLE `menu_classes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `class` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_classes`
--

INSERT INTO `menu_classes` (`id`, `class`, `created_at`, `updated_at`) VALUES
(1, 'Regular', '2025-05-20 01:56:01', '2025-05-20 01:56:01'),
(2, 'Plant Based', '2025-05-20 01:56:41', '2025-05-20 01:56:41'),
(3, 'Cold Cuts', '2025-05-20 01:56:48', '2025-05-20 01:56:48'),
(4, 'Canned Goods', '2025-05-20 01:56:52', '2025-05-20 01:56:52'),
(5, 'Eggs', '2025-05-20 01:56:55', '2025-05-20 01:56:55'),
(6, 'On The Spot', '2025-05-20 01:57:00', '2025-05-20 01:57:00'),
(7, 'Salad', '2025-05-20 01:57:03', '2025-05-20 01:57:03'),
(8, 'Rice', '2025-05-20 01:57:06', '2025-05-20 01:57:06'),
(9, 'Free Soup', '2025-05-20 01:57:10', '2025-05-20 01:57:10'),
(10, 'Desserts', '2025-05-20 01:57:14', '2025-05-20 01:57:14'),
(11, 'Delicacies', '2025-05-20 01:57:18', '2025-05-20 01:57:18'),
(12, 'Bakeshop', '2025-05-20 01:57:25', '2025-05-20 01:57:25'),
(13, 'Special', '2025-05-20 01:57:34', '2025-05-20 01:57:34'),
(14, 'Executive', '2025-05-20 01:57:38', '2025-05-20 01:57:38'),
(15, 'Pinoy Favorite Mainstay', '2025-05-20 01:58:01', '2025-05-20 01:58:01'),
(16, 'Pasta', '2025-05-20 01:58:09', '2025-05-20 01:58:09'),
(17, 'Noodles', '2025-05-20 01:58:12', '2025-05-20 01:58:12'),
(18, 'Porridge', '2025-05-20 01:58:17', '2025-05-20 01:58:17'),
(19, 'Pinoy Favorites Mainstay', '2025-05-20 01:58:27', '2025-05-20 01:58:27'),
(20, 'Pinoy Favorites', '2025-05-20 01:58:52', '2025-05-20 01:58:52'),
(21, 'Kalye Uno', '2025-05-20 01:58:57', '2025-05-20 01:58:57');

-- --------------------------------------------------------

--
-- Table structure for table `menu_dishes`
--

CREATE TABLE `menu_dishes` (
  `id` varchar(20) NOT NULL,
  `menu_to_dish_tag` varchar(255) NOT NULL,
  `dish_code` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `sub_category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `unit_cost` double NOT NULL DEFAULT 0,
  `production` enum('Commis','Commis Cooked','On Site') NOT NULL,
  `status` enum('Active','Discontinued') NOT NULL DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_dishes`
--

INSERT INTO `menu_dishes` (`id`, `menu_to_dish_tag`, `dish_code`, `name`, `sub_category_id`, `unit_cost`, `production`, `status`, `created_at`, `updated_at`) VALUES
('alsabRnl6BFgoYGMGvod', 'Chicken Regular', 'CHR-0001', 'CMC 3 Chicken Regular : Fried Chicken w/ Gravy', 5, 21.76, 'On Site', 'Active', '2025-05-18 15:30:25', '2025-05-19 09:26:56'),
('azDeIApvxylfrvPjXMiY', 'Chicken Regular', 'CHR-0002', 'CMC 3 Chicken Regular : Sinampalukang Manok', 5, 24.48, 'Commis', 'Active', '2025-05-18 15:47:39', '2025-05-19 09:27:00'),
('EW8jFVv3AUNbjhFROSvy', 'Chicken Regular', 'CHR-0003', 'CMC 3 Chicken Regular : Chicken Asado', 5, 23.29, 'Commis', 'Active', '2025-05-19 04:32:37', '2025-05-19 04:32:37');

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
-- Table structure for table `menu_form_elements`
--

CREATE TABLE `menu_form_elements` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `menu_shift_id` bigint(20) UNSIGNED DEFAULT NULL,
  `menu_class_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_form_elements`
--

INSERT INTO `menu_form_elements` (`id`, `menu_shift_id`, `menu_class_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2025-05-20 05:15:24', '2025-05-20 05:15:24');

-- --------------------------------------------------------

--
-- Table structure for table `menu_shifts`
--

CREATE TABLE `menu_shifts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `shift` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_shifts`
--

INSERT INTO `menu_shifts` (`id`, `shift`, `created_at`, `updated_at`) VALUES
(1, 'Breakfast', '2025-05-15 15:09:22', '2025-05-15 15:09:22'),
(2, 'Lunch', '2025-05-15 15:09:23', '2025-05-15 16:13:22'),
(3, 'Snack', '2025-05-15 15:09:24', '2025-05-15 15:09:24'),
(4, 'Dinner', '2025-05-15 15:09:25', '2025-05-22 15:09:25'),
(5, 'Midnight Lunch', '2025-05-15 15:09:26', '2025-05-15 15:09:26'),
(6, 'Midnight Snack', '2025-05-15 15:09:27', '2025-05-15 15:09:27');

-- --------------------------------------------------------

--
-- Table structure for table `menu_sub_categories`
--

CREATE TABLE `menu_sub_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sub_category` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_sub_categories`
--

INSERT INTO `menu_sub_categories` (`id`, `sub_category`, `created_at`, `updated_at`) VALUES
(1, 'Bakeshop', '2025-05-12 09:23:20', '2025-05-19 09:23:20'),
(2, 'Beef', '2025-05-19 09:23:20', '2025-05-19 09:23:20'),
(3, 'Breakfast', '2025-05-19 09:23:20', '2025-05-19 09:23:20'),
(4, 'Canned Goods', '2025-05-19 09:23:20', '2025-05-19 09:23:20'),
(5, 'Chicken', '2025-05-19 09:23:20', '2025-05-19 09:23:20'),
(6, 'Cold cuts', '2025-05-19 09:23:20', '2025-05-20 10:27:48'),
(7, 'Delicacies', '2025-05-19 09:23:20', '2025-05-19 09:23:20'),
(8, 'Dessert', '2025-05-19 09:23:20', '2025-05-19 09:23:20'),
(9, 'Egg', '2025-05-19 09:23:20', '2025-05-19 09:23:20'),
(10, 'Pasta & Noodles', '2025-05-19 09:23:20', '2025-05-19 09:23:20'),
(11, 'Plant Based', '2025-05-19 09:23:20', '2025-05-19 09:23:20'),
(12, 'Pork', '2025-05-19 09:23:20', '2025-05-19 09:23:20'),
(13, 'Porridge', '2025-05-19 09:23:20', '2025-05-19 09:23:20'),
(14, 'Rice', '2025-05-19 09:23:20', '2025-05-19 09:23:20'),
(15, 'Salad', '2025-05-19 09:23:20', '2025-05-19 09:23:20'),
(16, 'Seafood', '2025-05-19 09:23:20', '2025-05-19 09:23:20'),
(17, 'Soup', '2025-05-19 09:23:20', '2025-05-19 09:23:20'),
(18, 'Vegetable', '2025-05-19 09:23:20', '2025-05-19 09:23:20'),
(19, 'On The Spot', '2025-05-20 10:40:15', '2025-05-20 10:40:15'),
(20, 'Pinoy Favorite Mainstay', '2025-05-20 11:00:39', '2025-05-20 11:00:39'),
(21, 'Kalye Uno', '2025-05-20 11:03:45', '2025-05-20 11:03:45');

-- --------------------------------------------------------

--
-- Table structure for table `menu_tags`
--

CREATE TABLE `menu_tags` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `menu_class_id` bigint(20) UNSIGNED DEFAULT NULL,
  `menu_sub_category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `tag` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_tags`
--

INSERT INTO `menu_tags` (`id`, `menu_class_id`, `menu_sub_category_id`, `tag`, `created_at`, `updated_at`) VALUES
(1, 1, 5, 'Chicken Regular', '2025-05-20 02:20:50', '2025-05-20 03:46:54'),
(2, 1, 12, 'Pork Regular', '2025-05-20 02:21:08', '2025-05-20 02:21:08'),
(3, 1, 16, 'Seafood Regular', '2025-05-20 02:21:22', '2025-05-20 02:21:22'),
(5, 2, 11, 'Plant Based', '2025-05-20 02:22:06', '2025-05-20 02:22:06'),
(6, 3, 6, 'Cold Cuts 1', '2025-05-20 02:29:12', '2025-05-20 02:29:12'),
(7, 3, 6, 'Cold Cuts 2', '2025-05-20 02:29:15', '2025-05-20 02:29:15'),
(8, 4, 4, 'Canned Goods 1', '2025-05-20 02:38:53', '2025-05-20 02:38:53'),
(9, 4, 4, 'Canned Goods 2', '2025-05-20 02:38:56', '2025-05-20 02:38:56'),
(10, 5, 9, 'Egg 1', '2025-05-20 02:39:34', '2025-05-20 02:39:34'),
(11, 5, 9, 'Egg 2', '2025-05-20 02:39:37', '2025-05-20 02:39:37'),
(12, 5, 9, 'Egg 3', '2025-05-20 02:39:39', '2025-05-20 02:39:39'),
(13, 6, 19, 'On The Spot 1', '2025-05-20 02:41:37', '2025-05-20 02:41:37'),
(16, 7, 15, 'Salad 1', '2025-05-20 02:42:59', '2025-05-20 10:43:30'),
(17, 8, 14, 'Flavored Rice', '2025-05-20 02:50:43', '2025-05-20 02:50:43'),
(18, 9, 17, 'Free Soup', '2025-05-20 02:51:01', '2025-05-20 02:51:01'),
(19, 10, 8, 'Dessert 1', '2025-05-20 02:51:12', '2025-05-20 02:51:12'),
(20, 10, 8, 'Dessert 2', '2025-05-20 02:51:13', '2025-05-20 02:51:13'),
(21, 10, 8, 'Dessert 3', '2025-05-20 02:51:14', '2025-05-20 02:51:14'),
(22, 11, 7, 'Delicacies 1', '2025-05-20 02:51:33', '2025-05-20 02:51:33'),
(23, 11, 7, 'Delicacies 2', '2025-05-20 02:51:35', '2025-05-20 02:51:35'),
(24, 12, 1, 'Freshly Baked Breads', '2025-05-20 02:52:38', '2025-05-20 02:52:38'),
(25, 12, 1, 'Freshly Baked Breads (Mainstay)', '2025-05-20 02:52:43', '2025-05-20 02:52:43'),
(26, 13, 2, 'Beef Special', '2025-05-20 02:53:17', '2025-05-20 02:53:17'),
(27, 13, 5, 'Chicken Special', '2025-05-20 02:53:26', '2025-05-20 02:53:26'),
(28, 13, 12, 'Pork Special', '2025-05-20 02:53:36', '2025-05-20 02:53:36'),
(29, 13, 16, 'Seafood Special', '2025-05-20 02:53:44', '2025-05-20 02:53:44'),
(30, 13, 18, 'Vegetable Special', '2025-05-20 02:54:22', '2025-05-20 02:54:22'),
(31, 14, 2, 'Beef Executive', '2025-05-20 02:54:39', '2025-05-20 02:54:39'),
(32, 14, 5, 'Chicken Executive', '2025-05-20 02:55:47', '2025-05-20 02:55:47'),
(33, 14, 12, 'Pork Executive', '2025-05-20 02:55:54', '2025-05-20 02:55:54'),
(34, 14, 16, 'Seafood Executive', '2025-05-20 02:56:02', '2025-05-20 02:56:02'),
(35, 14, 18, 'Vegetable Executive', '2025-05-20 02:56:12', '2025-05-20 02:56:12'),
(36, 2, 11, 'Plant Based 1', '2025-05-20 02:56:44', '2025-05-20 02:56:44'),
(37, 2, 11, 'Plant Based 2', '2025-05-20 02:57:03', '2025-05-20 02:57:03'),
(38, 6, 19, 'On The Spot 2', '2025-05-20 02:57:31', '2025-05-20 02:57:31'),
(39, 6, 19, 'On The Spot 3', '2025-05-20 02:57:34', '2025-05-20 02:57:34'),
(40, 6, 19, 'On The Spot 4', '2025-05-20 02:57:35', '2025-05-20 02:57:35'),
(41, 11, 7, 'Delicacies 3', '2025-05-20 02:58:04', '2025-05-20 02:58:04'),
(43, 15, 20, 'Pinoy Favorite Mainstay 1', '2025-05-20 03:01:24', '2025-05-20 03:01:24'),
(44, 15, 20, 'Pinoy Favorite Mainstay 2', '2025-05-20 03:01:27', '2025-05-20 03:01:27'),
(45, 15, 20, 'Pinoy Favorite Mainstay 3', '2025-05-20 03:01:29', '2025-05-20 03:01:29'),
(46, 16, 10, 'Pasta 1', '2025-05-20 03:01:42', '2025-05-20 03:01:42'),
(47, 16, 10, 'Pasta 2', '2025-05-20 03:01:45', '2025-05-20 03:01:45'),
(48, 17, 10, 'Noodles 1', '2025-05-20 03:02:11', '2025-05-20 03:02:11'),
(49, 17, 10, 'Noodles 2', '2025-05-20 03:02:13', '2025-05-20 03:02:13'),
(50, 18, 13, 'Porridge', '2025-05-20 03:02:24', '2025-05-20 03:02:24'),
(51, 19, 20, 'Pinoy Favorite (Mainstay) 1', '2025-05-20 03:02:45', '2025-05-20 03:02:45'),
(52, 19, 20, 'Pinoy Favorite (Mainstay) 2', '2025-05-20 03:02:48', '2025-05-20 03:02:48'),
(53, 20, 20, 'Pinoy Favorites 1', '2025-05-20 03:03:08', '2025-05-20 03:03:08'),
(54, 20, 20, 'Pinoy Favorites 2', '2025-05-20 03:03:09', '2025-05-20 03:03:09'),
(55, 21, 21, 'Kalye Uno 1', '2025-05-20 03:04:44', '2025-05-20 03:04:44'),
(56, 21, 21, 'Kalye Uno 2', '2025-05-20 03:04:46', '2025-05-20 03:04:46'),
(57, 21, 21, 'Kalye Uno 3', '2025-05-20 03:04:47', '2025-05-20 03:04:47'),
(58, 21, 21, 'Kalye Uno 4', '2025-05-20 03:04:48', '2025-05-20 03:04:48'),
(59, 21, 21, 'Kalye Uno 5', '2025-05-20 03:04:50', '2025-05-20 03:04:50'),
(62, 1, 18, 'Vegetable Regular', '2025-05-20 03:57:45', '2025-05-20 03:57:45');

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
(33, '2025_05_06_032016_create_area_managers_table', 6),
(36, '2025_05_06_040908_create_branches_table', 7),
(37, '2025_05_06_063459_create_branch_managers_table', 8),
(40, '2025_05_06_102734_create_orders_table', 9),
(44, '2025_05_06_110018_create_order_items_table', 10),
(45, '2025_05_15_145624_create_menu_shifts_table', 11),
(50, '2025_05_19_091424_create_menu_sub_categories_table', 14),
(51, '2025_05_05_120656_create_menu_dishes_table', 15),
(52, '2025_05_15_145951_create_menu_categories_table', 16),
(55, '2025_05_20_091007_create_menu_classes_table', 18),
(56, '2025_05_16_142013_create_menu_tags_table', 19),
(57, '2025_05_20_120633_create_menu_form_elements_table', 20);

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
(59, 'App\\Models\\super_admins', 'X4r9KxLtQz7UeGvW2Fjd', 'Super Admin', '4a09430f0d3b409788efd6a0676ebe12251a2c6a1b3861341a6ac53b29d9dbaf', '[\"*\"]', '2025-05-20 05:34:57', NULL, '2025-05-18 06:47:14', '2025-05-20 05:34:57');

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
-- Indexes for table `menu_categories`
--
ALTER TABLE `menu_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu_classes`
--
ALTER TABLE `menu_classes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu_dishes`
--
ALTER TABLE `menu_dishes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `menu_dishes_dish_code_unique` (`dish_code`),
  ADD KEY `menu_dishes_sub_category_id_foreign` (`sub_category_id`);

--
-- Indexes for table `menu_dishes_categories`
--
ALTER TABLE `menu_dishes_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu_form_elements`
--
ALTER TABLE `menu_form_elements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menu_form_elements_menu_shift_id_foreign` (`menu_shift_id`),
  ADD KEY `menu_form_elements_menu_class_id_foreign` (`menu_class_id`);

--
-- Indexes for table `menu_shifts`
--
ALTER TABLE `menu_shifts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu_sub_categories`
--
ALTER TABLE `menu_sub_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu_tags`
--
ALTER TABLE `menu_tags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menu_tags_menu_class_id_foreign` (`menu_class_id`),
  ADD KEY `menu_tags_menu_sub_category_id_foreign` (`menu_sub_category_id`);

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
-- AUTO_INCREMENT for table `menu_categories`
--
ALTER TABLE `menu_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `menu_classes`
--
ALTER TABLE `menu_classes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `menu_dishes_categories`
--
ALTER TABLE `menu_dishes_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `menu_form_elements`
--
ALTER TABLE `menu_form_elements`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `menu_shifts`
--
ALTER TABLE `menu_shifts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `menu_sub_categories`
--
ALTER TABLE `menu_sub_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `menu_tags`
--
ALTER TABLE `menu_tags`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

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
  ADD CONSTRAINT `menu_dishes_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `menu_sub_categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `menu_form_elements`
--
ALTER TABLE `menu_form_elements`
  ADD CONSTRAINT `menu_form_elements_menu_class_id_foreign` FOREIGN KEY (`menu_class_id`) REFERENCES `menu_classes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `menu_form_elements_menu_shift_id_foreign` FOREIGN KEY (`menu_shift_id`) REFERENCES `menu_shifts` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `menu_tags`
--
ALTER TABLE `menu_tags`
  ADD CONSTRAINT `menu_tags_menu_class_id_foreign` FOREIGN KEY (`menu_class_id`) REFERENCES `menu_classes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `menu_tags_menu_sub_category_id_foreign` FOREIGN KEY (`menu_sub_category_id`) REFERENCES `menu_sub_categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

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
