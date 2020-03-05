-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 01, 2020 at 02:02 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sita2`
--

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8_persian_ci DEFAULT NULL,
  `text` text COLLATE utf8_persian_ci NOT NULL,
  `static_phone` varchar(15) COLLATE utf8_persian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`id`, `name`, `text`, `static_phone`) VALUES
(2, 'منزل', 'تهران،نیاوران،کاشانک', '02122808845'),
(3, 'محل کار', 'چهارراه ولیعصر، دانشگاه صنعتی امیرکبیر', '02122808846'),
(4, 'آدرس1', 'شیراز', '02122808845'),
(8, NULL, 'تهران، یوسف آباد', '02122808845'),
(9, 'آدرس1', 'آدرس1آدرس1آدرس1', '02122808845'),
(10, 'آدرس2', 'آدرس2آدرس2آدرس2', '02122808846'),
(11, NULL, 'okfpifjwiofjwoifwoifhwoihfwoif', '02122808845'),
(12, 'صبخهاضبعاعبها', 'صبخهضابخضصاب', '02122808845'),
(13, 'foo', 'foobar', '02122808845'),
(14, 'آدرسجدید', 'آدرس جدید علیرضا', '02122808846'),
(15, 'foo', 'foobar', '02122808845'),
(16, 'foo', 'foobar', '02122808845'),
(17, 'eneuifbweuib', 'wjfbfb', '02122808846'),
(18, 'foo', 'foobarfoobarr', '02122808847'),
(19, NULL, 'آدرس برای سفارش', '02122808847');

--
-- Triggers `address`
--
DELIMITER $$
CREATE TRIGGER `address_delete_logger` AFTER DELETE ON `address` FOR EACH ROW INSERT INTO address_log(operation,address_name,address_text,address_static_phone) VALUES ("delete",OLD.name,OLD.text,OLD.static_phone)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `address_insert_logger` AFTER INSERT ON `address` FOR EACH ROW INSERT INTO address_log(operation,address_name,address_text,address_static_phone) VALUES ("insert",NEW.name,NEW.text,NEW.static_phone)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `address_update_logger` AFTER UPDATE ON `address` FOR EACH ROW INSERT INTO address_log(operation,address_name,address_text,address_static_phone) VALUES ("update",NEW.name,NEW.text,NEW.static_phone)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `static_phone_validator` BEFORE INSERT ON `address` FOR EACH ROW BEGIN IF (NEW.static_phone REGEXP '[0]\d{2,3}\d{8}' ) = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Not a valid static phone number';END IF;END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `address_log`
--

CREATE TABLE `address_log` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `operation` varchar(10) COLLATE utf8_persian_ci NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `address_name` varchar(50) COLLATE utf8_persian_ci DEFAULT NULL,
  `address_text` text COLLATE utf8_persian_ci DEFAULT NULL,
  `address_static_phone` varchar(15) COLLATE utf8_persian_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci;

--
-- Dumping data for table `address_log`
--

INSERT INTO `address_log` (`id`, `operation`, `date`, `address_name`, `address_text`, `address_static_phone`) VALUES
(1, 'insert', '2020-01-24 18:30:08', 'addr', 'addr', '02122808845'),
(2, 'delete', '2020-01-24 18:30:34', 'addr', 'addr', '02122808845'),
(3, 'insert', '2020-01-24 18:31:34', 'منزل', 'تهران،نیاوران،کاشانک', '02122808845'),
(4, 'insert', '2020-01-24 18:32:06', 'محل کار', 'چهارراه ولیعصر، دانشگاه صنعتی امیرکبیر', '02122808846'),
(5, 'update', '2020-01-24 18:32:07', 'منزل', 'تهران،نیاوران،کاشانک', '02122808845'),
(6, 'update', '2020-01-24 18:32:07', 'منزل', 'تهران،نیاوران،کاشانک', '02122808845'),
(7, 'update', '2020-01-24 18:32:07', 'منزل', 'تهران،نیاوران،کاشانک', '02122808845'),
(8, 'insert', '2020-01-24 21:22:09', 'آدرس1', 'شیراز', '02122808845'),
(9, 'insert', '2020-01-25 01:26:44', NULL, 'تهران، شریعتی، قلهک', '02122808845'),
(10, 'insert', '2020-01-25 01:26:52', NULL, 'تهران، شریعتی، قلهک', '02122808845'),
(11, 'insert', '2020-01-25 01:27:43', NULL, 'تهران، شریعتی، قلهک', '02122808845'),
(12, 'delete', '2020-01-25 01:30:00', NULL, 'تهران، شریعتی، قلهک', '02122808845'),
(13, 'delete', '2020-01-25 01:30:03', NULL, 'تهران، شریعتی، قلهک', '02122808845'),
(14, 'delete', '2020-01-25 01:30:06', NULL, 'تهران، شریعتی، قلهک', '02122808845'),
(15, 'insert', '2020-01-25 01:43:52', NULL, 'تهران، یوسف آباد', '02122808845'),
(16, 'insert', '2020-01-25 01:46:08', 'آدرس1', 'آدرس1آدرس1آدرس1', '02122808845'),
(17, 'insert', '2020-01-25 01:46:25', 'آدرس2', 'آدرس2آدرس2آدرس2', '02122808846'),
(18, 'update', '2020-01-25 01:46:25', 'آدرس1', 'آدرس1آدرس1آدرس1', '02122808845'),
(19, 'update', '2020-01-25 01:46:25', 'آدرس1', 'آدرس1آدرس1آدرس1', '02122808845'),
(20, 'update', '2020-01-25 01:46:26', 'آدرس1', 'آدرس1آدرس1آدرس1', '02122808845'),
(21, 'insert', '2020-01-25 02:30:57', NULL, 'okfpifjwiofjwoifwoifhwoihfwoif', '02122808845'),
(22, 'insert', '2020-01-25 13:57:23', 'صبخهاضبعاعبها', 'صبخهضابخضصاب', '02122808845'),
(23, 'update', '2020-01-25 13:57:23', 'آدرس1', 'آدرس1آدرس1آدرس1', '02122808845'),
(24, 'update', '2020-01-25 13:57:23', 'آدرس1', 'آدرس1آدرس1آدرس1', '02122808845'),
(25, 'update', '2020-01-25 13:57:23', 'آدرس1', 'آدرس1آدرس1آدرس1', '02122808845'),
(26, 'update', '2020-01-25 13:57:23', 'آدرس2', 'آدرس2آدرس2آدرس2', '02122808846'),
(27, 'update', '2020-01-25 13:57:23', 'آدرس2', 'آدرس2آدرس2آدرس2', '02122808846'),
(28, 'update', '2020-01-25 13:57:23', 'آدرس2', 'آدرس2آدرس2آدرس2', '02122808846'),
(29, 'update', '2020-01-31 16:36:52', 'منزل', 'تهران،نیاوران،کاشانک', '02122808845'),
(30, 'insert', '2020-01-31 16:54:57', 'foo', 'foobar', '02122808845'),
(31, 'insert', '2020-01-31 16:58:40', 'آدرسجدید', 'آدرس جدید علیرضا', '02122808846'),
(32, 'insert', '2020-01-31 17:00:07', 'foo', 'foobar', '02122808845'),
(33, 'insert', '2020-01-31 17:00:59', 'foo', 'foobar', '02122808845'),
(34, 'insert', '2020-01-31 17:02:12', 'eneuifbweuib', 'wjfbfb', '02122808846'),
(35, 'insert', '2020-01-31 17:34:48', 'foo', 'foobarfoobarr', '02122808847'),
(36, 'insert', '2020-01-31 20:42:43', NULL, 'آدرس برای سفارش', '02122808847');

-- --------------------------------------------------------

--
-- Table structure for table `courier`
--

CREATE TABLE `courier` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(50) COLLATE utf8_persian_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8_persian_ci NOT NULL,
  `identification_number` varchar(10) COLLATE utf8_persian_ci NOT NULL,
  `phone_number` varchar(15) COLLATE utf8_persian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci;

--
-- Dumping data for table `courier`
--

INSERT INTO `courier` (`id`, `first_name`, `last_name`, `identification_number`, `phone_number`) VALUES
(1, 'اصغر', 'اصغری', '0371964660', '09031823553'),
(2, 'mohammadh', 'asghari', '0371964660', '09031823553');

--
-- Triggers `courier`
--
DELIMITER $$
CREATE TRIGGER `courier_delete_logger` AFTER DELETE ON `courier` FOR EACH ROW INSERT INTO courier_log(operation,courier_first_name,courier_last_name,courier_identification_number,courier_phone_number) VALUES ("delete",old.first_name,old.last_name,old.identification_number,old.phone_number)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `courier_insert_logger` AFTER INSERT ON `courier` FOR EACH ROW INSERT INTO courier_log(operation,courier_first_name,courier_last_name,courier_identification_number,courier_phone_number) VALUES ("insert",NEW.first_name,NEW.last_name,NEW.identification_number,NEW.phone_number)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `courier_update_logger` AFTER UPDATE ON `courier` FOR EACH ROW INSERT INTO courier_log(operation,courier_first_name,courier_last_name,courier_identification_number,courier_phone_number) VALUES ("update",NEW.first_name,NEW.last_name,NEW.identification_number,NEW.phone_number)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `phone_number_validator2` BEFORE INSERT ON `courier` FOR EACH ROW BEGIN IF (NEW.phone_number REGEXP '(\+98|0|98|0098)?([ ]|-|[()]){0,2}9[0-9]([ ]|-|[()]){0,2}(?:[0-9]([ ]|-|[()]){0,2}){8}' ) = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Not a valid phone number';END IF;END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `courier_log`
--

CREATE TABLE `courier_log` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `operation` varchar(10) COLLATE utf8_persian_ci NOT NULL,
  `courier_first_name` varchar(50) COLLATE utf8_persian_ci DEFAULT NULL,
  `courier_last_name` varchar(50) COLLATE utf8_persian_ci DEFAULT NULL,
  `courier_identification_number` varchar(10) COLLATE utf8_persian_ci DEFAULT NULL,
  `courier_phone_number` varchar(15) COLLATE utf8_persian_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci;

--
-- Dumping data for table `courier_log`
--

INSERT INTO `courier_log` (`id`, `date`, `operation`, `courier_first_name`, `courier_last_name`, `courier_identification_number`, `courier_phone_number`) VALUES
(1, '2020-01-25 02:28:29', 'insert', 'اصغر', 'اصغری', '0371964660', '09031823553'),
(2, '2020-01-25 15:10:33', 'insert', 'mohammadh', 'asghari', '0371964660', '09031823553');

-- --------------------------------------------------------

--
-- Table structure for table `courier_on_order`
--

CREATE TABLE `courier_on_order` (
  `courier_id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(30) COLLATE utf8_persian_ci NOT NULL DEFAULT 'notdelivered'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci;

