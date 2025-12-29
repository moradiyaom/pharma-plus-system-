-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 29, 2025 at 05:37 AM
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
-- Database: `users`
--

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `profile_photo` varchar(255) DEFAULT 'default-avatar.jpg',
  `join_date` datetime DEFAULT current_timestamp(),
  `last_login` datetime DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customer_inventory`
--

CREATE TABLE `customer_inventory` (
  `id` int(11) NOT NULL,
  `inventory_id` int(11) NOT NULL,
  `image` varchar(255) DEFAULT 'default.png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `medicine` varchar(100) NOT NULL,
  `category` varchar(100) NOT NULL,
  `registered_qty` int(11) NOT NULL,
  `sold_qty` int(11) NOT NULL DEFAULT 0,
  `remain_qty` int(11) GENERATED ALWAYS AS (`registered_qty` - `sold_qty`) STORED,
  `registered_date` date NOT NULL,
  `expiry_date` date NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `actual_price` decimal(10,2) DEFAULT NULL,
  `selling_price` decimal(10,2) DEFAULT NULL,
  `status` enum('Available','Out of Stock') DEFAULT 'Available',
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`id`, `code`, `medicine`, `category`, `registered_qty`, `sold_qty`, `registered_date`, `expiry_date`, `remark`, `actual_price`, `selling_price`, `status`, `image`) VALUES
(11, '1478', 'Khadi Pure Lavender Handmade Herbal Soap 125 gm', 'soap', 100, 10, '2025-09-10', '2026-10-05', 'none', 100.00, 80.00, 'Available', NULL),
(12, '1236', 'Apollo Pharmacy Glycerin Bathing Bar, 75 gm (Buy 2 Get 2 Free)', 'soap', 100, 0, '2025-09-12', '2027-10-15', 'none', 200.00, 150.00, 'Available', NULL),
(13, '9874', 'Ensure Diabetes Care Vanilla Delight Flavour Powder for Adults, 1 kg (2x500 gm)', 'tab', 100, 3, '2025-09-12', '2027-10-13', 'none', 2500.00, 2000.00, 'Available', NULL),
(14, '7458', 'Alcomax Tablet', 'tab', 100, 5, '2025-09-12', '2027-02-25', 'none', 300.00, 250.00, 'Available', NULL),
(15, '8745', 'Cetaphil Baby Daily lotion', 'lotion', 100, 0, '2025-10-03', '2026-05-10', 'none', 1000.00, 900.00, 'Available', NULL),
(16, '0310', 'Nestle Ceregrow Multigrain Cereal with Milk & Fruits Powder', 'baby food', 100, 0, '2025-10-03', '2026-10-15', 'none', 500.00, 300.00, 'Available', NULL),
(17, '3698', 'Nestle Nan Pro Stage 1 Infant Formula Milk Powder', 'baby food', 100, 0, '2025-10-03', '2026-05-20', 'none', 1000.00, 800.00, 'Available', NULL),
(18, '5204', 'Easum Rice & Moong Dal Baby Cereal, 6 to 24 Months, 400 gm Refill Pack', 'baby food', 100, 0, '2025-10-03', '2026-06-25', 'none', 500.00, 350.00, 'Available', NULL),
(19, '6547', 'Apollo Life Electro Choice Apple Flavour Liquid 600 ml, (3x200 ml)', 'food drink', 100, 0, '2025-10-03', '2027-09-20', 'none', 200.00, 150.00, 'Available', NULL),
(20, '2580', 'Sebamed Baby Body Milk Lotion, 400 ml', 'lotion', 100, 0, '2025-10-03', '2027-07-19', 'none', 1800.00, 1500.00, 'Available', NULL),
(21, '7410', 'Apollo Life Chia Seeds, 125 gm', 'food drink', 100, 0, '2025-10-03', '2027-09-19', 'none', 200.00, 150.00, 'Available', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
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
  `price` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) GENERATED ALWAYS AS (`quantity` * `price`) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `payment_type` varchar(50) NOT NULL,
  `payment_id` varchar(100) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `status` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `payment_type`, `payment_id`, `amount`, `status`, `created_at`) VALUES
(1, 'COD', NULL, 500.00, 'Pending', '2025-09-12 04:25:40'),
(2, 'COD', NULL, 500.00, 'Pending', '2025-09-12 04:41:50'),
(3, 'PayPal', NULL, 500.00, 'Success', '2025-09-12 04:43:41');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `barcode` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `actual_price` decimal(10,2) NOT NULL,
  `selling_price` decimal(10,2) NOT NULL,
  `image1` varchar(255) NOT NULL,
  `image2` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `quantity` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `barcode`, `name`, `category`, `actual_price`, `selling_price`, `image1`, `image2`, `created_at`, `quantity`) VALUES
(1, '1478', 'Khadi Pure Lavender Handmade Herbal Soap 125 gm', 'soap', 100.00, 80.00, '1757488350_1_Screenshot 2025-09-10 124138.png', '1757488350_2_Screenshot 2025-09-09 124340.png', '2025-09-10 07:12:30', 0),
(2, '1236', 'Apollo Pharmacy Glycerin Bathing Bar, 75 gm (Buy 2 Get 2 Free)', 'soap', 200.00, 150.00, '1757669895_1_Screenshot 2025-09-12 150742.png', '1757669895_2_Screenshot 2025-09-09 123436.png', '2025-09-12 09:38:15', 0),
(3, '9874', 'Ensure Diabetes Care Vanilla Delight Flavour Powder for Adults, 1 kg (2x500 gm)', 'tab', 2500.00, 2000.00, '1757669992_1_Screenshot 2025-09-12 150918.png', '1757669992_2_Screenshot 2025-09-12 150941.png', '2025-09-12 09:39:52', 0),
(4, '7458', 'Alcomax Tablet', 'tab', 300.00, 250.00, '1757670113_1_Screenshot 2025-09-12 151127.png', '1757670113_2_Screenshot 2025-09-12 151144.png', '2025-09-12 09:41:53', 0),
(5, '8745', 'Cetaphil Baby Daily lotion', 'lotion', 1000.00, 900.00, '1759464446_1_Screenshot 2025-10-01 131134.png', '1759464446_2_Screenshot 2025-10-03 093713.png', '2025-10-03 04:07:26', 0),
(6, '0310', 'Nestle Ceregrow Multigrain Cereal with Milk & Fruits Powder', 'baby food', 500.00, 300.00, '1759464791_1_Screenshot 2025-10-03 094207.png', '1759464791_2_Screenshot 2025-10-03 094223.png', '2025-10-03 04:13:11', 0),
(7, '3698', 'Nestle Nan Pro Stage 1 Infant Formula Milk Powder', 'baby food', 1000.00, 800.00, '1759465559_1_Screenshot 2025-10-03 095502.png', '1759465559_2_Screenshot 2025-10-03 095522.png', '2025-10-03 04:25:59', 0),
(8, '5204', 'Easum Rice & Moong Dal Baby Cereal, 6 to 24 Months, 400 gm Refill Pack', 'baby food', 500.00, 350.00, '1759465691_1_Screenshot 2025-10-03 095638.png', '1759465691_2_Screenshot 2025-10-03 095655.png', '2025-10-03 04:28:11', 0),
(9, '6547', 'Apollo Life Electro Choice Apple Flavour Liquid 600 ml, (3x200 ml)', 'food drink', 200.00, 150.00, '1759466223_1_Screenshot 2025-10-03 100642.png', '1759466223_2_Screenshot 2025-10-03 100656.png', '2025-10-03 04:37:03', 0),
(10, '2580', 'Sebamed Baby Body Milk Lotion, 400 ml', 'lotion', 1800.00, 1500.00, '1759466835_1_Screenshot 2025-10-03 101522.png', '1759466835_2_Screenshot 2025-10-03 101652.png', '2025-10-03 04:47:15', 0),
(11, '7410', 'Apollo Life Chia Seeds, 125 gm', 'food drink', 200.00, 150.00, '1759466989_1_Screenshot 2025-10-03 101829.png', '1759466989_2_Screenshot 2025-10-03 101914.png', '2025-10-03 04:49:49', 0);

-- --------------------------------------------------------

--
-- Table structure for table `products_cus`
--

CREATE TABLE `products_cus` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `category` varchar(100) NOT NULL,
  `mrp` decimal(10,2) NOT NULL,
  `expiry_date` date NOT NULL,
  `total_qty` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(11) NOT NULL,
  `barcode` varchar(100) DEFAULT NULL,
  `medicine` varchar(255) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `sold_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `barcode`, `medicine`, `category`, `quantity`, `price`, `total`, `payment_method`, `sold_date`) VALUES
