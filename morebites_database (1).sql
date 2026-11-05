-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 05, 2026 at 09:10 AM
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
-- Database: `more_bites`
--

-- --------------------------------------------------------

--
-- Table structure for table `audit_log`
--

CREATE TABLE `audit_log` (
  `audit_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(50) NOT NULL,
  `table_affected` varchar(50) NOT NULL,
  `record_id` int(11) DEFAULT NULL,
  `old_values` text DEFAULT NULL,
  `new_values` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bank_payment`
--

CREATE TABLE `bank_payment` (
  `bank_payment_id` int(11) NOT NULL,
  `payment_id` int(11) NOT NULL,
  `bank_name` varchar(50) NOT NULL,
  `transaction_number` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cash_payment`
--

CREATE TABLE `cash_payment` (
  `cash_payment_id` int(11) NOT NULL,
  `payment_id` int(11) NOT NULL,
  `amount_tendered` decimal(10,2) NOT NULL,
  `change_given` decimal(10,2) NOT NULL DEFAULT 0.00
) ;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `middle_initial` varchar(5) DEFAULT NULL,
  `contact_no` varchar(20) NOT NULL,
  `address` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `delivery`
--

CREATE TABLE `delivery` (
  `delivery_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `delivery_rider_id` int(11) NOT NULL,
  `delivery_location_id` int(11) NOT NULL,
  `delivery_fee` decimal(10,2) NOT NULL,
  `dispatched_at` datetime DEFAULT NULL,
  `delivered_at` datetime DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `delivery_location`
--

CREATE TABLE `delivery_location` (
  `delivery_location_id` int(11) NOT NULL,
  `origin` varchar(255) NOT NULL,
  `destination` varchar(255) NOT NULL,
  `distance_km` decimal(10,2) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `delivery_rider`
--

CREATE TABLE `delivery_rider` (
  `delivery_rider_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `middle_initial` varchar(5) DEFAULT NULL,
  `phone` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gcash_payment`
--

CREATE TABLE `gcash_payment` (
  `gcash_payment_id` int(11) NOT NULL,
  `payment_id` int(11) NOT NULL,
  `reference_number` varchar(50) NOT NULL,
  `sender_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `high_stock_alert`
--

CREATE TABLE `high_stock_alert` (
  `high_stock_alert_id` int(11) NOT NULL,
  `inventory_id` int(11) NOT NULL,
  `stock_level` decimal(10,2) NOT NULL,
  `alert_date` datetime NOT NULL DEFAULT current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Table structure for table `ingredient`
--

CREATE TABLE `ingredient` (
  `ingredient_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `ingredient_name` varchar(100) NOT NULL,
  `unit_cost` decimal(10,2) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `inventory_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  `stock_quantity` decimal(10,2) NOT NULL DEFAULT 0.00
) ;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_threshold`
--

CREATE TABLE `inventory_threshold` (
  `threshold_id` int(11) NOT NULL,
  `inventory_id` int(11) NOT NULL,
  `low_threshold` decimal(10,2) NOT NULL,
  `high_threshold` decimal(10,2) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `low_stock_alert`
--

CREATE TABLE `low_stock_alert` (
  `low_stock_alert_id` int(11) NOT NULL,
  `inventory_id` int(11) NOT NULL,
  `stock_level` decimal(10,2) NOT NULL,
  `alert_date` datetime NOT NULL DEFAULT current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `menu_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `menu_name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `availability` tinyint(1) NOT NULL DEFAULT 1
) ;

-- --------------------------------------------------------

--
-- Table structure for table `menu_ingredient`
--

CREATE TABLE `menu_ingredient` (
  `menu_ingredient_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  `quantity_needed` decimal(10,2) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `order_status_id` int(11) NOT NULL,
  `order_type_id` int(11) NOT NULL,
  `order_date` datetime NOT NULL DEFAULT current_timestamp(),
  `total_amount` decimal(10,2) NOT NULL,
  `remarks` varchar(255) DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `order_item`
--

CREATE TABLE `order_item` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `order_status`
--

CREATE TABLE `order_status` (
  `order_status_id` int(11) NOT NULL,
  `status_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_status`
--

INSERT INTO `order_status` (`order_status_id`, `status_name`) VALUES
(7, 'Cancelled'),
(2, 'Confirmed'),
(6, 'Delivered'),
(5, 'Out for Delivery'),
(1, 'Pending'),
(3, 'Preparing'),
(4, 'Ready');

-- --------------------------------------------------------

--
-- Table structure for table `order_status_log`
--

CREATE TABLE `order_status_log` (
  `log_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `order_status_id` int(11) NOT NULL,
  `remarks` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_type`
--

CREATE TABLE `order_type` (
  `order_type_id` int(11) NOT NULL,
  `type_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `payment_method` varchar(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `payment_date` datetime NOT NULL DEFAULT current_timestamp(),
  `amount_paid` decimal(10,2) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `purchase`
--

CREATE TABLE `purchase` (
  `purchase_id` int(11) NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `purchase_date` datetime NOT NULL DEFAULT current_timestamp(),
  `total_amount` decimal(10,2) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_item`
--

CREATE TABLE `purchase_item` (
  `purchase_item_id` int(11) NOT NULL,
  `purchase_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`role_id`, `role_name`, `description`) VALUES
(1, 'Owner', 'Full access: dashboard, reports, purchasing, and user management'),
(2, 'Staff', 'Handles orders, payments, deliveries, and stock');

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE `status` (
  `status_id` int(11) NOT NULL,
  `status_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`status_id`, `status_name`) VALUES
(1, 'Active'),
(2, 'Inactive');

-- --------------------------------------------------------

--
-- Table structure for table `stock_in`
--

CREATE TABLE `stock_in` (
  `stock_in_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  `purchase_id` int(11) NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `date_in` datetime NOT NULL DEFAULT current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Table structure for table `stock_out`
--

CREATE TABLE `stock_out` (
  `stock_out_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  `reason` varchar(50) NOT NULL,
  `order_item_id` int(11) DEFAULT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `date_out` datetime NOT NULL DEFAULT current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `supplier_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `supplier_name` varchar(100) NOT NULL,
  `contact_person` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `unit`
--

CREATE TABLE `unit` (
  `unit_id` int(11) NOT NULL,
  `unit_name` varchar(50) NOT NULL,
  `abbreviation` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `unit`
--

INSERT INTO `unit` (`unit_id`, `unit_name`, `abbreviation`) VALUES
(1, 'Kilogram', 'kg'),
(2, 'Gram', 'g'),
(3, 'Liter', 'L'),
(4, 'Milliliter', 'mL'),
(5, 'Piece', 'pc');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `middle_initial` varchar(5) DEFAULT NULL,
  `contact_no` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle`
--

CREATE TABLE `vehicle` (
  `vehicle_id` int(11) NOT NULL,
  `vehicle_type` varchar(50) NOT NULL,
  `plate_number` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_log`
--
ALTER TABLE `audit_log`
  ADD PRIMARY KEY (`audit_id`),
  ADD KEY `fk_audit_log_user` (`user_id`);

--
-- Indexes for table `bank_payment`
--
ALTER TABLE `bank_payment`
  ADD PRIMARY KEY (`bank_payment_id`),
  ADD UNIQUE KEY `uq_bank_payment_payment` (`payment_id`),
  ADD UNIQUE KEY `uq_bank_transaction` (`transaction_number`);

--
-- Indexes for table `cash_payment`
--
ALTER TABLE `cash_payment`
  ADD PRIMARY KEY (`cash_payment_id`),
  ADD UNIQUE KEY `uq_cash_payment_payment` (`payment_id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `uq_category_name` (`category_name`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`),
  ADD KEY `fk_customer_status` (`status_id`);

--
-- Indexes for table `delivery`
--
ALTER TABLE `delivery`
  ADD PRIMARY KEY (`delivery_id`),
  ADD UNIQUE KEY `uq_delivery_order` (`order_id`),
  ADD KEY `fk_delivery_rider` (`delivery_rider_id`),
  ADD KEY `fk_delivery_location` (`delivery_location_id`);

--
-- Indexes for table `delivery_location`
--
ALTER TABLE `delivery_location`
  ADD PRIMARY KEY (`delivery_location_id`);

--
-- Indexes for table `delivery_rider`
--
ALTER TABLE `delivery_rider`
  ADD PRIMARY KEY (`delivery_rider_id`),
  ADD UNIQUE KEY `uq_rider_vehicle` (`vehicle_id`),
  ADD KEY `fk_rider_status` (`status_id`);

--
-- Indexes for table `gcash_payment`
--
ALTER TABLE `gcash_payment`
  ADD PRIMARY KEY (`gcash_payment_id`),
  ADD UNIQUE KEY `uq_gcash_payment_payment` (`payment_id`),
  ADD UNIQUE KEY `uq_gcash_reference` (`reference_number`);

--
-- Indexes for table `high_stock_alert`
--
ALTER TABLE `high_stock_alert`
  ADD PRIMARY KEY (`high_stock_alert_id`),
  ADD KEY `fk_high_alert_inventory` (`inventory_id`);

--
-- Indexes for table `ingredient`
--
ALTER TABLE `ingredient`
  ADD PRIMARY KEY (`ingredient_id`),
  ADD UNIQUE KEY `uq_ingredient_name` (`ingredient_name`),
  ADD KEY `fk_ingredient_unit` (`unit_id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`inventory_id`),
  ADD UNIQUE KEY `uq_inventory_ingredient` (`ingredient_id`);

--
-- Indexes for table `inventory_threshold`
--
ALTER TABLE `inventory_threshold`
  ADD PRIMARY KEY (`threshold_id`),
  ADD UNIQUE KEY `uq_threshold_inventory` (`inventory_id`);

--
-- Indexes for table `low_stock_alert`
--
ALTER TABLE `low_stock_alert`
  ADD PRIMARY KEY (`low_stock_alert_id`),
  ADD KEY `fk_low_alert_inventory` (`inventory_id`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`menu_id`),
  ADD UNIQUE KEY `uq_menu_name` (`menu_name`),
  ADD KEY `fk_menu_category` (`category_id`);

--
-- Indexes for table `menu_ingredient`
--
ALTER TABLE `menu_ingredient`
  ADD PRIMARY KEY (`menu_ingredient_id`),
  ADD KEY `fk_menu_ingredient_menu` (`menu_id`),
  ADD KEY `fk_menu_ingredient_ingredient` (`ingredient_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `fk_orders_customer` (`customer_id`),
  ADD KEY `fk_orders_order_status` (`order_status_id`),
  ADD KEY `fk_orders_order_type` (`order_type_id`);

--
-- Indexes for table `order_item`
--
ALTER TABLE `order_item`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `fk_order_item_order` (`order_id`),
  ADD KEY `fk_order_item_menu` (`menu_id`);

--
-- Indexes for table `order_status`
--
ALTER TABLE `order_status`
  ADD PRIMARY KEY (`order_status_id`),
  ADD UNIQUE KEY `uq_order_status_name` (`status_name`);

--
-- Indexes for table `order_status_log`
--
ALTER TABLE `order_status_log`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `fk_status_log_order` (`order_id`),
  ADD KEY `fk_status_log_status` (`order_status_id`);

--
-- Indexes for table `order_type`
--
ALTER TABLE `order_type`
  ADD PRIMARY KEY (`order_type_id`),
  ADD UNIQUE KEY `uq_order_type_name` (`type_name`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD UNIQUE KEY `uq_payment_order` (`order_id`),
  ADD KEY `fk_payment_user` (`user_id`);

--
-- Indexes for table `purchase`
--
ALTER TABLE `purchase`
  ADD PRIMARY KEY (`purchase_id`),
  ADD KEY `fk_purchase_supplier` (`supplier_id`),
  ADD KEY `fk_purchase_user` (`user_id`);

--
-- Indexes for table `purchase_item`
--
ALTER TABLE `purchase_item`
  ADD PRIMARY KEY (`purchase_item_id`),
  ADD KEY `fk_purchase_item_purchase` (`purchase_id`),
  ADD KEY `fk_purchase_item_ingredient` (`ingredient_id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `uq_role_name` (`role_name`);

--
-- Indexes for table `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`status_id`),
  ADD UNIQUE KEY `uq_status_name` (`status_name`);

--
-- Indexes for table `stock_in`
--
ALTER TABLE `stock_in`
  ADD PRIMARY KEY (`stock_in_id`),
  ADD KEY `fk_stock_in_ingredient` (`ingredient_id`),
  ADD KEY `fk_stock_in_purchase` (`purchase_id`);

--
-- Indexes for table `stock_out`
--
ALTER TABLE `stock_out`
  ADD PRIMARY KEY (`stock_out_id`),
  ADD KEY `fk_stock_out_ingredient` (`ingredient_id`),
  ADD KEY `fk_stock_out_order_item` (`order_item_id`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`supplier_id`),
  ADD UNIQUE KEY `uq_supplier_name` (`supplier_name`),
  ADD KEY `fk_supplier_status` (`status_id`);

--
-- Indexes for table `unit`
--
ALTER TABLE `unit`
  ADD PRIMARY KEY (`unit_id`),
  ADD UNIQUE KEY `uq_unit_name` (`unit_name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `uq_users_username` (`username`),
  ADD KEY `fk_users_role` (`role_id`),
  ADD KEY `fk_users_status` (`status_id`);

--
-- Indexes for table `vehicle`
--
ALTER TABLE `vehicle`
  ADD PRIMARY KEY (`vehicle_id`),
  ADD UNIQUE KEY `uq_vehicle_plate` (`plate_number`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_log`
--
ALTER TABLE `audit_log`
  MODIFY `audit_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bank_payment`
--
ALTER TABLE `bank_payment`
  MODIFY `bank_payment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cash_payment`
--
ALTER TABLE `cash_payment`
  MODIFY `cash_payment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `delivery`
--
ALTER TABLE `delivery`
  MODIFY `delivery_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `delivery_location`
--
ALTER TABLE `delivery_location`
  MODIFY `delivery_location_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `delivery_rider`
--
ALTER TABLE `delivery_rider`
  MODIFY `delivery_rider_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gcash_payment`
--
ALTER TABLE `gcash_payment`
  MODIFY `gcash_payment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `high_stock_alert`
--
ALTER TABLE `high_stock_alert`
  MODIFY `high_stock_alert_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ingredient`
--
ALTER TABLE `ingredient`
  MODIFY `ingredient_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `inventory_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventory_threshold`
--
ALTER TABLE `inventory_threshold`
  MODIFY `threshold_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `low_stock_alert`
--
ALTER TABLE `low_stock_alert`
  MODIFY `low_stock_alert_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `menu_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menu_ingredient`
--
ALTER TABLE `menu_ingredient`
  MODIFY `menu_ingredient_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_item`
--
ALTER TABLE `order_item`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_status`
--
ALTER TABLE `order_status`
  MODIFY `order_status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `order_status_log`
--
ALTER TABLE `order_status_log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_type`
--
ALTER TABLE `order_type`
  MODIFY `order_type_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase`
--
ALTER TABLE `purchase`
  MODIFY `purchase_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_item`
--
ALTER TABLE `purchase_item`
  MODIFY `purchase_item_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `status`
--
ALTER TABLE `status`
  MODIFY `status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `stock_in`
--
ALTER TABLE `stock_in`
  MODIFY `stock_in_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stock_out`
--
ALTER TABLE `stock_out`
  MODIFY `stock_out_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `supplier_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `unit`
--
ALTER TABLE `unit`
  MODIFY `unit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vehicle`
--
ALTER TABLE `vehicle`
  MODIFY `vehicle_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit_log`
--
ALTER TABLE `audit_log`
  ADD CONSTRAINT `fk_audit_log_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `bank_payment`
--
ALTER TABLE `bank_payment`
  ADD CONSTRAINT `fk_bank_payment_payment` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`payment_id`) ON UPDATE CASCADE;

--
-- Constraints for table `cash_payment`
--
ALTER TABLE `cash_payment`
  ADD CONSTRAINT `fk_cash_payment_payment` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`payment_id`) ON UPDATE CASCADE;

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `fk_customer_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`) ON UPDATE CASCADE;

--
-- Constraints for table `delivery`
--
ALTER TABLE `delivery`
  ADD CONSTRAINT `fk_delivery_location` FOREIGN KEY (`delivery_location_id`) REFERENCES `delivery_location` (`delivery_location_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_delivery_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_delivery_rider` FOREIGN KEY (`delivery_rider_id`) REFERENCES `delivery_rider` (`delivery_rider_id`) ON UPDATE CASCADE;

--
-- Constraints for table `delivery_rider`
--
ALTER TABLE `delivery_rider`
  ADD CONSTRAINT `fk_rider_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_rider_vehicle` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`vehicle_id`) ON UPDATE CASCADE;

--
-- Constraints for table `gcash_payment`
--
ALTER TABLE `gcash_payment`
  ADD CONSTRAINT `fk_gcash_payment_payment` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`payment_id`) ON UPDATE CASCADE;

--
-- Constraints for table `high_stock_alert`
--
ALTER TABLE `high_stock_alert`
  ADD CONSTRAINT `fk_high_alert_inventory` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`inventory_id`) ON UPDATE CASCADE;

--
-- Constraints for table `ingredient`
--
ALTER TABLE `ingredient`
  ADD CONSTRAINT `fk_ingredient_unit` FOREIGN KEY (`unit_id`) REFERENCES `unit` (`unit_id`) ON UPDATE CASCADE;

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `fk_inventory_ingredient` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`ingredient_id`) ON UPDATE CASCADE;

--
-- Constraints for table `inventory_threshold`
--
ALTER TABLE `inventory_threshold`
  ADD CONSTRAINT `fk_threshold_inventory` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`inventory_id`) ON UPDATE CASCADE;

--
-- Constraints for table `low_stock_alert`
--
ALTER TABLE `low_stock_alert`
  ADD CONSTRAINT `fk_low_alert_inventory` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`inventory_id`) ON UPDATE CASCADE;

--
-- Constraints for table `menu`
--
ALTER TABLE `menu`
  ADD CONSTRAINT `fk_menu_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE;

--
-- Constraints for table `menu_ingredient`
--
ALTER TABLE `menu_ingredient`
  ADD CONSTRAINT `fk_menu_ingredient_ingredient` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`ingredient_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_menu_ingredient_menu` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`menu_id`) ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_orders_order_status` FOREIGN KEY (`order_status_id`) REFERENCES `order_status` (`order_status_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_orders_order_type` FOREIGN KEY (`order_type_id`) REFERENCES `order_type` (`order_type_id`) ON UPDATE CASCADE;

--
-- Constraints for table `order_item`
--
ALTER TABLE `order_item`
  ADD CONSTRAINT `fk_order_item_menu` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`menu_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_order_item_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON UPDATE CASCADE;

--
-- Constraints for table `order_status_log`
--
ALTER TABLE `order_status_log`
  ADD CONSTRAINT `fk_status_log_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_status_log_status` FOREIGN KEY (`order_status_id`) REFERENCES `order_status` (`order_status_id`) ON UPDATE CASCADE;

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `fk_payment_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_payment_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `purchase`
--
ALTER TABLE `purchase`
  ADD CONSTRAINT `fk_purchase_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`supplier_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_purchase_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `purchase_item`
--
ALTER TABLE `purchase_item`
  ADD CONSTRAINT `fk_purchase_item_ingredient` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`ingredient_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_purchase_item_purchase` FOREIGN KEY (`purchase_id`) REFERENCES `purchase` (`purchase_id`) ON UPDATE CASCADE;

--
-- Constraints for table `stock_in`
--
ALTER TABLE `stock_in`
  ADD CONSTRAINT `fk_stock_in_ingredient` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`ingredient_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_stock_in_purchase` FOREIGN KEY (`purchase_id`) REFERENCES `purchase` (`purchase_id`) ON UPDATE CASCADE;

--
-- Constraints for table `stock_out`
--
ALTER TABLE `stock_out`
  ADD CONSTRAINT `fk_stock_out_ingredient` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`ingredient_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_stock_out_order_item` FOREIGN KEY (`order_item_id`) REFERENCES `order_item` (`order_item_id`);

--
-- Constraints for table `supplier`
--
ALTER TABLE `supplier`
  ADD CONSTRAINT `fk_supplier_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`) ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_users_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