--
-- Dumping data for table `courier_on_order`
--

INSERT INTO `courier_on_order` (`courier_id`, `order_id`, `status`) VALUES
(1, 7, 'delivered'),
(2, 8, 'delivered');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(50) COLLATE utf8_persian_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8_persian_ci NOT NULL,
  `identification_number` varchar(10) COLLATE utf8_persian_ci NOT NULL,
  `phone_number` varchar(15) COLLATE utf8_persian_ci NOT NULL,
  `age` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id`, `first_name`, `last_name`, `identification_number`, `phone_number`, `age`) VALUES
(1, 'سید محمد هادی', 'طباطبایی', '0371964660', '09031823553', 20),
(4, 'شایان', 'شفقی', '0371964550', '09031823443', 21),
(5, 'علیرضا', 'حقیقی', '0371964668', '09121519003', 30),
(10, 'اصغر', 'اصغری', '0371964660', '09031823553', 20);

--
-- Triggers `customer`
--
DELIMITER $$
CREATE TRIGGER `customer_delete_logger` AFTER DELETE ON `customer` FOR EACH ROW INSERT INTO customer_log(operation,customer_first_name,customer_last_name,customer_identification_number,customer_phone_number,customer_age) VALUES ("delete",OLD.first_name,old.last_name,old.identification_number,old.phone_number,old.age)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `customer_insert_logger` AFTER INSERT ON `customer` FOR EACH ROW INSERT INTO customer_log(operation,customer_first_name,customer_last_name,customer_identification_number,customer_phone_number,customer_age) VALUES ("insert",NEW.first_name,NEW.last_name,NEW.identification_number,NEW.phone_number,NEW.age)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `customer_update_logger` AFTER UPDATE ON `customer` FOR EACH ROW INSERT INTO customer_log(operation,customer_first_name,customer_last_name,customer_identification_number,customer_phone_number,customer_age) VALUES ("update",NEW.first_name,NEW.last_name,NEW.identification_number,NEW.phone_number,NEW.age)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `phone_number_validator` BEFORE INSERT ON `customer` FOR EACH ROW BEGIN 
	IF (NEW.phone_number REGEXP "(\+98|0|98|0098)?([ ]|-|[()]){0,2}9[0-9]([ ]|-|[()]){0,2}(?:[0-9]([ ]|-|[()]){0,2}){8}" ) = 0 
    THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Not a valid phone number';END IF
    ;END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `customer_address`
--

CREATE TABLE `customer_address` (
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `address_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci;

