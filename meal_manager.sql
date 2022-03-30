-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 30, 2022 at 06:11 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `meal_manager`
--

-- --------------------------------------------------------

--
-- Table structure for table `deposite`
--

CREATE TABLE `deposite` (
  `id` int(150) NOT NULL,
  `name` text NOT NULL,
  `amount` int(150) NOT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` int(150) NOT NULL,
  `amount` int(150) DEFAULT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Stand-in structure for view `expenses_his`
-- (See below for the actual view)
--
CREATE TABLE `expenses_his` (
`amount` decimal(65,0)
,`date` date
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `final_report`
-- (See below for the actual view)
--
CREATE TABLE `final_report` (
`name` text
,`td_amount` decimal(65,0)
,`total_meal` decimal(65,0)
,`meal_rate` decimal(65,4)
,`total_tk` decimal(65,4)
,`r_or_p` decimal(65,4)
);

-- --------------------------------------------------------

--
-- Table structure for table `manage_meal`
--

CREATE TABLE `manage_meal` (
  `id` int(150) NOT NULL,
  `name` text DEFAULT NULL,
  `no_meal` int(150) DEFAULT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Stand-in structure for view `meal_dash`
-- (See below for the actual view)
--
CREATE TABLE `meal_dash` (
`total_d` decimal(65,0)
,`total_e` decimal(65,0)
,`total_m` decimal(65,0)
,`meal_rate` decimal(65,4)
);

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `id` int(100) NOT NULL,
  `name` text NOT NULL,
  `contact` char(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`id`, `name`, `contact`) VALUES
(1, 'Manik', '1814430772'),
(2, 'Taposh', '1857719143'),
(3, 'Nishan', '1867568689'),
(5, 'Ahsan', '1811111111'),
(6, 'Emon', '1766666666'),
(7, 'Aryan', '1699999999'),
(8, 'Ohab', '14444444');

-- --------------------------------------------------------

--
-- Stand-in structure for view `member_tdep`
-- (See below for the actual view)
--
CREATE TABLE `member_tdep` (
`name` text
,`td_amount` decimal(65,0)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `member_tmeal`
-- (See below for the actual view)
--
CREATE TABLE `member_tmeal` (
`name` text
,`total_meal` decimal(65,0)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `mem_meal`
-- (See below for the actual view)
--
CREATE TABLE `mem_meal` (
`name` text
,`total_meal` decimal(65,0)
,`meal_rate` decimal(65,4)
,`total_tk` decimal(65,4)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `total_dep`
-- (See below for the actual view)
--
CREATE TABLE `total_dep` (
`total` decimal(65,0)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `total_expen`
-- (See below for the actual view)
--
CREATE TABLE `total_expen` (
`total` decimal(65,0)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `total_meal`
-- (See below for the actual view)
--
CREATE TABLE `total_meal` (
`total` decimal(65,0)
);

-- --------------------------------------------------------

--
-- Structure for view `expenses_his`
--
DROP TABLE IF EXISTS `expenses_his`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `expenses_his`  AS SELECT sum(`expenses`.`amount`) AS `amount`, `expenses`.`date` AS `date` FROM `expenses` GROUP BY `expenses`.`date` ;

-- --------------------------------------------------------

--
-- Structure for view `final_report`
--
DROP TABLE IF EXISTS `final_report`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `final_report`  AS   (select `member_tdep`.`name` AS `name`,`member_tdep`.`td_amount` AS `td_amount`,`mem_meal`.`total_meal` AS `total_meal`,`mem_meal`.`meal_rate` AS `meal_rate`,`mem_meal`.`total_tk` AS `total_tk`,`member_tdep`.`td_amount` - `mem_meal`.`total_tk` AS `r_or_p` from (`member_tdep` join `mem_meal` on(`member_tdep`.`name` = `mem_meal`.`name`)))  ;

-- --------------------------------------------------------

--
-- Structure for view `meal_dash`
--
DROP TABLE IF EXISTS `meal_dash`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `meal_dash`  AS   (select `total_dep`.`total` AS `total_d`,`total_expen`.`total` AS `total_e`,`total_meal`.`total` AS `total_m`,`total_expen`.`total` / `total_meal`.`total` AS `meal_rate` from ((`total_dep` join `total_expen`) join `total_meal`))  ;

-- --------------------------------------------------------

--
-- Structure for view `member_tdep`
--
DROP TABLE IF EXISTS `member_tdep`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `member_tdep`  AS   (select `deposite`.`name` AS `name`,sum(`deposite`.`amount`) AS `td_amount` from `deposite` group by `deposite`.`name`)  ;

-- --------------------------------------------------------

--
-- Structure for view `member_tmeal`
--
DROP TABLE IF EXISTS `member_tmeal`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `member_tmeal`  AS   (select `manage_meal`.`name` AS `name`,sum(`manage_meal`.`no_meal`) AS `total_meal` from `manage_meal` group by `manage_meal`.`name`)  ;

-- --------------------------------------------------------

--
-- Structure for view `mem_meal`
--
DROP TABLE IF EXISTS `mem_meal`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mem_meal`  AS   (select `member_tmeal`.`name` AS `name`,`member_tmeal`.`total_meal` AS `total_meal`,`meal_dash`.`meal_rate` AS `meal_rate`,`member_tmeal`.`total_meal` * `meal_dash`.`meal_rate` AS `total_tk` from ((`member_tmeal` join `member_tdep`) join `meal_dash`) group by `member_tmeal`.`name`)  ;

-- --------------------------------------------------------

--
-- Structure for view `total_dep`
--
DROP TABLE IF EXISTS `total_dep`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `total_dep`  AS SELECT sum(`deposite`.`amount`) AS `total` FROM `deposite` ;

-- --------------------------------------------------------

--
-- Structure for view `total_expen`
--
DROP TABLE IF EXISTS `total_expen`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `total_expen`  AS   (select sum(`expenses_his`.`amount`) AS `total` from `expenses_his`)  ;

-- --------------------------------------------------------

--
-- Structure for view `total_meal`
--
DROP TABLE IF EXISTS `total_meal`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `total_meal`  AS   (select sum(`manage_meal`.`no_meal`) AS `total` from `manage_meal`)  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `deposite`
--
ALTER TABLE `deposite`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `manage_meal`
--
ALTER TABLE `manage_meal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `deposite`
--
ALTER TABLE `deposite`
  MODIFY `id` int(150) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` int(150) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `manage_meal`
--
ALTER TABLE `manage_meal`
  MODIFY `id` int(150) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `member`
--
ALTER TABLE `member`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
