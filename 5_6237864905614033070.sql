-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 18, 2019 at 08:24 AM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `senpai-api`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `admin_id` int(11) NOT NULL,
  `level` enum('Embassy','Content Creator','Super Admin') NOT NULL,
  `username` varchar(32) NOT NULL,
  `fullname` varchar(64) NOT NULL,
  `email` varchar(64) NOT NULL,
  `phone` varchar(16) NOT NULL,
  `content_type` tinytext NOT NULL,
  `nationality` varchar(4) NOT NULL,
  `description` text NOT NULL,
  `profile_picture` varchar(64) NOT NULL,
  `header_picture` varchar(64) NOT NULL,
  `password` varchar(256) NOT NULL,
  `remember_me` int(11) NOT NULL DEFAULT 0,
  `session_token` tinytext NOT NULL,
  `token` varchar(4) NOT NULL,
  `flag` enum('-1','0','1','2') NOT NULL DEFAULT '0' COMMENT '-1 = blocked, 0 = inactive, 1 = active/unverified, 2 = verified',
  `iat` datetime NOT NULL DEFAULT current_timestamp(),
  `uat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`admin_id`, `level`, `username`, `fullname`, `email`, `phone`, `content_type`, `nationality`, `description`, `profile_picture`, `header_picture`, `password`, `remember_me`, `session_token`, `token`, `flag`, `iat`, `uat`) VALUES
(123456, 'Super Admin', 'ito', 'Ito Rijal', 'ophyeq@gmail.com', '', '', '', '', '', '', '$2y$10$5njYR1SG4gBLUaV7hhkgYO.OW1PDjgnVGHpVVXR0JOCQXexVUUbYW', 0, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJsYXN0IjoiMjAxOS0xMS0xNCAwMDo1NToxMiIsImlkIjoiMTIzNDU2IiwidXNlcm5hbWUiOiJpdG8ifQ.ORre5XG_y2F_5sdCGIdjhxAxSDupiYtm-YpY1so2G-k', '0', '2', '2017-12-05 15:46:57', '2019-11-14 15:25:56'),
(180123, 'Embassy', 'Nichole_Macejkovic35', 'Savings Account', 'Vincent.Rippin56@example.org', '', 'Embassy', 'GI', '', '', '', '$2y$10$iW7p.Rj26NCN4gowpRSg5.3tpAYyVhBemDNM/mIrsru5MbNDvQ6vC', 0, '', '', '1', '2019-11-14 22:42:05', '2019-11-14 15:02:13'),
(234567, 'Embassy', 'indoemb', 'Indonesian Embassy', 'indo@senpai.id', '', 'Embassy', 'ID', '', '', '', '$2y$10$5njYR1SG4gBLUaV7hhkgYO.OW1PDjgnVGHpVVXR0JOCQXexVUUbYW', 0, 'itc2rvjemuq6snir44atve06jman2rdv', '0', '2', '2017-12-05 15:46:57', '2019-11-14 15:02:20'),
(532681, 'Content Creator', 'Amie.Jaskolski', 'Viaduct', 'Celia11@example.com', '', 'Featured Article, Emergency Alert', '', '', '4505415d6741b59816dc449d2ba2f4d9.png', '', '$2y$10$pApEnOlPm0McuC1VKFOAnuS9axg4DALcL23/psCvuI0/fB2xkbtf.', 0, '', '', '-1', '2019-11-14 23:18:55', '2019-11-14 15:20:21'),
(685645, 'Content Creator', 'cocre', 'Creator Kece', 'cocre@senpai.id', '', '', '', 'In perferendis tenetur ab vero occaecati veniam. Est reiciendis deserunt qui. Fugit dicta magnam ad voluptates illo cupiditate eos. Sequi quae nobis rerum voluptate. Tenetur aut autem dolores quam mollitia aliquid officia dolor cupiditate.', '045b6d370b9b0d0e615632f9cb9f4bf1.png', '7d3f375a6ec4cda4669d2ea4a450b4fc.png', '$2y$10$p.iOqxSSi5Kq9/ALVcRuSeWmCrH.vIhodkRVL7k9Y6FKQtwOBkKRS', 0, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJsYXN0IjoiMjAxOS0xMS0xNCAwNTo1MjoyNiIsImlkIjoiNjg1NjQ1IiwidXNlcm5hbWUiOiJjb25jcmUifQ.gtnoVQhqSEib6WiR090Lnpk5pWrX6FXH4OeSbGauYxw', '0', '2', '2017-12-05 15:46:57', '2019-11-14 15:25:47'),
(974102, 'Embassy', 'Amari3', 'Ergonomic', 'indo2@senpai.id', '', 'Embassy', 'JP', '', '', '', '$2y$10$WWKgn5cgkuO0w6jvQwGReeJ7CU/YJmdipzjHVmmr0lPErgOIS5086', 0, '', '', '1', '2019-11-14 22:35:23', '2019-11-14 15:02:17');

-- --------------------------------------------------------

--
-- Table structure for table `advice_answers`
--

CREATE TABLE `advice_answers` (
  `answer_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `answer` text NOT NULL,
  `votes` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 = open; 1 = solved;',
  `iat` datetime NOT NULL DEFAULT current_timestamp(),
  `uat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `advice_answers`
--

INSERT INTO `advice_answers` (`answer_id`, `question_id`, `user_id`, `answer`, `votes`, `status`, `iat`, `uat`) VALUES
(38745837, 50946721, 29384756, 'Yes it is.', 2, 1, '2019-11-04 08:29:55', '2019-11-13 10:09:07'),
(62764530, 19570281, 10293847, 'I\'m here.', 4, 1, '2019-11-13 18:01:57', '2019-11-14 15:56:53'),
(72475938, 87312968, 10293847, 'can I answer my own question?', 1, 0, '2019-11-13 18:04:57', '2019-11-14 15:56:49');

-- --------------------------------------------------------

--
-- Table structure for table `advice_questions`
--

CREATE TABLE `advice_questions` (
  `question_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` tinytext NOT NULL,
  `question` text NOT NULL,
  `weekly` int(11) NOT NULL,
  `votes` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 = open; 1 = solved;',
  `iat` datetime NOT NULL DEFAULT current_timestamp(),
  `uat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `advice_questions`
--

INSERT INTO `advice_questions` (`question_id`, `topic_id`, `user_id`, `title`, `question`, `weekly`, `votes`, `status`, `iat`, `uat`) VALUES
(19570281, 4, 29384756, 'Question 2', 'Where are you?', 1, 0, 1, '2019-10-25 19:41:33', '2019-11-13 10:24:20'),
(50946721, 3, 10293847, 'Question 1', 'What is this about?', 0, 0, 1, '2019-10-25 19:38:00', '2019-10-25 15:10:37'),
(87312968, 3, 10293847, 'Chips Money Market Account Industrial wireless', 'Accusamus et eveniet minima incidunt voluptatem qui. Non aut dolor itaque ad qui sed incidunt. Voluptatem ut hic.', 1, 0, 0, '2019-10-26 22:31:05', '2019-11-13 10:04:57');

-- --------------------------------------------------------

--
-- Table structure for table `advice_votes`
--

CREATE TABLE `advice_votes` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `answer_id` int(11) NOT NULL,
  `iat` datetime NOT NULL DEFAULT current_timestamp(),
  `uat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `advice_votes`
--

INSERT INTO `advice_votes` (`id`, `user_id`, `question_id`, `answer_id`, `iat`, `uat`) VALUES
(4, 29384756, 12435655, 38745837, '2019-11-07 14:46:22', '2019-11-07 06:46:39'),
(6, 10293847, 50946721, 38745837, '2019-11-13 18:09:07', '2019-11-13 10:09:07');

-- --------------------------------------------------------

--
-- Table structure for table `blocked_answers`
--

CREATE TABLE `blocked_answers` (
  `id` int(11) NOT NULL,
  `block_id` int(11) NOT NULL DEFAULT 0,
  `bat` datetime NOT NULL DEFAULT current_timestamp(),
  `answer_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `answer` text NOT NULL,
  `votes` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '0 = open; 1 = solved;',
  `iat` datetime NOT NULL,
  `uat` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `blocked_answers`