--
-- Dumping data for table `customer_address`
--

INSERT INTO `customer_address` (`customer_id`, `address_id`) VALUES
(1, 2),
(1, 3),
(4, 4),
(5, 18);

-- --------------------------------------------------------

--
-- Table structure for table `customer_log`
--

CREATE TABLE `customer_log` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `operation` varchar(10) COLLATE utf8_persian_ci NOT NULL,
  `customer_first_name` varchar(50) COLLATE utf8_persian_ci DEFAULT NULL,
  `customer_last_name` varchar(50) COLLATE utf8_persian_ci DEFAULT NULL,
  `customer_identification_number` varchar(10) COLLATE utf8_persian_ci DEFAULT NULL,
  `customer_phone_number` varchar(15) COLLATE utf8_persian_ci DEFAULT NULL,
  `customer_age` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci;

--
-- Dumping data for table `customer_log`
--

INSERT INTO `customer_log` (`id`, `date`, `operation`, `customer_first_name`, `customer_last_name`, `customer_identification_number`, `customer_phone_number`, `customer_age`) VALUES
(1, '2020-01-24 17:38:27', 'insert', 'سید محمد هادی', 'طباطبایی', '0371964660', '09031823553', 20),
(3, '2020-01-24 17:39:03', 'delete', 'سید محمد هادی', 'طباطبایی', '0371964660', '09031823553', 20),
(4, '2020-01-24 18:33:20', 'insert', 'شایان', 'شفقی', '0371964660', '09031823554', 21),
(5, '2020-01-24 18:36:03', 'delete', 'شایان', 'شفقی', '0371964660', '09031823554', 21),
(6, '2020-01-24 21:21:53', 'insert', 'شایان', 'شفقی', '0371964550', '09031823443', 21),
(7, '2020-01-25 01:45:47', 'insert', 'علیرضا', 'حقیقی', '0371964668', '09121519003', 30),
(8, '2020-01-31 15:57:43', 'insert', 'اصغر', 'اصغری', '0371964660', '09031823553', NULL),
(9, '2020-01-31 15:57:43', 'insert', 'اصغر', 'اصغری', '0371964660', '09031823553', NULL),
(10, '2020-01-31 15:57:43', 'insert', 'اصغر', 'اصغری', '0371964660', '09031823553', NULL),
(11, '2020-01-31 15:57:43', 'insert', 'اصغر', 'اصغری', '0371964660', '09031823553', NULL),
(12, '2020-01-31 15:59:50', 'insert', 'اصغر', 'اصغری', '0371964660', '09031823553', 20),
(13, '2020-01-31 16:00:15', 'delete', 'اصغر', 'اصغری', '0371964660', '09031823553', NULL),
(14, '2020-01-31 16:00:33', 'delete', 'اصغر', 'اصغری', '0371964660', '09031823553', NULL),
(15, '2020-01-31 16:00:35', 'delete', 'اصغر', 'اصغری', '0371964660', '09031823553', NULL),
(16, '2020-01-31 16:00:37', 'delete', 'اصغر', 'اصغری', '0371964660', '09031823553', NULL),
(17, '2020-01-31 16:02:29', 'insert', 'محمد', 'محمدی', '0371964660', '09031823553', NULL),
(18, '2020-01-31 16:02:56', 'delete', 'محمد', 'محمدی', '0371964660', '09031823553', NULL),
(19, '2020-01-31 16:16:41', 'update', 'علی محمد', 'حقیقی', '0371964668', '09121519003', 30),
(20, '2020-01-31 16:17:52', 'update', '', 'حقیقی', '0371964668', '09121519003', 30),
(21, '2020-01-31 16:20:58', 'update', 'علیرضا', 'حقیقی', '0371964668', '09121519003', 30),
(22, '2020-01-31 16:21:08', 'update', '', 'حقیقی', '0371964668', '09121519003', 30),
(23, '2020-01-31 16:21:29', 'update', '', 'حقیقی', '0371964668', '09121519003', 30),
(24, '2020-01-31 16:23:39', 'update', 'علیرضا', 'حقیقی', '0371964668', '09121519003', 30);

