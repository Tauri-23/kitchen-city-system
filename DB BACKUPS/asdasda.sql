-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 22, 2025 at 04:16 AM
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
-- Database: `asdasd`
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
  `menu_week` int(11) NOT NULL,
  `menu_shift_id` bigint(20) UNSIGNED DEFAULT NULL,
  `menu_dish_id` varchar(20) DEFAULT NULL,
  `menu_class_id` bigint(20) UNSIGNED DEFAULT NULL,
  `menu_sub_category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `menu_day` enum('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday') NOT NULL,
  `menu_size` enum('XL','Large','Medium','Medium Frying','Small','Small Frying') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(23, 'Bakeshop', '2025-05-20 01:35:17', '2025-05-20 20:56:07'),
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
(39, 'Themed', '2025-05-20 01:36:26', '2025-05-20 01:36:26'),
(40, 'Viand', '2025-05-21 04:56:53', '2025-05-21 04:56:53');

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
(1, 'Regular', '2025-05-20 01:56:01', '2025-05-20 21:01:07'),
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
  `dish_code` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `menu_class_id` bigint(20) UNSIGNED DEFAULT NULL,
  `menu_category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `menu_sub_category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `unit_cost` double NOT NULL DEFAULT 0,
  `srp` double NOT NULL DEFAULT 0,
  `production` enum('Commis','Commis Cooked','On Site') NOT NULL,
  `status` enum('Active','Discontinued') NOT NULL DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_dishes`
--