--

INSERT INTO `blocked_answers` (`id`, `block_id`, `bat`, `answer_id`, `question_id`, `user_id`, `answer`, `votes`, `status`, `iat`, `uat`) VALUES
(1, 3, '2019-11-14 10:24:34', 58921436, 98467102, 10293847, 'hmmm', 0, 0, '2019-11-13 19:10:16', '2019-11-13 19:10:16'),
(2, 3, '2019-11-14 10:24:34', 83596142, 98467102, 10293847, 'yes you are.', 0, 0, '2019-11-13 19:10:11', '2019-11-13 19:10:11'),
(3, 0, '2019-11-14 10:55:03', 75412398, 50946721, 10293847, 'Yuhuuuuu', 1, 0, '2019-10-25 22:29:16', '2019-11-13 18:09:45');

-- --------------------------------------------------------

--
-- Table structure for table `blocked_posts`
--

CREATE TABLE `blocked_posts` (
  `id` int(11) NOT NULL,
  `bat` datetime NOT NULL DEFAULT current_timestamp(),
  `post_id` int(11) NOT NULL,
  `post_type` enum('Post','Featured Article','Emergency Alert','Embassy','Daily Tips') NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` tinytext NOT NULL,
  `content` mediumtext NOT NULL,
  `picture` varchar(64) NOT NULL,
  `iat` datetime NOT NULL,
  `uat` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `blocked_posts`
--

INSERT INTO `blocked_posts` (`id`, `bat`, `post_id`, `post_type`, `user_id`, `title`, `content`, `picture`, `iat`, `uat`) VALUES
(1, '2019-11-14 09:16:33', 18729605, 'Featured Article', 685645, 'Savings Account Incredible Steel Table Groves', 'Et exercitationem consequatur nemo non quam rerum distinctio libero. Iusto dolorum nesciunt soluta quis. Possimus totam velit voluptatem corrupti corrupti consequuntur optio et harum. Reprehenderit dignissimos maiores magni nostrum. Delectus quidem eius eaque et sint delectus iste fugit.', 'e3ddbcee351a77cf79dbe3a08f22d41e.jpg', '2019-10-31 12:13:05', '2019-11-14 08:48:49');

-- --------------------------------------------------------

--
-- Table structure for table `blocked_questions`
--

CREATE TABLE `blocked_questions` (
  `id` int(11) NOT NULL,
  `bat` datetime NOT NULL DEFAULT current_timestamp(),
  `question_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` tinytext NOT NULL,
  `question` text NOT NULL,
  `weekly` int(11) NOT NULL,
  `votes` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '0 = open; 1 = solved;',
  `iat` datetime NOT NULL,
  `uat` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `blocked_questions`
--

INSERT INTO `blocked_questions` (`id`, `bat`, `question_id`, `topic_id`, `user_id`, `title`, `question`, `weekly`, `votes`, `status`, `iat`, `uat`) VALUES
(3, '2019-11-14 10:24:34', 98467102, 3, 29384756, 'Saepe iure quaerat officiis commodi culpa repudiandae.', 'Aut aut nihil quod et sint rem voluptas non aliquam. Maxime est porro vitae doloribus magnam. Alias cumque voluptatem non voluptates voluptate repellat eos nihil. Et placeat non velit eligendi nisi.', 2, 0, 0, '2019-10-26 22:30:01', '2019-11-13 19:10:16');

-- --------------------------------------------------------

--
-- Table structure for table `bookmarks`
--

CREATE TABLE `bookmarks` (
  `bookmark_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL DEFAULT 0,
  `question_id` int(11) NOT NULL DEFAULT 0,
  `iat` datetime NOT NULL DEFAULT current_timestamp(),
  `uat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bookmarks`
--

INSERT INTO `bookmarks` (`bookmark_id`, `user_id`, `post_id`, `question_id`, `iat`, `uat`) VALUES
(19016824, 10293847, 90572649, 0, '2019-11-18 15:53:15', '2019-11-18 07:53:15'),
(45390742, 10293847, 0, 19570281, '2019-11-18 15:52:57', '2019-11-18 07:52:57'),
(47653875, 29384756, 12234586, 0, '2019-11-01 13:47:18', '2019-11-01 05:47:18'),
(70213498, 10293847, 0, 50946721, '2019-10-30 15:59:58', '2019-10-30 07:59:58');

-- --------------------------------------------------------

--
-- Table structure for table `experiences`
--

CREATE TABLE `experiences` (
  `experience_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` tinytext NOT NULL,
  `company` tinytext NOT NULL,
  `sat` date NOT NULL,
  `eat` varchar(32) NOT NULL,
  `location` tinytext NOT NULL,
  `description` text NOT NULL,
  `iat` datetime NOT NULL DEFAULT current_timestamp(),
  `uat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `experiences`
--

INSERT INTO `experiences` (`experience_id`, `user_id`, `title`, `company`, `sat`, `eat`, `location`, `description`, `iat`, `uat`) VALUES
(16547920, 10293847, 'Investor Data Analyst', 'Cruickshank - McDermott', '2016-05-21', '', 'Mooremouth, Isle of Man', 'Aliquid magni sunt natus sapiente. Quam animi quia odio sed velit ipsum magnam distinctio. Eius id omnis et voluptatibus nihil harum recusandae. Sed distinctio nam. Cumque aliquam cumque voluptatum temporibus quas illo non non rem. Eius itaque dolorem nam quia qui facere aliquam assumenda temporibus.', '2019-10-28 11:24:07', '2019-10-28 03:24:07'),
(37629014, 10293847, 'Product Brand Strategist', 'Adams, Emmerich and Lehner', '2016-05-21', '', 'Lake Mitchel, Grenada', 'Mollitia neque facilis labore corrupti placeat. Recusandae illo provident repudiandae dolores beatae eos dolorum. Ut cum in. Ducimus at in eveniet sit et.', '2019-10-28 11:13:47', '2019-10-28 03:13:47'),
(50671439, 29384756, 'International Web Executive', 'Gleichner - Streich', '2016-05-21', '', 'Mitchellmouth, Rwanda', 'Aut voluptates illo possimus aut possimus aut consequatur. Soluta veniam qui omnis voluptatem. Omnis ipsam quae sint.', '2019-10-28 11:15:17', '2019-10-28 03:18:47'),
(53956801, 10293847, 'Lead Paradigm Director', 'Prosacco, Lehner and Schneider', '2016-05-21', '', 'South Chesterhaven, Antarctica (the territory South of 60 deg S)', 'Et provident est sequi rerum eum. Aut illo autem pariatur inventore voluptates tempore. Magnam repellat nulla exercitationem cumque est autem ut et. Vel dolorem incidunt eum doloribus eum iure laborum non. Exercitationem impedit quis veritatis porro atque. Maxime maiores in aut nobis.', '2019-10-28 11:16:07', '2019-10-28 03:16:07'),
(82518493, 29384756, 'Forward Creative Executive', 'O\'Kon, Gorczany and Kemmer', '2016-05-21', '', 'Port Kyleigh, Namibia', 'Saepe voluptas et eum omnis beatae optio voluptas ut magni. Quis et mollitia praesentium consequatur. In consequuntur minus. Necessitatibus voluptas sunt cum quia vel eos veniam. Quis quidem laudantium error. Architecto aut sint saepe quasi doloribus molestiae magnam modi illo.', '2019-10-28 11:12:52', '2019-10-28 03:19:34'),
(85754857, 10293847, 'International Division Manager', 'Prohaska LLC', '2016-05-21', '', 'New Sim, Maldives', 'Autem quia et ut eligendi. Eum a incidunt numquam vitae earum harum necessitatibus voluptatem dolor. Sint nobis nobis fugit quo est odio. Molestiae hic a fuga sunt explicabo dolores iure.', '2019-10-25 09:54:19', '2019-10-28 03:22:06');

-- --------------------------------------------------------

--
-- Table structure for table `follower`
--

CREATE TABLE `follower` (
  `user_id` int(11) NOT NULL,
  `follower_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 = unread; 1 = read;',
  `iat` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `follower`
--

INSERT INTO `follower` (`user_id`, `follower_id`, `status`, `iat`) VALUES
(10293847, 29384756, 0, '2019-10-17 13:12:45'),
(10293847, 38475647, 0, '2019-10-17 13:12:45'),
(29384756, 10293847, 0, '2019-10-17 13:12:45'),
(38745837, 10293847, 0, '2019-10-26 13:11:27');

-- --------------------------------------------------------

--
-- Table structure for table `md_countries`
--

CREATE TABLE `md_countries` (
  `id` int(11) NOT NULL,
  `code` varchar(2) NOT NULL DEFAULT '',
  `country` varchar(64) NOT NULL DEFAULT '',
  `country_group` varchar(20) NOT NULL,
  `continent` varchar(20) NOT NULL,
  `people` varchar(32) NOT NULL,
  `language` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `md_countries`
--

INSERT INTO `md_countries` (`id`, `code`, `country`, `country_group`, `continent`, `people`, `language`) VALUES
(1, 'AF', 'Afghanistan', '', 'South Asia', '', ''),
(2, 'AL', 'Albania', '', 'Southeastern Europe', '', ''),
(3, 'DZ', 'Algeria', 'African Union', 'North Africa', '', ''),
(4, 'DS', 'American Samoa', '', '', '', ''),
(5, 'AD', 'Andorra', '', 'Southern Europe', '', ''),
(6, 'AO', 'Angola', 'African Union', 'Central Africa', '', ''),
(7, 'AI', 'Anguilla', '', '', '', ''),
(8, 'AQ', 'Antarctica', '', '', '', ''),
(9, 'AG', 'Antigua and Barbuda', '', '', '', ''),
(10, 'AR', 'Argentina', '', 'South America', '', ''),
(11, 'AM', 'Armenia', '', 'Central Asia', '', ''),
(12, 'AW', 'Aruba', '', '', '', ''),
(13, 'AU', 'Australia', '', 'Australia', '', ''),
(14, 'AT', 'Austria', 'European Union', 'Central Europe', '', ''),
(15, 'AZ', 'Azerbaijan', '', 'Central Asia', '', ''),
(16, 'BS', 'Bahamas', '', '', '', ''),
(17, 'BH', 'Bahrain', '', 'West Asia', '', ''),
(18, 'BD', 'Bangladesh', '', 'South Asia', '', ''),
(19, 'BB', 'Barbados', '', '', '', ''),
(20, 'BY', 'Belarus', '', 'Eastern Europe', '', ''),
(21, 'BE', 'Belgium', 'European Union', 'Western Europe', '', ''),
(22, 'BZ', 'Belize', '', 'Central America', '', ''),
(23, 'BJ', 'Benin', 'African Union', 'West Africa', '', ''),
(24, 'BM', 'Bermuda', '', '', '', ''),
(25, 'BT', 'Bhutan', '', 'South Asia', '', ''),
(26, 'BO', 'Bolivia', '', 'South America', '', ''),
(27, 'BA', 'Bosnia and Herzegovina', '', 'Southeastern Europe', '', ''),
(28, 'BW', 'Botswana', 'African Union', 'South Africa', '', ''),
(29, 'BV', 'Bouvet Island', '', '', '', ''),
(30, 'BR', 'Brazil', '', 'South America', '', ''),
(31, 'IO', 'British Indian Ocean Territory', '', '', '', ''),
(32, 'BN', 'Brunei Darussalam', 'ASEAN', 'Southeast Asia', '', ''),
(33, 'BG', 'Bulgaria', 'European Union', 'Southeastern Europe', '', ''),
(34, 'BF', 'Burkina Faso', 'African Union', 'West Africa', '', ''),
(35, 'BI', 'Burundi', 'African Union', 'East Africa', '', ''),
(36, 'KH', 'Cambodia', 'ASEAN', 'Southeast Asia', '', ''),
(37, 'CM', 'Cameroon', 'African Union', 'Central Africa', '', ''),
(38, 'CA', 'Canada', '', 'North America', '', ''),
(39, 'CV', 'Cape Verde', 'African Union', 'West Africa', '', ''),
(40, 'KY', 'Cayman Islands', '', '', '', ''),
(41, 'CF', 'Central African Republic', 'African Union', 'Central Africa', '', ''),
(42, 'TD', 'Chad', 'African Union', 'Central Africa', '', ''),
(43, 'CL', 'Chile', '', 'South America', '', ''),
(44, 'CN', 'China', '', 'East Asia', '', ''),
(45, 'CX', 'Christmas Island', '', '', '', ''),
(46, 'CC', 'Cocos (Keeling) Islands', '', '', '', ''),
(47, 'CO', 'Colombia', '', 'South America', '', ''),
(48, 'KM', 'Comoros', 'African Union', 'East Africa', '', ''),
(49, 'CG', 'Congo', 'African Union', 'Central Africa', '', ''),
(50, 'CK', 'Cook Islands', '', '', '', ''),
(51, 'CR', 'Costa Rica', '', 'Central America', '', ''),
(52, 'HR', 'Croatia (Hrvatska)', 'European Union', 'Southeastern Europe', '', ''),
(53, 'CU', 'Cuba', '', 'Latin America', '', ''),
(54, 'CY', 'Cyprus', 'European Union', 'Southern Europe', '', ''),
(55, 'CZ', 'Czech Republic', 'European Union', 'Central Europe', '', ''),
(56, 'DK', 'Denmark', 'European Union', 'Northern Europe', '', ''),
(57, 'DJ', 'Djibouti', 'African Union', 'East Africa', '', ''),
(58, 'DM', 'Dominica', '', '', '', ''),
(59, 'DO', 'Dominican Republic', '', 'Latin America', '', ''),
(60, 'TP', 'East Timor', '', 'Southeast Asia', '', ''),
(61, 'EC', 'Ecuador', '', 'South America', '', ''),
(62, 'EG', 'Egypt', 'African Union', 'North Africa', '', ''),
(63, 'SV', 'El Salvador', '', 'Central America', '', ''),
(64, 'GQ', 'Equatorial Guinea', 'African Union', 'Central Africa', '', ''),
(65, 'ER', 'Eritrea', 'African Union', 'East Africa', '', ''),
(66, 'EE', 'Estonia', 'European Union', 'Eastern Europe', '', ''),
(67, 'ET', 'Ethiopia', 'African Union', 'East Africa', '', ''),
(68, 'FK', 'Falkland Islands (Malvinas)', '', 'South America', '', ''),
(69, 'FO', 'Faroe Islands', '', 'Northern Europe', '', ''),
(70, 'FJ', 'Fiji', '', '', '', ''),
(71, 'FI', 'Finland', 'European Union', 'Northern Europe', '', ''),
(72, 'FR', 'France', 'European Union', 'Western Europe', '', ''),
(73, 'FX', 'France, Metropolitan', '', '', '', ''),
(74, 'GF', 'French Guiana', '', '', '', ''),
(75, 'PF', 'French Polynesia', '', '', '', ''),
(76, 'TF', 'French Southern Territories', '', '', '', ''),
(77, 'GA', 'Gabon', 'African Union', 'Central Africa', '', ''),
(78, 'GM', 'Gambia', 'African Union', 'West Africa', '', ''),
(79, 'GE', 'Georgia', '', 'Central Asia', '', ''),
(80, 'DE', 'Germany', 'European Union', 'Central Europe', '', ''),
(81, 'GH', 'Ghana', 'African Union', 'West Africa', '', ''),
(82, 'GI', 'Gibraltar', '', 'Southern Europe', '', ''),
(83, 'GK', 'Guernsey', '', '', '', ''),
(84, 'GR', 'Greece', 'European Union', 'Southern Europe', '', ''),
(85, 'GL', 'Greenland', '', '', '', ''),
(86, 'GD', 'Grenada', '', '', '', ''),
(87, 'GP', 'Guadeloupe', '', '', '', ''),
(88, 'GU', 'Guam', '', '', '', ''),
(89, 'GT', 'Guatemala', '', 'Central America', '', ''),
(90, 'GN', 'Guinea', 'African Union', 'West Africa', '', ''),
(91, 'GW', 'Guinea-Bissau', 'African Union', 'West Africa', '', ''),
(92, 'GY', 'Guyana', '', 'South America', '', ''),
(93, 'HT', 'Haiti', '', '', '', ''),
(94, 'HM', 'Heard and Mc Donald Islands', '', '', '', ''),
(95, 'HN', 'Honduras', '', '', '', ''),
(96, 'HK', 'Hong Kong', '', 'East Asia', '', ''),
(97, 'HU', 'Hungary', 'European Union', 'Central Europe', '', ''),
(98, 'IS', 'Iceland', '', 'Northern Europe', '', ''),
(99, 'IN', 'India', '', 'South Asia', '', ''),
(100, 'IM', 'Isle of Man', '', 'Northern Europe', '', ''),
(101, 'ID', 'Indonesia', 'ASEAN', 'Southeast Asia', 'Indonesian', 'Bahasa'),
(102, 'IR', 'Iran (Islamic Republic of)', '', 'South Asia', '', ''),
(103, 'IQ', 'Iraq', '', 'West Asia', '', ''),
(104, 'IE', 'Ireland', 'European Union', 'Northern Europe', '', ''),
(105, 'IL', 'Israel', '', '', '', ''),
(106, 'IT', 'Italy', 'European Union', 'Southern Europe', '', ''),
(107, 'CI', 'Ivory Coast', '', 'West Africa', '', ''),
(108, 'JE', 'Jersey', '', '', '', ''),
(109, 'JM', 'Jamaica', '', '', '', ''),
(110, 'JP', 'Japan', '', 'East Asia', '', ''),
(111, 'JO', 'Jordan', '', 'West Asia', '', ''),
(112, 'KZ', 'Kazakhstan', '', 'Central Asia', '', ''),
(113, 'KE', 'Kenya', 'African Union', 'East Africa', '', ''),
(114, 'KI', 'Kiribati', '', '', '', ''),
(115, 'KP', 'Korea, Democratic People\'s Republic of', '', 'East Asia', '', ''),
(116, 'KR', 'Korea, Republic of', '', 'East Asia', '', ''),
(117, 'XK', 'Kosovo', '', '', '', ''),
(118, 'KW', 'Kuwait', '', 'West Asia', '', ''),
(119, 'KG', 'Kyrgyzstan', '', '', '', ''),
(120, 'LA', 'Laos', 'ASEAN', 'Southeast Asia', '', ''),
(121, 'LV', 'Latvia', 'European Union', 'Eastern Europe', '', ''),
(122, 'LB', 'Lebanon', '', 'West Asia', '', ''),
(123, 'LS', 'Lesotho', 'African Union', 'South Africa', '', ''),
(124, 'LR', 'Liberia', 'African Union', 'West Africa', '', ''),
(125, 'LY', 'Libyan Arab Jamahiriya', 'African Union', 'North Africa', '', ''),
(126, 'LI', 'Liechtenstein', '', 'Western Europe', '', ''),
(127, 'LT', 'Lithuania', 'European Union', 'Eastern Europe', '', ''),
(128, 'LU', 'Luxembourg', 'European Union', 'Western Europe', '', ''),
(129, 'MO', 'Macau', '', 'East Asia', '', ''),
(130, 'MK', 'Macedonia', '', 'Southeastern Europe', '', ''),
(131, 'MG', 'Madagascar', 'African Union', 'East Africa', '', ''),
(132, 'MW', 'Malawi', 'African Union', 'East Africa', '', ''),
(133, 'MY', 'Malaysia', 'ASEAN', 'Southeast Asia', '', ''),
(134, 'MV', 'Maldives', '', '', '', ''),
(135, 'ML', 'Mali', 'African Union', 'West Africa', '', ''),
(136, 'MT', 'Malta', 'European Union', 'Southern Europe', '', ''),
(137, 'MH', 'Marshall Islands', '', '', '', ''),
(138, 'MQ', 'Martinique', '', '', '', ''),
(139, 'MR', 'Mauritania', 'African Union', 'West Africa', '', ''),
(140, 'MU', 'Mauritius', 'African Union', 'East Africa', '', ''),
(141, 'TY', 'Mayotte', '', 'East Africa', '', ''),
(142, 'MX', 'Mexico', '', 'North America', '', ''),
(143, 'FM', 'Micronesia, Federated States of', '', '', '', ''),
(144, 'MD', 'Moldova, Republic of', '', 'Eastern Europe', '', ''),
(145, 'MC', 'Monaco', '', 'Western Europe', '', ''),
(146, 'MN', 'Mongolia', '', 'East Asia', '', ''),
(147, 'ME', 'Montenegro', '', 'Southeastern Europe', '', ''),
(148, 'MS', 'Montserrat', '', '', '', ''),
(149, 'MA', 'Morocco', 'African Union', 'North Africa', '', ''),
(150, 'MZ', 'Mozambique', 'African Union', 'East Africa', '', ''),
(151, 'MM', 'Myanmar', 'ASEAN', 'Southeast Asia', '', ''),
(152, 'NA', 'Namibia', 'African Union', 'South Africa', '', ''),
(153, 'NR', 'Nauru', '', '', '', ''),
(154, 'NP', 'Nepal', '', 'South Asia', '', ''),
(155, 'NL', 'Netherlands', 'European Union', 'Western Europe', '', ''),
(156, 'AN', 'Netherlands Antilles', '', '', '', ''),
(157, 'NC', 'New Caledonia', '', '', '', ''),
(158, 'NZ', 'New Zealand', '', '', '', ''),
(159, 'NI', 'Nicaragua', '', 'Central America', '', ''),
(160, 'NE', 'Niger', 'African Union', 'West Africa', '', ''),
(161, 'NG', 'Nigeria', 'African Union', 'West Africa', '', ''),
(162, 'NU', 'Niue', '', '', '', ''),
(163, 'NF', 'Norfolk Island', '', '', '', ''),
(164, 'MP', 'Northern Mariana Islands', '', '', '', ''),
(165, 'NO', 'Norway', '', 'Northern Europe', '', ''),
(166, 'OM', 'Oman', '', 'West Asia', '', ''),
(167, 'PK', 'Pakistan', '', 'South Asia', '', ''),
(168, 'PW', 'Palau', '', '', '', ''),
(169, 'PS', 'Palestine', '', '', '', ''),
(170, 'PA', 'Panama', '', 'Central America', '', ''),
(171, 'PG', 'Papua New Guinea', '', '', '', ''),
(172, 'PY', 'Paraguay', '', 'South America', '', ''),
(173, 'PE', 'Peru', '', '', '', ''),
(174, 'PH', 'Philippines', 'ASEAN', 'Southeast Asia', '', ''),
(175, 'PN', 'Pitcairn', '', '', '', ''),
(176, 'PL', 'Poland', 'European Union', 'Central Europe', '', ''),
(177, 'PT', 'Portugal', 'European Union', 'Southern Europe', '', ''),
(178, 'PR', 'Puerto Rico', '', 'Latin America', '', ''),
(179, 'QA', 'Qatar', '', 'West Asia', '', ''),
(180, 'RE', 'Reunion', '', 'East Africa', '', ''),
(181, 'RO', 'Romania', 'European Union', 'Central Europe', '', ''),
(182, 'RU', 'Russian Federation', '', '', '', ''),
(183, 'RW', 'Rwanda', 'African Union', 'East Africa', '', ''),
(184, 'KN', 'Saint Kitts and Nevis', '', '', '', ''),
(185, 'LC', 'Saint Lucia', '', '', '', ''),
(186, 'VC', 'Saint Vincent and the Grenadines', '', '', '', ''),
(187, 'WS', 'Samoa', '', '', '', ''),
(188, 'SM', 'San Marino', '', 'Southern Europe', '', ''),
(189, 'ST', 'Sao Tome and Principe', 'African Union', 'Central Africa', '', ''),
(190, 'SA', 'Saudi Arabia', '', 'West Asia', '', ''),
(191, 'SN', 'Senegal', 'African Union', 'West Africa', '', ''),
(192, 'RS', 'Serbia', '', 'Southeastern Europe', '', ''),
(193, 'SC', 'Seychelles', 'African Union', 'East Africa', '', ''),
(194, 'SL', 'Sierra Leone', 'African Union', 'West Africa', '', ''),
(195, 'SG', 'Singapore', 'ASEAN', 'Southeast Asia', '', ''),
(196, 'SK', 'Slovakia', 'European Union', 'Central Europe', '', ''),
(197, 'SI', 'Slovenia', 'European Union', 'Central Europe', '', ''),
(198, 'SB', 'Solomon Islands', '', '', '', ''),
(199, 'SO', 'Somalia', 'African Union', 'East Africa', '', ''),
(200, 'ZA', 'South Africa', 'African Union', 'South Africa', '', ''),
(201, 'GS', 'South Georgia South Sandwich Islands', '', 'South America', '', ''),
(202, 'ES', 'Spain', 'European Union', 'Southern Europe', '', ''),
(203, 'LK', 'Sri Lanka', '', 'South Asia', '', ''),
(204, 'SH', 'St. Helena', '', '', '', ''),
(205, 'PM', 'St. Pierre and Miquelon', '', '', '', ''),
(206, 'SD', 'Sudan', 'African Union', 'North Africa', '', ''),
(207, 'SR', 'Suriname', '', 'South America', '', ''),
(208, 'SJ', 'Svalbard and Jan Mayen Islands', '', 'Northern Europe', '', ''),
(209, 'SZ', 'Swaziland', 'African Union', 'South Africa', '', ''),
(210, 'SE', 'Sweden', 'European Union', 'Northern Europe', '', ''),
(211, 'CH', 'Switzerland', '', 'Western Europe', '', ''),
(212, 'SY', 'Syrian Arab Republic', '', '', '', ''),
(213, 'TW', 'Taiwan', '', 'East Asia', '', ''),
(214, 'TJ', 'Tajikistan', '', 'Central Asia', '', ''),
(215, 'TZ', 'Tanzania, United Republic of', 'African Union', 'East Africa', '', ''),
(216, 'TH', 'Thailand', 'ASEAN', 'Southeast Asia', '', ''),
(217, 'TG', 'Togo', 'African Union', 'West Africa', '', ''),
(218, 'TK', 'Tokelau', '', '', '', ''),
(219, 'TO', 'Tonga', '', '', '', ''),
(220, 'TT', 'Trinidad and Tobago', '', 'South America', '', ''),
(221, 'TN', 'Tunisia', 'African Union', 'North Africa', '', ''),
(222, 'TR', 'Turkey', '', 'Southeastern Europe', '', ''),
(223, 'TM', 'Turkmenistan', '', 'Central Asia', '', ''),
(224, 'TC', 'Turks and Caicos Islands', '', '', '', ''),
(225, 'TV', 'Tuvalu', '', '', '', ''),
(226, 'UG', 'Uganda', 'African Union', 'East Africa', '', ''),
(227, 'UA', 'Ukraine', '', 'Eastern Europe', '', ''),
(228, 'AE', 'United Arab Emirates', '', 'West Asia', '', ''),
(229, 'GB', 'United Kingdom', 'European Union', 'Europe', '', ''),
(230, 'US', 'United States', '', 'North America', '', ''),
(231, 'UM', 'United States minor outlying islands', '', '', '', ''),
(232, 'UY', 'Uruguay', '', 'South America', '', ''),
(233, 'UZ', 'Uzbekistan', '', 'Central Asia', '', ''),
(234, 'VU', 'Vanuatu', '', '', '', ''),
(235, 'VA', 'Vatican City State', '', 'Southern Europe', '', ''),
(236, 'VE', 'Venezuela', '', 'South America', '', ''),
(237, 'VN', 'Vietnam', 'ASEAN', 'Southeast Asia', '', ''),
(238, 'VG', 'Virgin Islands (British)', '', '', '', ''),
(239, 'VI', 'Virgin Islands (U.S.)', '', '', '', ''),
(240, 'WF', 'Wallis and Futuna Islands', '', '', '', ''),
(241, 'EH', 'Western Sahara', 'African Union', 'North Africa', '', ''),
(242, 'YE', 'Yemen', '', '', '', ''),
(243, 'ZR', 'Zaire', '', '', '', ''),
(244, 'ZM', 'Zambia', 'African Union', 'East Africa', '', ''),
(245, 'ZW', 'Zimbabwe', 'African Union', 'South Africa', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `md_goals`
--

CREATE TABLE `md_goals` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `slug` varchar(64) NOT NULL,
  `iat` datetime NOT NULL DEFAULT current_timestamp(),
  `uat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `md_goals`
--

INSERT INTO `md_goals` (`id`, `name`, `slug`, `iat`, `uat`) VALUES
(1, 'Find Mentor', 'find-mentor', '2019-10-17 10:27:44', '2019-10-17 06:12:57'),
(2, 'Get Inspired', 'get-inspired', '2019-10-17 10:27:44', '2019-10-17 06:13:01'),
(4, 'extensible', 'extensible', '2019-11-11 18:23:19', '2019-11-11 10:23:19');

-- --------------------------------------------------------

--
-- Table structure for table `md_interests`
--

CREATE TABLE `md_interests` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `slug` varchar(64) NOT NULL,
  `iat` datetime NOT NULL DEFAULT current_timestamp(),
  `uat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `md_interests`
--

INSERT INTO `md_interests` (`id`, `name`, `slug`, `iat`, `uat`) VALUES
(1, 'Markerting', 'marketing', '2019-10-17 10:27:44', '2019-11-07 09:32:57'),
(2, 'Finance', 'finance', '2019-10-17 10:27:44', '2019-11-07 09:33:03'),
(3, 'Technology', 'technology', '2019-10-17 10:27:44', '2019-11-07 09:33:16'),
(4, 'Sport', 'sport', '2019-11-07 17:34:00', '2019-11-07 09:34:00'),
(5, 'Entrepreneurship', 'entrepreneurship', '2019-11-07 17:34:00', '2019-11-07 09:34:00'),
(6, 'Travel', 'travel', '2019-11-07 17:34:00', '2019-11-07 09:34:00'),
(7, 'Art', 'art', '2019-11-07 17:34:00', '2019-11-07 09:34:00'),
(8, 'Forward', 'forward', '2019-11-11 18:06:36', '2019-11-11 10:08:27'),
(11, 'implement', 'implement', '2019-11-11 18:10:17', '2019-11-11 10:10:17');

-- --------------------------------------------------------

--
-- Table structure for table `md_ranks`
--

CREATE TABLE `md_ranks` (
  `id` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `slug` varchar(64) NOT NULL,
  `treshold` int(11) NOT NULL,
  `based_on` enum('Votes','Answers') NOT NULL,
  `iat` datetime NOT NULL DEFAULT current_timestamp(),
  `uat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `md_ranks`
--

INSERT INTO `md_ranks` (`id`, `level`, `name`, `slug`, `treshold`, `based_on`, `iat`, `uat`) VALUES
(1, 1, 'Kouhai', 'kouhai', 5, 'Votes', '2019-11-14 13:16:52', '2019-11-14 15:57:32'),
(2, 2, 'Senpai 1', 'senpai-1', 10, 'Votes', '2019-11-14 13:17:15', '2019-11-14 15:57:46');

-- --------------------------------------------------------

--
-- Table structure for table `md_topics`
--

CREATE TABLE `md_topics` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `slug` varchar(64) NOT NULL,
  `badge` varchar(64) NOT NULL,
  `iat` datetime NOT NULL DEFAULT current_timestamp(),
  `uat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `md_topics`
--

INSERT INTO `md_topics` (`id`, `name`, `slug`, `badge`, `iat`, `uat`) VALUES
(1, 'Trending', 'trending', '', '2019-10-17 10:27:44', '2019-10-17 06:18:58'),
(2, 'Work', 'work', 'work.png', '2019-10-17 10:27:44', '2019-11-07 09:34:46'),
(3, 'Accommodation', 'accommodation', 'accommodation.png', '2019-10-17 14:19:27', '2019-11-07 09:35:14'),
(4, 'Taxes', 'taxes', 'taxes.png', '2019-10-17 14:19:27', '2019-11-07 09:35:26'),
(5, 'Banking', 'banking', 'banking.png', '2019-11-07 17:36:45', '2019-11-07 09:36:45'),
(6, 'Hospital', 'hospital', 'hospital.png', '2019-11-07 17:36:45', '2019-11-07 09:36:45'),
(7, 'Telecommunications', 'telecommunications', 'telecommunications.png', '2019-11-07 17:36:45', '2019-11-07 09:36:45'),
(8, 'Disaster', 'disaster', 'disaster.png', '2019-11-07 17:36:45', '2019-11-07 09:36:45'),
(9, 'Emergency', 'emergency', 'emergency.png', '2019-11-07 17:36:45', '2019-11-07 09:36:45'),
(10, 'Bedfordshire', 'bedfordshire', 'bedfordshire.png', '2019-11-12 12:05:25', '2019-11-13 08:09:38'),
(11, 'Tunisia', 'tunisia', 'tunisia.png', '2019-11-12 12:15:54', '2019-11-12 04:15:54'),
(13, 'synthesizing', 'synthesizing', 'synthesizing.png', '2019-11-13 15:32:52', '2019-11-13 07:32:52');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `message_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `recipient_id` int(11) NOT NULL,
  `iat` datetime NOT NULL DEFAULT current_timestamp(),
  `uat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`message_id`, `sender_id`, `recipient_id`, `iat`, `uat`) VALUES
(12345678, 10293847, 29384756, '2019-11-05 14:26:01', '2019-11-05 06:26:01'),
(28924307, 10293847, 63608714, '2019-11-15 15:59:33', '2019-11-15 07:59:33'),
(83487438, 38475647, 10293847, '2019-11-05 15:51:20', '2019-11-05 07:51:20'),
(98765432, 29384756, 38475647, '2019-11-15 10:56:01', '2019-11-15 02:56:01');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `post_id` int(11) NOT NULL,
  `post_type` enum('Post','Featured Article','Emergency Alert','Embassy','Daily Tips') NOT NULL DEFAULT 'Post',
  `user_id` int(11) NOT NULL,
  `title` tinytext NOT NULL,
  `content` mediumtext NOT NULL,
  `picture` varchar(64) NOT NULL,
  `iat` datetime NOT NULL DEFAULT current_timestamp(),
  `uat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`post_id`, `post_type`, `user_id`, `title`, `content`, `picture`, `iat`, `uat`) VALUES
(12234586, 'Emergency Alert', 685645, '', 'Alert!!!!!', '', '2019-10-28 15:24:38', '2019-11-14 00:49:02'),
(13829105, 'Post', 10293847, '', 'apakahahh??', '', '2019-11-13 19:08:02', '2019-11-13 11:08:02'),
(15417238, 'Emergency Alert', 685645, '', 'Dolorem aut facere veniam id. Et nostrum et. Quaerat voluptatibus rerum quis soluta dolorem eligendi velit. Expedita qui commodi delectus sit autem. Neque ut vel voluptate vel dolorum perspiciatis. Aut officiis placeat.', '', '2017-12-04 15:46:56', '2019-11-14 00:49:11'),
(36230714, 'Featured Article', 685645, 'Alaska Congolese Franc programming North Dakota asymmetric', 'Earum quaerat et eum sapiente esse natus tempore sed. Sint repellendus quaerat qui. Qui ut ratione sit placeat voluptatibus quasi ipsum tempora voluptatem. Eum nisi error. Quo magni alias dolor qui aut dolor ut. Explicabo eos rerum similique cupiditate autem officia.', 'ca81330a86081fca04acf59503d204b8.jpg', '2019-10-31 13:59:45', '2019-11-14 00:48:47'),
(38536427, 'Featured Article', 685645, 'monetize reboot firewall Tunnel Alley', 'Debitis nisi iusto. Sint aperiam dolore id vel nesciunt eos nemo fugiat. Voluptate perspiciatis asperiores mollitia eius nisi blanditiis cum quibusdam deleniti. Odit voluptas reiciendis iure quibusdam quo sint.', '4ee0b1cc5ccac98643b4acb3dc1aef2e.jpg', '2019-11-08 16:15:39', '2019-11-14 00:48:42'),
(45458567, 'Daily Tips', 685645, '', '<p>\r\nAww yeah, you successfully read this important alert message. This example text is going to run a bit longer so that you can see how spacing within an alert works with this kind of content	</p>', '', '2019-10-25 14:35:23', '2019-11-14 00:49:05'),
(47682375, 'Post', 29384756, '', '<p>Good afternoon everyone. I want to share  an event about \"Career consultant for <br> foreigner\". This event is for foreigner who looking job or need consultation. <br>\r\n												Venue : Pasona Job Hub Square;<br>\r\n												Date and Time : Friday, 20 November 2019<br>\r\n												For mor information visit:<br>\r\n												<a href=\"#\">https://jobhubsquare.jp/foreign-event</a></p>', '', '2019-10-24 14:20:43', '2019-10-25 11:14:13'),
(48352796, 'Featured Article', 685645, 'Rand Loti Concrete', 'Quia animi dolor blanditiis numquam. Voluptas qui quis corrupti minima facilis. Ut enim animi. Perferendis culpa voluptate qui omnis officia.', '67e7b233e0becc43ad4e66c88dd7fc30.jpeg', '2019-10-31 14:10:52', '2019-11-14 00:48:44'),
(53145082, 'Emergency Alert', 685645, '', 'Tenetur reprehenderit aliquam tempore id magnam dolores eligendi. Eum omnis dolore magni nobis. Enim odit aut ea quo dolor placeat qui qui vitae.', '', '2019-10-30 12:14:09', '2019-11-14 00:48:57'),
(67513062, 'Embassy', 685645, '', 'Eaque iste doloremque aspernatur assumenda et accusantium deleniti officia. Voluptatum exercitationem omnis. Dolorem placeat voluptas unde. Dolore sequi expedita accusamus accusamus et iure nemo reprehenderit. Maxime dolorum repellat similique animi.', '', '2019-10-30 11:20:39', '2019-11-14 00:49:00'),
(74583456, 'Embassy', 234567, '', '<p>\r\n												To Celebrate our 74th Indonesian Independence Day, <br>\r\n												the Indonesian Embassy in Tokyo presents : <br>\r\n												<br>\r\n												\"People\'s Party\" - United for Forward. <br>\r\n												Location : Kasai Rinkai Park <br>\r\n												Date : Sunday, 15 September 2019, <br>\r\n												Time : 09.00 - 17.00\r\n											</p>', '', '2019-10-24 14:35:23', '2019-11-14 00:49:07'),
(76023184, 'Post', 10293847, '', 'In aut totam quibusdam voluptatum alias quisquam. Eum voluptatem sequi. Facilis numquam quo eum ipsa et aut animi. Doloremque dolore voluptas animi vitae vitae mollitia et modi.', '', '2019-10-31 10:25:59', '2019-10-31 02:25:59'),
(90572649, 'Post', 10293847, '', 'ldkgfjhsdfs\nskdfskdf\nsfsdkfsd', '', '2019-11-13 19:14:55', '2019-11-13 11:14:55'),
(95976021, 'Post', 10293847, '', 'Veritatis accusantium omnis labore quae culpa consequatur sit sit. Maiores est quisquam ab explicabo incidunt quos voluptatem doloremque cumque. Debitis qui tempore amet consectetur assumenda tempora.', '', '2019-10-31 10:51:32', '2019-10-31 02:51:32');

-- --------------------------------------------------------

--
-- Table structure for table `post_comments`
--

CREATE TABLE `post_comments` (
  `comment_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `comment` text NOT NULL,
  `iat` datetime NOT NULL DEFAULT current_timestamp(),
  `uat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `post_options`
--

CREATE TABLE `post_options` (
  `post_id` int(11) NOT NULL,
  `dismissed_by` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `blocked_by` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `iat` datetime NOT NULL DEFAULT current_timestamp(),
  `uat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `post_options`
--

INSERT INTO `post_options` (`post_id`, `dismissed_by`, `blocked_by`, `iat`, `uat`) VALUES
(12234586, '-', '-', '2019-10-29 18:46:06', '2019-11-06 06:27:53'),
(13829105, '-', '-', '2019-11-13 19:08:02', '2019-11-13 11:08:02'),
(15417238, '-', '-', '2019-10-30 12:00:46', '2019-11-06 06:27:55'),
(38536427, '-', '-', '2019-11-08 16:15:39', '2019-11-08 08:15:39'),
(53145082, '-10293847-', '-', '2019-10-30 12:14:09', '2019-11-06 06:27:57'),
(90572649, '-', '-', '2019-11-13 19:14:55', '2019-11-13 11:14:55');

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `report_id` int(11) NOT NULL,
  `reporter_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `post_id` int(11) NOT NULL DEFAULT 0,
  `question_id` int(11) NOT NULL DEFAULT 0,
  `answer_id` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0 = reported; 1 = blocked;',
  `iat` datetime NOT NULL DEFAULT current_timestamp(),
  `uat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `reports`
--

INSERT INTO `reports` (`report_id`, `reporter_id`, `user_id`, `post_id`, `question_id`, `answer_id`, `status`, `iat`, `uat`) VALUES
(37286453, 10293847, 38475647, 0, 0, 0, 0, '2019-11-14 17:55:54', '2019-11-14 09:55:54'),
(44576893, 10293847, 0, 12234586, 0, 0, 1, '2019-11-11 17:35:32', '2019-11-14 04:31:33'),
(58641866, 38475647, 0, 12234586, 0, 0, 1, '2019-11-11 17:35:32', '2019-11-14 04:31:40'),
(84517986, 10293847, 0, 0, 0, 75412398, 1, '2019-11-14 10:38:45', '2019-11-14 04:31:42'),
(87583465, 29384756, 0, 0, 50946721, 0, 1, '2019-11-11 17:31:09', '2019-11-14 04:31:44');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `keywords` text NOT NULL,
  `lang_id` enum('id','en') NOT NULL,
  `send_sms` enum('1','0') NOT NULL,
  `scache` int(11) NOT NULL,
  `lcache` int(11) NOT NULL,
  `foto` varchar(50) NOT NULL,
  `last_backup` datetime NOT NULL DEFAULT current_timestamp(),
  `server_availability` enum('0','1') NOT NULL DEFAULT '1',
  `uat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `keywords`, `lang_id`, `send_sms`, `scache`, `lcache`, `foto`, `last_backup`, `server_availability`, `uat`) VALUES
(1, 'senpai', 'en', '1', 0, 60, '', '2019-09-09 08:24:45', '1', '2019-10-17 05:45:00');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `level` enum('Kouhai','Senpai') NOT NULL DEFAULT 'Kouhai',
  `username` varchar(32) NOT NULL,
  `fullname` varchar(64) NOT NULL,
  `email` varchar(64) NOT NULL,
  `phone` varchar(16) NOT NULL,
  `nationality` varchar(4) NOT NULL,
  `profile_picture` varchar(64) NOT NULL,
  `password` varchar(256) NOT NULL,
  `remember_me` int(11) NOT NULL DEFAULT 0,
  `session_token` tinytext NOT NULL,
  `token` varchar(4) NOT NULL,
  `flag` enum('-1','0','1','2') NOT NULL DEFAULT '0' COMMENT '-1 = blocked, 0 = inactive, 1 = active/unverified, 2 = verified',
  `iat` datetime NOT NULL DEFAULT current_timestamp(),
  `uat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `level`, `username`, `fullname`, `email`, `phone`, `nationality`, `profile_picture`, `password`, `remember_me`, `session_token`, `token`, `flag`, `iat`, `uat`) VALUES
(10293847, 'Kouhai', 'ito', 'Ito Rijal', 'ophyeq@gmail.com', '+6285299877148', 'ID', '8772bcba588f40460a324840c55b945d.png', '$2y$10$5njYR1SG4gBLUaV7hhkgYO.OW1PDjgnVGHpVVXR0JOCQXexVUUbYW', 0, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJsYXN0IjoiMjAxOS0xMS0xOCAwMzoxNToyMSIsImlkIjoiMTAyOTM4NDciLCJ1c2VybmFtZSI6Iml0byJ9.Rbl0iJCbN9Avofknl6QPaf9q1BFfPqjzq6rHj86AJqM', '0', '1', '2017-12-05 15:46:57', '2019-11-18 03:15:21'),
(13872961, 'Kouhai', 'Katharina', 'Katharina.Greenholt', 'Lila.Hoppe@example.org', '', 'TH', '', '$2y$10$4RoHp//Uk5cbYw6iVYcv3OkpPdp9PD5D2FIO6b/6K/T2lga9V05bS', 0, '', '3208', '-1', '2019-10-30 13:43:08', '2019-10-30 06:33:42'),
(29384756, 'Kouhai', 'vega', 'Vega Vatima', 'vegavatima@gmail.com', '+6285', 'ID', '93c0fd5cde0a0c11fe9cd21e1dc6b382.png', '$2y$10$5njYR1SG4gBLUaV7hhkgYO.OW1PDjgnVGHpVVXR0JOCQXexVUUbYW', 0, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJsYXN0IjoiMjAxOS0xMS0xOCAwMzoyODoyNyIsImlkIjoiMjkzODQ3NTYiLCJ1c2VybmFtZSI6InZlZ2EifQ.9zhBzn4Wz6BeiXhqECENWlL0rkKmmn3ZEu_3TPLFDK8', '0', '1', '2017-12-05 15:46:57', '2019-11-18 03:28:27'),
(38146253, 'Kouhai', 'Ryleigh', 'Ryleigh.Bahringer24', 'Paul.Purdy@example.net', '', 'MP', '', '$2y$10$tZFautx0/ebihm0PgwZTx.8x3t0DTShU3igJTi3cAGPeTvmtiSE6C', 0, '', '7329', '-1', '2019-10-30 14:31:40', '2019-11-14 10:24:03'),
(38475647, 'Kouhai', 'aldi', 'Ahmad Rifaldi', 'aldi@gmail.com', '+6281', 'ID', 'a2e46fc6bba1c7d0e5de00e366c82443.png', '$2y$10$5njYR1SG4gBLUaV7hhkgYO.OW1PDjgnVGHpVVXR0JOCQXexVUUbYW', 0, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJsYXN0IjoiMjAxOS0xMS0xNSAwMzoxMjoyNiIsImlkIjoiMzg0NzU2NDciLCJ1c2VybmFtZSI6ImFsZGkifQ.YFhrWrojdx4u3wFT_DqdIu5sI35arcM75G1pYBKkZtc', '0', '2', '2017-12-05 15:46:57', '2019-11-15 03:12:26'),
(63608714, 'Kouhai', 'Dong', 'Dong Dang', 'Geraldine83@example.com', '', 'ME', '', '$2y$10$/XhPf15tezi7xUgmP3O0MO6SisQb/wMWCDc4SznhixEOB4mRBGnIK', 0, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJsYXN0IjoiMjAxOS0xMC0zMCAwOToxNDozMiIsImlkIjoiNjM2MDg3MTQiLCJ1c2VybmFtZSI6IkRvbmcifQ.LmgH6H8gjaPYTQIvkI9ScVAWaIQW2NJtoBSljJa5OHM', '9653', '1', '2019-10-30 13:45:28', '2019-10-30 09:14:32');

-- --------------------------------------------------------

--
-- Table structure for table `user_badges`
--

CREATE TABLE `user_badges` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  `iat` datetime NOT NULL DEFAULT current_timestamp(),
  `uat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_badges`
--

INSERT INTO `user_badges` (`id`, `user_id`, `topic_id`, `iat`, `uat`) VALUES
(2, 10293847, 2, '2019-10-24 16:06:42', '2019-10-24 08:06:42'),
(3, 29384756, 2, '2019-10-24 16:06:42', '2019-10-24 08:06:42'),
(4, 10293847, 4, '2019-11-14 18:22:30', '2019-11-14 10:22:30');

-- --------------------------------------------------------

--
-- Table structure for table `user_goals`
--

CREATE TABLE `user_goals` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `goal_id` int(11) NOT NULL,
  `iat` datetime NOT NULL DEFAULT current_timestamp(),
  `uat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_goals`
--

INSERT INTO `user_goals` (`id`, `user_id`, `goal_id`, `iat`, `uat`) VALUES
(2, 10293847, 1, '2019-10-26 23:44:30', '2019-10-26 15:44:30'),
(3, 38475647, 0, '2019-11-13 18:16:36', '2019-11-13 10:16:36');

-- --------------------------------------------------------

--
-- Table structure for table `user_interests`
--

CREATE TABLE `user_interests` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `interest_id` int(11) NOT NULL,
  `iat` datetime NOT NULL DEFAULT current_timestamp(),
  `uat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_interests`
--

INSERT INTO `user_interests` (`id`, `user_id`, `interest_id`, `iat`, `uat`) VALUES
(3, 29384756, 2, '2019-10-24 16:06:42', '2019-10-24 08:06:42'),
(10, 10293847, 2, '2019-10-25 15:09:47', '2019-10-25 07:09:47'),
(11, 10293847, 3, '2019-10-26 23:44:30', '2019-10-26 15:44:30'),
(12, 38475647, 0, '2019-11-13 18:16:36', '2019-11-13 10:16:36');

-- --------------------------------------------------------

--
-- Table structure for table `user_profiles`
--

CREATE TABLE `user_profiles` (
  `user_id` int(11) NOT NULL,
  `header_picture` varchar(64) NOT NULL,
  `job_position` tinytext NOT NULL,
  `job_company` tinytext NOT NULL,
  `city` tinytext NOT NULL,
  `description` text NOT NULL,
  `facebook` varchar(64) NOT NULL,
  `twitter` varchar(64) NOT NULL,
  `linkedin` varchar(64) NOT NULL,
  `iat` datetime NOT NULL DEFAULT current_timestamp(),
  `uat` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_profiles`
--

INSERT INTO `user_profiles` (`user_id`, `header_picture`, `job_position`, `job_company`, `city`, `description`, `facebook`, `twitter`, `linkedin`, `iat`, `uat`) VALUES
(10293847, 'aeda64085352d57409e5d4ffd194002c.png', 'Senior Programmer', 'Upana Studio Internasional', 'Tokyo', 'Consectetur corporis repellat omnis illum nemo similique officia quo. Quidem et omnis eaque molestiae suscipit.', 'ito.rijal', 'itorijal', 'mtaufiqurrahman', '2019-10-24 15:39:34', '2019-11-17 08:58:44'),
(13872961, '', '', '', '', '', '', '', '', '2019-10-30 13:43:08', '2019-10-30 05:43:08'),
(29384756, '552c37b9bb6660ff10c622c4a2f6274d.png', 'Manager', 'Pasona', 'Tokyo', '', '', '', '', '2019-10-24 15:39:34', '2019-11-13 09:53:25'),
(38146253, '', '', '', '', '', '', '', '', '2019-10-30 14:31:40', '2019-10-30 06:31:40'),
(38475647, 'ecdc707cc7bfb3547683a328e43b8684.png', 'Freelancer', 'Upana', 'Tokyo', 'yasss', '', '', '', '2019-10-24 15:39:34', '2019-11-13 10:16:36'),
(63608714, '', '', '', '', '', '', '', '', '2019-10-30 13:45:28', '2019-10-30 05:45:28');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `advice_answers`
--
ALTER TABLE `advice_answers`
  ADD PRIMARY KEY (`answer_id`);

--
-- Indexes for table `advice_questions`
--
ALTER TABLE `advice_questions`
  ADD PRIMARY KEY (`question_id`);

--
-- Indexes for table `advice_votes`
--
ALTER TABLE `advice_votes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blocked_answers`
--
ALTER TABLE `blocked_answers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blocked_posts`
--
ALTER TABLE `blocked_posts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blocked_questions`
--
ALTER TABLE `blocked_questions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD PRIMARY KEY (`bookmark_id`);

--
-- Indexes for table `experiences`
--
ALTER TABLE `experiences`
  ADD PRIMARY KEY (`experience_id`);

--
-- Indexes for table `follower`
--
ALTER TABLE `follower`
  ADD PRIMARY KEY (`user_id`,`follower_id`),
  ADD UNIQUE KEY `follower_id` (`follower_id`,`user_id`);

--
-- Indexes for table `md_countries`
--
ALTER TABLE `md_countries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `md_goals`
--
ALTER TABLE `md_goals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `md_interests`
--
ALTER TABLE `md_interests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `md_ranks`
--
ALTER TABLE `md_ranks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `md_topics`
--
ALTER TABLE `md_topics`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`message_id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`post_id`);

--
-- Indexes for table `post_comments`
--
ALTER TABLE `post_comments`
  ADD PRIMARY KEY (`comment_id`);

--
-- Indexes for table `post_options`
--
ALTER TABLE `post_options`
  ADD PRIMARY KEY (`post_id`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`report_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `user_badges`
--
ALTER TABLE `user_badges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_goals`
--
ALTER TABLE `user_goals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_interests`
--
ALTER TABLE `user_interests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_profiles`
--
ALTER TABLE `user_profiles`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `advice_votes`
--
ALTER TABLE `advice_votes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `blocked_answers`
--
ALTER TABLE `blocked_answers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `blocked_posts`
--
ALTER TABLE `blocked_posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `blocked_questions`
--
ALTER TABLE `blocked_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `md_countries`
--
ALTER TABLE `md_countries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=246;

--
-- AUTO_INCREMENT for table `md_goals`
--
ALTER TABLE `md_goals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `md_interests`
--
ALTER TABLE `md_interests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `md_ranks`
--
ALTER TABLE `md_ranks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `md_topics`
--
ALTER TABLE `md_topics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `user_badges`
--
ALTER TABLE `user_badges`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user_goals`
--
ALTER TABLE `user_goals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user_interests`
--
ALTER TABLE `user_interests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
