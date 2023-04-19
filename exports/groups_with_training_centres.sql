-- MariaDB dump 10.19  Distrib 10.5.15-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: db    Database: wordpress
-- ------------------------------------------------------
-- Server version	10.3.30-MariaDB-1:10.3.30+maria~focal

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `wp_groups_group`
--

DROP TABLE IF EXISTS `wp_groups_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_groups_group` (
  `group_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `datetime` datetime DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  PRIMARY KEY (`group_id`),
  UNIQUE KEY `group_n` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_groups_group`
--

LOCK TABLES `wp_groups_group` WRITE;
/*!40000 ALTER TABLE `wp_groups_group` DISABLE KEYS */;
INSERT INTO `wp_groups_group` VALUES 
(1,NULL,0,'2022-10-10 13:49:11','Registered',NULL),

(2,NULL,1,'2022-10-14 13:18:36','Ballincollig Training Centre',NULL),
(3,2,1,'2022-10-10 13:53:48','Cork City',''),
(4,2,1,'2022-10-10 13:55:53','Cork County Council',''),
(5,2,1,'2022-10-10 13:59:33','Kerry County Council',''),

(6,NULL,1,'2022-10-14 13:21:39','Ballycoolin Training Centre',NULL),
(7,6,1,'2022-10-10 14:15:59','Dublin City Council',NULL),
(8,6,1,'2022-10-10 14:15:59','Dun Laoghaire County Council',NULL),
(9,6,1,'2022-10-10 14:15:59','Fingal County Council',NULL),
(10,6,1,'2022-10-10 14:15:59','Kildare County Council',NULL),
(11,6,1,'2022-10-10 14:15:59','Louth County Council',NULL),
(12,6,1,'2022-10-10 14:15:59','Meath County Council',NULL),
(13,6,1,'2022-10-10 14:15:59','South Dublin County Council',NULL),
(14,6,1,'2022-10-10 14:15:59','Westmeath County Council',NULL),
(15,6,1,'2022-10-10 14:15:59','Wicklow County Council',NULL),

(16,NULL,1,'2022-10-14 13:22:00','Castlebar Training Centre',NULL),
(17,16,1,'2022-10-10 14:15:59','Galway City',NULL),
(18,16,1,'2022-10-10 14:15:59','Galway County',NULL),
(19,16,1,'2022-10-10 14:15:59','Leitrim County Council',NULL),
(20,16,1,'2022-10-10 14:15:59','Longford County Council',NULL),
(21,16,1,'2022-10-10 14:15:59','Mayo County Council',NULL),
(22,16,1,'2022-10-10 14:15:59','Roscommon County Council',NULL),

(23,NULL,1,'2022-10-14 13:22:23','Roscrea Training Centre',NULL),
(24,23,1,'2022-10-10 14:15:59','Carlow County Council',NULL),
(25,23,1,'2022-10-10 14:15:59','Clare County Council',NULL),
(26,23,1,'2022-10-10 14:15:59','Kilkenny County Council',NULL),
(27,23,1,'2022-10-10 14:15:59','Laois County Council',NULL),
(28,23,1,'2022-10-10 14:15:59','Limerick City & County Council',NULL),
(29,23,1,'2022-10-10 14:15:59','Offaly County Council',NULL),
(30,23,1,'2022-10-10 14:15:59','Tipperary County Council',NULL),
(31,23,1,'2022-10-10 14:15:59','Waterford City & County Council',NULL),
(32,23,1,'2022-10-10 14:15:59','Wexford County Council',NULL),

(34,NULL,1,'2022-10-14 13:22:40','Stranorlar Training Centre',NULL),
(35,34,1,'2022-10-10 14:15:59','Cavan County Council',NULL),
(36,34,1,'2022-10-10 14:15:59','Donegal County Council',NULL),
(37,34,1,'2022-10-10 14:15:59','Monaghan County Council',NULL),
(38,34,1,'2022-10-10 14:15:59','Sligo County Council',NULL),

(39,NULL,1,'2022-10-14 13:22:40','Private Client Training Centre',NULL),
(33,39,1,'2022-10-10 14:15:59','Private Client',NULL);

/*!40000 ALTER TABLE `wp_groups_group` ENABLE KEYS */;
UNLOCK TABLES;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-14 13:29:46
