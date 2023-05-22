-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.5.19-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- fileUpload 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `fileupload` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci */;
USE `fileUpload`;

-- 테이블 fileUpload.board 구조 내보내기
CREATE TABLE IF NOT EXISTS `board` (
  `board_no` int(11) NOT NULL AUTO_INCREMENT,
  `board_title` text NOT NULL,
  `member_id` varchar(50) NOT NULL,
  `updatedate` datetime NOT NULL,
  `createdate` datetime NOT NULL,
  PRIMARY KEY (`board_no`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 fileUpload.board:~7 rows (대략적) 내보내기
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` (`board_no`, `board_title`, `member_id`, `updatedate`, `createdate`) VALUES
	(1, '1차', 'null', '2023-05-19 15:35:41', '2023-05-19 15:35:41'),
	(2, '1차', 'null', '2023-05-19 15:53:49', '2023-05-19 15:53:49'),
	(3, '1', 'null', '2023-05-19 15:54:29', '2023-05-19 15:54:29'),
	(4, '1', 'null', '2023-05-19 16:03:42', '2023-05-19 16:03:42'),
	(5, '10', 'test', '2023-05-19 16:04:30', '2023-05-19 16:04:30'),
	(6, '1', 'test', '2023-05-19 16:05:31', '2023-05-19 16:05:31'),
	(7, '테스트1', 'test', '2023-05-19 16:22:49', '2023-05-19 16:22:49'),
	(8, 'test 50', 'test', '2023-05-19 16:28:35', '2023-05-19 16:28:35'),
	(9, 'test1111', 'test', '2023-05-19 16:33:49', '2023-05-19 16:33:49'),
	(10, 'test 99', 'test', '2023-05-19 16:43:46', '2023-05-19 16:43:46'),
	(11, 'test77', 'test', '2023-05-19 16:45:16', '2023-05-19 16:45:16');
/*!40000 ALTER TABLE `board` ENABLE KEYS */;

-- 테이블 fileUpload.board_file 구조 내보내기
CREATE TABLE IF NOT EXISTS `board_file` (
  `board_file_no` int(11) NOT NULL AUTO_INCREMENT,
  `board_no` int(11) NOT NULL,
  `origin_filename` text NOT NULL,
  `save_filename` text NOT NULL,
  `path` text NOT NULL,
  `type` varchar(50) NOT NULL,
  `createdate` datetime NOT NULL,
  PRIMARY KEY (`board_file_no`),
  KEY `FK__board` (`board_no`),
  CONSTRAINT `FK__board` FOREIGN KEY (`board_no`) REFERENCES `board` (`board_no`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 fileUpload.board_file:~9 rows (대략적) 내보내기
/*!40000 ALTER TABLE `board_file` DISABLE KEYS */;
INSERT INTO `board_file` (`board_file_no`, `board_no`, `origin_filename`, `save_filename`, `path`, `type`, `createdate`) VALUES
	(1, 3, 'SQLD 요약정리 2021.pdf', 'SQLD 요약정리 20212.pdf', '/upload', 'application/pdf', '2023-05-19 15:54:29'),
	(2, 4, 'SQLD 요약정리 2021.pdf', 'SQLD 요약정리 20213.pdf', 'upload', 'application/pdf', '2023-05-19 16:03:42'),
	(3, 5, 'SQLD 요약정리 2021.pdf', 'SQLD 요약정리 20214.pdf', 'upload', 'application/pdf', '2023-05-19 16:04:30'),
	(4, 6, 'SQLD 요약정리 2021.pdf', 'SQLD 요약정리 20215.pdf', 'upload', 'application/pdf', '2023-05-19 16:05:31'),
	(5, 7, 'SQLD 요약정리 2021.pdf', 'SQLD 요약정리 20216.pdf', 'upload', 'application/pdf', '2023-05-19 16:22:49'),
	(6, 8, 'SQLD 요약정리 2021.pdf', 'SQLD 요약정리 20217.pdf', 'upload', 'application/pdf', '2023-05-19 16:28:35'),
	(7, 9, 'SQLD 요약정리 2021.pdf', 'SQLD 요약정리 20218.pdf', 'upload', 'application/pdf', '2023-05-19 16:33:49'),
	(8, 10, 'SQLD 요약정리 2021.pdf', 'SQLD 요약정리 20219.pdf', 'upload', 'application/pdf', '2023-05-19 16:43:46'),
	(9, 11, 'SQLD 요약정리 2021.pdf', 'SQLD 요약정리 202110.pdf', 'upload', 'application/pdf', '2023-05-19 16:45:16');
/*!40000 ALTER TABLE `board_file` ENABLE KEYS */;

-- 테이블 fileUpload.member 구조 내보내기
CREATE TABLE IF NOT EXISTS `member` (
  `member_id` varchar(50) NOT NULL,
  `member_pw` varchar(50) NOT NULL,
  `updatedate` datetime NOT NULL,
  `createdate` datetime NOT NULL,
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 fileUpload.member:~1 rows (대략적) 내보내기
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` (`member_id`, `member_pw`, `updatedate`, `createdate`) VALUES
	('USER1', '*A4B6157319038724E3560894F7F932C8886EBFCF', '2023-05-19 10:11:37', '2023-05-19 10:11:37');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