-- --------------------------------------------------------

--
-- Table structure for table `food`
--

CREATE TABLE `food` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8_persian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci;

--
-- Dumping data for table `food`
--

INSERT INTO `food` (`id`, `name`) VALUES
(2, 'پیتزا مخصوص'),
(4, 'چلو خورشت قیمه'),
(5, 'پیتزا سبزیجات'),
(6, 'همبرگر'),
(7, 'نوشابه کوکا قوطی'),
(8, 'نوشابه فانتا خانواده');

-- --------------------------------------------------------

--
-- Table structure for table `food_data_history`
--

CREATE TABLE `food_data_history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `food_name` varchar(50) COLLATE utf8_persian_ci NOT NULL,
  `price` decimal(10,0) NOT NULL DEFAULT 0,
  `updated` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci;

--
-- Dumping data for table `food_data_history`
--

INSERT INTO `food_data_history` (`id`, `food_name`, `price`, `updated`) VALUES
(1, 'پیتزا مخصوص', '40000', '2020-01-24 19:08:20'),
(2, 'پیتزا مخصوص هادی', '45000', '2020-01-24 19:09:15'),
(3, 'پیتزا مخصوص هادی', '2', '2020-01-24 19:34:02'),
(4, 'پیتزا مخصوص هادی', '45500', '2020-01-24 19:35:30'),
(5, 'چلو کباب لقمه', '27500', '2020-01-24 19:51:19'),
(6, 'پیتزا مخصوص', '45000', '2020-01-25 01:46:45'),
(7, 'چلو خورشت قیمه', '12500', '2020-01-31 17:52:23'),
(8, 'پیتزا سبزیجات', '30000', '2020-01-31 18:14:20'),
(9, 'همبرگر', '23500', '2020-01-31 18:14:51'),
(10, 'همبرگر', '25000', '2020-01-31 18:23:41'),
(11, 'نوشابه کوکا قوطی', '2500', '2020-01-31 18:24:11'),
(12, 'نوشابه فانتا خانواده', '5000', '2020-01-31 18:27:01');

-- --------------------------------------------------------

--
-- Table structure for table `material`
--

CREATE TABLE `material` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8_persian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci;

--
-- Dumping data for table `material`
--

INSERT INTO `material` (`id`, `name`) VALUES
(5, 'کالباس خشک'),
(6, 'نوشابه خانواده بسته ای');

-- --------------------------------------------------------

--
-- Table structure for table `material_data_history`
--

CREATE TABLE `material_data_history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `material_name` varchar(50) COLLATE utf8_persian_ci NOT NULL,
  `price` decimal(10,0) NOT NULL DEFAULT 0,
  `updated` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci;

