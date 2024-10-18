-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1:3306
-- Thời gian đã tạo: Th10 18, 2024 lúc 12:08 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `koi_company_dev`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auctions`
--

CREATE TABLE `auctions` (
  `id` bigint(20) NOT NULL,
  `status` enum('ONGOING','ENDED','UPCOMING') DEFAULT NULL,
  `end_time` datetime(6) DEFAULT NULL,
  `start_time` datetime(6) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `auctioneer_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `auctions`
--

INSERT INTO `auctions` (`id`, `status`, `end_time`, `start_time`, `title`, `auctioneer_id`) VALUES
(1, 'ONGOING', '2024-10-30 14:41:38.679000', '2024-10-06 14:41:38.679000', 'Fixed Price Auction', 23),
(2, 'ONGOING', '2024-10-30 14:41:38.679000', '2024-10-06 14:41:38.679000', 'Sealed Price Auction', 23),
(3, 'ENDED', '2024-10-17 14:35:00.000000', '2024-10-15 14:35:00.000000', 'Test Auction', 21),
(4, 'ENDED', '2024-10-17 16:50:00.000000', '2024-10-15 16:50:00.000000', 'Decs Auction Test', 21);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auction_kois`
--

CREATE TABLE `auction_kois` (
  `id` bigint(20) NOT NULL,
  `base_price` bigint(20) DEFAULT NULL,
  `bid_step` int(11) DEFAULT 0,
  `bid_method` enum('ASCENDING_BID','DESCENDING_BID','FIXED_PRICE','SEALED_BID') DEFAULT NULL,
  `current_bid` bigint(20) DEFAULT NULL,
  `current_bidder_id` bigint(20) DEFAULT NULL,
  `is_sold` tinyint(1) NOT NULL DEFAULT 0,
  `auction_id` bigint(20) DEFAULT NULL,
  `koi_id` bigint(20) DEFAULT NULL,
  `ceil_price` bigint(20) DEFAULT NULL,
  `revoked` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `auction_kois`
--

INSERT INTO `auction_kois` (`id`, `base_price`, `bid_step`, `bid_method`, `current_bid`, `current_bidder_id`, `is_sold`, `auction_id`, `koi_id`, `ceil_price`, `revoked`) VALUES
(1, 200000, 0, 'FIXED_PRICE', 200000, 2, 1, 1, 117, NULL, 0),
(2, 200000, 0, 'FIXED_PRICE', 200000, 2, 1, 1, 324, NULL, 0),
(3, 200000, 0, 'FIXED_PRICE', 200000, 19, 1, 1, 123, NULL, 0),
(4, 200000, 0, 'FIXED_PRICE', 200000, 19, 1, 1, 333, NULL, 0),
(5, 200000, 0, 'FIXED_PRICE', 0, 0, 0, 1, 222, 0, 0),
(6, 200000, 0, 'FIXED_PRICE', 0, 0, 0, 1, 165, NULL, 0),
(7, 200000, 0, 'FIXED_PRICE', 0, 0, 0, 1, 334, 0, 0),
(8, 200000, 0, 'FIXED_PRICE', 0, 0, 0, 1, 97, NULL, 0),
(9, 200000, 0, 'FIXED_PRICE', 0, 0, 0, 1, 66, NULL, 0),
(10, 200000, 0, 'FIXED_PRICE', 0, 0, 0, 1, 61, 0, 0),
(11, 300000, 0, 'SEALED_BID', 0, 0, 0, 2, 281, 500000, 0),
(12, 300000, 0, 'SEALED_BID', 300000, 19, 0, 2, 63, NULL, 0),
(13, 300000, 0, 'SEALED_BID', 0, 1, 0, 2, 291, 500000, 0),
(14, 300000, 0, 'SEALED_BID', 0, 13, 0, 2, 238, 500000, 0),
(15, 300000, 0, 'SEALED_BID', 0, NULL, 0, 2, 160, 500000, 0),
(16, 300000, 0, 'SEALED_BID', 0, 11, 0, 2, 275, 500000, 0),
(17, 300000, 0, 'SEALED_BID', 0, 13, 0, 2, 93, 500000, 0),
(18, 300000, 0, 'SEALED_BID', 0, NULL, 0, 2, 286, 500000, 0),
(19, 300000, 0, 'SEALED_BID', 0, 3, 0, 2, 65, 500000, 0),
(20, 300000, 0, 'SEALED_BID', 0, NULL, 0, 2, 35, 500000, 0),
(21, 200000, 50, 'ASCENDING_BID', 0, 0, 0, 3, 201, 500000, 0),
(22, 100000, 50, 'DESCENDING_BID', 0, 0, 0, 4, 7, 500000, 0),
(23, 200000, 50, 'DESCENDING_BID', 0, 0, 0, 4, 8, 500000, 0),
(24, 150000, 50, 'DESCENDING_BID', 0, 0, 0, 4, 12, 500000, 0),
(25, 300000, 50, 'SEALED_BID', 0, 0, 0, 3, 5, 500000, 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auction_kois_details`
--