INSERT INTO `menu_dishes` (`id`, `dish_code`, `name`, `menu_class_id`, `menu_category_id`, `menu_sub_category_id`, `unit_cost`, `srp`, `production`, `status`, `created_at`, `updated_at`) VALUES
('1aiqyWcOjVoTZ1RRKAsr', '10000', 'CMC 3 Regular Chicken : Chicken Adobo', 1, 40, 5, 30, 39, 'Commis', 'Active', '2025-05-21 05:00:28', '2025-05-21 05:51:59');

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
(1, 1, 1, '2025-05-20 05:15:24', '2025-05-20 05:15:24'),
(3, 1, 2, '2025-05-20 08:08:21', '2025-05-20 08:08:21'),
(4, 1, 3, '2025-05-20 08:08:25', '2025-05-20 08:08:25'),
(5, 1, 4, '2025-05-20 08:08:29', '2025-05-20 08:08:29'),
(6, 1, 5, '2025-05-20 08:08:33', '2025-05-20 08:08:33'),
(7, 1, 6, '2025-05-20 08:08:36', '2025-05-20 08:08:36'),
(8, 1, 7, '2025-05-20 08:08:39', '2025-05-20 08:08:39'),
(9, 1, 8, '2025-05-20 08:08:53', '2025-05-20 08:08:53'),
(11, 1, 9, '2025-05-20 08:10:24', '2025-05-20 08:10:24'),
(12, 1, 10, '2025-05-20 08:10:27', '2025-05-20 08:10:27'),
(13, 1, 11, '2025-05-20 08:10:38', '2025-05-20 08:10:38'),
(14, 1, 12, '2025-05-20 08:10:44', '2025-05-20 08:10:44'),
(15, 2, 1, '2025-05-20 08:11:28', '2025-05-20 08:11:28'),
(16, 2, 13, '2025-05-20 08:11:37', '2025-05-20 08:11:37'),
(17, 2, 14, '2025-05-20 08:11:43', '2025-05-20 08:11:43'),
(18, 2, 2, '2025-05-20 08:11:51', '2025-05-20 08:11:51'),
(19, 2, 6, '2025-05-20 08:11:56', '2025-05-20 08:11:56'),
(20, 2, 7, '2025-05-20 08:12:01', '2025-05-20 08:12:01'),
(21, 3, 16, '2025-05-20 08:19:36', '2025-05-20 08:19:36'),
(22, 2, 8, '2025-05-20 20:42:29', '2025-05-20 20:42:29'),
(23, 2, 9, '2025-05-20 20:42:36', '2025-05-20 20:42:36'),
(24, 2, 10, '2025-05-20 20:42:40', '2025-05-20 20:42:40'),
(25, 2, 11, '2025-05-20 20:42:46', '2025-05-20 20:42:46'),
(26, 2, 15, '2025-05-20 20:42:56', '2025-05-20 20:42:56'),
(27, 3, 17, '2025-05-20 20:44:41', '2025-05-20 20:44:41'),
(28, 3, 18, '2025-05-20 20:44:45', '2025-05-20 20:44:45'),
(29, 3, 19, '2025-05-20 20:44:56', '2025-05-20 20:44:56'),
(31, 3, 20, '2025-05-20 20:45:25', '2025-05-20 20:45:25'),
(32, 3, 21, '2025-05-20 20:45:30', '2025-05-20 20:45:30'),
(33, 3, 12, '2025-05-20 20:45:35', '2025-05-20 20:45:35'),
(34, 4, 1, '2025-05-20 20:47:07', '2025-05-20 20:47:07'),
(35, 4, 13, '2025-05-20 20:47:12', '2025-05-20 20:47:12'),
(36, 4, 2, '2025-05-20 20:47:17', '2025-05-20 20:47:17'),
(37, 4, 7, '2025-05-20 20:47:22', '2025-05-20 20:47:22'),
(38, 4, 8, '2025-05-20 20:47:26', '2025-05-20 20:47:26'),
(40, 4, 9, '2025-05-20 20:47:39', '2025-05-20 20:47:39'),
(41, 4, 10, '2025-05-20 20:47:44', '2025-05-20 20:47:44'),
(42, 4, 11, '2025-05-20 20:47:49', '2025-05-20 20:47:49'),
(43, 5, 1, '2025-05-20 20:49:18', '2025-05-20 20:49:18'),
(44, 5, 13, '2025-05-20 20:49:23', '2025-05-20 20:49:23'),
(45, 5, 14, '2025-05-20 20:49:26', '2025-05-20 20:49:26'),
(46, 5, 2, '2025-05-20 20:49:30', '2025-05-20 20:49:30'),
(47, 5, 7, '2025-05-20 20:49:33', '2025-05-20 20:49:33'),
(48, 5, 8, '2025-05-20 20:49:36', '2025-05-20 20:49:36'),
(49, 5, 9, '2025-05-20 20:49:39', '2025-05-20 20:49:39'),
(50, 5, 10, '2025-05-20 20:49:43', '2025-05-20 20:49:43'),
(51, 5, 11, '2025-05-20 20:49:46', '2025-05-20 20:49:46'),
(52, 5, 15, '2025-05-20 20:49:57', '2025-05-20 20:49:57'),
(53, 6, 16, '2025-05-20 20:51:13', '2025-05-20 20:51:13'),
(54, 6, 17, '2025-05-20 20:51:18', '2025-05-20 20:51:18'),
(55, 6, 19, '2025-05-20 20:51:32', '2025-05-20 20:51:32'),
(56, 6, 20, '2025-05-20 20:51:42', '2025-05-20 20:51:42');

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
(28, '2025_05_05_115102_create_menu_dishes_categories_table', 4),
(33, '2025_05_06_032016_create_area_managers_table', 6),
(36, '2025_05_06_040908_create_branches_table', 7),
(37, '2025_05_06_063459_create_branch_managers_table', 8),
(40, '2025_05_06_102734_create_orders_table', 9),
(44, '2025_05_06_110018_create_order_items_table', 10),
(45, '2025_05_15_145624_create_menu_shifts_table', 11),
(50, '2025_05_19_091424_create_menu_sub_categories_table', 14),
(52, '2025_05_15_145951_create_menu_categories_table', 16),
(55, '2025_05_20_091007_create_menu_classes_table', 18),
(56, '2025_05_16_142013_create_menu_tags_table', 19),
(57, '2025_05_20_120633_create_menu_form_elements_table', 20),
(58, '2025_05_05_120656_create_menu_dishes_table', 21),
(61, '2025_05_05_075641_create_menus_table', 22);

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
(59, 'App\\Models\\super_admins', 'X4r9KxLtQz7UeGvW2Fjd', 'Super Admin', '4a09430f0d3b409788efd6a0676ebe12251a2c6a1b3861341a6ac53b29d9dbaf', '[\"*\"]', '2025-05-21 18:10:02', NULL, '2025-05-18 06:47:14', '2025-05-21 18:10:02');

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
  ADD PRIMARY KEY (`id`),
  ADD KEY `menus_menu_shift_id_foreign` (`menu_shift_id`),
  ADD KEY `menus_menu_dish_id_foreign` (`menu_dish_id`),
  ADD KEY `menus_menu_class_id_foreign` (`menu_class_id`),
  ADD KEY `menus_menu_sub_category_id_foreign` (`menu_sub_category_id`);

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
  ADD KEY `menu_dishes_menu_class_id_foreign` (`menu_class_id`),
  ADD KEY `menu_dishes_menu_category_id_foreign` (`menu_category_id`),
  ADD KEY `menu_dishes_menu_sub_category_id_foreign` (`menu_sub_category_id`);

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `menu_classes`
--
ALTER TABLE `menu_classes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `menu_dishes_categories`
--
ALTER TABLE `menu_dishes_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `menu_form_elements`
--
ALTER TABLE `menu_form_elements`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

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
-- Constraints for table `menus`
--
ALTER TABLE `menus`
  ADD CONSTRAINT `menus_menu_class_id_foreign` FOREIGN KEY (`menu_class_id`) REFERENCES `menu_classes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `menus_menu_dish_id_foreign` FOREIGN KEY (`menu_dish_id`) REFERENCES `menu_dishes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `menus_menu_shift_id_foreign` FOREIGN KEY (`menu_shift_id`) REFERENCES `menu_shifts` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `menus_menu_sub_category_id_foreign` FOREIGN KEY (`menu_sub_category_id`) REFERENCES `menu_sub_categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `menu_dishes`
--
ALTER TABLE `menu_dishes`
  ADD CONSTRAINT `menu_dishes_menu_category_id_foreign` FOREIGN KEY (`menu_category_id`) REFERENCES `menu_categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `menu_dishes_menu_class_id_foreign` FOREIGN KEY (`menu_class_id`) REFERENCES `menu_classes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `menu_dishes_menu_sub_category_id_foreign` FOREIGN KEY (`menu_sub_category_id`) REFERENCES `menu_sub_categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

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
