-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 23, 2023 at 09:08 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smarthonkingzone`
--

-- --------------------------------------------------------

--
-- Table structure for table `corporation`
--

CREATE TABLE `corporation` (
  `id` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `location` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mob` varchar(100) NOT NULL,
  `pass` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `corporation`
--

INSERT INTO `corporation` (`id`, `name`, `location`, `email`, `mob`, `pass`) VALUES
(1, 'Nashik Municipal Corporation', 'Nashik', 'nmc@gmail.com', '8600180045', '123456');

-- --------------------------------------------------------

--
-- Table structure for table `honkarea`
--

CREATE TABLE `honkarea` (
  `id` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mob` varchar(100) NOT NULL,
  `pass` varchar(100) NOT NULL,
  `areause` varchar(100) NOT NULL,
  `type` varchar(100) NOT NULL,
  `corporation` varchar(256) NOT NULL,
  `lat` varchar(256) NOT NULL,
  `lng` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `honkarea`
--

INSERT INTO `honkarea` (`id`, `name`, `city`, `email`, `mob`, `pass`, `areause`, `type`, `corporation`, `lat`, `lng`) VALUES
(1, 'KBT Circle', 'Nashik', 'gangapur@gmail.com', '9898989695', '0', 'Hospital', '0', '1', '20.00985396236794', '73.76461088769238'),
(2, 'Thakkar Bazzar', 'Nashik', 'cbs@gmail.com', '8678785858', '0', 'Goverment offices', '0', '1', '19.997150498687876', '73.78091269177057');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `corporation`
--
ALTER TABLE `corporation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `honkarea`
--
ALTER TABLE `honkarea`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `corporation`
--
ALTER TABLE `corporation`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `honkarea`
--
ALTER TABLE `honkarea`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