--
-- Dumping data for table `material_data_history`
--

INSERT INTO `material_data_history` (`id`, `material_name`, `price`, `updated`) VALUES
(1, 'کالباس', '10000', '2020-01-31 23:11:18'),
(2, 'کالباس', '10000', '2020-01-31 23:11:49'),
(3, 'کالباس خشک', '15500', '2020-01-31 23:16:34'),
(4, 'نوشابه خانواده بسته ای', '50000', '2020-01-31 23:16:57'),
(5, 'نوشابه خانواده بسته ای', '45500', '2020-01-31 23:17:08');

-- --------------------------------------------------------

--
-- Table structure for table `restaurant_order`
--

CREATE TABLE `restaurant_order` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `address_id` bigint(20) UNSIGNED DEFAULT NULL,
  `issue_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci;

--
-- Dumping data for table `restaurant_order`
--

INSERT INTO `restaurant_order` (`id`, `customer_id`, `address_id`, `issue_date`) VALUES
(7, 5, 10, '2020-01-24 22:47:52'),
(8, NULL, 11, '2020-01-24 23:00:57'),
(14, NULL, NULL, '2020-01-31 17:10:17'),
(15, 4, NULL, '2020-01-31 17:10:57'),
(18, 4, NULL, '2020-01-31 22:27:40'),
(19, 4, NULL, '2020-01-31 22:27:55'),
(20, 5, NULL, '2020-01-31 22:37:13');

-- --------------------------------------------------------

--
-- Table structure for table `restaurant_order_foods`
--

CREATE TABLE `restaurant_order_foods` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `food_data_id` bigint(20) UNSIGNED NOT NULL,
  `amount` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci;

--
-- Dumping data for table `restaurant_order_foods`
--

INSERT INTO `restaurant_order_foods` (`id`, `order_id`, `food_data_id`, `amount`) VALUES
(7, 7, 2, 2),
(8, 8, 2, 2),
(9, 14, 6, 2),
(10, 14, 12, 1),
(11, 15, 10, 3),
(12, 15, 11, 2),
(18, 18, 6, 10),
(19, 18, 7, 2),
(20, 18, 10, 3),
(21, 18, 11, 5),
(22, 19, 6, 1),
(23, 19, 7, 3),
(24, 19, 8, 6),
(25, 19, 10, 1),
(26, 19, 11, 1),
(27, 19, 12, 1),
(28, 20, 6, 3),
(29, 20, 7, 12),
(30, 20, 8, 3),
(31, 20, 11, 7);

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(50) COLLATE utf8_persian_ci NOT NULL,
  `is_available` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`id`, `title`, `is_available`) VALUES
(11, 'hi', 1),
(12, 'شرکت کاله', 1),
(13, 'شرکت کالباس رسان تبریز', 0);

--
-- Triggers `supplier`
--
DELIMITER $$
CREATE TRIGGER `supplier_delete_logger` AFTER DELETE ON `supplier` FOR EACH ROW INSERT INTO supplier_log(operation,supplier_title,supplier_is_available) VALUES ("delete",old.title,old.is_available)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `supplier_insert_logger` AFTER INSERT ON `supplier` FOR EACH ROW INSERT INTO supplier_log(operation,supplier_title,supplier_is_available) VALUES ("insert",NEW.title,NEW.is_available)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `supplier_update_logger` AFTER UPDATE ON `supplier` FOR EACH ROW INSERT INTO supplier_log(operation,supplier_title,supplier_is_available) VALUES ("update",NEW.title,NEW.is_available)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `supplier_log`
--

CREATE TABLE `supplier_log` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `operation` varchar(10) COLLATE utf8_persian_ci DEFAULT NULL,
  `supplier_title` varchar(50) COLLATE utf8_persian_ci DEFAULT NULL,
  `supplier_is_available` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci;

--
-- Dumping data for table `supplier_log`
--

INSERT INTO `supplier_log` (`id`, `date`, `operation`, `supplier_title`, `supplier_is_available`) VALUES
(1, '2020-02-01 00:11:09', 'insert', 'hi', 1),
(2, '2020-02-01 00:16:49', 'update', 'hi', 0),
(3, '2020-02-01 00:16:58', 'update', 'hi', 1),
(4, '2020-02-01 00:18:38', 'insert', 'شرکت کاله', 1),
(5, '2020-02-01 00:32:07', 'insert', 'شرکت کالباس رسان تبریز', 1),
(6, '2020-02-01 01:00:36', 'update', 'شرکت کالباس رسان تبریز', 0);

-- --------------------------------------------------------

--
-- Table structure for table `supplier_order`
--

CREATE TABLE `supplier_order` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `supplier_id` bigint(20) UNSIGNED NOT NULL,
  `issue_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci;