CREATE TABLE `auction_kois_details` (
  `id` bigint(20) NOT NULL,
  `bid_amount` bigint(20) DEFAULT NULL,
  `bid_time` datetime(6) DEFAULT NULL,
  `auction_koi_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `auction_kois_details`
--

INSERT INTO `auction_kois_details` (`id`, `bid_amount`, `bid_time`, `auction_koi_id`, `user_id`) VALUES
(1, 200000, '2024-10-18 04:57:48.000000', 1, 2),
(2, 300000, '2024-10-18 04:58:37.000000', 12, 2),
(3, 300000, '2024-10-18 04:58:43.000000', 12, 19),
(4, 200000, '2024-10-18 04:59:37.000000', 3, 19),
(5, 200000, '2024-10-18 05:01:01.000000', 4, 19),
(6, 200000, '2024-10-18 05:02:31.000000', 2, 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auction_participants`
--

CREATE TABLE `auction_participants` (
  `id` bigint(20) NOT NULL,
  `join_time` datetime(6) DEFAULT NULL,
  `auction_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `auction_participants`
--

INSERT INTO `auction_participants` (`id`, `join_time`, `auction_id`, `user_id`) VALUES
(1, '2024-10-18 04:57:48.000000', 1, 2),
(2, '2024-10-18 04:58:37.000000', 2, 2),
(3, '2024-10-18 04:58:43.000000', 2, 19),
(4, '2024-10-18 04:59:37.000000', 1, 19);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
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
-- Cấu trúc bảng cho bảng `kois`
--

CREATE TABLE `kois` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_display` int(11) DEFAULT NULL,
  `length` int(11) DEFAULT NULL,
  `name` varchar(350) NOT NULL,
  `base_price` bigint(20) DEFAULT NULL,
  `sex` varchar(10) DEFAULT NULL,
  `status` enum('PENDING','REJECTED','SOLD','UNVERIFIED','VERIFIED') DEFAULT NULL,
  `thumbnail` varchar(300) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `owner_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `kois`
--

INSERT INTO `kois` (`id`, `created_at`, `updated_at`, `age`, `description`, `is_display`, `length`, `name`, `base_price`, `sex`, `status`, `thumbnail`, `category_id`, `owner_id`) VALUES
(1, '2023-06-05 00:00:00.000000', '2024-05-16 00:00:00.000000', 1, 'A beautiful Doitsu Showa koi', 1, 26, 'Doitsu Showa', 558, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Doitsu%20Showa%2026cm%20tosai.png', 3, 26),
(2, '2023-03-14 00:00:00.000000', '2024-03-18 00:00:00.000000', 1, 'A beautiful Showa koi', 0, 26, 'Showa', 561, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Isa%20Showa%20Tosai%2026cm.png', 3, 27),
(3, '2024-05-18 00:00:00.000000', '2024-05-25 00:00:00.000000', 1, 'A beautiful Showa koi', 1, 27, 'Showa', 444, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Isa%20Showa%20Tosai%2027cm.png', 3, 28),
(4, '2024-10-13 00:00:00.000000', '2024-12-13 00:00:00.000000', 1, 'A beautiful Ginrin Kohaku koi', 0, 29, 'Ginrin Kohaku', 745, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Torazo%20Ginrin%20Kohaku%2029cm%20Tosai.png', 1, 24),
(5, '2024-01-11 00:00:00.000000', '2024-12-10 00:00:00.000000', 1, 'A beautiful Ginrin Kohaku koi', 1, 22, 'Ginrin Kohaku', 618, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Torazo%20Ginrin%20Kohaku%20Tosai%2022cm.png', 1, 30),
(6, '2024-05-24 00:00:00.000000', '2024-11-04 00:00:00.000000', 1, 'A beautiful Karashigoi koi', 0, 22, 'Karashigoi', 25, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Karashigoi%20Tosai%2022cm.png', 20, 25),
(7, '2024-01-06 00:00:00.000000', '2024-11-09 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 0, 32, 'Shiro Utsuri', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Shiro%20Utsuri%20Tosai%2032cm.png', 4, 27),
(8, '2023-12-19 00:00:00.000000', '2024-11-27 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 25, 'Shiro Utsuri', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Shiro%20Utsuri%20Tosai%20.png', 4, 37),
(9, '2024-06-01 00:00:00.000000', '2024-07-29 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 21, 'Shiro Utsuri', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Shiro%20Utsuri%20%20tosai%2021cm.png', 4, 28),
(10, '2024-08-30 00:00:00.000000', '2024-09-04 00:00:00.000000', 1, 'A beautiful Showa koi', 1, 22, 'Showa', 889, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/NND%20Showa%2022cm%20tosai.png', 3, 36),
(11, '2023-10-29 00:00:00.000000', '2024-11-01 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 30, 'Shiro Utsuri', 50, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Shiro%20Utsuri%20%2030cm.png', 4, 32),
(12, '2023-05-23 00:00:00.000000', '2024-02-13 00:00:00.000000', 1, 'A beautiful Yamabuki koi', 0, 18, 'Yamabuki', 991, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/NND%20Yamabuki%20Tosai%2018cm.png', 11, 36),
(13, '2024-08-29 00:00:00.000000', '2024-12-05 00:00:00.000000', 1, 'A beautiful Dark Ochiba koi', 1, 23, 'Dark Ochiba', 762, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Dark%20Ochiba%2023cm%20tosai.png', 7, 26),
(14, '2024-05-13 00:00:00.000000', '2024-11-09 00:00:00.000000', 1, 'A beautiful Ginrin Showa koi', 1, 31, 'Ginrin Showa', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Ginrin%20Showa%20Tosai%2031cm.png', 3, 32),
(15, '2023-05-28 00:00:00.000000', '2023-11-29 00:00:00.000000', 1, 'A beautiful Ginrin Showa koi', 1, 21, 'Ginrin Showa', 392, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Ginrin%20Showa%20tosai%2021cm.png', 3, 24),
(16, '2023-07-06 00:00:00.000000', '2023-09-28 00:00:00.000000', 1, 'A beautiful Hi Utsuri koi', 1, 33, 'Hi Utsuri', 661, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Hi%20Utsuri%2033cm.png', 4, 32),
(17, '2023-11-05 00:00:00.000000', '2023-12-16 00:00:00.000000', 1, 'A beautiful Hi Utsuri koi', 0, 28, 'Hi Utsuri', 50, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Hi%20Utsuri%20Tosai%2028cm.png', 4, 29),
(18, '2024-09-21 00:00:00.000000', '2024-12-03 00:00:00.000000', 1, 'A beautiful Ginrin Kohaku koi', 1, 18, 'Ginrin Kohaku', 50, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Torazo%20Ginrin%20Kohaku%2018cm.png', 1, 25),
(19, '2023-06-19 00:00:00.000000', '2023-10-18 00:00:00.000000', 1, 'A beautiful Ginrin Kohaku koi', 0, 17, 'Ginrin Kohaku', 50, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Torazo%20GinRin%20Kohaku%20Tosai%2017cm.png', 1, 28),
(20, '2023-04-26 00:00:00.000000', '2023-07-25 00:00:00.000000', 1, 'A beautiful Ginrin Kohaku koi', 0, 26, 'Ginrin Kohaku', 620, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Torazo%20Ginrin%20Kohaku%20Tosai%2026cm%20.png', 1, 32),
(21, '2023-07-24 00:00:00.000000', '2024-07-26 00:00:00.000000', 1, 'A beautiful Ginrin Showa koi', 1, 33, 'Ginrin Showa', 592, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Ginrin%20Showa%20tosai%2033cm.png', 3, 31),
(22, '2023-05-11 00:00:00.000000', '2023-05-26 00:00:00.000000', 1, 'A beautiful Doitsu Kohaku koi', 0, 31, 'Doitsu Kohaku', 364, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Doitsu%20Kohaku%20Tosai%2031.png', 1, 28),
(23, '2023-08-09 00:00:00.000000', '2023-12-31 00:00:00.000000', 1, 'A beautiful Kohaku koi', 0, 21, 'Kohaku', 50, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Torazo%20Kohaku%20Tosai%2021cm.png', 1, 28),
(24, '2024-08-17 00:00:00.000000', '2024-09-19 00:00:00.000000', 1, 'A beautiful Kohaku koi', 0, 23, 'Kohaku', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Torazo%20Kohaku%2023cm%20tosai%20.png', 1, 34),
(25, '2024-03-17 00:00:00.000000', '2024-08-03 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 0, 22, 'Shiro Utsuri', 50, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Shiro%20Utsuri%20Tosai%2022cm.png', 4, 30),
(26, '2023-10-14 00:00:00.000000', '2024-07-03 00:00:00.000000', 1, 'A beautiful Kohaku koi', 1, 21, 'Kohaku', 50, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Torazo%20Kohaku%20Tosai%2021cm%202.png', 1, 30),
(27, '2024-01-24 00:00:00.000000', '2024-12-04 00:00:00.000000', 1, 'A beautiful Hi Utsuri koi', 0, 33, 'Hi Utsuri', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Hi%20Utsuri%2033cm%20Nisai%20png.png', 4, 37),
(28, '2024-03-03 00:00:00.000000', '2024-11-11 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 1, 34, 'Doitsu Showa', 493, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Hiroi%20Doitsu%20Showa%2034cm%20Nisai.png', 3, 37),
(29, '2024-06-19 00:00:00.000000', '2024-12-05 00:00:00.000000', 2, 'A beautiful Showa koi', 0, 36, 'Showa', 435, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Isa%20Showa%20Nisai%2036cm.png', 3, 33),
(30, '2023-07-02 00:00:00.000000', '2023-11-26 00:00:00.000000', 2, 'A beautiful Doitsu Sanke koi', 0, 40, 'Doitsu Sanke', 258, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Hiroi%20Doitsu%20Sanke%2040cm%20Nisai.png', 2, 33),
(31, '2023-07-13 00:00:00.000000', '2024-05-16 00:00:00.000000', 2, 'A beautiful Ginrin Matsukawabake koi', 1, 34, 'Ginrin Matsukawabake', 50, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Iwashita%20Ginrin%20Matsukawabake%2034cm%20Nisai.png', 13, 29),
(32, '2023-08-24 00:00:00.000000', '2024-04-04 00:00:00.000000', 2, 'A beautiful Ai Goromo koi', 1, 33, 'Ai Goromo', 50, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Izumiya%20Ai%20Goromo%2033cm%20Nisai.png', 16, 28),
(33, '2023-06-27 00:00:00.000000', '2024-05-25 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 35, 'Kohaku', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Izumiya%20Kohaku%20nisai%2035cm.png', 1, 24),
(34, '2023-09-14 00:00:00.000000', '2024-10-03 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 31, 'Sanke', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Izumiya%20Sanke%2031cm%20Nisai.png', 2, 33),
(35, '2024-02-16 00:00:00.000000', '2024-07-14 00:00:00.000000', 2, 'A beautiful Sanke koi', 0, 35, 'Sanke', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Izumiya%20Sanke%2035cm%20Nisai.png', 2, 27),
(36, '2023-01-07 00:00:00.000000', '2023-06-13 00:00:00.000000', 2, 'A beautiful Sanke koi', 0, 33, 'Sanke', 983, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Izumiya%20Sanke%20Nisai%2033cm.png', 2, 25),
(37, '2024-06-12 00:00:00.000000', '2024-12-04 00:00:00.000000', 2, 'A beautiful Ginrin Goshiki koi', 0, 48, 'Ginrin Goshiki', 964, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Kanno%20Ginrin%20Goshiki%20Nisai%2048cm.png', 8, 24),
(38, '2023-11-08 00:00:00.000000', '2024-01-20 00:00:00.000000', 2, 'A beautiful Tancho Goshiki koi', 1, 39, 'Tancho Goshiki', 561, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Kanno%20Tancho%20Goshiki%20Nisai%2039cm.png', 11, 33),
(39, '2023-11-16 00:00:00.000000', '2024-01-22 00:00:00.000000', 2, 'A beautiful Bekko koi', 1, 27, 'Bekko', 50, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Bekko%20Nisai%2027cm.png', 10, 26),
(40, '2023-03-27 00:00:00.000000', '2024-10-14 00:00:00.000000', 2, 'A beautiful Ochiba koi', 0, 44, 'Ochiba', 317, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Ochiba%20Nisai%2044cm.png', 3, 33),
(41, '2024-07-20 00:00:00.000000', '2024-08-19 00:00:00.000000', 2, 'A beautiful Goshiki koi', 0, 37, 'Goshiki', 168, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Kanno%20Goshiki%20Nisai%2037cm.png', 3, 29),
(42, '2024-09-23 00:00:00.000000', '2024-10-16 00:00:00.000000', 2, 'A beautiful Doitsu Aragoke Ginrin Chagoi koi', 0, 42, 'Doitsu Aragoke Ginrin Chagoi', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Doitsu%20Aragoke%20Ginrin%20Chagoi%20Nisai%2042cm.png', 3, 25),
(43, '2023-08-01 00:00:00.000000', '2023-09-01 00:00:00.000000', 2, 'A beautiful Ginrin Ochiba koi', 0, 44, 'Ginrin Ochiba', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Ginrin%20Ochiba%20Nisai%2044cm.png', 9, 37),
(44, '2024-12-15 00:00:00.000000', '2024-12-16 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 40, 'Showa', 782, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Izumiya%20Showa%20nisai%2040cm.png', 3, 37),
(45, '2024-09-26 00:00:00.000000', '2024-10-10 00:00:00.000000', 2, 'A beautiful Soragoi koi', 0, 40, 'Soragoi', 865, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Soragoi%20Nisai%2040cm.png', 9, 33),
(46, '2023-09-27 00:00:00.000000', '2024-10-13 00:00:00.000000', 2, 'A beautiful Asagi koi', 0, 38, 'Asagi', 805, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Maruhiro%20Asagi%20Nisai%2038cm.png', 8, 36),
(47, '2024-02-22 00:00:00.000000', '2024-02-23 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 0, 46, 'Shiro Utsuri', 683, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/NND%20Shiro%20Utsuri%2046cm%20Nisai.png', 4, 26),
(48, '2023-07-27 00:00:00.000000', '2024-09-28 00:00:00.000000', 2, 'A beautiful Budo Goromo koi', 1, 28, 'Budo Goromo', 50, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Ootsuka%20Budo%20Goromo%20Nisai.png', 19, 35),
(49, '2023-03-07 00:00:00.000000', '2023-03-31 00:00:00.000000', 2, 'A beautiful Hi Utsuri koi', 0, 30, 'Hi Utsuri', 50, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Hi%20Utsuri%20Nisai%2030cm.png', 4, 36),
(50, '2023-12-06 00:00:00.000000', '2024-09-23 00:00:00.000000', 2, 'A beautiful Showa koi', 0, 28, 'Showa', 597, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Izumiya%20Showa%20Nisai%2028cm.png', 3, 30),
(51, '2024-03-12 00:00:00.000000', '2024-08-17 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 42, 'Showa', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Izumiya%20Showa%20Nisai%2042cm.png', 3, 27),
(52, '2023-07-30 00:00:00.000000', '2024-05-26 00:00:00.000000', 2, 'A beautiful Ginrin Aragoke Chagoi koi', 1, 33, 'Ginrin Aragoke Chagoi', 396, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Ginrin%20Aragoke%20Chagoi.png', 4, 34),
(53, '2024-09-21 00:00:00.000000', '2024-10-22 00:00:00.000000', 3, 'A beautiful Sanke koi', 0, 47, 'Sanke', 50, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Izumiya%20Sanke%20sansai%2047cm.png', 2, 27),
(54, '2024-11-14 00:00:00.000000', '2024-12-14 00:00:00.000000', 3, 'A beautiful Red Karashigoi koi', 1, 60, 'Red Karashigoi', 200, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Karashigoi%20Sansai%2060cm.png', 18, 34),
(55, '2024-01-05 00:00:00.000000', '2024-12-30 00:00:00.000000', 3, 'A beautiful Magoi koi', 1, 49, 'Magoi', 25, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Hirashin%20Magoi%20Sansai%2049cm.png', 13, 35),
(56, '2024-05-03 00:00:00.000000', '2024-10-11 00:00:00.000000', 3, 'A beautiful Showa koi', 0, 58, 'Showa', 520, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Sekiguchi%20Showa%20Sansai%2058cm.png', 3, 31),
(57, '2023-05-28 00:00:00.000000', '2024-09-14 00:00:00.000000', 3, 'A beautiful Magoi koi', 0, 48, 'Magoi', 321, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Hirashin%20Magoi%20Sansai%2048cm.png', 4, 32),
(58, '2023-07-22 00:00:00.000000', '2024-09-17 00:00:00.000000', 1, 'A beautiful Kohaku koi', 0, 15, 'Kohaku', 909, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Torazo%20Kohaku%2015cm%20Tosai.png', 1, 36),
(59, '2024-05-18 00:00:00.000000', '2024-10-09 00:00:00.000000', 1, 'A beautiful Ginrin Kohaku koi', 0, 15, 'Ginrin Kohaku', 605, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Torazo%20Ginrin%20Kohaku%2015cm%20Tosai.png', 1, 36),
(60, '2024-12-08 00:00:00.000000', '2024-12-27 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 18, 'Shiro Utsuri', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2018cm.png', 4, 27),
(61, '2023-05-08 00:00:00.000000', '2024-07-26 00:00:00.000000', 1, 'A beautiful Ginrin Kohaku koi', 0, 18, 'Ginrin Kohaku', 595, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Torazo%20Ginrin%20Kohaku%2018cm%20Tosai.png', 1, 25),
(62, '2024-10-26 00:00:00.000000', '2024-11-29 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 19, 'Shiro Utsuri', 50, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2019cm.png', 4, 31),
(63, '2024-09-01 00:00:00.000000', '2024-12-25 00:00:00.000000', 1, 'A beautiful Showa koi', 1, 19, 'Showa', 50, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/ISA%20Showa%2019cm%20Tosai.png', 3, 34),
(64, '2023-08-13 00:00:00.000000', '2024-01-30 00:00:00.000000', 1, 'A beautiful Kohaku koi', 1, 20, 'Kohaku', 145, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Torazo%20Kohaku%2020cm%20Tosai%20', 1, 32),
(65, '2024-04-05 00:00:00.000000', '2024-07-24 00:00:00.000000', 1, 'A beautiful Tancho Sanke koi', 0, 20, 'Tancho Sanke', 279, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Torazo%20Tancho%20Sanke%2020cm%20Tosai.png', 2, 31),
(66, '2023-09-07 00:00:00.000000', '2023-12-06 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 21, 'Shiro Utsuri', 50, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2021cm%202.png', 4, 29),
(67, '2023-08-13 00:00:00.000000', '2024-01-03 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 0, 21, 'Shiro Utsuri', 50, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2021cm%203.png', 4, 35),
(68, '2023-10-10 00:00:00.000000', '2024-11-02 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 0, 21, 'Shiro Utsuri', 50, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2021cm.png', 4, 34),
(69, '2024-08-03 00:00:00.000000', '2024-11-06 00:00:00.000000', 1, 'A beautiful Showa koi', 0, 21, 'Showa', 970, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/ISA%20Showa%2021cm%20Tosai.png', 3, 35),
(70, '2023-08-04 00:00:00.000000', '2024-04-23 00:00:00.000000', 1, 'A beautiful Showa koi', 0, 22, 'Showa', 50, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/ISA%20Showa%2022cm%20Tosai.png', 3, 30),
(71, '2023-10-18 00:00:00.000000', '2024-12-16 00:00:00.000000', 1, 'A beautiful Yamabuki koi', 0, 22, 'Yamabuki', 605, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/NND%20Yamibuki%20Tosai%2022cm%20.png', 6, 35),
(72, '2023-10-28 00:00:00.000000', '2024-03-01 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 22, 'Shiro Utsuri', 559, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2022cm%203.png', 4, 26),
(73, '2024-04-19 00:00:00.000000', '2024-05-21 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 22, 'Shiro Utsuri', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2022cm%205.png', 4, 37),
(74, '2024-02-16 00:00:00.000000', '2024-05-09 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 22, 'Shiro Utsuri', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2022cm%206.png', 4, 37),
(75, '2023-07-04 00:00:00.000000', '2023-07-20 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 22, 'Shiro Utsuri', 50, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2022cm%204.png', 4, 35),
(76, '2024-11-10 00:00:00.000000', '2024-11-29 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 22, 'Shiro Utsuri', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2022cm%207.png', 4, 34),
(77, '2024-05-12 00:00:00.000000', '2024-05-28 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 22, 'Shiro Utsuri', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2022cm.png', 4, 34),
(78, '2024-09-23 00:00:00.000000', '2024-10-26 00:00:00.000000', 1, 'A beautiful Yellow Monkey koi', 1, 22, 'Yellow Monkey', 359, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Yellow_Monkey_22cm_Tosai.png', 18, 33),
(79, '2024-10-05 00:00:00.000000', '2024-12-27 00:00:00.000000', 1, 'A beautiful Showa koi', 0, 23, 'Showa', 206, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/ISA%20Showa%2023cm%20Tosai%20', 3, 34),
(80, '2023-09-08 00:00:00.000000', '2024-12-22 00:00:00.000000', 1, 'A beautiful Showa koi', 0, 23, 'Showa', 50, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/ISA%20Showa%2023cm%20Tosai.png', 3, 32),
(81, '2023-11-01 00:00:00.000000', '2024-03-21 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 0, 23, 'Shiro Utsuri', 50, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2023cm%202.png', 4, 36),
(82, '2024-01-09 00:00:00.000000', '2024-08-05 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 23, 'Shiro Utsuri', 334, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2023cm.png', 4, 25),
(83, '2024-10-10 00:00:00.000000', '2024-10-14 00:00:00.000000', 1, 'A beautiful Yellow Monkey koi', 0, 23, 'Yellow Monkey', 345, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Dainichi%20Ginrin%20Chagoi%2023cm%20Tosai.png', 18, 32),
(84, '2023-11-02 00:00:00.000000', '2024-03-23 00:00:00.000000', 1, 'A beautiful Showa koi', 1, 24, 'Showa', 305, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/ISA%20Showa%2024cm%20Tosai.png', 3, 35),
(85, '2024-10-09 00:00:00.000000', '2024-12-29 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 0, 24, 'Shiro Utsuri', 50, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2024cm%203.png', 4, 29),
(86, '2023-02-25 00:00:00.000000', '2023-09-01 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 0, 24, 'Shiro Utsuri', 50, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2024cm%204.png', 4, 25),
(87, '2024-09-02 00:00:00.000000', '2024-11-12 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 24, 'Shiro Utsuri', 50, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2024cm.png', 4, 31),
(88, '2024-08-28 00:00:00.000000', '2024-09-14 00:00:00.000000', 1, 'A beautiful Kujaku koi', 0, 24, 'Kujaku', 997, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Kujaku_24cm_Tosai.png', 13, 36),
(89, '2024-04-26 00:00:00.000000', '2024-08-22 00:00:00.000000', 1, 'A beautiful Ginrin Kohaku koi', 0, 25, 'Ginrin Kohaku', 313, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Torazo%20Ginrin%20Kohaku%20Tosai%2025cm.png', 1, 29),
(90, '2024-08-08 00:00:00.000000', '2024-10-14 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 0, 25, 'Shiro Utsuri', 50, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2025cm%202.png', 4, 33),
(91, '2023-05-27 00:00:00.000000', '2024-07-19 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 25, 'Shiro Utsuri', 50, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2025cm.png', 4, 33),
(92, '2024-01-06 00:00:00.000000', '2024-08-13 00:00:00.000000', 1, 'A beautiful Yellow Monkey koi', 1, 25, 'Yellow Monkey', 320, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Dainichi%20Gin%20Rin%20Chagoi%2025cm%20Tosai.png', 11, 33),
(93, '2024-07-08 00:00:00.000000', '2024-09-02 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 26, 'Shiro Utsuri', 50, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2026cm%202.png', 4, 30),
(94, '2024-06-23 00:00:00.000000', '2024-07-02 00:00:00.000000', 2, 'A beautiful Sanke koi', 0, 26, 'Sanke', 739, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Izumiya%20Showa%2026cm%20Nisai.png', 2, 34),
(95, '2023-04-10 00:00:00.000000', '2024-11-08 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 26, 'Shiro Utsuri', 50, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2026cm.png', 4, 24),
(96, '2023-04-23 00:00:00.000000', '2024-07-14 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 0, 28, 'Shiro Utsuri', 50, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2028cm.png', 4, 35),
(97, '2023-06-22 00:00:00.000000', '2024-12-15 00:00:00.000000', 1, 'A beautiful Doitsu Shiro Utsuri koi', 1, 28, 'Doitsu Shiro Utsuri', 176, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Doitsu%20Shiro%20Utsuri%2028cm.png', 4, 30),
(98, '2024-01-05 00:00:00.000000', '2024-01-06 00:00:00.000000', 1, 'A beautiful Yellow Monkey koi', 0, 28, 'Yellow Monkey', 624, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Dainichi%20Gin%20Rin%20Chagoi%2028cm%20Tosai.png', 11, 35),
(99, '2023-07-25 00:00:00.000000', '2024-02-18 00:00:00.000000', 2, 'A beautiful Sanke koi', 0, 29, 'Sanke', 277, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Izumiya%20Sanke%2029cm%20Nisai.png', 2, 32),
(100, '2024-03-18 00:00:00.000000', '2024-12-06 00:00:00.000000', 1, 'A beautiful Yellow Monkey koi', 0, 29, 'Yellow Monkey', 728, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Dainichi%20Gin%20Rin%20Chagoi%2029cm%20Tosai.png', 3, 33),
(101, '2024-10-24 00:00:00.000000', '2024-12-24 00:00:00.000000', 1, 'A beautiful Doitsu Sanke koi', 1, 30, 'Doitsu Sanke', 723, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Shinoda%20Doitsu%20Sanke%2030cm%20Tosai.png', 2, 24),
(102, '2024-04-06 00:00:00.000000', '2024-06-11 00:00:00.000000', 1, 'A beautiful Yellow Monkey koi', 0, 32, 'Yellow Monkey', 897, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Dainichi%20Gin%20Rin%20Chagoi%2032cm%20Tosai.png', 1, 33),
(103, '2023-11-04 00:00:00.000000', '2023-12-27 00:00:00.000000', 1, 'A beautiful Yellow Monkey koi', 0, 33, 'Yellow Monkey', 769, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Dainichi%20Gin%20Rin%20Chagoi%2033cm%20tosai.png', 12, 35),
(104, '2023-04-06 00:00:00.000000', '2024-01-06 00:00:00.000000', 1, 'A beautiful Yellow Monkey koi', 1, 33, 'Yellow Monkey', 324, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Dainichi%20Gin%20Rin%20Chagoi%20Tosai%2033cm.png', 3, 29),
(105, '2023-03-02 00:00:00.000000', '2023-11-01 00:00:00.000000', 2, 'A beautiful Ginrin Showa koi', 1, 37, 'Ginrin Showa', 210, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/8-37%20Gin%20Rin%20Showa.png', 3, 32),
(106, '2024-11-09 00:00:00.000000', '2024-11-17 00:00:00.000000', 2, 'A beautiful Ginrin Showa koi', 1, 46, 'Ginrin Showa', 313, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/9-46%20Gin%20Rin%20Showa.png', 3, 27),
(107, '2024-10-05 00:00:00.000000', '2024-11-07 00:00:00.000000', 2, 'A beautiful Doitsu Tancho Showa koi', 1, 41, 'Doitsu Tancho Showa', 292, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/13-41%20Doitsu%20Tancho%20Showa.png', 3, 24),
(108, '2023-09-15 00:00:00.000000', '2024-08-29 00:00:00.000000', 2, 'A beautiful Ginrin Showa koi', 0, 40, 'Ginrin Showa', 797, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/10-40%20Gin%20Rin%20Showa.png', 3, 29),
(109, '2024-06-23 00:00:00.000000', '2024-11-02 00:00:00.000000', 2, 'A beautiful Doitsu Shiro Utsuri koi', 1, 41, 'Doitsu Shiro Utsuri', 210, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/12-41%20Doitsu%20Shiro%20Utsuri.png', 4, 27),
(110, '2024-12-09 00:00:00.000000', '2024-12-17 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 1, 42, 'Doitsu Showa', 210, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/15-42%20Doitsu%20Showa.png', 3, 37),
(111, '2024-06-15 00:00:00.000000', '2024-09-04 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 1, 40, 'Doitsu Showa', 484, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/16-40%20Doitsu%20Showa.png', 3, 37),
(112, '2024-09-11 00:00:00.000000', '2024-10-28 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 1, 44, 'Doitsu Showa', 339, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/17-44%20Doitsu%20Showa.png', 3, 35),
(113, '2024-07-25 00:00:00.000000', '2024-11-27 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 0, 42, 'Doitsu Showa', 210, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/19-42%20Doitsu%20Showa.png', 3, 37),
(114, '2023-09-21 00:00:00.000000', '2023-12-04 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 0, 45, 'Doitsu Showa', 115, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/21-45%20Doitsu%20Showa.png', 3, 31),
(115, '2023-12-06 00:00:00.000000', '2024-02-28 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 0, 40, 'Doitsu Showa', 210, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/22-40%20Doitsu%20Showa.png', 3, 29),
(116, '2024-02-01 00:00:00.000000', '2024-05-21 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 1, 44, 'Doitsu Showa', 210, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/24-44%20Doitsu%20Showa.png', 3, 28),
(117, '2023-07-05 00:00:00.000000', '2023-09-14 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 1, 40, 'Doitsu Showa', 346, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/27-40%20Doitsu%20Showa.png', 3, 29),
(118, '2024-11-20 00:00:00.000000', '2024-11-20 00:00:00.000000', 3, 'A beautiful Showa koi', 1, 65, 'Showa', 701, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/32-65%20Showa.png', 3, 35),
(119, '2024-05-03 00:00:00.000000', '2024-12-10 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 44, 'Showa', 210, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/4-44%20Showa.png', 3, 37),
(120, '2024-11-19 00:00:00.000000', '2024-11-20 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 1, 42, 'Doitsu Showa', 134, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/20-42%20Doitsu%20Showa.png?t=2023-11-03T14%3A52%3A53.891Z', 3, 35),
(121, '2024-11-27 00:00:00.000000', '2024-12-30 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 1, 35, 'Doitsu Showa', 210, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/25-35%20Doitsu%20Showa.png?t=2023-11-03T14%3A58%3A23.649Z', 3, 25),
(122, '2023-10-12 00:00:00.000000', '2024-02-18 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 0, 46, 'Doitsu Showa', 210, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/29-46%20Doitsu%20Showa.png', 3, 29),
(123, '2024-07-27 00:00:00.000000', '2024-11-15 00:00:00.000000', 3, 'A beautiful Ginrin Showa koi', 1, 55, 'Ginrin Showa', 597, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/31-55%20Gin%20Rin%20Showa.png', 3, 24),
(124, '2023-11-09 00:00:00.000000', '2024-06-14 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 44, 'Showa', 395, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/1-44%20Showa.png', 3, 34),
(125, '2023-12-26 00:00:00.000000', '2024-08-13 00:00:00.000000', 2, 'A beautiful Showa koi', 0, 43, 'Showa', 210, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/2-43%20Showa.png', 3, 32),
(126, '2023-10-23 00:00:00.000000', '2024-04-16 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 46, 'Showa', 210, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/3-46%20Showa.png', 3, 34),
(127, '2024-05-26 00:00:00.000000', '2024-06-29 00:00:00.000000', 2, 'A beautiful Showa koi', 0, 47, 'Showa', 228, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/5-47%20Showa.png', 3, 37),
(128, '2023-03-28 00:00:00.000000', '2024-08-10 00:00:00.000000', 2, 'A beautiful Tancho Kohaku koi', 1, 42, 'Tancho Kohaku', 808, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/6-42%20Tacnho%20Kohaku.png', 1, 24),
(129, '2023-07-14 00:00:00.000000', '2024-10-22 00:00:00.000000', 2, 'A beautiful Ginrin Showa koi', 1, 47, 'Ginrin Showa', 200, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/7-47%20Gin%20Rin%20Showa.png', 3, 34),
(130, '2023-03-16 00:00:00.000000', '2023-03-20 00:00:00.000000', 2, 'A beautiful Ginrin Showa koi', 1, 39, 'Ginrin Showa', 529, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/11-39%20Gin%20Rin%20Showa.png', 3, 35),
(131, '2024-05-06 00:00:00.000000', '2024-07-10 00:00:00.000000', 2, 'A beautiful Doitsu Tancho Showa koi', 0, 45, 'Doitsu Tancho Showa', 531, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/14-45%20Tancho%20Doitsu%20Showa.png', 3, 34),
(132, '2023-03-02 00:00:00.000000', '2024-01-16 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 1, 38, 'Doitsu Showa', 210, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/18-38%20Doitsu%20Showa.png', 3, 26),
(133, '2024-01-22 00:00:00.000000', '2024-12-08 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 1, 42, 'Doitsu Showa', 210, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/23-42%20Doitsu%20Showa.png', 3, 24),
(134, '2023-02-02 00:00:00.000000', '2024-11-11 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 0, 41, 'Doitsu Showa', 724, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/26-41%20Doitsu%20Showa.png', 3, 28),
(135, '2024-08-01 00:00:00.000000', '2024-08-16 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 0, 42, 'Doitsu Showa', 210, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/28-42%20Doitsu%20Showa.png', 3, 26),
(136, '2023-06-23 00:00:00.000000', '2023-12-13 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 1, 46, 'Doitsu Showa', 231, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/30-46%20Doitsu%20Showa.png', 3, 33),
(137, '2024-09-07 00:00:00.000000', '2024-10-12 00:00:00.000000', 2, 'A beautiful Kohaku koi', 0, 42, 'Kohaku', 964, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No1%202y%20Kohaku%20Female%2042cm.png', 1, 32),
(138, '2023-10-16 00:00:00.000000', '2024-08-10 00:00:00.000000', 2, 'A beautiful Platinum Ogon koi', 0, 56, 'Platinum Ogon', 334, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No2%202y%20Plutinum%2056cm%20Female.png', 16, 26),
(139, '2024-09-05 00:00:00.000000', '2024-12-22 00:00:00.000000', 2, 'A beautiful Karashigoi koi', 0, 55, 'Karashigoi', 540, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No3%202y%20Karashi%2055cm%20Female.png', 9, 37),
(140, '2024-01-01 00:00:00.000000', '2024-11-07 00:00:00.000000', 3, 'A beautiful Kohaku koi', 1, 71, 'Kohaku', 550, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No4%204y%20Kohaku%2071cm%20Female.png?t=2023-11-03T15%3A57%3A14.528Z', 1, 32),
(141, '2023-04-27 00:00:00.000000', '2024-06-12 00:00:00.000000', 2, 'A beautiful Sanke koi', 0, 42, 'Sanke', 410, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No5%202y%20Sanke%2042cm%20Male.png', 2, 24),
(142, '2023-11-12 00:00:00.000000', '2024-04-24 00:00:00.000000', 2, 'A beautiful Ginrin Tancho Kohaku koi', 1, 42, 'Ginrin Tancho Kohaku', 540, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No6%202y%20Ginrin%20Tancho%2042cm%20Female.png', 1, 29),
(143, '2023-05-25 00:00:00.000000', '2023-08-16 00:00:00.000000', 3, 'A beautiful Metallic Doitsu Karasugoi koi', 0, 55, 'Metallic Doitsu Karasugoi', 540, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No7%203y%20Metallic%20Doitsu%20Karasugoi%2055cm%20Female.png?t=2023-11-03T18%3A02%3A30.791Z', 17, 26),
(144, '2023-10-11 00:00:00.000000', '2024-04-05 00:00:00.000000', 2, 'A beautiful Kohaku koi', 0, 50, 'Kohaku', 730, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No8%202y%20Kohaku%2050cm%20Female.png', 1, 35),
(145, '2024-03-21 00:00:00.000000', '2024-04-30 00:00:00.000000', 2, 'A beautiful Koromo Showa koi', 0, 43, 'Koromo Showa', 340, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No9%202y%20Koromo%20Showa%2043cm%20Female.png', 3, 31),
(146, '2023-05-12 00:00:00.000000', '2023-08-16 00:00:00.000000', 2, 'A beautiful Tancho Kohaku koi', 0, 50, 'Tancho Kohaku', 978, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No10%202y%20Tancho%20kohaku%2050cm%20Female.png?t=2023-11-03T18%3A30%3A50.742Z', 1, 31),
(147, '2024-09-02 00:00:00.000000', '2024-12-05 00:00:00.000000', 2, 'A beautiful Tancho Sanke koi', 1, 46, 'Tancho Sanke', 410, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No11%202y%20Tancho%20Sanke%2046cm%20Male.png', 2, 31),
(148, '2023-10-10 00:00:00.000000', '2024-10-14 00:00:00.000000', 3, 'A beautiful Yamabuki koi', 0, 60, 'Yamabuki', 680, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Yamibuki.png', 18, 34),
(149, '2024-05-27 00:00:00.000000', '2024-10-02 00:00:00.000000', 3, 'A beautiful Ginrin Chagoi koi', 1, 58, 'Ginrin Chagoi', 410, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Chagoi%206.png', 18, 37),
(150, '2023-09-13 00:00:00.000000', '2024-05-16 00:00:00.000000', 3, 'A beautiful Ginrin Chagoi koi', 0, 59, 'Ginrin Chagoi', 904, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Chagoi%20kole%20Updated%20601.png', 14, 36),
(151, '2024-10-10 00:00:00.000000', '2024-12-12 00:00:00.000000', 3, 'A beautiful Yamabuki koi', 0, 57, 'Yamabuki', 540, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Yamibuki%202.png', 11, 32),
(152, '2024-03-22 00:00:00.000000', '2024-08-26 00:00:00.000000', 3, 'A beautiful Ginrin Showa koi', 1, 49, 'Ginrin Showa', 507, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Showa.png', 3, 24),
(153, '2023-08-28 00:00:00.000000', '2024-07-16 00:00:00.000000', 3, 'A beautiful Ginrin Karashigoi koi', 1, 70, 'Ginrin Karashigoi', 529, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Karashigoi%202.png', 14, 37),
(154, '2024-02-26 00:00:00.000000', '2024-12-13 00:00:00.000000', 3, 'A beautiful Ginrin Karashigoi koi', 0, 64, 'Ginrin Karashigoi', 638, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Karashigoi.png', 19, 35),
(155, '2024-10-02 00:00:00.000000', '2024-11-06 00:00:00.000000', 2, 'A beautiful Ginrin Shiro Utsuri koi', 1, 48, 'Ginrin Shiro Utsuri', 287, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Shiro%20Utsuri.png', 4, 24),
(156, '2023-11-28 00:00:00.000000', '2024-03-03 00:00:00.000000', 3, 'A beautiful Yamabuki koi', 1, 58, 'Yamabuki', 540, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Yamabuki%205.png', 2, 28),
(157, '2023-12-16 00:00:00.000000', '2024-03-06 00:00:00.000000', 2, 'A beautiful Orenji Ogon koi', 0, 51, 'Orenji Ogon', 747, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Orenji%20Ogon.png', 15, 25),
(158, '2023-02-25 00:00:00.000000', '2023-11-27 00:00:00.000000', 2, 'A beautiful Orenji Ogon koi', 1, 48, 'Orenji Ogon', 280, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Orenji%20Ogon%202.png', 13, 31),
(159, '2023-05-09 00:00:00.000000', '2023-05-22 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 47, 'Showa', 680, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Showa%203.png', 3, 28),
(160, '2023-11-23 00:00:00.000000', '2024-08-23 00:00:00.000000', 2, 'A beautiful Showa koi', 0, 49, 'Showa', 875, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Showa%202.png', 3, 34),
(161, '2024-04-09 00:00:00.000000', '2024-07-02 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 49, 'Showa', 680, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Showa.png', 3, 26),
(162, '2023-03-15 00:00:00.000000', '2024-01-22 00:00:00.000000', 3, 'A beautiful Yamabuki koi', 1, 62, 'Yamabuki', 540, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Yamibuki%203.png', 5, 24),
(163, '2024-05-09 00:00:00.000000', '2024-06-04 00:00:00.000000', 2, 'A beautiful Yamabuki koi', 1, 52, 'Yamabuki', 420, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Yamibuki%204.png', 17, 35),
(164, '2024-12-06 00:00:00.000000', '2024-12-10 00:00:00.000000', 2, 'A beautiful Ginrin Karashigoi koi', 0, 38, 'Ginrin Karashigoi', 150, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Karashigoi%203.png', 5, 24),
(165, '2024-10-16 00:00:00.000000', '2024-12-14 00:00:00.000000', 2, 'A beautiful Kohaku koi', 0, 47, 'Kohaku', 680, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%202.png', 1, 24),
(166, '2023-11-21 00:00:00.000000', '2024-12-12 00:00:00.000000', 2, 'A beautiful Ginrin Kohaku koi', 0, 55, 'Ginrin Kohaku', 1010, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Kohaku.png', 1, 35),
(167, '2023-11-01 00:00:00.000000', '2023-11-15 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 53, 'Kohaku', 963, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%203%20updated%20618.png', 1, 27),
(168, '2023-10-24 00:00:00.000000', '2024-07-03 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 49, 'Kohaku', 960, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%206.png', 1, 37),
(169, '2023-01-01 00:00:00.000000', '2024-11-14 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 46, 'Kohaku', 1010, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%205%20updated.png', 1, 26),
(170, '2024-10-26 00:00:00.000000', '2024-11-14 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 48, 'Kohaku', 680, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%204.png', 1, 27),
(171, '2024-05-16 00:00:00.000000', '2024-12-11 00:00:00.000000', 2, 'A beautiful Kohaku koi', 0, 51, 'Kohaku', 427, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%209%20Updated%20622.png', 1, 35),
(172, '2023-12-23 00:00:00.000000', '2024-11-22 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 47, 'Kohaku', 1200, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%2010%20updated%20623.png', 1, 32),
(173, '2024-02-17 00:00:00.000000', '2024-04-24 00:00:00.000000', 2, 'A beautiful Kohaku koi', 0, 47, 'Kohaku', 960, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%207.png', 1, 32),
(174, '2024-06-01 00:00:00.000000', '2024-09-17 00:00:00.000000', 2, 'A beautiful Kohaku koi', 0, 54, 'Kohaku', 577, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%208.png', 1, 32),
(175, '2023-08-09 00:00:00.000000', '2024-07-16 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 49, 'Kohaku', 680, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku.png', 1, 31),
(176, '2024-02-25 00:00:00.000000', '2024-11-26 00:00:00.000000', 3, 'A beautiful Kohaku koi', 1, 75, 'Kohaku', 641, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%2012%20updated.png', 1, 25),
(177, '2024-01-21 00:00:00.000000', '2024-09-04 00:00:00.000000', 2, 'A beautiful Maruten Kohaku koi', 1, 50, 'Maruten Kohaku', 960, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%2011.png', 1, 35),
(178, '2024-03-27 00:00:00.000000', '2024-06-25 00:00:00.000000', 3, 'A beautiful Maruten Kohaku koi', 0, 75, 'Maruten Kohaku', 6800, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Maruten%20Kohaku%20updated.png?t=2023-11-15T15%3A01%3A37.654Z', 1, 33),
(179, '2024-10-13 00:00:00.000000', '2024-12-28 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 46, 'Sanke', 411, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Sanke.png', 2, 33),
(180, '2023-01-07 00:00:00.000000', '2023-03-25 00:00:00.000000', 2, 'A beautiful Sanke koi', 0, 45, 'Sanke', 1010, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Showa%205.png', 2, 32);
INSERT INTO `kois` (`id`, `created_at`, `updated_at`, `age`, `description`, `is_display`, `length`, `name`, `base_price`, `sex`, `status`, `thumbnail`, `category_id`, `owner_id`) VALUES
(181, '2024-01-17 00:00:00.000000', '2024-12-16 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 43, 'Sanke', 960, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Sanke%202.png', 2, 26),
(182, '2023-06-23 00:00:00.000000', '2024-06-09 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 46, 'Showa', 540, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Showa%204.png', 3, 29),
(183, '2023-05-31 00:00:00.000000', '2023-12-26 00:00:00.000000', 2, 'A beautiful Showa koi', 0, 57, 'Showa', 680, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Showa%207%20updated%20634.png', 3, 34),
(184, '2024-12-21 00:00:00.000000', '2024-12-23 00:00:00.000000', 2, 'A beautiful Showa koi', 0, 52, 'Showa', 362, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Showa%206.png', 3, 33),
(185, '2023-03-09 00:00:00.000000', '2024-10-10 00:00:00.000000', 2, 'A beautiful Tancho Sanke koi', 0, 48, 'Tancho Sanke', 1400, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Tancho%20Showa%20updated%20636.png', 2, 36),
(186, '2023-07-18 00:00:00.000000', '2024-08-01 00:00:00.000000', 2, 'A beautiful Ginrin Karashigoi koi', 1, 34, 'Ginrin Karashigoi', 140, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Chagoi%204.png', 6, 32),
(187, '2024-07-30 00:00:00.000000', '2024-12-20 00:00:00.000000', 2, 'A beautiful Ginrin Karashigoi koi', 1, 36, 'Ginrin Karashigoi', 210, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Chagoi%202%205.png', 15, 26),
(188, '2023-08-27 00:00:00.000000', '2024-09-24 00:00:00.000000', 2, 'A beautiful Ginrin Hi Utsuri koi', 1, 61, 'Ginrin Hi Utsuri', 722, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Gin%20Rin%20Hi%20Utsuri%20Female%20......%2061cm.png', 4, 25),
(189, '2023-02-28 00:00:00.000000', '2024-12-01 00:00:00.000000', 2, 'A beautiful Ginrin Ki Matsuba koi', 1, 56, 'Ginrin Ki Matsuba', 178, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Gin%20Rin%20Ki%20Matsuba%20Female%20Nisai%2056cm.png', 13, 36),
(190, '2023-03-17 00:00:00.000000', '2023-12-28 00:00:00.000000', 2, 'A beautiful Ginrin Kohaku koi', 0, 48, 'Ginrin Kohaku', 938, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Gin%20Rin%20Kohaku%20Female%20Nisai%2048cm.png', 1, 33),
(191, '2023-02-28 00:00:00.000000', '2023-09-04 00:00:00.000000', 2, 'A beautiful Ginrin Showa koi', 0, 51, 'Ginrin Showa', 680, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Gin%20Rin%20Showa%202%20Female%20Nisai%2051cm.png', 3, 24),
(192, '2023-10-04 00:00:00.000000', '2024-05-09 00:00:00.000000', 2, 'A beautiful Ginrin Showa koi', 0, 48, 'Ginrin Showa', 680, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Gin%20Rin%20Showa%203%20Female%20Nisai%2048cm.png', 3, 36),
(193, '2024-12-14 00:00:00.000000', '2024-12-21 00:00:00.000000', 2, 'A beautiful Ginrin Hi Utsuri koi', 0, 50, 'Ginrin Hi Utsuri', 680, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/HI%20Utsuri%20Female%20Nisai%20...2cm.png', 4, 28),
(194, '2024-06-03 00:00:00.000000', '2024-09-02 00:00:00.000000', 2, 'A beautiful Hi Utsuri koi', 1, 56, 'Hi Utsuri', 659, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/photos/Hi%20Utsuri%20Female%20Nisai%2056cm%20646.png', 4, 33),
(195, '2024-06-19 00:00:00.000000', '2024-10-03 00:00:00.000000', 2, 'A beautiful Ki Utsuri koi', 1, 56, 'Ki Utsuri', 680, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Ki%20Utsuri%20Female%20Naisai%2056cm.png', 4, 36),
(196, '2024-04-17 00:00:00.000000', '2024-07-31 00:00:00.000000', 2, 'A beautiful Kin Hi Utsuri koi', 0, 62, 'Kin Hi Utsuri', 680, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Kin%20%20Hi%20Utsuri%20Female%20Nisai%2062cm.png', 4, 27),
(197, '2023-08-23 00:00:00.000000', '2024-02-16 00:00:00.000000', 2, 'A beautiful Kohaku koi', 0, 52, 'Kohaku', 680, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Kohaku%20Female%20Nisai%2052cm.png', 1, 27),
(198, '2023-05-30 00:00:00.000000', '2024-05-30 00:00:00.000000', 2, 'A beautiful Kujaku koi', 1, 51, 'Kujaku', 680, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Kujaku%20Female%20Nisai%2051cm.png', 7, 34),
(199, '2023-04-26 00:00:00.000000', '2024-01-24 00:00:00.000000', 2, 'A beautiful Ochiba koi', 1, 55, 'Ochiba', 680, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Ochiba%20Female%20Nisai%2055cm.png', 8, 36),
(200, '2023-12-03 00:00:00.000000', '2024-09-17 00:00:00.000000', 2, 'A beautiful Ogana Ochiba koi', 0, 58, 'Ogana Ochiba', 680, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Ogona%20Ochiba%20Female%20Nisai%2058cm.png', 11, 35),
(201, '2024-02-16 00:00:00.000000', '2024-06-14 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 50, 'Showa', 680, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Showa%20Female%20Nisai%2050cm.png', 3, 29),
(202, '2024-09-10 00:00:00.000000', '2024-11-13 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 53, 'Showa', 680, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Showa%20Female%20Nisai%2053cm.png', 3, 34),
(203, '2024-09-13 00:00:00.000000', '2024-12-06 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 58, 'Showa', 750, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Showa%20Female%20Nisai%2058cm.png', 3, 26),
(204, '2024-08-26 00:00:00.000000', '2024-12-30 00:00:00.000000', 2, 'A beautiful Ginrin Karashigoi koi', 0, 56, 'Ginrin Karashigoi', 213, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Yamibuki%20Female%20Nisai%2056cm.png', 18, 29),
(205, '2023-11-23 00:00:00.000000', '2024-05-12 00:00:00.000000', 2, 'A beautiful Aka Matsuba koi', 0, 51, 'Aka Matsuba', 680, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Aka%20Matsuba.png', 2, 24),
(206, '2023-03-22 00:00:00.000000', '2023-12-15 00:00:00.000000', 2, 'A beautiful Ginrin Soragoi koi', 1, 38, 'Ginrin Soragoi', 971, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/1%20Ginrin%20Soragoi%2038cm%20edited.png', 15, 27),
(207, '2023-12-06 00:00:00.000000', '2024-09-18 00:00:00.000000', 2, 'A beautiful Ai Goromo koi', 1, 37, 'Ai Goromo', 217, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/2%20Koromo%2037cm%20edited.png', 6, 28),
(208, '2023-02-25 00:00:00.000000', '2024-03-30 00:00:00.000000', 2, 'A beautiful Hi Utsuri koi', 1, 38, 'Hi Utsuri', 899, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/3%20Hi%20Utsuri%2038cm%20edited.png', 4, 35),
(209, '2023-09-16 00:00:00.000000', '2024-11-11 00:00:00.000000', 2, 'A beautiful Ochiba koi', 0, 34, 'Ochiba', 954, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/5%20Ochiba%2034cm%20edited.png', 16, 28),
(210, '2024-01-28 00:00:00.000000', '2024-06-23 00:00:00.000000', 2, 'A beautiful Kin Ki Utsuri koi', 1, 45, 'Kin Ki Utsuri', 485, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/6%20Kin%20Ki%20Utsuri%2045cm%20edited.png', 4, 25),
(211, '2023-07-14 00:00:00.000000', '2023-10-28 00:00:00.000000', 2, 'A beautiful Ginrin Ochiba koi', 0, 35, 'Ginrin Ochiba', 293, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/7%20Ginrin%20Ochiba%2035cm%20edited.png', 16, 33),
(212, '2024-05-01 00:00:00.000000', '2024-12-20 00:00:00.000000', 2, 'A beautiful Kin Showa koi', 0, 33, 'Kin Showa', 210, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/8%20Kin%20Showa%2033cm%20edited.png', 3, 36),
(213, '2023-02-14 00:00:00.000000', '2023-11-14 00:00:00.000000', 2, 'A beautiful Tancho Goshiki koi', 1, 33, 'Tancho Goshiki', 720, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/4%20Tancho%20Goshiki%2033cm%20edited.png', 11, 24),
(214, '2024-07-18 00:00:00.000000', '2024-09-27 00:00:00.000000', 2, 'A beautiful Ginrin Goshiki koi', 1, 31, 'Ginrin Goshiki', 195, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/9%20Ginrin%20Goshiki%2031cm%20edited.png', 10, 34),
(215, '2023-08-16 00:00:00.000000', '2023-10-02 00:00:00.000000', 2, 'A beautiful Ai Goromo koi', 0, 39, 'Ai Goromo', 418, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/10%20Koromo%2039cm%20edited.png', 8, 33),
(216, '2023-03-22 00:00:00.000000', '2023-10-04 00:00:00.000000', 2, 'A beautiful Ginrin Chagoi koi', 1, 36, 'Ginrin Chagoi', 619, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/11%20Ginrin%20Chagoi%2036cm%20edited.png', 4, 37),
(217, '2024-07-31 00:00:00.000000', '2024-08-19 00:00:00.000000', 2, 'A beautiful Tancho Goshiki koi', 1, 32, 'Tancho Goshiki', 920, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/12%20Tancho%20Goshiki%20Edited.png', 11, 35),
(218, '2023-05-18 00:00:00.000000', '2023-12-25 00:00:00.000000', 2, 'A beautiful Ginrin Goshiki koi', 1, 35, 'Ginrin Goshiki', 430, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/13%20Ginrin%20Goshiki%2035cm%20edited.png', 8, 32),
(219, '2024-03-29 00:00:00.000000', '2024-07-16 00:00:00.000000', 2, 'A beautiful Kikusui koi', 1, 35, 'Kikusui', 210, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/14%20Kikusui%2035cm%20edited.png', 15, 33),
(220, '2023-11-26 00:00:00.000000', '2024-08-01 00:00:00.000000', 2, 'A beautiful Hi Utsuri koi', 0, 38, 'Hi Utsuri', 870, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/15%20Hi%20Utsuri%2038cm%20edited.png', 4, 26),
(221, '2024-11-23 00:00:00.000000', '2024-12-21 00:00:00.000000', 2, 'A beautiful Ochiba koi', 0, 38, 'Ochiba', 210, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/16%20Ochiba%2038cm%20edited.png', 8, 29),
(222, '2024-09-21 00:00:00.000000', '2024-11-20 00:00:00.000000', 2, 'A beautiful Tancho Goshiki koi', 1, 30, 'Tancho Goshiki', 417, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/17%20Tancho%20Goshiki%2030cm%20edited.png', 11, 34),
(223, '2023-07-01 00:00:00.000000', '2024-12-08 00:00:00.000000', 2, 'A beautiful Goshiki koi', 1, 36, 'Goshiki', 779, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/18%20Goshiki%2036cm%20edited.png', 20, 28),
(224, '2024-05-16 00:00:00.000000', '2024-06-08 00:00:00.000000', 2, 'A beautiful Goshiki koi', 0, 33, 'Goshiki', 657, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/19%20Gohiski%2033cm%20edited.png', 16, 33),
(225, '2024-06-08 00:00:00.000000', '2024-09-26 00:00:00.000000', 2, 'A beautiful Goshiki koi', 1, 37, 'Goshiki', 932, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/20%20Goshiki%2037cm%20edited.png', 16, 32),
(226, '2023-12-15 00:00:00.000000', '2024-03-01 00:00:00.000000', 2, 'A beautiful Goshiki koi', 0, 48, 'Goshiki', 217, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/21%20Goshiki%2048cm%20edited.png', 9, 25),
(227, '2024-03-07 00:00:00.000000', '2024-12-29 00:00:00.000000', 3, 'A beautiful Ginrin Ochiba koi', 1, 53, 'Ginrin Ochiba', 2000, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Gin%20Rin%20Ochiba%2053cm%20Tank%204%205.png', 13, 35),
(228, '2023-06-30 00:00:00.000000', '2023-07-08 00:00:00.000000', 3, 'A beautiful Doitsu Showa koi', 0, 55, 'Doitsu Showa', 2500, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Doitsu%20Showa%2055cm%20Tank%204%205.png', 3, 35),
(229, '2024-11-18 00:00:00.000000', '2024-12-01 00:00:00.000000', 3, 'A beautiful Showa koi', 0, 47, 'Showa', 1000, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Showa%2067cm%20Tank%204%205.png', 3, 31),
(230, '2023-07-29 00:00:00.000000', '2024-03-08 00:00:00.000000', 3, 'A beautiful Maruten Showa koi', 1, 67, 'Maruten Showa', 2500, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Maruten%20Showa%2067cm%20Tank%204%205.png', 3, 28),
(231, '2024-06-24 00:00:00.000000', '2024-09-18 00:00:00.000000', 3, 'A beautiful Kujaku koi', 1, 70, 'Kujaku', 370, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Kujaku%2070cm%20Tank%204%205.png', 15, 30),
(232, '2024-04-04 00:00:00.000000', '2024-09-24 00:00:00.000000', 3, 'A beautiful Sanke koi', 0, 58, 'Sanke', 493, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Sanke%2058cm%20Tank%204%205.png', 2, 31),
(233, '2023-01-01 00:00:00.000000', '2023-04-15 00:00:00.000000', 2, 'A beautiful Hi Utsuri koi', 0, 51, 'Hi Utsuri', 238, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Hi%20Utsuri%2051cm%20Tank%204%205%202.0.png', 4, 35),
(234, '2023-12-25 00:00:00.000000', '2024-09-26 00:00:00.000000', 3, 'A beautiful Sakura Ogon koi', 0, 55, 'Sakura Ogon', 349, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Sakura%20Ogon%2055cm%20Tank%204%205.png', 17, 29),
(235, '2023-08-03 00:00:00.000000', '2024-05-25 00:00:00.000000', 3, 'A beautiful Shiro Utsuri koi', 1, 49, 'Shiro Utsuri', 369, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Shiro%20Utsuri%2049cm%20Tank%204%205.png', 4, 28),
(236, '2023-07-04 00:00:00.000000', '2023-07-27 00:00:00.000000', 3, 'A beautiful Tancho Showa koi', 1, 70, 'Tancho Showa', 717, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Tancho%20Showa%2070cm%20Tank%204%205%202.0.png', 3, 33),
(237, '2023-08-25 00:00:00.000000', '2024-09-09 00:00:00.000000', 2, 'A beautiful Hi Utsuri koi', 0, 35, 'Hi Utsuri', 150, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/11/photos/Hi%20Utsuri%2035cm%20Tank%206.png', 4, 27),
(238, '2023-03-25 00:00:00.000000', '2024-07-22 00:00:00.000000', 2, 'A beautiful Yellow Monkey koi', 1, 27, 'Yellow Monkey', 348, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/11/photos/Karashigoi%2027cm%20Tank%206.png', 17, 35),
(239, '2023-10-14 00:00:00.000000', '2024-01-01 00:00:00.000000', 2, 'A beautiful Kohaku koi', 0, 25, 'Kohaku', 100, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/11/photos/Kohaku%2025cm%20Tank%206%201.2.png', 1, 27),
(240, '2024-03-26 00:00:00.000000', '2024-10-21 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 35, 'Sanke', 200, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/11/photos/Sanke%2035cm%20Tank%206%201.2.png', 2, 37),
(241, '2024-09-28 00:00:00.000000', '2024-11-23 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 0, 28, 'Shiro Utsuri', 357, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/11/photos/Shiro%20Utsuri%2028cm%20Tank%206.png', 4, 36),
(242, '2023-04-21 00:00:00.000000', '2024-04-26 00:00:00.000000', 2, 'A beautiful Sanke koi', 0, 41, 'Sanke', 275, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/12/photos/Sanke%2041cm%20Tank%206%201.4.png', 2, 28),
(243, '2023-08-19 00:00:00.000000', '2024-02-09 00:00:00.000000', 2, 'A beautiful Kohaku koi', 0, 30, 'Kohaku', 733, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/12/photos/Kohaku%2030cm%20Tank%206%201.3.png', 1, 28),
(244, '2024-07-15 00:00:00.000000', '2024-10-18 00:00:00.000000', 2, 'A beautiful Ginrin Kohaku koi', 1, 22, 'Ginrin Kohaku', 870, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/13/photos/Gin-Rin%20Kohaku%2022cm%201.2.png', 1, 33),
(245, '2024-06-08 00:00:00.000000', '2024-08-18 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 35, 'Sanke', 665, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/13/photos/Sanke%2035cm%20Tank%206%202.5.png', 2, 34),
(246, '2023-06-06 00:00:00.000000', '2023-10-31 00:00:00.000000', 2, 'A beautiful Showa koi', 0, 36, 'Showa', 304, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/14/photos/Showa%2036cm.png', 3, 26),
(247, '2024-01-18 00:00:00.000000', '2024-02-12 00:00:00.000000', 2, 'A beautiful Yellow Monkey koi', 0, 36, 'Yellow Monkey', 549, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/14/photos/Yellow%20Monkey%20yellow%2036cm.png', 15, 37),
(248, '2024-07-16 00:00:00.000000', '2024-12-25 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 36, 'Sanke', 150, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/14/photos/Sanke%2036cm0.png', 2, 35),
(249, '2024-01-19 00:00:00.000000', '2024-10-10 00:00:00.000000', 2, 'A beautiful Yellow Monkey koi', 1, 36, 'Yellow Monkey', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/15/photos/Yellow%20Monkey%20orange%2036cm.png', 4, 33),
(250, '2023-09-12 00:00:00.000000', '2023-10-26 00:00:00.000000', 3, 'A beautiful Ai Goromo koi', 1, 43, 'Ai Goromo', 109, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/15/photos/Ai%20Goromo%2041cm.png', 19, 36),
(251, '2024-10-23 00:00:00.000000', '2024-10-31 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 35, 'Kohaku', 686, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/15/photos/AJ.png', 1, 33),
(252, '2024-03-21 00:00:00.000000', '2024-10-29 00:00:00.000000', 2, 'A beautiful Showa koi', 0, 44, 'Showa', 914, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/16/photos/Showa%2044cm.png', 3, 30),
(253, '2024-02-17 00:00:00.000000', '2024-07-18 00:00:00.000000', 2, 'A beautiful Hi Utsuri koi', 1, 38, 'Hi Utsuri', 651, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/16/photos/Hi%20Utsuri%2038cm.png', 4, 25),
(254, '2024-03-28 00:00:00.000000', '2024-12-08 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 38, 'Kohaku', 265, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/16/photos/Kohaku%2038cm.png', 1, 33),
(255, '2024-02-19 00:00:00.000000', '2024-12-15 00:00:00.000000', 3, 'A beautiful Red Karashigoi koi', 0, 64, 'Red Karashigoi', 1000, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/17/photos/Red%20Karashigoi%2064cm2.png', 11, 35),
(256, '2024-04-20 00:00:00.000000', '2024-09-06 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 32, 'Sanke', 100, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/17/photos/Sanke%2032cm.png', 2, 24),
(257, '2024-08-08 00:00:00.000000', '2024-12-21 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 0, 27, 'Shiro Utsuri', 735, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/17/photos/Shiro%20Utsuri%2027cm.png', 4, 27),
(258, '2023-03-22 00:00:00.000000', '2023-09-25 00:00:00.000000', 2, 'A beautiful Sanke koi', 0, 37, 'Sanke', 150, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/18/photos/Sanke%2037cm.png', 2, 27),
(259, '2023-11-16 00:00:00.000000', '2023-12-10 00:00:00.000000', 3, 'A beautiful Doitsu Aragoke Black Diamond koi', 0, 51, 'Doitsu Aragoke Black Diamond', 500, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/18/photos/Aragoke%20Doitsu%20Black%20Diamond%2051cm.png', 6, 32),
(260, '2024-07-31 00:00:00.000000', '2024-08-17 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 40, 'Showa', 255, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/18/photos/Showa%2040cm.png', 3, 24),
(261, '2023-12-15 00:00:00.000000', '2024-07-10 00:00:00.000000', 2, 'A beautiful Beni Kumonryu koi', 0, 34, 'Beni Kumonryu', 250, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/19/photos/Beni%20Kumonryu%2034cm.png', 19, 34),
(262, '2024-11-18 00:00:00.000000', '2024-12-20 00:00:00.000000', 2, 'A beautiful Ai Goromo koi', 0, 37, 'Ai Goromo', 300, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/19/photos/Ai%20Goromo%2037cm2%20no%20beni%20kumonryu.png', 11, 27),
(263, '2023-03-17 00:00:00.000000', '2024-07-29 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 1, 30, 'Shiro Utsuri', 150, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/19/photos/Shiro%20Utsuri%2030cm.png', 4, 34),
(264, '2024-05-17 00:00:00.000000', '2024-09-26 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 45, 'Showa', 701, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/20/photos/Showa%2045cm0.png', 3, 35),
(265, '2024-06-14 00:00:00.000000', '2024-10-28 00:00:00.000000', 3, 'A beautiful Black Diamond koi', 1, 40, 'Black Diamond', 526, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/20/photos/Black%20Diamond%2040cm.png', 13, 30),
(266, '2023-02-07 00:00:00.000000', '2024-11-08 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 35, 'Sanke', 150, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/20/photos/Sanke%2035cm.png', 2, 28),
(267, '2023-11-24 00:00:00.000000', '2024-11-20 00:00:00.000000', 3, 'A beautiful Kohaku koi', 1, 41, 'Kohaku', 200, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/21/photos/Kohaku%2041.png', 1, 24),
(268, '2024-06-13 00:00:00.000000', '2024-08-14 00:00:00.000000', 2, 'A beautiful Doitsu Aka Matsuba koi', 1, 37, 'Doitsu Aka Matsuba', 250, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/21/photos/Doitsu%20Aka%20Matsuba%2037cm.png', 1, 28),
(269, '2023-10-19 00:00:00.000000', '2024-06-04 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 36, 'Showa', 202, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/21/photos/Showa%2036.png', 3, 24),
(270, '2024-12-28 00:00:00.000000', '2024-12-28 00:00:00.000000', 2, 'A beautiful Showa koi', 0, 35, 'Showa', 254, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/22/photos/Showa%2035cm.png', 3, 30),
(271, '2024-08-26 00:00:00.000000', '2024-12-29 00:00:00.000000', 2, 'A beautiful Ginrin Chagoi koi', 1, 37, 'Ginrin Chagoi', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/22/photos/gin-rin%20chagoi%2037cm.png', 15, 37),
(272, '2023-04-20 00:00:00.000000', '2023-08-22 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 0, 30, 'Shiro Utsuri', 336, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/22/photos/Shiro%20UTsuri%2030cm.png', 4, 35),
(273, '2023-09-21 00:00:00.000000', '2024-10-02 00:00:00.000000', 2, 'A beautiful Kohaku koi', 0, 25, 'Kohaku', 100, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/23/photos/Kohaku%2025cm%20Tank%206%201.2.png', 1, 28),
(274, '2024-07-21 00:00:00.000000', '2024-08-01 00:00:00.000000', 2, 'A beautiful Yellow Monkey koi', 1, 36, 'Yellow Monkey', 252, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/23/photos/Yellow%20Monkey%20orange%2036cm.png', 14, 28),
(275, '2024-08-23 00:00:00.000000', '2024-11-17 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 36, 'Sanke', 719, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/23/photos/Sanke%2036cm0.png', 2, 31),
(276, '2024-07-01 00:00:00.000000', '2024-11-22 00:00:00.000000', 2, 'A beautiful Hi Utsuri koi', 0, 35, 'Hi Utsuri', 150, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/24/photos/Hi%20Utsuri%2035cm%20Tank%206.png', 4, 34),
(277, '2023-09-14 00:00:00.000000', '2024-05-20 00:00:00.000000', 2, 'A beautiful Ai Goromo koi', 1, 37, 'Ai Goromo', 103, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/24/photos/Ai%20Goromo%2037cm2%20no%20beni%20kumonryu.png', 3, 34),
(278, '2023-06-17 00:00:00.000000', '2024-05-03 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 1, 30, 'Shiro Utsuri', 892, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/24/photos/Shiro%20Utsuri%2030cm.png', 4, 34),
(279, '2024-05-05 00:00:00.000000', '2024-11-01 00:00:00.000000', 3, 'A beautiful Kohaku koi', 0, 41, 'Kohaku', 348, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/25/photos/Kohaku%2041.png', 1, 36),
(280, '2024-04-05 00:00:00.000000', '2024-07-13 00:00:00.000000', 2, 'A beautiful Beni Kumonryu koi', 0, 34, 'Beni Kumonryu', 727, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/25/photos/Beni%20Kumonryu%2034cm.png', 19, 36),
(281, '2024-03-03 00:00:00.000000', '2024-05-10 00:00:00.000000', 3, 'A beautiful Red Karashigoi koi', 1, 64, 'Red Karashigoi', 1000, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/25/photos/Red%20Karashigoi%2064cm2.png', 5, 32),
(282, '2024-10-07 00:00:00.000000', '2024-10-18 00:00:00.000000', 2, 'A beautiful Showa koi', 0, 40, 'Showa', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/26/photos/Showa%2040cm.png', 3, 28),
(283, '2023-04-07 00:00:00.000000', '2024-10-27 00:00:00.000000', 2, 'A beautiful Yellow Monkey koi', 1, 35, 'Yellow Monkey', 705, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/26/photos/Yellow%20Monkey%2035cm.png', 5, 26),
(284, '2024-02-15 00:00:00.000000', '2024-11-03 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 0, 26, 'Shiro Utsuri', 715, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/26/photos/Shiro%20Utsuri%2026cm.png', 4, 26),
(285, '2024-09-25 00:00:00.000000', '2024-11-09 00:00:00.000000', 2, 'A beautiful Ai Goromo koi', 1, 43, 'Ai Goromo', 164, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/27/photos/Ai%20Goromo%2043cm.png', 9, 31),
(286, '2023-03-30 00:00:00.000000', '2024-09-01 00:00:00.000000', 3, 'A beautiful Black Diamond koi', 0, 40, 'Black Diamond', 535, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/27/photos/Black%20Diamond%2040cm.png', 8, 31),
(287, '2024-12-27 00:00:00.000000', '2024-12-30 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 41, 'Sanke', 619, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/27/photos/Sanke%2041cm.png', 2, 24),
(288, '2023-09-27 00:00:00.000000', '2024-06-17 00:00:00.000000', 2, 'A beautiful Showa koi', 0, 35, 'Showa', 350, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/28/photos/Showa%2035cm.png', 3, 31),
(289, '2024-01-23 00:00:00.000000', '2024-04-27 00:00:00.000000', 2, 'A beautiful Yellow Monkey koi', 1, 32, 'Yellow Monkey', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/28/photos/Yellow%20Monkey%2032cm.png', 2, 33),
(290, '2024-08-07 00:00:00.000000', '2024-11-20 00:00:00.000000', 2, 'A beautiful Sanke koi', 0, 39, 'Sanke', 317, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/28/photos/Sanke%2039cm.png', 2, 37),
(291, '2024-09-06 00:00:00.000000', '2024-12-26 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 40, 'Showa', 565, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/29/photos/Showa%2040cm.png', 3, 27),
(292, '2023-07-18 00:00:00.000000', '2024-12-02 00:00:00.000000', 2, 'A beautiful Yellow Monkey koi', 0, 32, 'Yellow Monkey', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/29/photos/Yellow%20Monkey%2032cm.png', 10, 31),
(293, '2023-10-12 00:00:00.000000', '2023-10-15 00:00:00.000000', 2, 'A beautiful Kohaku koi', 0, 25, 'Kohaku', 100, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/29/photos/Kohaku%2025cm%20Tank%206%201.2.png', 1, 36),
(294, '2024-09-19 00:00:00.000000', '2024-11-30 00:00:00.000000', 2, 'A beautiful Hi Utsuri koi', 0, 35, 'Hi Utsuri', 419, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/30/photos/Hi%20Utsuri%2035cm%20Tank%206.png', 4, 36),
(295, '2023-11-20 00:00:00.000000', '2024-04-01 00:00:00.000000', 3, 'A beautiful Asagi koi', 0, 46, 'Asagi', 642, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/30/photos/Asgai%2046cm.png', 8, 31),
(296, '2024-11-29 00:00:00.000000', '2024-12-09 00:00:00.000000', 2, 'A beautiful Doitsu Aka Matsuba koi', 1, 37, 'Doitsu Aka Matsuba', 250, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/30/photos/Doitsu%20Aka%20Matsuba%2037cm.png', 7, 27),
(297, '2024-11-10 00:00:00.000000', '2024-12-09 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 35, 'Sanke', 150, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/20/photos/Sanke%2035cm.png', 2, 28),
(298, '2024-11-13 00:00:00.000000', '2024-12-11 00:00:00.000000', 2, 'A beautiful Showa koi', 0, 35, 'Showa', 350, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/28/photos/Showa%2035cm.png', 3, 34),
(299, '2024-01-19 00:00:00.000000', '2024-11-12 00:00:00.000000', 2, 'A beautiful Ginrin Chagoi koi', 0, 37, 'Ginrin Chagoi', 300, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/22/photos/gin-rin%20chagoi%2037cm.png', 17, 32),
(300, '2023-06-03 00:00:00.000000', '2024-03-16 00:00:00.000000', 3, 'A beautiful Black Diamond koi', 1, 42, 'Black Diamond', 388, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/20/photos/Black%20Diamond%2040cm.png', 16, 26),
(301, '2023-07-01 00:00:00.000000', '2024-08-23 00:00:00.000000', 3, 'A beautiful Sanke koi', 0, 42, 'Sanke', 134, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/32/photos/Sanke%2042cm.png', 2, 34),
(302, '2023-04-22 00:00:00.000000', '2024-03-10 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 1, 32, 'Shiro Utsuri', 786, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/32/photos/Shiro%20Utsuri%2032cm.png', 4, 24),
(303, '2023-07-08 00:00:00.000000', '2024-11-14 00:00:00.000000', 3, 'A beautiful Hi Utsuri koi', 1, 44, 'Hi Utsuri', 200, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/33/photos/Hi%20Utsuri%2044cm.png', 4, 31),
(304, '2024-03-27 00:00:00.000000', '2024-04-28 00:00:00.000000', 2, 'A beautiful Yellow Monkey koi', 1, 28, 'Yellow Monkey', 300, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/33/photos/red%20Yellow%20Monkey%2028cm.png', 13, 26),
(305, '2024-01-06 00:00:00.000000', '2024-05-25 00:00:00.000000', 2, 'A beautiful Sanke koi', 0, 37, 'Sanke', 150, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/18/photos/Sanke%2037cm.png', 2, 32),
(306, '2024-07-30 00:00:00.000000', '2024-09-06 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 33, 'Sanke', 100, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/17/photos/Sanke%2032cm.png', 2, 26),
(307, '2023-10-11 00:00:00.000000', '2024-11-14 00:00:00.000000', 2, 'A beautiful Yellow Monkey koi', 0, 32, 'Yellow Monkey', 348, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/14/photos/Yellow%20Monkey%20yellow%2036cm.png', 16, 26),
(308, '2023-12-15 00:00:00.000000', '2024-07-11 00:00:00.000000', 2, 'A beautiful Ai Goromo koi', 0, 42, 'Ai Goromo', 200, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/34/photos/Ai%20Goromo%2042cm.png', 4, 26),
(309, '2023-05-28 00:00:00.000000', '2024-05-04 00:00:00.000000', 3, 'A beautiful Red Karashigoi koi', 0, 64, 'Red Karashigoi', 1000, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/17/photos/Red%20Karashigoi%2064cm2.png', 9, 24),
(310, '2024-05-16 00:00:00.000000', '2024-08-30 00:00:00.000000', 2, 'A beautiful Black Diamond koi', 0, 32, 'Black Diamond', 186, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/35/photos/Black%20Diamond%2032cm.png', 17, 29),
(311, '2024-12-22 00:00:00.000000', '2024-12-29 00:00:00.000000', 2, 'A beautiful Showa koi', 0, 37, 'Showa', 350, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/35/photos/Showa%2037cm.png', 3, 34),
(312, '2024-02-14 00:00:00.000000', '2024-08-06 00:00:00.000000', 3, 'A beautiful Showa koi', 0, 43, 'Showa', 300, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/36/photos/Showa%2043cm.png', 3, 31),
(313, '2024-07-13 00:00:00.000000', '2024-10-31 00:00:00.000000', 2, 'A beautiful Ginrin Chagoi koi', 0, 41, 'Ginrin Chagoi', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/36/photos/Gin-Rin%20Chagoi%2041cm0.png', 10, 36),
(314, '2023-06-19 00:00:00.000000', '2024-07-21 00:00:00.000000', 2, 'A beautiful Kujaku koi', 1, 34, 'Kujaku', 300, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/36/photos/Kujaku%2034cm.png', 16, 24),
(315, '2024-06-08 00:00:00.000000', '2024-08-25 00:00:00.000000', 2, 'A beautiful Ai Goromo koi', 1, 40, 'Ai Goromo', 300, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/37/photos/Ai%20Goromo%2040cm.png', 20, 30),
(316, '2023-06-22 00:00:00.000000', '2024-09-03 00:00:00.000000', 2, 'A beautiful Black Diamond koi', 0, 36, 'Black Diamond', 300, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/37/photos/Black%20Diamond%2036cm.png', 19, 36),
(317, '2023-08-11 00:00:00.000000', '2024-01-01 00:00:00.000000', 2, 'A beautiful Ginrin Showa koi', 0, 34, 'Ginrin Showa', 450, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/37/photos/Gin-Rin%20Showa%2034cm.png', 3, 33),
(318, '2023-09-11 00:00:00.000000', '2024-09-13 00:00:00.000000', 2, 'A beautiful Black Diamond koi', 0, 40, 'Black Diamond', 300, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/27/photos/Black%20Diamond%2040cm.png', 6, 28),
(319, '2023-03-14 00:00:00.000000', '2024-01-07 00:00:00.000000', 3, 'A beautiful Sanke koi', 0, 52, 'Sanke', 500, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/38/photos/Showa%2052cm.png', 2, 34),
(320, '2024-07-11 00:00:00.000000', '2024-08-30 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 1, 27, 'Shiro Utsuri', 150, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/38/photos/Shiro%20Utsuri%2027cm.png', 4, 26),
(321, '2024-04-17 00:00:00.000000', '2024-06-13 00:00:00.000000', 2, 'A beautiful Black Diamond koi', 0, 34, 'Black Diamond', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/35/photos/Black%20Diamond%2032cm.png', 19, 33),
(322, '2023-05-27 00:00:00.000000', '2023-05-27 00:00:00.000000', 2, 'A beautiful Ai Goromo koi', 0, 42, 'Ai Goromo', 200, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/34/photos/Ai%20Goromo%2042cm.png', 5, 27),
(323, '2024-06-22 00:00:00.000000', '2024-08-28 00:00:00.000000', 2, 'A beautiful Ginrin Chagoi koi', 0, 37, 'Ginrin Chagoi', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/22/photos/gin-rin%20chagoi%2037cm.png', 6, 29),
(324, '2023-08-06 00:00:00.000000', '2024-04-17 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 35, 'Sanke', 150, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/18/photos/Sanke%2037cm.png', 2, 24),
(325, '2024-07-14 00:00:00.000000', '2024-12-02 00:00:00.000000', 2, 'A beautiful Doitsu Aka Matsuba koi', 0, 37, 'Doitsu Aka Matsuba', 250, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/21/photos/Doitsu%20Aka%20Matsuba%2037cm.png', 16, 29),
(326, '2023-11-21 00:00:00.000000', '2024-05-24 00:00:00.000000', 2, 'A beautiful Black Diamond koi', 1, 38, 'Black Diamond', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/20/photos/Black%20Diamond%2040cm.png', 3, 25),
(327, '2023-01-16 00:00:00.000000', '2024-08-10 00:00:00.000000', 2, 'A beautiful Kohaku koi', 0, 26, 'Kohaku', 100, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/11/photos/Kohaku%2025cm%20Tank%206%201.2.png', 1, 25),
(328, '2023-12-30 00:00:00.000000', '2024-01-14 00:00:00.000000', 3, 'A beautiful Hi Utsuri koi', 0, 44, 'Hi Utsuri', 999, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/33/photos/Hi%20Utsuri%2044cm.png', 4, 24),
(329, '2024-07-19 00:00:00.000000', '2024-10-18 00:00:00.000000', 2, 'A beautiful Yellow Monkey koi', 0, 35, 'Yellow Monkey', 352, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/14/photos/Yellow%20Monkey%20yellow%2036cm.png', 7, 30),
(330, '2023-10-07 00:00:00.000000', '2024-07-30 00:00:00.000000', 3, 'A beautiful Showa koi', 0, 43, 'Showa', 948, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/36/photos/Showa%2043cm.png', 3, 26),
(331, '2024-08-06 00:00:00.000000', '2024-08-24 00:00:00.000000', 2, 'A beautiful Kujaku koi', 1, 34, 'Kujaku', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/36/photos/Kujaku%2034cm.png', 7, 35),
(332, '2024-10-27 00:00:00.000000', '2024-11-09 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 35, 'Sanke', 150, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/20/photos/Sanke%2035cm.png', 2, 29),
(333, '2024-08-23 00:00:00.000000', '2024-12-21 00:00:00.000000', 2, 'A beautiful Doitsu Maruten Sanke koi', 0, 38, 'Doitsu Maruten Sanke', 300, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/43/photos/Doitsu%20Sanke%2038cm.png', 2, 26),
(334, '2024-03-04 00:00:00.000000', '2024-07-14 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 1, 37, 'Shiro Utsuri', 580, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/43/photos/Shiro%20Utsuri%2037cm.png', 4, 34),
(335, '2024-04-24 00:00:00.000000', '2024-11-03 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 25, 'Showa', 135, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/43/photos/Showa%2025cm.png', 3, 31),
(336, '2023-01-03 00:00:00.000000', '2023-09-08 00:00:00.000000', 2, 'A beautiful Hi Utsuri koi', 0, 37, 'Hi Utsuri', 239, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/44/photos/Hi%20Utsuri%2037cm.png', 4, 30),
(337, '2023-12-15 00:00:00.000000', '2024-04-01 00:00:00.000000', 2, 'A beautiful Kujaku koi', 1, 39, 'Kujaku', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/44/photos/Kujaku%2039cm.png', 9, 32),
(338, '2023-01-25 00:00:00.000000', '2023-10-23 00:00:00.000000', 2, 'A beautiful Black Diamond koi', 0, 46, 'Black Diamond', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/44/photos/Black%20Diamond%2046cm.png', 11, 37),
(339, '2023-05-04 00:00:00.000000', '2024-08-17 00:00:00.000000', 2, 'A beautiful Kohaku koi', 0, 48, 'Kohaku', 338, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/45/photos/Kohaku%20dot%2048cm.png', 1, 29),
(340, '2024-04-27 00:00:00.000000', '2024-11-09 00:00:00.000000', 2, 'A beautiful Kage Shiro Utsuri koi', 0, 46, 'Kage Shiro Utsuri', 500, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/45/photos/Kage%20Shiro%20Utsuri%2046cm.png', 4, 37),
(341, '2023-11-08 00:00:00.000000', '2024-08-21 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 48, 'Kohaku', 744, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/45/photos/Kohaku%2048cm0.png', 1, 28),
(342, '2023-08-31 00:00:00.000000', '2024-08-19 00:00:00.000000', 3, 'A beautiful Golden Corn koi', 1, 44, 'Golden Corn', 619, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/46/photos/Golden%20Corn%2044cm.png', 8, 27),
(343, '2024-10-16 00:00:00.000000', '2024-12-19 00:00:00.000000', 3, 'A beautiful Showa koi', 1, 52, 'Showa', 1000, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/46/photos/Showa%2052cm.png', 3, 28),
(344, '2024-12-09 00:00:00.000000', '2024-12-16 00:00:00.000000', 3, 'A beautiful Karashigoi koi', 1, 47, 'Karashigoi', 798, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/46/photos/Karashigoi%2047cm.png', 2, 36),
(345, '2024-07-27 00:00:00.000000', '2024-10-25 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 0, 28, 'Shiro Utsuri', 150, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/47/photos/Shiro%20Utsuri%2028cm.png', 4, 31),
(346, '2023-10-30 00:00:00.000000', '2024-11-30 00:00:00.000000', 2, 'A beautiful Showa koi', 0, 44, 'Showa', 360, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/47/photos/Showa%2044cm.png', 3, 35),
(347, '2023-10-07 00:00:00.000000', '2024-03-16 00:00:00.000000', 2, 'A beautiful Yellow Monkey koi', 0, 30, 'Yellow Monkey', 314, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/47/photos/Yellow%20Monkey%2030cm.png', 4, 31),
(348, '2023-05-25 00:00:00.000000', '2024-09-14 00:00:00.000000', 2, 'A beautiful Ginrin Chagoi koi', 0, 34, 'Ginrin Chagoi', 276, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/49/photos/Gin-Rin%20Chagoi%2034cm.png', 19, 36),
(349, '2023-06-01 00:00:00.000000', '2024-12-21 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 0, 35, 'Shiro Utsuri', 602, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/49/photos/Shiro%20Utsuri%2035cm.png', 4, 28),
(350, '2024-03-03 00:00:00.000000', '2024-10-25 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 43, 'Showa', 197, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/49/photos/Showa%2043cm.png', 3, 27),
(351, '2024-02-01 00:00:00.000000', '2024-05-18 00:00:00.000000', 2, 'A beautiful Black Diamond koi', 0, 39, 'Black Diamond', 833, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/48/photos/Black%20Diamond%2039cm.png', 15, 35),
(352, '2023-01-13 00:00:00.000000', '2023-09-04 00:00:00.000000', 2, 'A beautiful Kujaku koi', 0, 40, 'Kujaku', 200, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/48/photos/Kujaku%2040cm.png', 7, 37),
(353, '2024-04-25 00:00:00.000000', '2024-10-30 00:00:00.000000', 2, 'A beautiful Sanke koi', 0, 40, 'Sanke', 424, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/48/photos/Sanke%2040cm.png', 2, 30),
(354, '2024-12-15 00:00:00.000000', '2024-12-19 00:00:00.000000', 3, 'A beautiful Sanke koi', 1, 52, 'Sanke', 500, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/38/photos/Sanke%2052.png', 2, 32),
(355, '2023-10-30 00:00:00.000000', '2024-06-05 00:00:00.000000', 2, 'A beautiful Ai Goromo koi', 0, 42, 'Ai Goromo', 200, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/34/photos/Ai%20Goromo%2042cm.png', 18, 31),
(356, '2023-08-30 00:00:00.000000', '2024-02-20 00:00:00.000000', 2, 'A beautiful Ginrin Chagoi koi', 1, 41, 'Ginrin Chagoi', 828, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/36/photos/Gin-Rin%20Chagoi%2041cm0.png', 19, 24),
(357, '2023-10-16 00:00:00.000000', '2024-12-10 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 1, 27, 'Shiro Utsuri', 150, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/38/photos/Shiro%20Utsuri%2027cm.png', 4, 35),
(358, '2023-04-14 00:00:00.000000', '2024-05-10 00:00:00.000000', 2, 'A beautiful Kujaku koi', 0, 39, 'Kujaku', 300, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/44/photos/Kujaku%2039cm.png', 4, 31),
(359, '2024-12-30 00:00:00.000000', '2024-12-30 00:00:00.000000', 2, 'A beautiful Sanke koi', 0, 40, 'Sanke', 200, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/44/photos/Sanke%2040cm.png', 2, 27),
(360, '2023-01-07 00:00:00.000000', '2023-11-04 00:00:00.000000', 2, 'A beautiful Kage Shiro Utsuri koi', 0, 46, 'Kage Shiro Utsuri', 500, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/45/photos/Kage%20Shiro%20Utsuri%2046cm.png', 4, 34),
(361, '2024-08-08 00:00:00.000000', '2024-10-16 00:00:00.000000', 2, 'A beautiful Doitsu Maruten Sanke koi', 1, 38, 'Doitsu Maruten Sanke', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/43/photos/Doitsu%20Sanke%2038cm.png', 2, 26),
(362, '2024-07-30 00:00:00.000000', '2024-11-20 00:00:00.000000', 2, 'A beautiful Black Diamond koi', 1, 34, 'Black Diamond', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/35/photos/Black%20Diamond%2032cm.png', 6, 31),
(363, '2024-12-03 00:00:00.000000', '2024-12-20 00:00:00.000000', 3, 'A beautiful Red Karashigoi koi', 1, 64, 'Red Karashigoi', 1000, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/25/photos/Red%20Karashigoi%2064cm2.png', 19, 32),
(364, '2024-01-17 00:00:00.000000', '2024-06-14 00:00:00.000000', 2, 'A beautiful Doitsu Aka Matsuba koi', 0, 37, 'Doitsu Aka Matsuba', 609, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/30/photos/Doitsu%20Aka%20Matsuba%2037cm.png', 14, 31);
INSERT INTO `kois` (`id`, `created_at`, `updated_at`, `age`, `description`, `is_display`, `length`, `name`, `base_price`, `sex`, `status`, `thumbnail`, `category_id`, `owner_id`) VALUES
(365, '2023-11-20 00:00:00.000000', '2024-03-24 00:00:00.000000', 2, 'A beautiful Kujaku koi', 0, 34, 'Kujaku', 300, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/36/photos/Kujaku%2034cm.png', 19, 34),
(366, '2023-01-09 00:00:00.000000', '2023-09-27 00:00:00.000000', 2, 'A beautiful Sanke koi', 0, 39, 'Sanke', 344, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/55/photos/Sanke%2039cm.png', 2, 28),
(367, '2024-01-29 00:00:00.000000', '2024-05-20 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 1, 32, 'Shiro Utsuri', 150, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/55/photos/Shiro%20Utsuri%2032cm.png', 4, 30),
(368, '2024-11-18 00:00:00.000000', '2024-12-11 00:00:00.000000', 2, 'A beautiful Ginrin Chagoi koi', 1, 35, 'Ginrin Chagoi', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/55/photos/Gin-Rin%20Chagoi%2035cm.png', 11, 24),
(369, '2023-10-11 00:00:00.000000', '2024-05-11 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 44, 'Sanke', 991, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/56/photos/Sanke%2044cm.png', 2, 25),
(370, '2024-12-22 00:00:00.000000', '2024-12-26 00:00:00.000000', 2, 'A beautiful Chagoi koi', 1, 36, 'Chagoi', 300, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/56/photos/Chagoi%2036cm.png', 9, 31),
(371, '2023-09-30 00:00:00.000000', '2023-10-08 00:00:00.000000', 2, 'A beautiful Shiro Muji koi', 1, 34, 'Shiro Muji', 200, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/56/photos/Shiro%20Muji%2034cm.png', 5, 35),
(372, '2024-12-23 00:00:00.000000', '2024-12-24 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 36, 'Showa', 200, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/57/photos/Showa%2036cm.png', 3, 26),
(373, '2023-04-08 00:00:00.000000', '2024-01-27 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 37, 'Showa', 721, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/57/photos/Showa%2037.png', 3, 28),
(374, '2024-06-10 00:00:00.000000', '2024-09-16 00:00:00.000000', 2, 'A beautiful Showa koi', 0, 43, 'Showa', 250, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/57/photos/Showa%2043cm.png', 3, 24),
(375, '2023-12-16 00:00:00.000000', '2024-05-28 00:00:00.000000', 1, 'A beautiful Orenji Ogon koi', 1, 27, 'Orenji Ogon', 150, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/58/photos/Orenji%20Ogon%2027cm%20F.png', 11, 27),
(376, '2024-08-07 00:00:00.000000', '2024-10-16 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 46, 'Showa', 542, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/58/photos/Showa%2046cm%20F.png', 3, 37),
(377, '2024-02-05 00:00:00.000000', '2024-06-25 00:00:00.000000', 2, 'A beautiful Ginrin Chagoi koi', 1, 33, 'Ginrin Chagoi', 350, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/58/photos/Gin-Rin%20Chagoi%2033cm%20F.png', 2, 37),
(378, '2023-07-20 00:00:00.000000', '2024-07-22 00:00:00.000000', 3, 'A beautiful Showa koi', 0, 52, 'Showa', 1000, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/46/photos/Showa%2052cm.png', 3, 37),
(379, '2024-02-08 00:00:00.000000', '2024-12-30 00:00:00.000000', 2, 'A beautiful Black Diamond koi', 1, 46, 'Black Diamond', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/44/photos/Black%20Diamond%2046cm.png', 12, 34),
(380, '2024-07-06 00:00:00.000000', '2024-12-25 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 28, 'Kohaku', 586, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/11/photos/Kohaku%2025cm%20Tank%206%201.2.png', 1, 35),
(381, '2023-11-05 00:00:00.000000', '2023-11-19 00:00:00.000000', 2, 'A beautiful Ai Goromo koi', 0, 44, 'Ai Goromo', 150, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/60/photos/Ai%20Goromo%2044cm%20M.png', 17, 33),
(382, '2024-01-21 00:00:00.000000', '2024-12-10 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 43, 'Sanke', 582, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/60/photos/Sanke%2043cm%20U.png', 2, 37),
(383, '2024-08-23 00:00:00.000000', '2024-09-29 00:00:00.000000', 2, 'A beautiful Hi Utsuri koi', 1, 45, 'Hi Utsuri', 200, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/60/photos/Hi%20Utsuri%2045cm%20U.png', 4, 29),
(384, '2023-09-07 00:00:00.000000', '2024-06-19 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 36, 'Showa', 300, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/61/photos/Showa%2036cm%20F.png', 3, 35),
(385, '2023-11-19 00:00:00.000000', '2024-07-01 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 1, 30, 'Shiro Utsuri', 150, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/61/photos/Shiro%20Utsuri%2036cm%20F.png', 4, 35),
(386, '2024-02-09 00:00:00.000000', '2024-05-23 00:00:00.000000', 2, 'A beautiful Kujaku koi', 0, 40, 'Kujaku', 200, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/48/photos/Kujaku%2040cm.png', 17, 32),
(387, '2024-06-03 00:00:00.000000', '2024-06-21 00:00:00.000000', 3, 'A beautiful Showa koi', 1, 62, 'Showa', 693, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/62/photos/Showa%2062cm%20F.png', 3, 31),
(388, '2023-02-08 00:00:00.000000', '2023-11-10 00:00:00.000000', 2, 'A beautiful Ochiba koi', 0, 37, 'Ochiba', 450, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/62/photos/Ochiba%2037cm%20M.png', 20, 37),
(389, '2023-06-26 00:00:00.000000', '2023-08-15 00:00:00.000000', 2, 'A beautiful Tancho Goshiki koi', 1, 34, 'Tancho Goshiki', 300, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/62/photos/Tancho%20Goshiki%2034cm%20F.png', 11, 28),
(390, '2023-03-19 00:00:00.000000', '2023-11-15 00:00:00.000000', 2, 'A beautiful Kikusui koi', 0, 33, 'Kikusui', 200, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/63/photos/Kikusui%2033cm%20F.png', 10, 37),
(391, '2023-12-22 00:00:00.000000', '2024-09-05 00:00:00.000000', 3, 'A beautiful Gin-Rin Beni Matsukawabake koi', 1, 44, 'Gin-Rin Beni Matsukawabake', 300, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/63/photos/Matsukawabake%2044cm%20F.png', 17, 29),
(392, '2023-01-14 00:00:00.000000', '2024-02-21 00:00:00.000000', 2, 'A beautiful Yamabuki koi', 1, 27, 'Yamabuki', 200, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/63/photos/Yamibuki%2027cm%20F.png', 14, 36),
(393, '2023-08-19 00:00:00.000000', '2023-09-11 00:00:00.000000', 2, 'A beautiful Ginrin Chagoi koi', 1, 34, 'Ginrin Chagoi', 300, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/64/photos/Gin-Rin%20Chagoi%2034cm%20M.png', 7, 24),
(394, '2024-04-29 00:00:00.000000', '2024-05-19 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 1, 35, 'Shiro Utsuri', 200, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/64/photos/Shiro%20Utsuri%2035cm%20M.png', 4, 35),
(395, '2023-07-05 00:00:00.000000', '2024-12-25 00:00:00.000000', 2, 'A beautiful Showa koi', 0, 37, 'Showa', 109, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/35/photos/Showa%2037cm.png', 3, 26),
(396, '2023-07-23 00:00:00.000000', '2023-08-12 00:00:00.000000', 2, 'A beautiful Goshiki koi', 1, 41, 'Goshiki', 1000, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/65%20Big%20Auction/photos/Goshiki%20auction.png', 17, 31),
(397, '2023-12-28 00:00:00.000000', '2024-08-03 00:00:00.000000', 2, 'A beautiful Golden Corn koi', 0, 54, 'Golden Corn', 2000, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/65%20Big%20Auction/photos/Golden%20Corn%2048cm.png', 20, 30),
(398, '2024-01-30 00:00:00.000000', '2024-05-04 00:00:00.000000', 2, 'A beautiful Ochiba koi', 1, 39, 'Ochiba', 1000, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/65%20Big%20Auction/photos/Ochiba%2035cm%202.png', 20, 36),
(399, '2024-02-05 00:00:00.000000', '2024-06-20 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 59, 'Kohaku', 861, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/65%20Big%20Auction/photos/KOhaku%20dianichi.png', 1, 30),
(400, '2024-09-09 00:00:00.000000', '2024-12-14 00:00:00.000000', 2, 'A beautiful Kohaku koi', 0, 61, 'Kohaku', 1000, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/65%20Big%20Auction/photos/kOHAKU%20Dainichi.png', 1, 31);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `koi_images`
--

CREATE TABLE `koi_images` (
  `id` bigint(20) NOT NULL,
  `image_url` varchar(300) NOT NULL,
  `video_url` varchar(500) DEFAULT NULL,
  `koi_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) NOT NULL,
  `active` bit(1) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `note` varchar(100) DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `phone_number` varchar(100) NOT NULL,
  `shipping_address` varchar(255) DEFAULT NULL,
  `shipping_date` date DEFAULT NULL,
  `shipping_method` varchar(255) DEFAULT NULL,
  `status` enum('CANCELLED','DELIVERED','PENDING','PROCESSING','SHIPPED') DEFAULT NULL,
  `total_money` float DEFAULT NULL,
  `tracking_number` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `orders`
--

INSERT INTO `orders` (`id`, `active`, `address`, `email`, `note`, `order_date`, `payment_method`, `phone_number`, `shipping_address`, `shipping_date`, `shipping_method`, `status`, `total_money`, `tracking_number`, `user_id`, `first_name`, `last_name`) VALUES
(1, b'1', 'Quang Binh, Viet Nam', 'son@gmail.com', '12345', '2024-10-18', 'Cash', '0562278326', 'Á', '2024-10-18', 'Standard', 'PROCESSING', 500000, NULL, 2, 'Son', 'Cong Duong'),
(2, b'1', 'Da Nang, Viet Nam', 'duongnmse181515@fpt.edu.vn', NULL, '2024-10-18', 'Cash', '', 'Da Nang, Viet Nam', '2024-10-18', 'Standard', 'PROCESSING', 500000, NULL, 19, 'Duong', 'Duong'),
(3, b'1', 'Da Nang, Viet Nam', 'duongnmse181515@fpt.edu.vn', '123123', '2024-10-18', 'Payment', '031241233', 'Da Nang, Viet Nam', '2024-10-18', 'Standard', 'PROCESSING', 500000, NULL, 19, 'Duong', 'Duong'),
(4, b'1', 'Quang Binh, Viet Nam', 'son@gmail.com', NULL, '2024-10-18', 'Cash', '', 'Quang Binh, Viet Nam', '2024-10-18', 'Standard', 'PENDING', 500000, NULL, 2, 'Son', 'Cong Duong');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_details`
--

CREATE TABLE `order_details` (
  `id` bigint(20) NOT NULL,
  `number_of_products` int(11) NOT NULL,
  `price` float NOT NULL,
  `total_money` float NOT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `order_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `order_details`
--

INSERT INTO `order_details` (`id`, `number_of_products`, `price`, `total_money`, `product_id`, `order_id`) VALUES
(1, 1, 0, 0, 117, 1),
(2, 1, 0, 0, 123, 2),
(3, 1, 0, 0, 333, 3),
(4, 1, 0, 0, 324, 4);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `otps`
--

CREATE TABLE `otps` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `expired_at` datetime(6) DEFAULT NULL,
  `is_expired` bit(1) DEFAULT NULL,
  `is_used` bit(1) DEFAULT NULL,
  `otp` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `otps`
--

INSERT INTO `otps` (`id`, `created_at`, `updated_at`, `email`, `expired_at`, `is_expired`, `is_used`, `otp`) VALUES
(1, '2024-09-28 09:00:13.067393', '2024-09-28 09:03:04.106708', 'hoanglcse181513@fpt.edu.vn', '2024-09-28 09:05:13.059192', b'1', b'1', '853886'),
(2, '2024-09-30 08:26:57.508033', '2024-09-30 08:26:57.508045', 'caohoanggt0@gmail.com', '2024-09-30 08:31:54.722583', b'1', b'0', '549126'),
(3, '2024-09-30 08:30:47.731452', '2024-09-30 08:30:47.731457', 'luukaohoang1604@gmail.com', '2024-09-30 08:35:43.734659', b'1', b'0', '949211'),
(4, '2024-10-01 01:31:34.255917', '2024-10-01 02:06:43.505061', 'luukaohoang1604@gmail.com', '2024-10-01 01:36:34.235109', b'1', b'0', '203907'),
(5, '2024-10-01 02:09:47.665277', '2024-10-01 02:10:11.117976', 'luukaohoang1604@gmail.com', '2024-10-01 02:14:45.322141', b'1', b'1', '651850'),
(6, '2024-10-01 02:16:46.710810', '2024-10-01 02:16:46.710815', 'luukaohoang1604@gmail.com', '2024-10-01 02:21:45.357069', b'1', b'0', '746803'),
(7, '2024-10-01 02:20:32.079047', '2024-10-01 02:20:32.079058', 'luukaohoang1604@gmail.com', '2024-10-01 02:25:30.364439', b'1', b'0', '284557'),
(8, '2024-10-01 02:25:53.955642', '2024-10-01 02:25:53.955654', 'luukaohoang1604@gmail.com', '2024-10-01 02:30:53.948773', b'1', b'0', '893316'),
(9, '2024-10-01 02:31:10.328353', '2024-10-01 02:31:10.328363', 'tet@gmail.com', '2024-10-01 02:36:10.322156', b'1', b'0', '505209'),
(10, '2024-10-01 02:37:34.649672', '2024-10-01 02:37:34.649683', 'luu1231604@gmail.com', '2024-10-01 02:42:34.644412', b'1', b'0', '556292'),
(11, '2024-10-01 02:40:19.458392', '2024-10-01 02:40:19.458403', 'testetet@gmail.com', '2024-10-01 02:45:19.452182', b'1', b'0', '870921'),
(12, '2024-10-01 02:42:00.355417', '2024-10-01 02:42:00.355423', 'hehe@gmail.com', '2024-10-01 02:47:00.348372', b'1', b'0', '174915'),
(13, '2024-10-01 02:46:17.568215', '2024-10-01 02:48:20.640102', 'luukaohoang1604@gmail.com', '2024-10-01 02:51:17.563754', b'1', b'1', '700113'),
(14, '2024-10-05 16:11:18.699072', '2024-10-05 16:11:18.699083', 'manhduong@gmail.com', '2024-10-05 16:16:18.696391', b'1', b'0', '821346'),
(15, '2024-10-05 16:11:34.176603', '2024-10-05 16:11:34.176611', 'manhduonglhp4@gmail.com', '2024-10-05 16:16:34.174143', b'1', b'0', '655900');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `payments`
--

CREATE TABLE `payments` (
  `id` bigint(20) NOT NULL,
  `payment_amount` float NOT NULL,
  `payment_date` datetime(6) NOT NULL,
  `payment_method` varchar(255) NOT NULL,
  `payment_type` enum('DEPOSIT','ORDER','DRAW_OUT') NOT NULL,
  `payment_status` enum('PENDING','REFUNDED','SUCCESS') NOT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `payments`
--

INSERT INTO `payments` (`id`, `payment_amount`, `payment_date`, `payment_method`, `payment_type`, `payment_status`, `order_id`, `user_id`) VALUES
(1, 500000, '2024-10-18 05:00:13.000000', 'Cash', 'ORDER', 'PENDING', 1, 2),
(2, 500000, '2024-10-18 05:00:40.000000', 'Cash', 'ORDER', 'PENDING', 2, 19),
(3, 500000, '2024-10-18 05:02:12.000000', 'VNPAY', 'ORDER', 'SUCCESS', 3, 19);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `refunds`
--

CREATE TABLE `refunds` (
  `id` bigint(20) NOT NULL,
  `refund_amount` float NOT NULL,
  `refund_reason` varchar(255) NOT NULL,
  `refund_status` varchar(255) NOT NULL,
  `payment_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) NOT NULL,
  `name` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
(1, 'member'),
(2, 'staff'),
(3, 'breeder'),
(4, 'manager');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `social_accounts`
--

CREATE TABLE `social_accounts` (
  `id` bigint(20) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `provider_name` enum('FACEBOOK','GOOGLE') DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tokens`
--

CREATE TABLE `tokens` (
  `id` bigint(20) NOT NULL,
  `expiration_date` datetime(6) DEFAULT NULL,
  `expired` bit(1) NOT NULL,
  `is_mobile` tinyint(1) DEFAULT NULL,
  `refresh_expiration_date` datetime(6) DEFAULT NULL,
  `refresh_token` varchar(255) DEFAULT NULL,
  `revoked` bit(1) NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `token_type` varchar(50) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `tokens`
--

INSERT INTO `tokens` (`id`, `expiration_date`, `expired`, `is_mobile`, `refresh_expiration_date`, `refresh_token`, `revoked`, `token`, `token_type`, `user_id`) VALUES
(10, '2024-11-09 16:07:30.000000', b'0', 0, '2024-12-09 16:07:30.000000', 'ce4f9a4b-e7da-46da-812b-be0452fdf04b', b'1', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjIzLCJlbWFpbCI6Im1hbmh0cmFuQGdtYWlsLmNvbSIsInN1YiI6Im1hbmh0cmFuQGdtYWlsLmNvbSIsImV4cCI6MTczMTE2ODQ1MH0.B2TqIRbw7VRy2UBXieWyCgsFH71xmlSc-c1PMBoDFrA', 'Bearer', 23),
(14, '2024-11-10 14:11:25.000000', b'0', 0, '2024-12-10 14:11:25.000000', 'eb944f8c-5c96-46b1-b936-dbacdb41c9ed', b'0', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjE5LCJlbWFpbCI6ImR1b25nbm1zZTE4MTUxNUBmcHQuZWR1LnZuIiwic3ViIjoiZHVvbmdubXNlMTgxNTE1QGZwdC5lZHUudm4iLCJleHAiOjE3MzEyNDc4ODV9.5XugdDUDIVg1-ZlFNoWWbgJUiplcW0RcDTDEigxpzk0', 'Bearer', 19),
(16, '2024-11-11 14:55:42.000000', b'0', 0, '2024-12-11 14:55:42.000000', '77aa2d19-006a-4307-aa61-c4670095578f', b'1', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjIsImVtYWlsIjoic29uQGdtYWlsLmNvbSIsInN1YiI6InNvbkBnbWFpbC5jb20iLCJleHAiOjE3MzEzMzY5NDJ9.OPTaQ9K4S6wwdv7GTjEuHTwDaTXhki99bHbeuT9iGzU', 'Bearer', 2),
(17, '2024-11-12 03:31:28.000000', b'0', 0, '2024-12-12 03:31:28.000000', 'b327b3bd-9d89-46bd-85ac-77c0c1809141', b'1', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjIsImVtYWlsIjoic29uQGdtYWlsLmNvbSIsInN1YiI6InNvbkBnbWFpbC5jb20iLCJleHAiOjE3MzEzODIyODh9.Odyp3GEH2sXzStKfzbb2mr8eKJNiNZ067fYUUa8jsfU', 'Bearer', 2),
(18, '2024-11-12 04:09:27.000000', b'0', 0, '2024-12-12 04:09:27.000000', 'bd776b08-272c-4331-bc32-114417d803f2', b'0', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjE5LCJlbWFpbCI6ImR1b25nbm1zZTE4MTUxNUBmcHQuZWR1LnZuIiwic3ViIjoiZHVvbmdubXNlMTgxNTE1QGZwdC5lZHUudm4iLCJleHAiOjE3MzEzODQ1Njd9.57M18gx63wXPDSm1FTHVWxan7n3SwJ_B-ZYLFzfzJhU', 'Bearer', 19),
(19, '2024-11-14 14:26:55.000000', b'0', 0, '2024-12-14 14:26:55.000000', '83e10193-256e-4570-a9dd-c0d71c06a3b4', b'1', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjM4LCJlbWFpbCI6ImhvYW5nY2x3QGdtYWlsLmNvbSIsInN1YiI6ImhvYW5nY2x3QGdtYWlsLmNvbSIsImV4cCI6MTczMTU5NDQxNX0.XFKAdcTb1bjUEPGlMEpkklj9TWCRgy5y8QG-M9nfvrk', 'Bearer', 38),
(20, '2024-11-14 14:29:02.000000', b'0', 0, '2024-12-14 14:29:02.000000', '2aabf2aa-fc69-4c90-8eaf-680f0d00faac', b'1', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjI3LCJlbWFpbCI6ImlzYUBnbWFpbC5jb20iLCJzdWIiOiJpc2FAZ21haWwuY29tIiwiZXhwIjoxNzMxNTk0NTQyfQ.Rxwe_boPWtqS2SJypEcx-hQTaqSt5HlI8vsSNHw4TSQ', 'Bearer', 27),
(21, '2024-11-14 14:31:07.000000', b'0', 0, '2024-12-14 14:31:07.000000', '35e39fd8-8207-46f6-b99f-03c4d85d926d', b'1', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjIzLCJlbWFpbCI6Im1hbmh0cmFuQGdtYWlsLmNvbSIsInN1YiI6Im1hbmh0cmFuQGdtYWlsLmNvbSIsImV4cCI6MTczMTU5NDY2N30.NVPKeIQOl06qzyfG0hotwqHz-4SR9Zybs2m1XbPzFQk', 'Bearer', 23),
(22, '2024-11-14 14:32:09.000000', b'0', 0, '2024-12-14 14:32:09.000000', '484d07a2-b750-4b2a-b36b-21895bf18924', b'1', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjI3LCJlbWFpbCI6ImlzYUBnbWFpbC5jb20iLCJzdWIiOiJpc2FAZ21haWwuY29tIiwiZXhwIjoxNzMxNTk0NzI5fQ.ephN0NnRkc8q_rVYxclG4LWoXimgd_WFGOfTvFTu9rg', 'Bearer', 27),
(23, '2024-11-14 16:43:49.000000', b'0', 0, '2024-12-14 16:43:49.000000', 'eae592c4-5512-4df0-b52f-3b246252d128', b'1', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjIzLCJlbWFpbCI6Im1hbmh0cmFuQGdtYWlsLmNvbSIsInN1YiI6Im1hbmh0cmFuQGdtYWlsLmNvbSIsImV4cCI6MTczMTYwMjYyOX0.8hRbiOPjlWjQW1WyK-Ug7chhBftlKAgEnXgv8LpcygE', 'Bearer', 23),
(24, '2024-11-14 16:44:34.000000', b'0', 0, '2024-12-14 16:44:34.000000', '6c191ff8-b937-4b6b-b3ec-effdd8ab929b', b'1', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjM4LCJlbWFpbCI6ImhvYW5nY2x3QGdtYWlsLmNvbSIsInN1YiI6ImhvYW5nY2x3QGdtYWlsLmNvbSIsImV4cCI6MTczMTYwMjY3NH0.coGayXDz7j1iYAqZns3NfAwElCn7vdqBGempisam1SI', 'Bearer', 38),
(25, '2024-11-14 16:45:42.000000', b'0', 0, '2024-12-14 16:45:42.000000', 'c54520b5-0374-482a-91b9-ac9229fbfb9f', b'0', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjI3LCJlbWFpbCI6ImlzYUBnbWFpbC5jb20iLCJzdWIiOiJpc2FAZ21haWwuY29tIiwiZXhwIjoxNzMxNjAyNzQyfQ.rz8Dc9mV_9iacZ61bVIozCJkLRzev8qc2XtVEXcP4xg', 'Bearer', 27),
(26, '2024-11-17 02:54:12.000000', b'0', 0, '2024-12-17 02:54:12.000000', '1a3bfe27-2c16-49db-b857-e5a52c7a1921', b'0', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjI0LCJlbWFpbCI6Im5uZEBnbWFpbC5jb20iLCJzdWIiOiJubmRAZ21haWwuY29tIiwiZXhwIjoxNzMxODEyMDUyfQ.mc3ffDEojUV_cVsvwI8SIeUFMYomYxugEYGKDsPtOnc', 'Bearer', 24),
(27, '2024-11-17 04:50:31.000000', b'0', 0, '2024-12-17 04:50:31.000000', 'd7150e2b-9804-44e2-805c-c34b06c46645', b'1', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjM4LCJlbWFpbCI6ImhvYW5nY2x3QGdtYWlsLmNvbSIsInN1YiI6ImhvYW5nY2x3QGdtYWlsLmNvbSIsImV4cCI6MTczMTgxOTAzMX0.qBslJ0j_KjAYw2zJbKidfo3tLeNOnuKXk3Wof0WH1Jk', 'Bearer', 38),
(28, '2024-11-17 04:56:58.000000', b'0', 0, '2024-12-17 04:56:58.000000', 'e041bde2-4143-44c1-8386-97668aed0d04', b'0', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjIsImVtYWlsIjoic29uQGdtYWlsLmNvbSIsInN1YiI6InNvbkBnbWFpbC5jb20iLCJleHAiOjE3MzE4MTk0MTh9.m687ZYL_q7L9ZaOcrkYSXEFVcrXeQtivQ4Hhog-LLWg', 'Bearer', 2),
(29, '2024-11-17 04:58:21.000000', b'0', 0, '2024-12-17 04:58:21.000000', '72ed15f8-0d66-4e83-9e76-238ff2b677a5', b'0', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjE5LCJlbWFpbCI6ImR1b25nbm1zZTE4MTUxNUBmcHQuZWR1LnZuIiwic3ViIjoiZHVvbmdubXNlMTgxNTE1QGZwdC5lZHUudm4iLCJleHAiOjE3MzE4MTk1MDF9.ilJDApqE6cUQlZama9JTzTuIxt1egpkLoQ7YlBLaPcI', 'Bearer', 19);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `avatar_url` varchar(255) DEFAULT NULL,
  `date_of_birth` datetime(6) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `google_account_id` int(11) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `status` enum('ONGOING','BANNED','INACTIVE','UNVERIFIED','VERIFIED') DEFAULT NULL,
  `role_id` bigint(20) DEFAULT NULL,
  `account_balance` bigint(20) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT NULL,
  `is_subscription` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `created_at`, `updated_at`, `address`, `avatar_url`, `date_of_birth`, `email`, `first_name`, `google_account_id`, `last_name`, `password`, `phone_number`, `status`, `role_id`, `account_balance`, `is_active`, `is_subscription`) VALUES
(1, '2024-09-22 12:52:28.527956', '2024-09-22 12:52:28.527967', '', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', NULL, 'mnhw.0612@gmail.com', 'Minh', 0, 'Nhu', '$2a$10$Fr4Khr9gT8rBlSlZIF3Z3.t62ZenOSFVJamccBe5yxLB27SSvF0Ru', NULL, NULL, 1, 0, 1, 0),
(2, '2024-09-22 06:58:19.000000', '2024-10-18 05:02:31.000000', 'Quang Binh, Viet Nam', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', '1979-10-13 00:00:00.000000', 'son@gmail.com', 'Son', 0, 'Cong Duong', '$2a$10$Orep8r6WJo5EjwNq7HyTL.kD8xDlwD5QA6Qk2HVQzkVjUXG1ccGPm', NULL, 'UNVERIFIED', 1, 807078831, 1, 0),
(3, '2024-09-22 06:58:39.749509', '2024-09-22 06:58:39.749513', 'Tam Ki, Viet Nam', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', '1979-10-13 00:00:00.000000', 'manhduonglhp1@gmail.com', 'Duong', 0, 'Manh Nguyen', '$2a$10$Rg7wfZ2yabht3eBqhoJQxedR.r4ojQUGm9g9Jz5WtDJw3pWqpoiTu', NULL, 'UNVERIFIED', 1, 0, 1, 0),
(4, '2024-09-27 15:21:18.973575', '2024-09-27 15:21:18.973595', 'Hoa Khanh, Da Nang', NULL, '2004-10-14 00:00:00.000000', 'hoangdz1604@gmail.com', 'Bao', 0, 'Chau', '$2a$10$jX.17d38A.AXWWJedIQ4p..KzZkKt.Pk3bwpU5gtPJLJtzygdjoy.', NULL, NULL, 1, 0, 0, 0),
(5, '2024-09-27 15:25:59.286318', '2024-09-27 15:25:59.286337', 'Hoa Vang, Da Nang', NULL, '2004-10-14 00:00:00.000000', 'luuhai@gmail.com', 'Hai', 0, 'Luu', '$2a$10$SwG2quSV3SQNdAfKWpZd0uzaB9XwoaBfR8n27D9QptspytMyNkj3u', NULL, NULL, 1, 0, 0, 0),
(6, '2024-09-27 15:28:51.559247', '2024-09-27 15:28:51.559286', 'Hoa Vang, Da Nang', NULL, '2004-10-14 00:00:00.000000', 'luuhaivn@gmail.com', 'Hai', 0, 'Luu', '$2a$10$MmAaEStq3KT7fRhKWlD8FOXL6GdTk1e.5BjPISpZunxAxCq5pGbwq', NULL, 'UNVERIFIED', 1, 0, 0, 0),
(7, '2024-09-27 15:30:52.640808', '2024-09-27 15:30:52.640833', 'Hoa Vang, Da Nang', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', '2004-10-14 00:00:00.000000', 'lch@gmail.com', 'Hoang', 0, 'Hai', '$2a$10$63eAnEyqY4Y3xsktquBzJ.u39j/X8b.1NcafBdXSvx7Y0wai1hIxm', NULL, 'UNVERIFIED', 1, 0, 0, 0),
(8, '2024-09-28 01:42:59.705789', '2024-09-28 01:42:59.705833', 'Vinh Long', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', '2004-10-14 00:00:00.000000', 'mah@gmail.com', 'Mac', 0, 'Hao Anh', '$2a$10$lwZzBtJFAJjPGRCJvJKlk.Gyd3RhLsV4eFai1BGIQByQjfjAj46xa', NULL, 'UNVERIFIED', 1, 0, 0, 0),
(9, '2024-09-28 02:04:20.784604', '2024-09-28 02:04:20.784678', 'Vinh Long', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', '2004-10-14 00:00:00.000000', 'manhduonglhp2@gmail.com', 'Mac', 0, 'Hao Anh', '$2a$10$M3WCdcgsRAW.zfCyf2kQwODnDFHm0fCExajXE74gR8Dq4WJZvGN2O', NULL, 'UNVERIFIED', 1, 0, 1, 0),
(10, '2024-09-28 02:09:21.078020', '2024-09-28 02:09:21.078121', 'Vinh Long', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', '2004-10-14 00:00:00.000000', 'manhduonglhp3@gmail.com', 'Mac', 0, 'Hao Anh', '$2a$10$pDVmvBj9Bs7/A8OVQ5nUzeQoCE4F95CU3ggA88cxHTveueEtpjvTe', NULL, 'UNVERIFIED', 1, 0, 1, 0),
(11, '2024-09-28 02:15:37.103176', '2024-09-28 02:15:37.103200', 'Vinh Long', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', '2004-10-14 00:00:00.000000', 'manhduonglhp5@gmail.com', 'Mac', 0, 'Hao Anh', '$2a$10$4evUxJ397YXsiexQ7yTMC.67GpQ9lSBCda4DvxA2aYQ833XCB89fW', NULL, 'UNVERIFIED', 1, 0, 1, 0),
(12, '2024-09-28 08:05:35.248602', '2024-09-28 08:05:35.248634', 'Tokyo', 'https://auctionkoi.com/images/shintaro-logo.png', NULL, 'test4@gmail.com', 'hehe', 0, 'taolanhat', '$2a$10$ZwV/1YUWzLeG3mMR1GIFnujiezIBvwvdzLcrTcABwA2DM8NlKPc0G', NULL, 'UNVERIFIED', 1, 0, 1, 0),
(13, '2024-09-28 09:00:08.369215', '2024-09-28 09:03:04.120112', 'TPHCM', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTTfSLvr6JNIBOy0OBG-ydUSOhjq7Y7KDRvg&s', NULL, 'hoanglcse181513@fpt.edu.vn', 'Hoang', 0, 'Cao Luu', '$2a$10$shSYCgMKePpgyXhjDXdJ.e0LUTivx3mQCjJOmsSmBnKjJYjD9mEWu', NULL, 'VERIFIED', 1, 0, 1, 0),
(14, '2024-09-30 08:26:46.220241', '2024-09-30 08:26:46.220247', 'TPHCM', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTTfSLvr6JNIBOy0OBG-ydUSOhjq7Y7KDRvg&s', NULL, 'caohoanggt0@gmail.com', 'Hoang', 0, 'Cao Luu', '$2a$10$BGSucPFP/s1A1NCAG5MRDe/36W04uVJzp0Ala7YKtOzUS8anAC1W.', NULL, 'UNVERIFIED', 1, 0, 1, 0),
(15, '2024-10-01 02:37:30.758899', '2024-10-01 02:37:30.758902', 'Tra Bui', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', NULL, 'luu1231604@gmail.com', 'Hoang', 0, 'Luu', '$2a$10$AFB6FiL9C931yESMHntJf.iB/wQN3nFzhnFJEMREffrUKWcPQfoUy', NULL, 'UNVERIFIED', 1, 0, 1, 0),
(16, '2024-10-01 02:40:15.418332', '2024-10-01 02:40:15.418334', 'Tra Bong', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', NULL, 'testetet@gmail.com', 'Hoang', 0, 'Luu', '$2a$10$NaE3c0NGEZGS.ZritlyvD.pcff84D8e.0Y0opMYdQZsOUXUcJYUvC', NULL, 'UNVERIFIED', 1, 0, 1, 0),
(17, '2024-10-01 02:41:55.837629', '2024-10-01 02:41:55.837632', 'Thai Sau', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', NULL, 'hehe@gmail.com', 'Hoang', 0, 'Luu', '$2a$10$v/I9kSV3sH35xejKElfedOWBrgDBqN922.AetAs5ae3sTRRU8CmxW', NULL, 'UNVERIFIED', 1, 0, 1, 0),
(18, '2024-10-01 02:46:13.663828', '2024-10-01 02:48:20.669047', 'Can Gio', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', NULL, 'luukaohoang1604@gmail.com', 'Hoang', 0, 'Luu', '$2a$10$t5Gsz29f8N9.zV21DRGM0OMyDqaxRjClIJSiv9liA36Ff8atzdrAC', NULL, 'VERIFIED', 1, 0, 1, 0),
(19, '2024-10-05 16:11:14.000000', '2024-10-18 05:01:01.000000', 'Da Nang, Viet Nam', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', '1979-10-13 00:00:00.000000', 'duongnmse181515@fpt.edu.vn', 'Duong', 0, 'Duong', '$2a$10$pXEzC6NCd9r2e6kXNV9PFe9ZJKyyxL/yniNwUl6xpZUy/iQguZQU6', NULL, 'UNVERIFIED', 1, 248660537, 1, 0),
(20, '2024-10-05 16:11:30.574401', '2024-10-05 16:11:30.574405', 'Da Nang, Viet Nam', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', '1979-10-13 00:00:00.000000', 'manhduonglhp4@gmail.com', 'Duong', 0, 'Duong', '$2a$10$s/ICX1aEukr/V7Iz7G/TbOus5yAaayCqKc6DPS9AwrZLf5nbjqAOW', NULL, 'UNVERIFIED', 1, 0, 1, 0),
(21, '2024-09-22 06:56:15.470639', '2024-09-28 07:53:03.281172', 'Ha Tinh, Viet Nam', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', '1979-10-13 00:00:00.000000', 'vy@gmail.com', 'Vy', 0, 'Ky Nguyen', '$2a$10$FGoLrPd5YESJhA7iiE3Jf.vnZU1BcxR3N5xtMxOJMKUjknCQ.iK7O', NULL, 'UNVERIFIED', 2, 0, 0, 0),
(22, '2024-09-22 06:57:39.672269', '2024-09-22 06:57:39.672273', 'Ha Nam, Viet Nam', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', '1979-10-13 00:00:00.000000', 'baovu@gmail.com', 'Bao', 0, 'Van Vu', '$2a$10$rP7CU.wmF3SaP4lzNHNA6uUQr27JBAJr2Uoot1toTKmRlmGWcg7su', NULL, 'UNVERIFIED', 2, 0, 1, 0),
(23, '2024-09-22 06:57:57.861037', '2024-09-22 06:57:57.861041', 'Phu Tho, Viet Nam', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', '1979-10-13 00:00:00.000000', 'manhtran@gmail.com', 'Tran', 0, 'Manh Duc', '$2a$10$nGC/NyBlxwFZzA0Ecj7gP.tYPRIvvFb8DZNNlaM/nylbvU3IzBWGi', NULL, 'UNVERIFIED', 2, 0, 1, 0),
(24, '2024-09-22 06:59:36.244230', '2024-09-27 01:12:20.853127', 'Tokyo', 'https://auctionkoi.com/images/nnd-logo.png', '1979-10-13 00:00:00.000000', 'nnd@gmail.com', 'NND', 0, 'Farm', '$2a$10$DkiD8VzBXW5pGgGH2cYvQOtT3DbtLsuKHJ9.KjoN.GsI6LSQZJmui', NULL, 'VERIFIED', 3, 0, 1, 0),
(25, '2024-09-22 06:59:53.747779', '2024-09-27 01:23:26.819524', 'Tokyo', 'https://auctionkoi.com/images/marushin-logo.png', '1979-10-13 00:00:00.000000', 'marushin@gmail.com', 'Marushin', 0, 'Farm', '$2a$10$sornl4RV.DkqkAS68ryyw.azD20A/4KmeeOa2IiTRxuS89nUQXMK.', NULL, 'VERIFIED', 3, 0, 1, 0),
(26, '2024-09-22 07:00:02.941910', '2024-09-27 01:23:47.658909', 'Tokyo', 'https://auctionkoi.com/images/sakai-logo.png', '1979-10-13 00:00:00.000000', 'sakai@gmail.com', 'Sakai', 0, 'Farm', '$2a$10$SecO0EZQEWjBVyok7D7eTeBuVelmz7pjiCA8sddztylvVq801fiRu', NULL, 'VERIFIED', 3, 0, 1, 0),
(27, '2024-09-22 07:00:12.510595', '2024-09-27 01:24:15.330550', 'Tokyo', 'https://auctionkoi.com/images/isa-logo.png', '1979-10-13 00:00:00.000000', 'isa@gmail.com', 'Isa', 0, 'Farm', '$2a$10$.Wj6q5N.bCR.3dFi3fc2dugPIrA0X91FiibIW/8Kw5mVyYAYjpLei', NULL, 'VERIFIED', 3, 0, 1, 0),
(28, '2024-09-22 07:00:24.623763', '2024-09-27 01:24:49.064092', 'Tokyo', 'https://auctionkoi.com/images/maruhiro-logo.png', '1979-10-13 00:00:00.000000', 'maruhiro@gmail.com', 'Maruhiro', 0, 'Farm', '$2a$10$3TSjJG7bHVlNRdQAi5qBZeeXbLoNhMMXrsFp6FJcC9CFBmrjiV2Su', NULL, 'VERIFIED', 3, 0, 1, 0),
(29, '2024-09-22 07:00:39.043899', '2024-09-27 01:25:04.915762', 'Tokyo', 'https://auctionkoi.com/images/torazo-logo.png', '1979-10-13 00:00:00.000000', 'torazo@gmail.com', 'Torazo', 0, 'Farm', '$2a$10$8sFYFH/3KtoCaV5wiLGhQecY7SwhM.gqFa9G2C1QrC0v2dQaNA0VK', NULL, 'VERIFIED', 3, 0, 1, 0),
(30, '2024-09-22 07:00:50.485396', '2024-09-27 01:25:20.130483', 'Tokyo', 'https://auctionkoi.com/images/shinoda-logo.png', '1979-10-13 00:00:00.000000', 'shinoda@gmail.com', 'Shinoda', 0, 'Farm', '$2a$10$xGxH5nAWUFgWdo0Twsuc8.6PFhf6ZdgqrvAweQA/kmCj6z9PQKpQi', NULL, 'VERIFIED', 3, 0, 1, 0),
(31, '2024-09-22 12:50:53.030997', '2024-09-27 01:27:52.862485', 'Tokyo', 'https://auctionkoi.com/images/kanno-logo.png', NULL, 'kanno@gmail.com', 'Kanno', 0, 'Farm', '$2a$10$.k6HZRqVtl7sxRtsgjiQ/eOjTpuy4pe7ZwpQKwgA9KwR70WFfeefq', NULL, 'VERIFIED', 3, 0, 1, 0),
(32, '2024-09-27 01:29:07.895187', '2024-09-27 01:32:19.992118', 'Tokyo', 'https://auctionkoi.com/images/dainichi-logo.png', NULL, 'dainichi@gmail.com', 'Dainichi', 0, 'Farm', '$2a$10$XckSkz8ZTZcOGOndc8YTduaPyPdHjj9hQ4PYezMAziSaUTsOgofQO', NULL, 'VERIFIED', 3, 0, 1, 0),
(33, '2024-09-27 01:31:44.803419', '2024-09-27 01:32:22.979260', 'Tokyo', 'https://auctionkoi.com/images/omosako-logo.png', NULL, 'omosako@gmail.com', 'Omosako', 0, 'Farm', '$2a$10$CHmNC2psYO9xeJjzmbSiSe5yAlZzgl5rAN0RYibVMRyARj4YU9ve6', NULL, 'VERIFIED', 3, 0, 1, 0),
(34, '2024-09-27 01:32:46.643498', '2024-09-27 01:33:56.144482', 'Tokyo', 'https://auctionkoi.com/images/izumiya-logo.png', NULL, 'izumiya@gmail.com', 'Izumiya', 0, 'Farm', '$2a$10$iWrH3sir7RQPmn0UHdV0fO5OiLzsVpNtS/u6drxxK1aEilMkycU9S', NULL, 'VERIFIED', 3, 0, 1, 0),
(35, '2024-09-27 01:33:11.046544', '2024-09-27 01:33:58.113222', 'Tokyo', 'https://auctionkoi.com/images/marudo-logo.png', NULL, 'marudo@gmail.com', 'Marudo', 0, 'Farm', '$2a$10$OJa7MR5d3mG6Ju7Bl4NYqO8EOGRDcVzv.GD6m9NtSRK.AsFhakqCO', NULL, 'VERIFIED', 3, 0, 1, 0),
(36, '2024-09-27 01:33:21.593383', '2024-09-27 01:33:59.833681', 'Tokyo', 'https://auctionkoi.com/images/marujyu-logo.png', NULL, 'marujyu@gmail.com', 'Marujyu', 0, 'Farm', '$2a$10$kxEegAgSjIy6yBPcU3Low.Xn9mamaOiU8mnzfehvZ7ltDy4R2ym1a', NULL, 'VERIFIED', 3, 0, 1, 0),
(37, '2024-09-27 01:33:32.619792', '2024-09-27 01:34:01.592871', 'Tokyo', 'https://auctionkoi.com/images/shintaro-logo.png', NULL, 'shintaro@gmail.com', 'Shintaro', 0, 'Farm', '$2a$10$nbKQCdjMw1pEplr.o8ELdOudQWUDtImtQDAfwCQUzsMs8hF6scurW', NULL, 'VERIFIED', 3, 0, 1, 0),
(38, '2024-09-22 06:59:14.042883', '2024-09-22 06:59:14.042887', 'Arab Saudi', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', '1979-10-13 00:00:00.000000', 'hoangclw@gmail.com', 'Hoang', 0, 'Luu Cao', '$2a$10$W22x0wOuJ5aFtLI1NvN1tO2ZgZhNAq0pEKdLGjsSgSKqJ462qitsO', NULL, 'UNVERIFIED', 4, 0, 1, 0);

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
  ADD KEY `fk_user_payment` (`user_id`);

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `auction_kois`
--
ALTER TABLE `auction_kois`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT cho bảng `auction_kois_details`
--
ALTER TABLE `auction_kois_details`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `auction_participants`
--
ALTER TABLE `auction_participants`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT cho bảng `kois`
--
ALTER TABLE `kois`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=401;

--
-- AUTO_INCREMENT cho bảng `koi_images`
--
ALTER TABLE `koi_images`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `otps`
--
ALTER TABLE `otps`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT cho bảng `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `refunds`
--
ALTER TABLE `refunds`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `social_accounts`
--
ALTER TABLE `social_accounts`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `tokens`
--
ALTER TABLE `tokens`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

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
  ADD CONSTRAINT `fk_user_payment` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

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
