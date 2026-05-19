-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 19, 2026 at 02:15 PM
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
(1, 2, 3096.00, 'shipped', 'Syanja', '9812345670', '2026-05-16 08:16:30', '2026-05-19 04:48:56'),
(2, 2, 648.00, 'confirmed', 'Syanja', '9812345670', '2026-05-16 08:35:01', '2026-05-19 04:48:56'),
(3, 2, 1499.00, 'shipped', 'Syanja', '9812345670', '2026-05-16 08:36:11', '2026-05-19 04:48:56'),
(4, 3, 1598.00, 'confirmed', 'Lekhnath', '9876543211', '2026-05-16 08:37:53', '2026-05-19 04:48:56'),
(5, 4, 1198.00, 'confirmed', 'Lamachaur, PKR', '9804111994', '2026-05-16 08:48:53', '2026-05-19 04:48:56');

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`order_item_id`, `order_id`, `product_id`, `quantity`, `price`) VALUES
(1, 1, 22, 1, 1299.00),
(2, 1, 19, 1, 299.00),
(3, 1, 7, 1, 499.00),
(4, 1, 21, 1, 999.00),
(5, 2, 16, 1, 449.00),
(6, 2, 28, 1, 199.00),
(7, 3, 3, 1, 1499.00),
(8, 4, 2, 1, 999.00),
(9, 4, 14, 1, 599.00),
(10, 5, 14, 2, 599.00);

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `name`, `description`, `price`, `stock`, `category_id`, `brand`, `image`, `status`, `created_at`, `updated_at`) VALUES
(1, '20W USB-C Charger', 'Quick Charging adapter', 899.00, 11, 2, 'Anker', '20W USB-C Charger Anker.jpg', 'active', '2026-05-16 06:55:21', '2026-05-19 05:30:27'),
(2, 'Dual Port Charger', 'Charge Two Devices', 999.00, 14, 2, 'Baseus', 'Dual Port Charger Baseus.jpg', 'active', '2026-05-16 06:56:10', '2026-05-19 05:34:47'),
(3, '10000mAh Power Bank', 'Compact battery backup', 1499.00, 13, 1, 'Xiaomi', '10000mAh Power Bank Xiaomi.jpg', 'active', '2026-05-16 06:58:15', '2026-05-19 05:34:39'),
(4, '20000mAh Power Bank', 'Extended charging capacity', 2799.00, 13, 1, 'Anker', '20000mAh Power Bank Anker.jpg', 'active', '2026-05-16 06:58:42', '2026-05-19 05:34:32'),
(5, 'Wireless Power Bank', 'Cable-free charging support', 3299.00, 13, 1, 'Baseus', 'Wireless Power Bank Baseus.jpg', 'active', '2026-05-16 06:59:29', '2026-05-19 05:34:26'),
(6, 'Tempered Glass Protector', 'Scratch resistant shield', 399.00, 14, 9, 'Spigen', 'Tempered Glass Protector Spigen.jpg', 'active', '2026-05-16 07:00:15', '2026-05-19 05:34:17'),
(7, 'Privacy Screen Protector', 'Blocks side viewing', 499.00, 11, 9, 'ESR', 'Privacy Screen Protector ESR.jpg', 'active', '2026-05-16 07:01:29', '2026-05-19 05:34:07'),
(8, 'USB-C Cable', 'Fast data transfer', 349.00, 12, 4, 'UGREEN', 'USB-C Cable UGREEN.jpg', 'active', '2026-05-16 07:02:04', '2026-05-19 05:33:56'),
(9, 'Lightning Cable', 'Apple device charging', 1199.00, 14, 4, 'Apple', 'Lightning Cable Apple.jpg', 'active', '2026-05-16 07:02:50', '2026-05-19 05:33:46'),
(10, 'Fitness Smartwatch', 'Health activity tracking', 4499.00, 14, 11, 'Amazfit', 'FitnessSmartwatchAmazfit.jpg', 'active', '2026-05-16 07:04:08', '2026-05-19 05:33:37'),
(11, 'Calling Smartwatch', 'Bluetooth call support', 6999.00, 13, 11, 'Noise', 'Calling Smartwatch Noise.jpg', 'active', '2026-05-16 07:06:47', '2026-05-19 05:33:26'),
(12, 'Mini Bluetooth Speaker', 'Compact portable sound', 2499.00, 13, 8, 'JBL', 'Mini Bluetooth Speaker JBL.jpg', 'active', '2026-05-16 07:07:29', '2026-05-19 05:33:18'),
(13, 'Waterproof Speaker', 'Water resistant audio', 5499.00, 13, 8, 'Sony', 'Waterproof Speaker  Sony.jpg', 'active', '2026-05-16 07:08:23', '2026-05-19 05:33:09'),
(14, 'Selfie Stick', 'Extended photo reach', 599.00, 12, 13, 'Xiaomi', 'Selfie Stick Xiaomi.jpg', 'active', '2026-05-16 07:09:20', '2026-05-19 05:33:01'),
(15, 'Ring Light', 'Bright photo lighting', 799.00, 13, 13, 'Digitek', 'Ring Light Digitek.jpg', 'active', '2026-05-16 07:09:51', '2026-05-19 05:32:52'),
(16, 'Mobile Gaming Trigger', 'Faster gaming controls', 449.00, 12, 12, 'MEMO', 'Mobile Gaming Trigger MEMO.jpg', 'active', '2026-05-16 07:10:31', '2026-05-19 05:32:44'),
(19, 'Gaming Finger Sleeves', 'Smooth touch movement', 299.00, 12, 12, 'Flydigi', 'Gaming Finger Sleeves Flydigi.png', 'active', '2026-05-16 07:13:38', '2026-05-19 05:32:09'),
(20, 'OTG Flash Drive', 'Mobile file transfer', 899.00, 12, 14, 'SanDisk', 'OTG Flash Drive SanDisk.jpg', 'active', '2026-05-16 07:15:24', '2026-05-19 05:32:01'),
(21, 'Memory Card', 'Expand device storage', 999.00, 12, 14, 'Samsung', 'Memory Card Samsung.jpg', 'active', '2026-05-16 07:16:03', '2026-05-19 05:31:54'),
(22, 'Mobile Cooling Fan', 'Reduces overheating', 1299.00, 12, 16, 'Black Shark', 'Mobile Cooling Fan Black Shark.jpg', 'active', '2026-05-16 07:18:06', '2026-05-19 05:31:46'),
(23, 'Semiconductor Cooler', 'Advanced cooling performance', 1599.00, 12, 16, 'MEMO', 'Semiconductor Cooler MEMO.jpg', 'active', '2026-05-16 07:18:38', '2026-05-19 05:31:36'),
(24, 'Wireless Charging Pad', 'Flat charging surface', 1799.00, 12, 5, 'Anker', 'Wireless Charging Pad Anker.jpg', 'active', '2026-05-16 07:19:06', '2026-05-19 05:31:27'),
(25, 'Magnetic Wireless Charger', 'Snap charging support', 3499.00, 13, 5, 'Apple', 'Magnetic Wireless Charger Apple.jpg', 'active', '2026-05-16 07:19:47', '2026-05-19 05:31:16'),
(26, 'Screen Cleaning Kit', 'Removes dust marks', 699.00, 12, 15, 'WHOOSH!', 'Screen Cleaning Kit WHOOSH!.jpg', 'active', '2026-05-16 07:21:08', '2026-05-19 05:31:08'),
(27, 'Cleaning Brush Set', 'Keyboard dust removal', 399.00, 20, 15, 'Hama', 'CleaningBrushSetHama.jpg', 'active', '2026-05-16 07:21:41', '2026-05-19 05:30:59'),
(28, 'Microfiber Cloth', 'Gentle screen cleaning', 199.00, 10, 15, '3M', 'MicroFiber Cloth 3M.jpg', 'active', '2026-05-16 07:22:14', '2026-05-19 05:30:44'),
(29, 'Microfiber Cloth', 'nclkanklnq', 3242.00, 24, 15, 'weffwef', 'MicroFiber Cloth 3M.jpg', 'active', '2026-05-19 07:47:37', '2026-05-19 07:47:37'),
(30, 'wefwefewfwe', 'wfwefew', 32232.00, 34, 9, 'sfdsf', NULL, 'active', '2026-05-19 07:49:06', '2026-05-19 07:49:06'),
(31, 'sfqwfq', 'ada', 323.00, 23, 5, 'afsdsd', NULL, 'active', '2026-05-19 08:24:22', '2026-05-19 08:24:22');

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
(2, 'neevik', 'neevik@gmail.com', '$2a$10$6DL5rupMwhtti25vNPCBdOrnbCt.9ePpRaOjZr4QkXJzEsL4/gGEC', 'Neevik Thapa', '9812345670', 'Syanja', 'user', '2026-05-15 16:04:49', '2026-05-19 11:49:50'),
(3, 'arun', 'arun@gmail.com', '$2a$10$hE14bNaO.C1m96/Sdx0q8eygeOVrOhKqcxkCbBdD4gYZB4Rav/jD2', 'Arun Grg', '9876543211', 'Lekhnath', 'user', '2026-05-15 16:05:55', '2026-05-15 16:05:55'),
(4, 'aashish', 'aashish@gmail.com', '$2a$10$vlM657iFDndtMZ6qw1yiPO1YPHJS6fbt9gjhdp7LtUEgZyXITTdgO', 'Aashish Gyawali', '9804111994', 'Lamachaur, PKR', 'user', '2026-05-15 16:07:31', '2026-05-15 16:07:31'),
(5, 'barun', 'barun@gmail.com', '$2a$10$Ig8jMFva5lSTO8EEpCw6S.916L9fpSXyYl02hG99h2Viz9qEKzAMK', 'Barun Thapa', '9826636379', 'Lamachaur, PKR', 'user', '2026-05-15 16:09:04', '2026-05-15 16:09:04');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