(24, '1478', 'Khadi Pure Lavender Handmade Herbal Soap 125 gm', NULL, 2, 80.00, 160.00, 'COD', '2025-09-12 05:29:18'),
(25, '1478', 'Khadi Pure Lavender Handmade Herbal Soap 125 gm', NULL, 1, 80.00, 80.00, 'GPay', '2025-09-12 05:29:40'),
(26, '1478', 'Khadi Pure Lavender Handmade Herbal Soap 125 gm', NULL, 1, 80.00, 80.00, 'PayPal', '2025-09-12 05:29:53'),
(27, '1478', 'Khadi Pure Lavender Handmade Herbal Soap 125 gm', NULL, 5, 80.00, 400.00, 'GPay', '2025-09-12 09:36:11'),
(28, '7458', 'Alcomax Tablet', NULL, 1, 250.00, 250.00, 'GPay', '2025-09-12 09:45:18'),
(29, '9874', 'Ensure Diabetes Care Vanilla Delight Flavour Powder for Adults, 1 kg (2x500 gm)', NULL, 1, 2000.00, 2000.00, 'COD', '2025-09-12 09:50:23'),
(30, '7458', 'Alcomax Tablet', NULL, 1, 250.00, 250.00, 'GPay', '2025-09-14 18:31:36'),
(31, '7458', 'Alcomax Tablet', NULL, 1, 250.00, 250.00, NULL, '2025-09-16 23:57:24'),
(32, '7458', 'Alcomax Tablet', NULL, 1, 250.00, 250.00, 'PayPal', '2025-09-17 00:34:40'),
(33, '7458', 'Alcomax Tablet', NULL, 1, 250.00, 250.00, NULL, '2025-09-17 06:51:15'),
(34, '9874', 'Ensure Diabetes Care Vanilla Delight Flavour Powder for Adults, 1 kg (2x500 gm)', NULL, 1, 2000.00, 2000.00, 'COD', '2025-09-17 06:53:06'),
(35, '9874', 'Ensure Diabetes Care Vanilla Delight Flavour Powder for Adults, 1 kg (2x500 gm)', NULL, 1, 2000.00, 2000.00, 'PayPal', '2025-09-17 06:54:20'),
(36, '1478', 'Khadi Pure Lavender Handmade Herbal Soap 125 gm', NULL, 1, 80.00, 80.00, 'COD', '2025-09-17 07:14:06'),
(37, '5204', 'Easum Rice & Moong Dal Baby Cereal, 6 to 24 Months, 400 gm Refill Pack', 'baby food', 1, 350.00, 350.00, 'COD', '2025-10-04 04:58:21'),
(38, '7410', 'Apollo Life Chia Seeds, 125 gm', 'food drink', 1, 150.00, 150.00, 'COD', '2025-10-04 05:02:22'),
(39, '7458', 'Alcomax Tablet', 'tab', 1, 250.00, 250.00, 'COD', '2025-10-31 04:38:34'),
(40, '5204', 'Easum Rice & Moong Dal Baby Cereal, 6 to 24 Months, 400 gm Refill Pack', 'baby food', 1, 350.00, 350.00, 'COD', '2025-10-31 04:40:14'),
(41, '6547', 'Apollo Life Electro Choice Apple Flavour Liquid 600 ml, (3x200 ml)', 'food drink', 1, 150.00, 150.00, 'GPay', '2025-11-07 04:29:50');

