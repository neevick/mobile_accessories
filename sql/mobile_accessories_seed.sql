-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 16, 2026 at 05:24 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

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

INSERT INTO `categories` (`category_id`, `name`, `description`, `created_at`) VALUES
(1, 'Power Banks', 'Portable backup Charging', '2026-05-15 16:11:05'),
(2, 'Chargers', 'Fast Device Charging', '2026-05-15 16:11:30'),
(3, 'Mobile Phone Cases', 'Protective covers', '2026-05-15 16:11:41'),
(4, 'Phone Cables & Converters', 'USB & Type-C cords', '2026-05-16 06:37:36'),
(5, 'Wireless Charging', 'Pads & docks', '2026-05-16 06:38:07'),
(6, 'Earphones', 'Wired Audio.', '2026-05-16 06:38:47'),
(7, 'Headphones', 'Over-ear sound', '2026-05-16 06:39:05'),
(8, 'Bluetooth Speakers', 'Portable Speakers', '2026-05-16 06:39:24'),
(9, 'Screen Protectors', 'Display Protection layers', '2026-05-16 06:45:17'),
(10, 'Phone Holders', 'Secure Phone Mounting', '2026-05-16 06:45:48'),
(11, 'Smartwatches', 'Wearable Smart Devices', '2026-05-16 06:46:10'),
(12, 'Gaming Accessories', 'Mobile Gaming Equipment', '2026-05-16 06:47:14'),
(13, 'Selfie Accessories', 'Mobile Photography Tools', '2026-05-16 06:48:46'),
(14, 'Storage Devices', 'Extra Data Storage', '2026-05-16 06:49:11'),
(15, 'Cleaning Accessories', 'Device Cleaning Tools', '2026-05-16 06:50:07'),
(16, 'Cooling Accessories', 'Device temperature control', '2026-05-16 07:17:29');

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `total_amount`, `status`, `shipping_address`, `phone`, `order_date`, `updated_at`) VALUES
(1, 2, 73.00, 'shipped', 'Syanja', '9812345670', '2026-05-16 08:16:30', '2026-05-16 08:43:18'),
(2, 2, 17.00, 'confirmed', 'Syanja', '9812345670', '2026-05-16 08:35:01', '2026-05-16 08:42:46'),
(3, 2, 25.00, 'shipped', 'Syanja', '9812345670', '2026-05-16 08:36:11', '2026-05-16 08:41:50'),
(4, 3, 35.00, 'confirmed', 'Lekhnath', '9876543211', '2026-05-16 08:37:53', '2026-05-16 08:43:05'),
(5, 4, 30.00, 'confirmed', 'Lamachaur, PKR', '9804111994', '2026-05-16 08:48:53', '2026-05-16 08:52:57');

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`order_item_id`, `order_id`, `product_id`, `quantity`, `price`) VALUES
(1, 1, 22, 1, 30.00),
(2, 1, 19, 1, 8.00),
(3, 1, 7, 1, 15.00),
(4, 1, 21, 1, 20.00),
(5, 2, 16, 1, 12.00),
(6, 2, 28, 1, 5.00),
(7, 3, 3, 1, 25.00),
(8, 4, 2, 1, 20.00),
(9, 4, 14, 1, 15.00),
(10, 5, 14, 2, 15.00);

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `name`, `description`, `price`, `stock`, `category_id`, `brand`, `image`, `status`, `created_at`, `updated_at`) VALUES
(1, '20W USB-C Charger', 'Quick Charging adapter', 18.00, 11, 2, 'Anker', NULL, 'active', '2026-05-16 06:55:21', '2026-05-16 08:52:11'),
(2, 'Dual Port Charger', 'Charge Two Devices', 20.00, 14, 2, 'Baseus', NULL, 'active', '2026-05-16 06:56:10', '2026-05-16 08:52:05'),
(3, '10000mAh Power Bank', 'Compact battery backup', 25.00, 13, 1, 'Xiaomi', NULL, 'active', '2026-05-16 06:58:15', '2026-05-16 08:51:59'),
(4, '20000mAh Power Bank', 'Extended charging capacity', 45.00, 13, 1, 'Anker', NULL, 'active', '2026-05-16 06:58:42', '2026-05-16 08:51:53'),
(5, 'Wireless Power Bank', 'Cable-free charging support', 50.00, 13, 1, 'Baseus', NULL, 'active', '2026-05-16 06:59:29', '2026-05-16 08:51:47'),
(6, 'Tempered Glass Protector', 'Scratch resistant shield', 12.00, 14, 9, 'Spigen', NULL, 'active', '2026-05-16 07:00:15', '2026-05-16 08:51:41'),
(7, 'Privacy Screen Protector', 'Blocks side viewing', 15.00, 11, 9, 'ESR', NULL, 'active', '2026-05-16 07:01:29', '2026-05-16 08:51:35'),
(8, 'USB-C Cable', 'Fast data transfer', 8.00, 12, 4, 'UGREEN', NULL, 'active', '2026-05-16 07:02:04', '2026-05-16 08:51:30'),
(9, 'Lightning Cable', 'Apple device charging', 20.00, 14, 4, 'Apple', NULL, 'active', '2026-05-16 07:02:50', '2026-05-16 08:51:23'),
(10, 'Fitness Smartwatch', 'Health activity tracking', 50.00, 14, 11, 'Amazfit', NULL, 'active', '2026-05-16 07:04:08', '2026-05-16 08:51:18'),
(11, 'Calling Smartwatch', 'Bluetooth call support', 80.00, 13, 11, 'Noise', NULL, 'active', '2026-05-16 07:06:47', '2026-05-16 08:51:11'),
(12, 'Mini Bluetooth Speaker', 'Compact portable sound', 45.00, 13, 8, 'JBL', NULL, 'active', '2026-05-16 07:07:29', '2026-05-16 08:51:04'),
(13, 'Waterproof Speaker', 'Water resistant audio', 90.00, 13, 8, 'Sony', NULL, 'active', '2026-05-16 07:08:23', '2026-05-16 08:50:59'),
(14, 'Selfie Stick', 'Extended photo reach', 15.00, 12, 13, 'Xiaomi', NULL, 'active', '2026-05-16 07:09:20', '2026-05-16 08:48:53'),
(15, 'Ring Light', 'Bright photo lighting', 10.00, 13, 13, 'Digitek', NULL, 'active', '2026-05-16 07:09:51', '2026-05-16 08:50:53'),
(16, 'Mobile Gaming Trigger', 'Faster gaming controls', 12.00, 12, 12, 'MEMO', NULL, 'active', '2026-05-16 07:10:31', '2026-05-16 08:50:47'),
(17, 'Cooling Gaming Fan', 'Prevents device heating', 15.00, 14, 12, 'Black Shark', NULL, 'active', '2026-05-16 07:11:08', '2026-05-16 08:50:40'),
(18, 'Gaming Finger Sleeves', 'Smooth touch movement', 8.00, 12, 12, 'Flydigi', NULL, 'active', '2026-05-16 07:11:42', '2026-05-16 08:50:34'),
(19, 'Gaming Finger Sleeves', 'Smooth touch movement', 8.00, 12, 12, 'Flydigi', NULL, 'active', '2026-05-16 07:13:38', '2026-05-16 08:50:29'),
(20, 'OTG Flash Drive', 'Mobile file transfer', 18.00, 12, 14, 'SanDisk', NULL, 'active', '2026-05-16 07:15:24', '2026-05-16 08:50:24'),
(21, 'Memory Card', 'Expand device storage', 20.00, 12, 14, 'Samsung', NULL, 'active', '2026-05-16 07:16:03', '2026-05-16 08:50:18'),
(22, 'Mobile Cooling Fan', 'Reduces overheating', 30.00, 12, 16, 'Black Shark', NULL, 'active', '2026-05-16 07:18:06', '2026-05-16 08:50:12'),
(23, 'Semiconductor Cooler', 'Advanced cooling performance', 35.00, 12, 16, 'MEMO', NULL, 'active', '2026-05-16 07:18:38', '2026-05-16 08:50:07'),
(24, 'Wireless Charging Pad', 'Flat charging surface', 25.00, 12, 5, 'Anker', NULL, 'active', '2026-05-16 07:19:06', '2026-05-16 08:50:01'),
(25, 'Magnetic Wireless Charger', 'Snap charging support', 40.00, 13, 5, 'Apple', NULL, 'active', '2026-05-16 07:19:47', '2026-05-16 08:49:55'),
(26, 'Screen Cleaning Kit', 'Removes dust marks', 20.00, 12, 15, 'WHOOSH!', NULL, 'active', '2026-05-16 07:21:08', '2026-05-16 08:49:49'),
(27, 'Cleaning Brush Set', 'Keyboard dust removal', 10.00, 20, 15, 'Hama', NULL, 'active', '2026-05-16 07:21:41', '2026-05-16 08:49:42'),
(28, 'Microfiber Cloth', 'Gentle screen cleaning', 5.00, 10, 15, '3M', NULL, 'active', '2026-05-16 07:22:14', '2026-05-16 08:49:37');

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`review_id`, `user_id`, `product_id`, `rating`, `comment`, `created_at`) VALUES
(1, 2, 22, 2, 'dfds', '2026-05-16 08:15:36'),
(2, 3, 19, 3, 'Is it good?', '2026-05-16 08:37:36'),
(3, 4, 14, 3, 'I like it.', '2026-05-16 08:48:40');

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password`, `full_name`, `phone`, `address`, `role`, `created_at`, `updated_at`) VALUES
(1, 'vijan', 'vijan@gmail.com', '$2a$10$NjzrwQZdryPgS3SCGZTiqO9MCelolVF6GtgSeyLZ2YFB3DshcC4Ee', 'Vijan Rana', '9876543210', 'PKR', 'admin', '2026-05-15 16:03:06', '2026-05-15 16:03:32'),
(2, 'neevik', 'neevik@gmail.com', '$2a$10$6DL5rupMwhtti25vNPCBdOrnbCt.9ePpRaOjZr4QkXJzEsL4/gGEC', 'Neevick Thor', '9812345670', 'Syanja', 'user', '2026-05-15 16:04:49', '2026-05-15 16:04:49'),
(3, 'arun', 'arun@gmail.com', '$2a$10$hE14bNaO.C1m96/Sdx0q8eygeOVrOhKqcxkCbBdD4gYZB4Rav/jD2', 'Arun Grg', '9876543211', 'Lekhnath', 'user', '2026-05-15 16:05:55', '2026-05-15 16:05:55'),
(4, 'aashish', 'aashish@gmail.com', '$2a$10$vlM657iFDndtMZ6qw1yiPO1YPHJS6fbt9gjhdp7LtUEgZyXITTdgO', 'Aashish Gyawali', '9804111994', 'Lamachaur, PKR', 'user', '2026-05-15 16:07:31', '2026-05-15 16:07:31'),
(5, 'barun', 'barun@gmail.com', '$2a$10$Ig8jMFva5lSTO8EEpCw6S.916L9fpSXyYl02hG99h2Viz9qEKzAMK', 'Barun Thapa', '9826636379', 'Lamachaur, PKR', 'user', '2026-05-15 16:09:04', '2026-05-15 16:09:04');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
