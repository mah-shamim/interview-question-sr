-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 01, 2020 at 05:56 AM
-- Server version: 5.7.31-0ubuntu0.18.04.1
-- PHP Version: 7.3.21-1+ubuntu18.04.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `med_question`
--

-- --------------------------------------------------------

--
-- Table structure for table `blogs`
--

CREATE TABLE `blogs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `blog_post` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `blog_category_id` bigint(20) UNSIGNED NOT NULL,
  `tags` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blog_categories`
--

CREATE TABLE `blog_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blog_tags`
--

CREATE TABLE `blog_tags` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `blog_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(6, '2020_08_28_072131_create_blog_categories_table', 3),
(7, '2020_08_28_072234_create_blogs_table', 3),
(8, '2020_08_28_103502_create_variants_table', 3),
(10, '2020_08_28_104103_create_blog_tags_table', 3),
(14, '2020_08_28_063029_create_products_table', 4),
(15, '2020_08_28_103644_create_product_images_table', 4),
(16, '2020_08_31_065549_create_product_variants_table', 4),
(17, '2020_08_31_073704_create_product_variant_prices_table', 4),
(18, '2020_08_31_081510_create_product_variant_price_relation_table', 4);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sku` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `title`, `sku`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Product Name', 'asdflasdf', 't is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)', '2020-08-31 02:18:53', '2020-08-31 02:18:53'),
(2, 'Product Two', 'adfsadfsasf', 't is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)', '2020-08-31 09:25:57', '2020-08-31 09:25:57'),
(3, 'Product Three', 'afdafdfasdfasasdf', 't is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)', '2020-08-31 10:21:29', '2020-08-31 10:21:29'),
(4, 'Product Four', 'afdafdfasdfasasdfadsf', 'adsfadft is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)', '2020-08-31 10:21:44', '2020-08-31 10:21:44'),
(5, 'T-Shirt', 't-shirt', 't is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)', '2020-08-31 10:37:15', '2020-08-31 10:37:15'),
(6, 'T-Shirt RED', 't-shirt-red', 't is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)', '2020-08-31 10:38:17', '2020-08-31 10:38:17'),
(7, 'Formal Shirt', 'formal-shirt', 't is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)', '2020-08-31 10:38:39', '2020-08-31 10:38:39');

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `thumbnail` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_variants`
--

CREATE TABLE `product_variants` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `variant` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `variant_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_variants`
--

INSERT INTO `product_variants` (`id`, `variant`, `variant_id`, `product_id`, `created_at`, `updated_at`) VALUES
(1, 'red', 1, 1, '2020-08-31 02:18:53', '2020-08-31 02:18:53'),
(2, 'green', 1, 1, '2020-08-31 02:18:53', '2020-08-31 02:18:53'),
(3, 'blue', 1, 1, '2020-08-31 02:18:53', '2020-08-31 02:18:53'),
(4, 'xl', 2, 1, '2020-08-31 02:18:53', '2020-08-31 02:18:53'),
(5, 'sm', 2, 1, '2020-08-31 02:18:53', '2020-08-31 02:18:53'),
(6, 'm', 2, 1, '2020-08-31 02:18:53', '2020-08-31 02:18:53'),
(7, 'XL', 2, 2, '2020-08-31 09:25:57', '2020-08-31 09:25:57'),
(8, 'L', 2, 2, '2020-08-31 09:25:57', '2020-08-31 09:25:57'),
(9, 'red', 1, 2, '2020-08-31 09:25:57', '2020-08-31 09:25:57'),
(10, 'green', 1, 2, '2020-08-31 09:25:57', '2020-08-31 09:25:57'),
(11, 'blue', 1, 2, '2020-08-31 09:25:57', '2020-08-31 09:25:57'),
(12, 'red', 1, 3, '2020-08-31 10:21:29', '2020-08-31 10:21:29'),
(13, 'green', 1, 3, '2020-08-31 10:21:30', '2020-08-31 10:21:30'),
(14, 'xl', 2, 3, '2020-08-31 10:21:30', '2020-08-31 10:21:30'),
(15, 'l', 2, 3, '2020-08-31 10:21:30', '2020-08-31 10:21:30'),
(16, 'm', 2, 3, '2020-08-31 10:21:30', '2020-08-31 10:21:30'),
(17, 'v-nick', 6, 3, '2020-08-31 10:21:30', '2020-08-31 10:21:30'),
(18, 'o-nick', 6, 3, '2020-08-31 10:21:30', '2020-08-31 10:21:30'),
(19, 'red', 1, 4, '2020-08-31 10:21:44', '2020-08-31 10:21:44'),
(20, 'green', 1, 4, '2020-08-31 10:21:44', '2020-08-31 10:21:44'),
(21, 'xl', 2, 4, '2020-08-31 10:21:44', '2020-08-31 10:21:44'),
(22, 'l', 2, 4, '2020-08-31 10:21:44', '2020-08-31 10:21:44'),
(23, 'm', 2, 4, '2020-08-31 10:21:44', '2020-08-31 10:21:44'),
(24, 'v-nick', 6, 4, '2020-08-31 10:21:44', '2020-08-31 10:21:44'),
(25, 'o-nick', 6, 4, '2020-08-31 10:21:44', '2020-08-31 10:21:44'),
(26, 'red', 1, 5, '2020-08-31 10:37:15', '2020-08-31 10:37:15'),
(27, 'green', 1, 5, '2020-08-31 10:37:15', '2020-08-31 10:37:15'),
(28, 'xl', 2, 5, '2020-08-31 10:37:15', '2020-08-31 10:37:15'),
(29, 'l', 2, 5, '2020-08-31 10:37:15', '2020-08-31 10:37:15'),
(30, 'm', 2, 5, '2020-08-31 10:37:15', '2020-08-31 10:37:15'),
(31, 'v-nick', 6, 5, '2020-08-31 10:37:15', '2020-08-31 10:37:15'),
(32, 'o-nick', 6, 5, '2020-08-31 10:37:15', '2020-08-31 10:37:15'),
(33, 'red', 1, 6, '2020-08-31 10:38:17', '2020-08-31 10:38:17'),
(34, 'green', 1, 6, '2020-08-31 10:38:17', '2020-08-31 10:38:17'),
(35, 'xl', 2, 6, '2020-08-31 10:38:18', '2020-08-31 10:38:18'),
(36, 'l', 2, 6, '2020-08-31 10:38:18', '2020-08-31 10:38:18'),
(37, 'm', 2, 6, '2020-08-31 10:38:18', '2020-08-31 10:38:18'),
(38, 'v-nick', 6, 6, '2020-08-31 10:38:18', '2020-08-31 10:38:18'),
(39, 'o-nick', 6, 6, '2020-08-31 10:38:18', '2020-08-31 10:38:18'),
(40, 'red', 1, 7, '2020-08-31 10:38:39', '2020-08-31 10:38:39'),
(41, 'green', 1, 7, '2020-08-31 10:38:39', '2020-08-31 10:38:39'),
(42, 'xl', 2, 7, '2020-08-31 10:38:39', '2020-08-31 10:38:39'),
(43, 'l', 2, 7, '2020-08-31 10:38:39', '2020-08-31 10:38:39'),
(44, 'm', 2, 7, '2020-08-31 10:38:39', '2020-08-31 10:38:39'),
(45, 'v-nick', 6, 7, '2020-08-31 10:38:39', '2020-08-31 10:38:39'),
(46, 'o-nick', 6, 7, '2020-08-31 10:38:39', '2020-08-31 10:38:39');

-- --------------------------------------------------------

--
-- Table structure for table `product_variant_prices`
--

CREATE TABLE `product_variant_prices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_variant_one` bigint(20) UNSIGNED DEFAULT NULL,
  `product_variant_two` bigint(20) UNSIGNED DEFAULT NULL,
  `product_variant_three` bigint(20) UNSIGNED DEFAULT NULL,
  `price` double NOT NULL,
  `stock` int(11) NOT NULL DEFAULT '0',
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_variant_prices`
--