-- --------------------------------------------------------

--
-- Table structure for table `support_requests`
--

CREATE TABLE `support_requests` (
  `id` int(11) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `role` enum('Customer','Company','Admin') NOT NULL,
  `subject` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `status` enum('Pending','In Progress','Resolved','Closed') DEFAULT 'Pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `userdata`
--

CREATE TABLE `userdata` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','company','customer') NOT NULL,
  `profile_photo` varchar(255) DEFAULT 'default-avatar.jpg',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `userdata`
--

INSERT INTO `userdata` (`id`, `username`, `email`, `phone`, `address`, `password`, `role`, `profile_photo`, `created_at`) VALUES
(9, 'admin', 'admin@gmail.com', '9484485519', 'surat', '$2y$10$Ks1MOrbeFmA1XWGs/2o2B.uNg.TZ7TKAm3yzNIFEbkjBsUTPfwRla', 'admin', 'default-avatar.jpg', '2025-09-04 06:40:39'),
(10, 'company', 'company@gmail.com', NULL, NULL, '$2y$10$3pOJRZLP0qqDvnL2b8ZOSe2CDaUmsZRhCQS0WJ9kWFsdAGh1H5vNm', 'company', 'default-avatar.jpg', '2025-09-04 06:50:13'),
(11, 'customer', 'customer@gmail.com', '8160988504', 'surat', '$2y$10$0TBj4mr22UwL8rM9TovGIOmGNYO6/Lx7QpyP0UlpXrcJ1rvon0LLe', 'customer', 'user_11_1757347700.png', '2025-09-04 06:54:23');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `customer_inventory`
--
ALTER TABLE `customer_inventory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inventory_id` (`inventory_id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_id` (`company_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `barcode` (`barcode`);

--
-- Indexes for table `products_cus`
--
ALTER TABLE `products_cus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `support_requests`
--
ALTER TABLE `support_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `userdata`
--
ALTER TABLE `userdata`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customer_inventory`
--
ALTER TABLE `customer_inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

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
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `products_cus`
--
ALTER TABLE `products_cus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `support_requests`
--
ALTER TABLE `support_requests`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `userdata`
--
ALTER TABLE `userdata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customer_inventory`
--
ALTER TABLE `customer_inventory`
  ADD CONSTRAINT `customer_inventory_ibfk_1` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `userdata` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `userdata` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
