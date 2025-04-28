-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 28, 2025 at 02:04 PM
-- Server version: 10.4.28-MariaDB-log
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `audit_tool`
--

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` int(11) NOT NULL,
  `event_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `event_type` varchar(255) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `details` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `event_time`, `event_type`, `user`, `host`, `details`) VALUES
(1, '2025-03-24 10:26:46', 'Login Attempt', 'root', '127.0.0.1', 'Login attempt by root from 127.0.0.1'),
(2, '2025-03-24 10:26:46', 'Login Attempt', 'root', '::1', 'Login attempt by root from ::1'),
(3, '2025-03-24 10:26:46', 'Login Attempt', 'pma', 'localhost', 'Login attempt by pma from localhost'),
(4, '2025-03-24 10:26:46', 'Login Attempt', 'root', 'localhost', 'Login attempt by root from localhost'),
(8, '2025-03-24 10:26:46', 'Privilege Check', 'root', 'localhost', 'User root has SUPER privilege'),
(9, '2025-03-24 10:26:46', 'Privilege Check', 'root', '127.0.0.1', 'User root has SUPER privilege'),
(10, '2025-03-24 10:26:46', 'Privilege Check', 'root', '::1', 'User root has SUPER privilege'),
(11, '2025-03-24 10:26:46', 'Database Check', '', '%', 'User  has access to: test,test\\_%'),
(12, '2025-03-24 10:26:46', 'Database Check', 'pma', 'localhost', 'User pma has access to: phpmyadmin'),
(14, '2025-03-24 10:26:46', 'Schema Check', 'system', NULL, 'Checking MySQL schema version');

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
-- Table structure for table `failed_logins`
--

CREATE TABLE `failed_logins` (
  `id` int(11) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `attempt_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `failed_logins`
--

INSERT INTO `failed_logins` (`id`, `username`, `host`, `attempt_time`) VALUES
(1, NULL, '127.0.0.1', '2025-04-28 08:22:29'),
(2, NULL, '127.0.0.1', '2025-04-28 08:23:05'),
(3, 'wrongemail@example.com', '127.0.0.1', '2025-04-28 08:24:16'),
(4, NULL, '127.0.0.1', '2025-04-28 09:40:29'),
(5, NULL, '127.0.0.1', '2025-04-28 09:53:18');

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
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2025_04_28_101930_add_role_to_users_table', 2),
(6, '2025_04_28_112637_add_users_table', 3),
(7, '2025_04_28_112941_add_failed_jobs_table', 4),
(8, '2025_04_28_113103_add_personal_access_tokens_table', 5),
(9, '2025_04_28_113140_add_password_reset_table', 6);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
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

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'YourAppName', 'f2ae86d06cca8cf36ac5e768c0d2882d05ef8fe6e24df7c3b21e0fd31c7dfa86', '[\"*\"]', '2025-04-28 06:40:12', NULL, '2025-04-28 06:38:43', '2025-04-28 06:40:12');

-- --------------------------------------------------------

--
-- Table structure for table `suspicious_queries`
--

CREATE TABLE `suspicious_queries` (
  `id` int(11) NOT NULL,
  `query_text` text DEFAULT NULL,
  `execution_time` float DEFAULT NULL,
  `detected_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suspicious_queries`
--

INSERT INTO `suspicious_queries` (`id`, `query_text`, `execution_time`, `detected_at`) VALUES
(1, 'SELECT * FROM big_table', 12.5, '2025-04-28 08:27:17'),
(2, 'SET timestamp=1745830385;\nSELECT SLEEP(5);', 4.99991, '2025-04-28 04:06:12'),
(3, 'SET timestamp=1745830610;\nSELECT SLEEP(5);', 5.01385, '2025-04-28 04:06:12');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','auditor','viewer') NOT NULL DEFAULT 'viewer',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `role`, `created_at`, `updated_at`) VALUES
(1, 'admin_user', 'admin_user@example.com', '$2y$10$yO/P/YmgRGZ0zx2iWWTpJut29KAiBi46Agec1hQwILxT8IxAukrBG', 'admin', '2025-04-28 06:34:32', '2025-04-28 06:34:32'),
(2, 'auditor_user', 'auditor_user@example.com', '$2y$10$YQTPRUWdIn74erH36qVtRuULWVpt.jLcRksy4GbnN8PACDkvlZG/O', 'auditor', '2025-04-28 06:34:32', '2025-04-28 06:34:32'),
(3, 'viewer_user', 'viewer_user@example.com', '$2y$10$4TWNLiB.zI6FIyvSvbY0jOznqmy6meCdrkLt0ZzQQnVXnEVd4QNSW', 'viewer', '2025-04-28 06:34:32', '2025-04-28 06:34:32');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `failed_logins`
--
ALTER TABLE `failed_logins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `suspicious_queries`
--
ALTER TABLE `suspicious_queries`
  ADD PRIMARY KEY (`id`);

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
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_logins`
--
ALTER TABLE `failed_logins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `suspicious_queries`
--
ALTER TABLE `suspicious_queries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