INSERT INTO `product_variant_prices` (`id`, `product_variant_one`, `product_variant_two`, `product_variant_three`, `price`, `stock`, `product_id`, `created_at`, `updated_at`) VALUES
(1, 1, 4, NULL, 150, 150, 1, '2020-08-31 02:18:53', '2020-08-31 02:18:53'),
(2, 1, 5, NULL, 15, 54, 1, '2020-08-31 02:18:53', '2020-08-31 02:18:53'),
(3, 1, 6, NULL, 564564, 546, 1, '2020-08-31 02:18:53', '2020-08-31 02:18:53'),
(4, 2, 4, NULL, 54, 45, 1, '2020-08-31 02:18:53', '2020-08-31 02:18:53'),
(5, 2, 5, NULL, 45, 45, 1, '2020-08-31 02:18:53', '2020-08-31 02:18:53'),
(6, 2, 6, NULL, 454, 45, 1, '2020-08-31 02:18:53', '2020-08-31 02:18:53'),
(7, 3, 4, NULL, 45, 54, 1, '2020-08-31 02:18:53', '2020-08-31 02:18:53'),
(8, 3, 5, NULL, 54, 54, 1, '2020-08-31 02:18:53', '2020-08-31 02:18:53'),
(9, 3, 6, NULL, 54, 545, 1, '2020-08-31 02:18:53', '2020-08-31 02:18:53'),
(10, 4, 1, NULL, 150, 150, 2, '2020-08-31 09:25:57', '2020-08-31 09:25:57'),
(11, 4, 2, NULL, 15, 15, 2, '2020-08-31 09:25:57', '2020-08-31 09:25:57'),
(12, 4, 3, NULL, 15, 15, 2, '2020-08-31 09:25:57', '2020-08-31 09:25:57'),
(13, 8, 1, NULL, 15, 15, 2, '2020-08-31 09:25:57', '2020-08-31 09:25:57'),
(14, 8, 2, NULL, 15, 15, 2, '2020-08-31 09:25:57', '2020-08-31 09:25:57'),
(15, 8, 3, NULL, 51, 515, 2, '2020-08-31 09:25:57', '2020-08-31 09:25:57'),
(16, 1, 4, 17, 0, 0, 3, '2020-08-31 10:21:30', '2020-08-31 10:21:30'),
(17, 1, 4, 18, 0, 0, 3, '2020-08-31 10:21:30', '2020-08-31 10:21:30'),
(18, 1, 8, 17, 0, 0, 3, '2020-08-31 10:21:30', '2020-08-31 10:21:30'),
(19, 1, 8, 18, 0, 0, 3, '2020-08-31 10:21:30', '2020-08-31 10:21:30'),
(20, 1, 6, 17, 0, 0, 3, '2020-08-31 10:21:30', '2020-08-31 10:21:30'),
(21, 1, 6, 18, 0, 0, 3, '2020-08-31 10:21:30', '2020-08-31 10:21:30'),
(22, 2, 4, 17, 0, 0, 3, '2020-08-31 10:21:30', '2020-08-31 10:21:30'),
(23, 2, 4, 18, 0, 0, 3, '2020-08-31 10:21:30', '2020-08-31 10:21:30'),
(24, 2, 8, 17, 0, 0, 3, '2020-08-31 10:21:30', '2020-08-31 10:21:30'),
(25, 2, 8, 18, 0, 0, 3, '2020-08-31 10:21:30', '2020-08-31 10:21:30'),
(26, 2, 6, 17, 0, 0, 3, '2020-08-31 10:21:30', '2020-08-31 10:21:30'),
(27, 2, 6, 18, 0, 0, 3, '2020-08-31 10:21:30', '2020-08-31 10:21:30'),
(28, 1, 4, 17, 0, 0, 4, '2020-08-31 10:21:44', '2020-08-31 10:21:44'),
(29, 1, 4, 18, 0, 0, 4, '2020-08-31 10:21:44', '2020-08-31 10:21:44'),
(30, 1, 8, 17, 0, 0, 4, '2020-08-31 10:21:44', '2020-08-31 10:21:44'),
(31, 1, 8, 18, 0, 0, 4, '2020-08-31 10:21:44', '2020-08-31 10:21:44'),
(32, 1, 6, 17, 0, 0, 4, '2020-08-31 10:21:44', '2020-08-31 10:21:44'),
(33, 1, 6, 18, 0, 0, 4, '2020-08-31 10:21:44', '2020-08-31 10:21:44'),
(34, 2, 4, 17, 0, 0, 4, '2020-08-31 10:21:45', '2020-08-31 10:21:45'),
(35, 2, 4, 18, 0, 0, 4, '2020-08-31 10:21:45', '2020-08-31 10:21:45'),
(36, 2, 8, 17, 0, 0, 4, '2020-08-31 10:21:45', '2020-08-31 10:21:45'),
(37, 2, 8, 18, 0, 0, 4, '2020-08-31 10:21:45', '2020-08-31 10:21:45'),
(38, 2, 6, 17, 0, 0, 4, '2020-08-31 10:21:45', '2020-08-31 10:21:45'),
(39, 2, 6, 18, 0, 0, 4, '2020-08-31 10:21:45', '2020-08-31 10:21:45'),
(40, 1, 4, 17, 0, 0, 5, '2020-08-31 10:37:15', '2020-08-31 10:37:15'),
(41, 1, 4, 18, 0, 0, 5, '2020-08-31 10:37:15', '2020-08-31 10:37:15'),
(42, 1, 8, 17, 0, 0, 5, '2020-08-31 10:37:15', '2020-08-31 10:37:15'),
(43, 1, 8, 18, 0, 0, 5, '2020-08-31 10:37:15', '2020-08-31 10:37:15'),
(44, 1, 6, 17, 0, 0, 5, '2020-08-31 10:37:15', '2020-08-31 10:37:15'),
(45, 1, 6, 18, 0, 0, 5, '2020-08-31 10:37:15', '2020-08-31 10:37:15'),
(46, 2, 4, 17, 0, 0, 5, '2020-08-31 10:37:15', '2020-08-31 10:37:15'),
(47, 2, 4, 18, 0, 0, 5, '2020-08-31 10:37:15', '2020-08-31 10:37:15'),
(48, 2, 8, 17, 0, 0, 5, '2020-08-31 10:37:15', '2020-08-31 10:37:15'),
(49, 2, 8, 18, 0, 0, 5, '2020-08-31 10:37:15', '2020-08-31 10:37:15'),
(50, 2, 6, 17, 0, 0, 5, '2020-08-31 10:37:15', '2020-08-31 10:37:15'),
(51, 2, 6, 18, 0, 0, 5, '2020-08-31 10:37:15', '2020-08-31 10:37:15'),
(52, 1, 4, 17, 0, 0, 6, '2020-08-31 10:38:18', '2020-08-31 10:38:18'),
(53, 1, 4, 18, 0, 0, 6, '2020-08-31 10:38:18', '2020-08-31 10:38:18'),
(54, 1, 8, 17, 0, 0, 6, '2020-08-31 10:38:18', '2020-08-31 10:38:18'),
(55, 1, 8, 18, 0, 0, 6, '2020-08-31 10:38:18', '2020-08-31 10:38:18'),
(56, 1, 6, 17, 0, 0, 6, '2020-08-31 10:38:18', '2020-08-31 10:38:18'),
(57, 1, 6, 18, 0, 0, 6, '2020-08-31 10:38:18', '2020-08-31 10:38:18'),
(58, 2, 4, 17, 0, 0, 6, '2020-08-31 10:38:18', '2020-08-31 10:38:18'),
(59, 2, 4, 18, 0, 0, 6, '2020-08-31 10:38:18', '2020-08-31 10:38:18'),
(60, 2, 8, 17, 0, 0, 6, '2020-08-31 10:38:18', '2020-08-31 10:38:18'),
(61, 2, 8, 18, 0, 0, 6, '2020-08-31 10:38:18', '2020-08-31 10:38:18'),
(62, 2, 6, 17, 0, 0, 6, '2020-08-31 10:38:18', '2020-08-31 10:38:18'),
(63, 2, 6, 18, 0, 0, 6, '2020-08-31 10:38:18', '2020-08-31 10:38:18'),
(64, 1, 4, 17, 0, 0, 7, '2020-08-31 10:38:39', '2020-08-31 10:38:39'),
(65, 1, 4, 18, 0, 0, 7, '2020-08-31 10:38:39', '2020-08-31 10:38:39'),
(66, 1, 8, 17, 0, 0, 7, '2020-08-31 10:38:39', '2020-08-31 10:38:39'),
(67, 1, 8, 18, 0, 0, 7, '2020-08-31 10:38:39', '2020-08-31 10:38:39'),
(68, 1, 6, 17, 0, 0, 7, '2020-08-31 10:38:40', '2020-08-31 10:38:40'),
(69, 1, 6, 18, 0, 0, 7, '2020-08-31 10:38:40', '2020-08-31 10:38:40'),
(70, 2, 4, 17, 0, 0, 7, '2020-08-31 10:38:40', '2020-08-31 10:38:40'),
(71, 2, 4, 18, 0, 0, 7, '2020-08-31 10:38:40', '2020-08-31 10:38:40'),
(72, 2, 8, 17, 0, 0, 7, '2020-08-31 10:38:40', '2020-08-31 10:38:40'),
(73, 2, 8, 18, 0, 0, 7, '2020-08-31 10:38:40', '2020-08-31 10:38:40'),
(74, 2, 6, 17, 0, 0, 7, '2020-08-31 10:38:40', '2020-08-31 10:38:40'),
(75, 2, 6, 18, 0, 0, 7, '2020-08-31 10:38:40', '2020-08-31 10:38:40');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'admin@example.com', NULL, '$2y$10$NfLWLL9Mj6dCi0fQ3TBqWO53ZFsDlGUZmFl.gILMhHDHVi34XwWKW', NULL, '2020-08-28 00:03:42', '2020-08-28 00:03:42');

