-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: mysql_db_koi_development
-- Thời gian đã tạo: Th10 25, 2024 lúc 01:09 AM
-- Phiên bản máy phục vụ: 9.0.1
-- Phiên bản PHP: 8.2.24

DROP DATABASE IF EXISTS koi_company;
-- Nếu cơ sở dữ liệu koi_company chưa tồn tại, thực hiện câu lệnh CREATE DATABASE
CREATE DATABASE IF NOT EXISTS koi_company;

-- Sử dụng cơ sở dữ liệu koi_company
USE koi_company;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `koi_company`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auctions`
--

CREATE TABLE `auctions` (
  `auctioneer_id` bigint DEFAULT NULL,
  `end_time` datetime(6) DEFAULT NULL,
  `id` bigint NOT NULL,
  `start_time` datetime(6) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` enum('ENDED','ONGOING','UPCOMING') COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `auctions`
--

INSERT INTO `auctions` (`auctioneer_id`, `end_time`, `id`, `start_time`, `title`, `status`) VALUES
(23, '2024-10-30 14:41:38.679000', 1, '2024-10-06 14:41:38.679000', 'This is Fixed Price Auction', 'ENDED'),
(21, '2024-10-17 14:35:00.000000', 3, '2024-10-15 14:35:00.000000', 'Auction 3', 'ENDED'),
(21, '2024-10-17 16:50:00.000000', 4, '2024-10-15 16:50:00.000000', 'Auction 4', 'ENDED'),
(22, '2024-11-09 21:38:54.037519', 9, '2024-11-09 21:38:54.037519', 'Auction 9', 'ENDED'),
(21, '2024-11-14 20:05:00.670000', 11, '2024-11-11 09:35:00.670000', 'Winter Auction', 'ENDED'),
(21, '2024-11-15 20:06:00.000000', 12, '2024-11-11 20:04:00.000000', 'Quick Auction', 'ENDED'),
(22, '2024-11-12 00:20:50.487000', 13, '2024-11-11 22:47:50.487000', 'Kantan Auction', 'ENDED'),
(22, '2024-11-12 22:10:00.000000', 19, '2024-11-10 21:30:00.000000', 'Auction 18', 'ENDED'),
(21, '2024-11-15 09:54:00.670000', 22, '2024-11-12 10:15:00.670000', 'Auction 22', 'ENDED'),
(21, '2024-12-07 17:46:00.000000', 27, '2024-11-21 11:00:00.000000', 'This is All Method Test Auction', 'ONGOING'),
(22, '2024-11-17 22:00:00.000000', 28, '2024-11-15 18:00:00.000000', 'Auction Test All Method', 'ENDED'),
(14, '2024-11-23 10:00:00.000000', 30, '2024-11-21 11:00:00.000000', 'This is Fixed Price Test Auction', 'ENDED'),
(21, '2024-11-23 10:00:00.000000', 31, '2024-11-21 11:00:00.000000', 'This is Ascending Test Auction', 'ENDED'),
(14, '2024-11-23 10:00:00.000000', 32, '2024-11-21 11:00:00.000000', 'This is Descending Test Auction', 'ENDED'),
(14, '2024-11-23 14:50:00.000000', 33, '2024-11-21 14:15:00.000000', 'Final Test All Method Auction', 'ENDED');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auction_kois`
--

CREATE TABLE `auction_kois` (
  `is_sold` tinyint(1) NOT NULL DEFAULT '0',
  `revoked` int NOT NULL DEFAULT '0',
  `auction_id` bigint DEFAULT NULL,
  `base_price` bigint DEFAULT NULL,
  `bid_step` bigint DEFAULT '0',
  `ceil_price` bigint DEFAULT NULL,
  `current_bid` bigint DEFAULT NULL,
  `current_bidder_id` bigint DEFAULT NULL,
  `id` bigint NOT NULL,
  `koi_id` bigint DEFAULT NULL,
  `bid_method` enum('ASCENDING_BID','DESCENDING_BID','FIXED_PRICE','SEALED_BID') COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `auction_kois`
--

INSERT INTO `auction_kois` (`is_sold`, `revoked`, `auction_id`, `base_price`, `bid_step`, `ceil_price`, `current_bid`, `current_bidder_id`, `id`, `koi_id`, `bid_method`) VALUES
(0, 0, 1, 2000000, 0, NULL, 0, 0, 1, 117, 'FIXED_PRICE'),
(0, 0, 1, 2000000, 0, NULL, 0, 0, 2, 324, 'FIXED_PRICE'),
(0, 0, 1, 2000000, 0, NULL, 0, 0, 3, 123, 'FIXED_PRICE'),
(0, 0, 1, 2000000, 0, NULL, 0, 0, 4, 333, 'FIXED_PRICE'),
(0, 0, 1, 2000000, 0, NULL, 0, 0, 5, 222, 'FIXED_PRICE'),
(0, 0, 1, 2000000, 0, NULL, 0, 0, 6, 165, 'FIXED_PRICE'),
(0, 0, 1, 2000000, 0, NULL, 0, 0, 7, 334, 'FIXED_PRICE'),
(0, 0, 1, 2000000, 0, NULL, 0, 0, 8, 97, 'FIXED_PRICE'),
(0, 0, 1, 2000000, 0, NULL, 0, 0, 9, 66, 'FIXED_PRICE'),
(0, 0, 1, 2000000, 0, NULL, 0, 0, 10, 61, 'FIXED_PRICE'),
(0, 0, 3, 1000000, 50000, 10000000, 1000000, 0, 21, 201, 'ASCENDING_BID'),
(0, 0, 4, 1000000, 50000, 10000000, 1000000, 0, 22, 7, 'DESCENDING_BID'),
(0, 0, 4, 1000000, 50000, 10000000, 1000000, 0, 23, 8, 'DESCENDING_BID'),
(0, 0, 4, 1000000, 50000, 10000000, 1000000, 0, 24, 12, 'DESCENDING_BID'),
(0, 0, 9, 1000000, 50000, 10000000, 0, 0, 26, 401, 'ASCENDING_BID'),
(0, 0, 9, 1000000, 50000, 10000000, 0, 0, 27, 6, 'ASCENDING_BID'),
(0, 0, 9, 1000000, 50000, 10000000, 0, 0, 28, 226, 'ASCENDING_BID'),
(0, 0, 11, 1000000, 50000, 10000000, 0, 0, 29, 291, 'ASCENDING_BID'),
(0, 0, 11, 1000000, 50000, 10000000, 0, 0, 30, 405, 'ASCENDING_BID'),
(0, 0, 12, 1000000, 50000, 10000000, 0, 0, 31, 2, 'ASCENDING_BID'),
(0, 0, 12, 1000000, 50000, 10000000, 0, 0, 32, 7, 'ASCENDING_BID'),
(0, 0, 11, 1000000, 50000, 10000000, 0, 0, 33, 407, 'ASCENDING_BID'),
(0, 0, 11, 1000000, 50000, 10000000, 0, 0, 34, 411, 'ASCENDING_BID'),
(0, 0, 19, 1000000, 50000, 10000000, 0, 0, 35, 413, 'ASCENDING_BID'),
(0, 0, 19, 1000000, 0, NULL, 0, 0, 37, 206, 'FIXED_PRICE'),
(0, 0, 19, 1000000, 0, NULL, 0, 0, 38, 15, 'FIXED_PRICE'),
(0, 0, 19, 1000000, 50000, 5000000, 1000000, 0, 39, 170, 'DESCENDING_BID'),
(0, 0, 19, 1000000, 50000, 50000000, 1000000, 0, 40, 107, 'DESCENDING_BID'),
(0, 0, 19, 1000000, 50000, 10000000, 0, 0, 41, 356, 'ASCENDING_BID'),
(0, 0, 11, 1000000, 50000, 10000000, 0, 0, 44, 416, 'ASCENDING_BID'),
(0, 0, 11, 1000000, 50000, 10000000, 0, 0, 45, 417, 'ASCENDING_BID'),
(0, 0, 13, 1000000, 50000, 10000000, 0, 0, 46, 6, 'ASCENDING_BID'),
(0, 0, 13, 1000000, 50000, 10000000, 0, 0, 47, 226, 'ASCENDING_BID'),
(0, 0, 22, 1200000, 0, NULL, 0, 0, 48, 418, 'FIXED_PRICE'),
(0, 0, 28, 1000000, 50000, 10000000, 0, 0, 49, 404, 'ASCENDING_BID'),
(0, 0, 28, 1000000, 50000, 10000000, 0, 0, 50, 405, 'ASCENDING_BID'),
(0, 0, 28, 1000000, 50000, 10000000, 0, 0, 51, 411, 'ASCENDING_BID'),
(0, 0, 28, 1000000, 50000, 7000000, 1000000, 0, 52, 18, 'DESCENDING_BID'),
(0, 0, 28, 1000000, 100000, 10000000, 1000000, 0, 53, 61, 'DESCENDING_BID'),
(0, 0, 28, 2000000, 100000, 10000000, 2000000, 0, 54, 86, 'DESCENDING_BID'),
(0, 0, 28, 2500000, 0, NULL, 0, 0, 55, 11, 'FIXED_PRICE'),
(0, 0, 28, 2500000, 0, NULL, 0, 0, 56, 20, 'FIXED_PRICE'),
(0, 0, 28, 5000000, 0, NULL, 0, 0, 57, 16, 'FIXED_PRICE'),
(0, 0, 27, 1000000, 50000, 10000000, 0, 0, 58, 53, 'ASCENDING_BID'),
(0, 0, 27, 1000000, 50000, 10000000, 0, 0, 59, 419, 'ASCENDING_BID'),
(0, 0, 27, 1000000, 50000, 10000000, 0, 0, 60, 106, 'ASCENDING_BID'),
(0, 0, 27, 1000000, 50000, 10000000, 0, 0, 61, 197, 'ASCENDING_BID'),
(0, 0, 27, 1000000, 100000, 2000000, 1000000, 0, 62, 257, 'DESCENDING_BID'),
(0, 0, 27, 1000000, 50000, 10000000, 0, 0, 63, 406, 'ASCENDING_BID'),
(0, 0, 27, 50000000, 0, NULL, 0, 0, 64, 322, 'FIXED_PRICE'),
(0, 0, 27, 3000000, 50000, 15000000, 12850000, 0, 65, 328, 'DESCENDING_BID'),
(0, 0, 27, 2500000, 50000, 25000000, 22850000, 0, 66, 152, 'DESCENDING_BID'),
(0, 0, 27, 15000000, 0, NULL, 0, 0, 67, 33, 'FIXED_PRICE'),
(0, 0, 27, 2500000, 0, NULL, 0, 0, 68, 421, 'FIXED_PRICE'),
(0, 0, 30, 10000000, 0, NULL, 0, 0, 69, 413, 'FIXED_PRICE'),
(0, 0, 31, 1500000, 50000, 7500000, 0, 0, 70, 414, 'ASCENDING_BID'),
(0, 0, 32, 1000000, 50000, 10000000, 8500000, 0, 71, 415, 'DESCENDING_BID'),
(0, 0, 27, 5000000, 0, NULL, 0, 0, 72, 418, 'FIXED_PRICE'),
(0, 0, 30, 5000000, 0, NULL, 0, 0, 73, 2, 'FIXED_PRICE'),
(0, 0, 27, 5000000, 50000, 10000000, 7850000, 0, 74, 7, 'DESCENDING_BID'),
(0, 0, 27, 1000000, 50000, 2500000, 1000000, 0, 75, 35, 'DESCENDING_BID'),
(0, 0, 27, 5000000, 100000, 20000000, 15700000, 0, 76, 60, 'DESCENDING_BID'),
(0, 0, 27, 2500000, 0, NULL, 0, 0, 77, 167, 'FIXED_PRICE'),
(0, 0, 30, 3500000, 0, NULL, 0, 0, 78, 4, 'FIXED_PRICE'),
(0, 0, 30, 5000000, 0, NULL, 0, 0, 79, 15, 'FIXED_PRICE'),
(0, 0, 31, 1000000, 50000, 5000000, 0, 0, 80, 37, 'ASCENDING_BID'),
(0, 0, 30, 25000000, 0, NULL, 0, 0, 81, 11, 'FIXED_PRICE'),
(0, 0, 30, 5000000, 0, NULL, 0, 0, 82, 16, 'FIXED_PRICE'),
(0, 0, 30, 5250000, 0, NULL, 0, 0, 83, 20, 'FIXED_PRICE'),
(0, 0, 31, 1500000, 50000, 5000000, 0, 0, 84, 14, 'ASCENDING_BID'),
(0, 0, 31, 1500000, 75000, 2500000, 0, 0, 85, 57, 'ASCENDING_BID'),
(0, 0, 32, 5000000, 75000, 15000000, 12750000, 0, 86, 64, 'DESCENDING_BID'),
(0, 0, 32, 1500000, 50000, 5000000, 3500000, 0, 87, 80, 'DESCENDING_BID'),
(0, 0, 32, 5000000, 75000, 15000000, 12750000, 0, 88, 83, 'DESCENDING_BID'),
(0, 0, 30, 5000000, 0, NULL, 0, 0, 89, 48, 'FIXED_PRICE'),
(0, 0, 30, 15000000, 0, NULL, 0, 0, 90, 55, 'FIXED_PRICE'),
(0, 0, 30, 2500000, 0, NULL, 0, 0, 91, 67, 'FIXED_PRICE'),
(0, 0, 30, 3750000, 0, NULL, 0, 0, 92, 69, 'FIXED_PRICE'),
(0, 0, 30, 10000000, 0, NULL, 0, 0, 93, 238, 'FIXED_PRICE'),
(0, 0, 31, 15000000, 150000, 25000000, 0, 0, 94, 71, 'ASCENDING_BID'),
(0, 0, 31, 1500000, 50000, 5000000, 0, 0, 95, 75, 'ASCENDING_BID'),
(0, 0, 31, 1000000, 50000, 9500000, 0, 0, 96, 103, 'ASCENDING_BID'),
(0, 0, 31, 3000000, 100000, 10000000, 0, 0, 97, 84, 'ASCENDING_BID'),
(0, 0, 32, 5000000, 50000, 10000000, 8500000, 0, 98, 98, 'DESCENDING_BID'),
(0, 0, 32, 7500000, 340000, 75000000, 64800000, 0, 99, 96, 'DESCENDING_BID'),
(0, 0, 32, 1000000, 100000, 5000000, 2000000, 0, 100, 144, 'DESCENDING_BID'),
(0, 0, 32, 1500000, 50000, 7500000, 6000000, 0, 101, 120, 'DESCENDING_BID'),
(0, 0, 31, 1000000, 50000, 7500000, 0, 0, 102, 29, 'ASCENDING_BID'),
(0, 0, 31, 7500000, 100000, 10000000, 0, 0, 103, 30, 'ASCENDING_BID'),
(0, 0, 31, 1000000, 50000, 5000000, 0, 0, 104, 34, 'ASCENDING_BID'),
(0, 0, 33, 1000000, 50000, 2000000, 0, 0, 105, 170, 'ASCENDING_BID'),
(0, 0, 33, 5000000, 50000, 12000000, 0, 0, 106, 206, 'ASCENDING_BID'),
(0, 0, 33, 1200000, 50000, 5000000, 0, 0, 107, 196, 'ASCENDING_BID'),
(0, 0, 33, 2500000, 100000, 5000000, 0, 0, 108, 237, 'ASCENDING_BID'),
(0, 0, 33, 5000000, 50000, 15000000, 14000000, 0, 109, 38, 'DESCENDING_BID'),
(0, 0, 33, 1000000, 50000, 7500000, 6500000, 0, 110, 40, 'DESCENDING_BID'),
(0, 0, 33, 1000000, 50000, 10000000, 9000000, 0, 111, 45, 'DESCENDING_BID'),
(0, 0, 33, 3500000, 50000, 15000000, 14000000, 0, 112, 78, 'DESCENDING_BID'),
(0, 0, 33, 3000000, 0, NULL, 0, 0, 113, 5, 'FIXED_PRICE'),
(0, 0, 33, 5000000, 0, NULL, 0, 0, 114, 25, 'FIXED_PRICE'),
(0, 0, 33, 6400000, 0, NULL, 0, 0, 115, 50, 'FIXED_PRICE'),
(0, 0, 33, 9900000, 0, NULL, 0, 0, 116, 26, 'FIXED_PRICE');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auction_kois_details`
--

