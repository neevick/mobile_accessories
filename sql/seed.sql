-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 04, 2026 at 07:58 AM
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
-- Database: `mobile_accessories`
--

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `image`, `status`, `created_at`) VALUES
(1, 'Phone Cases', 'Protective cases for all phone models', NULL, 'active', '2026-05-02 18:47:21'),
(2, 'Screen Protectors', 'Tempered glass and film protectors', NULL, 'active', '2026-05-02 18:47:21'),
(3, 'Chargers', 'Wall chargers, car chargers, and wireless chargers', NULL, 'active', '2026-05-02 18:47:21'),
(4, 'Earphones & Headphones', 'Wired and wireless audio accessories', NULL, 'active', '2026-05-02 18:47:21'),
(5, 'Power Banks', 'Portable charging solutions', NULL, 'active', '2026-05-02 18:47:21'),
(6, 'Cables & Adapters', 'USB cables, charging cables, and adapters', NULL, 'active', '2026-05-02 18:47:21'),
(7, 'Mounts & Holders', 'Car mounts, desk stands, and holders', NULL, 'active', '2026-05-02 18:47:21'),
(8, 'Smartwatch Bands', 'Replacement bands for smartwatches', NULL, 'active', '2026-05-02 18:47:21');

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `stock`, `category_id`, `brand`, `image`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Silicone Shockproof Case', 'Premium silicone case with shock absorption technology. Compatible with iPhone 15 series.', 12.99, 150, 1, 'Spigen', NULL, 'active', '2026-05-02 18:47:21', '2026-05-04 05:57:12'),
(2, 'Clear Transparent Case', 'Ultra-thin clear case showing the original phone design. Anti-yellowing technology.', 9.99, 200, 1, 'Ringke', NULL, 'active', '2026-05-02 18:47:21', '2026-05-02 18:47:21'),
(3, 'Leather Wallet Case', 'Genuine leather wallet case with card slots and kickstand feature.', 24.99, 80, 1, 'Mujjo', NULL, 'active', '2026-05-02 18:47:21', '2026-05-02 18:47:21'),
(4, 'Tempered Glass 9H', '9H hardness tempered glass screen protector with oleophobic coating.', 8.99, 300, 2, 'amFilm', NULL, 'active', '2026-05-02 18:47:21', '2026-05-02 18:47:21'),
(5, 'Privacy Screen Protector', 'Anti-spy privacy glass that blocks viewing from angles.', 14.99, 120, 2, 'Spigen', NULL, 'active', '2026-05-02 18:47:21', '2026-05-02 18:47:21'),
(6, '20W Fast Charger', '20W USB-C fast charger with PD 3.0 support.', 19.99, 100, 3, 'Anker', NULL, 'active', '2026-05-02 18:47:21', '2026-05-02 18:47:21'),
(7, 'Wireless Charging Pad', '15W Qi wireless charging pad with LED indicator.', 24.99, 75, 3, 'Samsung', NULL, 'active', '2026-05-02 18:47:21', '2026-05-02 18:47:21'),
(8, 'Car Charger Dual USB', 'Dual USB car charger with 2.4A total output.', 11.99, 130, 3, 'Baseus', NULL, 'active', '2026-05-02 18:47:21', '2026-05-02 18:47:21'),
(9, 'Wireless Earbuds Pro', 'Active noise cancelling wireless earbuds with 30hr battery.', 49.99, 60, 4, 'Soundcore', NULL, 'active', '2026-05-02 18:47:21', '2026-05-02 18:47:21'),
(10, 'Over-Ear Headphones', 'Premium over-ear headphones with deep bass and 40hr battery.', 79.99, 40, 4, 'Sony', NULL, 'active', '2026-05-02 18:47:21', '2026-05-02 18:47:21'),
(11, 'Wired Earphones', 'Hi-fi wired earphones with inline mic and volume control.', 14.99, 200, 4, 'Panasonic', NULL, 'active', '2026-05-02 18:47:21', '2026-05-02 18:47:21'),
(12, '10000mAh Power Bank', 'Slim 10000mAh portable charger with dual USB output.', 22.99, 90, 5, 'Anker', NULL, 'active', '2026-05-02 18:47:21', '2026-05-02 18:47:21'),
(13, '20000mAh Power Bank', 'High capacity 20000mAh power bank with fast charging.', 34.99, 50, 5, 'Xiaomi', NULL, 'active', '2026-05-02 18:47:21', '2026-05-02 18:47:21'),
(14, 'USB-C to USB-C Cable', 'Braided USB-C cable 1m with 100W PD support.', 9.99, 250, 6, 'Anker', NULL, 'active', '2026-05-02 18:47:21', '2026-05-02 18:47:21'),
(15, 'Lightning to USB Cable', 'MFi certified lightning cable 1.2m for iPhone.', 12.99, 180, 6, 'Belkin', NULL, 'active', '2026-05-02 18:47:21', '2026-05-02 18:47:21'),
(16, 'Car Phone Mount', 'Magnetic car phone mount with 360 rotation.', 15.99, 110, 7, 'iOttie', NULL, 'active', '2026-05-02 18:47:21', '2026-05-02 18:47:21'),
(17, 'Desk Phone Stand', 'Adjustable aluminum desk stand for phones and tablets.', 18.99, 70, 7, 'Lamicall', NULL, 'active', '2026-05-02 18:47:21', '2026-05-02 18:47:21'),
(18, 'Silicone Sport Band', 'Premium silicone sport band for Apple Watch. Multiple colors.', 19.99, 140, 8, 'Apple', NULL, 'active', '2026-05-02 18:47:21', '2026-05-02 18:47:21'),
(19, 'Stainless Steel Band', 'Elegant stainless steel band for smartwatches.', 29.99, 50, 8, 'Samsung', NULL, 'active', '2026-05-02 18:47:21', '2026-05-02 18:47:21');

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `full_name`, `phone`, `address`, `role`, `status`, `created_at`, `updated_at`) VALUES
(3, 'neevik', 'neevik980@gmail.com', '$2a$10$Wy7vD3.7BCx1Ds3j9wEdpO/BXDM80cs3yr.iKmqMXsZ1YEeGx4gOi', 'Neevik Thapa', '9814120334', 'Shuklagandaki-5, Belchautara, Tanahun', 'admin', 'active', '2026-05-02 18:49:06', '2026-05-02 18:49:26'),
(4, 'bhijan', 'bhijan78@gmail.com', '$2a$10$C3xoP5j1fNCoMUiYHZ6aXeEpZNaJryU3Uiy8jg6AwLVsTAx3YHOxO', 'Bhijan Rana', '9814120900', 'damauli', 'user', 'active', '2026-05-02 18:53:17', '2026-05-02 19:12:03'),
(5, 'barun', 'barunhacor@gmail.com', '$2a$10$5MgMYMM6R4OHNKLieZj1YOJq/pzeU7RLb1pdT2k8NKv1uN1y6h1oO', 'barun thapa magar', '9800000000', 'lamachaur', 'user', 'active', '2026-05-03 04:36:59', '2026-05-03 04:37:36');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
