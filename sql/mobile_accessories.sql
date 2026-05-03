-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 03, 2026 at 07:37 AM
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

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `image` mediumblob DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `subject` varchar(200) NOT NULL,
  `message` text NOT NULL,
  `status` enum('unread','read','replied') NOT NULL DEFAULT 'unread',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` enum('pending','confirmed','shipped','delivered','cancelled') NOT NULL DEFAULT 'pending',
  `shipping_address` text NOT NULL,
  `phone` varchar(20) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `category_id` int(11) NOT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `image` mediumblob DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `stock`, `category_id`, `brand`, `image`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Silicone Shockproof Case', 'Premium silicone case with shock absorption technology. Compatible with iPhone 15 series.', 12.99, 150, 1, 'Spigen', 0xffd8ffe000104a46494600010100000100010000ffdb0084000906070f0f10150d0f100f0f0f0f100f0f0f0f0e0f100f10101015151717151515151a1e2820191a261d151521312125292b2e2e2e171f3338332e39282d322b010a0a0a0d0d0e1a0f101a2d1f1d2537372d2d352b2b2b2b2d30372d372b2d2d37372d2d372d372b372b2d37372d2b322b2d2b372d2d2b2b372b2b2b2b2b2b2b2bffc000110800d100f103012200021101031101ffc4001c0001000105010100000000000000000000000401030506070802ffc40048100001030200070c050b030305010000000100020304110507122131327106133435415161727381b1b37491a1b2d1141622334252539294d2f093a2c115436224548284f123ffc400160101010100000000000000000000000000000201ffc40017110101010100000000000000000000000000011131ffda000c03010002110311003f00e8dbb7dd8b30706c4d1973c832837eeb745ced37b6c3dfcdeab7735b29be5c8de864d2307f6d82898cda873f0ace09cd1986368e602261b7ac93deb0511273f2670073db4941b29ddb5716e4efb25bb6901fcd7bab3f3bab7f166fd5547ee586f566d24d801b4aa0209b02c2799ae6b8fa81ba0cdfcedadfc59ff5551fb91dbaead3feecdfa99ff72c1bc5c7374856e0909041d6692d36d17e7f558a0cff00cedadfc59ff5551fb957e76d67e2cffaaa8fdcb0888338ddd7d68d12cddf5339f172faf9e55df8b2ff005e5f8ac0a20ce3b75f5c7fdd9bbaa661fe5643026332aa9e502a899e98901f94019631f79ae02eeb69b1bdf9c2d4d43aed083d3f0cad7b448c21cc7b439ae19c39a45c11d165f6b59c5acc5f82a949fb31ba3ee63dcc1ec685b320e5f8c1c3f571d71a46cefa781b04728de7e83e42e24125fa74b48b0216b34fbb1aca691af8aa6799a08cb8ea1e6563c737d2b91b42d8f1d34c03e96a06b384d0bba5a325cdf55ddeb5ce25d1de83d29493896364add5918d78d8e008f157968f8a5c2335451bb7d7b9fbd4a228f2adf46311b0868206719f956ed23ac09e604fa90735ddb6315f0ceea3a302f11c99a72038e5f2b18082337293ecb5d6a6776f5c7397c87ff6246fb1a6cb561297cae7bb39712f71e77389713edf62919283631bb9aefbcffd44bf15476edeb8fda93f5330f02b5ec94b20ce7cf1c21f8cff00ebd47ee4f9e3843f19ff00d7a8fdcb07655b20cdfcf1c21f8cff00ebd47ee55f9e3843f19ffd7a8fdeb076565994e1957c90738b017b739ba0d9c6ed2af96497f5151fb95c8f7735add123f3fde9647fbc4ac260ec0559522f4f14f2b4662e6c6322fcd9645afd175f384b02d5d366a88e786f9817c60349e60eb589e8ba0cd33771580df2e5ee9e43ec75c7b16efb8adde7ca656d2d4105f2668a5b0692e1f61e066bf310b8f49760b9394dfb570011d39b917d605aa74758c23ecbd920e8731c0a0f4ea2220f3de3178daa7b48fca8d6269f57f37aae565b18bc6d53da47e53161e3368c9e877b09283ee5781b7c367c5632b26e7f6abf161374323276649746f0f6e50ca6dc68b8e55070c573657196e729f7749988064273db3ab45b771370556992ec71bb9b9c13a5cdd19fa41b67e95260d67f5c7b8d583dce02e95cee46c641dae70b0f613dcb3906b3fae3dc6a9ab5f44458088880a1d6a98a1d6a0eef8ace29a7d9379cf5b5ad53159c534fb26f39eb6b41ccf1d9a94bda4deeb57309b40daba7e3b35297b49bdd6ae633681b50758c4b70397b71e5316fd51a8eeabbc1683896e072f6e3ca62dfaa351dd577820f30528fa5dcdf053145a4d6ee6f80531052c965508829655b2220f978cc7615b262e773adaf9c0945e0818c92517b6593998cbf31b127a1a79d6baed07615d1f12b3b72678bed914f20e96d9c0fa8dbd683a5c31358d0c635ad6b400d6b406b5a068000d017cd553472b0c52b1b246f192e63c0735c3a42ba883cff008c1c01f209a485b730be332425d9ce41b82d27948208d96e75add00ffa91fce50ba363ba7699228c5b2e3a799cfd8f70c9bfe477ad73aa0e123f9ca107a8d111079ef189c6d53da47e546b114fabebf12b21bb8a96cd84ea6468206fe59675af78c08cfb585635b206465e74343dc7602494102bb05b8e7888ea38e4dbaa74771b2c70c0950e367643073991aff634952f09e10a884b1c77a2246e5e436ee2d1f74bafad9f3e6b5f9ecb251d4195b16466dfe482306c096ef8f6b6f6d171755658c965e3ea828d90b321b73cae71d2e7739f87278d60d693ae3dc6a9785b073e8eacd2991d2b1d0475113e40c0fc8739edcf9200fb1cca241ad275c7b8d52d5f444404444050eb54c50eb50777c56714d36c9bce7adad6a98ade29a6d9379cf5b5a0e678ecd4a5ed66f75ab98cda06d5d331de6cca4ed66f062e60f71d06d71639b98fff001075bc4b70397b71e5316fd51a8eeabbc1683896e072fa40f2a35bf546a3baaef041e62a5d6ee6f8053143a4d6ee6f829a808888088aa83e5da0ec2a66e770acb452c75309194d6805a755ec206531dd07c403c8a23f41d856c98b7c070d6d4644e0ba38a0df4b012dcb376800919ed9c9ee083a3609ddfe0f9da0be5f93496fa4c9ae003d0fd523dbd015ac378c2a18187797fcaa5b7d16457c8bff00ca4b580d973d0b51c64ee6a0a4743252b3204e5ec310248cb16c92db9cd7bdada3474ad9705e2d68db10151be4b311773db23e36b5dccc00dac3a6e8391ee82be5a932d44ceca9240e738e8033580039000001b140c1fc29bb7fc85b06eef011a0964a7ca2f618b7c89e7312c75c7d2e905a4775f96cb5da375aa438e86dc9ee2107a9116b9f3c20fc397d4cf8aa20e1fba4e1f53e9753e6b9476461d1e49d0e0e0761254cdd7167fa854e4021bf2a9f4fdecb395edba80e711112dd601e46db9b20c347815cd796efacc970b67cf264ece7e959a640626c5bd004d3c90cad6975b2b7b7875af6cd7c9d365accc23316f85e77dbb8bafa49cd620df4e9f62d97063dce8585f7ca2d17be9d0aaeb232386b083ab2add58e8cc40c31c2d639cd7b8e49738b8d8586771cc39941835a4eb8f71aafab106b3fae3dc6a96afa2220222202875ca62875a83bbe2b78a69b64de73d6d6b54c56f14d36c9bce7adad072fc78ea5276b3783172eb3bed105d66dc8161a4aea38f1d4a4ed66f062e60f19cec6ff00941d7712dc0e5f481e546b7ea8d47755de0b41c4b70397d20794c5bf546a3baaef041e63a4d6ee6f8298543a4d6ee6f8298801551101155107cbf41d856c58bac3d150d46f93dc452c2222f682e2c376904819c8cc466e75aebf41d857c43aa3aadf041bc631b74f0563a2652b8b9b017bccb925a32cdac1a0e7cd6bdedca16df80b774c9e9f7d929eaf7c60b49bc534b346e70d392e68206c36b7b571c8c024071b34901c799b7ce7d4bd19474f1c51b638835b1b1a1ac6b754340cd641c0b773875d5f2c9505b90c11ef7130e96b1b73f4bfe44924edb725d6b917d71ea3d6ef8dea78a3ac937a001929db24ad6e8129ca04ed2034f7df9569117d71ea3d074dfe6945b0efb837ee3bd4ef8a20e45ba7e1d53e9753e6b9586bb273104b739040274e9042c96eee99b1613a98db7b6fc5ff0048dcde402477b5c7b9426e84104d253656f99032af7d47dafcf6b594bf9437a7f2bbe0ae220b46a0720713cc1ae1ed39956061172759c728dbc3d565715501111011110143ae53143ad41ddf15bc534db26f39eb6b5aa62b78a69b64de73d6d68397e3c75293b59bc18b983af7cf626cdd02c3495d431dedbb29393ffd26f062e60f6f293726dc96cc10764c50e0f9a0a37efac7304b36f91657db8cc6c01c3a3315bb546a3baaef050b739c0e9fd1a9fcb6a9b51a8eeabbc10798e935bb9be0a628749addcdf00a620aa22aa0222202b2d6968b58b80cc0822f6e9babc882d659fb8ef5b3e2b3f83776b8469a21046f3bdb4599be3627b98399a49d1d06f6585544166be596a1ce7c85c5d23b2a5924702e7f466f5740d0a045f5dff83d649ca051b41a96b4e87020ec24041d3bd7eb45bbfcd2a6fbd37e76fed441c33759339f5f52e792e77ca676dce9c96bcb5a3b9a00ee569ba17deea5a45754820b4fcaaa4d9c083632388363c8458ec2be5ba1011551051551101111011110143ad53143ae41ddf15bc534db26f39eb6b5aae2bb8a69b64de73d6d48397e3c75292fa37d9afb325ab979b67c9b5be89cda2f9fe0ba7e3c80c8a4be8df66becc96ae606d9eda3e8f2df3e7e541e8fdce703a7f4683dc6a9b51a8eeabbc142dce703a7f4683dc6a9b51a8eeabbc10798e935bb9be0a6a8547addcdf00a6a02aa22022220222202a2aaa20f872c753b889ee3486bc83cc459645eb1b08bcf619c963ec06724a0ec1feb355f8d27e628a3fc925fc297fa6ff8220d2f18dc6b53da47e531631ba164b18fc6b53da33ca62c6b7420aa22202222022220222202875ca62875a83bc62bb8a69b64de73d6d4b55c57714d36c9bce7ada90732c768fa149da4feeb1730945805d3f1d9ab49da4feeb17319f4041e8adce703a7f4683cb6a9b51a8eeabbc142dce703a7f4683cb6a9b53a8eeabbc10798e934f737c029aa1526b7737c029a82a881101111011110111105b728583f8537f9ca14e7a8341c29bfce5083d4688883cf58c6e35a9ed19e531635ba164b18dc6b53da33ca62c6b7420aa22202222022220222202875ca62875a83bc62bb8a69b64de73d6d4b55c57714d36c9bce7ada90732c766ad27693fbac5cc67d0174ec766ad27693fbac5cc67d0107a2b73bc0e9fd1a0f2daa6d46a3baaef050b739c0e9fd1a0f2daa6d4ea3baaef041e63a4d6ee6f8053542a3d6ee6f8053505511101111011110111107c3941a0e14dfe728539ca0e0fe14cfe72841ea344441e7ac6371ad4f68cf298b1add0b258c6e35a9ed19e531635ba10551110111101111011110143ad53143ae41de315dc534db26f39eb6a5aae2bb8a69b64de73d6d4839963b35693af3fbac5cc67d0174dc76ead27693fbac5cc67d0107a2f739c0e9fd1a0f2daa6d4ea3baaef050b739c0e9fd1a0f2daa6d4ea3baaef041e63a4d6ee6fba14d50a8f5bb9be014d41544440444404444044441f0e506838537f9ca14e728383f8537f9ca107a8d111079eb18bc6b53da33cb62c6b742c9631b8d6a7b46796c58d6e84154444044440444404444050eb54c50eb50778c57714d36c9bce7ada96ab8aee29a6d9379cf5b520e638edd5a4ed27f062e633e80ba7e3b35693b49fdd62e633e841e8adcef03a7f4683cb6a9b53a8eeabbc142dcef03a7f4683cb6a9b53a8eeabbc10798e8f5bb9be014d50a935bb9be014d415444404444044440444416dca160fe14dfe728535ca160fe14dfe72841ea344441e6edd84c5f842a5ce7171f94ccdb916366bcb5a3b8340ee5619a06c57b75d196e10a905ae6ff00d54ee01d98d9cf241ef041d842b2cd03620fa4444044440444404444050eb54c50eb50778c57714d36c9bce7ada96ab8aee29a6d9379cf5b520e5f8f1272296da72ea2d7d17c962e604bb2465663cb65d3f1e37c8a5b69cba8b5f9f258b9867c91946e7948cc83d1fb9de074fe8d0796d52ea751dd5778289b9de074fe8d07b8d532a751dd577820f31d26b7737dd0a6a8549addcdf00a6a0aa222022220222202a2aaa141f0e58e81c44f943486b88da2cb24e58c84133d867258f00739cc83baff00aabffee25fcadf822f9ff4d3f8151f951072fc6371ad4f68cf2d8b18cd0362c9e3178d6a7b46796c58c6e841f488880888808888088880a1d6a98a1d6a0ef18aee29a6d9379cf5b52d5715fc534dd597cd7ada90731c76ead275e7f062e633680ba763b75693af3f8317319f4041e8cdcef03a7f4683dc6a9753a8eeabbc144dcf703a7f4683cb6a9755a8eea3bc10798e935bb9bee853942a4d6ee6fba14c4155554441545455404444054284aa141f2e50b07f0b67f39429ae50b0770b67f395a83d4688883cf98c761185aa41e57c67b8c4c2b16dd0ba7634771f2d43c57d334bded6864d1b73b9c06abda394db311d03a572f735ec392e6b8119882082107da2b796798a659e6282e22b5be1e65f71b5eed563ddd56b9de083e91577997f0a4fc8ef82b396798a0ba8ad659e64df0f320baa1d6abf96798acae00dcb5561090358c7362b8cb99cd22360e5cfca7a1075fc59c65b82a981e563dddce91e47b085b3a8f83e919044c82316644c646c1ff168b0f0521072dc764cdbd2477fa57a87db99bf405fd7e0b9a4a6e16f18dba49dd5c252c7ef2218e38df63906c5c5d63a2f771cdb16a183b054f51208a28dd23dc4001a09b7493c83a507a1373dc0e9fd1a0f71aa64edbb1c0692d70f62f8a0a7dea28e1bdf7b8d91df9f25a07f857d0797a9c10eb1e61eccc7da0a9775b76edb71b3534efa88a37494b2bdd20318b984b8ddcd70e417d07674ad49f11e4f6877c102e975f3bd9e71fddf055decf47f77c107d5d2ebe77b3d1fddf057594929170c711ce18f23c107c5d2ebedf4b2345dcc73473b98f03da15ac83d1fddf0415ba5d537b3d1fddf04de8f47f77c107cb8a8b82185d58c68ce4903bcb9a078a94e81e730b5f63be0b77c5c6e22533b2b276399146e120320c974b2373b2c391a0e7bf47a83b0a2a5910556afba9d7ee08883008aa8827d57d50ee5b4603fa866c44413d693ba0faf72aa20f9a6d0362bef444109df583b96ef4ba8dea8444179111059aad476c51b056a955441391110516a95ff005a76a220bf1680be65d0aa8820d3eb8eb05b9b74772220f99754ec2b59a1d676d44410dfac7695f251104ec11f5816d2888088883fffd9, 'active', '2026-05-02 18:47:21', '2026-05-02 20:55:59'),
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

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL CHECK (`rating` >= 1 and `rating` <= 5),
  `comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` text DEFAULT NULL,
  `role` enum('admin','user') NOT NULL DEFAULT 'user',
  `status` enum('active','inactive','pending') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `full_name`, `phone`, `address`, `role`, `status`, `created_at`, `updated_at`) VALUES
(3, 'neevik', 'neevik980@gmail.com', '$2a$10$Wy7vD3.7BCx1Ds3j9wEdpO/BXDM80cs3yr.iKmqMXsZ1YEeGx4gOi', 'Neevik Thapa', '9814120334', 'Shuklagandaki-5, Belchautara, Tanahun', 'admin', 'active', '2026-05-02 18:49:06', '2026-05-02 18:49:26'),
(4, 'bhijan', 'bhijan78@gmail.com', '$2a$10$C3xoP5j1fNCoMUiYHZ6aXeEpZNaJryU3Uiy8jg6AwLVsTAx3YHOxO', 'Bhijan Rana', '9814120900', 'damauli', 'user', 'active', '2026-05-02 18:53:17', '2026-05-02 19:12:03'),
(5, 'barun', 'barunhacor@gmail.com', '$2a$10$5MgMYMM6R4OHNKLieZj1YOJq/pzeU7RLb1pdT2k8NKv1uN1y6h1oO', 'barun thapa magar', '9800000000', 'lamachaur', 'user', 'active', '2026-05-03 04:36:59', '2026-05-03 04:37:36');

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE `wishlist` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_order_user` (`user_id`),
  ADD KEY `idx_order_status` (`status`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_orderitem_order` (`order_id`),
  ADD KEY `idx_orderitem_product` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_product_category` (`category_id`),
  ADD KEY `idx_product_brand` (`brand`),
  ADD KEY `idx_product_status` (`status`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_review` (`user_id`,`product_id`),
  ADD KEY `idx_review_product` (`product_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- Indexes for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_wishlist` (`user_id`,`product_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `idx_wishlist_user` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `wishlist`
--
ALTER TABLE `wishlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD CONSTRAINT `wishlist_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `wishlist_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