--
-- Dumping data for table `supplier_order`
--

INSERT INTO `supplier_order` (`id`, `supplier_id`, `issue_date`) VALUES
(2, 13, '2020-02-01 00:50:33');

-- --------------------------------------------------------

--
-- Table structure for table `supplier_order_items`
--

CREATE TABLE `supplier_order_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `supplier_order_id` bigint(20) UNSIGNED NOT NULL,
  `material_data_id` bigint(20) UNSIGNED NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci;

--
-- Dumping data for table `supplier_order_items`
--

INSERT INTO `supplier_order_items` (`id`, `supplier_order_id`, `material_data_id`, `amount`) VALUES
(2, 2, 3, 10),
(3, 2, 5, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `address_log`
--
ALTER TABLE `address_log`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `courier`
--
ALTER TABLE `courier`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `courier_log`
--
ALTER TABLE `courier_log`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `courier_on_order`
--
ALTER TABLE `courier_on_order`
  ADD PRIMARY KEY (`courier_id`,`order_id`,`status`) USING BTREE,
  ADD KEY `courier_id` (`courier_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `status` (`status`),
  ADD KEY `order_id_2` (`order_id`) USING BTREE,
  ADD KEY `courier_id_2` (`courier_id`) USING BTREE;

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `customer_address`
--
ALTER TABLE `customer_address`
  ADD PRIMARY KEY (`customer_id`,`address_id`),
  ADD KEY `customer_id` (`customer_id`) USING BTREE,
  ADD KEY `address_id` (`address_id`) USING BTREE;

