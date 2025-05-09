-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 29, 2025 at 07:24 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `attendancemsystem`
--
CREATE DATABASE IF NOT EXISTS attendancemsystem;

USE `attendancemsystem`;
-- --------------------------------------------------------

--
-- Table structure for table `tbladmin`
--

DROP TABLE IF EXISTS `tbladmin`;

CREATE TABLE `tbladmin` (
  `Id` int(10) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `emailAddress` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbladmin`
--

INSERT INTO `tbladmin` (`Id`, `firstName`, `lastName`, `emailAddress`, `password`) VALUES
(1, 'Admin', '', 'admin@mail.com', 'D00F5D5217896FB7FD601412CB890830');

-- --------------------------------------------------------

--
-- Table structure for table `tblattendance`
--

DROP TABLE IF EXISTS `tblattendance`;

CREATE TABLE `tblattendance` (
  `Id` int(10) NOT NULL AUTO_INCREMENT,
  `admissionNo` varchar(255) NOT NULL,
  `classId` varchar(10) NOT NULL,
  `classArmId` varchar(10) NOT NULL,
  `sessionTermId` varchar(10) NOT NULL,
  `status` varchar(10) NOT NULL,
  `dateTimeTaken` varchar(20) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblattendance`
--

INSERT INTO `tblattendance` (`Id`, `admissionNo`, `classId`, `classArmId`, `sessionTermId`, `status`, `dateTimeTaken`) VALUES
(162, 'ASDFLKJ', '1', '2', '1', '1', '2020-11-01'),
(163, 'HSKSDD', '1', '2', '1', '1', '2020-11-01');

-- --------------------------------------------------------

--
-- Table structure for table `tblclass`
--

DROP TABLE IF EXISTS `tblclass`;

CREATE TABLE `tblclass` (
  `Id` int(10) NOT NULL AUTO_INCREMENT,
  `className` varchar(255) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblclass`
--

INSERT INTO `tblclass` (`Id`, `className`) VALUES
(1, 'CSE-3A'),
(3, 'CSE-3B');

-- --------------------------------------------------------

--
-- Table structure for table `tblclassarms`
--

DROP TABLE IF EXISTS `tblclassarms`;

CREATE TABLE `tblclassarms` (
  `Id` int(10) NOT NULL AUTO_INCREMENT,
  `classId` varchar(10) NOT NULL,
  `classArmName` varchar(255) NOT NULL,
  `isAssigned` varchar(10) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblclassarms`
--

INSERT INTO `tblclassarms` (`Id`, `classId`, `classArmName`, `isAssigned`) VALUES
(2, '1', 'S1', '1'),
(4, '1', 'S2', '1');

-- --------------------------------------------------------

--
-- Table structure for table `tblclassteacher`
--

DROP TABLE IF EXISTS `tblclassteacher`;

CREATE TABLE `tblclassteacher` (
  `Id` int(10) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `emailAddress` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phoneNo` varchar(50) NOT NULL,
  `classId` varchar(10) NOT NULL,
  `classArmId` varchar(10) NOT NULL,
  `dateCreated` varchar(50) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblclassteacher`
--

INSERT INTO `tblclassteacher` (`Id`, `firstName`, `lastName`, `emailAddress`, `password`, `phoneNo`, `classId`, `classArmId`, `dateCreated`) VALUES
(1, 'Rakesh', 'Kumar', 'teacher2@mail.com', '32250170a0dca92d53ec9624f336ca24', '09089898999', '1', '2', '2022-10-31');

-- --------------------------------------------------------

--
-- Table structure for table `tblsessionterm`
--

DROP TABLE IF EXISTS `tblsessionterm`;

CREATE TABLE `tblsessionterm` (
  `Id` int(10) NOT NULL AUTO_INCREMENT,
  `sessionName` varchar(50) NOT NULL,
  `termId` varchar(50) NOT NULL,
  `isActive` varchar(10) NOT NULL,
  `dateCreated` varchar(50) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblsessionterm`
--

INSERT INTO `tblsessionterm` (`Id`, `sessionName`, `termId`, `isActive`, `dateCreated`) VALUES
(1, '2021/2022', '1', '1', '2022-10-31');

-- --------------------------------------------------------

--
-- Table structure for table `tblstudents`
--

DROP TABLE IF EXISTS `tblstudents`;

CREATE TABLE `tblstudents` (
  `Id` int(10) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `otherName` varchar(255) NOT NULL,
  `admissionNumber` varchar(255) NOT NULL,
  `password` varchar(50) NOT NULL,
  `classId` varchar(10) NOT NULL,
  `classArmId` varchar(10) NOT NULL,
  `dateCreated` varchar(50) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblstudents`
--

INSERT INTO `tblstudents` (`Id`, `firstName`, `lastName`, `otherName`, `admissionNumber`, `password`, `classId`, `classArmId`, `dateCreated`) VALUES
(1, 'Aastha', 'Anand', 'none', 'AMS005', '12345', '1', '2', '2022-10-31');

-- --------------------------------------------------------

--
-- Table structure for table `tblterm`
--

DROP TABLE IF EXISTS `tblterm`;

CREATE TABLE `tblterm` (
  `Id` int(10) NOT NULL AUTO_INCREMENT,
  `termName` varchar(20) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblterm`
--

INSERT INTO `tblterm` (`Id`, `termName`) VALUES
(1, 'First'),
(2, 'Second');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbladmin`
--
-- ALTER TABLE `tbladmin`
--   ADD PRIMARY KEY (`Id`);

-- --
-- -- Indexes for table `tblattendance`
-- --
-- ALTER TABLE `tblattendance`
--   ADD PRIMARY KEY (`Id`);

-- --
-- -- Indexes for table `tblclass`
-- --
-- ALTER TABLE `tblclass`
--   ADD PRIMARY KEY (`Id`);

-- --
-- -- Indexes for table `tblclassarms`
-- --
-- ALTER TABLE `tblclassarms`
--   ADD PRIMARY KEY (`Id`);

-- --
-- -- Indexes for table `tblclassteacher`
-- --
-- ALTER TABLE `tblclassteacher`
--   ADD PRIMARY KEY (`Id`);

-- --
-- -- Indexes for table `tblsessionterm`
-- --
-- ALTER TABLE `tblsessionterm`
--   ADD PRIMARY KEY (`Id`);

-- --
-- -- Indexes for table `tblstudents`
-- --
-- ALTER TABLE `tblstudents`
--   ADD PRIMARY KEY (`Id`);

-- --
-- -- Indexes for table `tblterm`
-- --
-- ALTER TABLE `tblterm`
--   ADD PRIMARY KEY (`Id`);

-- --
-- -- AUTO_INCREMENT for dumped tables
-- --

-- --
-- -- AUTO_INCREMENT for table `tbladmin`
-- --
-- ALTER TABLE `tbladmin`
--   MODIFY `Id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

-- --
-- -- AUTO_INCREMENT for table `tblattendance`
-- --
-- ALTER TABLE `tblattendance`
--   MODIFY `Id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=204;

-- --
-- -- AUTO_INCREMENT for table `tblclass`
-- --
-- ALTER TABLE `tblclass`
--   MODIFY `Id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

-- --
-- -- AUTO_INCREMENT for table `tblclassarms`
-- --
-- ALTER TABLE `tblclassarms`
--   MODIFY `Id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

-- --
-- -- AUTO_INCREMENT for table `tblclassteacher`
-- --
-- ALTER TABLE `tblclassteacher`
--   MODIFY `Id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

-- --
-- -- AUTO_INCREMENT for table `tblsessionterm`
-- --
-- ALTER TABLE `tblsessionterm`
--   MODIFY `Id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

-- --
-- -- AUTO_INCREMENT for table `tblstudents`
-- --
-- ALTER TABLE `tblstudents`
--   MODIFY `Id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

-- --
-- -- AUTO_INCREMENT for table `tblterm`
-- --
-- ALTER TABLE `tblterm`
--   MODIFY `Id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
-- COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
