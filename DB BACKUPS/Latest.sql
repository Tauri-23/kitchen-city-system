-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 05, 2025 at 07:30 PM
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
CREATE DATABASE IF NOT EXISTS `kitchen_city` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `kitchen_city`;

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
('1ZL7C7yTZWmtxDngZVbI', 'Monday Week 1 Bfast Small', 1, 'Monday', 'Breakfast', 'Small', '2025-05-05 03:30:29', '2025-05-05 03:30:29'),
('3ati547ryA4mBp58aOjt', 'Monday Week 1 Bfast Small Frying', 1, 'Monday', 'Breakfast', 'Small Frying', '2025-05-05 03:30:41', '2025-05-05 03:30:41'),
('dgvm2369GPnC3GFveBvz', 'Monday Week 1 Bfast XL', 1, 'Monday', 'Breakfast', 'XL', '2025-05-05 03:27:02', '2025-05-05 03:27:02'),
('HtxLTdZrsgxdr3VUnyZ7', 'Monday Week 1 Bfast Medium Frying', 1, 'Monday', 'Breakfast', 'Medium Frying', '2025-05-05 03:30:17', '2025-05-05 03:30:17'),
('kC7tpGtkRvFiK9KmSb04', 'Monday Week 2 Bfast XL', 2, 'Monday', 'Breakfast', 'XL', '2025-05-05 06:44:04', '2025-05-05 06:44:04'),
('mMTZ1Psoz8nJEU3sGEk8', 'Monday Week 1 Bfast Large', 1, 'Monday', 'Breakfast', 'Large', '2025-05-05 03:29:49', '2025-05-05 03:29:49'),
('ya3COfeKED5rUwp1diAA', 'Monday Week 1 Bfast Medium', 1, 'Monday', 'Breakfast', 'Medium', '2025-05-05 03:30:02', '2025-05-05 03:30:02');

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
('1zUvajqOBOr4fzOIIszD', 'dgvm2369GPnC3GFveBvz', 'Canned Goods', 'CMC 3 Coldcuts : Luncheon Meat', 1, 16.15, 'On Site', 'Active', '2025-05-05 08:42:27', '2025-05-05 08:42:27'),
('8rvSPY0xEmgP591EQWDM', 'dgvm2369GPnC3GFveBvz', 'Cold Cuts', 'CMC 3 Coldcuts : Fried Hungarian Sausage', 1, 36.35, 'On Site', 'Active', '2025-05-05 08:41:10', '2025-05-05 08:41:10'),
('g6cYFzpU8WRK1XnvbOmL', 'dgvm2369GPnC3GFveBvz', 'Cold Cuts', 'CMC 3 Coldcuts : Fried German Franks', 1, 26.62, 'On Site', 'Active', '2025-05-05 12:43:32', '2025-05-05 12:43:32');

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
(13, 'Baked', '2025-05-05 11:58:58', '2025-05-05 11:58:58');

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
(31, '2025_05_05_120656_create_menu_dishes_table', 5);

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
(1, 'App\\Models\\super_admins', 'X4r9KxLtQz7UeGvW2Fjd', 'superAdmin', '2757ddfd467736c3b02fe027706c4997ddb893ad537c004a7bcd82c222e6e6ac', '[\"*\"]', NULL, NULL, '2025-05-04 18:27:58', '2025-05-04 18:27:58'),
(2, 'App\\Models\\super_admins', 'X4r9KxLtQz7UeGvW2Fjd', 'superAdmin', 'e3453110c58b83019e13275fc1db945fc437936a222f96aeee2368391273bf1d', '[\"*\"]', NULL, NULL, '2025-05-04 18:28:01', '2025-05-04 18:28:01'),
(3, 'App\\Models\\super_admins', 'X4r9KxLtQz7UeGvW2Fjd', 'superAdmin', 'ecffd2f4e554870e4c0a42a46068b9e6293fe0795bb329540c6b9cd0b4e57c5d', '[\"*\"]', NULL, NULL, '2025-05-04 18:28:19', '2025-05-04 18:28:19'),
(4, 'App\\Models\\super_admins', 'X4r9KxLtQz7UeGvW2Fjd', 'superAdmin', '00d8b28853f47dd6850911f1bbbd4174af00d6f6c8d5ef490c4a4e6807416d43', '[\"*\"]', NULL, NULL, '2025-05-04 18:28:29', '2025-05-04 18:28:29'),
(5, 'App\\Models\\super_admins', 'X4r9KxLtQz7UeGvW2Fjd', 'superAdmin', 'b16fe3d5e25174d146cefff6c5e37eb2d2aa4d360fc963ffeb79fa8eaf363672', '[\"*\"]', NULL, NULL, '2025-05-04 18:29:21', '2025-05-04 18:29:21'),
(6, 'App\\Models\\super_admins', 'X4r9KxLtQz7UeGvW2Fjd', 'superAdmin', '3b981e279492883ba325fc4ce377c8ee998082ca8b328793004c1ad9373914a4', '[\"*\"]', NULL, NULL, '2025-05-04 18:29:22', '2025-05-04 18:29:22'),
(7, 'App\\Models\\super_admins', 'X4r9KxLtQz7UeGvW2Fjd', 'superAdmin', 'ff357c5a04b310116534181af4c7c9db0d19fb267ceb4e6e816a29e1ed3fbac7', '[\"*\"]', NULL, NULL, '2025-05-04 18:29:39', '2025-05-04 18:29:39'),
(8, 'App\\Models\\super_admins', 'X4r9KxLtQz7UeGvW2Fjd', 'superAdmin', '81adcc7062f1b9cce17e55fa960ae32901fa4163e9760295c99c5e2c8a7ab7a3', '[\"*\"]', NULL, NULL, '2025-05-04 18:29:41', '2025-05-04 18:29:41'),
(9, 'App\\Models\\super_admins', 'X4r9KxLtQz7UeGvW2Fjd', 'superAdmin', '9c6662256960b9a3df3017b9b7e55f285e15222740fcf237b911c40d1dd2657d', '[\"*\"]', NULL, NULL, '2025-05-04 18:29:42', '2025-05-04 18:29:42'),
(10, 'App\\Models\\super_admins', 'X4r9KxLtQz7UeGvW2Fjd', 'superAdmin', '08ec012814cb47c26ca27044b1d3819d33b7d71e7ea2e99cd87a29c8c25de579', '[\"*\"]', NULL, NULL, '2025-05-04 18:30:16', '2025-05-04 18:30:16'),
(11, 'App\\Models\\super_admins', 'X4r9KxLtQz7UeGvW2Fjd', 'superAdmin', '1081cd7f993afe74540f58bda43945aed090b2b464e48305a4cfe7d6674fda84', '[\"*\"]', NULL, NULL, '2025-05-04 18:30:50', '2025-05-04 18:30:50'),
(12, 'App\\Models\\super_admins', 'X4r9KxLtQz7UeGvW2Fjd', 'superAdmin', 'dc6160cae04d749979ad7ff0d0e8a499d9d6342ae61b110d746f0f10afb1ea28', '[\"*\"]', '2025-05-04 19:27:53', NULL, '2025-05-04 18:31:19', '2025-05-04 19:27:53'),
(13, 'App\\Models\\super_admins', 'X4r9KxLtQz7UeGvW2Fjd', 'superAdmin', '81f05124f0678aa2992c0f1cf01679faabd5c1c41d6ff2b8c3482de01214685e', '[\"*\"]', '2025-05-05 09:29:51', NULL, '2025-05-04 20:47:51', '2025-05-05 09:29:51');

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `menu_dishes`
--
ALTER TABLE `menu_dishes`
  ADD CONSTRAINT `menu_dishes_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `menu_dishes_categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `menu_dishes_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