CREATE TABLE `auction_kois_details` (
  `auction_koi_id` bigint DEFAULT NULL,
  `bid_amount` bigint DEFAULT NULL,
  `bid_time` datetime(6) DEFAULT NULL,
  `id` bigint NOT NULL,
  `user_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auction_participants`
--

CREATE TABLE `auction_participants` (
  `auction_id` bigint DEFAULT NULL,
  `id` bigint NOT NULL,
  `join_time` datetime(6) DEFAULT NULL,
  `user_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Kohaku'),
(2, 'Taisho Sanke'),
(3, 'Showa Sanshoku'),
(4, 'Utsurimono'),
(5, 'Shiro Utsuri'),
(6, 'Hi Utsuri'),
(7, 'Ki Utsuri'),
(8, 'Asagi'),
(9, 'Shusui'),
(10, 'Bekko'),
(11, 'Tancho'),
(12, 'Ginrin Kohaku'),
(13, 'Ginrin Sanke'),
(14, 'Ginrin Showa'),
(15, 'Doitsu Kohaku'),
(16, 'Doitsu Sanke'),
(17, 'Doitsu Showa'),
(18, 'Kin Kikokuryu'),
(19, 'Kumonryu'),
(20, 'Ochiba Shigure');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `feedbacks`
--

CREATE TABLE `feedbacks` (
  `rating` int DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `id` bigint NOT NULL,
  `order_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `content` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `kois`
--

CREATE TABLE `kois` (
  `category_id` int DEFAULT NULL,
  `is_display` int DEFAULT NULL,
  `length` int DEFAULT NULL,
  `year_born` int DEFAULT NULL,
  `base_price` bigint DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `id` bigint NOT NULL,
  `owner_id` bigint DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `thumbnail` varchar(300) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name` varchar(350) COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sex` enum('FEMALE','MALE','UNKNOWN') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` enum('REJECTED','SOLD','UNVERIFIED','VERIFIED') COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `kois`
--

INSERT INTO `kois` (`category_id`, `is_display`, `length`, `year_born`, `base_price`, `created_at`, `id`, `owner_id`, `updated_at`, `thumbnail`, `name`, `description`, `sex`, `status`) VALUES
(1, 1, 36, 2023, 1000000, '2023-06-05 00:00:00.000000', 1, 26, '2024-11-19 00:27:24.325261', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Doitsu%20Showa%2026cm%20tosai.png', 'Doitsu Showaaaa', 'A beautiful Doitsuuuuu Showa koi', 'FEMALE', 'VERIFIED'),
(1, 1, 26, 2023, 1000000, '2023-03-14 00:00:00.000000', 2, 27, '2024-11-10 09:23:24.394462', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Isa%20Showa%20Tosai%2026cm.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(1, 1, 27, 2023, 1000000, '2024-05-18 00:00:00.000000', 3, 28, '2024-10-30 16:26:26.985954', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Isa%20Showa%20Tosai%2027cm.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(1, 1, 29, 2023, 1000000, '2024-10-13 00:00:00.000000', 4, 24, '2024-11-08 22:39:44.897838', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Torazo%20Ginrin%20Kohaku%2029cm%20Tosai.png', 'Ginrin Kohaku', 'A beautiful Ginrin Kohaku koi', 'FEMALE', 'VERIFIED'),
(1, 1, 22, 2023, 1000000, '2024-01-11 00:00:00.000000', 5, 30, '2024-12-10 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Torazo%20Ginrin%20Kohaku%20Tosai%2022cm.png', 'Ginrin Kohaku', 'A beautiful Ginrin Kohaku koi', 'FEMALE', 'VERIFIED'),
(1, 1, 22, 2023, 1000000, '2024-05-24 00:00:00.000000', 6, 25, '2024-11-04 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Karashigoi%20Tosai%2022cm.png', 'Karashigoi', 'A beautiful Karashigoi koi', 'MALE', 'VERIFIED'),
(1, 1, 32, 2023, 1000000, '2024-01-06 00:00:00.000000', 7, 27, '2024-11-08 22:41:08.943924', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Shiro%20Utsuri%20Tosai%2032cm.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(1, 1, 25, 2023, 1000000, '2023-12-19 00:00:00.000000', 8, 37, '2024-11-08 22:41:13.091741', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Shiro%20Utsuri%20Tosai%20.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(1, 1, 21, 2023, 1000000, '2024-06-01 00:00:00.000000', 9, 28, '2024-11-08 22:41:15.424761', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Shiro%20Utsuri%20%20tosai%2021cm.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(1, 1, 22, 2023, 1000000, '2024-08-30 00:00:00.000000', 10, 36, '2024-11-08 22:41:25.549626', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/NND%20Showa%2022cm%20tosai.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(1, 1, 30, 2023, 1000000, '2023-10-29 00:00:00.000000', 11, 32, '2024-11-09 11:14:10.343157', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Shiro%20Utsuri%20%2030cm.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'MALE', 'VERIFIED'),
(1, 1, 18, 2023, 1000000, '2023-05-23 00:00:00.000000', 12, 36, '2024-11-09 11:14:12.315415', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/NND%20Yamabuki%20Tosai%2018cm.png', 'Yamabuki', 'A beautiful Yamabuki koi', 'FEMALE', 'VERIFIED'),
(1, 1, 23, 2023, 1000000, '2024-08-29 00:00:00.000000', 13, 26, '2024-12-05 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Dark%20Ochiba%2023cm%20tosai.png', 'Dark Ochiba', 'A beautiful Dark Ochiba koi', 'FEMALE', 'VERIFIED'),
(1, 1, 31, 2023, 1000000, '2024-05-13 00:00:00.000000', 14, 32, '2024-11-09 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Ginrin%20Showa%20Tosai%2031cm.png', 'Ginrin Showa', 'A beautiful Ginrin Showa koi', 'FEMALE', 'VERIFIED'),
(1, 1, 21, 2023, 1000000, '2023-05-28 00:00:00.000000', 15, 24, '2023-11-29 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Ginrin%20Showa%20tosai%2021cm.png', 'Ginrin Showa', 'A beautiful Ginrin Showa koi', 'FEMALE', 'VERIFIED'),
(1, 1, 33, 2023, 1000000, '2023-07-06 00:00:00.000000', 16, 32, '2023-09-28 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Hi%20Utsuri%2033cm.png', 'Hi Utsuri', 'A beautiful Hi Utsuri koi', 'FEMALE', 'VERIFIED'),
(1, 1, 28, 2023, 1000000, '2023-11-05 00:00:00.000000', 17, 29, '2023-12-16 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Hi%20Utsuri%20Tosai%2028cm.png', 'Hi Utsuri', 'A beautiful Hi Utsuri koi', 'FEMALE', 'VERIFIED'),
(1, 1, 18, 2023, 1000000, '2024-09-21 00:00:00.000000', 18, 25, '2024-12-03 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Torazo%20Ginrin%20Kohaku%2018cm.png', 'Ginrin Kohaku', 'A beautiful Ginrin Kohaku koi', 'FEMALE', 'VERIFIED'),
(1, 1, 17, 2023, 1000000, '2023-06-19 00:00:00.000000', 19, 28, '2023-10-18 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Torazo%20GinRin%20Kohaku%20Tosai%2017cm.png', 'Ginrin Kohaku', 'A beautiful Ginrin Kohaku koi', 'MALE', 'VERIFIED'),
(1, 1, 26, 2023, 1000000, '2023-04-26 00:00:00.000000', 20, 32, '2023-07-25 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Torazo%20Ginrin%20Kohaku%20Tosai%2026cm%20.png', 'Ginrin Kohaku', 'A beautiful Ginrin Kohaku koi', 'MALE', 'VERIFIED'),
(1, 1, 33, 2023, 1000000, '2023-07-24 00:00:00.000000', 21, 31, '2024-07-26 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Ginrin%20Showa%20tosai%2033cm.png', 'Ginrin Showa', 'A beautiful Ginrin Showa koi', 'FEMALE', 'VERIFIED'),
(1, 1, 31, 2023, 1000000, '2023-05-11 00:00:00.000000', 22, 28, '2023-05-26 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Doitsu%20Kohaku%20Tosai%2031.png', 'Doitsu Kohaku', 'A beautiful Doitsu Kohaku koi', 'FEMALE', 'VERIFIED'),
(1, 1, 21, 2023, 1000000, '2023-08-09 00:00:00.000000', 23, 28, '2023-12-31 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Torazo%20Kohaku%20Tosai%2021cm.png', 'Kohaku', 'A beautiful Kohaku koi', 'MALE', 'VERIFIED'),
(1, 1, 23, 2023, 1000000, '2024-08-17 00:00:00.000000', 24, 34, '2024-09-19 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Torazo%20Kohaku%2023cm%20tosai%20.png', 'Kohaku', 'A beautiful Kohaku koi', 'FEMALE', 'VERIFIED'),
(1, 1, 22, 2023, 1000000, '2024-03-17 00:00:00.000000', 25, 30, '2024-08-03 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Shiro%20Utsuri%20Tosai%2022cm.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'MALE', 'VERIFIED'),
(1, 1, 21, 2023, 1000000, '2023-10-14 00:00:00.000000', 26, 30, '2024-07-03 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Torazo%20Kohaku%20Tosai%2021cm%202.png', 'Kohaku', 'A beautiful Kohaku koi', 'MALE', 'VERIFIED'),
(1, 1, 33, 2023, 1000000, '2024-01-24 00:00:00.000000', 27, 37, '2024-12-04 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Hi%20Utsuri%2033cm%20Nisai%20png.png', 'Hi Utsuri', 'A beautiful Hi Utsuri koi', 'FEMALE', 'VERIFIED'),
(1, 1, 34, 2023, 1000000, '2024-03-03 00:00:00.000000', 28, 37, '2024-11-11 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Hiroi%20Doitsu%20Showa%2034cm%20Nisai.png', 'Doitsu Showa', 'A beautiful Doitsu Showa koi', 'FEMALE', 'VERIFIED'),
(1, 1, 36, 2023, 1000000, '2024-06-19 00:00:00.000000', 29, 33, '2024-12-05 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Isa%20Showa%20Nisai%2036cm.png', 'Showa', 'A beautiful Showa koi', 'MALE', 'VERIFIED'),
(2, 1, 40, 2023, 1000000, '2023-07-02 00:00:00.000000', 30, 33, '2023-11-26 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Hiroi%20Doitsu%20Sanke%2040cm%20Nisai.png', 'Doitsu Sanke', 'A beautiful Doitsu Sanke koi', 'FEMALE', 'VERIFIED'),
(2, 1, 34, 2023, 1000000, '2023-07-13 00:00:00.000000', 31, 29, '2024-05-16 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Iwashita%20Ginrin%20Matsukawabake%2034cm%20Nisai.png', 'Ginrin Matsukawabake', 'A beautiful Ginrin Matsukawabake koi', 'MALE', 'VERIFIED'),
(2, 1, 33, 2023, 1000000, '2023-08-24 00:00:00.000000', 32, 28, '2024-04-04 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Izumiya%20Ai%20Goromo%2033cm%20Nisai.png', 'Ai Goromo', 'A beautiful Ai Goromo koi', 'MALE', 'VERIFIED'),
(2, 1, 35, 2023, 1000000, '2023-06-27 00:00:00.000000', 33, 24, '2024-11-09 11:30:27.264666', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Izumiya%20Kohaku%20nisai%2035cm.png', 'Kohaku', 'A beautiful Kohaku koi', 'FEMALE', 'VERIFIED'),
(2, 1, 31, 2023, 1000000, '2023-09-14 00:00:00.000000', 34, 33, '2024-10-03 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Izumiya%20Sanke%2031cm%20Nisai.png', 'Sanke', 'A beautiful Sanke koi', 'FEMALE', 'VERIFIED'),
(2, 1, 35, 2023, 1000000, '2024-02-16 00:00:00.000000', 35, 27, '2024-07-14 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Izumiya%20Sanke%2035cm%20Nisai.png', 'Sanke', 'A beautiful Sanke koi', 'FEMALE', 'VERIFIED'),
(2, 1, 33, 2023, 1000000, '2023-01-07 00:00:00.000000', 36, 25, '2023-06-13 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Izumiya%20Sanke%20Nisai%2033cm.png', 'Sanke', 'A beautiful Sanke koi', 'FEMALE', 'VERIFIED'),
(2, 1, 48, 2023, 1000000, '2024-06-12 00:00:00.000000', 37, 24, '2024-12-04 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Kanno%20Ginrin%20Goshiki%20Nisai%2048cm.png', 'Ginrin Goshiki', 'A beautiful Ginrin Goshiki koi', 'FEMALE', 'VERIFIED'),
(2, 1, 39, 2023, 1000000, '2023-11-08 00:00:00.000000', 38, 33, '2024-01-20 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Kanno%20Tancho%20Goshiki%20Nisai%2039cm.png', 'Tancho Goshiki', 'A beautiful Tancho Goshiki koi', 'FEMALE', 'VERIFIED'),
(2, 1, 27, 2023, 1000000, '2023-11-16 00:00:00.000000', 39, 26, '2024-01-22 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Bekko%20Nisai%2027cm.png', 'Bekko', 'A beautiful Bekko koi', 'FEMALE', 'VERIFIED'),
(2, 1, 44, 2023, 1000000, '2023-03-27 00:00:00.000000', 40, 33, '2024-10-14 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Ochiba%20Nisai%2044cm.png', 'Ochiba', 'A beautiful Ochiba koi', 'FEMALE', 'VERIFIED'),
(2, 1, 37, 2023, 1000000, '2024-07-20 00:00:00.000000', 41, 29, '2024-08-19 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Kanno%20Goshiki%20Nisai%2037cm.png', 'Goshiki', 'A beautiful Goshiki koi', 'MALE', 'VERIFIED'),
(2, 1, 42, 2023, 1000000, '2024-09-23 00:00:00.000000', 42, 25, '2024-10-16 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Doitsu%20Aragoke%20Ginrin%20Chagoi%20Nisai%2042cm.png', 'Doitsu Aragoke Ginrin Chagoi', 'A beautiful Doitsu Aragoke Ginrin Chagoi koi', 'FEMALE', 'VERIFIED'),
(2, 1, 44, 2023, 1000000, '2023-08-01 00:00:00.000000', 43, 37, '2023-09-01 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Ginrin%20Ochiba%20Nisai%2044cm.png', 'Ginrin Ochiba', 'A beautiful Ginrin Ochiba koi', 'FEMALE', 'VERIFIED'),
(2, 1, 40, 2023, 1000000, '2024-12-15 00:00:00.000000', 44, 37, '2024-12-16 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Izumiya%20Showa%20nisai%2040cm.png', 'Showa', 'A beautiful Showa koi', 'MALE', 'VERIFIED'),
(2, 1, 40, 2023, 1000000, '2024-09-26 00:00:00.000000', 45, 33, '2024-10-10 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Soragoi%20Nisai%2040cm.png', 'Soragoi', 'A beautiful Soragoi koi', 'MALE', 'VERIFIED'),
(2, 1, 38, 2023, 1000000, '2023-09-27 00:00:00.000000', 46, 36, '2024-10-13 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Maruhiro%20Asagi%20Nisai%2038cm.png', 'Asagi', 'A beautiful Asagi koi', 'FEMALE', 'VERIFIED'),
(2, 1, 46, 2023, 1000000, '2024-02-22 00:00:00.000000', 47, 26, '2024-02-23 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/NND%20Shiro%20Utsuri%2046cm%20Nisai.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'MALE', 'VERIFIED'),
(2, 1, 28, 2023, 1000000, '2023-07-27 00:00:00.000000', 48, 35, '2024-09-28 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Ootsuka%20Budo%20Goromo%20Nisai.png', 'Budo Goromo', 'A beautiful Budo Goromo koi', 'FEMALE', 'VERIFIED'),
(2, 1, 30, 2023, 1000000, '2023-03-07 00:00:00.000000', 49, 36, '2023-03-31 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Hi%20Utsuri%20Nisai%2030cm.png', 'Hi Utsuri', 'A beautiful Hi Utsuri koi', 'FEMALE', 'VERIFIED'),
(2, 1, 28, 2023, 1000000, '2023-12-06 00:00:00.000000', 50, 30, '2024-09-23 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Izumiya%20Showa%20Nisai%2028cm.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(2, 1, 33, 2023, 1000000, '2023-07-30 00:00:00.000000', 52, 34, '2024-05-26 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Ginrin%20Aragoke%20Chagoi.png', 'Ginrin Aragoke Chagoi', 'A beautiful Ginrin Aragoke Chagoi koi', 'MALE', 'VERIFIED'),
(2, 1, 47, 2023, 1000000, '2024-09-21 00:00:00.000000', 53, 27, '2024-10-22 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Izumiya%20Sanke%20sansai%2047cm.png', 'Sanke', 'A beautiful Sanke koi', 'MALE', 'VERIFIED'),
(2, 1, 60, 2023, 1000000, '2024-11-14 00:00:00.000000', 54, 34, '2024-12-14 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Karashigoi%20Sansai%2060cm.png', 'Red Karashigoi', 'A beautiful Red Karashigoi koi', 'FEMALE', 'VERIFIED'),
(2, 1, 49, 2023, 1000000, '2024-01-05 00:00:00.000000', 55, 35, '2024-12-30 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Hirashin%20Magoi%20Sansai%2049cm.png', 'Magoi', 'A beautiful Magoi koi', 'FEMALE', 'VERIFIED'),
(2, 1, 58, 2023, 1000000, '2024-05-03 00:00:00.000000', 56, 31, '2024-10-11 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Sekiguchi%20Showa%20Sansai%2058cm.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(2, 1, 48, 2023, 1000000, '2023-05-28 00:00:00.000000', 57, 32, '2024-09-14 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Hirashin%20Magoi%20Sansai%2048cm.png', 'Magoi', 'A beautiful Magoi koi', 'FEMALE', 'VERIFIED'),
(2, 1, 15, 2023, 1000000, '2023-07-22 00:00:00.000000', 58, 36, '2024-09-17 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Torazo%20Kohaku%2015cm%20Tosai.png', 'Kohaku', 'A beautiful Kohaku koi', 'MALE', 'VERIFIED'),
(2, 1, 15, 2023, 1000000, '2024-05-18 00:00:00.000000', 59, 36, '2024-10-09 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Torazo%20Ginrin%20Kohaku%2015cm%20Tosai.png', 'Ginrin Kohaku', 'A beautiful Ginrin Kohaku koi', 'MALE', 'VERIFIED'),
(2, 1, 18, 2023, 1000000, '2024-12-08 00:00:00.000000', 60, 27, '2024-12-27 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2018cm.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(2, 1, 18, 2023, 1000000, '2023-05-08 00:00:00.000000', 61, 25, '2024-07-26 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Torazo%20Ginrin%20Kohaku%2018cm%20Tosai.png', 'Ginrin Kohaku', 'A beautiful Ginrin Kohaku koi', 'FEMALE', 'VERIFIED'),
(2, 1, 19, 2023, 1000000, '2024-10-26 00:00:00.000000', 62, 31, '2024-11-29 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2019cm.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'MALE', 'VERIFIED'),
(2, 1, 19, 2023, 1000000, '2024-09-01 00:00:00.000000', 63, 34, '2024-12-25 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/ISA%20Showa%2019cm%20Tosai.png', 'Showa', 'A beautiful Showa koi', 'MALE', 'VERIFIED'),
(2, 1, 20, 2023, 1000000, '2023-08-13 00:00:00.000000', 64, 32, '2024-01-30 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Torazo%20Kohaku%2020cm%20Tosai%20', 'Kohaku', 'A beautiful Kohaku koi', 'MALE', 'VERIFIED'),
(2, 1, 20, 2023, 1000000, '2024-04-05 00:00:00.000000', 65, 31, '2024-07-24 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Torazo%20Tancho%20Sanke%2020cm%20Tosai.png', 'Tancho Sanke', 'A beautiful Tancho Sanke koi', 'FEMALE', 'VERIFIED'),
(2, 1, 21, 2023, 1000000, '2023-09-07 00:00:00.000000', 66, 29, '2023-12-06 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2021cm%202.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(2, 1, 21, 2023, 1000000, '2023-08-13 00:00:00.000000', 67, 35, '2024-01-03 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2021cm%203.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(2, 1, 21, 2023, 1000000, '2023-10-10 00:00:00.000000', 68, 34, '2024-11-02 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2021cm.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(2, 1, 21, 2023, 1000000, '2024-08-03 00:00:00.000000', 69, 35, '2024-11-06 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/ISA%20Showa%2021cm%20Tosai.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(2, 1, 22, 2023, 1000000, '2023-08-04 00:00:00.000000', 70, 30, '2024-04-23 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/ISA%20Showa%2022cm%20Tosai.png', 'Showa', 'A beautiful Showa koi', 'MALE', 'VERIFIED'),
(2, 1, 22, 2023, 1000000, '2023-10-18 00:00:00.000000', 71, 35, '2024-12-16 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/NND%20Yamibuki%20Tosai%2022cm%20.png', 'Yamabuki', 'A beautiful Yamabuki koi', 'MALE', 'VERIFIED'),
(2, 1, 22, 2023, 1000000, '2023-10-28 00:00:00.000000', 72, 26, '2024-03-01 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2022cm%203.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'MALE', 'VERIFIED'),
(2, 1, 22, 2023, 1000000, '2024-04-19 00:00:00.000000', 73, 37, '2024-05-21 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2022cm%205.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(2, 1, 22, 2023, 1000000, '2024-02-16 00:00:00.000000', 74, 37, '2024-11-09 11:13:37.094917', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2022cm%206.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(2, 1, 22, 2023, 1000000, '2023-07-04 00:00:00.000000', 75, 35, '2023-07-20 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2022cm%204.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(2, 1, 22, 2023, 1000000, '2024-11-10 00:00:00.000000', 76, 34, '2024-11-09 11:13:57.068899', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2022cm%207.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(2, 1, 22, 2023, 1000000, '2024-05-12 00:00:00.000000', 77, 34, '2024-05-28 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2022cm.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(2, 1, 22, 2023, 1000000, '2024-09-23 00:00:00.000000', 78, 33, '2024-10-26 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Yellow_Monkey_22cm_Tosai.png', 'Yellow Monkey', 'A beautiful Yellow Monkey koi', 'FEMALE', 'VERIFIED'),
(2, 1, 23, 2023, 1000000, '2024-10-05 00:00:00.000000', 79, 34, '2024-12-27 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/ISA%20Showa%2023cm%20Tosai%20', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(2, 1, 23, 2023, 1000000, '2023-09-08 00:00:00.000000', 80, 32, '2024-12-22 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/ISA%20Showa%2023cm%20Tosai.png', 'Showa', 'A beautiful Showa koi', 'MALE', 'VERIFIED'),
(2, 1, 23, 2023, 1000000, '2023-11-01 00:00:00.000000', 81, 36, '2024-03-21 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2023cm%202.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'MALE', 'VERIFIED'),
(2, 1, 23, 2023, 1000000, '2024-01-09 00:00:00.000000', 82, 25, '2024-08-05 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2023cm.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(2, 1, 23, 2023, 1000000, '2024-10-10 00:00:00.000000', 83, 32, '2024-10-14 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Dainichi%20Ginrin%20Chagoi%2023cm%20Tosai.png', 'Yellow Monkey', 'A beautiful Yellow Monkey koi', 'MALE', 'VERIFIED'),
(2, 1, 24, 2023, 1000000, '2023-11-02 00:00:00.000000', 84, 35, '2024-03-23 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/ISA%20Showa%2024cm%20Tosai.png', 'Showa', 'A beautiful Showa koi', 'MALE', 'VERIFIED'),
(2, 1, 24, 2023, 1000000, '2024-10-09 00:00:00.000000', 85, 29, '2024-12-29 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2024cm%203.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'MALE', 'VERIFIED'),
(2, 1, 24, 2023, 1000000, '2023-02-25 00:00:00.000000', 86, 25, '2023-09-01 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2024cm%204.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'MALE', 'VERIFIED'),
(2, 1, 24, 2023, 1000000, '2024-09-02 00:00:00.000000', 87, 31, '2024-11-12 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2024cm.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'MALE', 'VERIFIED'),
(2, 1, 24, 2023, 1000000, '2024-08-28 00:00:00.000000', 88, 36, '2024-09-14 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Kujaku_24cm_Tosai.png', 'Kujaku', 'A beautiful Kujaku koi', 'FEMALE', 'VERIFIED'),
(2, 1, 25, 2023, 1000000, '2024-04-26 00:00:00.000000', 89, 29, '2024-08-22 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Torazo%20Ginrin%20Kohaku%20Tosai%2025cm.png', 'Ginrin Kohaku', 'A beautiful Ginrin Kohaku koi', 'MALE', 'VERIFIED'),
(2, 1, 25, 2023, 1000000, '2024-08-08 00:00:00.000000', 90, 33, '2024-10-14 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2025cm%202.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(2, 1, 25, 2023, 1000000, '2023-05-27 00:00:00.000000', 91, 33, '2024-07-19 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2025cm.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(2, 1, 25, 2023, 1000000, '2024-01-06 00:00:00.000000', 92, 33, '2024-08-13 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Dainichi%20Gin%20Rin%20Chagoi%2025cm%20Tosai.png', 'Yellow Monkey', 'A beautiful Yellow Monkey koi', 'MALE', 'VERIFIED'),
(2, 1, 26, 2023, 1000000, '2024-07-08 00:00:00.000000', 93, 30, '2024-09-02 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2026cm%202.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'MALE', 'VERIFIED'),
(2, 1, 26, 2023, 1000000, '2024-06-23 00:00:00.000000', 94, 34, '2024-07-02 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Izumiya%20Showa%2026cm%20Nisai.png', 'Sanke', 'A beautiful Sanke koi', 'MALE', 'VERIFIED'),
(2, 1, 26, 2023, 1000000, '2023-04-10 00:00:00.000000', 95, 24, '2024-11-08 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2026cm.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(2, 1, 28, 2023, 1000000, '2023-04-23 00:00:00.000000', 96, 35, '2024-07-14 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2028cm.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'MALE', 'VERIFIED'),
(2, 1, 28, 2023, 1000000, '2023-06-22 00:00:00.000000', 97, 30, '2024-10-26 23:28:39.177451', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Doitsu%20Shiro%20Utsuri%2028cm.png', 'Doitsu Shiro Utsuri', 'A beautiful Doitsu Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(2, 1, 28, 2023, 1000000, '2024-01-05 00:00:00.000000', 98, 35, '2024-01-06 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Dainichi%20Gin%20Rin%20Chagoi%2028cm%20Tosai.png', 'Yellow Monkey', 'A beautiful Yellow Monkey koi', 'FEMALE', 'VERIFIED'),
(2, 1, 29, 2023, 1000000, '2023-07-25 00:00:00.000000', 99, 32, '2024-02-18 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Izumiya%20Sanke%2029cm%20Nisai.png', 'Sanke', 'A beautiful Sanke koi', 'FEMALE', 'VERIFIED'),
(2, 1, 29, 2023, 1000000, '2024-03-18 00:00:00.000000', 100, 33, '2024-12-06 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Dainichi%20Gin%20Rin%20Chagoi%2029cm%20Tosai.png', 'Yellow Monkey', 'A beautiful Yellow Monkey koi', 'FEMALE', 'VERIFIED'),
(4, 1, 30, 2023, 1000000, '2024-10-24 00:00:00.000000', 101, 24, '2024-12-24 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Shinoda%20Doitsu%20Sanke%2030cm%20Tosai.png', 'Doitsu Sanke', 'A beautiful Doitsu Sanke koi', 'FEMALE', 'VERIFIED'),
(4, 1, 32, 2023, 1000000, '2024-04-06 00:00:00.000000', 102, 33, '2024-06-11 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Dainichi%20Gin%20Rin%20Chagoi%2032cm%20Tosai.png', 'Yellow Monkey', 'A beautiful Yellow Monkey koi', 'FEMALE', 'VERIFIED'),
(4, 1, 33, 2023, 1000000, '2023-11-04 00:00:00.000000', 103, 35, '2023-12-27 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Dainichi%20Gin%20Rin%20Chagoi%2033cm%20tosai.png', 'Yellow Monkey', 'A beautiful Yellow Monkey koi', 'MALE', 'VERIFIED'),
(4, 1, 33, 2023, 1000000, '2023-04-06 00:00:00.000000', 104, 29, '2024-01-06 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Dainichi%20Gin%20Rin%20Chagoi%20Tosai%2033cm.png', 'Yellow Monkey', 'A beautiful Yellow Monkey koi', 'MALE', 'VERIFIED'),
(4, 1, 37, 2023, 1000000, '2023-03-02 00:00:00.000000', 105, 32, '2023-11-01 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/8-37%20Gin%20Rin%20Showa.png', 'Ginrin Showa', 'A beautiful Ginrin Showa koi', 'MALE', 'VERIFIED'),
(4, 1, 46, 2023, 1000000, '2024-11-09 00:00:00.000000', 106, 27, '2024-11-17 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/9-46%20Gin%20Rin%20Showa.png', 'Ginrin Showa', 'A beautiful Ginrin Showa koi', 'FEMALE', 'VERIFIED'),
(4, 1, 41, 2023, 1000000, '2024-10-05 00:00:00.000000', 107, 24, '2024-11-07 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/13-41%20Doitsu%20Tancho%20Showa.png', 'Doitsu Tancho Showa', 'A beautiful Doitsu Tancho Showa koi', 'MALE', 'VERIFIED'),
(4, 1, 40, 2023, 1000000, '2023-09-15 00:00:00.000000', 108, 29, '2024-08-29 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/10-40%20Gin%20Rin%20Showa.png', 'Ginrin Showa', 'A beautiful Ginrin Showa koi', 'FEMALE', 'VERIFIED'),
(4, 1, 42, 2023, 1000000, '2024-12-09 00:00:00.000000', 110, 37, '2024-12-17 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/15-42%20Doitsu%20Showa.png', 'Doitsu Showa', 'A beautiful Doitsu Showa koi', 'FEMALE', 'VERIFIED'),
(4, 1, 40, 2023, 1000000, '2024-06-15 00:00:00.000000', 111, 37, '2024-09-04 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/16-40%20Doitsu%20Showa.png', 'Doitsu Showa', 'A beautiful Doitsu Showa koi', 'MALE', 'VERIFIED'),
(4, 1, 44, 2023, 1000000, '2024-09-11 00:00:00.000000', 112, 35, '2024-10-28 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/17-44%20Doitsu%20Showa.png', 'Doitsu Showa', 'A beautiful Doitsu Showa koi', 'FEMALE', 'VERIFIED'),
(4, 1, 42, 2023, 1000000, '2024-07-25 00:00:00.000000', 113, 37, '2024-11-27 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/19-42%20Doitsu%20Showa.png', 'Doitsu Showa', 'A beautiful Doitsu Showa koi', 'FEMALE', 'VERIFIED'),
(4, 1, 45, 2023, 1000000, '2023-09-21 00:00:00.000000', 114, 31, '2023-12-04 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/21-45%20Doitsu%20Showa.png', 'Doitsu Showa', 'A beautiful Doitsu Showa koi', 'FEMALE', 'VERIFIED'),
(4, 1, 40, 2023, 1000000, '2023-12-06 00:00:00.000000', 115, 29, '2024-02-28 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/22-40%20Doitsu%20Showa.png', 'Doitsu Showa', 'A beautiful Doitsu Showa koi', 'MALE', 'VERIFIED'),
(4, 1, 44, 2023, 1000000, '2024-02-01 00:00:00.000000', 116, 28, '2024-05-21 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/24-44%20Doitsu%20Showa.png', 'Doitsu Showa', 'A beautiful Doitsu Showa koi', 'FEMALE', 'VERIFIED'),
(4, 1, 40, 2023, 1000000, '2023-07-05 00:00:00.000000', 117, 29, '2023-09-14 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/27-40%20Doitsu%20Showa.png', 'Doitsu Showa', 'A beautiful Doitsu Showa koi', 'MALE', 'VERIFIED'),
(4, 1, 65, 2023, 1000000, '2024-11-20 00:00:00.000000', 118, 35, '2024-11-20 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/32-65%20Showa.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(4, 1, 44, 2023, 1000000, '2024-05-03 00:00:00.000000', 119, 37, '2024-12-10 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/4-44%20Showa.png', 'Showa', 'A beautiful Showa koi', 'MALE', 'VERIFIED'),
(4, 1, 42, 2023, 1000000, '2024-11-19 00:00:00.000000', 120, 35, '2024-11-20 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/20-42%20Doitsu%20Showa.png?t=2023-11-03T14%3A52%3A53.891Z', 'Doitsu Showa', 'A beautiful Doitsu Showa koi', 'MALE', 'VERIFIED'),
(4, 1, 35, 2023, 1000000, '2024-11-27 00:00:00.000000', 121, 25, '2024-12-30 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/25-35%20Doitsu%20Showa.png?t=2023-11-03T14%3A58%3A23.649Z', 'Doitsu Showa', 'A beautiful Doitsu Showa koi', 'FEMALE', 'VERIFIED'),
(4, 1, 46, 2023, 1000000, '2023-10-12 00:00:00.000000', 122, 29, '2024-02-18 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/29-46%20Doitsu%20Showa.png', 'Doitsu Showa', 'A beautiful Doitsu Showa koi', 'FEMALE', 'VERIFIED'),
(4, 1, 55, 2023, 1000000, '2024-07-27 00:00:00.000000', 123, 24, '2024-10-25 23:11:13.603255', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/31-55%20Gin%20Rin%20Showa.png', 'Ginrin Showa', 'A beautiful Ginrin Showa koi', 'FEMALE', 'VERIFIED'),
(4, 1, 44, 2023, 1000000, '2023-11-09 00:00:00.000000', 124, 34, '2024-06-14 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/1-44%20Showa.png', 'Showa', 'A beautiful Showa koi', 'MALE', 'VERIFIED'),
(4, 1, 43, 2023, 1000000, '2023-12-26 00:00:00.000000', 125, 32, '2024-08-13 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/2-43%20Showa.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(2, 1, 46, 2023, 1000000, '2023-10-23 00:00:00.000000', 126, 34, '2024-04-16 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/3-46%20Showa.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(3, 1, 47, 2023, 1000000, '2024-05-26 00:00:00.000000', 127, 37, '2024-06-29 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/5-47%20Showa.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(4, 1, 42, 2023, 1000000, '2023-03-28 00:00:00.000000', 128, 24, '2024-08-10 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/6-42%20Tacnho%20Kohaku.png', 'Tancho Kohaku', 'A beautiful Tancho Kohaku koi', 'MALE', 'VERIFIED'),
(5, 1, 47, 2023, 1000000, '2023-07-14 00:00:00.000000', 129, 34, '2024-10-22 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/7-47%20Gin%20Rin%20Showa.png', 'Ginrin Showa', 'A beautiful Ginrin Showa koi', 'MALE', 'VERIFIED'),
(6, 1, 39, 2023, 1000000, '2023-03-16 00:00:00.000000', 130, 35, '2023-03-20 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/11-39%20Gin%20Rin%20Showa.png', 'Ginrin Showa', 'A beautiful Ginrin Showa koi', 'MALE', 'VERIFIED'),
(7, 1, 45, 2023, 1000000, '2024-05-06 00:00:00.000000', 131, 34, '2024-07-10 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/14-45%20Tancho%20Doitsu%20Showa.png', 'Doitsu Tancho Showa', 'A beautiful Doitsu Tancho Showa koi', 'FEMALE', 'VERIFIED'),
(8, 1, 38, 2023, 1000000, '2023-03-02 00:00:00.000000', 132, 26, '2024-01-16 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/18-38%20Doitsu%20Showa.png', 'Doitsu Showa', 'A beautiful Doitsu Showa koi', 'MALE', 'VERIFIED'),
(9, 1, 42, 2023, 1000000, '2024-01-22 00:00:00.000000', 133, 24, '2024-12-08 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/23-42%20Doitsu%20Showa.png', 'Doitsu Showa', 'A beautiful Doitsu Showa koi', 'MALE', 'VERIFIED'),
(10, 1, 41, 2023, 1000000, '2023-02-02 00:00:00.000000', 134, 28, '2024-11-11 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/26-41%20Doitsu%20Showa.png', 'Doitsu Showa', 'A beautiful Doitsu Showa koi', 'FEMALE', 'VERIFIED'),
(11, 1, 42, 2023, 1000000, '2024-08-01 00:00:00.000000', 135, 26, '2024-08-16 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/28-42%20Doitsu%20Showa.png', 'Doitsu Showa', 'A beautiful Doitsu Showa koi', 'MALE', 'VERIFIED'),
(12, 1, 46, 2023, 1000000, '2023-06-23 00:00:00.000000', 136, 33, '2023-12-13 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/30-46%20Doitsu%20Showa.png', 'Doitsu Showa', 'A beautiful Doitsu Showa koi', 'MALE', 'VERIFIED'),
(13, 1, 42, 2023, 1000000, '2024-09-07 00:00:00.000000', 137, 32, '2024-10-12 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No1%202y%20Kohaku%20Female%2042cm.png', 'Kohaku', 'A beautiful Kohaku koi', 'FEMALE', 'VERIFIED'),
(14, 1, 56, 2023, 1000000, '2023-10-16 00:00:00.000000', 138, 26, '2024-08-10 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No2%202y%20Plutinum%2056cm%20Female.png', 'Platinum Ogon', 'A beautiful Platinum Ogon koi', 'FEMALE', 'VERIFIED'),
(15, 1, 55, 2023, 1000000, '2024-09-05 00:00:00.000000', 139, 37, '2024-12-22 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No3%202y%20Karashi%2055cm%20Female.png', 'Karashigoi', 'A beautiful Karashigoi koi', 'FEMALE', 'VERIFIED'),
(16, 1, 71, 2023, 1000000, '2024-01-01 00:00:00.000000', 140, 32, '2024-11-07 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No4%204y%20Kohaku%2071cm%20Female.png?t=2023-11-03T15%3A57%3A14.528Z', 'Kohaku', 'A beautiful Kohaku koi', 'FEMALE', 'VERIFIED'),
(17, 1, 42, 2023, 1000000, '2023-04-27 00:00:00.000000', 141, 24, '2024-06-12 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No5%202y%20Sanke%2042cm%20Male.png', 'Sanke', 'A beautiful Sanke koi', 'MALE', 'VERIFIED'),
(18, 1, 42, 2023, 1000000, '2023-11-12 00:00:00.000000', 142, 29, '2024-04-24 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No6%202y%20Ginrin%20Tancho%2042cm%20Female.png', 'Ginrin Tancho Kohaku', 'A beautiful Ginrin Tancho Kohaku koi', 'FEMALE', 'VERIFIED'),
(19, 1, 55, 2023, 1000000, '2023-05-25 00:00:00.000000', 143, 26, '2023-08-16 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No7%203y%20Metallic%20Doitsu%20Karasugoi%2055cm%20Female.png?t=2023-11-03T18%3A02%3A30.791Z', 'Metallic Doitsu Karasugoi', 'A beautiful Metallic Doitsu Karasugoi koi', 'FEMALE', 'VERIFIED'),
(20, 1, 50, 2023, 1000000, '2023-10-11 00:00:00.000000', 144, 35, '2024-04-05 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No8%202y%20Kohaku%2050cm%20Female.png', 'Kohaku', 'A beautiful Kohaku koi', 'FEMALE', 'VERIFIED'),
(4, 1, 43, 2023, 1000000, '2024-03-21 00:00:00.000000', 145, 31, '2024-04-30 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No9%202y%20Koromo%20Showa%2043cm%20Female.png', 'Koromo Showa', 'A beautiful Koromo Showa koi', 'FEMALE', 'VERIFIED'),
(4, 1, 50, 2023, 1000000, '2023-05-12 00:00:00.000000', 146, 31, '2023-08-16 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No10%202y%20Tancho%20kohaku%2050cm%20Female.png?t=2023-11-03T18%3A30%3A50.742Z', 'Tancho Kohaku', 'A beautiful Tancho Kohaku koi', 'FEMALE', 'VERIFIED'),
(4, 1, 46, 2023, 1000000, '2024-09-02 00:00:00.000000', 147, 31, '2024-12-05 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No11%202y%20Tancho%20Sanke%2046cm%20Male.png', 'Tancho Sanke', 'A beautiful Tancho Sanke koi', 'MALE', 'VERIFIED'),
(4, 1, 60, 2023, 1000000, '2023-10-10 00:00:00.000000', 148, 34, '2024-10-14 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Yamibuki.png', 'Yamabuki', 'A beautiful Yamabuki koi', 'FEMALE', 'VERIFIED'),
(4, 1, 58, 2023, 1000000, '2024-05-27 00:00:00.000000', 149, 37, '2024-10-02 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Chagoi%206.png', 'Ginrin Chagoi', 'A beautiful Ginrin Chagoi koi', 'FEMALE', 'VERIFIED'),
(4, 1, 59, 2023, 1000000, '2023-09-13 00:00:00.000000', 150, 36, '2024-05-16 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Chagoi%20kole%20Updated%20601.png', 'Ginrin Chagoi', 'A beautiful Ginrin Chagoi koi', 'FEMALE', 'VERIFIED'),
(1, 1, 57, 2023, 1000000, '2024-10-10 00:00:00.000000', 151, 32, '2024-12-12 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Yamibuki%202.png', 'Yamabuki', 'A beautiful Yamabuki koi', 'FEMALE', 'VERIFIED'),
(1, 1, 49, 2023, 1000000, '2024-03-22 00:00:00.000000', 152, 24, '2024-08-26 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Showa.png', 'Ginrin Showa', 'A beautiful Ginrin Showa koi', 'FEMALE', 'VERIFIED'),
(1, 1, 70, 2023, 1000000, '2023-08-28 00:00:00.000000', 153, 37, '2024-07-16 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Karashigoi%202.png', 'Ginrin Karashigoi', 'A beautiful Ginrin Karashigoi koi', 'MALE', 'VERIFIED'),
(1, 1, 64, 2023, 1000000, '2024-02-26 00:00:00.000000', 154, 35, '2024-12-13 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Karashigoi.png', 'Ginrin Karashigoi', 'A beautiful Ginrin Karashigoi koi', 'FEMALE', 'VERIFIED'),
(1, 1, 48, 2023, 1000000, '2024-10-02 00:00:00.000000', 155, 24, '2024-11-06 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Shiro%20Utsuri.png', 'Ginrin Shiro Utsuri', 'A beautiful Ginrin Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(1, 1, 58, 2023, 1000000, '2023-11-28 00:00:00.000000', 156, 28, '2024-03-03 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Yamabuki%205.png', 'Yamabuki', 'A beautiful Yamabuki koi', 'FEMALE', 'VERIFIED'),
(1, 1, 51, 2023, 1000000, '2023-12-16 00:00:00.000000', 157, 25, '2024-03-06 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Orenji%20Ogon.png', 'Orenji Ogon', 'A beautiful Orenji Ogon koi', 'MALE', 'VERIFIED'),
(1, 1, 48, 2023, 1000000, '2023-02-25 00:00:00.000000', 158, 31, '2023-11-27 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Orenji%20Ogon%202.png', 'Orenji Ogon', 'A beautiful Orenji Ogon koi', 'MALE', 'VERIFIED'),
(1, 1, 47, 2023, 1000000, '2023-05-09 00:00:00.000000', 159, 28, '2023-05-22 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Showa%203.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(1, 1, 49, 2023, 1000000, '2023-11-23 00:00:00.000000', 160, 34, '2024-08-23 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Showa%202.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(1, 1, 49, 2023, 1000000, '2024-04-09 00:00:00.000000', 161, 26, '2024-07-02 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Showa.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(1, 1, 62, 2023, 1000000, '2023-03-15 00:00:00.000000', 162, 24, '2024-01-22 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Yamibuki%203.png', 'Yamabuki', 'A beautiful Yamabuki koi', 'MALE', 'VERIFIED'),
(1, 1, 52, 2023, 1000000, '2024-05-09 00:00:00.000000', 163, 35, '2024-06-04 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Yamibuki%204.png', 'Yamabuki', 'A beautiful Yamabuki koi', 'FEMALE', 'VERIFIED'),
(1, 1, 38, 2023, 1000000, '2024-12-06 00:00:00.000000', 164, 24, '2024-12-10 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Karashigoi%203.png', 'Ginrin Karashigoi', 'A beautiful Ginrin Karashigoi koi', 'FEMALE', 'VERIFIED'),
(1, 1, 47, 2023, 1000000, '2024-10-16 00:00:00.000000', 165, 24, '2024-12-14 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%202.png', 'Kohaku', 'A beautiful Kohaku koi', 'FEMALE', 'VERIFIED'),
(1, 1, 55, 2023, 1000000, '2023-11-21 00:00:00.000000', 166, 35, '2024-12-12 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Kohaku.png', 'Ginrin Kohaku', 'A beautiful Ginrin Kohaku koi', 'FEMALE', 'VERIFIED'),
(1, 1, 53, 2023, 1000000, '2023-11-01 00:00:00.000000', 167, 27, '2023-11-15 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%203%20updated%20618.png', 'Kohaku', 'A beautiful Kohaku koi', 'FEMALE', 'VERIFIED'),
(1, 1, 49, 2023, 1000000, '2023-10-24 00:00:00.000000', 168, 37, '2024-07-03 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%206.png', 'Kohaku', 'A beautiful Kohaku koi', 'FEMALE', 'VERIFIED'),
(1, 1, 46, 2023, 1000000, '2023-01-01 00:00:00.000000', 169, 26, '2024-11-14 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%205%20updated.png', 'Kohaku', 'A beautiful Kohaku koi', 'FEMALE', 'VERIFIED'),
(1, 1, 48, 2023, 1000000, '2024-10-26 00:00:00.000000', 170, 27, '2024-11-14 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%204.png', 'Kohaku', 'A beautiful Kohaku koi', 'FEMALE', 'VERIFIED'),
(1, 1, 51, 2023, 1000000, '2024-05-16 00:00:00.000000', 171, 35, '2024-12-11 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%209%20Updated%20622.png', 'Kohaku', 'A beautiful Kohaku koi', 'FEMALE', 'VERIFIED'),
(1, 1, 47, 2023, 1000000, '2023-12-23 00:00:00.000000', 172, 32, '2024-11-22 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%2010%20updated%20623.png', 'Kohaku', 'A beautiful Kohaku koi', 'FEMALE', 'VERIFIED'),
(1, 1, 47, 2023, 1000000, '2024-02-17 00:00:00.000000', 173, 32, '2024-04-24 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%207.png', 'Kohaku', 'A beautiful Kohaku koi', 'FEMALE', 'VERIFIED'),
(1, 1, 54, 2023, 1000000, '2024-06-01 00:00:00.000000', 174, 32, '2024-09-17 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%208.png', 'Kohaku', 'A beautiful Kohaku koi', 'FEMALE', 'VERIFIED'),
(1, 1, 49, 2023, 1000000, '2023-08-09 00:00:00.000000', 175, 31, '2024-07-16 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku.png', 'Kohaku', 'A beautiful Kohaku koi', 'FEMALE', 'VERIFIED'),
(1, 1, 75, 2023, 1000000, '2024-02-25 00:00:00.000000', 176, 25, '2024-11-26 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%2012%20updated.png', 'Kohaku', 'A beautiful Kohaku koi', 'FEMALE', 'VERIFIED'),
(1, 1, 50, 2023, 1000000, '2024-01-21 00:00:00.000000', 177, 35, '2024-09-04 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%2011.png', 'Maruten Kohaku', 'A beautiful Maruten Kohaku koi', 'MALE', 'VERIFIED'),
(1, 1, 75, 2023, 1000000, '2024-03-27 00:00:00.000000', 178, 33, '2024-06-25 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Maruten%20Kohaku%20updated.png?t=2023-11-15T15%3A01%3A37.654Z', 'Maruten Kohaku', 'A beautiful Maruten Kohaku koi', 'FEMALE', 'VERIFIED');
INSERT INTO `kois` (`category_id`, `is_display`, `length`, `year_born`, `base_price`, `created_at`, `id`, `owner_id`, `updated_at`, `thumbnail`, `name`, `description`, `sex`, `status`) VALUES
(1, 1, 46, 2023, 1000000, '2024-10-13 00:00:00.000000', 179, 33, '2024-12-28 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Sanke.png', 'Sanke', 'A beautiful Sanke koi', 'FEMALE', 'VERIFIED'),
(1, 1, 45, 2023, 1000000, '2023-01-07 00:00:00.000000', 180, 32, '2023-03-25 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Showa%205.png', 'Sanke', 'A beautiful Sanke koi', 'FEMALE', 'VERIFIED'),
(1, 1, 43, 2023, 1000000, '2024-01-17 00:00:00.000000', 181, 26, '2024-12-16 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Sanke%202.png', 'Sanke', 'A beautiful Sanke koi', 'FEMALE', 'VERIFIED'),
(1, 1, 46, 2023, 1000000, '2023-06-23 00:00:00.000000', 182, 29, '2024-06-09 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Showa%204.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(1, 1, 57, 2023, 1000000, '2023-05-31 00:00:00.000000', 183, 34, '2023-12-26 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Showa%207%20updated%20634.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(1, 1, 52, 2023, 1000000, '2024-12-21 00:00:00.000000', 184, 33, '2024-12-23 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Showa%206.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(1, 1, 48, 2023, 1000000, '2023-03-09 00:00:00.000000', 185, 36, '2024-10-10 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Tancho%20Showa%20updated%20636.png', 'Tancho Sanke', 'A beautiful Tancho Sanke koi', 'FEMALE', 'VERIFIED'),
(1, 1, 34, 2023, 1000000, '2023-07-18 00:00:00.000000', 186, 32, '2024-08-01 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Chagoi%204.png', 'Ginrin Karashigoi', 'A beautiful Ginrin Karashigoi koi', 'FEMALE', 'VERIFIED'),
(1, 1, 36, 2023, 1000000, '2024-07-30 00:00:00.000000', 187, 26, '2024-12-20 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Chagoi%202%205.png', 'Ginrin Karashigoi', 'A beautiful Ginrin Karashigoi koi', 'FEMALE', 'VERIFIED'),
(1, 1, 61, 2023, 1000000, '2023-08-27 00:00:00.000000', 188, 25, '2024-09-24 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Gin%20Rin%20Hi%20Utsuri%20Female%20......%2061cm.png', 'Ginrin Hi Utsuri', 'A beautiful Ginrin Hi Utsuri koi', 'FEMALE', 'VERIFIED'),
(1, 1, 56, 2023, 1000000, '2023-02-28 00:00:00.000000', 189, 36, '2024-12-01 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Gin%20Rin%20Ki%20Matsuba%20Female%20Nisai%2056cm.png', 'Ginrin Ki Matsuba', 'A beautiful Ginrin Ki Matsuba koi', 'FEMALE', 'VERIFIED'),
(1, 1, 48, 2023, 1000000, '2023-03-17 00:00:00.000000', 190, 33, '2023-12-28 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Gin%20Rin%20Kohaku%20Female%20Nisai%2048cm.png', 'Ginrin Kohaku', 'A beautiful Ginrin Kohaku koi', 'FEMALE', 'VERIFIED'),
(1, 1, 51, 2023, 1000000, '2023-02-28 00:00:00.000000', 191, 24, '2023-09-04 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Gin%20Rin%20Showa%202%20Female%20Nisai%2051cm.png', 'Ginrin Showa', 'A beautiful Ginrin Showa koi', 'FEMALE', 'VERIFIED'),
(1, 1, 48, 2023, 1000000, '2023-10-04 00:00:00.000000', 192, 36, '2024-05-09 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Gin%20Rin%20Showa%203%20Female%20Nisai%2048cm.png', 'Ginrin Showa', 'A beautiful Ginrin Showa koi', 'FEMALE', 'VERIFIED'),
(1, 1, 50, 2023, 1000000, '2024-12-14 00:00:00.000000', 193, 28, '2024-12-21 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/HI%20Utsuri%20Female%20Nisai%20...2cm.png', 'Ginrin Hi Utsuri', 'A beautiful Ginrin Hi Utsuri koi', 'FEMALE', 'VERIFIED'),
(1, 1, 56, 2023, 1000000, '2024-06-03 00:00:00.000000', 194, 33, '2024-09-02 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/photos/Hi%20Utsuri%20Female%20Nisai%2056cm%20646.png', 'Hi Utsuri', 'A beautiful Hi Utsuri koi', 'FEMALE', 'VERIFIED'),
(1, 1, 56, 2023, 1000000, '2024-06-19 00:00:00.000000', 195, 36, '2024-10-03 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Ki%20Utsuri%20Female%20Naisai%2056cm.png', 'Ki Utsuri', 'A beautiful Ki Utsuri koi', 'FEMALE', 'VERIFIED'),
(1, 1, 62, 2023, 1000000, '2024-04-17 00:00:00.000000', 196, 27, '2024-07-31 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Kin%20%20Hi%20Utsuri%20Female%20Nisai%2062cm.png', 'Kin Hi Utsuri', 'A beautiful Kin Hi Utsuri koi', 'FEMALE', 'VERIFIED'),
(1, 1, 52, 2023, 1000000, '2023-08-23 00:00:00.000000', 197, 27, '2024-02-16 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Kohaku%20Female%20Nisai%2052cm.png', 'Kohaku', 'A beautiful Kohaku koi', 'FEMALE', 'VERIFIED'),
(1, 1, 51, 2023, 1000000, '2023-05-30 00:00:00.000000', 198, 34, '2024-05-30 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Kujaku%20Female%20Nisai%2051cm.png', 'Kujaku', 'A beautiful Kujaku koi', 'FEMALE', 'VERIFIED'),
(1, 1, 55, 2023, 1000000, '2023-04-26 00:00:00.000000', 199, 36, '2024-01-24 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Ochiba%20Female%20Nisai%2055cm.png', 'Ochiba', 'A beautiful Ochiba koi', 'FEMALE', 'VERIFIED'),
(5, 1, 58, 2023, 1000000, '2023-12-03 00:00:00.000000', 200, 35, '2024-09-17 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Ogona%20Ochiba%20Female%20Nisai%2058cm.png', 'Ogana Ochiba', 'A beautiful Ogana Ochiba koi', 'FEMALE', 'VERIFIED'),
(5, 1, 50, 2023, 1000000, '2024-02-16 00:00:00.000000', 201, 29, '2024-06-14 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Showa%20Female%20Nisai%2050cm.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(5, 1, 53, 2023, 1000000, '2024-09-10 00:00:00.000000', 202, 34, '2024-11-13 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Showa%20Female%20Nisai%2053cm.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(5, 1, 58, 2023, 1000000, '2024-09-13 00:00:00.000000', 203, 26, '2024-12-06 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Showa%20Female%20Nisai%2058cm.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(5, 1, 56, 2023, 1000000, '2024-08-26 00:00:00.000000', 204, 29, '2024-12-30 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Yamibuki%20Female%20Nisai%2056cm.png', 'Ginrin Karashigoi', 'A beautiful Ginrin Karashigoi koi', 'FEMALE', 'VERIFIED'),
(5, 1, 51, 2023, 1000000, '2023-11-23 00:00:00.000000', 205, 24, '2024-05-12 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Aka%20Matsuba.png', 'Aka Matsuba', 'A beautiful Aka Matsuba koi', 'FEMALE', 'VERIFIED'),
(5, 1, 38, 2023, 1000000, '2023-03-22 00:00:00.000000', 206, 27, '2024-11-10 21:57:44.603530', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/1%20Ginrin%20Soragoi%2038cm%20edited.png', 'Ginrin Soragoi', 'A beautiful Ginrin Soragoi koi', 'FEMALE', 'VERIFIED'),
(5, 1, 37, 2023, 1000000, '2023-12-06 00:00:00.000000', 207, 28, '2024-09-18 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/2%20Koromo%2037cm%20edited.png', 'Ai Goromo', 'A beautiful Ai Goromo koi', 'MALE', 'VERIFIED'),
(5, 1, 38, 2023, 1000000, '2023-02-25 00:00:00.000000', 208, 35, '2024-03-30 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/3%20Hi%20Utsuri%2038cm%20edited.png', 'Hi Utsuri', 'A beautiful Hi Utsuri koi', 'FEMALE', 'VERIFIED'),
(5, 1, 34, 2023, 1000000, '2023-09-16 00:00:00.000000', 209, 28, '2024-11-11 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/5%20Ochiba%2034cm%20edited.png', 'Ochiba', 'A beautiful Ochiba koi', 'MALE', 'VERIFIED'),
(5, 1, 45, 2023, 1000000, '2024-01-28 00:00:00.000000', 210, 25, '2024-06-23 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/6%20Kin%20Ki%20Utsuri%2045cm%20edited.png', 'Kin Ki Utsuri', 'A beautiful Kin Ki Utsuri koi', 'MALE', 'VERIFIED'),
(5, 1, 35, 2023, 1000000, '2023-07-14 00:00:00.000000', 211, 33, '2023-10-28 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/7%20Ginrin%20Ochiba%2035cm%20edited.png', 'Ginrin Ochiba', 'A beautiful Ginrin Ochiba koi', 'FEMALE', 'VERIFIED'),
(5, 1, 33, 2023, 1000000, '2024-05-01 00:00:00.000000', 212, 36, '2024-12-20 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/8%20Kin%20Showa%2033cm%20edited.png', 'Kin Showa', 'A beautiful Kin Showa koi', 'FEMALE', 'VERIFIED'),
(5, 1, 33, 2023, 1000000, '2023-02-14 00:00:00.000000', 213, 24, '2023-11-14 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/4%20Tancho%20Goshiki%2033cm%20edited.png', 'Tancho Goshiki', 'A beautiful Tancho Goshiki koi', 'MALE', 'VERIFIED'),
(5, 1, 31, 2023, 1000000, '2024-07-18 00:00:00.000000', 214, 34, '2024-09-27 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/9%20Ginrin%20Goshiki%2031cm%20edited.png', 'Ginrin Goshiki', 'A beautiful Ginrin Goshiki koi', 'FEMALE', 'VERIFIED'),
(5, 1, 39, 2023, 1000000, '2023-08-16 00:00:00.000000', 215, 33, '2023-10-02 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/10%20Koromo%2039cm%20edited.png', 'Ai Goromo', 'A beautiful Ai Goromo koi', 'FEMALE', 'VERIFIED'),
(5, 1, 36, 2023, 1000000, '2023-03-22 00:00:00.000000', 216, 37, '2023-10-04 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/11%20Ginrin%20Chagoi%2036cm%20edited.png', 'Ginrin Chagoi', 'A beautiful Ginrin Chagoi koi', 'FEMALE', 'VERIFIED'),
(5, 1, 32, 2023, 1000000, '2024-07-31 00:00:00.000000', 217, 35, '2024-08-19 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/12%20Tancho%20Goshiki%20Edited.png', 'Tancho Goshiki', 'A beautiful Tancho Goshiki koi', 'FEMALE', 'VERIFIED'),
(5, 1, 35, 2023, 1000000, '2023-05-18 00:00:00.000000', 218, 32, '2023-12-25 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/13%20Ginrin%20Goshiki%2035cm%20edited.png', 'Ginrin Goshiki', 'A beautiful Ginrin Goshiki koi', 'FEMALE', 'VERIFIED'),
(5, 1, 35, 2023, 1000000, '2024-03-29 00:00:00.000000', 219, 33, '2024-07-16 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/14%20Kikusui%2035cm%20edited.png', 'Kikusui', 'A beautiful Kikusui koi', 'FEMALE', 'VERIFIED'),
(5, 1, 38, 2023, 1000000, '2023-11-26 00:00:00.000000', 220, 26, '2024-08-01 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/15%20Hi%20Utsuri%2038cm%20edited.png', 'Hi Utsuri', 'A beautiful Hi Utsuri koi', 'FEMALE', 'VERIFIED'),
(5, 1, 38, 2023, 1000000, '2024-11-23 00:00:00.000000', 221, 29, '2024-12-21 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/16%20Ochiba%2038cm%20edited.png', 'Ochiba', 'A beautiful Ochiba koi', 'FEMALE', 'VERIFIED'),
(5, 1, 30, 2023, 1000000, '2024-09-21 00:00:00.000000', 222, 34, '2024-11-20 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/17%20Tancho%20Goshiki%2030cm%20edited.png', 'Tancho Goshiki', 'A beautiful Tancho Goshiki koi', 'MALE', 'VERIFIED'),
(5, 1, 36, 2023, 1000000, '2023-07-01 00:00:00.000000', 223, 28, '2024-12-08 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/18%20Goshiki%2036cm%20edited.png', 'Goshiki', 'A beautiful Goshiki koi', 'FEMALE', 'VERIFIED'),
(5, 1, 33, 2023, 1000000, '2024-05-16 00:00:00.000000', 224, 33, '2024-06-08 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/19%20Gohiski%2033cm%20edited.png', 'Goshiki', 'A beautiful Goshiki koi', 'FEMALE', 'VERIFIED'),
(5, 1, 37, 2023, 1000000, '2024-06-08 00:00:00.000000', 225, 32, '2024-09-26 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/20%20Goshiki%2037cm%20edited.png', 'Goshiki', 'A beautiful Goshiki koi', 'FEMALE', 'VERIFIED'),
(5, 1, 48, 2023, 1000000, '2023-12-15 00:00:00.000000', 226, 25, '2024-03-01 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/21%20Goshiki%2048cm%20edited.png', 'Goshiki', 'A beautiful Goshiki koi', 'FEMALE', 'VERIFIED'),
(5, 1, 53, 2023, 1000000, '2024-03-07 00:00:00.000000', 227, 35, '2024-12-29 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Gin%20Rin%20Ochiba%2053cm%20Tank%204%205.png', 'Ginrin Ochiba', 'A beautiful Ginrin Ochiba koi', 'FEMALE', 'VERIFIED'),
(5, 1, 55, 2023, 1000000, '2023-06-30 00:00:00.000000', 228, 35, '2023-07-08 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Doitsu%20Showa%2055cm%20Tank%204%205.png', 'Doitsu Showa', 'A beautiful Doitsu Showa koi', 'FEMALE', 'VERIFIED'),
(5, 1, 47, 2023, 1000000, '2024-11-18 00:00:00.000000', 229, 31, '2024-12-01 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Showa%2067cm%20Tank%204%205.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(5, 1, 67, 2023, 1000000, '2023-07-29 00:00:00.000000', 230, 28, '2024-03-08 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Maruten%20Showa%2067cm%20Tank%204%205.png', 'Maruten Showa', 'A beautiful Maruten Showa koi', 'FEMALE', 'VERIFIED'),
(6, 1, 70, 2023, 1000000, '2024-06-24 00:00:00.000000', 231, 30, '2024-09-18 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Kujaku%2070cm%20Tank%204%205.png', 'Kujaku', 'A beautiful Kujaku koi', 'FEMALE', 'VERIFIED'),
(6, 1, 58, 2023, 1000000, '2024-04-04 00:00:00.000000', 232, 31, '2024-09-24 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Sanke%2058cm%20Tank%204%205.png', 'Sanke', 'A beautiful Sanke koi', 'FEMALE', 'VERIFIED'),
(6, 1, 51, 2023, 1000000, '2023-01-01 00:00:00.000000', 233, 35, '2023-04-15 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Hi%20Utsuri%2051cm%20Tank%204%205%202.0.png', 'Hi Utsuri', 'A beautiful Hi Utsuri koi', 'FEMALE', 'VERIFIED'),
(6, 1, 55, 2023, 1000000, '2023-12-25 00:00:00.000000', 234, 29, '2024-09-26 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Sakura%20Ogon%2055cm%20Tank%204%205.png', 'Sakura Ogon', 'A beautiful Sakura Ogon koi', 'FEMALE', 'VERIFIED'),
(6, 1, 49, 2023, 1000000, '2023-08-03 00:00:00.000000', 235, 28, '2024-05-25 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Shiro%20Utsuri%2049cm%20Tank%204%205.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(6, 1, 70, 2023, 1000000, '2023-07-04 00:00:00.000000', 236, 33, '2023-07-27 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Tancho%20Showa%2070cm%20Tank%204%205%202.0.png', 'Tancho Showa', 'A beautiful Tancho Showa koi', 'FEMALE', 'VERIFIED'),
(6, 1, 35, 2023, 1000000, '2023-08-25 00:00:00.000000', 237, 27, '2024-09-09 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/11/photos/Hi%20Utsuri%2035cm%20Tank%206.png', 'Hi Utsuri', 'A beautiful Hi Utsuri koi', 'MALE', 'VERIFIED'),
(6, 1, 27, 2023, 1000000, '2023-03-25 00:00:00.000000', 238, 35, '2024-07-22 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/11/photos/Karashigoi%2027cm%20Tank%206.png', 'Yellow Monkey', 'A beautiful Yellow Monkey koi', 'FEMALE', 'VERIFIED'),
(6, 1, 25, 2023, 1000000, '2023-10-14 00:00:00.000000', 239, 27, '2024-01-01 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/11/photos/Kohaku%2025cm%20Tank%206%201.2.png', 'Kohaku', 'A beautiful Kohaku koi', 'FEMALE', 'VERIFIED'),
(6, 1, 35, 2023, 1000000, '2024-03-26 00:00:00.000000', 240, 37, '2024-10-21 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/11/photos/Sanke%2035cm%20Tank%206%201.2.png', 'Sanke', 'A beautiful Sanke koi', 'MALE', 'VERIFIED'),
(6, 1, 28, 2023, 1000000, '2024-09-28 00:00:00.000000', 241, 36, '2024-11-23 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/11/photos/Shiro%20Utsuri%2028cm%20Tank%206.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'MALE', 'VERIFIED'),
(6, 1, 41, 2023, 1000000, '2023-04-21 00:00:00.000000', 242, 28, '2024-04-26 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/12/photos/Sanke%2041cm%20Tank%206%201.4.png', 'Sanke', 'A beautiful Sanke koi', 'MALE', 'VERIFIED'),
(6, 1, 30, 2023, 1000000, '2023-08-19 00:00:00.000000', 243, 28, '2024-02-09 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/12/photos/Kohaku%2030cm%20Tank%206%201.3.png', 'Kohaku', 'A beautiful Kohaku koi', 'MALE', 'VERIFIED'),
(6, 1, 22, 2023, 1000000, '2024-07-15 00:00:00.000000', 244, 33, '2024-10-18 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/13/photos/Gin-Rin%20Kohaku%2022cm%201.2.png', 'Ginrin Kohaku', 'A beautiful Ginrin Kohaku koi', 'MALE', 'VERIFIED'),
(6, 1, 35, 2023, 1000000, '2024-06-08 00:00:00.000000', 245, 34, '2024-08-18 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/13/photos/Sanke%2035cm%20Tank%206%202.5.png', 'Sanke', 'A beautiful Sanke koi', 'FEMALE', 'VERIFIED'),
(6, 1, 36, 2023, 1000000, '2023-06-06 00:00:00.000000', 246, 26, '2023-10-31 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/14/photos/Showa%2036cm.png', 'Showa', 'A beautiful Showa koi', 'MALE', 'VERIFIED'),
(6, 1, 36, 2023, 1000000, '2024-01-18 00:00:00.000000', 247, 37, '2024-02-12 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/14/photos/Yellow%20Monkey%20yellow%2036cm.png', 'Yellow Monkey', 'A beautiful Yellow Monkey koi', 'FEMALE', 'VERIFIED'),
(6, 1, 36, 2023, 1000000, '2024-07-16 00:00:00.000000', 248, 35, '2024-12-25 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/14/photos/Sanke%2036cm0.png', 'Sanke', 'A beautiful Sanke koi', 'FEMALE', 'VERIFIED'),
(6, 1, 36, 2023, 1000000, '2024-01-19 00:00:00.000000', 249, 33, '2024-10-10 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/15/photos/Yellow%20Monkey%20orange%2036cm.png', 'Yellow Monkey', 'A beautiful Yellow Monkey koi', 'FEMALE', 'VERIFIED'),
(6, 1, 43, 2023, 1000000, '2023-09-12 00:00:00.000000', 250, 36, '2023-10-26 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/15/photos/Ai%20Goromo%2041cm.png', 'Ai Goromo', 'A beautiful Ai Goromo koi', 'FEMALE', 'VERIFIED'),
(6, 1, 35, 2023, 1000000, '2024-10-23 00:00:00.000000', 251, 33, '2024-10-31 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/15/photos/AJ.png', 'Kohaku', 'A beautiful Kohaku koi', 'FEMALE', 'VERIFIED'),
(6, 1, 44, 2023, 1000000, '2024-03-21 00:00:00.000000', 252, 30, '2024-10-29 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/16/photos/Showa%2044cm.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(6, 1, 38, 2023, 1000000, '2024-02-17 00:00:00.000000', 253, 25, '2024-07-18 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/16/photos/Hi%20Utsuri%2038cm.png', 'Hi Utsuri', 'A beautiful Hi Utsuri koi', 'FEMALE', 'VERIFIED'),
(6, 1, 38, 2023, 1000000, '2024-03-28 00:00:00.000000', 254, 33, '2024-12-08 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/16/photos/Kohaku%2038cm.png', 'Kohaku', 'A beautiful Kohaku koi', 'FEMALE', 'VERIFIED'),
(6, 1, 64, 2023, 1000000, '2024-02-19 00:00:00.000000', 255, 35, '2024-12-15 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/17/photos/Red%20Karashigoi%2064cm2.png', 'Red Karashigoi', 'A beautiful Red Karashigoi koi', 'FEMALE', 'VERIFIED'),
(6, 1, 32, 2023, 1000000, '2024-04-20 00:00:00.000000', 256, 24, '2024-09-06 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/17/photos/Sanke%2032cm.png', 'Sanke', 'A beautiful Sanke koi', 'FEMALE', 'VERIFIED'),
(6, 1, 27, 2023, 1000000, '2024-08-08 00:00:00.000000', 257, 27, '2024-12-21 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/17/photos/Shiro%20Utsuri%2027cm.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(6, 1, 37, 2023, 1000000, '2023-03-22 00:00:00.000000', 258, 27, '2023-09-25 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/18/photos/Sanke%2037cm.png', 'Sanke', 'A beautiful Sanke koi', 'FEMALE', 'VERIFIED'),
(6, 1, 51, 2023, 1000000, '2023-11-16 00:00:00.000000', 259, 32, '2023-12-10 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/18/photos/Aragoke%20Doitsu%20Black%20Diamond%2051cm.png', 'Doitsu Aragoke Black Diamond', 'A beautiful Doitsu Aragoke Black Diamond koi', 'FEMALE', 'VERIFIED'),
(6, 1, 40, 2023, 1000000, '2024-07-31 00:00:00.000000', 260, 24, '2024-08-17 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/18/photos/Showa%2040cm.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(6, 1, 34, 2023, 1000000, '2023-12-15 00:00:00.000000', 261, 34, '2024-07-10 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/19/photos/Beni%20Kumonryu%2034cm.png', 'Beni Kumonryu', 'A beautiful Beni Kumonryu koi', 'FEMALE', 'VERIFIED'),
(6, 1, 37, 2023, 1000000, '2024-11-18 00:00:00.000000', 262, 27, '2024-12-20 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/19/photos/Ai%20Goromo%2037cm2%20no%20beni%20kumonryu.png', 'Ai Goromo', 'A beautiful Ai Goromo koi', 'FEMALE', 'VERIFIED'),
(6, 1, 30, 2023, 1000000, '2023-03-17 00:00:00.000000', 263, 34, '2024-07-29 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/19/photos/Shiro%20Utsuri%2030cm.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(6, 1, 45, 2023, 1000000, '2024-05-17 00:00:00.000000', 264, 35, '2024-09-26 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/20/photos/Showa%2045cm0.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(6, 1, 40, 2023, 1000000, '2024-06-14 00:00:00.000000', 265, 30, '2024-10-28 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/20/photos/Black%20Diamond%2040cm.png', 'Black Diamond', 'A beautiful Black Diamond koi', 'FEMALE', 'VERIFIED'),
(6, 1, 35, 2023, 1000000, '2023-02-07 00:00:00.000000', 266, 28, '2024-11-08 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/20/photos/Sanke%2035cm.png', 'Sanke', 'A beautiful Sanke koi', 'FEMALE', 'VERIFIED'),
(6, 1, 41, 2023, 1000000, '2023-11-24 00:00:00.000000', 267, 24, '2024-11-20 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/21/photos/Kohaku%2041.png', 'Kohaku', 'A beautiful Kohaku koi', 'FEMALE', 'VERIFIED'),
(6, 1, 37, 2023, 1000000, '2024-06-13 00:00:00.000000', 268, 28, '2024-08-14 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/21/photos/Doitsu%20Aka%20Matsuba%2037cm.png', 'Doitsu Aka Matsuba', 'A beautiful Doitsu Aka Matsuba koi', 'FEMALE', 'VERIFIED'),
(6, 1, 36, 2023, 1000000, '2023-10-19 00:00:00.000000', 269, 24, '2024-06-04 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/21/photos/Showa%2036.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(6, 1, 35, 2023, 1000000, '2024-12-28 00:00:00.000000', 270, 30, '2024-12-28 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/22/photos/Showa%2035cm.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(7, 1, 37, 2023, 1000000, '2024-08-26 00:00:00.000000', 271, 37, '2024-12-29 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/22/photos/gin-rin%20chagoi%2037cm.png', 'Ginrin Chagoi', 'A beautiful Ginrin Chagoi koi', 'FEMALE', 'VERIFIED'),
(7, 1, 30, 2023, 1000000, '2023-04-20 00:00:00.000000', 272, 35, '2023-08-22 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/22/photos/Shiro%20UTsuri%2030cm.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(7, 1, 25, 2023, 1000000, '2023-09-21 00:00:00.000000', 273, 28, '2024-10-02 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/23/photos/Kohaku%2025cm%20Tank%206%201.2.png', 'Kohaku', 'A beautiful Kohaku koi', 'MALE', 'VERIFIED'),
(7, 1, 36, 2023, 1000000, '2024-07-21 00:00:00.000000', 274, 28, '2024-08-01 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/23/photos/Yellow%20Monkey%20orange%2036cm.png', 'Yellow Monkey', 'A beautiful Yellow Monkey koi', 'FEMALE', 'VERIFIED'),
(7, 1, 36, 2023, 1000000, '2024-08-23 00:00:00.000000', 275, 31, '2024-11-17 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/23/photos/Sanke%2036cm0.png', 'Sanke', 'A beautiful Sanke koi', 'FEMALE', 'VERIFIED'),
(7, 1, 35, 2023, 1000000, '2024-07-01 00:00:00.000000', 276, 34, '2024-11-22 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/24/photos/Hi%20Utsuri%2035cm%20Tank%206.png', 'Hi Utsuri', 'A beautiful Hi Utsuri koi', 'MALE', 'VERIFIED'),
(7, 1, 37, 2023, 1000000, '2023-09-14 00:00:00.000000', 277, 34, '2024-05-20 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/24/photos/Ai%20Goromo%2037cm2%20no%20beni%20kumonryu.png', 'Ai Goromo', 'A beautiful Ai Goromo koi', 'FEMALE', 'VERIFIED'),
(7, 1, 30, 2023, 1000000, '2023-06-17 00:00:00.000000', 278, 34, '2024-05-03 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/24/photos/Shiro%20Utsuri%2030cm.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(7, 1, 41, 2023, 1000000, '2024-05-05 00:00:00.000000', 279, 36, '2024-11-01 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/25/photos/Kohaku%2041.png', 'Kohaku', 'A beautiful Kohaku koi', 'FEMALE', 'VERIFIED'),
(7, 1, 34, 2023, 1000000, '2024-04-05 00:00:00.000000', 280, 36, '2024-07-13 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/25/photos/Beni%20Kumonryu%2034cm.png', 'Beni Kumonryu', 'A beautiful Beni Kumonryu koi', 'MALE', 'VERIFIED'),
(7, 1, 64, 2023, 1000000, '2024-03-03 00:00:00.000000', 281, 32, '2024-05-10 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/25/photos/Red%20Karashigoi%2064cm2.png', 'Red Karashigoi', 'A beautiful Red Karashigoi koi', 'FEMALE', 'VERIFIED'),
(7, 1, 40, 2023, 1000000, '2024-10-07 00:00:00.000000', 282, 28, '2024-10-18 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/26/photos/Showa%2040cm.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(7, 1, 35, 2023, 1000000, '2023-04-07 00:00:00.000000', 283, 26, '2024-10-27 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/26/photos/Yellow%20Monkey%2035cm.png', 'Yellow Monkey', 'A beautiful Yellow Monkey koi', 'FEMALE', 'VERIFIED'),
(7, 1, 26, 2023, 1000000, '2024-02-15 00:00:00.000000', 284, 26, '2024-11-03 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/26/photos/Shiro%20Utsuri%2026cm.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(7, 1, 43, 2023, 1000000, '2024-09-25 00:00:00.000000', 285, 31, '2024-11-09 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/27/photos/Ai%20Goromo%2043cm.png', 'Ai Goromo', 'A beautiful Ai Goromo koi', 'FEMALE', 'VERIFIED'),
(7, 1, 40, 2023, 1000000, '2023-03-30 00:00:00.000000', 286, 31, '2024-09-01 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/27/photos/Black%20Diamond%2040cm.png', 'Black Diamond', 'A beautiful Black Diamond koi', 'FEMALE', 'VERIFIED'),
(7, 1, 41, 2023, 1000000, '2024-12-27 00:00:00.000000', 287, 24, '2024-11-18 17:36:03.582376', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/27/photos/Sanke%2041cm.png', 'Sanke', 'A beautiful Sankeeeeeeeeee koi', 'MALE', 'VERIFIED'),
(7, 1, 35, 2023, 1000000, '2023-09-27 00:00:00.000000', 288, 31, '2024-06-17 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/28/photos/Showa%2035cm.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(7, 1, 32, 2023, 1000000, '2024-01-23 00:00:00.000000', 289, 33, '2024-04-27 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/28/photos/Yellow%20Monkey%2032cm.png', 'Yellow Monkey', 'A beautiful Yellow Monkey koi', 'FEMALE', 'VERIFIED'),
(7, 1, 39, 2023, 1000000, '2024-08-07 00:00:00.000000', 290, 37, '2024-11-20 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/28/photos/Sanke%2039cm.png', 'Sanke', 'A beautiful Sanke koi', 'FEMALE', 'VERIFIED'),
(7, 1, 40, 2023, 1000000, '2024-09-06 00:00:00.000000', 291, 27, '2024-12-26 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/29/photos/Showa%2040cm.png', 'Showa', 'A beautiful Showa koi', 'MALE', 'VERIFIED'),
(7, 1, 32, 2023, 1000000, '2023-07-18 00:00:00.000000', 292, 31, '2024-12-02 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/29/photos/Yellow%20Monkey%2032cm.png', 'Yellow Monkey', 'A beautiful Yellow Monkey koi', 'FEMALE', 'VERIFIED'),
(7, 1, 25, 2023, 1000000, '2023-10-12 00:00:00.000000', 293, 36, '2023-10-15 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/29/photos/Kohaku%2025cm%20Tank%206%201.2.png', 'Kohaku', 'A beautiful Kohaku koi', 'FEMALE', 'VERIFIED'),
(7, 1, 35, 2023, 1000000, '2024-09-19 00:00:00.000000', 294, 36, '2024-11-30 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/30/photos/Hi%20Utsuri%2035cm%20Tank%206.png', 'Hi Utsuri', 'A beautiful Hi Utsuri koi', 'MALE', 'VERIFIED'),
(7, 1, 46, 2023, 1000000, '2023-11-20 00:00:00.000000', 295, 31, '2024-04-01 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/30/photos/Asgai%2046cm.png', 'Asagi', 'A beautiful Asagi koi', 'FEMALE', 'VERIFIED'),
(7, 1, 37, 2023, 1000000, '2024-11-29 00:00:00.000000', 296, 27, '2024-12-09 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/30/photos/Doitsu%20Aka%20Matsuba%2037cm.png', 'Doitsu Aka Matsuba', 'A beautiful Doitsu Aka Matsuba koi', 'FEMALE', 'VERIFIED'),
(7, 1, 35, 2023, 1000000, '2024-11-10 00:00:00.000000', 297, 28, '2024-12-09 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/20/photos/Sanke%2035cm.png', 'Sanke', 'A beautiful Sanke koi', 'MALE', 'VERIFIED'),
(7, 1, 35, 2023, 1000000, '2024-11-13 00:00:00.000000', 298, 34, '2024-12-11 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/28/photos/Showa%2035cm.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(7, 1, 37, 2023, 1000000, '2024-01-19 00:00:00.000000', 299, 32, '2024-11-12 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/22/photos/gin-rin%20chagoi%2037cm.png', 'Ginrin Chagoi', 'A beautiful Ginrin Chagoi koi', 'FEMALE', 'VERIFIED'),
(7, 1, 42, 2023, 1000000, '2023-06-03 00:00:00.000000', 300, 26, '2024-03-16 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/20/photos/Black%20Diamond%2040cm.png', 'Black Diamond', 'A beautiful Black Diamond koi', 'FEMALE', 'VERIFIED'),
(8, 1, 42, 2023, 1000000, '2023-07-01 00:00:00.000000', 301, 34, '2024-08-23 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/32/photos/Sanke%2042cm.png', 'Sanke', 'A beautiful Sanke koi', 'MALE', 'VERIFIED'),
(8, 1, 32, 2023, 1000000, '2023-04-22 00:00:00.000000', 302, 24, '2024-03-10 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/32/photos/Shiro%20Utsuri%2032cm.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'MALE', 'VERIFIED'),
(8, 1, 44, 2023, 1000000, '2023-07-08 00:00:00.000000', 303, 31, '2024-11-14 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/33/photos/Hi%20Utsuri%2044cm.png', 'Hi Utsuri', 'A beautiful Hi Utsuri koi', 'FEMALE', 'VERIFIED'),
(8, 1, 28, 2023, 1000000, '2024-03-27 00:00:00.000000', 304, 26, '2024-04-28 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/33/photos/red%20Yellow%20Monkey%2028cm.png', 'Yellow Monkey', 'A beautiful Yellow Monkey koi', 'FEMALE', 'VERIFIED'),
(8, 1, 37, 2023, 1000000, '2024-01-06 00:00:00.000000', 305, 32, '2024-05-25 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/18/photos/Sanke%2037cm.png', 'Sanke', 'A beautiful Sanke koi', 'FEMALE', 'VERIFIED'),
(8, 1, 33, 2023, 1000000, '2024-07-30 00:00:00.000000', 306, 26, '2024-09-06 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/17/photos/Sanke%2032cm.png', 'Sanke', 'A beautiful Sanke koi', 'FEMALE', 'VERIFIED'),
(8, 1, 32, 2023, 1000000, '2023-10-11 00:00:00.000000', 307, 26, '2024-11-14 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/14/photos/Yellow%20Monkey%20yellow%2036cm.png', 'Yellow Monkey', 'A beautiful Yellow Monkey koi', 'FEMALE', 'VERIFIED'),
(8, 1, 42, 2023, 1000000, '2023-12-15 00:00:00.000000', 308, 26, '2024-07-11 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/34/photos/Ai%20Goromo%2042cm.png', 'Ai Goromo', 'A beautiful Ai Goromo koi', 'FEMALE', 'VERIFIED'),
(8, 1, 64, 2023, 1000000, '2023-05-28 00:00:00.000000', 309, 24, '2024-05-04 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/17/photos/Red%20Karashigoi%2064cm2.png', 'Red Karashigoi', 'A beautiful Red Karashigoi koi', 'FEMALE', 'VERIFIED'),
(8, 1, 32, 2023, 1000000, '2024-05-16 00:00:00.000000', 310, 29, '2024-08-30 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/35/photos/Black%20Diamond%2032cm.png', 'Black Diamond', 'A beautiful Black Diamond koi', 'FEMALE', 'VERIFIED'),
(8, 1, 37, 2023, 1000000, '2024-12-22 00:00:00.000000', 311, 34, '2024-12-29 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/35/photos/Showa%2037cm.png', 'Showa', 'A beautiful Showa koi', 'MALE', 'VERIFIED'),
(8, 1, 43, 2023, 1000000, '2024-02-14 00:00:00.000000', 312, 31, '2024-08-06 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/36/photos/Showa%2043cm.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(8, 1, 41, 2023, 1000000, '2024-07-13 00:00:00.000000', 313, 36, '2024-10-31 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/36/photos/Gin-Rin%20Chagoi%2041cm0.png', 'Ginrin Chagoi', 'A beautiful Ginrin Chagoi koi', 'FEMALE', 'VERIFIED'),
(8, 1, 34, 2023, 1000000, '2023-06-19 00:00:00.000000', 314, 24, '2024-07-21 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/36/photos/Kujaku%2034cm.png', 'Kujaku', 'A beautiful Kujaku koi', 'FEMALE', 'VERIFIED'),
(8, 1, 40, 2023, 1000000, '2024-06-08 00:00:00.000000', 315, 30, '2024-08-25 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/37/photos/Ai%20Goromo%2040cm.png', 'Ai Goromo', 'A beautiful Ai Goromo koi', 'FEMALE', 'VERIFIED'),
(8, 1, 36, 2023, 1000000, '2023-06-22 00:00:00.000000', 316, 36, '2024-09-03 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/37/photos/Black%20Diamond%2036cm.png', 'Black Diamond', 'A beautiful Black Diamond koi', 'FEMALE', 'VERIFIED'),
(8, 1, 34, 2023, 1000000, '2023-08-11 00:00:00.000000', 317, 33, '2024-01-01 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/37/photos/Gin-Rin%20Showa%2034cm.png', 'Ginrin Showa', 'A beautiful Ginrin Showa koi', 'FEMALE', 'VERIFIED'),
(8, 1, 40, 2023, 1000000, '2023-09-11 00:00:00.000000', 318, 28, '2024-09-13 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/27/photos/Black%20Diamond%2040cm.png', 'Black Diamond', 'A beautiful Black Diamond koi', 'FEMALE', 'VERIFIED'),
(8, 1, 52, 2023, 1000000, '2023-03-14 00:00:00.000000', 319, 34, '2024-01-07 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/38/photos/Showa%2052cm.png', 'Sanke', 'A beautiful Sanke koi', 'FEMALE', 'VERIFIED'),
(8, 1, 27, 2023, 1000000, '2024-07-11 00:00:00.000000', 320, 26, '2024-08-30 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/38/photos/Shiro%20Utsuri%2027cm.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(8, 1, 34, 2023, 1000000, '2024-04-17 00:00:00.000000', 321, 33, '2024-06-13 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/35/photos/Black%20Diamond%2032cm.png', 'Black Diamond', 'A beautiful Black Diamond koi', 'FEMALE', 'VERIFIED'),
(8, 1, 42, 2023, 1000000, '2023-05-27 00:00:00.000000', 322, 27, '2023-05-27 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/34/photos/Ai%20Goromo%2042cm.png', 'Ai Goromo', 'A beautiful Ai Goromo koi', 'FEMALE', 'VERIFIED'),
(8, 1, 37, 2023, 1000000, '2024-06-22 00:00:00.000000', 323, 29, '2024-08-28 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/22/photos/gin-rin%20chagoi%2037cm.png', 'Ginrin Chagoi', 'A beautiful Ginrin Chagoi koi', 'FEMALE', 'VERIFIED'),
(8, 1, 35, 2023, 1000000, '2023-08-06 00:00:00.000000', 324, 24, '2024-04-17 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/18/photos/Sanke%2037cm.png', 'Sanke', 'A beautiful Sanke koi', 'MALE', 'VERIFIED'),
(8, 1, 37, 2023, 1000000, '2024-07-14 00:00:00.000000', 325, 29, '2024-12-02 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/21/photos/Doitsu%20Aka%20Matsuba%2037cm.png', 'Doitsu Aka Matsuba', 'A beautiful Doitsu Aka Matsuba koi', 'FEMALE', 'VERIFIED'),
(8, 1, 38, 2023, 1000000, '2023-11-21 00:00:00.000000', 326, 25, '2024-05-24 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/20/photos/Black%20Diamond%2040cm.png', 'Black Diamond', 'A beautiful Black Diamond koi', 'FEMALE', 'VERIFIED'),
(8, 1, 26, 2023, 1000000, '2023-01-16 00:00:00.000000', 327, 25, '2024-08-10 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/11/photos/Kohaku%2025cm%20Tank%206%201.2.png', 'Kohaku', 'A beautiful Kohaku koi', 'FEMALE', 'VERIFIED'),
(8, 1, 44, 2023, 1000000, '2023-12-30 00:00:00.000000', 328, 24, '2024-01-14 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/33/photos/Hi%20Utsuri%2044cm.png', 'Hi Utsuri', 'A beautiful Hi Utsuri koi', 'MALE', 'VERIFIED'),
(8, 1, 35, 2023, 1000000, '2024-07-19 00:00:00.000000', 329, 30, '2024-10-18 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/14/photos/Yellow%20Monkey%20yellow%2036cm.png', 'Yellow Monkey', 'A beautiful Yellow Monkey koi', 'FEMALE', 'VERIFIED'),
(8, 1, 43, 2023, 1000000, '2023-10-07 00:00:00.000000', 330, 26, '2024-07-30 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/36/photos/Showa%2043cm.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(1, 1, 34, 2023, 1000000, '2024-08-06 00:00:00.000000', 331, 35, '2024-08-24 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/36/photos/Kujaku%2034cm.png', 'Kujaku', 'A beautiful Kujaku koi', 'FEMALE', 'VERIFIED'),
(1, 1, 35, 2023, 1000000, '2024-10-27 00:00:00.000000', 332, 29, '2024-11-09 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/20/photos/Sanke%2035cm.png', 'Sanke', 'A beautiful Sanke koi', 'MALE', 'VERIFIED'),
(1, 1, 38, 2023, 1000000, '2024-08-23 00:00:00.000000', 333, 26, '2024-12-21 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/43/photos/Doitsu%20Sanke%2038cm.png', 'Doitsu Maruten Sanke', 'A beautiful Doitsu Maruten Sanke koi', 'MALE', 'VERIFIED'),
(1, 1, 37, 2023, 1000000, '2024-03-04 00:00:00.000000', 334, 34, '2024-07-14 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/43/photos/Shiro%20Utsuri%2037cm.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(1, 1, 25, 2023, 1000000, '2024-04-24 00:00:00.000000', 335, 31, '2024-11-03 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/43/photos/Showa%2025cm.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(1, 1, 37, 2023, 1000000, '2023-01-03 00:00:00.000000', 336, 30, '2023-09-08 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/44/photos/Hi%20Utsuri%2037cm.png', 'Hi Utsuri', 'A beautiful Hi Utsuri koi', 'MALE', 'VERIFIED'),
(1, 1, 39, 2023, 1000000, '2023-12-15 00:00:00.000000', 337, 32, '2024-04-01 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/44/photos/Kujaku%2039cm.png', 'Kujaku', 'A beautiful Kujaku koi', 'FEMALE', 'VERIFIED'),
(1, 1, 46, 2023, 1000000, '2023-01-25 00:00:00.000000', 338, 37, '2023-10-23 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/44/photos/Black%20Diamond%2046cm.png', 'Black Diamond', 'A beautiful Black Diamond koi', 'FEMALE', 'VERIFIED'),
(1, 1, 48, 2023, 1000000, '2023-05-04 00:00:00.000000', 339, 29, '2024-08-17 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/45/photos/Kohaku%20dot%2048cm.png', 'Kohaku', 'A beautiful Kohaku koi', 'MALE', 'VERIFIED'),
(1, 1, 46, 2023, 1000000, '2024-04-27 00:00:00.000000', 340, 37, '2024-11-09 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/45/photos/Kage%20Shiro%20Utsuri%2046cm.png', 'Kage Shiro Utsuri', 'A beautiful Kage Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(1, 1, 48, 2023, 1000000, '2023-11-08 00:00:00.000000', 341, 28, '2024-08-21 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/45/photos/Kohaku%2048cm0.png', 'Kohaku', 'A beautiful Kohaku koi', 'FEMALE', 'VERIFIED'),
(1, 1, 44, 2023, 1000000, '2023-08-31 00:00:00.000000', 342, 27, '2024-08-19 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/46/photos/Golden%20Corn%2044cm.png', 'Golden Corn', 'A beautiful Golden Corn koi', 'FEMALE', 'VERIFIED'),
(1, 1, 52, 2023, 1000000, '2024-10-16 00:00:00.000000', 343, 28, '2024-12-19 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/46/photos/Showa%2052cm.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(1, 1, 47, 2023, 1000000, '2024-12-09 00:00:00.000000', 344, 36, '2024-12-16 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/46/photos/Karashigoi%2047cm.png', 'Karashigoi', 'A beautiful Karashigoi koi', 'FEMALE', 'VERIFIED'),
(1, 1, 28, 2023, 1000000, '2024-07-27 00:00:00.000000', 345, 31, '2024-10-25 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/47/photos/Shiro%20Utsuri%2028cm.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(1, 1, 44, 2023, 1000000, '2023-10-30 00:00:00.000000', 346, 35, '2024-11-30 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/47/photos/Showa%2044cm.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(1, 1, 30, 2023, 1000000, '2023-10-07 00:00:00.000000', 347, 31, '2024-03-16 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/47/photos/Yellow%20Monkey%2030cm.png', 'Yellow Monkey', 'A beautiful Yellow Monkey koi', 'FEMALE', 'VERIFIED'),
(1, 1, 34, 2023, 1000000, '2023-05-25 00:00:00.000000', 348, 36, '2024-09-14 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/49/photos/Gin-Rin%20Chagoi%2034cm.png', 'Ginrin Chagoi', 'A beautiful Ginrin Chagoi koi', 'FEMALE', 'VERIFIED'),
(1, 1, 35, 2023, 1000000, '2023-06-01 00:00:00.000000', 349, 28, '2024-12-21 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/49/photos/Shiro%20Utsuri%2035cm.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'MALE', 'VERIFIED'),
(1, 1, 43, 2023, 1000000, '2024-03-03 00:00:00.000000', 350, 27, '2024-10-25 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/49/photos/Showa%2043cm.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(9, 1, 39, 2023, 1000000, '2024-02-01 00:00:00.000000', 351, 35, '2024-05-18 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/48/photos/Black%20Diamond%2039cm.png', 'Black Diamond', 'A beautiful Black Diamond koi', 'FEMALE', 'VERIFIED'),
(9, 1, 40, 2023, 1000000, '2023-01-13 00:00:00.000000', 352, 37, '2023-09-04 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/48/photos/Kujaku%2040cm.png', 'Kujaku', 'A beautiful Kujaku koi', 'FEMALE', 'VERIFIED'),
(9, 1, 40, 2023, 1000000, '2024-04-25 00:00:00.000000', 353, 30, '2024-10-30 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/48/photos/Sanke%2040cm.png', 'Sanke', 'A beautiful Sanke koi', 'MALE', 'VERIFIED'),
(9, 1, 52, 2023, 1000000, '2024-12-15 00:00:00.000000', 354, 32, '2024-12-19 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/38/photos/Sanke%2052.png', 'Sanke', 'A beautiful Sanke koi', 'FEMALE', 'VERIFIED'),
(9, 1, 42, 2023, 1000000, '2023-10-30 00:00:00.000000', 355, 31, '2024-06-05 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/34/photos/Ai%20Goromo%2042cm.png', 'Ai Goromo', 'A beautiful Ai Goromo koi', 'FEMALE', 'VERIFIED'),
(9, 1, 41, 2023, 1000000, '2023-08-30 00:00:00.000000', 356, 24, '2024-02-20 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/36/photos/Gin-Rin%20Chagoi%2041cm0.png', 'Ginrin Chagoi', 'A beautiful Ginrin Chagoi koi', 'FEMALE', 'VERIFIED'),
(9, 1, 27, 2023, 1000000, '2023-10-16 00:00:00.000000', 357, 35, '2024-12-10 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/38/photos/Shiro%20Utsuri%2027cm.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'MALE', 'VERIFIED'),
(9, 1, 39, 2023, 1000000, '2023-04-14 00:00:00.000000', 358, 31, '2024-05-10 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/44/photos/Kujaku%2039cm.png', 'Kujaku', 'A beautiful Kujaku koi', 'FEMALE', 'VERIFIED'),
(9, 1, 40, 2023, 1000000, '2024-12-30 00:00:00.000000', 359, 27, '2024-12-30 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/44/photos/Sanke%2040cm.png', 'Sanke', 'A beautiful Sanke koi', 'FEMALE', 'VERIFIED');
INSERT INTO `kois` (`category_id`, `is_display`, `length`, `year_born`, `base_price`, `created_at`, `id`, `owner_id`, `updated_at`, `thumbnail`, `name`, `description`, `sex`, `status`) VALUES
(9, 1, 46, 2023, 1000000, '2023-01-07 00:00:00.000000', 360, 34, '2023-11-04 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/45/photos/Kage%20Shiro%20Utsuri%2046cm.png', 'Kage Shiro Utsuri', 'A beautiful Kage Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(9, 1, 38, 2023, 1000000, '2024-08-08 00:00:00.000000', 361, 26, '2024-10-16 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/43/photos/Doitsu%20Sanke%2038cm.png', 'Doitsu Maruten Sanke', 'A beautiful Doitsu Maruten Sanke koi', 'FEMALE', 'VERIFIED'),
(9, 1, 34, 2023, 1000000, '2024-07-30 00:00:00.000000', 362, 31, '2024-11-20 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/35/photos/Black%20Diamond%2032cm.png', 'Black Diamond', 'A beautiful Black Diamond koi', 'FEMALE', 'VERIFIED'),
(9, 1, 64, 2023, 1000000, '2024-12-03 00:00:00.000000', 363, 32, '2024-12-20 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/25/photos/Red%20Karashigoi%2064cm2.png', 'Red Karashigoi', 'A beautiful Red Karashigoi koi', 'FEMALE', 'VERIFIED'),
(9, 1, 37, 2023, 1000000, '2024-01-17 00:00:00.000000', 364, 31, '2024-06-14 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/30/photos/Doitsu%20Aka%20Matsuba%2037cm.png', 'Doitsu Aka Matsuba', 'A beautiful Doitsu Aka Matsuba koi', 'FEMALE', 'VERIFIED'),
(9, 1, 34, 2023, 1000000, '2023-11-20 00:00:00.000000', 365, 34, '2024-03-24 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/36/photos/Kujaku%2034cm.png', 'Kujaku', 'A beautiful Kujaku koi', 'FEMALE', 'VERIFIED'),
(9, 1, 39, 2023, 1000000, '2023-01-09 00:00:00.000000', 366, 28, '2023-09-27 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/55/photos/Sanke%2039cm.png', 'Sanke', 'A beautiful Sanke koi', 'FEMALE', 'VERIFIED'),
(9, 1, 32, 2023, 1000000, '2024-01-29 00:00:00.000000', 367, 30, '2024-05-20 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/55/photos/Shiro%20Utsuri%2032cm.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'MALE', 'VERIFIED'),
(9, 1, 35, 2023, 1000000, '2024-11-18 00:00:00.000000', 368, 24, '2024-12-11 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/55/photos/Gin-Rin%20Chagoi%2035cm.png', 'Ginrin Chagoi', 'A beautiful Ginrin Chagoi koi', 'FEMALE', 'VERIFIED'),
(9, 1, 44, 2023, 1000000, '2023-10-11 00:00:00.000000', 369, 25, '2024-05-11 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/56/photos/Sanke%2044cm.png', 'Sanke', 'A beautiful Sanke koi', 'FEMALE', 'VERIFIED'),
(9, 1, 36, 2023, 1000000, '2024-12-22 00:00:00.000000', 370, 31, '2024-12-26 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/56/photos/Chagoi%2036cm.png', 'Chagoi', 'A beautiful Chagoi koi', 'FEMALE', 'VERIFIED'),
(10, 1, 34, 2023, 1000000, '2023-09-30 00:00:00.000000', 371, 35, '2023-10-08 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/56/photos/Shiro%20Muji%2034cm.png', 'Shiro Muji', 'A beautiful Shiro Muji koi', 'FEMALE', 'VERIFIED'),
(10, 1, 36, 2023, 1000000, '2024-12-23 00:00:00.000000', 372, 26, '2024-12-24 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/57/photos/Showa%2036cm.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(10, 1, 37, 2023, 1000000, '2023-04-08 00:00:00.000000', 373, 28, '2024-01-27 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/57/photos/Showa%2037.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(10, 1, 43, 2023, 1000000, '2024-06-10 00:00:00.000000', 374, 24, '2024-09-16 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/57/photos/Showa%2043cm.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(10, 1, 27, 2023, 1000000, '2023-12-16 00:00:00.000000', 375, 27, '2024-05-28 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/58/photos/Orenji%20Ogon%2027cm%20F.png', 'Orenji Ogon', 'A beautiful Orenji Ogon koi', 'FEMALE', 'VERIFIED'),
(10, 1, 46, 2023, 1000000, '2024-08-07 00:00:00.000000', 376, 37, '2024-10-16 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/58/photos/Showa%2046cm%20F.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(10, 1, 33, 2023, 1000000, '2024-02-05 00:00:00.000000', 377, 37, '2024-06-25 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/58/photos/Gin-Rin%20Chagoi%2033cm%20F.png', 'Ginrin Chagoi', 'A beautiful Ginrin Chagoi koi', 'FEMALE', 'VERIFIED'),
(10, 1, 52, 2023, 1000000, '2023-07-20 00:00:00.000000', 378, 37, '2024-07-22 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/46/photos/Showa%2052cm.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(10, 1, 46, 2023, 1000000, '2024-02-08 00:00:00.000000', 379, 34, '2024-12-30 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/44/photos/Black%20Diamond%2046cm.png', 'Black Diamond', 'A beautiful Black Diamond koi', 'FEMALE', 'VERIFIED'),
(10, 1, 28, 2023, 1000000, '2024-07-06 00:00:00.000000', 380, 35, '2024-12-25 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/11/photos/Kohaku%2025cm%20Tank%206%201.2.png', 'Kohaku', 'A beautiful Kohaku koi', 'FEMALE', 'VERIFIED'),
(10, 1, 44, 2023, 1000000, '2023-11-05 00:00:00.000000', 381, 33, '2023-11-19 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/60/photos/Ai%20Goromo%2044cm%20M.png', 'Ai Goromo', 'A beautiful Ai Goromo koi', 'MALE', 'VERIFIED'),
(10, 1, 43, 2023, 1000000, '2024-01-21 00:00:00.000000', 382, 37, '2024-12-10 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/60/photos/Sanke%2043cm%20U.png', 'Sanke', 'A beautiful Sanke koi', 'FEMALE', 'VERIFIED'),
(10, 1, 45, 2023, 1000000, '2024-08-23 00:00:00.000000', 383, 29, '2024-09-29 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/60/photos/Hi%20Utsuri%2045cm%20U.png', 'Hi Utsuri', 'A beautiful Hi Utsuri koi', 'FEMALE', 'VERIFIED'),
(10, 1, 36, 2023, 1000000, '2023-09-07 00:00:00.000000', 384, 35, '2024-06-19 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/61/photos/Showa%2036cm%20F.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(10, 1, 30, 2023, 1000000, '2023-11-19 00:00:00.000000', 385, 35, '2024-07-01 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/61/photos/Shiro%20Utsuri%2036cm%20F.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'FEMALE', 'VERIFIED'),
(10, 1, 40, 2023, 1000000, '2024-02-09 00:00:00.000000', 386, 32, '2024-05-23 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/48/photos/Kujaku%2040cm.png', 'Kujaku', 'A beautiful Kujaku koi', 'FEMALE', 'VERIFIED'),
(10, 1, 62, 2023, 1000000, '2024-06-03 00:00:00.000000', 387, 31, '2024-06-21 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/62/photos/Showa%2062cm%20F.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(10, 1, 37, 2023, 1000000, '2023-02-08 00:00:00.000000', 388, 37, '2023-11-10 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/62/photos/Ochiba%2037cm%20M.png', 'Ochiba', 'A beautiful Ochiba koi', 'MALE', 'VERIFIED'),
(10, 1, 34, 2023, 1000000, '2023-06-26 00:00:00.000000', 389, 28, '2023-08-15 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/62/photos/Tancho%20Goshiki%2034cm%20F.png', 'Tancho Goshiki', 'A beautiful Tancho Goshiki koi', 'FEMALE', 'VERIFIED'),
(10, 1, 33, 2023, 1000000, '2023-03-19 00:00:00.000000', 390, 37, '2023-11-15 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/63/photos/Kikusui%2033cm%20F.png', 'Kikusui', 'A beautiful Kikusui koi', 'FEMALE', 'VERIFIED'),
(10, 1, 44, 2023, 1000000, '2023-12-22 00:00:00.000000', 391, 29, '2024-09-05 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/63/photos/Matsukawabake%2044cm%20F.png', 'Gin-Rin Beni Matsukawabake', 'A beautiful Gin-Rin Beni Matsukawabake koi', 'FEMALE', 'VERIFIED'),
(10, 1, 27, 2023, 1000000, '2023-01-14 00:00:00.000000', 392, 36, '2024-02-21 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/63/photos/Yamibuki%2027cm%20F.png', 'Yamabuki', 'A beautiful Yamabuki koi', 'FEMALE', 'VERIFIED'),
(10, 1, 34, 2023, 1000000, '2023-08-19 00:00:00.000000', 393, 24, '2024-11-09 11:30:17.320010', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/64/photos/Gin-Rin%20Chagoi%2034cm%20M.png', 'Ginrin Chagoi', 'A beautiful Ginrin Chagoi koi', 'MALE', 'VERIFIED'),
(10, 1, 35, 2023, 1000000, '2024-04-29 00:00:00.000000', 394, 35, '2024-05-19 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/64/photos/Shiro%20Utsuri%2035cm%20M.png', 'Shiro Utsuri', 'A beautiful Shiro Utsuri koi', 'MALE', 'VERIFIED'),
(10, 1, 37, 2023, 1000000, '2023-07-05 00:00:00.000000', 395, 26, '2024-12-25 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/35/photos/Showa%2037cm.png', 'Showa', 'A beautiful Showa koi', 'FEMALE', 'VERIFIED'),
(10, 1, 41, 2023, 1000000, '2023-07-23 00:00:00.000000', 396, 31, '2023-08-12 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/65%20Big%20Auction/photos/Goshiki%20auction.png', 'Goshiki', 'A beautiful Goshiki koi', 'FEMALE', 'VERIFIED'),
(10, 1, 54, 2023, 1000000, '2023-12-28 00:00:00.000000', 397, 30, '2024-10-31 08:37:21.886424', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/65%20Big%20Auction/photos/Golden%20Corn%2048cm.png', 'Golden Corn', 'A beautiful Golden Corn koi', 'FEMALE', 'VERIFIED'),
(10, 1, 39, 2023, 1000000, '2024-01-30 00:00:00.000000', 398, 36, '2024-05-04 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/65%20Big%20Auction/photos/Ochiba%2035cm%202.png', 'Ochiba', 'A beautiful Ochiba koi', 'MALE', 'VERIFIED'),
(10, 1, 59, 2023, 1000000, '2024-02-05 00:00:00.000000', 399, 30, '2024-06-20 00:00:00.000000', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/65%20Big%20Auction/photos/KOhaku%20dianichi.png', 'Kohaku', 'A beautiful Kohaku koi', 'FEMALE', 'VERIFIED'),
(10, 1, 61, 2023, 1000000, '2024-09-09 00:00:00.000000', 400, 31, '2024-10-31 08:37:23.019729', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/65%20Big%20Auction/photos/kOHAKU%20Dainichi.png', 'Kohaku', 'A beautiful Kohaku koi', 'FEMALE', 'VERIFIED'),
(10, 1, 30, 2023, 1000000, '2024-10-31 08:31:58.325842', 401, 25, '2024-10-31 08:37:12.236557', 'https://static.vecteezy.com/system/resources/previews/019/046/451/original/koi-carp-fish-png.png', 'KOI111', 'CA DEP TUYET VOI', 'FEMALE', 'VERIFIED'),
(10, 1, 230, 2023, 1000000, '2024-11-08 21:12:15.931647', 403, 5, '2024-11-08 21:45:50.323131', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/65%20Big%20Auction/photos/Golden%20Corn%2048cm.png', 'Tokuda', 'Koi from Japan', 'MALE', 'VERIFIED'),
(10, 1, 40, 2023, 1000000, '2024-11-09 10:51:46.341500', 404, 27, '2024-11-09 11:28:06.211337', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Shiro%20Utsuri%20Tosai%2022cm.png', 'Shiro Kuro', 'a nice Shiro Utsuri Koi', 'FEMALE', 'VERIFIED'),
(10, 1, 40, 2023, 1000000, '2024-11-09 11:02:17.463552', 405, 27, '2024-11-09 11:29:58.329288', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Hiroi%20Doitsu%20Sanke%2040cm%20Nisai.png', 'Doitsu Sancho', 'a nice Doitsu Sanke Koi', 'UNKNOWN', 'VERIFIED'),
(10, 1, 15, 2023, 1000000, '2024-11-09 21:27:24.976952', 406, 27, '2024-11-09 23:11:19.388072', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Shiro%20Utsuri%20Tosai%2022cm.png', 'Shiro Kuro', 'nice', 'FEMALE', 'VERIFIED'),
(10, 1, 20, 2023, 1000000, '2024-11-09 23:13:57.494415', 407, 27, '2024-11-09 23:23:33.711856', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/65%20Big%20Auction/photos/Golden%20Corn%2048cm.png', 'Ca Vang', 'hehe', 'MALE', 'VERIFIED'),
(10, 1, 15, 2023, 1000000, '2024-11-10 11:49:21.092254', 408, 27, '2024-11-10 11:49:21.092254', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/65%20Big%20Auction/photos/Golden%20Corn%2048cm.png', 'Magoi', 'Con ca mau vang va trang', 'MALE', 'VERIFIED'),
(10, 1, 30, 2023, 1000000, '2024-11-10 11:53:27.743121', 409, 27, '2024-11-10 11:53:27.743121', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/65%20Big%20Auction/photos/Goshiki%20auction.png', 'Black Diamond', 'Con ca mau den do', 'MALE', 'VERIFIED'),
(10, 1, 58, 2023, 1000000, '2024-11-10 11:55:02.502575', 410, 27, '2024-11-10 11:55:02.502575', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/65%20Big%20Auction/photos/KOhaku%20dianichi.png', 'Kohaku', 'Con ca mau cam trang', 'FEMALE', 'VERIFIED'),
(10, 1, 36, 2023, 1000000, '2024-11-10 11:57:01.750332', 411, 27, '2024-11-10 12:01:18.845052', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/23/photos/Yellow%20Monkey%20orange%2036cm.png', 'Yellow Monkey', 'Con ca di verified', 'FEMALE', 'VERIFIED'),
(10, 1, 30, 2023, 1000000, '2024-11-10 18:35:50.413673', 413, 20, '2024-11-10 20:30:52.667784', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Yamibuki.png', 'Doitsu Showa', 'muoi gio ba bay', 'UNKNOWN', 'VERIFIED'),
(10, 1, 20, 2023, 1500000, '2024-11-10 20:23:47.047738', 414, 20, '2024-11-10 20:23:47.047738', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No2%202y%20Plutinum%2056cm%20Female.png', 'Platinum Ogon', 'quy vuong bat tu', 'FEMALE', 'VERIFIED'),
(10, 1, 40, 2023, 1000000, '2024-11-11 20:02:29.226052', 415, 20, '2024-11-11 20:02:29.226052', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/31-55%20Gin%20Rin%20Showa.png', 'Gin-Rin Beni Matsukawabake', 'khoai tay loc xoay', 'FEMALE', 'VERIFIED'),
(10, 1, 20, 2023, 2000000, '2024-11-11 20:16:25.857528', 416, 25, '2024-11-11 20:19:21.369697', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/36/photos/Gin-Rin%20Chagoi%2041cm0.png', 'Doitsu Shiro Utsuri', 'Em nay hấp ngon', 'FEMALE', 'VERIFIED'),
(10, 1, 90, 2023, 1000000, '2024-11-11 21:22:16.622239', 417, 25, '2024-11-11 21:23:14.140977', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/64/photos/Gin-Rin%20Chagoi%2034cm%20M.png', 'Red Karashigoi', 'Em ca hitle', 'MALE', 'VERIFIED'),
(10, 1, 10, 2023, 1200000, '2024-11-12 10:03:47.696646', 418, 20, '2024-11-12 10:08:49.384201', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXJA32WU4rBpx7maglqeEtt3ot1tPIRWptxA&s', 'Dark Ochiba', 'Enter description here...', 'FEMALE', 'VERIFIED'),
(10, 1, 100, 2023, 1000000, '2024-11-12 10:24:52.359291', 419, 27, '2024-11-12 10:26:02.485535', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbVNaWS5HYp_KLYVHx3bnHdX0E-35GalBYBQ&s', 'Red Karashigoi', 'ca bien', 'MALE', 'VERIFIED'),
(10, 1, 90, 2022, 1000000, '2024-11-14 21:08:43.903086', 420, 25, '2024-11-14 21:10:15.845359', 'https://w7.pngwing.com/pngs/879/189/png-transparent-butterfly-koi-carassius-auratus-tail-creative-mermaid-tail-clip-buckle-free-free-logo-design-template-photography-creative-artwork-thumbnail.png', 'DuongCongSon ', 'Enter description here...', 'FEMALE', 'VERIFIED'),
(8, 1, 90, 2023, 2500000, '2024-11-15 16:15:20.273921', 421, 18, '2024-11-18 17:38:46.195320', 'https://i.ytimg.com/vi/JfLP9FdK6rE/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLBXRI5fOT7-mJImjELmBYGdDyKzQg', 'CaoHoangLuu', '911', 'FEMALE', 'VERIFIED'),
(10, 1, 35, 2023, 3000000, '2024-11-15 16:16:59.902282', 422, 18, '2024-11-15 16:16:59.902285', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/65%20Big%20Auction/photos/Goshiki%20auction.png', 'Goshiki', 'con ca mau do den', 'FEMALE', 'VERIFIED'),
(10, 1, 45, 2023, 1400000, '2024-11-15 16:17:40.278557', 423, 18, '2024-11-15 16:17:40.278575', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/65%20Big%20Auction/photos/Golden%20Corn%2048cm.png', 'Golden Corner', 'Con ca mau vang trang', 'FEMALE', 'VERIFIED'),
(10, 1, 35, 2023, 3400000, '2024-11-15 16:18:19.573874', 424, 18, '2024-11-15 16:18:19.573877', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/65%20Big%20Auction/photos/Ochiba%2035cm%202.png', 'Ochibaka', 'Ca mau trang cam vang', 'FEMALE', 'VERIFIED'),
(6, 1, 35, 2023, 2000500, '2024-11-18 11:08:37.175056', 425, 18, '2024-11-19 01:06:13.954825', 'https://lumiere-a.akamaihd.net/v1/images/07ff8e314e2798d32bfc8c39f82a9601677de34c.jpeg?region=0%2C0%2C600%2C600', 'Toi La Nemonome', 'nemo', 'MALE', 'VERIFIED'),
(10, 1, 20, 2024, 1000000, '2024-11-18 12:04:16.943415', 426, 27, '2024-11-18 12:04:16.943415', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/31-55%20Gin%20Rin%20Showa.png', 'Duong Nguyen Manh', 'DuongDZ', 'FEMALE', 'VERIFIED');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `koi_images`
--

CREATE TABLE `koi_images` (
  `id` bigint NOT NULL,
  `koi_id` bigint DEFAULT NULL,
  `image_url` varchar(300) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `video_url` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `active` bit(1) DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `shipping_date` date DEFAULT NULL,
  `total_money` float DEFAULT NULL,
  `id` bigint NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `address` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `first_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `note` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone_number` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `payment_method` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shipping_address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shipping_method` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tracking_number` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` enum('CANCELLED','COMPLETED','DELIVERED','PENDING','PROCESSING','SHIPPING') COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_details`
--

CREATE TABLE `order_details` (
  `number_of_products` int NOT NULL,
  `price` float NOT NULL,
  `total_money` float NOT NULL,
  `id` bigint NOT NULL,
  `order_id` bigint NOT NULL,
  `product_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `otps`
--

CREATE TABLE `otps` (
  `is_expired` bit(1) DEFAULT NULL,
  `is_used` bit(1) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `expired_at` datetime(6) DEFAULT NULL,
  `id` bigint NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `otp` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `otps`
--

INSERT INTO `otps` (`is_expired`, `is_used`, `created_at`, `expired_at`, `id`, `updated_at`, `email`, `otp`) VALUES
(b'1', b'1', '2024-09-28 09:00:13.067393', '2024-09-28 09:05:13.059192', 1, '2024-09-28 09:03:04.106708', 'hoanglcse181513@fpt.edu.vn', '853886'),
(b'1', b'0', '2024-09-30 08:26:57.508033', '2024-09-30 08:31:54.722583', 2, '2024-09-30 08:26:57.508045', 'caohoanggt0@gmail.com', '549126'),
(b'1', b'0', '2024-09-30 08:30:47.731452', '2024-09-30 08:35:43.734659', 3, '2024-09-30 08:30:47.731457', 'luukaohoang1604@gmail.com', '949211'),
(b'1', b'0', '2024-10-01 01:31:34.255917', '2024-10-01 01:36:34.235109', 4, '2024-10-01 02:06:43.505061', 'luukaohoang1604@gmail.com', '203907'),
(b'1', b'1', '2024-10-01 02:09:47.665277', '2024-10-01 02:14:45.322141', 5, '2024-10-01 02:10:11.117976', 'luukaohoang1604@gmail.com', '651850'),
(b'1', b'0', '2024-10-01 02:16:46.710810', '2024-10-01 02:21:45.357069', 6, '2024-10-01 02:16:46.710815', 'luukaohoang1604@gmail.com', '746803'),
(b'1', b'0', '2024-10-01 02:20:32.079047', '2024-10-01 02:25:30.364439', 7, '2024-10-01 02:20:32.079058', 'luukaohoang1604@gmail.com', '284557'),
(b'1', b'0', '2024-10-01 02:25:53.955642', '2024-10-01 02:30:53.948773', 8, '2024-10-01 02:25:53.955654', 'luukaohoang1604@gmail.com', '893316'),
(b'1', b'0', '2024-10-01 02:31:10.328353', '2024-10-01 02:36:10.322156', 9, '2024-10-01 02:31:10.328363', 'tet@gmail.com', '505209'),
(b'1', b'0', '2024-10-01 02:37:34.649672', '2024-10-01 02:42:34.644412', 10, '2024-10-01 02:37:34.649683', 'luu1231604@gmail.com', '556292'),
(b'1', b'0', '2024-10-01 02:40:19.458392', '2024-10-01 02:45:19.452182', 11, '2024-10-01 02:40:19.458403', 'testetet@gmail.com', '870921'),
(b'1', b'0', '2024-10-01 02:42:00.355417', '2024-10-01 02:47:00.348372', 12, '2024-10-01 02:42:00.355423', 'hehe@gmail.com', '174915'),
(b'1', b'1', '2024-10-01 02:46:17.568215', '2024-10-01 02:51:17.563754', 13, '2024-10-01 02:48:20.640102', 'luukaohoang1604@gmail.com', '700113'),
(b'1', b'0', '2024-10-05 16:11:18.699072', '2024-10-05 16:16:18.696391', 14, '2024-10-05 16:11:18.699083', 'manhduong@gmail.com', '821346'),
(b'1', b'0', '2024-10-05 16:11:34.176603', '2024-10-05 16:16:34.174143', 15, '2024-10-05 16:11:34.176611', 'manhduonglhp4@gmail.com', '655900'),
(b'1', b'0', '2024-11-06 16:32:44.787474', '2024-11-06 16:37:44.718785', 16, '2024-11-06 16:32:44.787478', 'hoang1@gmail.com', '502526'),
(b'1', b'0', '2024-11-06 22:02:18.268299', '2024-11-06 22:07:18.223951', 17, '2024-11-06 22:02:18.268299', 'sonduongcong8@gmail.com', '364079'),
(b'1', b'0', '2024-11-06 22:09:18.360133', '2024-11-06 22:14:18.317880', 18, '2024-11-06 22:09:18.360133', 'sonduongcong8@gmail.com', '325487'),
(b'1', b'1', '2024-11-08 10:56:22.992723', '2024-11-08 11:01:22.926201', 19, '2024-11-08 10:56:45.205688', 'hoangclw@gmail.com', '142807'),
(b'1', b'1', '2024-11-09 17:05:16.377409', '2024-11-09 17:10:16.309114', 20, '2024-11-09 17:05:52.454095', 'duongnmse181515@fpt.edu.vn', '167733'),
(b'1', b'1', '2024-11-10 18:12:11.527509', '2024-11-10 18:17:11.462410', 21, '2024-11-10 18:13:02.510610', 'manhduonglhp4@gmail.com', '907814'),
(b'1', b'1', '2024-11-10 21:39:26.758195', '2024-11-10 21:44:26.706834', 22, '2024-11-10 21:39:57.814733', 'sonduongcong8@gmail.com', '326204'),
(b'1', b'1', '2024-11-12 07:54:31.691575', '2024-11-12 07:59:31.605974', 23, '2024-11-12 07:55:25.604598', 'duongnmse181515@fpt.edu.vn', '457170'),
(b'1', b'1', '2024-11-12 09:34:59.038697', '2024-11-12 09:39:58.963489', 24, '2024-11-12 09:35:39.029921', 'vanvtt10@fpt.edu.vn', '816026'),
(b'1', b'1', '2024-11-13 16:26:09.921993', '2024-11-13 16:31:09.811737', 25, '2024-11-13 16:26:42.879797', 'caohoanggt0@gmail.com', '828064'),
(b'1', b'1', '2024-11-14 21:43:41.366078', '2024-11-14 21:48:41.318271', 26, '2024-11-14 21:44:32.722374', 'hoangdz1604@gmail.com', '954590'),
(b'1', b'1', '2024-11-15 10:03:44.755896', '2024-11-15 10:08:44.717496', 27, '2024-11-15 10:04:19.932775', 'hoangdz1604@gmail.com', '073694'),
(b'1', b'1', '2024-11-15 10:41:57.862421', '2024-11-15 10:46:57.824302', 28, '2024-11-15 10:42:36.040213', 'hoangdz1604@gmail.com', '783052'),
(b'1', b'1', '2024-11-15 10:49:43.753544', '2024-11-15 10:54:43.715701', 29, '2024-11-15 10:51:39.500952', 'hoangdz1604@gmail.com', '645943'),
(b'1', b'0', '2024-11-15 05:00:17.908075', '2024-11-15 05:05:17.836623', 30, '2024-11-15 05:00:17.908079', 'anhoang800140@gmail.com', '438415'),
(b'1', b'0', '2024-11-15 05:00:17.908128', '2024-11-15 05:05:17.836577', 31, '2024-11-15 05:00:17.908130', 'anhoang800140@gmail.com', '222098'),
(b'1', b'0', '2024-11-15 05:08:45.561028', '2024-11-15 05:13:45.504828', 32, '2024-11-15 05:08:45.561030', 'lienminhdaditfifa@gmail.com', '783018'),
(b'1', b'0', '2024-11-15 09:45:42.645787', '2024-11-15 09:50:42.603368', 33, '2024-11-15 09:45:42.645789', 'hoang@gmail.com', '354792'),
(b'1', b'0', '2024-11-15 09:46:20.584343', '2024-11-15 09:51:20.542639', 34, '2024-11-15 09:46:20.584345', 'hoang@gmail.com', '154625'),
(b'1', b'0', '2024-11-15 09:46:21.020220', '2024-11-15 09:51:20.976626', 35, '2024-11-15 09:46:21.020222', 'hoang@gmail.com', '689859'),
(b'1', b'0', '2024-11-15 17:16:23.445192', '2024-11-15 17:21:23.391975', 36, '2024-11-15 17:16:23.445196', 'taquoc196@gmail.com', '950707'),
(b'1', b'0', '2024-11-15 17:18:17.441297', '2024-11-15 17:23:17.396090', 37, '2024-11-15 17:18:17.441301', 'hoanduyphoto@gmail.com', '593017'),
(b'1', b'0', '2024-11-16 16:15:53.488550', '2024-11-16 16:20:53.443078', 38, '2024-11-16 16:15:53.488550', 'son@gmail.com', '876996'),
(b'1', b'0', '2024-11-16 19:01:15.156522', '2024-11-16 19:06:15.080810', 39, '2024-11-16 19:01:15.156524', 'nhducminhqt@gmail.com', '371372'),
(b'1', b'0', '2024-11-16 19:01:15.156522', '2024-11-16 19:06:15.080350', 40, '2024-11-16 19:01:15.156524', 'nhducminhqt@gmail.com', '787256'),
(b'1', b'0', '2024-11-16 19:01:15.156585', '2024-11-16 19:06:15.080382', 41, '2024-11-16 19:01:15.156586', 'nhducminhqt@gmail.com', '060323'),
(b'1', b'0', '2024-11-16 19:01:15.163492', '2024-11-16 19:06:15.080547', 42, '2024-11-16 19:01:15.163494', 'nhducminhqt@gmail.com', '421872'),
(b'1', b'0', '2024-11-16 19:01:15.165580', '2024-11-16 19:06:15.080690', 43, '2024-11-16 19:01:15.165582', 'nhducminhqt@gmail.com', '755329'),
(b'1', b'1', '2024-11-17 08:57:31.685789', '2024-11-17 09:02:31.586256', 44, '2024-11-17 08:58:11.844378', 'hoangdz1604@gmail.com', '712036'),
(b'1', b'1', '2024-11-17 09:11:48.478296', '2024-11-17 09:16:48.439744', 45, '2024-11-17 09:12:16.467037', 'hoangdz1604@gmail.com', '348945'),
(b'1', b'0', '2024-11-17 03:33:46.166082', '2024-11-17 03:38:46.126656', 46, '2024-11-17 03:33:46.166085', 'hoanglcse181513@fpt.edu.vn', '558817'),
(b'1', b'0', '2024-11-17 03:35:56.590165', '2024-11-17 03:40:56.551712', 47, '2024-11-17 03:35:56.590168', 'hoanglcse181513@fpt.edu.vn', '473608'),
(b'1', b'0', '2024-11-17 03:41:50.623422', '2024-11-17 03:46:50.589377', 48, '2024-11-17 03:41:50.623423', 'hoanglcse181513@fpt.edu.vn', '445768'),
(b'1', b'0', '2024-11-17 03:42:16.719265', '2024-11-17 03:47:16.679100', 49, '2024-11-17 03:42:16.719267', 'hoanglcse181513@fpt.edu.vn', '410339'),
(b'1', b'0', '2024-11-17 15:55:53.049939', '2024-11-17 16:00:53.017294', 50, '2024-11-17 15:55:53.049942', 'hoanglcse181513@fpt.edu.vn', '849348'),
(b'1', b'0', '2024-11-17 16:36:10.848710', '2024-11-17 16:41:10.795147', 51, '2024-11-17 16:36:10.848723', 'hoanglcse181513@fpt.edu.vn', '392611'),
(b'1', b'0', '2024-11-17 16:36:33.045001', '2024-11-17 16:41:32.473052', 52, '2024-11-17 16:36:33.045011', 'hoanglcse181513@fpt.edu.vn', '758342'),
(b'1', b'0', '2024-11-17 16:41:57.534228', '2024-11-17 16:46:57.500382', 53, '2024-11-17 16:41:57.534230', 'hoanglcse181513@fpt.edu.vn', '025181'),
(b'1', b'0', '2024-11-18 08:29:35.342277', '2024-11-18 08:34:35.304796', 54, '2024-11-18 08:29:35.342282', 'admin@gmail', '737708'),
(b'1', b'0', '2024-11-18 08:54:27.895293', '2024-11-18 08:59:27.860733', 55, '2024-11-18 08:54:27.895298', 'admin@gmail.com', '609691'),
(b'1', b'0', '2024-11-18 14:26:00.743225', '2024-11-18 14:31:00.698976', 56, '2024-11-18 14:26:00.743225', 'sonduongcong9@gmail.com', '564269'),
(b'1', b'1', '2024-11-18 15:52:17.423861', '2024-11-18 15:57:17.375445', 57, '2024-11-18 15:53:28.119298', 'toriansplett8397@gmail.com', '715195'),
(b'1', b'0', '2024-11-18 15:54:45.622455', '2024-11-18 15:59:45.580637', 58, '2024-11-18 15:54:45.622466', 'hoanglc@gmail.com', '859509'),
(b'1', b'1', '2024-11-18 16:09:23.496702', '2024-11-18 16:14:23.452059', 59, '2024-11-18 16:10:03.568303', 'perneyislam@gmail.com', '514574'),
(b'1', b'0', '2024-11-19 15:19:01.195960', '2024-11-19 15:24:01.114882', 60, '2024-11-19 15:19:01.195963', 'hoangdz1604@gmail.com', '326948'),
(b'1', b'0', '2024-11-19 15:20:10.310410', '2024-11-19 15:25:10.264187', 61, '2024-11-19 15:20:10.310415', 'hoangdz1604@gmail.com', '584240'),
(b'1', b'1', '2024-11-19 15:39:44.156465', '2024-11-19 15:44:44.122520', 62, '2024-11-19 15:40:38.212300', 'caohoanggt0@gmail.com', '672294'),
(b'1', b'1', '2024-11-19 15:55:04.067961', '2024-11-19 16:00:04.032209', 63, '2024-11-19 15:55:25.428321', 'caohoanggt0@gmail.com', '502864'),
(b'1', b'0', '2024-11-19 16:05:24.703671', '2024-11-19 16:10:24.663961', 64, '2024-11-19 16:05:24.703673', 'hoangclw@gmail.com', '798143'),
(b'1', b'0', '2024-11-19 16:11:04.349545', '2024-11-19 16:16:04.310688', 65, '2024-11-19 16:11:04.349547', 'hoangclw@gmail.com', '879666'),
(b'1', b'0', '2024-11-19 16:11:24.431820', '2024-11-19 16:16:24.394503', 66, '2024-11-19 16:11:24.431824', 'hoangclw@gmail.com', '566274'),
(b'1', b'0', '2024-11-19 16:16:59.540942', '2024-11-19 16:21:59.506433', 67, '2024-11-19 16:16:59.540943', 'hoangclw@gmail.com', '124779'),
(b'1', b'0', '2024-11-19 17:10:42.971980', '2024-11-19 17:15:42.971302', 68, '2024-11-19 17:10:42.971982', 'hoang123123@gmail.com', '762566'),
(b'1', b'1', '2024-11-19 17:20:28.447080', '2024-11-19 17:25:28.443713', 69, '2024-11-19 17:21:12.291321', 'hoanglcse181513@fpt.edu.vn', '871448'),
(b'1', b'0', '2024-11-19 18:05:05.904445', '2024-11-19 18:10:05.872443', 70, '2024-11-19 18:05:05.904445', 'duongnmse181515@fpt.edu.vn', '180427'),
(b'1', b'0', '2024-11-19 18:06:23.878290', '2024-11-19 18:11:23.853849', 71, '2024-11-19 18:06:23.878297', 'duongnmse181515@fpt.edu.vn', '774750'),
(b'1', b'0', '2024-11-19 15:22:43.000000', '2024-11-19 15:27:43.000000', 72, '2024-11-19 15:22:43.000000', 'son@gmail.com', '986879'),
(b'1', b'0', '2024-11-19 15:23:41.000000', '2024-11-19 15:28:41.000000', 73, '2024-11-19 15:23:41.000000', 'son@gmail.com', '360219'),
(b'1', b'1', '2024-11-19 15:26:25.000000', '2024-11-19 15:31:25.000000', 74, '2024-11-19 15:26:51.000000', 'hoanglcse181513@fpt.edu.vn', '422375'),
(b'1', b'0', '2024-11-24 14:50:37.971432', '2024-11-24 14:55:37.970757', 75, '2024-11-24 14:50:37.971435', 'hoang5@gmail.com', '440227');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payments`
--

CREATE TABLE `payments` (
  `payment_amount` float NOT NULL,
  `id` bigint NOT NULL,
  `order_id` bigint DEFAULT NULL,
  `payment_date` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  `bank_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bank_number` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `payment_method` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `payment_status` enum('PENDING','REFUNDED','SUCCESS') COLLATE utf8mb4_general_ci NOT NULL,
  `payment_type` enum('DEPOSIT','DRAW_OUT','ORDER') COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `payments`
--

INSERT INTO `payments` (`payment_amount`, `id`, `order_id`, `payment_date`, `user_id`, `bank_name`, `bank_number`, `payment_method`, `payment_status`, `payment_type`) VALUES
(5000000, 1, NULL, '2024-11-21 03:13:41.000000', 19, NULL, NULL, 'VNPAY', 'SUCCESS', 'DEPOSIT'),
(5000000, 2, NULL, '2024-11-21 03:15:21.000000', 19, NULL, NULL, 'VNPAY', 'SUCCESS', 'DEPOSIT'),
(5000000, 3, NULL, '2024-11-21 03:16:00.000000', 19, NULL, NULL, 'VNPAY', 'SUCCESS', 'DEPOSIT'),
(100000000, 4, NULL, '2024-11-21 03:17:21.000000', 19, NULL, NULL, 'VNPAY', 'SUCCESS', 'DEPOSIT'),
(1000000, 5, NULL, '2024-11-21 03:35:14.000000', 19, 'Techcombank', '0982959691', 'BANK_TRANSFER', 'PENDING', 'DRAW_OUT'),
(5000000, 6, NULL, '2024-11-21 03:35:23.000000', 19, 'Techcombank', '0982959691', 'BANK_TRANSFER', 'PENDING', 'DRAW_OUT'),
(50000000, 7, NULL, '2024-11-21 10:29:01.000000', 32, NULL, NULL, 'VNPAY', 'SUCCESS', 'DEPOSIT'),
(50000000, 8, NULL, '2024-11-21 10:37:53.000000', 35, NULL, NULL, 'VNPAY', 'SUCCESS', 'DEPOSIT'),
(50000000, 9, NULL, '2024-11-21 10:48:24.000000', 33, NULL, NULL, 'VNPAY', 'SUCCESS', 'DEPOSIT'),
(49990000, 10, NULL, '2024-11-21 13:55:04.000000', 30, NULL, NULL, 'VNPAY', 'SUCCESS', 'DEPOSIT');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `refunds`
--

CREATE TABLE `refunds` (
  `refund_amount` float NOT NULL,
  `id` bigint NOT NULL,
  `payment_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `refund_reason` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `refund_status` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `roles`
--

CREATE TABLE `roles` (
  `id` bigint NOT NULL,
  `name` enum('MEMBER','STAFF','BREEDER','MANAGER') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
(1, 'MEMBER'),
(2, 'STAFF'),
(3, 'BREEDER'),
(4, 'MANAGER');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `social_accounts`
--

CREATE TABLE `social_accounts` (
  `id` bigint NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `email` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `provider_name` enum('FACEBOOK','GOOGLE') COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tokens`
--

CREATE TABLE `tokens` (
  `expired` bit(1) NOT NULL,
  `is_mobile` tinyint(1) DEFAULT NULL,
  `revoked` bit(1) NOT NULL,
  `expiration_date` datetime(6) DEFAULT NULL,
  `id` bigint NOT NULL,
  `refresh_expiration_date` datetime(6) DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `token_type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `refresh_token` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `token` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `tokens`
--

INSERT INTO `tokens` (`expired`, `is_mobile`, `revoked`, `expiration_date`, `id`, `refresh_expiration_date`, `user_id`, `token_type`, `refresh_token`, `token`) VALUES
(b'0', 1, b'1', '2024-11-23 18:21:06.055440', 43, '2024-12-23 18:21:06.055757', 2, 'Bearer', '7b1bfeeb-d3fb-43a2-93e8-52af8dfc9755', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjIsImVtYWlsIjoic29uQGdtYWlsLmNvbSIsInN1YiI6InNvbkBnbWFpbC5jb20iLCJleHAiOjE3MzIzNjA4NjV9.Y2fZQaWZ5YtgipbSJ6yEnvgg0GM3VArlLYx4rfUeleI'),
(b'0', 1, b'1', '2024-11-24 07:45:00.706757', 50, '2024-12-24 07:45:00.707139', 2, 'Bearer', 'aa2f131d-cd84-4053-83e4-bc4bd912be25', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjIsImVtYWlsIjoic29uQGdtYWlsLmNvbSIsInN1YiI6InNvbkBnbWFpbC5jb20iLCJleHAiOjE3MzI0MDkxMDB9.ktxIapz7ZQ459QfrwT9fYYb8pxCw-oQndwJhv9J8j7Q'),
(b'0', 0, b'0', '2024-11-25 00:23:44.697717', 60, '2024-12-25 00:23:44.697717', 26, 'Bearer', 'ae300671-7f3a-4cc7-bef7-ecc6e8e81b44', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjI2LCJlbWFpbCI6InNha2FpQGdtYWlsLmNvbSIsInN1YiI6InNha2FpQGdtYWlsLmNvbSIsImV4cCI6MTczMjQ2OTAyNH0.R8cuBg2ahJTxMrmsA32hkP9SVZG7t6by9_xpim4ESvE'),
(b'0', 0, b'0', '2024-11-25 23:28:22.897818', 63, '2024-12-25 23:28:22.898819', 30, 'Bearer', 'b203029f-137e-4723-aa29-4703d4c38a15', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjMwLCJlbWFpbCI6InNoaW5vZGFAZ21haWwuY29tIiwic3ViIjoic2hpbm9kYUBnbWFpbC5jb20iLCJleHAiOjE3MzI1NTIxMDJ9.HtKYanwbyGj_IPk4A-Q7v_hHaNdQeUSDMmXklQa0A8c'),
(b'0', 0, b'1', '2024-11-25 23:28:23.880896', 64, '2024-12-25 23:28:23.880896', 30, 'Bearer', '25bdcd91-b940-4de6-ad92-771618d9a831', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjMwLCJlbWFpbCI6InNoaW5vZGFAZ21haWwuY29tIiwic3ViIjoic2hpbm9kYUBnbWFpbC5jb20iLCJleHAiOjE3MzI1NTIxMDN9.lTu8w3g7lGTh0ZoIVNh8QFuk8EkhiivZV1hgkR5FoAw'),
(b'0', 1, b'1', '2024-11-26 10:04:31.333655', 69, '2024-12-26 10:04:31.333875', 27, 'Bearer', 'c1b180b8-2d3c-4f8a-8fbb-5d1aafd8b4b1', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjI3LCJlbWFpbCI6ImlzYUBnbWFpbC5jb20iLCJzdWIiOiJpc2FAZ21haWwuY29tIiwiZXhwIjoxNzMyNTkwMjcxfQ.jstv7faQE_z5hyxiNHbJAw6IIzN4MJGL3nA2opFnPfc'),
(b'0', 1, b'1', '2024-12-09 23:11:54.387840', 214, '2025-01-08 23:11:54.387840', 27, 'Bearer', 'd8a16164-e3db-42fd-9f57-0bf673ddb3f2', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjI3LCJlbWFpbCI6ImlzYUBnbWFpbC5jb20iLCJzdWIiOiJpc2FAZ21haWwuY29tIiwiZXhwIjoxNzMzNzYwNzE0fQ.seeVthOMYhuUyewQzmSHuhQFQgUqER8b-ImnmTQrLag'),
(b'0', 0, b'1', '2024-12-10 14:32:39.005351', 250, '2025-01-09 14:32:39.005351', 24, 'Bearer', '4e955dc9-16f5-4c51-9421-2e19de9b00ab', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjI0LCJlbWFpbCI6Im5uZEBnbWFpbC5jb20iLCJzdWIiOiJubmRAZ21haWwuY29tIiwiZXhwIjoxNzMzODE1OTU4fQ.XHXW3_C_1_DFW5LkCJQIY8Bga-ebbpw6w4qViijzxpQ'),
(b'0', 0, b'1', '2024-12-10 21:40:03.708651', 254, '2025-01-09 21:40:03.708651', 9, 'Bearer', '02ed33f6-50a5-446f-954d-303f95761eb5', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjksImVtYWlsIjoibWFuaGR1b25nbGhwMkBnbWFpbC5jb20iLCJzdWIiOiJtYW5oZHVvbmdsaHAyQGdtYWlsLmNvbSIsImV4cCI6MTczMzg0MTYwM30.MMEZ4CnG6bBccEKiKDdoU4eVUmnWrwpbZtBKdRPchOk'),
(b'0', 0, b'0', '2024-12-11 08:08:44.901551', 260, '2025-01-10 08:08:44.901601', 35, 'Bearer', '5d9c165f-a3b4-4e7c-80d9-761a12b9c50e', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjM1LCJlbWFpbCI6Im1hcnVkb0BnbWFpbC5jb20iLCJzdWIiOiJtYXJ1ZG9AZ21haWwuY29tIiwiZXhwIjoxNzMzODc5MzI0fQ.R2_VRgQ_eRtcswik6wHwt7JBDTeJhYhVtfL7a9m6DCg'),
(b'0', 0, b'1', '2024-12-11 08:17:22.182037', 261, '2025-01-10 08:17:22.182339', 35, 'Bearer', 'b2bcbf9d-08d0-4635-b985-c1e92b8f2c4e', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjM1LCJlbWFpbCI6Im1hcnVkb0BnbWFpbC5jb20iLCJzdWIiOiJtYXJ1ZG9AZ21haWwuY29tIiwiZXhwIjoxNzMzODc5ODQxfQ.9NnXgdwV_b2GOmpoy8zZULSsiwnPW4EhLgmc6AHsMrM'),
(b'0', 0, b'1', '2024-12-11 22:43:28.758598', 293, '2025-01-10 22:43:28.759578', 40, 'Bearer', 'd46f78d9-3659-41dd-b9cd-947120a433f5', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjQwLCJlbWFpbCI6InNvbmR1b25nY29uZzhAZ21haWwuY29tIiwic3ViIjoic29uZHVvbmdjb25nOEBnbWFpbC5jb20iLCJleHAiOjE3MzM5MzE4MDh9.7TODtGet_ZR2VJXnd2iKuAeLqslsWIMY2yBtil72L-E'),
(b'0', 0, b'0', '2024-12-14 21:09:40.662094', 339, '2025-01-13 21:09:40.662094', 22, 'Bearer', '5c811c65-6eb6-41d3-9ed0-29ce5ed1e745', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjIyLCJlbWFpbCI6ImJhb3Z1QGdtYWlsLmNvbSIsInN1YiI6ImJhb3Z1QGdtYWlsLmNvbSIsImV4cCI6MTczNDE4NTM4MH0.0qoCF90rn86sKBy154udkkRI6krm7bozLq-GAJFvdMQ'),
(b'0', 0, b'1', '2024-12-15 05:09:28.709560', 363, '2025-01-14 05:09:28.709924', 44, 'Bearer', 'fb30b76e-fe22-4487-b888-8f5741097e2b', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjQ0LCJlbWFpbCI6ImxpZW5taW5oZGFkaXRmaWZhQGdtYWlsLmNvbSIsInN1YiI6ImxpZW5taW5oZGFkaXRmaWZhQGdtYWlsLmNvbSIsImV4cCI6MTczNDIzOTM2OH0.sxDmCn1uQPCzs1wEjf8pCYt-_HD-3dQhObY7qHfVTHU'),
(b'0', 1, b'1', '2024-12-15 16:13:32.155554', 366, '2025-01-14 16:13:32.155606', 18, 'Bearer', 'f473fbd4-9e48-4b92-a249-2979fe8a97fc', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjE4LCJlbWFpbCI6Imx1dWthb2hvYW5nMTYwNEBnbWFpbC5jb20iLCJzdWIiOiJsdXVrYW9ob2FuZzE2MDRAZ21haWwuY29tIiwiZXhwIjoxNzM0MjU0MDEyfQ.wpvJtdzoiAshigIoquJKP5pEiTdwUoSq27Sb5mCijQ8'),
(b'0', 1, b'1', '2024-12-15 16:37:31.037424', 370, '2025-01-14 16:37:31.037479', 23, 'Bearer', '9dd63ff7-6bac-47a7-bd58-c84b0efa8ec5', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjIzLCJlbWFpbCI6Im1hbmh0cmFuQGdtYWlsLmNvbSIsInN1YiI6Im1hbmh0cmFuQGdtYWlsLmNvbSIsImV4cCI6MTczNDI1NTQ1MH0.nVPlcMFPcQrX1QmPvvFJyHGYlw-VW2j-GJ6wtVrybVQ'),
(b'0', 1, b'0', '2024-12-15 16:39:40.030035', 371, '2025-01-14 16:39:40.030085', 23, 'Bearer', '74b61cfe-436b-447b-9b61-590cf4aa367a', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjIzLCJlbWFpbCI6Im1hbmh0cmFuQGdtYWlsLmNvbSIsInN1YiI6Im1hbmh0cmFuQGdtYWlsLmNvbSIsImV4cCI6MTczNDI1NTU3OX0.afzZm_CgBtV4mhtDmvRdy11CZi5bGMXZquwHP318_FE'),
(b'0', 0, b'1', '2024-12-15 09:46:04.265421', 372, '2025-01-14 09:46:04.267201', 45, 'Bearer', '321b20c9-4020-4881-b807-80977f9a42c5', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjQ1LCJlbWFpbCI6ImhvYW5nQGdtYWlsLmNvbSIsInN1YiI6ImhvYW5nQGdtYWlsLmNvbSIsImV4cCI6MTczNDI1NTk2M30.9zJZ1LkS1isaCg-iBaHA3d8IYfIwXw0WIqzFNVkAkq8'),
(b'0', 0, b'1', '2024-12-15 17:33:52.255511', 377, '2025-01-14 17:33:52.255511', 22, 'Bearer', '1464e035-629d-4ddf-9b49-ff0e9d921e2c', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjIyLCJlbWFpbCI6ImJhb3Z1QGdtYWlsLmNvbSIsInN1YiI6ImJhb3Z1QGdtYWlsLmNvbSIsImV4cCI6MTczNDI1ODgzMn0.7eif8o2rWvZv2kkI0u02vB0Hc-m-5QO475M4EN_ZJM0'),
(b'0', 0, b'0', '2024-12-15 17:52:20.739851', 388, '2025-01-14 17:52:20.739851', 32, 'Bearer', 'a892e600-cf54-4329-9e92-776b0fb7351b', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjMyLCJlbWFpbCI6ImRhaW5pY2hpQGdtYWlsLmNvbSIsInN1YiI6ImRhaW5pY2hpQGdtYWlsLmNvbSIsImV4cCI6MTczNDI1OTk0MH0.BUywwL48aLl1jNhUZXv6AW517j0FvLxa2DCXpV4t7vw'),
(b'0', 0, b'1', '2024-12-16 15:45:12.026175', 418, '2025-01-15 15:45:12.026175', 25, 'Bearer', '9119d8a3-90f4-4a94-809e-5b8d5692cdd6', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjI1LCJlbWFpbCI6Im1hcnVzaGluQGdtYWlsLmNvbSIsInN1YiI6Im1hcnVzaGluQGdtYWlsLmNvbSIsImV4cCI6MTczNDMzODcxMX0.-uFJWEYuHOQ4Znqz6O3rG4PKrn0twN56z5pvwJdBLPU'),
(b'0', 0, b'1', '2024-12-16 15:45:54.732569', 419, '2025-01-15 15:45:54.732569', 25, 'Bearer', 'e64bd579-d4d9-4c4d-a0a3-a05530c43866', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjI1LCJlbWFpbCI6Im1hcnVzaGluQGdtYWlsLmNvbSIsInN1YiI6Im1hcnVzaGluQGdtYWlsLmNvbSIsImV4cCI6MTczNDMzODc1NH0.y49I4l_rxkcYw9d6O03VmSx1_sYqz20q-OM04Yr9zic'),
(b'0', 0, b'1', '2024-12-16 15:46:40.379707', 421, '2025-01-15 15:46:40.379707', 22, 'Bearer', 'a828c70b-2f90-483a-97d4-47fb22e8144f', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjIyLCJlbWFpbCI6ImJhb3Z1QGdtYWlsLmNvbSIsInN1YiI6ImJhb3Z1QGdtYWlsLmNvbSIsImV4cCI6MTczNDMzODgwMH0.NvxhTU77CEm63F620NCjCjPHvX7SSTUy2msLARkr3iU'),
(b'0', 0, b'1', '2024-12-16 16:30:33.703799', 424, '2025-01-15 16:30:33.703799', 40, 'Bearer', 'c783d305-6a79-4774-b400-a93feb309a5b', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjQwLCJlbWFpbCI6InNvbmR1b25nY29uZzhAZ21haWwuY29tIiwic3ViIjoic29uZHVvbmdjb25nOEBnbWFpbC5jb20iLCJleHAiOjE3MzQzNDE0MzN9.8IjpRJLcnQSdOiadnGmAPguJGs_BcH8tOr5s-TGj-uM'),
(b'0', 0, b'0', '2024-12-16 16:44:55.595907', 425, '2025-01-15 16:44:55.595907', 40, 'Bearer', '19e1bdf7-822b-4d0d-be7d-04ccc3327097', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjQwLCJlbWFpbCI6InNvbmR1b25nY29uZzhAZ21haWwuY29tIiwic3ViIjoic29uZHVvbmdjb25nOEBnbWFpbC5jb20iLCJleHAiOjE3MzQzNDIyOTV9.xmq_WPf1eD91kv5KvjsO8Rua6MT0ImUGJy9EPjxVEWs'),
(b'0', 1, b'0', '2024-12-18 13:15:56.488604', 461, '2025-01-17 13:15:56.490057', 19, 'Bearer', '98b52b8a-e3a8-439e-9c1b-a65ca2be12e1', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjE5LCJlbWFpbCI6ImR1b25nbm1zZTE4MTUxNUBmcHQuZWR1LnZuIiwic3ViIjoiZHVvbmdubXNlMTgxNTE1QGZwdC5lZHUudm4iLCJleHAiOjE3MzQ1MDI1NTZ9.sTeVD96fv_eQbjIGZmsP6r6x-NxQzidsJ8Ka9CDJr6E'),
(b'0', 0, b'1', '2024-12-18 14:26:21.841015', 462, '2025-01-17 14:26:21.841015', 57, 'Bearer', 'f8375ca0-0f08-4884-b737-f638979d78a4', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjU3LCJlbWFpbCI6InNvbmR1b25nY29uZzlAZ21haWwuY29tIiwic3ViIjoic29uZHVvbmdjb25nOUBnbWFpbC5jb20iLCJleHAiOjE3MzQ1MDY3ODF9.QbOUABfglnyeh1aDyyiopIhuA_z49AZrfnOrkO__12Q'),
(b'0', 0, b'1', '2024-12-18 15:50:15.574049', 463, '2025-01-17 15:50:15.574049', 57, 'Bearer', '9be5c1b8-4f8d-4522-8516-030c2565e019', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjU3LCJlbWFpbCI6InNvbmR1b25nY29uZzlAZ21haWwuY29tIiwic3ViIjoic29uZHVvbmdjb25nOUBnbWFpbC5jb20iLCJleHAiOjE3MzQ1MTE4MTV9.SCNB33ucYoTTMDAjTDMT-rOTeHyVg0CXGcZ9b1aJehE'),
(b'0', 0, b'1', '2024-12-18 16:10:17.961407', 465, '2025-01-17 16:10:17.961407', 60, 'Bearer', '3c2c6fec-f7a7-4a01-9811-8eff6fb6ce6c', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjYwLCJlbWFpbCI6InBlcm5leWlzbGFtQGdtYWlsLmNvbSIsInN1YiI6InBlcm5leWlzbGFtQGdtYWlsLmNvbSIsImV4cCI6MTczNDUxMzAxN30.hYt5ZuT33eW8sPPNC7kqI3WGTMULj12vmXSSd3d0ghU'),
(b'0', 0, b'0', '2024-12-18 16:10:40.403187', 466, '2025-01-17 16:10:40.403187', 25, 'Bearer', 'f74b316a-510f-4e7f-9a72-ac29236e0221', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjI1LCJlbWFpbCI6Im1hcnVzaGluQGdtYWlsLmNvbSIsInN1YiI6Im1hcnVzaGluQGdtYWlsLmNvbSIsImV4cCI6MTczNDUxMzA0MH0.qIY42K4bQRfOYPUhul8YKQEapqFczQqnGNQ3jyU_rbw'),
(b'0', 0, b'1', '2024-12-19 00:28:13.978007', 473, '2025-01-18 00:28:13.978007', 24, 'Bearer', '163ee7df-9c27-4dc1-a30b-0bde5f168373', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjI0LCJlbWFpbCI6Im5uZEBnbWFpbC5jb20iLCJzdWIiOiJubmRAZ21haWwuY29tIiwiZXhwIjoxNzM0NTQyODkzfQ.ryx7bROQ7nTiKHUBTgImkZpennyWkYQhC0YeW5qpV_Q'),
(b'0', 0, b'1', '2024-12-19 01:12:19.868483', 479, '2025-01-18 01:12:19.868483', 23, 'Bearer', '18b27dfb-a121-414a-b1a5-51da0f433c91', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjIzLCJlbWFpbCI6Im1hbmh0cmFuQGdtYWlsLmNvbSIsInN1YiI6Im1hbmh0cmFuQGdtYWlsLmNvbSIsImV4cCI6MTczNDU0NTUzOX0.LXyn37CpigFty-saacixEpT30ufUfj3jDQhWZ05wiJ8'),
(b'0', 1, b'0', '2024-12-19 08:30:12.947358', 481, '2025-01-18 08:30:12.948608', 38, 'Bearer', '7453091b-899c-4cd6-8520-efb38ee26811', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjM4LCJlbWFpbCI6ImhvYW5nY2x3QGdtYWlsLmNvbSIsInN1YiI6ImhvYW5nY2x3QGdtYWlsLmNvbSIsImV4cCI6MTczNDU3MTgxMn0.e4lHercQfjBUkO7HFPcV2FbjTy7kNbwsYnA4kbOq7kc'),
(b'0', 0, b'1', '2024-12-19 10:21:29.164183', 488, '2025-01-18 10:21:29.164352', 14, 'Bearer', '9503c9c9-6bb4-4970-b8ab-e76157ef69e1', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjE0LCJlbWFpbCI6ImNhb2hvYW5nZ3QwQGdtYWlsLmNvbSIsInN1YiI6ImNhb2hvYW5nZ3QwQGdtYWlsLmNvbSIsImV4cCI6MTczNDU3ODQ4OH0.jwYM4RACeLaGOdpsVIICZL0CwfWPc1s9JAtjeY8jNOs'),
(b'0', 0, b'1', '2024-12-19 11:26:02.800943', 493, '2025-01-18 11:26:02.800983', 14, 'Bearer', '6dcc3141-04e9-4024-bdf7-05a600c30e70', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjE0LCJlbWFpbCI6ImNhb2hvYW5nZ3QwQGdtYWlsLmNvbSIsInN1YiI6ImNhb2hvYW5nZ3QwQGdtYWlsLmNvbSIsImV4cCI6MTczNDU4MjM2Mn0.VEkh1N_uMtWA71urrYHJUuAuFAJm1jj6-fvcC3n2jqo'),
(b'0', 0, b'1', '2024-12-19 11:26:16.875440', 494, '2025-01-18 11:26:16.875487', 18, 'Bearer', '5528d5f8-a27f-4de9-b3b9-207bc07dccd7', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjE4LCJlbWFpbCI6Imx1dWthb2hvYW5nMTYwNEBnbWFpbC5jb20iLCJzdWIiOiJsdXVrYW9ob2FuZzE2MDRAZ21haWwuY29tIiwiZXhwIjoxNzM0NTgyMzc2fQ.GrgmEC9UbiayuKry4duzS8h4eqb-LXM34KRYgn4U0og'),
(b'0', 0, b'1', '2024-12-19 13:13:09.977772', 503, '2025-01-18 13:13:09.977851', 14, 'Bearer', '913d420e-c3d1-42e0-a04f-5fee1932a207', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjE0LCJlbWFpbCI6ImNhb2hvYW5nZ3QwQGdtYWlsLmNvbSIsInN1YiI6ImNhb2hvYW5nZ3QwQGdtYWlsLmNvbSIsImV4cCI6MTczNDU4ODc4OX0.a0ZLJDgFkNzTJoG5annjB0p5t5KLI99thWJpXFjiV4Y'),
(b'0', 1, b'1', '2024-12-19 13:40:33.751473', 505, '2025-01-18 13:40:33.752401', 20, 'Bearer', 'dc427936-5ecc-4caf-82bd-af283f137d0b', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjIwLCJlbWFpbCI6Im1hbmhkdW9uZ2xocDRAZ21haWwuY29tIiwic3ViIjoibWFuaGR1b25nbGhwNEBnbWFpbC5jb20iLCJleHAiOjE3MzQ1OTA0MzN9.OdNNytzcQv20fgvopJBADqGUX9wC3xJVxB6vZkarEIQ'),
(b'0', 1, b'0', '2024-12-19 13:44:44.554193', 506, '2025-01-18 13:44:44.554241', 20, 'Bearer', '87023fee-da81-4480-a4f8-dfd911919cc2', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjIwLCJlbWFpbCI6Im1hbmhkdW9uZ2xocDRAZ21haWwuY29tIiwic3ViIjoibWFuaGR1b25nbGhwNEBnbWFpbC5jb20iLCJleHAiOjE3MzQ1OTA2ODR9.QNM1BErZu4UXAueAc9Mqt7gkUIMZxYmf5j8Q1reilm4'),
(b'0', 0, b'1', '2024-12-19 17:22:24.489625', 507, '2025-01-18 17:22:24.489756', 62, 'Bearer', 'a67354f4-17cf-4400-a71c-c556f97bca03', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjYyLCJlbWFpbCI6ImhvYW5nbGNzZTE4MTUxM0BmcHQuZWR1LnZuIiwic3ViIjoiaG9hbmdsY3NlMTgxNTEzQGZwdC5lZHUudm4iLCJleHAiOjE3MzQ2MDM3NDR9.irhwS4swj_alCe9gTd_reItcYNFBKhRDHIzyFPtbiN0'),
(b'0', 0, b'1', '2024-12-19 17:35:38.514281', 508, '2025-01-18 17:35:38.514615', 4, 'Bearer', '3e36f31b-5d8e-4b9c-a606-2a32e0a41a83', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjQsImVtYWlsIjoiaG9hbmdkejE2MDRAZ21haWwuY29tIiwic3ViIjoiaG9hbmdkejE2MDRAZ21haWwuY29tIiwiZXhwIjoxNzM0NjA0NTM4fQ.F7G5nxQOD4LFg-rE9y_Hg7BKPwuRZCcA_nJ_ZKZLD7Q'),
(b'0', 0, b'1', '2024-12-19 17:35:54.829750', 509, '2025-01-18 17:35:54.829807', 18, 'Bearer', 'fdee32ed-5fc1-4bce-adaa-d55ebbf1e32a', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjE4LCJlbWFpbCI6Imx1dWthb2hvYW5nMTYwNEBnbWFpbC5jb20iLCJzdWIiOiJsdXVrYW9ob2FuZzE2MDRAZ21haWwuY29tIiwiZXhwIjoxNzM0NjA0NTU0fQ.hseycWJmowq9YcIzaWzFT3thY6-uXQP4pNcXYi6ODLQ'),
(b'0', 1, b'0', '2024-12-19 18:03:21.584770', 510, '2025-01-18 18:03:21.584770', 19, 'Bearer', '6980e610-5e72-425b-906a-79f37e748e97', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjE5LCJlbWFpbCI6ImR1b25nbm1zZTE4MTUxNUBmcHQuZWR1LnZuIiwic3ViIjoiZHVvbmdubXNlMTgxNTE1QGZwdC5lZHUudm4iLCJleHAiOjE3MzQ2MDYyMDF9.Wtoph87oyJJtQZME3S0p-pZbkktX98osq4oW4TBI8Cg'),
(b'0', 1, b'1', '2024-12-19 15:20:10.000000', 512, '2025-01-18 15:20:10.000000', 4, 'Bearer', 'b1590a4f-384b-43f8-a0c3-b0de5ab9d8a8', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjQsImVtYWlsIjoiaG9hbmdkejE2MDRAZ21haWwuY29tIiwic3ViIjoiaG9hbmdkejE2MDRAZ21haWwuY29tIiwiZXhwIjoxNzM0NjIxNjEwfQ.2f3tA7ErNYHKcxecXV_XLMTDYmWHBx-0yNqtzIITGU4'),
(b'0', 1, b'1', '2024-12-19 15:22:27.000000', 513, '2025-01-18 15:22:27.000000', 2, 'Bearer', '204c8534-6b4a-4e30-8792-8556389ea97a', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjIsImVtYWlsIjoic29uQGdtYWlsLmNvbSIsInN1YiI6InNvbkBnbWFpbC5jb20iLCJleHAiOjE3MzQ2MjE3NDd9.0m3y_d7_D_18f5ELsegZghD_De2mgq84M1VygZtYWkI'),
(b'0', 0, b'1', '2024-12-21 09:14:22.000000', 519, '2025-01-20 09:14:22.000000', 20, 'Bearer', '97294bb6-c029-4218-9c46-4d51a19b47df', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjIwLCJlbWFpbCI6Im1hbmhkdW9uZ2xocDRAZ21haWwuY29tIiwic3ViIjoibWFuaGR1b25nbGhwNEBnbWFpbC5jb20iLCJleHAiOjE3MzQ3NzI0NjJ9.g_uJlqs1dAtyuPnIOHdL501D6AGSSq8kOz30E8xW2N8'),
(b'0', 0, b'1', '2024-12-21 10:25:58.000000', 521, '2025-01-20 10:25:58.000000', 24, 'Bearer', '7e7b2fb9-2fe5-432a-a80c-e174eb9dc447', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjI0LCJlbWFpbCI6Im5uZEBnbWFpbC5jb20iLCJzdWIiOiJubmRAZ21haWwuY29tIiwiZXhwIjoxNzM0Nzc2NzU4fQ.rcek0TIAyh4BO3tvk8cmAZf97LI72z7sgWOMTIwXLNg'),
(b'0', 0, b'1', '2024-12-21 10:28:30.000000', 522, '2025-01-20 10:28:30.000000', 32, 'Bearer', '06da887c-dd01-4bce-8085-d3551ed2950d', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjMyLCJlbWFpbCI6ImRhaW5pY2hpQGdtYWlsLmNvbSIsInN1YiI6ImRhaW5pY2hpQGdtYWlsLmNvbSIsImV4cCI6MTczNDc3NjkxMH0.ojUra6GCkeA1KdqzJJK2wFxwZtNIQs9iWf374MkMif8'),
(b'0', 0, b'1', '2024-12-21 10:37:24.000000', 523, '2025-01-20 10:37:24.000000', 35, 'Bearer', '00542bde-0884-40b2-a27c-ffa11d2252ed', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjM1LCJlbWFpbCI6Im1hcnVkb0BnbWFpbC5jb20iLCJzdWIiOiJtYXJ1ZG9AZ21haWwuY29tIiwiZXhwIjoxNzM0Nzc3NDQ0fQ.yCpMq9IwX1lMYPZJOAXdJvs0cZwZa1U_-ab4a6qHlsY'),
(b'0', 0, b'1', '2024-12-21 10:47:56.000000', 524, '2025-01-20 10:47:56.000000', 33, 'Bearer', 'a1d20fb2-445d-4172-a16e-41a3facd961b', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjMzLCJlbWFpbCI6Im9tb3Nha29AZ21haWwuY29tIiwic3ViIjoib21vc2Frb0BnbWFpbC5jb20iLCJleHAiOjE3MzQ3NzgwNzZ9.GQCcINMYvFj2J0wgp-7iQ2Q3I5l4UcSXQ8CTM9o5IDI'),
(b'0', 0, b'1', '2024-12-21 10:55:02.000000', 525, '2025-01-20 10:55:02.000000', 19, 'Bearer', 'aa945d74-77ac-4dd7-88d6-44af5903e074', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjE5LCJlbWFpbCI6ImR1b25nbm1zZTE4MTUxNUBmcHQuZWR1LnZuIiwic3ViIjoiZHVvbmdubXNlMTgxNTE1QGZwdC5lZHUudm4iLCJleHAiOjE3MzQ3Nzg1MDJ9.9hglkIHkaZn21k4aTn9bD2kFWG_1vSPzmGlUVZr22dA'),
(b'0', 0, b'1', '2024-12-21 13:52:27.000000', 528, '2025-01-20 13:52:27.000000', 33, 'Bearer', '7aca3e90-1d94-4d79-9420-4f9e13bbe5f9', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjMzLCJlbWFpbCI6Im9tb3Nha29AZ21haWwuY29tIiwic3ViIjoib21vc2Frb0BnbWFpbC5jb20iLCJleHAiOjE3MzQ3ODkxNDd9.faYFsSan2OaVYEF0Mq4uK9tVNx5JsuodZEcqi_4FJHw'),
(b'0', 0, b'0', '2024-12-21 13:54:40.000000', 529, '2025-01-20 13:54:40.000000', 30, 'Bearer', '4e7a18df-0b58-4a26-afcd-c97aaef221a6', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjMwLCJlbWFpbCI6InNoaW5vZGFAZ21haWwuY29tIiwic3ViIjoic2hpbm9kYUBnbWFpbC5jb20iLCJleHAiOjE3MzQ3ODkyODB9.JvWJkQKNluYJn8QLxr8S2vxCoYyAXSq7S9C8aYFoWLs'),
(b'0', 1, b'1', '2024-12-24 15:50:04.181654', 531, '2025-01-23 15:50:04.181771', 38, 'Bearer', '4b281847-71ca-477f-89dd-4f87ffec519d', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjM4LCJlbWFpbCI6ImhvYW5nY2x3QGdtYWlsLmNvbSIsInN1YiI6ImhvYW5nY2x3QGdtYWlsLmNvbSIsImV4cCI6MTczNTA1NTQwNH0.wYMXM23EnliWk6ZDPa3Sb8ETyQlGrU5dpW4OR778_xk'),
(b'0', 0, b'0', '2024-12-25 00:29:16.096970', 532, '2025-01-24 00:29:16.097096', 27, 'Bearer', '227a6012-3eed-45a5-b9f0-84264885eba7', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjI3LCJlbWFpbCI6ImlzYUBnbWFpbC5jb20iLCJzdWIiOiJpc2FAZ21haWwuY29tIiwiZXhwIjoxNzM1MDg2NTU2fQ.jtn6Gjv6rWg_KhfEJYez8TfWBSEArFN5X-WBc6aNFhc'),
(b'0', 0, b'1', '2024-12-25 00:39:14.413437', 533, '2025-01-24 00:39:14.413502', 4, 'Bearer', 'ee5d50f5-9095-4519-a378-e8f3166d97f9', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjQsImVtYWlsIjoiaG9hbmdkejE2MDRAZ21haWwuY29tIiwic3ViIjoiaG9hbmdkejE2MDRAZ21haWwuY29tIiwiZXhwIjoxNzM1MDg3MTU0fQ.HqVailBkQYr22vkDvX1AzHEdkIkseUTgFoIhWWIaS0Q'),
(b'0', 1, b'0', '2024-12-25 00:49:56.263721', 534, '2025-01-24 00:49:56.263775', 38, 'Bearer', '32b97798-7583-44b0-bf4d-d2aa54af384b', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjM4LCJlbWFpbCI6ImhvYW5nY2x3QGdtYWlsLmNvbSIsInN1YiI6ImhvYW5nY2x3QGdtYWlsLmNvbSIsImV4cCI6MTczNTA4Nzc5Nn0.IS6vkO30yclH00_XSVDPqmnjEpMkgzCcj0lcgJ1uk9E');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `google_account_id` int DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `is_subscription` tinyint(1) DEFAULT '0',
  `account_balance` bigint DEFAULT '0',
  `created_at` datetime(6) DEFAULT NULL,
  `date_of_birth` datetime(6) DEFAULT NULL,
  `id` bigint NOT NULL,
  `role_id` bigint DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `phone_number` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `first_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `avatar_url` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` enum('BANNED','UNVERIFIED','VERIFIED') COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO users (google_account_id, is_active, is_subscription, account_balance, created_at, date_of_birth, id, role_id, updated_at, phone_number, email, first_name, last_name, address, password, avatar_url, status) VALUES
(0, 1, 0, 781568604, '2024-09-22 06:58:19.000000', '1979-10-13 00:00:00.000000', 2, 1, '2024-11-11 22:45:35.702667', NULL, 'son@gmail.com', 'Son', 'Cong Duong', 'Quang Binh, Viet Nam', '$2a$10$Orep8r6WJo5EjwNq7HyTL.kD8xDlwD5QA6Qk2HVQzkVjUXG1ccGPm', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', 'UNVERIFIED'),
(0, 1, 0, 0, '2024-09-22 06:58:39.749509', '1979-10-13 00:00:00.000000', 3, 1, '2024-09-22 06:58:39.749513', NULL, 'manhduonglhp1@gmail.com', 'Manh Duong LHP1', 'Manh Nguyen', 'Tam Ki, Viet Nam', '$2a$10$Rg7wfZ2yabht3eBqhoJQxedR.r4ojQUGm9g9Jz5WtDJw3pWqpoiTu', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', 'UNVERIFIED'),
(0, 1, 0, 59900000, '2024-09-27 15:21:18.000000', '2004-10-14 00:00:00.000000', 4, 1, '2024-11-19 15:21:42.000000', '0934162561', 'hoangdz1604@gmail.com', 'HoangCaodz', 'Luucao', '250C Vo Van Hat St, Long Truong Province, 9th District, Ho Chi Minh City, Viet Nam', '$2a$10$W3zl5tbhHy0GnaaVtuIwc.Zlv99AcnHLnpDwJekK0Ux3u98tjewly', 'https://images.unsplash.com/photo-1682956875922-7399de4167e4?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'VERIFIED'),
(0, 0, 0, 0, '2024-09-27 15:25:59.286318', '2004-10-14 00:00:00.000000', 5, 1, '2024-09-27 15:25:59.286337', NULL, 'luuhai@gmail.com', 'Hai', 'Luu', 'Hoa Vang, Da Nang', '$2a$10$SwG2quSV3SQNdAfKWpZd0uzaB9XwoaBfR8n27D9QptspytMyNkj3u', NULL, NULL),
(0, 0, 0, 0, '2024-09-27 15:28:51.559247', '2004-10-14 00:00:00.000000', 6, 1, '2024-09-27 15:28:51.559286', NULL, 'luuhaivn@gmail.com', 'Hai', 'Luu', 'Hoa Vang, Da Nang', '$2a$10$MmAaEStq3KT7fRhKWlD8FOXL6GdTk1e.5BjPISpZunxAxCq5pGbwq', NULL, 'UNVERIFIED'),
(0, 1, 0, 50000000, '2024-09-28 02:04:20.784604', '2004-10-14 00:00:00.000000', 9, 1, '2024-11-10 21:41:00.816611', NULL, 'manhduonglhp2@gmail.com', 'Manh Duong LHP2', 'Hao Anh', 'Vinh Long', '$2a$10$M3WCdcgsRAW.zfCyf2kQwODnDFHm0fCExajXE74gR8Dq4WJZvGN2O', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', 'UNVERIFIED'),
(0, 1, 0, 0, '2024-09-28 02:09:21.078020', '2004-10-14 00:00:00.000000', 10, 1, '2024-09-28 02:09:21.078121', NULL, 'manhduonglhp3@gmail.com', 'Manh Duong LHP3', 'Hao Anh', 'Vinh Long', '$2a$10$pDVmvBj9Bs7/A8OVQ5nUzeQoCE4F95CU3ggA88cxHTveueEtpjvTe', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', 'UNVERIFIED'),
(0, 1, 0, 0, '2024-09-28 02:15:37.103176', '2004-10-14 00:00:00.000000', 11, 1, '2024-09-28 02:15:37.103200', NULL, 'manhduonglhp5@gmail.com', 'Manh Duong LHP5', 'Hao Anh', 'Vinh Long', '$2a$10$4evUxJ397YXsiexQ7yTMC.67GpQ9lSBCda4DvxA2aYQ833XCB89fW', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', 'UNVERIFIED'),
(0, 1, 0, 0, '2024-09-30 08:26:46.220241', '2005-04-16 07:00:00.000000', 14, 2, '2024-11-19 01:01:03.291503', NULL, 'caohoanggt0@gmail.com', 'HoangSta', 'Cao Luu', 'TPHCM', '$2a$10$BGSucPFP/s1A1NCAG5MRDe/36W04uVJzp0Ala7YKtOzUS8anAC1W.', 'https://images.javatpoint.com/core/images/java-logo1.png', 'VERIFIED'),
(0, 1, 0, 199850000, '2024-10-01 02:46:13.663828', '2022-02-18 07:00:00.000000', 18, 3, '2024-11-19 17:50:19.139156', NULL, 'luukaohoang1604@gmail.com', 'HoangBre', 'Luu', 'Can Gio', '$2a$10$t5Gsz29f8N9.zV21DRGM0OMyDqaxRjClIJSiv9liA36Ff8atzdrAC', 'https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:quality(100)/2024_1_29_638421681698161851_750.jpg', 'VERIFIED'),
(0, 1, 0, 283853301, '2024-10-05 16:11:14.000000', '1979-10-13 00:00:00.000000', 19, 1, '2024-11-21 03:35:23.000000', NULL, 'duongnmse181515@fpt.edu.vn', 'Duong FPT', 'Duong', 'Da Nang, Viet Nam', '$2a$10$rX0NEePVCsC.xIz6eT1sie4aWaKAuARicOb/1Pzi1ftzDfqKAV.je', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', 'VERIFIED'),
(0, 1, 0, 11580000, '2024-10-05 16:11:30.000000', '1979-10-13 00:00:00.000000', 20, 3, '2024-11-21 09:54:28.000000', NULL, 'manhduonglhp4@gmail.com', 'Manh Duong LHP4', 'Duong', 'Da Nang, Viet Nam', '$2a$10$s/ICX1aEukr/V7Iz7G/TbOus5yAaayCqKc6DPS9AwrZLf5nbjqAOW', 'https://cdn0.gamesports.net/content_teasers/148000/148578.jpg?1687436699', 'VERIFIED'),
(0, 1, 0, 0, '2024-09-22 06:56:15.470639', '1979-10-13 00:00:00.000000', 21, 2, '2024-09-28 07:53:03.281172', NULL, 'vy@gmail.com', 'Vy', 'Ky Nguyen', 'Ha Tinh, Viet Nam', '$2a$10$FGoLrPd5YESJhA7iiE3Jf.vnZU1BcxR3N5xtMxOJMKUjknCQ.iK7O', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', 'UNVERIFIED'),
(0, 1, 0, 0, '2024-09-22 06:57:39.672269', '1979-10-13 00:00:00.000000', 22, 2, '2024-09-22 06:57:39.672273', NULL, 'baovu@gmail.com', 'Bao', 'Van Vu', 'Ha Nam, Viet Nam', '$2a$10$rP7CU.wmF3SaP4lzNHNA6uUQr27JBAJr2Uoot1toTKmRlmGWcg7su', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', 'UNVERIFIED'),
(0, 1, 0, 0, '2024-09-22 06:57:57.861037', '1979-10-13 07:00:00.000000', 23, 2, '2024-11-18 23:09:52.689408', NULL, 'manhtran@gmail.com', 'Tran', 'Duc Manh', 'Phu Tho, Viet Nam', '$2a$10$nGC/NyBlxwFZzA0Ecj7gP.tYPRIvvFb8DZNNlaM/nylbvU3IzBWGi', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', 'UNVERIFIED'),
(0, 1, 0, 27400000, '2024-09-22 06:59:36.000000', '1979-10-13 00:00:00.000000', 24, 3, '2024-11-21 10:27:34.000000', NULL, 'nnd@gmail.com', 'NND', 'Farm', 'Tokyo', '$2a$10$DkiD8VzBXW5pGgGH2cYvQOtT3DbtLsuKHJ9.KjoN.GsI6LSQZJmui', 'https://auctionkoi.com/wp-content/uploads/2024/11/nnd-logo-128x117.png', 'VERIFIED'),
(0, 1, 0, 8179998, '2024-09-22 06:59:53.747779', '1979-10-13 00:00:00.000000', 25, 3, '2024-11-15 17:51:56.083979', NULL, 'marushin@gmail.com', 'Marushin', 'Farm', 'Tokyo', '$2a$10$sornl4RV.DkqkAS68ryyw.azD20A/4KmeeOa2IiTRxuS89nUQXMK.', 'https://auctionkoi.com/wp-content/uploads/2024/11/marushin-logo-128x91.jpg', 'VERIFIED'),
(0, 1, 0, 200000, '2024-09-22 07:00:02.941910', '1979-10-13 00:00:00.000000', 26, 3, '2024-10-26 00:39:25.129626', NULL, 'sakai@gmail.com', 'Sakai', 'Farm', 'Tokyo', '$2a$10$SecO0EZQEWjBVyok7D7eTeBuVelmz7pjiCA8sddztylvVq801fiRu', 'https://auctionkoi.com/wp-content/uploads/2024/11/sakai-logo.png', 'VERIFIED'),
(0, 1, 0, 187076889, '2024-09-22 07:00:12.000000', '1979-11-13 07:00:00.000000', 27, 3, '2024-11-21 13:52:03.000000', NULL, 'isa@gmail.com', 'Isa', 'Farm', 'Tokyo', '$2a$10$.Wj6q5N.bCR.3dFi3fc2dugPIrA0X91FiibIW/8Kw5mVyYAYjpLei', 'https://auctionkoi.com/wp-content/uploads/2024/11/isa-logo-128x50.png', 'VERIFIED'),
(0, 1, 0, 0, '2024-09-22 07:00:24.623763', '1979-10-13 00:00:00.000000', 28, 3, '2024-09-27 01:24:49.064092', NULL, 'maruhiro@gmail.com', 'Maruhiro', 'Farm', 'Tokyo', '$2a$10$3TSjJG7bHVlNRdQAi5qBZeeXbLoNhMMXrsFp6FJcC9CFBmrjiV2Su', 'https://auctionkoi.com/wp-content/uploads/2024/11/maruhiro-logo-128x145.png', 'VERIFIED'),
(0, 1, 0, 0, '2024-09-22 07:00:39.043899', '1979-10-13 00:00:00.000000', 29, 3, '2024-09-27 01:25:04.915762', NULL, 'torazo@gmail.com', 'Torazo', 'Farm', 'Tokyo', '$2a$10$8sFYFH/3KtoCaV5wiLGhQecY7SwhM.gqFa9G2C1QrC0v2dQaNA0VK', 'https://auctionkoi.com/wp-content/uploads/2024/11/torazo-logo-128x48.jpg', 'VERIFIED'),
(0, 1, 0, 47760000, '2024-09-22 07:00:50.000000', '1979-10-13 00:00:00.000000', 30, 3, '2024-11-21 13:56:23.000000', NULL, 'shinoda@gmail.com', 'Shinoda', 'Farm', 'Tokyo', '$2a$10$xGxH5nAWUFgWdo0Twsuc8.6PFhf6ZdgqrvAweQA/kmCj6z9PQKpQi', 'https://auctionkoi.com/wp-content/uploads/2024/11/shinoda-logo-128x128.png', 'VERIFIED'),
(0, 1, 0, 0, '2024-09-22 12:50:53.030997', NULL, 31, 3, '2024-09-27 01:27:52.862485', NULL, 'kanno@gmail.com', 'Kanno', 'Farm', 'Tokyo', '$2a$10$.k6HZRqVtl7sxRtsgjiQ/eOjTpuy4pe7ZwpQKwgA9KwR70WFfeefq', 'https://auctionkoi.com/wp-content/uploads/2024/11/kanno-logo-128x130.png', 'VERIFIED'),
(0, 1, 0, 54025000, '2024-09-27 01:29:07.000000', NULL, 32, 3, '2024-11-21 10:36:07.000000', NULL, 'dainichi@gmail.com', 'Dainichi', 'Farm', 'Tokyo', '$2a$10$XckSkz8ZTZcOGOndc8YTduaPyPdHjj9hQ4PYezMAziSaUTsOgofQO', 'https://auctionkoi.com/wp-content/uploads/2024/11/dainichi-logo-128x128.png', 'VERIFIED'),
(0, 1, 0, 48000000, '2024-09-27 01:31:44.000000', NULL, 33, 3, '2024-11-21 13:54:10.000000', NULL, 'omosako@gmail.com', 'Omosako', 'Farm', 'Tokyo', '$2a$10$CHmNC2psYO9xeJjzmbSiSe5yAlZzgl5rAN0RYibVMRyARj4YU9ve6', 'https://auctionkoi.com/wp-content/uploads/2024/11/omosako-logo-128x128.png', 'VERIFIED'),
(0, 1, 0, 0, '2024-09-27 01:32:46.643498', NULL, 34, 3, '2024-09-27 01:33:56.144482', NULL, 'izumiya@gmail.com', 'Izumiya', 'Farm', 'Tokyo', '$2a$10$iWrH3sir7RQPmn0UHdV0fO5OiLzsVpNtS/u6drxxK1aEilMkycU9S', 'https://auctionkoi.com/wp-content/uploads/2024/11/izumiya-logo-128x128.png', 'VERIFIED'),
(0, 1, 0, 43625000, '2024-09-27 01:33:11.000000', NULL, 35, 3, '2024-11-21 10:47:19.000000', NULL, 'marudo@gmail.com', 'Marudo', 'Farm', 'Tokyo', '$2a$10$OJa7MR5d3mG6Ju7Bl4NYqO8EOGRDcVzv.GD6m9NtSRK.AsFhakqCO', 'https://auctionkoi.com/wp-content/uploads/2024/11/marudo-logo-128x129.png', 'VERIFIED'),
(0, 1, 0, 0, '2024-09-27 01:33:21.593383', NULL, 36, 3, '2024-09-27 01:33:59.833681', NULL, 'marujyu@gmail.com', 'Marujyu', 'Farm', 'Tokyo', '$2a$10$kxEegAgSjIy6yBPcU3Low.Xn9mamaOiU8mnzfehvZ7ltDy4R2ym1a', 'https://auctionkoi.com/wp-content/uploads/2024/11/marujyu-logo-128x63.png', 'VERIFIED'),
(0, 1, 0, 0, '2024-09-27 01:33:32.619792', NULL, 37, 3, '2024-09-27 01:34:01.592871', NULL, 'shintaro@gmail.com', 'Shintaro', 'Farm', 'Tokyo', '$2a$10$nbKQCdjMw1pEplr.o8ELdOudQWUDtImtQDAfwCQUzsMs8hF6scurW', 'https://auctionkoi.com/wp-content/uploads/2024/11/shintaro-logo-128x21.png', 'VERIFIED'),
(0, 1, 0, 0, '2024-09-22 06:59:14.042883', '1979-10-13 07:00:00.000000', 38, 4, '2024-11-19 01:03:45.001981', '0945162571', 'hoangclw@gmail.com', 'Hoang Admin', 'Luu Cao', 'Arab Saudi', '$2a$10$W22x0wOuJ5aFtLI1NvN1tO2ZgZhNAq0pEKdLGjsSgSKqJ462qitsO', 'https://mochidemy.com/blog/wp-content/uploads/2024/09/khong-co-gi-tieng-anh-feature.jpg', 'VERIFIED'),
(0, 1, 0, 598354985, '2024-11-06 22:02:17.999728', NULL, 40, 1, '2024-11-11 22:52:19.533142', NULL, 'sonduongcong8@gmail.com', 'Son', 'Duong Cong', '', '$2a$10$e9fR6q4kME3IK0TKobrvP.JIpT2/ovvrp8gg1VSz4rxYGHayydjtW', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', 'VERIFIED'),
(0, 1, 0, 0, '2024-11-15 05:00:17.696051', NULL, 42, 1, '2024-11-15 05:00:17.696053', NULL, 'anhoang800140@gmail.com', 'Hoàng', 'An', '', '$2a$10$GcZ/AoGPWLndvhw64WPe2OeL7nHb4LuS6UoZksXt4nihOP4jHnhoW', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', 'UNVERIFIED'),
(0, 1, 0, 0, '2024-11-15 05:08:45.388890', NULL, 44, 1, '2024-11-15 05:08:45.388892', NULL, 'lienminhdaditfifa@gmail.com', 'Hoàng', 'An', '', '$2a$10$f99GkcNVe8RKi63kyMWJ..Hp0rmd/IWtWwfpBqsoO0IAiUve1GfWO', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', 'UNVERIFIED'),
(0, 1, 0, 0, '2024-11-15 09:45:42.368243', NULL, 45, 1, '2024-11-15 09:45:42.368245', NULL, 'hoang@gmail.com', 'Hoang Test', 'Luu', '', '$2a$10$8QfT0vXM6JieY1cPx2qwge/R28DiyZkS5zfcXNPhvKPIoe/AUzKF6', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', 'UNVERIFIED'),
(0, 1, 0, 0, '2024-11-15 17:16:22.991879', NULL, 46, 1, '2024-11-15 17:16:22.991882', NULL, 'taquoc196@gmail.com', 'TRAN ANH', 'QUOC', '', '$2a$10$IrJe8AGdFLE.xUP9Ley51.5rKXb4tilMB1hU6CvAeZJ5.HmZPf47K', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', 'UNVERIFIED'),
(0, 1, 0, 0, '2024-11-15 17:18:17.276609', NULL, 47, 1, '2024-11-15 17:18:17.276612', NULL, 'hoanduyphoto@gmail.com', 'TRAN ANH', 'QUOC', '', '$2a$10$aOtYBMmJYKM6cY1j6SLPUuheA9dMnN9K9j8rpf35iOzp5EERPPYvq', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', 'UNVERIFIED'),
(0, 1, 0, 0, '2024-11-16 19:01:14.271546', NULL, 48, 1, '2024-11-16 19:01:14.271548', NULL, 'nhducminhqt@gmail.com', 'Nguyễn Hoàng Đức', 'Minh', '', '$2a$10$0SE4GRiqeXHbswsTxKAQ..WwhS8y86b5QwDhnNLFhF2tjYFOPv9h2', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', 'UNVERIFIED'),
(0, 1, 0, 0, '2024-11-18 08:54:27.753941', NULL, 56, 1, '2024-11-18 08:54:27.753943', NULL, 'admin@gmail.com', 'Hoang', 'Luu', '', '$2a$10$4.d7IIURfYpawQcRVOlLO.bBs99zN.FOsq52ybbJG17K30Rp3ecQe', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', 'UNVERIFIED'),
(0, 1, 0, 0, '2024-11-18 14:26:00.510187', NULL, 57, 1, '2024-11-18 14:26:00.510187', NULL, 'sonduongcong9@gmail.com', 'Hang ', 'Le Minh', '', '$2a$10$3IiF8ZfGBvtqBAWmO25SM.Eev7RdAUF7MF3CAIRLDE9jbDecv/JH2', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', 'UNVERIFIED'),
(0, 1, 0, 0, '2024-11-18 15:52:17.223694', NULL, 58, 1, '2024-11-18 15:53:28.118184', NULL, 'toriansplett8397@gmail.com', 'Mai', 'Hoang Ha Phuong', '', '$2a$10$fQpOrXKTopgA7CktAz6I9..5i5nVwBRy0ff2XMBFjL0tauC8d4qt2', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', 'VERIFIED'),
(0, 1, 0, 0, '2024-11-18 15:54:45.440544', '1979-10-13 07:00:00.000000', 59, 1, '2024-11-18 15:54:45.440549', NULL, 'hoanglc@gmail.com', 'Hoang', 'Luu', 'Da Nang, Viet Nam', '$2a$10$tH5.zH05xAeoR/Bca15P5OgIne6dPSn./WxSImBv5g9.TgOcl2PLe', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', 'UNVERIFIED'),
(0, 1, 0, 0, '2024-11-18 16:09:23.304684', NULL, 60, 1, '2024-11-18 16:10:03.568303', NULL, 'perneyislam@gmail.com', 'My Hanh', 'Le Thi', '', '$2a$10$ftigO7VSl6Y9Tm9Ehi5Pl.C1iTiSdM1uGONBl76cMH2uuiutlRZOO', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', 'VERIFIED'),
(0, 1, 0, 0, '2024-11-19 17:10:42.909687', '1979-10-13 07:00:00.000000', 61, 1, '2024-11-19 17:10:42.909693', NULL, 'hoang123123@gmail.com', 'Hoang', 'Luu', 'Da Nang, Viet Nam', '$2a$10$vSDIXIONPR9Rr4pgMyrovuzjJO8VPdGb4FgUBix08./c4fGDcAS8m', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', 'UNVERIFIED'),
(0, 1, 0, 0, '2024-11-19 17:20:28.358680', NULL, 62, 3, '2024-11-19 17:21:12.289885', NULL, 'hoanglcse181513@fpt.edu.vn', 'luu', 'hoangtets', '', '$2a$10$PiaRD8OdsYe5sDoeYd2EHebymC/Tf1YDj0.dHIsUdaZfe3EwwOzSS', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', 'UNVERIFIED'),
(0, 1, 0, 0, '2024-11-24 14:50:37.934087', '1979-10-13 00:00:00.000000', 63, 1, '2024-11-24 14:50:37.934101', NULL, 'hoang5@gmail.com', 'Hoang', 'Luu', 'Da Nang, Viet Nam', '$2a$10$LMHxkcz/E0TSAjcuxARAZew87Rm/sWSKT1WqMMkaTXJHyqLOTZtV.', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', 'UNVERIFIED');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `auctions`
--
ALTER TABLE `auctions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK3ilucsumdckke8k3yljkpf86q` (`auctioneer_id`);

--
-- Chỉ mục cho bảng `auction_kois`
--
ALTER TABLE `auction_kois`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKp4gi0darfksbicctbsh6uc3ou` (`auction_id`),
  ADD KEY `FKhiwdnap3fod80aliuymaklkit` (`koi_id`);

--
-- Chỉ mục cho bảng `auction_kois_details`
--
ALTER TABLE `auction_kois_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKjo0888rrp37jokibr875ftqcx` (`auction_koi_id`),
  ADD KEY `FKkaaka2inkbtxrlqno2syf1x4s` (`user_id`);

--
-- Chỉ mục cho bảng `auction_participants`
--
ALTER TABLE `auction_participants`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKoueiq28cuki5mhu0i7udc8q9b` (`auction_id`),
  ADD KEY `FK9jnbjd50w43dg3vtc4b1th1fw` (`user_id`);

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `feedbacks`
--
ALTER TABLE `feedbacks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKbdhoov2mv332ks2m84owt5tv3` (`order_id`),
  ADD KEY `FK312drfl5lquu37mu4trk8jkwx` (`user_id`);

--
-- Chỉ mục cho bảng `kois`
--
ALTER TABLE `kois`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKabkupc6s0m4jrqoh0e0a9ri1f` (`category_id`),
  ADD KEY `FKcx45ppp71l5dlu25f9kd0qpa` (`owner_id`);

--
-- Chỉ mục cho bảng `koi_images`
--
ALTER TABLE `koi_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKj6nh95hilrad5roxpf7hy6v7w` (`koi_id`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK32ql8ubntj5uh44ph9659tiih` (`user_id`);

--
-- Chỉ mục cho bảng `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKe9d6wfc3gtdvbc4aoy3lge1o0` (`product_id`),
  ADD KEY `FKjyu2qbqt8gnvno9oe9j2s2ldk` (`order_id`);

--
-- Chỉ mục cho bảng `otps`
--
ALTER TABLE `otps`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK81gagumt0r8y3rmudcgpbk42l` (`order_id`),
  ADD KEY `FKj94hgy9v5fw1munb90tar2eje` (`user_id`);

--
-- Chỉ mục cho bảng `refunds`
--
ALTER TABLE `refunds`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKpt9ic0j1y6xwlej99wnynvnpy` (`payment_id`),
  ADD KEY `FKrtxief4co3k1lfklj7n05m8mo` (`user_id`);

--
-- Chỉ mục cho bảng `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `social_accounts`
--
ALTER TABLE `social_accounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK6rmxxiton5yuvu7ph2hcq2xn7` (`user_id`);

--
-- Chỉ mục cho bảng `tokens`
--
ALTER TABLE `tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK2dylsfo39lgjyqml2tbe0b0ss` (`user_id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKp56c1712k691lhsyewcssf40f` (`role_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `auctions`
--
ALTER TABLE `auctions`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT cho bảng `auction_kois`
--
ALTER TABLE `auction_kois`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;

--
-- AUTO_INCREMENT cho bảng `auction_kois_details`
--
ALTER TABLE `auction_kois_details`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT cho bảng `auction_participants`
--
ALTER TABLE `auction_participants`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT cho bảng `feedbacks`
--
ALTER TABLE `feedbacks`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `kois`
--
ALTER TABLE `kois`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=427;

--
-- AUTO_INCREMENT cho bảng `koi_images`
--
ALTER TABLE `koi_images`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT cho bảng `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT cho bảng `otps`
--
ALTER TABLE `otps`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT cho bảng `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `refunds`
--
ALTER TABLE `refunds`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `social_accounts`
--
ALTER TABLE `social_accounts`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tokens`
--
ALTER TABLE `tokens`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=535;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `auctions`
--
ALTER TABLE `auctions`
  ADD CONSTRAINT `FK3ilucsumdckke8k3yljkpf86q` FOREIGN KEY (`auctioneer_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `auction_kois`
--
ALTER TABLE `auction_kois`
  ADD CONSTRAINT `FKhiwdnap3fod80aliuymaklkit` FOREIGN KEY (`koi_id`) REFERENCES `kois` (`id`),
  ADD CONSTRAINT `FKp4gi0darfksbicctbsh6uc3ou` FOREIGN KEY (`auction_id`) REFERENCES `auctions` (`id`);

--
-- Các ràng buộc cho bảng `auction_kois_details`
--
ALTER TABLE `auction_kois_details`
  ADD CONSTRAINT `FKjo0888rrp37jokibr875ftqcx` FOREIGN KEY (`auction_koi_id`) REFERENCES `auction_kois` (`id`),
  ADD CONSTRAINT `FKkaaka2inkbtxrlqno2syf1x4s` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `auction_participants`
--
ALTER TABLE `auction_participants`
  ADD CONSTRAINT `FK9jnbjd50w43dg3vtc4b1th1fw` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `FKoueiq28cuki5mhu0i7udc8q9b` FOREIGN KEY (`auction_id`) REFERENCES `auctions` (`id`);

--
-- Các ràng buộc cho bảng `feedbacks`
--
ALTER TABLE `feedbacks`
  ADD CONSTRAINT `FK312drfl5lquu37mu4trk8jkwx` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `FKbdhoov2mv332ks2m84owt5tv3` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Các ràng buộc cho bảng `kois`
--
ALTER TABLE `kois`
  ADD CONSTRAINT `FKabkupc6s0m4jrqoh0e0a9ri1f` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `FKcx45ppp71l5dlu25f9kd0qpa` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `koi_images`
--
ALTER TABLE `koi_images`
  ADD CONSTRAINT `FKj6nh95hilrad5roxpf7hy6v7w` FOREIGN KEY (`koi_id`) REFERENCES `kois` (`id`);

--
-- Các ràng buộc cho bảng `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `FK32ql8ubntj5uh44ph9659tiih` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `FKe9d6wfc3gtdvbc4aoy3lge1o0` FOREIGN KEY (`product_id`) REFERENCES `kois` (`id`),
  ADD CONSTRAINT `FKjyu2qbqt8gnvno9oe9j2s2ldk` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Các ràng buộc cho bảng `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `FK81gagumt0r8y3rmudcgpbk42l` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `FKj94hgy9v5fw1munb90tar2eje` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `refunds`
--
ALTER TABLE `refunds`
  ADD CONSTRAINT `FKpt9ic0j1y6xwlej99wnynvnpy` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`),
  ADD CONSTRAINT `FKrtxief4co3k1lfklj7n05m8mo` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `social_accounts`
--
ALTER TABLE `social_accounts`
  ADD CONSTRAINT `FK6rmxxiton5yuvu7ph2hcq2xn7` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `tokens`
--
ALTER TABLE `tokens`
  ADD CONSTRAINT `FK2dylsfo39lgjyqml2tbe0b0ss` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `FKp56c1712k691lhsyewcssf40f` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