--
-- Indexes for table `customer_log`
--
ALTER TABLE `customer_log`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `food`
--
ALTER TABLE `food`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `food_data_history`
--
ALTER TABLE `food_data_history`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `food_id` (`food_name`);

--
-- Indexes for table `material`
--
ALTER TABLE `material`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `material_data_history`
--
ALTER TABLE `material_data_history`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `material_id` (`material_name`);

--
-- Indexes for table `restaurant_order`
--
ALTER TABLE `restaurant_order`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `address_id` (`address_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `restaurant_order_foods`
--
ALTER TABLE `restaurant_order_foods`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `food_id` (`food_data_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `supplier_log`
--
ALTER TABLE `supplier_log`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `supplier_order`
--
ALTER TABLE `supplier_order`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `supplier_id_fk` (`supplier_id`);

--
-- Indexes for table `supplier_order_items`
--
ALTER TABLE `supplier_order_items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `material_data_id` (`material_data_id`),
  ADD KEY `supplier_order_items_ibfk_1` (`supplier_order_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `address_log`
--
ALTER TABLE `address_log`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `courier`
--
ALTER TABLE `courier`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `courier_log`
--
ALTER TABLE `courier_log`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `customer_log`
--
ALTER TABLE `customer_log`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `food`
--
ALTER TABLE `food`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `food_data_history`
--
ALTER TABLE `food_data_history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `material`
--
ALTER TABLE `material`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `material_data_history`
--
ALTER TABLE `material_data_history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `restaurant_order`
--
ALTER TABLE `restaurant_order`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `restaurant_order_foods`
--
ALTER TABLE `restaurant_order_foods`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `supplier_log`
--
ALTER TABLE `supplier_log`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `supplier_order`
--
ALTER TABLE `supplier_order`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `supplier_order_items`
--
ALTER TABLE `supplier_order_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `courier_on_order`
--
ALTER TABLE `courier_on_order`
  ADD CONSTRAINT `courier_on_order_ibfk_1` FOREIGN KEY (`courier_id`) REFERENCES `courier` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `courier_on_order_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `restaurant_order` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `customer_address`
--
ALTER TABLE `customer_address`
  ADD CONSTRAINT `address_id_fk` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `customer_id_fk` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `restaurant_order`
--
ALTER TABLE `restaurant_order`
  ADD CONSTRAINT `restaurant_order_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`),
  ADD CONSTRAINT `restaurant_order_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`);

--
-- Constraints for table `restaurant_order_foods`
--
ALTER TABLE `restaurant_order_foods`
  ADD CONSTRAINT `restaurant_order_foods_ibfk_1` FOREIGN KEY (`food_data_id`) REFERENCES `food_data_history` (`id`),
  ADD CONSTRAINT `restaurant_order_foods_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `restaurant_order` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `supplier_order`
--
ALTER TABLE `supplier_order`
  ADD CONSTRAINT `supplier_id_fk` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`);

--
-- Constraints for table `supplier_order_items`
--
ALTER TABLE `supplier_order_items`
  ADD CONSTRAINT `supplier_order_items_ibfk_1` FOREIGN KEY (`supplier_order_id`) REFERENCES `supplier_order` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `supplier_order_items_ibfk_2` FOREIGN KEY (`material_data_id`) REFERENCES `material_data_history` (`id`);

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `delete_3month_old_logs` ON SCHEDULE EVERY 1 DAY STARTS '2020-01-24 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
DELETE FROM address_log WHERE date < NOW() - INTERVAL 3 MONTH;
DELETE FROM courier_log WHERE date < NOW() - INTERVAL 3 MONTH;
DELETE FROM customer_log WHERE date < NOW() - INTERVAL 3 MONTH;
DELETE FROM supplier_log WHERE date < NOW() - INTERVAL 3 MONTH; END$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
