-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 15, 2026 at 07:02 PM
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
(1, 'Power Banks', '', '2026-05-15 16:11:05'),
(2, 'Chargers', '', '2026-05-15 16:11:30'),
(3, 'Phone Cases', '', '2026-05-15 16:11:41');

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