-- --------------------------------------------------------

--
-- Table structure for table `variants`
--

CREATE TABLE `variants` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `variants`
--

INSERT INTO `variants` (`id`, `title`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Color', 'asdfadsf', NULL, '2020-08-31 08:53:32'),
(2, 'Size', 'adfsasdf', NULL, '2020-08-31 08:54:28'),
(6, 'Style', 'Description', '2020-08-31 09:46:24', '2020-08-31 09:46:24');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blogs`
--
ALTER TABLE `blogs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blogs_blog_category_id_foreign` (`blog_category_id`);

--
-- Indexes for table `blog_categories`
--
ALTER TABLE `blog_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `blog_categories_slug_unique` (`slug`);

--
-- Indexes for table `blog_tags`
--
ALTER TABLE `blog_tags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_tags_blog_id_foreign` (`blog_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
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
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `products_sku_unique` (`sku`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_images_product_id_foreign` (`product_id`);

--
-- Indexes for table `product_variants`
--
ALTER TABLE `product_variants`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_variants_variant_id_foreign` (`variant_id`),
  ADD KEY `product_variants_product_id_foreign` (`product_id`);

--
-- Indexes for table `product_variant_prices`
--
ALTER TABLE `product_variant_prices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_variant_prices_product_id_foreign` (`product_id`),
  ADD KEY `product_variant_prices_product_variant_one_foreign` (`product_variant_one`),
  ADD KEY `product_variant_prices_product_variant_two_foreign` (`product_variant_two`),
  ADD KEY `product_variant_prices_product_variant_three_foreign` (`product_variant_three`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `variants`
--
ALTER TABLE `variants`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `variants_title_unique` (`title`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `blogs`
--
ALTER TABLE `blogs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `blog_categories`
--
ALTER TABLE `blog_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `blog_tags`
--
ALTER TABLE `blog_tags`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `product_variants`
--
ALTER TABLE `product_variants`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;
--
-- AUTO_INCREMENT for table `product_variant_prices`
--
ALTER TABLE `product_variant_prices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `variants`
--
ALTER TABLE `variants`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `blogs`
--
ALTER TABLE `blogs`
  ADD CONSTRAINT `blogs_blog_category_id_foreign` FOREIGN KEY (`blog_category_id`) REFERENCES `blog_categories` (`id`);

--
-- Constraints for table `blog_tags`
--
ALTER TABLE `blog_tags`
  ADD CONSTRAINT `blog_tags_blog_id_foreign` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`id`);

--
-- Constraints for table `product_images`
--
ALTER TABLE `product_images`
  ADD CONSTRAINT `product_images_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `product_variants`
--
ALTER TABLE `product_variants`
  ADD CONSTRAINT `product_variants_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_variants_variant_id_foreign` FOREIGN KEY (`variant_id`) REFERENCES `variants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_variant_prices`
--
ALTER TABLE `product_variant_prices`
  ADD CONSTRAINT `product_variant_prices_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_variant_prices_product_variant_one_foreign` FOREIGN KEY (`product_variant_one`) REFERENCES `product_variants` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_variant_prices_product_variant_three_foreign` FOREIGN KEY (`product_variant_three`) REFERENCES `product_variants` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_variant_prices_product_variant_two_foreign` FOREIGN KEY (`product_variant_two`) REFERENCES `product_variants` (`id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
