-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1:3306
-- Thời gian đã tạo: Th10 18, 2024 lúc 04:54 AM
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
(3, 'ONGOING', '2024-10-17 14:35:00.000000', '2024-10-15 14:35:00.000000', 'Test Auction', 21),
(4, 'ONGOING', '2024-10-17 16:50:00.000000', '2024-10-15 16:50:00.000000', 'Decs Auction Test', 21);

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

INSERT INTO `auction_kois` (`id`, `base_price`, `bid_step`, `bid_method`, `current_bid`, `current_bidder_id`, `is_sold`, `auction_id`, `koi_id`, `ceil_price`) VALUES
(1, 200000, 0, 'FIXED_PRICE', 0, 0, 0, 1, 117, 0),
(2, 200000, 0, 'FIXED_PRICE', 0, 0, 0, 1, 324, NULL),
(3, 200000, 0, 'FIXED_PRICE', 0, 0, 0, 1, 123, 0),
(4, 200000, 0, 'FIXED_PRICE', 0, 0, 0, 1, 333, NULL),
(5, 200000, 0, 'FIXED_PRICE', 0, 0, 0, 1, 222, 0),
(6, 200000, 0, 'FIXED_PRICE', 0, 0, 0, 1, 165, NULL),
(7, 200000, 0, 'FIXED_PRICE', 0, 0, 0, 1, 334, 0),
(8, 200000, 0, 'FIXED_PRICE', 0, 0, 0, 1, 97, NULL),
(9, 200000, 0, 'FIXED_PRICE', 0, 0, 0, 1, 66, NULL),
(10, 200000, 0, 'FIXED_PRICE', 0, 0, 0, 1, 61, 0),
(11, 300000, 0, 'SEALED_BID', 0, 0, 0, 2, 281, 500000),
(12, 300000, 0, 'SEALED_BID', 0, 0, 0, 2, 63, 500000),
(13, 300000, 0, 'SEALED_BID', 0, 1, 0, 2, 291, 500000),
(14, 300000, 0, 'SEALED_BID', 0, 13, 0, 2, 238, 500000),
(15, 300000, 0, 'SEALED_BID', 0, NULL, 0, 2, 160, 500000),
(16, 300000, 0, 'SEALED_BID', 0, 11, 0, 2, 275, 500000),
(17, 300000, 0, 'SEALED_BID', 0, 13, 0, 2, 93, 500000),
(18, 300000, 0, 'SEALED_BID', 0, NULL, 0, 2, 286, 500000),
(19, 300000, 0, 'SEALED_BID', 0, 3, 0, 2, 65, 500000),
(20, 300000, 0, 'SEALED_BID', 0, NULL, 0, 2, 35, 500000),
(21, 200000, 50, 'ASCENDING_BID', 0, 0, 0, 3, 201, 500000),
(22, 100000, 50, 'DESCENDING_BID', 0, 0, 0, 4, 7, 500000),
(23, 200000, 50, 'DESCENDING_BID', 0, 0, 0, 4, 8, 500000),
(24, 150000, 50, 'DESCENDING_BID', 0, 0, 0, 4, 12, 500000),
(25, 300000, 50, 'SEALED_BID', 0, 0, 0, 3, 5, 500000);

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
(1, '2023-10-25 00:00:00.000000', '2024-05-07 00:00:00.000000', 1, 'A beautiful Sanke koi', 1, 21, 'Sanke', 150, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/21cm%20torazo%20sanke%20tosai.png', 14, 24),
(2, '2023-03-04 00:00:00.000000', '2024-02-21 00:00:00.000000', 1, 'A beautiful Showa koi', 1, 18, 'Showa', 150, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/ISA%2018cm%20Tosai%20Showa.png?t=2023-07-22T14%3A51%3A55.194Z', 6, 32),
(3, '2024-06-13 00:00:00.000000', '2024-12-17 00:00:00.000000', 1, 'A beautiful Showa koi', 1, 19, 'Showa', 150, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/ISA%2019cm%20Showa%20Tosai.png?t=2023-07-22T14%3A53%3A01.267Z', 19, 29),
(4, '2024-12-01 00:00:00.000000', '2024-12-15 00:00:00.000000', 1, 'A beautiful Showa koi', 1, 20, 'Showa', 150, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/ISA%2020cm%20Showa%20tosai.png?t=2023-07-22T14%3A53%3A47.947Z', 9, 27),
(5, '2023-05-26 00:00:00.000000', '2024-12-20 00:00:00.000000', 1, 'A beautiful Showa koi', 1, 22, 'Showa', 150, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/ISA%2022cm%20Showa%20tosai.png?t=2023-07-22T14%3A55%3A25.054Z', 19, 25),
(6, '2023-03-19 00:00:00.000000', '2023-09-09 00:00:00.000000', 1, 'A beautiful Showa koi', 1, 23, 'Showa', 150, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/ISA%2023cm%20Showa%20Tosai.png?t=2023-07-22T14%3A56%3A45.071Z', 12, 28),
(7, '2024-03-03 00:00:00.000000', '2024-07-01 00:00:00.000000', 1, 'A beautiful Yamabuki koi', 1, 19, 'Yamabuki', 150, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/NND%2019cm%20Tosai%20Yamabuki%20.png?t=2023-07-22T14%3A58%3A07.915Z', 17, 34),
(8, '2023-04-20 00:00:00.000000', '2024-03-23 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 20, 'Shiro Utsuri', 150, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/NND%2020cm%20Shiro%20Utsuri%20Tosai(1).png?t=2023-07-22T14%3A59%3A34.301Z', 13, 31),
(9, '2024-02-25 00:00:00.000000', '2024-06-03 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 20, 'Shiro Utsuri', 150, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/NND%2020cm%20Shiro%20Utsuri%20Tosai.png?t=2023-07-22T15%3A00%3A31.466Z', 10, 28),
(10, '2023-04-11 00:00:00.000000', '2024-08-04 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 19, 'Shiro Utsuri', 150, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/NND%20Shiro%20utsuri%2019cm%20tosai.png?t=2023-07-22T15%3A01%3A58.222Z', 9, 33),
(11, '2023-12-09 00:00:00.000000', '2024-05-03 00:00:00.000000', 1, 'A beautiful Tancho Showa koi', 1, 19, 'Tancho Showa', 150, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/NND%20Tancho%20Showa%2019cm%20Tosai.png?t=2023-07-22T15%3A02%3A50.695Z', 13, 34),
(12, '2023-03-23 00:00:00.000000', '2023-12-05 00:00:00.000000', 1, 'A beautiful Doitsu Sanke koi', 1, 26, 'Doitsu Sanke', 150, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/Shinoda%20Doitsu%20Sanke%2026cm%20Tosai(1).png?t=2023-07-22T15%3A04%3A24.313Z', 17, 37),
(13, '2023-06-10 00:00:00.000000', '2023-06-27 00:00:00.000000', 1, 'A beautiful Doitsu Sanke koi', 1, 26, 'Doitsu Sanke', 150, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/Shinoda%20Doitsu%20Sanke%2026cm%20Tosai.png?t=2023-07-22T15%3A05%3A26.861Z', 3, 33),
(14, '2024-01-24 00:00:00.000000', '2024-12-19 00:00:00.000000', 1, 'A beautiful Ginrin Tancho Showa koi', 1, 29, 'Ginrin Tancho Showa', 150, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/Shinoda%20Ginrin%20Tancho%20Showa%2029cm.png?t=2023-07-22T15%3A06%3A33.850Z', 5, 27),
(15, '2024-04-03 00:00:00.000000', '2024-09-26 00:00:00.000000', 1, 'A beautiful Hi Utsuri koi', 1, 31, 'Hi Utsuri', 150, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/Shinoda%20Hi%20Utsuri%2031cm%20Nisai%20.png?t=2023-07-22T15%3A08%3A11.840Z', 20, 33),
(16, '2023-02-16 00:00:00.000000', '2024-12-26 00:00:00.000000', 1, 'A beautiful Hi Utsuri koi', 1, 24, 'Hi Utsuri', 150, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/Shinoda%20Hi%20Utsuri%20Tosai%2024cm.png?t=2023-07-22T15%3A09%3A01.955Z', 9, 33),
(17, '2023-10-24 00:00:00.000000', '2024-09-06 00:00:00.000000', 1, 'A beautiful Tancho Sanke koi', 1, 16, 'Tancho Sanke', 150, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/Shinoda%20tosai%20Tancho%20Sanke%2016cm%20tosai.png?t=2023-07-22T15%3A10%3A11.026Z', 14, 29),
(18, '2023-07-14 00:00:00.000000', '2023-09-25 00:00:00.000000', 1, 'A beautiful Kohaku koi', 1, 16, 'Kohaku', 150, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/Torazo%2016cm%20Tosai%20Kohaku.png?t=2023-07-22T15%3A11%3A21.869Z', 12, 30),
(19, '2024-01-22 00:00:00.000000', '2024-04-13 00:00:00.000000', 1, 'A beautiful Kohaku koi', 1, 18, 'Kohaku', 150, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/Torazo%2018cm%20Kohaku%20Tosai.png?t=2023-07-22T15%3A12%3A26.241Z', 20, 34),
(20, '2024-12-28 00:00:00.000000', '2024-12-28 00:00:00.000000', 1, 'A beautiful Kohaku koi', 1, 19, 'Kohaku', 150, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/Torazo%2019cm%20Kohaku%20tosai.png?t=2023-07-22T15%3A13%3A00.390Z', 20, 27),
(21, '2023-06-15 00:00:00.000000', '2024-03-02 00:00:00.000000', 1, 'A beautiful Showa koi', 1, 19, 'Showa', 150, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/ISA%2019cm%20Showa%20Tosai.png?t=2023-07-22T14%3A53%3A01.267Z', 1, 33),
(22, '2023-06-26 00:00:00.000000', '2024-12-13 00:00:00.000000', 1, 'A beautiful Showa koi', 1, 20, 'Showa', 150, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/ISA%2020cm%20Showa%20tosai.png?t=2023-07-22T14%3A53%3A47.947Z', 9, 37),
(23, '2023-11-02 00:00:00.000000', '2024-07-30 00:00:00.000000', 1, 'A beautiful Showa koi', 1, 22, 'Showa', 150, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/ISA%2022cm%20Showa%20tosai.png?t=2023-07-22T14%3A55%3A25.054Z', 5, 26),
(24, '2024-02-01 00:00:00.000000', '2024-04-09 00:00:00.000000', 1, 'A beautiful Yamabuki koi', 1, 19, 'Yamabuki', 150, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/NND%2019cm%20Tosai%20Yamabuki%20.png?t=2023-07-22T14%3A58%3A07.915Z', 1, 31),
(25, '2023-03-16 00:00:00.000000', '2023-03-19 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 20, 'Shiro Utsuri', 150, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/NND%2020cm%20Shiro%20Utsuri%20Tosai(1).png?t=2023-07-22T14%3A59%3A34.301Z', 17, 30),
(26, '2023-04-07 00:00:00.000000', '2023-06-10 00:00:00.000000', 1, 'A beautiful Tancho Showa koi', 1, 19, 'Tancho Showa', 947, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/NND%20Tancho%20Showa%2019cm%20Tosai.png?t=2023-07-22T15%3A02%3A50.695Z', 9, 33),
(27, '2023-09-19 00:00:00.000000', '2023-10-18 00:00:00.000000', 1, 'A beautiful Doitsu Sanke koi', 1, 26, 'Doitsu Sanke', 906, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/Shinoda%20Doitsu%20Sanke%2026cm%20Tosai(1).png?t=2023-07-22T15%3A04%3A24.313Z', 2, 33),
(28, '2023-09-07 00:00:00.000000', '2024-06-17 00:00:00.000000', 1, 'A beautiful Doitsu Sanke koi', 1, 26, 'Doitsu Sanke', 314, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/Shinoda%20Doitsu%20Sanke%2026cm%20Tosai.png?t=2023-07-22T15%3A05%3A26.861Z', 3, 36),
(29, '2023-10-23 00:00:00.000000', '2023-12-10 00:00:00.000000', 1, 'A beautiful Hi Utsuri koi', 1, 31, 'Hi Utsuri', 150, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/Shinoda%20Hi%20Utsuri%2031cm%20Nisai%20.png?t=2023-07-22T15%3A08%3A11.840Z', 19, 34),
(30, '2023-04-19 00:00:00.000000', '2024-10-23 00:00:00.000000', 1, 'A beautiful Hi Utsuri koi', 1, 24, 'Hi Utsuri', 150, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/Shinoda%20Hi%20Utsuri%20Tosai%2024cm.png?t=2023-07-22T15%3A09%3A01.955Z', 10, 30),
(31, '2023-06-29 00:00:00.000000', '2024-08-17 00:00:00.000000', 1, 'A beautiful Tancho Sanke koi', 1, 16, 'Tancho Sanke', 379, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/Shinoda%20tosai%20Tancho%20Sanke%2016cm%20tosai.png?t=2023-07-22T15%3A10%3A11.026Z', 16, 25),
(32, '2024-04-17 00:00:00.000000', '2024-08-03 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 19, 'Shiro Utsuri', 150, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/NND%20Shiro%20utsuri%2019cm%20tosai.png?t=2023-07-22T15%3A01%3A58.222Z', 17, 31),
(33, '2023-06-30 00:00:00.000000', '2024-03-01 00:00:00.000000', 1, 'A beautiful Kohaku koi', 1, 18, 'Kohaku', 150, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/Torazo%2018cm%20Kohaku%20Tosai.png?t=2023-07-22T15%3A12%3A26.241Z', 5, 29),
(34, '2023-07-02 00:00:00.000000', '2024-03-26 00:00:00.000000', 1, 'A beautiful Sanke koi', 1, 21, 'Sanke', 150, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/21cm%20torazo%20sanke%20tosai.png', 8, 28),
(35, '2023-03-26 00:00:00.000000', '2024-12-10 00:00:00.000000', 1, 'A beautiful Showa koi', 1, 18, 'Showa', 150, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/ISA%2018cm%20Tosai%20Showa.png?t=2023-07-22T14%3A51%3A55.194Z', 14, 27),
(36, '2023-02-13 00:00:00.000000', '2024-02-02 00:00:00.000000', 1, 'A beautiful Showa koi', 1, 23, 'Showa', 146, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/ISA%2023cm%20Showa%20Tosai.png?t=2023-07-22T14%3A56%3A45.071Z', 16, 36),
(37, '2023-10-29 00:00:00.000000', '2024-05-03 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 20, 'Shiro Utsuri', 150, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/NND%2020cm%20Shiro%20Utsuri%20Tosai.png?t=2023-07-22T15%3A00%3A31.466Z', 12, 32),
(38, '2024-03-14 00:00:00.000000', '2024-09-19 00:00:00.000000', 1, 'A beautiful Ginrin Tancho Showa koi', 1, 29, 'Ginrin Tancho Showa', 767, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/Shinoda%20Ginrin%20Tancho%20Showa%2029cm.png?t=2023-07-22T15%3A06%3A33.850Z', 7, 28),
(39, '2023-08-15 00:00:00.000000', '2023-08-17 00:00:00.000000', 1, 'A beautiful Kohaku koi', 1, 16, 'Kohaku', 150, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/Torazo%2016cm%20Tosai%20Kohaku.png?t=2023-07-22T15%3A11%3A21.869Z', 8, 29),
(40, '2023-01-18 00:00:00.000000', '2023-03-29 00:00:00.000000', 1, 'A beautiful Kohaku koi', 1, 19, 'Kohaku', 150, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/1/photos/Torazo%2019cm%20Kohaku%20tosai.png?t=2023-07-22T15%3A13%3A00.390Z', 5, 34),
(41, '2024-03-21 00:00:00.000000', '2024-11-08 00:00:00.000000', 1, 'A beautiful Doitsu Showa koi', 1, 26, 'Doitsu Showa', 763, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Doitsu%20Showa%2026cm%20tosai.png', 12, 26),
(42, '2024-10-23 00:00:00.000000', '2024-12-28 00:00:00.000000', 1, 'A beautiful Showa koi', 1, 26, 'Showa', 107, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Isa%20Showa%20Tosai%2026cm.png', 13, 31),
(43, '2024-09-02 00:00:00.000000', '2024-10-20 00:00:00.000000', 1, 'A beautiful Showa koi', 1, 27, 'Showa', 656, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Isa%20Showa%20Tosai%2027cm.png', 1, 29),
(44, '2023-01-06 00:00:00.000000', '2023-03-19 00:00:00.000000', 1, 'A beautiful Ginrin Kohaku koi', 1, 29, 'Ginrin Kohaku', 880, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Torazo%20Ginrin%20Kohaku%2029cm%20Tosai.png', 18, 27),
(45, '2023-09-18 00:00:00.000000', '2024-11-04 00:00:00.000000', 1, 'A beautiful Ginrin Kohaku koi', 1, 22, 'Ginrin Kohaku', 855, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Torazo%20Ginrin%20Kohaku%20Tosai%2022cm.png', 3, 26),
(46, '2024-08-13 00:00:00.000000', '2024-11-07 00:00:00.000000', 1, 'A beautiful Karashigoi koi', 1, 22, 'Karashigoi', 25, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Karashigoi%20Tosai%2022cm.png', 5, 27),
(47, '2024-04-08 00:00:00.000000', '2024-08-04 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 32, 'Shiro Utsuri', 50, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Shiro%20Utsuri%20Tosai%2032cm.png', 3, 24),
(48, '2024-04-15 00:00:00.000000', '2024-08-27 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 25, 'Shiro Utsuri', 50, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Shiro%20Utsuri%20Tosai%20.png', 19, 36),
(49, '2023-02-09 00:00:00.000000', '2024-01-09 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 21, 'Shiro Utsuri', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Shiro%20Utsuri%20%20tosai%2021cm.png', 14, 30),
(50, '2023-07-20 00:00:00.000000', '2023-11-19 00:00:00.000000', 1, 'A beautiful Showa koi', 1, 22, 'Showa', 852, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/NND%20Showa%2022cm%20tosai.png', 3, 36),
(51, '2023-04-14 00:00:00.000000', '2024-03-30 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 30, 'Shiro Utsuri', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Shiro%20Utsuri%20%2030cm.png', 2, 24),
(52, '2023-10-29 00:00:00.000000', '2024-11-23 00:00:00.000000', 1, 'A beautiful Yamabuki koi', 1, 18, 'Yamabuki', 552, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/NND%20Yamabuki%20Tosai%2018cm.png', 18, 30),
(53, '2023-08-28 00:00:00.000000', '2024-09-03 00:00:00.000000', 1, 'A beautiful Dark Ochiba koi', 1, 23, 'Dark Ochiba', 967, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Dark%20Ochiba%2023cm%20tosai.png', 7, 31),
(54, '2024-05-28 00:00:00.000000', '2024-11-20 00:00:00.000000', 1, 'A beautiful Ginrin Showa koi', 1, 31, 'Ginrin Showa', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Ginrin%20Showa%20Tosai%2031cm.png', 8, 25),
(55, '2023-11-30 00:00:00.000000', '2024-08-19 00:00:00.000000', 1, 'A beautiful Ginrin Showa koi', 1, 21, 'Ginrin Showa', 716, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Ginrin%20Showa%20tosai%2021cm.png', 12, 31),
(56, '2023-05-28 00:00:00.000000', '2024-11-25 00:00:00.000000', 1, 'A beautiful Hi Utsuri koi', 1, 33, 'Hi Utsuri', 726, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Hi%20Utsuri%2033cm.png', 5, 32),
(57, '2024-06-01 00:00:00.000000', '2024-12-18 00:00:00.000000', 1, 'A beautiful Hi Utsuri koi', 1, 28, 'Hi Utsuri', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Hi%20Utsuri%20Tosai%2028cm.png', 18, 31),
(58, '2023-01-16 00:00:00.000000', '2023-08-29 00:00:00.000000', 1, 'A beautiful Ginrin Kohaku koi', 1, 18, 'Ginrin Kohaku', 50, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Torazo%20Ginrin%20Kohaku%2018cm.png', 1, 26),
(59, '2024-12-19 00:00:00.000000', '2024-12-23 00:00:00.000000', 1, 'A beautiful Ginrin Kohaku koi', 1, 17, 'Ginrin Kohaku', 50, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Torazo%20GinRin%20Kohaku%20Tosai%2017cm.png', 11, 33),
(60, '2023-08-31 00:00:00.000000', '2024-02-02 00:00:00.000000', 1, 'A beautiful Ginrin Kohaku koi', 1, 26, 'Ginrin Kohaku', 614, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Torazo%20Ginrin%20Kohaku%20Tosai%2026cm%20.png', 16, 24),
(61, '2023-02-13 00:00:00.000000', '2024-01-21 00:00:00.000000', 1, 'A beautiful Ginrin Showa koi', 1, 33, 'Ginrin Showa', 850, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Ginrin%20Showa%20tosai%2033cm.png', 16, 32),
(62, '2023-12-11 00:00:00.000000', '2024-09-11 00:00:00.000000', 1, 'A beautiful Doitsu Kohaku koi', 1, 31, 'Doitsu Kohaku', 100, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Doitsu%20Kohaku%20Tosai%2031.png', 14, 31),
(63, '2023-12-22 00:00:00.000000', '2024-09-23 00:00:00.000000', 1, 'A beautiful Kohaku koi', 1, 21, 'Kohaku', 50, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Torazo%20Kohaku%20Tosai%2021cm.png', 3, 34),
(64, '2024-12-30 00:00:00.000000', '2024-12-30 00:00:00.000000', 1, 'A beautiful Kohaku koi', 1, 23, 'Kohaku', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Torazo%20Kohaku%2023cm%20tosai%20.png', 19, 33),
(65, '2024-06-20 00:00:00.000000', '2024-09-02 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 22, 'Shiro Utsuri', 50, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Shiro%20Utsuri%20Tosai%2022cm.png', 16, 26),
(66, '2024-10-22 00:00:00.000000', '2024-11-13 00:00:00.000000', 1, 'A beautiful Kohaku koi', 1, 21, 'Kohaku', 50, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Torazo%20Kohaku%20Tosai%2021cm%202.png', 20, 25),
(67, '2024-06-30 00:00:00.000000', '2024-08-11 00:00:00.000000', 1, 'A beautiful Hi Utsuri koi', 1, 33, 'Hi Utsuri', 50, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Hi%20Utsuri%2033cm%20Nisai%20png.png', 20, 24),
(68, '2024-04-28 00:00:00.000000', '2024-08-24 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 1, 34, 'Doitsu Showa', 962, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Hiroi%20Doitsu%20Showa%2034cm%20Nisai.png', 20, 34),
(69, '2023-04-07 00:00:00.000000', '2024-04-23 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 36, 'Showa', 912, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Isa%20Showa%20Nisai%2036cm.png', 7, 37),
(70, '2024-09-30 00:00:00.000000', '2024-11-17 00:00:00.000000', 2, 'A beautiful Doitsu Sanke koi', 1, 40, 'Doitsu Sanke', 556, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Hiroi%20Doitsu%20Sanke%2040cm%20Nisai.png', 7, 29),
(71, '2024-07-27 00:00:00.000000', '2024-10-15 00:00:00.000000', 2, 'A beautiful Ginrin Matsukawabake koi', 1, 34, 'Ginrin Matsukawabake', 50, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Iwashita%20Ginrin%20Matsukawabake%2034cm%20Nisai.png', 12, 26),
(72, '2024-01-08 00:00:00.000000', '2024-10-23 00:00:00.000000', 2, 'A beautiful Ai Goromo koi', 1, 33, 'Ai Goromo', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Izumiya%20Ai%20Goromo%2033cm%20Nisai.png', 8, 26),
(73, '2024-07-27 00:00:00.000000', '2024-11-05 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 35, 'Kohaku', 50, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Izumiya%20Kohaku%20nisai%2035cm.png', 2, 34),
(74, '2024-05-31 00:00:00.000000', '2024-10-29 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 31, 'Sanke', 50, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Izumiya%20Sanke%2031cm%20Nisai.png', 18, 32),
(75, '2023-04-27 00:00:00.000000', '2023-12-18 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 35, 'Sanke', 50, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Izumiya%20Sanke%2035cm%20Nisai.png', 3, 37),
(76, '2024-08-02 00:00:00.000000', '2024-10-14 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 33, 'Sanke', 769, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Izumiya%20Sanke%20Nisai%2033cm.png', 17, 25),
(77, '2023-07-16 00:00:00.000000', '2023-09-06 00:00:00.000000', 2, 'A beautiful Ginrin Goshiki koi', 1, 48, 'Ginrin Goshiki', 702, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Kanno%20Ginrin%20Goshiki%20Nisai%2048cm.png', 12, 29),
(78, '2023-11-27 00:00:00.000000', '2024-06-16 00:00:00.000000', 2, 'A beautiful Tancho Goshiki koi', 1, 39, 'Tancho Goshiki', 288, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Kanno%20Tancho%20Goshiki%20Nisai%2039cm.png', 18, 35),
(79, '2023-01-18 00:00:00.000000', '2024-06-07 00:00:00.000000', 2, 'A beautiful Bekko koi', 1, 27, 'Bekko', 50, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Bekko%20Nisai%2027cm.png', 8, 27),
(80, '2024-07-24 00:00:00.000000', '2024-09-17 00:00:00.000000', 2, 'A beautiful Ochiba koi', 1, 44, 'Ochiba', 480, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Ochiba%20Nisai%2044cm.png', 1, 30),
(81, '2024-02-26 00:00:00.000000', '2024-07-16 00:00:00.000000', 2, 'A beautiful Goshiki koi', 1, 37, 'Goshiki', 739, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Kanno%20Goshiki%20Nisai%2037cm.png', 9, 27),
(82, '2023-07-07 00:00:00.000000', '2023-09-10 00:00:00.000000', 2, 'A beautiful Doitsu Aragoke Ginrin Chagoi koi', 1, 42, 'Doitsu Aragoke Ginrin Chagoi', 50, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Doitsu%20Aragoke%20Ginrin%20Chagoi%20Nisai%2042cm.png', 13, 36),
(83, '2024-10-23 00:00:00.000000', '2024-12-06 00:00:00.000000', 2, 'A beautiful Ginrin Ochiba koi', 1, 44, 'Ginrin Ochiba', 50, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Ginrin%20Ochiba%20Nisai%2044cm.png', 17, 27),
(84, '2023-01-28 00:00:00.000000', '2024-06-25 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 40, 'Showa', 393, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Izumiya%20Showa%20nisai%2040cm.png', 8, 29),
(85, '2024-01-13 00:00:00.000000', '2024-06-29 00:00:00.000000', 2, 'A beautiful Soragoi koi', 1, 40, 'Soragoi', 558, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Soragoi%20Nisai%2040cm.png', 4, 25),
(86, '2024-12-05 00:00:00.000000', '2024-12-29 00:00:00.000000', 2, 'A beautiful Asagi koi', 1, 38, 'Asagi', 381, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Maruhiro%20Asagi%20Nisai%2038cm.png', 13, 35),
(87, '2023-10-15 00:00:00.000000', '2024-01-26 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 1, 46, 'Shiro Utsuri', 182, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/NND%20Shiro%20Utsuri%2046cm%20Nisai.png', 17, 33),
(88, '2023-02-09 00:00:00.000000', '2023-04-07 00:00:00.000000', 2, 'A beautiful Budo Goromo koi', 1, 28, 'Budo Goromo', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Ootsuka%20Budo%20Goromo%20Nisai.png', 3, 32),
(89, '2024-03-06 00:00:00.000000', '2024-03-15 00:00:00.000000', 2, 'A beautiful Hi Utsuri koi', 1, 30, 'Hi Utsuri', 50, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Shinoda%20Hi%20Utsuri%20Nisai%2030cm.png', 4, 24),
(90, '2024-04-20 00:00:00.000000', '2024-08-10 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 28, 'Showa', 162, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Izumiya%20Showa%20Nisai%2028cm.png', 5, 37),
(91, '2024-10-18 00:00:00.000000', '2024-11-27 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 42, 'Showa', 50, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Izumiya%20Showa%20Nisai%2042cm.png', 9, 33),
(92, '2023-02-22 00:00:00.000000', '2023-11-03 00:00:00.000000', 2, 'A beautiful Ginrin Aragoke Chagoi koi', 1, 33, 'Ginrin Aragoke Chagoi', 734, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Ginrin%20Aragoke%20Chagoi.png', 1, 31),
(93, '2024-04-27 00:00:00.000000', '2024-04-27 00:00:00.000000', 3, 'A beautiful Sanke koi', 1, 47, 'Sanke', 50, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Izumiya%20Sanke%20sansai%2047cm.png', 2, 32),
(94, '2023-06-16 00:00:00.000000', '2024-04-28 00:00:00.000000', 3, 'A beautiful Red Karashigoi koi', 1, 60, 'Red Karashigoi', 200, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Marudo%20Karashigoi%20Sansai%2060cm.png', 7, 28),
(95, '2023-07-15 00:00:00.000000', '2024-11-27 00:00:00.000000', 3, 'A beautiful Magoi koi', 1, 49, 'Magoi', 25, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Hirashin%20Magoi%20Sansai%2049cm.png', 6, 35),
(96, '2023-03-11 00:00:00.000000', '2023-11-23 00:00:00.000000', 3, 'A beautiful Showa koi', 1, 58, 'Showa', 809, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Sekiguchi%20Showa%20Sansai%2058cm.png', 11, 26),
(97, '2023-02-19 00:00:00.000000', '2023-09-02 00:00:00.000000', 3, 'A beautiful Magoi koi', 1, 48, 'Magoi', 735, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/3/photos/Hirashin%20Magoi%20Sansai%2048cm.png', 4, 33),
(98, '2023-06-17 00:00:00.000000', '2023-12-22 00:00:00.000000', 1, 'A beautiful Kohaku koi', 1, 15, 'Kohaku', 957, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Torazo%20Kohaku%2015cm%20Tosai.png', 1, 29),
(99, '2024-06-05 00:00:00.000000', '2024-11-19 00:00:00.000000', 1, 'A beautiful Ginrin Kohaku koi', 1, 15, 'Ginrin Kohaku', 487, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Torazo%20Ginrin%20Kohaku%2015cm%20Tosai.png', 10, 33),
(100, '2024-03-28 00:00:00.000000', '2024-12-27 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 18, 'Shiro Utsuri', 50, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2018cm.png', 16, 34),
(101, '2024-04-16 00:00:00.000000', '2024-10-05 00:00:00.000000', 1, 'A beautiful Ginrin Kohaku koi', 1, 18, 'Ginrin Kohaku', 232, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Torazo%20Ginrin%20Kohaku%2018cm%20Tosai.png', 1, 29),
(102, '2023-09-09 00:00:00.000000', '2024-07-30 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 19, 'Shiro Utsuri', 50, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2019cm.png', 17, 27),
(103, '2024-08-16 00:00:00.000000', '2024-09-19 00:00:00.000000', 1, 'A beautiful Showa koi', 1, 19, 'Showa', 50, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/ISA%20Showa%2019cm%20Tosai.png', 14, 24),
(104, '2024-01-01 00:00:00.000000', '2024-05-29 00:00:00.000000', 1, 'A beautiful Kohaku koi', 1, 20, 'Kohaku', 736, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Torazo%20Kohaku%2020cm%20Tosai%20', 11, 36),
(105, '2023-09-28 00:00:00.000000', '2024-06-25 00:00:00.000000', 1, 'A beautiful Tancho Sanke koi', 1, 20, 'Tancho Sanke', 416, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Torazo%20Tancho%20Sanke%2020cm%20Tosai.png', 17, 28),
(106, '2023-12-12 00:00:00.000000', '2024-07-22 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 21, 'Shiro Utsuri', 50, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2021cm%202.png', 11, 36),
(107, '2023-02-20 00:00:00.000000', '2024-01-31 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 21, 'Shiro Utsuri', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2021cm%203.png', 12, 27),
(108, '2023-12-26 00:00:00.000000', '2024-05-15 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 21, 'Shiro Utsuri', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2021cm.png', 11, 25),
(109, '2023-02-20 00:00:00.000000', '2024-10-03 00:00:00.000000', 1, 'A beautiful Showa koi', 1, 21, 'Showa', 709, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/ISA%20Showa%2021cm%20Tosai.png', 8, 31),
(110, '2023-09-03 00:00:00.000000', '2023-10-20 00:00:00.000000', 1, 'A beautiful Showa koi', 1, 22, 'Showa', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/ISA%20Showa%2022cm%20Tosai.png', 18, 31),
(111, '2023-09-05 00:00:00.000000', '2023-09-30 00:00:00.000000', 1, 'A beautiful Yamabuki koi', 1, 22, 'Yamabuki', 915, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/NND%20Yamibuki%20Tosai%2022cm%20.png', 20, 25),
(112, '2024-01-31 00:00:00.000000', '2024-08-16 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 22, 'Shiro Utsuri', 749, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2022cm%203.png', 19, 37),
(113, '2024-10-11 00:00:00.000000', '2024-12-27 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 22, 'Shiro Utsuri', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2022cm%205.png', 4, 25),
(114, '2023-12-17 00:00:00.000000', '2024-02-12 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 22, 'Shiro Utsuri', 50, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2022cm%206.png', 11, 28),
(115, '2023-03-31 00:00:00.000000', '2023-08-03 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 22, 'Shiro Utsuri', 50, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2022cm%204.png', 19, 37),
(116, '2023-10-23 00:00:00.000000', '2023-11-08 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 22, 'Shiro Utsuri', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2022cm%207.png', 2, 26),
(117, '2024-02-20 00:00:00.000000', '2024-08-29 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 22, 'Shiro Utsuri', 50, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2022cm.png', 5, 32),
(118, '2023-04-23 00:00:00.000000', '2023-11-12 00:00:00.000000', 1, 'A beautiful Yellow Monkey koi', 1, 22, 'Yellow Monkey', 181, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Yellow_Monkey_22cm_Tosai.png', 13, 25),
(119, '2023-07-24 00:00:00.000000', '2024-08-26 00:00:00.000000', 1, 'A beautiful Showa koi', 1, 23, 'Showa', 784, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/ISA%20Showa%2023cm%20Tosai%20', 14, 35),
(120, '2023-12-08 00:00:00.000000', '2024-07-16 00:00:00.000000', 1, 'A beautiful Showa koi', 1, 23, 'Showa', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/ISA%20Showa%2023cm%20Tosai.png', 12, 33),
(121, '2023-04-30 00:00:00.000000', '2024-07-21 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 23, 'Shiro Utsuri', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2023cm%202.png', 15, 34),
(122, '2024-06-23 00:00:00.000000', '2024-09-11 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 23, 'Shiro Utsuri', 883, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2023cm.png', 4, 25),
(123, '2023-11-17 00:00:00.000000', '2024-04-05 00:00:00.000000', 1, 'A beautiful Yellow Monkey koi', 1, 23, 'Yellow Monkey', 562, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Dainichi%20Ginrin%20Chagoi%2023cm%20Tosai.png', 15, 28),
(124, '2024-02-13 00:00:00.000000', '2024-03-06 00:00:00.000000', 1, 'A beautiful Showa koi', 1, 24, 'Showa', 454, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/ISA%20Showa%2024cm%20Tosai.png', 13, 35),
(125, '2024-05-27 00:00:00.000000', '2024-08-16 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 24, 'Shiro Utsuri', 50, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2024cm%203.png', 17, 36),
(126, '2023-03-27 00:00:00.000000', '2024-04-09 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 24, 'Shiro Utsuri', 50, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2024cm%204.png', 11, 33),
(127, '2024-06-30 00:00:00.000000', '2024-09-03 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 24, 'Shiro Utsuri', 50, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2024cm.png', 11, 27),
(128, '2024-01-16 00:00:00.000000', '2024-12-05 00:00:00.000000', 1, 'A beautiful Kujaku koi', 1, 24, 'Kujaku', 344, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Kujaku_24cm_Tosai.png', 13, 36),
(129, '2023-03-02 00:00:00.000000', '2023-06-24 00:00:00.000000', 1, 'A beautiful Ginrin Kohaku koi', 1, 25, 'Ginrin Kohaku', 569, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Torazo%20Ginrin%20Kohaku%20Tosai%2025cm.png', 12, 29),
(130, '2023-06-07 00:00:00.000000', '2024-02-03 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 25, 'Shiro Utsuri', 50, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2025cm%202.png', 7, 24),
(131, '2023-01-14 00:00:00.000000', '2023-11-19 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 25, 'Shiro Utsuri', 50, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2025cm.png', 3, 29),
(132, '2024-06-22 00:00:00.000000', '2024-07-24 00:00:00.000000', 1, 'A beautiful Yellow Monkey koi', 1, 25, 'Yellow Monkey', 192, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Dainichi%20Gin%20Rin%20Chagoi%2025cm%20Tosai.png', 7, 24),
(133, '2023-10-05 00:00:00.000000', '2024-01-08 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 26, 'Shiro Utsuri', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2026cm%202.png', 6, 26),
(134, '2023-09-17 00:00:00.000000', '2023-10-19 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 26, 'Sanke', 288, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Izumiya%20Showa%2026cm%20Nisai.png', 9, 28),
(135, '2023-11-08 00:00:00.000000', '2024-12-06 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 26, 'Shiro Utsuri', 50, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2026cm.png', 3, 29),
(136, '2023-11-30 00:00:00.000000', '2024-03-17 00:00:00.000000', 1, 'A beautiful Shiro Utsuri koi', 1, 28, 'Shiro Utsuri', 50, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Shiro%20Utsuri%2028cm.png', 7, 35),
(137, '2023-01-03 00:00:00.000000', '2024-07-02 00:00:00.000000', 1, 'A beautiful Doitsu Shiro Utsuri koi', 1, 28, 'Doitsu Shiro Utsuri', 929, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Omosako%20Tosai%20Doitsu%20Shiro%20Utsuri%2028cm.png', 13, 29),
(138, '2024-03-17 00:00:00.000000', '2024-08-11 00:00:00.000000', 1, 'A beautiful Yellow Monkey koi', 1, 28, 'Yellow Monkey', 863, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Dainichi%20Gin%20Rin%20Chagoi%2028cm%20Tosai.png', 17, 33),
(139, '2023-05-22 00:00:00.000000', '2023-06-01 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 29, 'Sanke', 623, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Izumiya%20Sanke%2029cm%20Nisai.png', 19, 34),
(140, '2024-10-30 00:00:00.000000', '2024-11-16 00:00:00.000000', 1, 'A beautiful Yellow Monkey koi', 1, 29, 'Yellow Monkey', 885, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Dainichi%20Gin%20Rin%20Chagoi%2029cm%20Tosai.png', 13, 34),
(141, '2024-10-21 00:00:00.000000', '2024-11-18 00:00:00.000000', 1, 'A beautiful Doitsu Sanke koi', 1, 30, 'Doitsu Sanke', 967, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Shinoda%20Doitsu%20Sanke%2030cm%20Tosai.png', 3, 35),
(142, '2024-05-03 00:00:00.000000', '2024-05-11 00:00:00.000000', 1, 'A beautiful Yellow Monkey koi', 1, 32, 'Yellow Monkey', 342, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Dainichi%20Gin%20Rin%20Chagoi%2032cm%20Tosai.png', 15, 26),
(143, '2023-10-06 00:00:00.000000', '2024-02-13 00:00:00.000000', 1, 'A beautiful Yellow Monkey koi', 1, 33, 'Yellow Monkey', 577, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Dainichi%20Gin%20Rin%20Chagoi%2033cm%20tosai.png', 12, 34),
(144, '2023-08-11 00:00:00.000000', '2024-02-14 00:00:00.000000', 1, 'A beautiful Yellow Monkey koi', 1, 33, 'Yellow Monkey', 225, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/4/photos/Dainichi%20Gin%20Rin%20Chagoi%20Tosai%2033cm.png', 6, 31),
(145, '2024-04-19 00:00:00.000000', '2024-11-11 00:00:00.000000', 2, 'A beautiful Ginrin Showa koi', 1, 37, 'Ginrin Showa', 210, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/8-37%20Gin%20Rin%20Showa.png', 10, 26),
(146, '2024-02-18 00:00:00.000000', '2024-03-10 00:00:00.000000', 2, 'A beautiful Ginrin Showa koi', 1, 46, 'Ginrin Showa', 811, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/9-46%20Gin%20Rin%20Showa.png', 17, 31),
(147, '2024-08-11 00:00:00.000000', '2024-12-30 00:00:00.000000', 2, 'A beautiful Doitsu Tancho Showa koi', 1, 41, 'Doitsu Tancho Showa', 677, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/13-41%20Doitsu%20Tancho%20Showa.png', 1, 25),
(148, '2023-04-22 00:00:00.000000', '2024-04-30 00:00:00.000000', 2, 'A beautiful Ginrin Showa koi', 1, 40, 'Ginrin Showa', 915, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/10-40%20Gin%20Rin%20Showa.png', 5, 31),
(149, '2023-04-05 00:00:00.000000', '2024-01-12 00:00:00.000000', 2, 'A beautiful Doitsu Shiro Utsuri koi', 1, 41, 'Doitsu Shiro Utsuri', 210, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/12-41%20Doitsu%20Shiro%20Utsuri.png', 11, 28),
(150, '2023-02-11 00:00:00.000000', '2024-10-04 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 1, 42, 'Doitsu Showa', 210, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/15-42%20Doitsu%20Showa.png', 11, 27),
(151, '2023-12-08 00:00:00.000000', '2024-04-05 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 1, 40, 'Doitsu Showa', 188, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/16-40%20Doitsu%20Showa.png', 1, 37),
(152, '2024-11-04 00:00:00.000000', '2024-12-23 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 1, 44, 'Doitsu Showa', 154, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/17-44%20Doitsu%20Showa.png', 16, 30),
(153, '2024-05-08 00:00:00.000000', '2024-09-21 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 1, 42, 'Doitsu Showa', 210, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/19-42%20Doitsu%20Showa.png', 1, 30),
(154, '2024-12-03 00:00:00.000000', '2024-12-08 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 1, 45, 'Doitsu Showa', 605, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/21-45%20Doitsu%20Showa.png', 9, 33),
(155, '2024-03-05 00:00:00.000000', '2024-10-06 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 1, 40, 'Doitsu Showa', 210, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/22-40%20Doitsu%20Showa.png', 14, 29),
(156, '2024-09-21 00:00:00.000000', '2024-11-10 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 1, 44, 'Doitsu Showa', 210, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/24-44%20Doitsu%20Showa.png', 5, 25),
(157, '2024-09-11 00:00:00.000000', '2024-11-18 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 1, 40, 'Doitsu Showa', 268, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/27-40%20Doitsu%20Showa.png', 5, 27),
(158, '2023-07-16 00:00:00.000000', '2024-06-05 00:00:00.000000', 3, 'A beautiful Showa koi', 1, 65, 'Showa', 345, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/32-65%20Showa.png', 16, 32),
(159, '2024-06-24 00:00:00.000000', '2024-09-13 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 44, 'Showa', 210, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/4-44%20Showa.png', 10, 24),
(160, '2023-02-21 00:00:00.000000', '2024-02-26 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 1, 42, 'Doitsu Showa', 625, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/20-42%20Doitsu%20Showa.png?t=2023-11-03T14%3A52%3A53.891Z', 7, 24),
(161, '2023-09-18 00:00:00.000000', '2024-03-07 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 1, 35, 'Doitsu Showa', 210, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/25-35%20Doitsu%20Showa.png?t=2023-11-03T14%3A58%3A23.649Z', 2, 24),
(162, '2023-03-09 00:00:00.000000', '2023-10-24 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 1, 46, 'Doitsu Showa', 210, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/29-46%20Doitsu%20Showa.png', 19, 27),
(163, '2024-07-11 00:00:00.000000', '2024-11-04 00:00:00.000000', 3, 'A beautiful Ginrin Showa koi', 1, 55, 'Ginrin Showa', 925, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/31-55%20Gin%20Rin%20Showa.png', 5, 36),
(164, '2024-09-06 00:00:00.000000', '2024-11-30 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 44, 'Showa', 888, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/1-44%20Showa.png', 1, 24),
(165, '2024-09-09 00:00:00.000000', '2024-10-23 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 43, 'Showa', 210, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/2-43%20Showa.png', 7, 34),
(166, '2023-05-20 00:00:00.000000', '2023-06-01 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 46, 'Showa', 210, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/3-46%20Showa.png', 6, 36),
(167, '2024-07-18 00:00:00.000000', '2024-08-06 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 47, 'Showa', 846, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/5-47%20Showa.png', 19, 37),
(168, '2023-07-10 00:00:00.000000', '2024-10-23 00:00:00.000000', 2, 'A beautiful Tancho Kohaku koi', 1, 42, 'Tancho Kohaku', 591, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/6-42%20Tacnho%20Kohaku.png', 13, 29),
(169, '2023-07-23 00:00:00.000000', '2023-11-21 00:00:00.000000', 2, 'A beautiful Ginrin Showa koi', 1, 47, 'Ginrin Showa', 771, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/7-47%20Gin%20Rin%20Showa.png', 20, 28),
(170, '2023-10-02 00:00:00.000000', '2024-05-09 00:00:00.000000', 2, 'A beautiful Ginrin Showa koi', 1, 39, 'Ginrin Showa', 532, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/11-39%20Gin%20Rin%20Showa.png', 10, 32),
(171, '2024-12-23 00:00:00.000000', '2024-12-27 00:00:00.000000', 2, 'A beautiful Doitsu Tancho Showa koi', 1, 45, 'Doitsu Tancho Showa', 625, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/14-45%20Tancho%20Doitsu%20Showa.png', 3, 30),
(172, '2023-09-16 00:00:00.000000', '2024-07-23 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 1, 38, 'Doitsu Showa', 210, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/18-38%20Doitsu%20Showa.png', 17, 32),
(173, '2023-08-01 00:00:00.000000', '2023-09-07 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 1, 42, 'Doitsu Showa', 210, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/23-42%20Doitsu%20Showa.png', 7, 25),
(174, '2023-05-21 00:00:00.000000', '2024-07-04 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 1, 41, 'Doitsu Showa', 237, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/26-41%20Doitsu%20Showa.png', 12, 34);
INSERT INTO `kois` (`id`, `created_at`, `updated_at`, `age`, `description`, `is_display`, `length`, `name`, `base_price`, `sex`, `status`, `thumbnail`, `category_id`, `owner_id`) VALUES
(175, '2023-11-01 00:00:00.000000', '2024-05-24 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 1, 42, 'Doitsu Showa', 210, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/28-42%20Doitsu%20Showa.png', 4, 27),
(176, '2024-09-18 00:00:00.000000', '2024-12-06 00:00:00.000000', 2, 'A beautiful Doitsu Showa koi', 1, 46, 'Doitsu Showa', 507, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/5/photos2/30-46%20Doitsu%20Showa.png', 18, 35),
(177, '2023-06-12 00:00:00.000000', '2023-08-07 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 42, 'Kohaku', 494, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No1%202y%20Kohaku%20Female%2042cm.png', 7, 27),
(178, '2024-07-30 00:00:00.000000', '2024-10-16 00:00:00.000000', 2, 'A beautiful Platinum Ogon koi', 1, 56, 'Platinum Ogon', 589, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No2%202y%20Plutinum%2056cm%20Female.png', 13, 26),
(179, '2024-07-07 00:00:00.000000', '2024-10-11 00:00:00.000000', 2, 'A beautiful Karashigoi koi', 1, 55, 'Karashigoi', 540, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No3%202y%20Karashi%2055cm%20Female.png', 12, 24),
(180, '2023-04-03 00:00:00.000000', '2024-10-22 00:00:00.000000', 3, 'A beautiful Kohaku koi', 1, 71, 'Kohaku', 501, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No4%204y%20Kohaku%2071cm%20Female.png?t=2023-11-03T15%3A57%3A14.528Z', 5, 32),
(181, '2023-10-09 00:00:00.000000', '2024-06-17 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 42, 'Sanke', 410, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No5%202y%20Sanke%2042cm%20Male.png', 20, 33),
(182, '2024-01-11 00:00:00.000000', '2024-05-24 00:00:00.000000', 2, 'A beautiful Ginrin Tancho Kohaku koi', 1, 42, 'Ginrin Tancho Kohaku', 540, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No6%202y%20Ginrin%20Tancho%2042cm%20Female.png', 16, 35),
(183, '2024-06-11 00:00:00.000000', '2024-06-15 00:00:00.000000', 3, 'A beautiful Metallic Doitsu Karasugoi koi', 1, 55, 'Metallic Doitsu Karasugoi', 540, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No7%203y%20Metallic%20Doitsu%20Karasugoi%2055cm%20Female.png?t=2023-11-03T18%3A02%3A30.791Z', 2, 34),
(184, '2023-05-02 00:00:00.000000', '2023-10-06 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 50, 'Kohaku', 640, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No8%202y%20Kohaku%2050cm%20Female.png', 5, 29),
(185, '2023-07-21 00:00:00.000000', '2023-09-21 00:00:00.000000', 2, 'A beautiful Koromo Showa koi', 1, 43, 'Koromo Showa', 340, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No9%202y%20Koromo%20Showa%2043cm%20Female.png', 9, 24),
(186, '2023-11-29 00:00:00.000000', '2024-08-22 00:00:00.000000', 2, 'A beautiful Tancho Kohaku koi', 1, 50, 'Tancho Kohaku', 580, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No10%202y%20Tancho%20kohaku%2050cm%20Female.png?t=2023-11-03T18%3A30%3A50.742Z', 4, 32),
(187, '2023-04-17 00:00:00.000000', '2023-12-16 00:00:00.000000', 2, 'A beautiful Tancho Sanke koi', 1, 46, 'Tancho Sanke', 410, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/6/photos/No11%202y%20Tancho%20Sanke%2046cm%20Male.png', 6, 35),
(188, '2023-01-17 00:00:00.000000', '2024-01-01 00:00:00.000000', 3, 'A beautiful Yamabuki koi', 1, 60, 'Yamabuki', 680, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Yamibuki.png', 3, 24),
(189, '2023-10-04 00:00:00.000000', '2024-02-04 00:00:00.000000', 3, 'A beautiful Ginrin Chagoi koi', 1, 58, 'Ginrin Chagoi', 410, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Chagoi%206.png', 2, 34),
(190, '2024-10-06 00:00:00.000000', '2024-12-14 00:00:00.000000', 3, 'A beautiful Ginrin Chagoi koi', 1, 59, 'Ginrin Chagoi', 731, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Chagoi%20kole%20Updated%20601.png', 13, 25),
(191, '2023-09-06 00:00:00.000000', '2023-10-31 00:00:00.000000', 3, 'A beautiful Yamabuki koi', 1, 57, 'Yamabuki', 540, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Yamibuki%202.png', 7, 30),
(192, '2023-10-15 00:00:00.000000', '2024-03-12 00:00:00.000000', 3, 'A beautiful Ginrin Showa koi', 1, 49, 'Ginrin Showa', 782, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Showa.png', 3, 30),
(193, '2023-02-03 00:00:00.000000', '2024-08-04 00:00:00.000000', 3, 'A beautiful Ginrin Karashigoi koi', 1, 70, 'Ginrin Karashigoi', 351, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Karashigoi%202.png', 2, 31),
(194, '2023-12-14 00:00:00.000000', '2024-01-31 00:00:00.000000', 3, 'A beautiful Ginrin Karashigoi koi', 1, 64, 'Ginrin Karashigoi', 241, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Karashigoi.png', 18, 24),
(195, '2023-01-07 00:00:00.000000', '2024-11-20 00:00:00.000000', 2, 'A beautiful Ginrin Shiro Utsuri koi', 1, 48, 'Ginrin Shiro Utsuri', 106, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Shiro%20Utsuri.png', 17, 25),
(196, '2024-01-08 00:00:00.000000', '2024-05-19 00:00:00.000000', 3, 'A beautiful Yamabuki koi', 1, 58, 'Yamabuki', 540, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Yamabuki%205.png', 16, 27),
(197, '2024-02-29 00:00:00.000000', '2024-04-02 00:00:00.000000', 2, 'A beautiful Orenji Ogon koi', 1, 51, 'Orenji Ogon', 736, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Orenji%20Ogon.png', 11, 33),
(198, '2024-02-21 00:00:00.000000', '2024-10-28 00:00:00.000000', 2, 'A beautiful Orenji Ogon koi', 1, 48, 'Orenji Ogon', 280, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Orenji%20Ogon%202.png', 20, 28),
(199, '2024-11-12 00:00:00.000000', '2024-11-24 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 47, 'Showa', 680, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Showa%203.png', 11, 25),
(200, '2024-03-21 00:00:00.000000', '2024-12-09 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 49, 'Showa', 592, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Showa%202.png', 6, 32),
(201, '2023-03-22 00:00:00.000000', '2024-02-22 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 49, 'Showa', 680, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Showa.png', 3, 33),
(202, '2024-02-17 00:00:00.000000', '2024-11-15 00:00:00.000000', 3, 'A beautiful Yamabuki koi', 1, 62, 'Yamabuki', 540, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Yamibuki%203.png', 16, 28),
(203, '2023-10-18 00:00:00.000000', '2024-08-22 00:00:00.000000', 2, 'A beautiful Yamabuki koi', 1, 52, 'Yamabuki', 420, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Yamibuki%204.png', 4, 25),
(204, '2024-04-10 00:00:00.000000', '2024-11-03 00:00:00.000000', 2, 'A beautiful Ginrin Karashigoi koi', 1, 38, 'Ginrin Karashigoi', 150, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Karashigoi%203.png', 1, 32),
(205, '2024-11-10 00:00:00.000000', '2024-12-19 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 47, 'Kohaku', 680, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%202.png', 20, 25),
(206, '2023-09-23 00:00:00.000000', '2023-10-13 00:00:00.000000', 2, 'A beautiful Ginrin Kohaku koi', 1, 55, 'Ginrin Kohaku', 1010, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Kohaku.png', 8, 28),
(207, '2023-03-31 00:00:00.000000', '2023-08-10 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 53, 'Kohaku', 263, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%203%20updated%20618.png', 17, 25),
(208, '2024-03-07 00:00:00.000000', '2024-09-10 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 49, 'Kohaku', 960, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%206.png', 14, 35),
(209, '2023-08-26 00:00:00.000000', '2024-06-13 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 46, 'Kohaku', 1010, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%205%20updated.png', 15, 28),
(210, '2023-08-11 00:00:00.000000', '2024-05-10 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 48, 'Kohaku', 680, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%204.png', 20, 37),
(211, '2024-08-21 00:00:00.000000', '2024-10-24 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 51, 'Kohaku', 450, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%209%20Updated%20622.png', 9, 36),
(212, '2024-08-05 00:00:00.000000', '2024-10-02 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 47, 'Kohaku', 1200, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%2010%20updated%20623.png', 9, 26),
(213, '2024-04-13 00:00:00.000000', '2024-04-27 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 47, 'Kohaku', 960, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%207.png', 10, 28),
(214, '2023-03-27 00:00:00.000000', '2024-05-10 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 54, 'Kohaku', 717, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%208.png', 16, 25),
(215, '2024-11-21 00:00:00.000000', '2024-12-18 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 49, 'Kohaku', 680, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku.png', 15, 24),
(216, '2023-01-01 00:00:00.000000', '2024-01-21 00:00:00.000000', 3, 'A beautiful Kohaku koi', 1, 75, 'Kohaku', 907, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%2012%20updated.png', 1, 34),
(217, '2023-08-12 00:00:00.000000', '2024-11-04 00:00:00.000000', 2, 'A beautiful Maruten Kohaku koi', 1, 50, 'Maruten Kohaku', 960, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Kohaku%2011.png', 14, 24),
(218, '2023-02-20 00:00:00.000000', '2023-07-07 00:00:00.000000', 3, 'A beautiful Maruten Kohaku koi', 1, 75, 'Maruten Kohaku', 6800, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Maruten%20Kohaku%20updated.png?t=2023-11-15T15%3A01%3A37.654Z', 2, 32),
(219, '2024-07-09 00:00:00.000000', '2024-10-10 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 46, 'Sanke', 731, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Sanke.png', 16, 26),
(220, '2023-06-21 00:00:00.000000', '2023-12-20 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 45, 'Sanke', 1010, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Showa%205.png', 3, 32),
(221, '2024-11-20 00:00:00.000000', '2024-12-14 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 43, 'Sanke', 960, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Sanke%202.png', 3, 27),
(222, '2024-07-06 00:00:00.000000', '2024-09-19 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 46, 'Showa', 540, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Showa%204.png', 20, 34),
(223, '2024-07-19 00:00:00.000000', '2024-10-14 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 57, 'Showa', 680, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Showa%207%20updated%20634.png', 4, 30),
(224, '2023-04-07 00:00:00.000000', '2023-09-25 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 52, 'Showa', 844, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Showa%206.png', 10, 33),
(225, '2023-03-05 00:00:00.000000', '2023-08-02 00:00:00.000000', 2, 'A beautiful Tancho Sanke koi', 1, 48, 'Tancho Sanke', 1400, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Tancho%20Showa%20updated%20636.png', 20, 30),
(226, '2024-08-20 00:00:00.000000', '2024-09-25 00:00:00.000000', 2, 'A beautiful Ginrin Karashigoi koi', 1, 34, 'Ginrin Karashigoi', 140, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Chagoi%204.png', 1, 32),
(227, '2024-01-08 00:00:00.000000', '2024-09-08 00:00:00.000000', 2, 'A beautiful Ginrin Karashigoi koi', 1, 36, 'Ginrin Karashigoi', 210, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/7/thumbs/Gin%20Rin%20Chagoi%202%205.png', 4, 28),
(228, '2023-12-16 00:00:00.000000', '2024-04-13 00:00:00.000000', 2, 'A beautiful Ginrin Hi Utsuri koi', 1, 61, 'Ginrin Hi Utsuri', 418, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Gin%20Rin%20Hi%20Utsuri%20Female%20......%2061cm.png', 20, 33),
(229, '2024-06-29 00:00:00.000000', '2024-07-31 00:00:00.000000', 2, 'A beautiful Ginrin Ki Matsuba koi', 1, 56, 'Ginrin Ki Matsuba', 571, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Gin%20Rin%20Ki%20Matsuba%20Female%20Nisai%2056cm.png', 8, 30),
(230, '2023-07-28 00:00:00.000000', '2024-08-21 00:00:00.000000', 2, 'A beautiful Ginrin Kohaku koi', 1, 48, 'Ginrin Kohaku', 389, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Gin%20Rin%20Kohaku%20Female%20Nisai%2048cm.png', 4, 29),
(231, '2024-11-05 00:00:00.000000', '2024-11-24 00:00:00.000000', 2, 'A beautiful Ginrin Showa koi', 1, 51, 'Ginrin Showa', 680, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Gin%20Rin%20Showa%202%20Female%20Nisai%2051cm.png', 6, 29),
(232, '2023-12-11 00:00:00.000000', '2024-03-25 00:00:00.000000', 2, 'A beautiful Ginrin Showa koi', 1, 48, 'Ginrin Showa', 680, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Gin%20Rin%20Showa%203%20Female%20Nisai%2048cm.png', 13, 33),
(233, '2024-01-02 00:00:00.000000', '2024-02-04 00:00:00.000000', 2, 'A beautiful Ginrin Hi Utsuri koi', 1, 50, 'Ginrin Hi Utsuri', 680, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/HI%20Utsuri%20Female%20Nisai%20...2cm.png', 15, 35),
(234, '2024-10-29 00:00:00.000000', '2024-11-14 00:00:00.000000', 2, 'A beautiful Hi Utsuri koi', 1, 56, 'Hi Utsuri', 590, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/photos/Hi%20Utsuri%20Female%20Nisai%2056cm%20646.png', 7, 36),
(235, '2024-12-13 00:00:00.000000', '2024-12-29 00:00:00.000000', 2, 'A beautiful Ki Utsuri koi', 1, 56, 'Ki Utsuri', 680, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Ki%20Utsuri%20Female%20Naisai%2056cm.png', 18, 29),
(236, '2023-01-21 00:00:00.000000', '2024-05-29 00:00:00.000000', 2, 'A beautiful Kin Hi Utsuri koi', 1, 62, 'Kin Hi Utsuri', 680, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Kin%20%20Hi%20Utsuri%20Female%20Nisai%2062cm.png', 5, 36),
(237, '2023-05-18 00:00:00.000000', '2023-06-10 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 52, 'Kohaku', 680, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Kohaku%20Female%20Nisai%2052cm.png', 20, 27),
(238, '2023-03-27 00:00:00.000000', '2024-09-17 00:00:00.000000', 2, 'A beautiful Kujaku koi', 1, 51, 'Kujaku', 680, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Kujaku%20Female%20Nisai%2051cm.png', 14, 24),
(239, '2023-04-07 00:00:00.000000', '2024-03-04 00:00:00.000000', 2, 'A beautiful Ochiba koi', 1, 55, 'Ochiba', 680, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Ochiba%20Female%20Nisai%2055cm.png', 16, 28),
(240, '2023-12-28 00:00:00.000000', '2024-11-09 00:00:00.000000', 2, 'A beautiful Ogana Ochiba koi', 1, 58, 'Ogana Ochiba', 680, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Ogona%20Ochiba%20Female%20Nisai%2058cm.png', 10, 35),
(241, '2023-02-02 00:00:00.000000', '2023-09-15 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 50, 'Showa', 680, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Showa%20Female%20Nisai%2050cm.png', 12, 24),
(242, '2023-06-03 00:00:00.000000', '2024-03-02 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 53, 'Showa', 680, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Showa%20Female%20Nisai%2053cm.png', 17, 34),
(243, '2024-02-20 00:00:00.000000', '2024-09-02 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 58, 'Showa', 347, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Showa%20Female%20Nisai%2058cm.png', 1, 31),
(244, '2023-04-14 00:00:00.000000', '2024-03-30 00:00:00.000000', 2, 'A beautiful Ginrin Karashigoi koi', 1, 56, 'Ginrin Karashigoi', 719, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Yamibuki%20Female%20Nisai%2056cm.png', 11, 31),
(245, '2023-07-14 00:00:00.000000', '2023-12-01 00:00:00.000000', 2, 'A beautiful Aka Matsuba koi', 1, 51, 'Aka Matsuba', 680, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/8/thumbs/Aka%20Matsuba.png', 18, 30),
(246, '2023-08-08 00:00:00.000000', '2024-06-06 00:00:00.000000', 2, 'A beautiful Ginrin Soragoi koi', 1, 38, 'Ginrin Soragoi', 161, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/1%20Ginrin%20Soragoi%2038cm%20edited.png', 10, 36),
(247, '2024-03-14 00:00:00.000000', '2024-12-23 00:00:00.000000', 2, 'A beautiful Ai Goromo koi', 1, 37, 'Ai Goromo', 600, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/2%20Koromo%2037cm%20edited.png', 7, 35),
(248, '2024-06-04 00:00:00.000000', '2024-09-29 00:00:00.000000', 2, 'A beautiful Hi Utsuri koi', 1, 38, 'Hi Utsuri', 184, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/3%20Hi%20Utsuri%2038cm%20edited.png', 5, 30),
(249, '2024-11-04 00:00:00.000000', '2024-11-21 00:00:00.000000', 2, 'A beautiful Ochiba koi', 1, 34, 'Ochiba', 913, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/5%20Ochiba%2034cm%20edited.png', 8, 27),
(250, '2023-06-08 00:00:00.000000', '2023-07-30 00:00:00.000000', 2, 'A beautiful Kin Ki Utsuri koi', 1, 45, 'Kin Ki Utsuri', 491, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/6%20Kin%20Ki%20Utsuri%2045cm%20edited.png', 9, 33),
(251, '2024-04-16 00:00:00.000000', '2024-05-09 00:00:00.000000', 2, 'A beautiful Ginrin Ochiba koi', 1, 35, 'Ginrin Ochiba', 330, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/7%20Ginrin%20Ochiba%2035cm%20edited.png', 12, 36),
(252, '2024-02-15 00:00:00.000000', '2024-08-10 00:00:00.000000', 2, 'A beautiful Kin Showa koi', 1, 33, 'Kin Showa', 210, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/8%20Kin%20Showa%2033cm%20edited.png', 4, 37),
(253, '2023-02-14 00:00:00.000000', '2023-05-24 00:00:00.000000', 2, 'A beautiful Tancho Goshiki koi', 1, 33, 'Tancho Goshiki', 503, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/4%20Tancho%20Goshiki%2033cm%20edited.png', 19, 26),
(254, '2024-07-31 00:00:00.000000', '2024-12-19 00:00:00.000000', 2, 'A beautiful Ginrin Goshiki koi', 1, 31, 'Ginrin Goshiki', 158, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/9%20Ginrin%20Goshiki%2031cm%20edited.png', 1, 29),
(255, '2024-03-19 00:00:00.000000', '2024-04-24 00:00:00.000000', 2, 'A beautiful Ai Goromo koi', 1, 39, 'Ai Goromo', 103, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/10%20Koromo%2039cm%20edited.png', 16, 32),
(256, '2023-04-16 00:00:00.000000', '2024-02-17 00:00:00.000000', 2, 'A beautiful Ginrin Chagoi koi', 1, 36, 'Ginrin Chagoi', 149, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/11%20Ginrin%20Chagoi%2036cm%20edited.png', 6, 37),
(257, '2024-09-20 00:00:00.000000', '2024-09-29 00:00:00.000000', 2, 'A beautiful Tancho Goshiki koi', 1, 32, 'Tancho Goshiki', 718, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/12%20Tancho%20Goshiki%20Edited.png', 6, 29),
(258, '2023-06-03 00:00:00.000000', '2023-11-13 00:00:00.000000', 2, 'A beautiful Ginrin Goshiki koi', 1, 35, 'Ginrin Goshiki', 254, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/13%20Ginrin%20Goshiki%2035cm%20edited.png', 7, 24),
(259, '2024-08-23 00:00:00.000000', '2024-11-07 00:00:00.000000', 2, 'A beautiful Kikusui koi', 1, 35, 'Kikusui', 210, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/14%20Kikusui%2035cm%20edited.png', 14, 26),
(260, '2024-11-24 00:00:00.000000', '2024-12-12 00:00:00.000000', 2, 'A beautiful Hi Utsuri koi', 1, 38, 'Hi Utsuri', 496, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/15%20Hi%20Utsuri%2038cm%20edited.png', 6, 24),
(261, '2024-06-01 00:00:00.000000', '2024-12-16 00:00:00.000000', 2, 'A beautiful Ochiba koi', 1, 38, 'Ochiba', 210, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/16%20Ochiba%2038cm%20edited.png', 5, 30),
(262, '2024-01-08 00:00:00.000000', '2024-04-29 00:00:00.000000', 2, 'A beautiful Tancho Goshiki koi', 1, 30, 'Tancho Goshiki', 131, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/17%20Tancho%20Goshiki%2030cm%20edited.png', 16, 33),
(263, '2024-07-04 00:00:00.000000', '2024-10-26 00:00:00.000000', 2, 'A beautiful Goshiki koi', 1, 36, 'Goshiki', 913, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/18%20Goshiki%2036cm%20edited.png', 1, 32),
(264, '2024-03-23 00:00:00.000000', '2024-04-26 00:00:00.000000', 2, 'A beautiful Goshiki koi', 1, 33, 'Goshiki', 555, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/19%20Gohiski%2033cm%20edited.png', 7, 29),
(265, '2024-01-25 00:00:00.000000', '2024-02-18 00:00:00.000000', 2, 'A beautiful Goshiki koi', 1, 37, 'Goshiki', 892, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/20%20Goshiki%2037cm%20edited.png', 3, 35),
(266, '2023-04-13 00:00:00.000000', '2024-04-29 00:00:00.000000', 2, 'A beautiful Goshiki koi', 1, 48, 'Goshiki', 155, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/9/photos2/21%20Goshiki%2048cm%20edited.png', 13, 25),
(267, '2023-11-06 00:00:00.000000', '2024-10-24 00:00:00.000000', 3, 'A beautiful Ginrin Ochiba koi', 1, 53, 'Ginrin Ochiba', 2000, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Gin%20Rin%20Ochiba%2053cm%20Tank%204%205.png', 19, 24),
(268, '2024-05-02 00:00:00.000000', '2024-07-27 00:00:00.000000', 3, 'A beautiful Doitsu Showa koi', 1, 55, 'Doitsu Showa', 2500, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Doitsu%20Showa%2055cm%20Tank%204%205.png', 19, 30),
(269, '2024-06-23 00:00:00.000000', '2024-07-31 00:00:00.000000', 3, 'A beautiful Showa koi', 1, 47, 'Showa', 1000, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Showa%2067cm%20Tank%204%205.png', 15, 37),
(270, '2024-06-09 00:00:00.000000', '2024-08-05 00:00:00.000000', 3, 'A beautiful Maruten Showa koi', 1, 67, 'Maruten Showa', 2500, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Maruten%20Showa%2067cm%20Tank%204%205.png', 13, 37),
(271, '2023-03-02 00:00:00.000000', '2023-05-06 00:00:00.000000', 3, 'A beautiful Kujaku koi', 1, 70, 'Kujaku', 773, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Kujaku%2070cm%20Tank%204%205.png', 5, 28),
(272, '2023-05-30 00:00:00.000000', '2023-12-25 00:00:00.000000', 3, 'A beautiful Sanke koi', 1, 58, 'Sanke', 667, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Sanke%2058cm%20Tank%204%205.png', 11, 33),
(273, '2024-06-08 00:00:00.000000', '2024-09-28 00:00:00.000000', 2, 'A beautiful Hi Utsuri koi', 1, 51, 'Hi Utsuri', 824, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Hi%20Utsuri%2051cm%20Tank%204%205%202.0.png', 6, 24),
(274, '2023-07-20 00:00:00.000000', '2024-11-11 00:00:00.000000', 3, 'A beautiful Sakura Ogon koi', 1, 55, 'Sakura Ogon', 543, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Sakura%20Ogon%2055cm%20Tank%204%205.png', 8, 27),
(275, '2023-03-09 00:00:00.000000', '2024-03-17 00:00:00.000000', 3, 'A beautiful Shiro Utsuri koi', 1, 49, 'Shiro Utsuri', 470, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Shiro%20Utsuri%2049cm%20Tank%204%205.png', 18, 32),
(276, '2023-08-09 00:00:00.000000', '2024-03-15 00:00:00.000000', 3, 'A beautiful Tancho Showa koi', 1, 70, 'Tancho Showa', 185, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/10/photos/Tancho%20Showa%2070cm%20Tank%204%205%202.0.png', 14, 25),
(277, '2023-02-13 00:00:00.000000', '2024-11-03 00:00:00.000000', 2, 'A beautiful Hi Utsuri koi', 1, 35, 'Hi Utsuri', 150, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/11/photos/Hi%20Utsuri%2035cm%20Tank%206.png', 6, 33),
(278, '2024-11-04 00:00:00.000000', '2024-12-13 00:00:00.000000', 2, 'A beautiful Yellow Monkey koi', 1, 27, 'Yellow Monkey', 222, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/11/photos/Karashigoi%2027cm%20Tank%206.png', 3, 29),
(279, '2024-10-31 00:00:00.000000', '2024-11-19 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 25, 'Kohaku', 100, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/11/photos/Kohaku%2025cm%20Tank%206%201.2.png', 10, 27),
(280, '2024-08-29 00:00:00.000000', '2024-11-06 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 35, 'Sanke', 200, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/11/photos/Sanke%2035cm%20Tank%206%201.2.png', 8, 27),
(281, '2024-09-18 00:00:00.000000', '2024-10-30 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 1, 28, 'Shiro Utsuri', 856, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/11/photos/Shiro%20Utsuri%2028cm%20Tank%206.png', 4, 30),
(282, '2023-04-08 00:00:00.000000', '2023-12-11 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 41, 'Sanke', 119, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/12/photos/Sanke%2041cm%20Tank%206%201.4.png', 6, 34),
(283, '2023-08-14 00:00:00.000000', '2024-10-24 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 30, 'Kohaku', 204, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/12/photos/Kohaku%2030cm%20Tank%206%201.3.png', 16, 30),
(284, '2024-05-13 00:00:00.000000', '2024-09-19 00:00:00.000000', 2, 'A beautiful Ginrin Kohaku koi', 1, 22, 'Ginrin Kohaku', 536, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/13/photos/Gin-Rin%20Kohaku%2022cm%201.2.png', 1, 33),
(285, '2023-11-21 00:00:00.000000', '2024-05-08 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 35, 'Sanke', 123, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/13/photos/Sanke%2035cm%20Tank%206%202.5.png', 5, 31),
(286, '2024-06-05 00:00:00.000000', '2024-10-19 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 36, 'Showa', 125, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/14/photos/Showa%2036cm.png', 10, 28),
(287, '2023-03-27 00:00:00.000000', '2023-12-05 00:00:00.000000', 2, 'A beautiful Yellow Monkey koi', 1, 36, 'Yellow Monkey', 194, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/14/photos/Yellow%20Monkey%20yellow%2036cm.png', 15, 33),
(288, '2024-02-20 00:00:00.000000', '2024-11-18 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 36, 'Sanke', 150, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/14/photos/Sanke%2036cm0.png', 6, 29),
(289, '2024-03-08 00:00:00.000000', '2024-04-15 00:00:00.000000', 2, 'A beautiful Yellow Monkey koi', 1, 36, 'Yellow Monkey', 300, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/15/photos/Yellow%20Monkey%20orange%2036cm.png', 7, 28),
(290, '2023-07-26 00:00:00.000000', '2024-10-15 00:00:00.000000', 3, 'A beautiful Ai Goromo koi', 1, 43, 'Ai Goromo', 110, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/15/photos/Ai%20Goromo%2041cm.png', 14, 30),
(291, '2023-01-22 00:00:00.000000', '2024-04-02 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 35, 'Kohaku', 478, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/15/photos/AJ.png', 6, 37),
(292, '2024-10-17 00:00:00.000000', '2024-11-26 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 44, 'Showa', 891, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/16/photos/Showa%2044cm.png', 3, 33),
(293, '2024-09-24 00:00:00.000000', '2024-11-03 00:00:00.000000', 2, 'A beautiful Hi Utsuri koi', 1, 38, 'Hi Utsuri', 831, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/16/photos/Hi%20Utsuri%2038cm.png', 11, 34),
(294, '2024-01-01 00:00:00.000000', '2024-03-27 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 38, 'Kohaku', 770, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/16/photos/Kohaku%2038cm.png', 8, 35),
(295, '2023-02-18 00:00:00.000000', '2024-12-30 00:00:00.000000', 3, 'A beautiful Red Karashigoi koi', 1, 64, 'Red Karashigoi', 1000, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/17/photos/Red%20Karashigoi%2064cm2.png', 18, 25),
(296, '2024-02-18 00:00:00.000000', '2024-12-14 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 32, 'Sanke', 100, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/17/photos/Sanke%2032cm.png', 11, 24),
(297, '2024-04-22 00:00:00.000000', '2024-09-03 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 1, 27, 'Shiro Utsuri', 296, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/17/photos/Shiro%20Utsuri%2027cm.png', 8, 25),
(298, '2024-05-26 00:00:00.000000', '2024-10-04 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 37, 'Sanke', 150, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/18/photos/Sanke%2037cm.png', 12, 28),
(299, '2023-06-27 00:00:00.000000', '2024-03-06 00:00:00.000000', 3, 'A beautiful Doitsu Aragoke Black Diamond koi', 1, 51, 'Doitsu Aragoke Black Diamond', 500, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/18/photos/Aragoke%20Doitsu%20Black%20Diamond%2051cm.png', 6, 37),
(300, '2024-09-20 00:00:00.000000', '2024-11-16 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 40, 'Showa', 630, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/18/photos/Showa%2040cm.png', 12, 35),
(301, '2024-07-31 00:00:00.000000', '2024-10-22 00:00:00.000000', 2, 'A beautiful Beni Kumonryu koi', 1, 34, 'Beni Kumonryu', 250, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/19/photos/Beni%20Kumonryu%2034cm.png', 7, 34),
(302, '2023-09-18 00:00:00.000000', '2023-11-10 00:00:00.000000', 2, 'A beautiful Ai Goromo koi', 1, 37, 'Ai Goromo', 300, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/19/photos/Ai%20Goromo%2037cm2%20no%20beni%20kumonryu.png', 8, 27),
(303, '2023-07-14 00:00:00.000000', '2024-08-15 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 1, 30, 'Shiro Utsuri', 150, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/19/photos/Shiro%20Utsuri%2030cm.png', 7, 29),
(304, '2023-08-02 00:00:00.000000', '2024-08-23 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 45, 'Showa', 407, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/20/photos/Showa%2045cm0.png', 4, 36),
(305, '2023-05-02 00:00:00.000000', '2024-02-06 00:00:00.000000', 3, 'A beautiful Black Diamond koi', 1, 40, 'Black Diamond', 820, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/20/photos/Black%20Diamond%2040cm.png', 18, 26),
(306, '2023-05-17 00:00:00.000000', '2024-05-06 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 35, 'Sanke', 150, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/20/photos/Sanke%2035cm.png', 11, 26),
(307, '2024-01-12 00:00:00.000000', '2024-07-07 00:00:00.000000', 3, 'A beautiful Kohaku koi', 1, 41, 'Kohaku', 200, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/21/photos/Kohaku%2041.png', 14, 34),
(308, '2024-08-29 00:00:00.000000', '2024-09-24 00:00:00.000000', 2, 'A beautiful Doitsu Aka Matsuba koi', 1, 37, 'Doitsu Aka Matsuba', 250, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/21/photos/Doitsu%20Aka%20Matsuba%2037cm.png', 7, 30),
(309, '2023-06-26 00:00:00.000000', '2024-11-19 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 36, 'Showa', 420, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/21/photos/Showa%2036.png', 5, 31),
(310, '2023-09-22 00:00:00.000000', '2024-04-16 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 35, 'Showa', 231, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/22/photos/Showa%2035cm.png', 13, 24),
(311, '2023-05-06 00:00:00.000000', '2023-09-20 00:00:00.000000', 2, 'A beautiful Ginrin Chagoi koi', 1, 37, 'Ginrin Chagoi', 300, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/22/photos/gin-rin%20chagoi%2037cm.png', 6, 37),
(312, '2024-12-01 00:00:00.000000', '2024-12-22 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 1, 30, 'Shiro Utsuri', 919, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/22/photos/Shiro%20UTsuri%2030cm.png', 20, 32),
(313, '2023-12-19 00:00:00.000000', '2024-09-29 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 25, 'Kohaku', 100, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/23/photos/Kohaku%2025cm%20Tank%206%201.2.png', 9, 27),
(314, '2023-09-06 00:00:00.000000', '2024-11-28 00:00:00.000000', 2, 'A beautiful Yellow Monkey koi', 1, 36, 'Yellow Monkey', 486, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/23/photos/Yellow%20Monkey%20orange%2036cm.png', 8, 24),
(315, '2023-07-31 00:00:00.000000', '2024-05-13 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 36, 'Sanke', 762, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/23/photos/Sanke%2036cm0.png', 5, 27),
(316, '2024-09-22 00:00:00.000000', '2024-10-26 00:00:00.000000', 2, 'A beautiful Hi Utsuri koi', 1, 35, 'Hi Utsuri', 150, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/24/photos/Hi%20Utsuri%2035cm%20Tank%206.png', 5, 27),
(317, '2024-12-25 00:00:00.000000', '2024-12-25 00:00:00.000000', 2, 'A beautiful Ai Goromo koi', 1, 37, 'Ai Goromo', 804, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/24/photos/Ai%20Goromo%2037cm2%20no%20beni%20kumonryu.png', 4, 28),
(318, '2024-11-17 00:00:00.000000', '2024-12-13 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 1, 30, 'Shiro Utsuri', 404, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/24/photos/Shiro%20Utsuri%2030cm.png', 14, 32),
(319, '2023-05-18 00:00:00.000000', '2024-02-08 00:00:00.000000', 3, 'A beautiful Kohaku koi', 1, 41, 'Kohaku', 335, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/25/photos/Kohaku%2041.png', 3, 30),
(320, '2024-11-24 00:00:00.000000', '2024-12-05 00:00:00.000000', 2, 'A beautiful Beni Kumonryu koi', 1, 34, 'Beni Kumonryu', 412, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/25/photos/Beni%20Kumonryu%2034cm.png', 10, 37),
(321, '2024-09-17 00:00:00.000000', '2024-12-26 00:00:00.000000', 3, 'A beautiful Red Karashigoi koi', 1, 64, 'Red Karashigoi', 1000, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/25/photos/Red%20Karashigoi%2064cm2.png', 6, 33),
(322, '2024-07-25 00:00:00.000000', '2024-11-09 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 40, 'Showa', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/26/photos/Showa%2040cm.png', 17, 36),
(323, '2023-08-17 00:00:00.000000', '2024-05-28 00:00:00.000000', 2, 'A beautiful Yellow Monkey koi', 1, 35, 'Yellow Monkey', 603, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/26/photos/Yellow%20Monkey%2035cm.png', 19, 34),
(324, '2023-01-31 00:00:00.000000', '2024-11-10 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 1, 26, 'Shiro Utsuri', 644, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/26/photos/Shiro%20Utsuri%2026cm.png', 6, 31),
(325, '2024-12-27 00:00:00.000000', '2024-12-29 00:00:00.000000', 2, 'A beautiful Ai Goromo koi', 1, 43, 'Ai Goromo', 246, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/27/photos/Ai%20Goromo%2043cm.png', 15, 33),
(326, '2024-07-23 00:00:00.000000', '2024-09-29 00:00:00.000000', 3, 'A beautiful Black Diamond koi', 1, 40, 'Black Diamond', 599, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/27/photos/Black%20Diamond%2040cm.png', 2, 24),
(327, '2024-04-15 00:00:00.000000', '2024-12-28 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 41, 'Sanke', 184, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/27/photos/Sanke%2041cm.png', 10, 35),
(328, '2023-12-11 00:00:00.000000', '2024-12-13 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 35, 'Showa', 350, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/28/photos/Showa%2035cm.png', 15, 24),
(329, '2023-11-09 00:00:00.000000', '2024-05-25 00:00:00.000000', 2, 'A beautiful Yellow Monkey koi', 1, 32, 'Yellow Monkey', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/28/photos/Yellow%20Monkey%2032cm.png', 7, 31),
(330, '2024-01-30 00:00:00.000000', '2024-07-01 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 39, 'Sanke', 503, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/28/photos/Sanke%2039cm.png', 4, 24),
(331, '2024-04-05 00:00:00.000000', '2024-05-10 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 40, 'Showa', 909, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/29/photos/Showa%2040cm.png', 8, 32),
(332, '2023-09-07 00:00:00.000000', '2023-12-07 00:00:00.000000', 2, 'A beautiful Yellow Monkey koi', 1, 32, 'Yellow Monkey', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/29/photos/Yellow%20Monkey%2032cm.png', 2, 32),
(333, '2023-02-13 00:00:00.000000', '2023-11-26 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 25, 'Kohaku', 100, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/29/photos/Kohaku%2025cm%20Tank%206%201.2.png', 10, 30),
(334, '2024-05-17 00:00:00.000000', '2024-06-22 00:00:00.000000', 2, 'A beautiful Hi Utsuri koi', 1, 35, 'Hi Utsuri', 899, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/30/photos/Hi%20Utsuri%2035cm%20Tank%206.png', 8, 27),
(335, '2023-02-22 00:00:00.000000', '2023-12-02 00:00:00.000000', 3, 'A beautiful Asagi koi', 1, 46, 'Asagi', 708, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/30/photos/Asgai%2046cm.png', 12, 37),
(336, '2024-05-16 00:00:00.000000', '2024-07-26 00:00:00.000000', 2, 'A beautiful Doitsu Aka Matsuba koi', 1, 37, 'Doitsu Aka Matsuba', 250, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/30/photos/Doitsu%20Aka%20Matsuba%2037cm.png', 17, 26),
(337, '2023-01-15 00:00:00.000000', '2024-05-25 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 35, 'Sanke', 150, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/20/photos/Sanke%2035cm.png', 14, 30),
(338, '2024-01-25 00:00:00.000000', '2024-12-30 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 35, 'Showa', 350, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/28/photos/Showa%2035cm.png', 4, 34),
(339, '2024-05-10 00:00:00.000000', '2024-10-23 00:00:00.000000', 2, 'A beautiful Ginrin Chagoi koi', 1, 37, 'Ginrin Chagoi', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/22/photos/gin-rin%20chagoi%2037cm.png', 19, 36),
(340, '2023-01-19 00:00:00.000000', '2023-04-13 00:00:00.000000', 3, 'A beautiful Black Diamond koi', 1, 42, 'Black Diamond', 362, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/20/photos/Black%20Diamond%2040cm.png', 14, 28),
(341, '2023-12-16 00:00:00.000000', '2024-11-19 00:00:00.000000', 3, 'A beautiful Sanke koi', 1, 42, 'Sanke', 514, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/32/photos/Sanke%2042cm.png', 7, 31),
(342, '2024-05-21 00:00:00.000000', '2024-12-22 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 1, 32, 'Shiro Utsuri', 602, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/32/photos/Shiro%20Utsuri%2032cm.png', 16, 37),
(343, '2023-10-23 00:00:00.000000', '2024-04-04 00:00:00.000000', 3, 'A beautiful Hi Utsuri koi', 1, 44, 'Hi Utsuri', 200, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/33/photos/Hi%20Utsuri%2044cm.png', 9, 24),
(344, '2024-06-12 00:00:00.000000', '2024-12-19 00:00:00.000000', 2, 'A beautiful Yellow Monkey koi', 1, 28, 'Yellow Monkey', 300, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/33/photos/red%20Yellow%20Monkey%2028cm.png', 18, 24),
(345, '2023-02-28 00:00:00.000000', '2024-09-08 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 37, 'Sanke', 150, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/18/photos/Sanke%2037cm.png', 6, 26),
(346, '2023-03-05 00:00:00.000000', '2023-08-12 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 33, 'Sanke', 100, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/17/photos/Sanke%2032cm.png', 6, 24),
(347, '2023-09-10 00:00:00.000000', '2024-03-13 00:00:00.000000', 2, 'A beautiful Yellow Monkey koi', 1, 32, 'Yellow Monkey', 238, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/14/photos/Yellow%20Monkey%20yellow%2036cm.png', 2, 28),
(348, '2024-04-26 00:00:00.000000', '2024-10-26 00:00:00.000000', 2, 'A beautiful Ai Goromo koi', 1, 42, 'Ai Goromo', 200, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/34/photos/Ai%20Goromo%2042cm.png', 9, 33),
(349, '2023-06-27 00:00:00.000000', '2024-02-29 00:00:00.000000', 3, 'A beautiful Red Karashigoi koi', 1, 64, 'Red Karashigoi', 1000, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/17/photos/Red%20Karashigoi%2064cm2.png', 17, 26),
(350, '2023-12-03 00:00:00.000000', '2024-07-29 00:00:00.000000', 2, 'A beautiful Black Diamond koi', 1, 32, 'Black Diamond', 911, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/35/photos/Black%20Diamond%2032cm.png', 18, 37),
(351, '2023-06-11 00:00:00.000000', '2024-08-05 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 37, 'Showa', 350, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/35/photos/Showa%2037cm.png', 16, 27),
(352, '2024-05-23 00:00:00.000000', '2024-07-04 00:00:00.000000', 3, 'A beautiful Showa koi', 1, 43, 'Showa', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/36/photos/Showa%2043cm.png', 13, 31),
(353, '2023-03-12 00:00:00.000000', '2023-07-26 00:00:00.000000', 2, 'A beautiful Ginrin Chagoi koi', 1, 41, 'Ginrin Chagoi', 300, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/36/photos/Gin-Rin%20Chagoi%2041cm0.png', 5, 36),
(354, '2024-04-15 00:00:00.000000', '2024-12-29 00:00:00.000000', 2, 'A beautiful Kujaku koi', 1, 34, 'Kujaku', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/36/photos/Kujaku%2034cm.png', 9, 31),
(355, '2024-02-28 00:00:00.000000', '2024-06-04 00:00:00.000000', 2, 'A beautiful Ai Goromo koi', 1, 40, 'Ai Goromo', 300, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/37/photos/Ai%20Goromo%2040cm.png', 13, 35),
(356, '2024-02-03 00:00:00.000000', '2024-12-10 00:00:00.000000', 2, 'A beautiful Black Diamond koi', 1, 36, 'Black Diamond', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/37/photos/Black%20Diamond%2036cm.png', 12, 28),
(357, '2023-10-10 00:00:00.000000', '2024-10-27 00:00:00.000000', 2, 'A beautiful Ginrin Showa koi', 1, 34, 'Ginrin Showa', 860, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/37/photos/Gin-Rin%20Showa%2034cm.png', 15, 24);
INSERT INTO `kois` (`id`, `created_at`, `updated_at`, `age`, `description`, `is_display`, `length`, `name`, `base_price`, `sex`, `status`, `thumbnail`, `category_id`, `owner_id`) VALUES
(358, '2024-02-05 00:00:00.000000', '2024-06-05 00:00:00.000000', 2, 'A beautiful Black Diamond koi', 1, 40, 'Black Diamond', 300, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/27/photos/Black%20Diamond%2040cm.png', 17, 31),
(359, '2024-12-13 00:00:00.000000', '2024-12-24 00:00:00.000000', 3, 'A beautiful Sanke koi', 1, 52, 'Sanke', 500, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/38/photos/Showa%2052cm.png', 6, 33),
(360, '2023-04-14 00:00:00.000000', '2023-07-15 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 1, 27, 'Shiro Utsuri', 150, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/38/photos/Shiro%20Utsuri%2027cm.png', 19, 25),
(361, '2023-12-06 00:00:00.000000', '2024-06-25 00:00:00.000000', 2, 'A beautiful Black Diamond koi', 1, 34, 'Black Diamond', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/35/photos/Black%20Diamond%2032cm.png', 16, 35),
(362, '2024-11-16 00:00:00.000000', '2024-11-19 00:00:00.000000', 2, 'A beautiful Ai Goromo koi', 1, 42, 'Ai Goromo', 200, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/34/photos/Ai%20Goromo%2042cm.png', 18, 30),
(363, '2023-02-18 00:00:00.000000', '2024-01-20 00:00:00.000000', 2, 'A beautiful Ginrin Chagoi koi', 1, 37, 'Ginrin Chagoi', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/22/photos/gin-rin%20chagoi%2037cm.png', 4, 25),
(364, '2023-10-29 00:00:00.000000', '2024-03-30 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 35, 'Sanke', 150, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/18/photos/Sanke%2037cm.png', 7, 24),
(365, '2023-07-05 00:00:00.000000', '2024-08-14 00:00:00.000000', 2, 'A beautiful Doitsu Aka Matsuba koi', 1, 37, 'Doitsu Aka Matsuba', 250, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/21/photos/Doitsu%20Aka%20Matsuba%2037cm.png', 15, 24),
(366, '2024-09-25 00:00:00.000000', '2024-12-23 00:00:00.000000', 2, 'A beautiful Black Diamond koi', 1, 38, 'Black Diamond', 300, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/20/photos/Black%20Diamond%2040cm.png', 4, 29),
(367, '2023-04-23 00:00:00.000000', '2024-06-08 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 26, 'Kohaku', 100, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/11/photos/Kohaku%2025cm%20Tank%206%201.2.png', 2, 27),
(368, '2024-11-25 00:00:00.000000', '2024-12-16 00:00:00.000000', 3, 'A beautiful Hi Utsuri koi', 1, 44, 'Hi Utsuri', 130, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/33/photos/Hi%20Utsuri%2044cm.png', 1, 32),
(369, '2024-04-02 00:00:00.000000', '2024-12-09 00:00:00.000000', 2, 'A beautiful Yellow Monkey koi', 1, 35, 'Yellow Monkey', 488, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/14/photos/Yellow%20Monkey%20yellow%2036cm.png', 12, 26),
(370, '2024-02-08 00:00:00.000000', '2024-11-01 00:00:00.000000', 3, 'A beautiful Showa koi', 1, 43, 'Showa', 335, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/36/photos/Showa%2043cm.png', 20, 29),
(371, '2023-08-21 00:00:00.000000', '2024-12-20 00:00:00.000000', 2, 'A beautiful Kujaku koi', 1, 34, 'Kujaku', 300, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/36/photos/Kujaku%2034cm.png', 18, 33),
(372, '2023-01-09 00:00:00.000000', '2024-10-12 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 35, 'Sanke', 150, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/20/photos/Sanke%2035cm.png', 3, 29),
(373, '2023-09-15 00:00:00.000000', '2024-07-23 00:00:00.000000', 2, 'A beautiful Doitsu Maruten Sanke koi', 1, 38, 'Doitsu Maruten Sanke', 300, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/43/photos/Doitsu%20Sanke%2038cm.png', 6, 26),
(374, '2024-07-04 00:00:00.000000', '2024-11-14 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 1, 37, 'Shiro Utsuri', 914, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/43/photos/Shiro%20Utsuri%2037cm.png', 6, 24),
(375, '2024-07-18 00:00:00.000000', '2024-11-10 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 25, 'Showa', 439, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/43/photos/Showa%2025cm.png', 11, 28),
(376, '2023-04-26 00:00:00.000000', '2024-05-18 00:00:00.000000', 2, 'A beautiful Hi Utsuri koi', 1, 37, 'Hi Utsuri', 696, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/44/photos/Hi%20Utsuri%2037cm.png', 10, 29),
(377, '2023-09-06 00:00:00.000000', '2024-08-16 00:00:00.000000', 2, 'A beautiful Kujaku koi', 1, 39, 'Kujaku', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/44/photos/Kujaku%2039cm.png', 8, 36),
(378, '2023-12-26 00:00:00.000000', '2024-10-30 00:00:00.000000', 2, 'A beautiful Black Diamond koi', 1, 46, 'Black Diamond', 300, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/44/photos/Black%20Diamond%2046cm.png', 8, 27),
(379, '2023-11-20 00:00:00.000000', '2024-07-15 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 48, 'Kohaku', 419, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/45/photos/Kohaku%20dot%2048cm.png', 1, 34),
(380, '2024-09-11 00:00:00.000000', '2024-12-15 00:00:00.000000', 2, 'A beautiful Kage Shiro Utsuri koi', 1, 46, 'Kage Shiro Utsuri', 500, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/45/photos/Kage%20Shiro%20Utsuri%2046cm.png', 13, 31),
(381, '2023-04-25 00:00:00.000000', '2024-12-28 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 48, 'Kohaku', 278, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/45/photos/Kohaku%2048cm0.png', 10, 32),
(382, '2023-03-27 00:00:00.000000', '2024-06-03 00:00:00.000000', 3, 'A beautiful Golden Corn koi', 1, 44, 'Golden Corn', 378, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/46/photos/Golden%20Corn%2044cm.png', 12, 27),
(383, '2024-10-02 00:00:00.000000', '2024-12-17 00:00:00.000000', 3, 'A beautiful Showa koi', 1, 52, 'Showa', 1000, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/46/photos/Showa%2052cm.png', 8, 33),
(384, '2023-05-04 00:00:00.000000', '2023-09-13 00:00:00.000000', 3, 'A beautiful Karashigoi koi', 1, 47, 'Karashigoi', 934, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/46/photos/Karashigoi%2047cm.png', 15, 24),
(385, '2023-03-01 00:00:00.000000', '2023-11-20 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 1, 28, 'Shiro Utsuri', 150, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/47/photos/Shiro%20Utsuri%2028cm.png', 14, 29),
(386, '2024-11-01 00:00:00.000000', '2024-11-04 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 44, 'Showa', 724, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/47/photos/Showa%2044cm.png', 8, 31),
(387, '2024-07-07 00:00:00.000000', '2024-10-09 00:00:00.000000', 2, 'A beautiful Yellow Monkey koi', 1, 30, 'Yellow Monkey', 833, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/47/photos/Yellow%20Monkey%2030cm.png', 18, 24),
(388, '2024-10-19 00:00:00.000000', '2024-11-21 00:00:00.000000', 2, 'A beautiful Ginrin Chagoi koi', 1, 34, 'Ginrin Chagoi', 277, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/49/photos/Gin-Rin%20Chagoi%2034cm.png', 8, 28),
(389, '2023-01-19 00:00:00.000000', '2024-04-30 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 1, 35, 'Shiro Utsuri', 708, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/49/photos/Shiro%20Utsuri%2035cm.png', 20, 26),
(390, '2024-02-18 00:00:00.000000', '2024-10-25 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 43, 'Showa', 943, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/49/photos/Showa%2043cm.png', 9, 25),
(391, '2023-11-04 00:00:00.000000', '2024-05-19 00:00:00.000000', 2, 'A beautiful Black Diamond koi', 1, 39, 'Black Diamond', 715, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/48/photos/Black%20Diamond%2039cm.png', 9, 36),
(392, '2023-12-11 00:00:00.000000', '2024-10-31 00:00:00.000000', 2, 'A beautiful Kujaku koi', 1, 40, 'Kujaku', 200, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/48/photos/Kujaku%2040cm.png', 10, 37),
(393, '2024-12-29 00:00:00.000000', '2024-12-30 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 40, 'Sanke', 475, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/48/photos/Sanke%2040cm.png', 10, 26),
(394, '2023-10-31 00:00:00.000000', '2024-05-25 00:00:00.000000', 3, 'A beautiful Sanke koi', 1, 52, 'Sanke', 500, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/38/photos/Sanke%2052.png', 10, 26),
(395, '2024-10-24 00:00:00.000000', '2024-11-30 00:00:00.000000', 2, 'A beautiful Ai Goromo koi', 1, 42, 'Ai Goromo', 200, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/34/photos/Ai%20Goromo%2042cm.png', 17, 31),
(396, '2024-11-13 00:00:00.000000', '2024-12-16 00:00:00.000000', 2, 'A beautiful Ginrin Chagoi koi', 1, 41, 'Ginrin Chagoi', 965, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/36/photos/Gin-Rin%20Chagoi%2041cm0.png', 4, 33),
(397, '2024-05-09 00:00:00.000000', '2024-10-02 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 1, 27, 'Shiro Utsuri', 150, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/38/photos/Shiro%20Utsuri%2027cm.png', 17, 26),
(398, '2023-11-08 00:00:00.000000', '2024-09-03 00:00:00.000000', 2, 'A beautiful Kujaku koi', 1, 39, 'Kujaku', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/44/photos/Kujaku%2039cm.png', 14, 27),
(399, '2024-04-03 00:00:00.000000', '2024-09-23 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 40, 'Sanke', 200, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/44/photos/Sanke%2040cm.png', 12, 32),
(400, '2023-11-27 00:00:00.000000', '2024-09-15 00:00:00.000000', 2, 'A beautiful Kage Shiro Utsuri koi', 1, 46, 'Kage Shiro Utsuri', 500, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/45/photos/Kage%20Shiro%20Utsuri%2046cm.png', 3, 26),
(401, '2023-07-13 00:00:00.000000', '2023-10-31 00:00:00.000000', 2, 'A beautiful Doitsu Maruten Sanke koi', 1, 38, 'Doitsu Maruten Sanke', 300, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/43/photos/Doitsu%20Sanke%2038cm.png', 14, 31),
(402, '2024-12-13 00:00:00.000000', '2024-12-19 00:00:00.000000', 2, 'A beautiful Black Diamond koi', 1, 34, 'Black Diamond', 300, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/35/photos/Black%20Diamond%2032cm.png', 3, 27),
(403, '2023-10-12 00:00:00.000000', '2024-07-28 00:00:00.000000', 3, 'A beautiful Red Karashigoi koi', 1, 64, 'Red Karashigoi', 1000, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/25/photos/Red%20Karashigoi%2064cm2.png', 12, 24),
(404, '2024-10-25 00:00:00.000000', '2024-11-09 00:00:00.000000', 2, 'A beautiful Doitsu Aka Matsuba koi', 1, 37, 'Doitsu Aka Matsuba', 1000, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/30/photos/Doitsu%20Aka%20Matsuba%2037cm.png', 2, 24),
(405, '2023-04-06 00:00:00.000000', '2024-05-10 00:00:00.000000', 2, 'A beautiful Kujaku koi', 1, 34, 'Kujaku', 300, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/36/photos/Kujaku%2034cm.png', 5, 27),
(406, '2023-06-12 00:00:00.000000', '2023-07-10 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 39, 'Sanke', 215, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/55/photos/Sanke%2039cm.png', 10, 31),
(407, '2024-05-07 00:00:00.000000', '2024-08-07 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 1, 32, 'Shiro Utsuri', 150, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/55/photos/Shiro%20Utsuri%2032cm.png', 19, 27),
(408, '2024-02-10 00:00:00.000000', '2024-05-18 00:00:00.000000', 2, 'A beautiful Ginrin Chagoi koi', 1, 35, 'Ginrin Chagoi', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/55/photos/Gin-Rin%20Chagoi%2035cm.png', 12, 27),
(409, '2023-08-27 00:00:00.000000', '2023-10-12 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 44, 'Sanke', 175, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/56/photos/Sanke%2044cm.png', 1, 25),
(410, '2024-06-26 00:00:00.000000', '2024-09-04 00:00:00.000000', 2, 'A beautiful Chagoi koi', 1, 36, 'Chagoi', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/56/photos/Chagoi%2036cm.png', 5, 29),
(411, '2023-06-21 00:00:00.000000', '2024-10-09 00:00:00.000000', 2, 'A beautiful Shiro Muji koi', 1, 34, 'Shiro Muji', 200, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/56/photos/Shiro%20Muji%2034cm.png', 13, 35),
(412, '2023-08-18 00:00:00.000000', '2024-05-19 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 36, 'Showa', 200, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/57/photos/Showa%2036cm.png', 8, 26),
(413, '2023-12-23 00:00:00.000000', '2024-03-01 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 37, 'Showa', 674, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/57/photos/Showa%2037.png', 16, 30),
(414, '2024-09-10 00:00:00.000000', '2024-10-13 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 43, 'Showa', 250, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/57/photos/Showa%2043cm.png', 19, 33),
(415, '2024-03-07 00:00:00.000000', '2024-09-25 00:00:00.000000', 1, 'A beautiful Orenji Ogon koi', 1, 27, 'Orenji Ogon', 150, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/58/photos/Orenji%20Ogon%2027cm%20F.png', 10, 30),
(416, '2024-10-25 00:00:00.000000', '2024-12-18 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 46, 'Showa', 469, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/58/photos/Showa%2046cm%20F.png', 5, 29),
(417, '2023-04-14 00:00:00.000000', '2023-07-24 00:00:00.000000', 2, 'A beautiful Ginrin Chagoi koi', 1, 33, 'Ginrin Chagoi', 350, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/58/photos/Gin-Rin%20Chagoi%2033cm%20F.png', 7, 32),
(418, '2023-05-10 00:00:00.000000', '2024-07-12 00:00:00.000000', 3, 'A beautiful Showa koi', 1, 52, 'Showa', 1000, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/46/photos/Showa%2052cm.png', 14, 36),
(419, '2024-09-29 00:00:00.000000', '2024-10-17 00:00:00.000000', 2, 'A beautiful Black Diamond koi', 1, 46, 'Black Diamond', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/44/photos/Black%20Diamond%2046cm.png', 17, 30),
(420, '2023-03-01 00:00:00.000000', '2023-09-13 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 28, 'Kohaku', 753, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/11/photos/Kohaku%2025cm%20Tank%206%201.2.png', 12, 33),
(421, '2024-01-26 00:00:00.000000', '2024-04-20 00:00:00.000000', 2, 'A beautiful Ai Goromo koi', 1, 44, 'Ai Goromo', 150, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/60/photos/Ai%20Goromo%2044cm%20M.png', 5, 27),
(422, '2024-09-08 00:00:00.000000', '2024-10-14 00:00:00.000000', 2, 'A beautiful Sanke koi', 1, 43, 'Sanke', 480, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/60/photos/Sanke%2043cm%20U.png', 12, 34),
(423, '2023-07-25 00:00:00.000000', '2023-12-12 00:00:00.000000', 2, 'A beautiful Hi Utsuri koi', 1, 45, 'Hi Utsuri', 200, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/60/photos/Hi%20Utsuri%2045cm%20U.png', 11, 37),
(424, '2024-05-06 00:00:00.000000', '2024-06-06 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 36, 'Showa', 300, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/61/photos/Showa%2036cm%20F.png', 11, 29),
(425, '2023-07-26 00:00:00.000000', '2024-10-13 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 1, 30, 'Shiro Utsuri', 150, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/61/photos/Shiro%20Utsuri%2036cm%20F.png', 20, 35),
(426, '2023-10-18 00:00:00.000000', '2024-04-01 00:00:00.000000', 2, 'A beautiful Kujaku koi', 1, 40, 'Kujaku', 200, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/48/photos/Kujaku%2040cm.png', 17, 27),
(427, '2024-05-16 00:00:00.000000', '2024-08-10 00:00:00.000000', 3, 'A beautiful Showa koi', 1, 62, 'Showa', 349, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/62/photos/Showa%2062cm%20F.png', 18, 35),
(428, '2024-05-26 00:00:00.000000', '2024-09-26 00:00:00.000000', 2, 'A beautiful Ochiba koi', 1, 37, 'Ochiba', 450, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/62/photos/Ochiba%2037cm%20M.png', 14, 25),
(429, '2024-10-31 00:00:00.000000', '2024-11-21 00:00:00.000000', 2, 'A beautiful Tancho Goshiki koi', 1, 34, 'Tancho Goshiki', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/62/photos/Tancho%20Goshiki%2034cm%20F.png', 7, 31),
(430, '2023-12-09 00:00:00.000000', '2024-02-16 00:00:00.000000', 2, 'A beautiful Kikusui koi', 1, 33, 'Kikusui', 200, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/63/photos/Kikusui%2033cm%20F.png', 11, 35),
(431, '2024-07-08 00:00:00.000000', '2024-08-08 00:00:00.000000', 3, 'A beautiful Gin-Rin Beni Matsukawabake koi', 1, 44, 'Gin-Rin Beni Matsukawabake', 300, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/63/photos/Matsukawabake%2044cm%20F.png', 19, 34),
(432, '2023-09-18 00:00:00.000000', '2024-07-19 00:00:00.000000', 2, 'A beautiful Yamabuki koi', 1, 27, 'Yamabuki', 200, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/63/photos/Yamibuki%2027cm%20F.png', 2, 28),
(433, '2023-10-03 00:00:00.000000', '2024-09-11 00:00:00.000000', 2, 'A beautiful Ginrin Chagoi koi', 1, 34, 'Ginrin Chagoi', 300, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/64/photos/Gin-Rin%20Chagoi%2034cm%20M.png', 19, 26),
(434, '2023-05-16 00:00:00.000000', '2023-05-24 00:00:00.000000', 2, 'A beautiful Shiro Utsuri koi', 1, 35, 'Shiro Utsuri', 200, 'Male', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/64/photos/Shiro%20Utsuri%2035cm%20M.png', 13, 25),
(435, '2024-11-22 00:00:00.000000', '2024-12-28 00:00:00.000000', 2, 'A beautiful Showa koi', 1, 37, 'Showa', 184, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/35/photos/Showa%2037cm.png', 14, 27),
(436, '2023-05-21 00:00:00.000000', '2024-05-11 00:00:00.000000', 2, 'A beautiful Goshiki koi', 1, 41, 'Goshiki', 1000, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/65%20Big%20Auction/photos/Goshiki%20auction.png', 1, 35),
(437, '2024-04-19 00:00:00.000000', '2024-09-20 00:00:00.000000', 2, 'A beautiful Golden Corn koi', 1, 54, 'Golden Corn', 2000, 'Female', 'UNVERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/65%20Big%20Auction/photos/Golden%20Corn%2048cm.png', 1, 33),
(438, '2024-04-29 00:00:00.000000', '2024-06-17 00:00:00.000000', 2, 'A beautiful Ochiba koi', 1, 39, 'Ochiba', 1000, 'Male', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/65%20Big%20Auction/photos/Ochiba%2035cm%202.png', 1, 36),
(439, '2023-04-05 00:00:00.000000', '2024-01-30 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 59, 'Kohaku', 565, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/65%20Big%20Auction/photos/KOhaku%20dianichi.png', 12, 24),
(440, '2023-10-17 00:00:00.000000', '2023-11-28 00:00:00.000000', 2, 'A beautiful Kohaku koi', 1, 61, 'Kohaku', 1000, 'Female', 'VERIFIED', 'https://mjjlqhnswgbzvxfujauo.supabase.co/storage/v1/object/public/auctions/65%20Big%20Auction/photos/kOHAKU%20Dainichi.png', 8, 32);

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
(13, '2024-11-10 03:28:12.000000', b'0', 0, '2024-12-10 03:28:12.000000', '75313b90-eb09-450a-8285-07762b948616', b'0', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjE5LCJlbWFpbCI6ImR1b25nbm1zZTE4MTUxNUBmcHQuZWR1LnZuIiwic3ViIjoiZHVvbmdubXNlMTgxNTE1QGZwdC5lZHUudm4iLCJleHAiOjE3MzEyMDkyOTJ9.AzaZVSI7gxQeLjpkpdZnc6Q9It-Q7S2ecx8ACos_uEo', 'Bearer', 19),
(14, '2024-11-10 14:11:25.000000', b'0', 0, '2024-12-10 14:11:25.000000', 'eb944f8c-5c96-46b1-b936-dbacdb41c9ed', b'0', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjE5LCJlbWFpbCI6ImR1b25nbm1zZTE4MTUxNUBmcHQuZWR1LnZuIiwic3ViIjoiZHVvbmdubXNlMTgxNTE1QGZwdC5lZHUudm4iLCJleHAiOjE3MzEyNDc4ODV9.5XugdDUDIVg1-ZlFNoWWbgJUiplcW0RcDTDEigxpzk0', 'Bearer', 19),
(15, '2024-11-11 01:27:18.000000', b'0', 0, '2024-12-11 01:27:18.000000', '22fdbaed-8bcb-4a10-acd2-2b0062526287', b'0', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjIsImVtYWlsIjoic29uQGdtYWlsLmNvbSIsInN1YiI6InNvbkBnbWFpbC5jb20iLCJleHAiOjE3MzEyODg0Mzh9.blq6XCOFTfGtGHfu5akH1-9RTm6hZg61_5gKhfAyHX8', 'Bearer', 2),
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
(26, '2024-11-17 02:54:12.000000', b'0', 0, '2024-12-17 02:54:12.000000', '1a3bfe27-2c16-49db-b857-e5a52c7a1921', b'0', 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjI0LCJlbWFpbCI6Im5uZEBnbWFpbC5jb20iLCJzdWIiOiJubmRAZ21haWwuY29tIiwiZXhwIjoxNzMxODEyMDUyfQ.mc3ffDEojUV_cVsvwI8SIeUFMYomYxugEYGKDsPtOnc', 'Bearer', 24);

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
(2, '2024-09-22 06:58:19.000000', '2024-10-13 03:42:56.000000', 'Quang Binh, Viet Nam', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', '1979-10-13 00:00:00.000000', 'son@gmail.com', 'Son', 0, 'Cong Duong', '$2a$10$Orep8r6WJo5EjwNq7HyTL.kD8xDlwD5QA6Qk2HVQzkVjUXG1ccGPm', NULL, 'UNVERIFIED', 1, 807778831, 1, 0),
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
(19, '2024-10-05 16:11:14.000000', '2024-10-15 15:14:21.000000', 'Da Nang, Viet Nam', 'https://www.shutterstock.com/image-vector/default-avatar-profile-icon-social-600nw-1677509740.jpg', '1979-10-13 00:00:00.000000', 'duongnmse181515@fpt.edu.vn', 'Duong', 0, 'Duong', '$2a$10$pXEzC6NCd9r2e6kXNV9PFe9ZJKyyxL/yniNwUl6xpZUy/iQguZQU6', NULL, 'UNVERIFIED', 1, 249360537, 1, 0),
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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `auction_kois`
--
ALTER TABLE `auction_kois`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `auction_kois_details`
--
ALTER TABLE `auction_kois_details`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `auction_participants`
--
ALTER TABLE `auction_participants`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT cho bảng `kois`
--
ALTER TABLE `kois`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=441;

--
-- AUTO_INCREMENT cho bảng `koi_images`
--
ALTER TABLE `koi_images`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `otps`
--
ALTER TABLE `otps`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT cho bảng `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

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
