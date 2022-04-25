CREATE DATABASE  IF NOT EXISTS `year_7_project` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `year_7_project`;
-- MySQL dump 10.13  Distrib 8.0.28, for macos11 (x86_64)
--
-- Host: localhost    Database: year_7_project
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `behaviour_management`
--

DROP TABLE IF EXISTS `behaviour_management`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `behaviour_management` (
  `incident_ID` int NOT NULL AUTO_INCREMENT,
  `incident_date` date NOT NULL,
  `student_ID` int NOT NULL,
  `behaviour_points` int DEFAULT '0',
  `incident_type` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  PRIMARY KEY (`incident_ID`),
  UNIQUE KEY `unique_incident_ID` (`incident_ID`),
  KEY `fk_bm_s_ID_idx` (`student_ID`),
  CONSTRAINT `fk_bm_s_ID` FOREIGN KEY (`student_ID`) REFERENCES `students_names` (`student_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `behaviour_management`
--

LOCK TABLES `behaviour_management` WRITE;
/*!40000 ALTER TABLE `behaviour_management` DISABLE KEYS */;
INSERT INTO `behaviour_management` VALUES (9,'2022-03-17',3,1,'Low level disruption'),(10,'2022-03-17',3,1,'Low level disruption'),(11,'2022-03-17',3,1,'Low level disruption'),(12,'2022-03-17',3,1,'Low level disruption'),(13,'2022-03-17',12,2,'Behaviour'),(14,'2022-03-17',12,1,'Uniform'),(15,'2022-03-20',12,1,'Uniform'),(16,'2022-03-20',28,2,'Behaviour'),(17,'2022-03-20',3,1,'Low level disruption'),(18,'2022-03-20',10,2,'Behaviour'),(19,'2022-03-20',21,1,'Uniform'),(20,'2022-03-20',15,1,'Uniform'),(21,'2022-03-20',18,1,'Uniform'),(22,'2022-03-20',18,1,'Uniform'),(23,'2022-03-20',3,2,'Behaviour'),(24,'2022-03-20',3,1,'Uniform'),(25,'2022-03-20',11,2,'Behaviour'),(26,'2022-03-20',11,1,'Low level disruption'),(27,'2022-03-20',11,1,'Uniform'),(28,'2022-03-20',11,1,'Uniform');
/*!40000 ALTER TABLE `behaviour_management` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_incident_insert` AFTER INSERT ON `behaviour_management` FOR EACH ROW BEGIN
        INSERT IGNORE INTO behaviour_message(incident_ID, student_ID, message, date_time)
        SELECT bm.incident_ID, bm.student_ID, 
        CONCAT('Hi ', h.parental_contact,', ', s.first_name, ' has been given ', bm.behaviour_points, 
        ' behaviour points. We appreciate your support with ', student_pronoun(gender_at_birth), ' behaviour in school.'),
        NOW()
FROM home_contact h
INNER JOIN 
behaviour_management bm
ON h.student_ID = bm.student_ID
INNER JOIN 
students_names s
ON s.student_ID = bm.student_ID 
INNER JOIN students_gender g
ON g.student_ID = s.student_ID;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `behaviour_message`
--

DROP TABLE IF EXISTS `behaviour_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `behaviour_message` (
  `incident_ID` int NOT NULL,
  `student_ID` int NOT NULL,
  `message_ID` int NOT NULL AUTO_INCREMENT,
  `message` varchar(200) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  PRIMARY KEY (`message_ID`),
  UNIQUE KEY `unique_messages_ID` (`incident_ID`,`message_ID`),
  UNIQUE KEY `incident_ID_UNIQUE` (`incident_ID`),
  KEY `fk_mess_s_ID_idx` (`student_ID`),
  KEY `fk_mess_incident_ID_idx` (`incident_ID`),
  CONSTRAINT `fk_mess_inc_ID` FOREIGN KEY (`incident_ID`) REFERENCES `behaviour_management` (`incident_ID`),
  CONSTRAINT `fk_mess_s_ID` FOREIGN KEY (`student_ID`) REFERENCES `students_names` (`student_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `behaviour_message`
--

LOCK TABLES `behaviour_message` WRITE;
/*!40000 ALTER TABLE `behaviour_message` DISABLE KEYS */;
INSERT INTO `behaviour_message` VALUES (9,3,46,'Hi Dr New, Cerys has been given 1 behaviour points. We appreciate your support with her behaviour in school.','2022-03-20 18:02:39'),(10,3,47,'Hi Dr New, Cerys has been given 1 behaviour points. We appreciate your support with her behaviour in school.','2022-03-20 18:02:39'),(11,3,48,'Hi Dr New, Cerys has been given 1 behaviour points. We appreciate your support with her behaviour in school.','2022-03-20 18:02:39'),(12,3,49,'Hi Dr New, Cerys has been given 1 behaviour points. We appreciate your support with her behaviour in school.','2022-03-20 18:02:39'),(13,12,50,'Hi Mr Wilson, Jack has been given 2 behaviour points. We appreciate your support with his behaviour in school.','2022-03-20 18:02:39'),(14,12,51,'Hi Mr Wilson, Jack has been given 1 behaviour points. We appreciate your support with his behaviour in school.','2022-03-20 18:02:39'),(15,12,52,'Hi Mr Wilson, Jack has been given 1 behaviour points. We appreciate your support with his behaviour in school.','2022-03-20 18:02:39'),(16,28,53,'Hi Ms Bennett, Oliver has been given 2 behaviour points. We appreciate your support with his behaviour in school.','2022-03-20 18:03:38'),(17,3,54,'Hi Dr New, Cerys has been given 1 behaviour points. We appreciate your support with her behaviour in school.','2022-03-20 19:17:33'),(18,10,55,'Hi Mr Davies, Lily has been given 2 behaviour points. We appreciate your support with her behaviour in school.','2022-03-20 19:17:41'),(19,21,56,'Hi Mr Lawrence, Bella has been given 1 behaviour points. We appreciate your support with her behaviour in school.','2022-03-20 19:17:52'),(20,15,57,'Hi Mr Sulyman, Emaan has been given 1 behaviour points. We appreciate your support with her behaviour in school.','2022-03-20 19:17:58'),(21,18,58,'Hi Mr Ashbee, Rain has been given 1 behaviour points. We appreciate your support with her behaviour in school.','2022-03-20 19:18:06'),(22,18,59,'Hi Mr Ashbee, Rain has been given 1 behaviour points. We appreciate your support with her behaviour in school.','2022-03-20 19:18:29'),(23,3,60,'Hi Dr New, Cerys has been given 2 behaviour points. We appreciate your support with her behaviour in school.','2022-03-20 19:35:23'),(24,3,61,'Hi Dr New, Cerys has been given 1 behaviour points. We appreciate your support with her behaviour in school.','2022-03-20 19:35:30'),(25,11,62,'Hi Ms Young, Alice has been given 2 behaviour points. We appreciate your support with her behaviour in school.','2022-03-20 19:40:00'),(26,11,63,'Hi Ms Young, Alice has been given 1 behaviour points. We appreciate your support with her behaviour in school.','2022-03-20 19:43:46'),(27,11,64,'Hi Ms Young, Alice has been given 1 behaviour points. We appreciate your support with her behaviour in school.','2022-03-20 19:43:51'),(28,11,65,'Hi Ms Young, Alice has been given 1 behaviour points. We appreciate your support with her behaviour in school.','2022-03-20 19:43:52');
/*!40000 ALTER TABLE `behaviour_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `behaviour_profile`
--

DROP TABLE IF EXISTS `behaviour_profile`;
/*!50001 DROP VIEW IF EXISTS `behaviour_profile`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `behaviour_profile` AS SELECT 
 1 AS `student_name`,
 1 AS `total_behaviour_points`,
 1 AS `is_vulnerable`,
 1 AS `number_of_incidents`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `eal_status`
--

DROP TABLE IF EXISTS `eal_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `eal_status` (
  `student_ID` int DEFAULT NULL,
  `EAL` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  KEY `fk_eal_s_ID_idx` (`student_ID`),
  CONSTRAINT `fk_eal_s_ID` FOREIGN KEY (`student_ID`) REFERENCES `students_names` (`student_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eal_status`
--

LOCK TABLES `eal_status` WRITE;
/*!40000 ALTER TABLE `eal_status` DISABLE KEYS */;
INSERT INTO `eal_status` VALUES (1,'N'),(2,'N'),(3,'N'),(4,'N'),(5,'N'),(6,'N'),(7,'N'),(8,'N'),(9,'N'),(10,'N'),(11,'N'),(12,'N'),(13,'N'),(14,'N'),(15,'Y'),(16,'N'),(17,'Y'),(18,'N'),(19,'N'),(20,'Y'),(21,'N'),(22,'N'),(23,'N'),(24,'N'),(25,'N'),(26,'N'),(27,'N'),(28,'N'),(29,'Y'),(30,'N'),(31,'N');
/*!40000 ALTER TABLE `eal_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `home_contact`
--

DROP TABLE IF EXISTS `home_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `home_contact` (
  `student_ID` int NOT NULL,
  `parental_contact` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `home_email` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `home_phone` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  KEY `fk_home_s_ID_idx` (`student_ID`),
  CONSTRAINT `fk_home_s_ID` FOREIGN KEY (`student_ID`) REFERENCES `students_names` (`student_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `home_contact`
--

LOCK TABLES `home_contact` WRITE;
/*!40000 ALTER TABLE `home_contact` DISABLE KEYS */;
INSERT INTO `home_contact` VALUES (1,'Mrs Buss','buss1@gmail.com','077 8116 9010'),(2,'Mr Biggs','thebiggsfamily@hotmail.co.uk','077 2640 6244'),(3,'Dr New','new1992@gmail.com','079 0093 5219'),(4,'Ms Dylan','heyheydylan@outlook.com','070 4732 3377'),(5,'Mr Knowles','knowitall@gmail.com','078 6018 4362'),(6,'Dr Bailey','drbailey00@hotmail.co.uk','070 6548 7844'),(7,'Ms Jackson','jackson5@outlook.com','079 6312 1355'),(8,'Mr Dunton','jayinthecountry@hotmail.com','077 2438 7466'),(9,'Ms Stone','setinstone88@gmail.com','077 4212 7545'),(10,'Mr Davies','davies@hotmail.co.uk','078 6394 0790'),(11,'Ms Young','wwwhiyoung@hotmail.co.uk','078 2644 6932'),(12,'Mr Wilson','anthonyandjulia@outlook.com','070 7511 5767'),(13,'Dr Falconer','falconerstudio@icloud.com','078 3232 5471'),(14,'Mrs Baker','bakerfamily3@gmail.com','077 4579 2839'),(15,'Mr Sulyman','suly00001@hotmail.co.uk','070 7982 1674'),(16,'Mr Dunton','jayinthecountry@hotmail.com','079 5704 2387'),(17,'Mrs Gueye','gueguegue@outlook.com','077 5275 5678'),(18,'Mr Ashbee','miaashbee001@gmail.com','079 1711 4146'),(19,'Mrs Driscoll','driscollgirls@hotmail.com','070 0865 2630'),(20,'Mr Staffold','staffoldandsons@hotmail.co.uk','077 1242 9108'),(21,'Mr Lawrence','trayboo@gmail.com','077 6389 8107'),(22,'Mr Swanson','londonpals23@hotmail.co.uk','077 0447 2206'),(23,'Ms Hoffman','ciarahoffman86@gmail.com','079 8999 0731'),(24,'Mrs Norman','lauranorman001@outlook.com','070 4084 4341'),(25,'Dr Cox','drcoxmedical@hotmail.com','077 2270 6677'),(26,'Ms Collins','laylacolling@gmail.com','078 2288 9120'),(27,'Mr Duncan','familyinbrizzle@outlook.com','070 3152 8092'),(28,'Ms Bennett','bennettfamily@hotmail.co.uk','078 2965 6009'),(29,'Mr Bukenya','mililobukenya@gmail.com','078 6548 8107'),(30,'Mrs Allan','jayallan@icloud.com','078 7727 8311'),(31,'Ms Blackburn','blackburns00@hotmail.com','070 6866 1541');
/*!40000 ALTER TABLE `home_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lac_status`
--

DROP TABLE IF EXISTS `lac_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lac_status` (
  `student_ID` int DEFAULT NULL,
  `LAC` text,
  KEY `fk_lac_s_ID_idx` (`student_ID`),
  CONSTRAINT `fk_lac_s_ID` FOREIGN KEY (`student_ID`) REFERENCES `students_names` (`student_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lac_status`
--

LOCK TABLES `lac_status` WRITE;
/*!40000 ALTER TABLE `lac_status` DISABLE KEYS */;
INSERT INTO `lac_status` VALUES (1,'N'),(2,'N'),(3,'N'),(4,'N'),(5,'N'),(6,'N'),(7,'N'),(8,'N'),(9,'N'),(10,'N'),(11,'Y'),(12,'N'),(13,'N'),(14,'N'),(15,'N'),(16,'N'),(17,'N'),(18,'N'),(19,'N'),(20,'N'),(21,'N'),(22,'N'),(23,'N'),(24,'N'),(25,'N'),(26,'N'),(27,'N'),(28,'N'),(29,'N'),(30,'N'),(31,'Y');
/*!40000 ALTER TABLE `lac_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pp_status`
--

DROP TABLE IF EXISTS `pp_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pp_status` (
  `student_ID` int DEFAULT NULL,
  `PP` text,
  KEY `fk_pp_s_ID_idx` (`student_ID`),
  CONSTRAINT `fk_pp_s_ID` FOREIGN KEY (`student_ID`) REFERENCES `students_names` (`student_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pp_status`
--

LOCK TABLES `pp_status` WRITE;
/*!40000 ALTER TABLE `pp_status` DISABLE KEYS */;
INSERT INTO `pp_status` VALUES (1,'Y'),(2,'N'),(3,'N'),(4,'N'),(5,'N'),(6,'N'),(7,'N'),(8,'N'),(9,'N'),(10,'N'),(11,'Y'),(12,'Y'),(13,'N'),(14,'Y'),(15,'N'),(16,'N'),(17,'Y'),(18,'Y'),(19,'N'),(20,'N'),(21,'N'),(22,'N'),(23,'N'),(24,'Y'),(25,'N'),(26,'N'),(27,'N'),(28,'N'),(29,'N'),(30,'Y'),(31,'Y');
/*!40000 ALTER TABLE `pp_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `previous_school_data`
--

DROP TABLE IF EXISTS `previous_school_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `previous_school_data` (
  `student_ID` int DEFAULT NULL,
  `previous_school` text NOT NULL,
  `CAT_ID` int NOT NULL,
  `CAT_score` int DEFAULT NULL,
  PRIMARY KEY (`CAT_ID`),
  KEY `fk_primary_s_ID_idx` (`student_ID`),
  CONSTRAINT `fk_primary_s_ID` FOREIGN KEY (`student_ID`) REFERENCES `students_names` (`student_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `previous_school_data`
--

LOCK TABLES `previous_school_data` WRITE;
/*!40000 ALTER TABLE `previous_school_data` DISABLE KEYS */;
INSERT INTO `previous_school_data` VALUES (22,'Cabot_Primary_School',987,120),(24,'Hotwells_Primary_School',1083,112),(25,'Henleaze_Junior_School',1087,111),(23,'The_Dolphin_School',2103,105),(7,'Cotham_Gardens_Primary_School',2132,90),(20,'Henleaze_Junior_School',2236,101),(21,'Cabot_Primary_School',2344,120),(4,'Cabot_Primary_School',2454,91),(2,'Cotham_Gardens_Primary_School',2973,113),(9,'Henleaze_Junior_School',3244,114),(31,'Cabot_Primary_School',3245,115),(8,'Henleaze_Junior_School',3254,97),(29,'Cabot_Primary_School',4037,123),(17,'The_Dolphin_School',4235,126),(12,'Henleaze_Junior_School',4536,112),(15,'Hotwells_Primary_School',4564,105),(10,'Hotwells_Primary_School',5476,104),(5,'Hotwells_Primary_School',5645,120),(19,'Cabot_Primary_School',6554,103),(16,'Henleaze_Junior_School',6575,114),(30,'Cotham_Gardens_Primary_School',6651,95),(13,'Cotham_Gardens_Primary_School',6763,110),(26,'Henleaze_Junior_School',6854,101),(11,'Hotwells_Primary_School',7564,93),(6,'The_Dolphin_School',7665,110),(14,'The_Dolphin_School',7799,99),(27,'The_Dolphin_School',8425,91),(28,'The_Dolphin_School',8436,123),(18,'Cotham_Gardens_Primary_School',8766,0),(3,'Henleaze_Junior_School',9623,104),(1,'Henleaze_Junior_School',9743,91);
/*!40000 ALTER TABLE `previous_school_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sas_data`
--

DROP TABLE IF EXISTS `sas_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sas_data` (
  `student_ID` int NOT NULL,
  `SAS_ID` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `SAS_maths` int DEFAULT NULL,
  `SAS_reading` int DEFAULT NULL,
  PRIMARY KEY (`SAS_ID`),
  KEY `fk_sas_s_ID_idx` (`student_ID`),
  CONSTRAINT `fk_sas_s_ID` FOREIGN KEY (`student_ID`) REFERENCES `students_names` (`student_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sas_data`
--

LOCK TABLES `sas_data` WRITE;
/*!40000 ALTER TABLE `sas_data` DISABLE KEYS */;
INSERT INTO `sas_data` VALUES (6,'ab63',112,93),(17,'ag77',0,124),(5,'ak86',101,126),(11,'ay44',95,92),(30,'ba11',82,79),(21,'bl05',116,113),(24,'bn39',117,100),(9,'ch87',100,107),(3,'cn55',111,120),(7,'eb76',92,91),(14,'eb93',91,94),(15,'es56',98,115),(26,'fc69',114,127),(25,'jc59',119,121),(4,'jd08',79,69),(12,'jw33',108,103),(23,'kh62',95,110),(2,'lb73',116,123),(10,'ld02',0,69),(8,'ld28',109,113),(1,'mb37',92,104),(29,'mb47',122,124),(16,'md17',127,116),(27,'md47',86,119),(28,'ob49',115,121),(18,'ra34',0,0),(13,'rf64',111,127),(20,'rs84',122,110),(31,'sb39',120,106),(19,'wd94',98,112),(22,'zs66',119,118);
/*!40000 ALTER TABLE `sas_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `send_status`
--

DROP TABLE IF EXISTS `send_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `send_status` (
  `student_ID` int DEFAULT NULL,
  `SEND` text,
  KEY `fk_send_s_ID_idx` (`student_ID`),
  CONSTRAINT `fk_send_s_ID` FOREIGN KEY (`student_ID`) REFERENCES `students_names` (`student_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `send_status`
--

LOCK TABLES `send_status` WRITE;
/*!40000 ALTER TABLE `send_status` DISABLE KEYS */;
INSERT INTO `send_status` VALUES (1,'N'),(2,'N'),(3,'N'),(4,'N'),(5,'N'),(6,'N'),(7,'N'),(8,'N'),(9,'N'),(10,'E'),(11,'K'),(12,'N'),(13,'N'),(14,'N'),(15,'N'),(16,'N'),(17,'N'),(18,'N'),(19,'N'),(20,'N'),(21,'N'),(22,'N'),(23,'N'),(24,'K'),(25,'N'),(26,'K'),(27,'K'),(28,'N'),(29,'N'),(30,'K'),(31,'K');
/*!40000 ALTER TABLE `send_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `student_details`
--

DROP TABLE IF EXISTS `student_details`;
/*!50001 DROP VIEW IF EXISTS `student_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `student_details` AS SELECT 
 1 AS `student_name`,
 1 AS `gender_at_birth`,
 1 AS `eal`,
 1 AS `lac`,
 1 AS `pp`,
 1 AS `send`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `students_gender`
--

DROP TABLE IF EXISTS `students_gender`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students_gender` (
  `student_ID` int NOT NULL,
  `gender_at_birth` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  KEY `fk_gender_s_ID_idx` (`student_ID`),
  CONSTRAINT `fk_gender_s_ID` FOREIGN KEY (`student_ID`) REFERENCES `students_names` (`student_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students_gender`
--

LOCK TABLES `students_gender` WRITE;
/*!40000 ALTER TABLE `students_gender` DISABLE KEYS */;
INSERT INTO `students_gender` VALUES (1,'F'),(2,'F'),(3,'F'),(4,'M'),(5,'M'),(6,'F'),(7,'M'),(8,'F'),(9,'F'),(10,'F'),(11,'F'),(12,'M'),(13,'M'),(14,'F'),(15,'F'),(16,'M'),(17,'F'),(18,'F'),(19,'F'),(20,'F'),(21,'F'),(22,'M'),(23,'M'),(24,'F'),(25,'M'),(26,'F'),(27,'M'),(28,'M'),(29,'M'),(30,'F'),(31,'F');
/*!40000 ALTER TABLE `students_gender` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students_names`
--

DROP TABLE IF EXISTS `students_names`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students_names` (
  `student_ID` int NOT NULL,
  `first_name` text,
  `last_name` text,
  PRIMARY KEY (`student_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students_names`
--

LOCK TABLES `students_names` WRITE;
/*!40000 ALTER TABLE `students_names` DISABLE KEYS */;
INSERT INTO `students_names` VALUES (1,'Martha','Buss'),(2,'Lily','Biggs'),(3,'Cerys','New'),(4,'Jonathan','Dylan'),(5,'Alex','Knowles'),(6,'Alice','Bailey'),(7,'Ethan','Brodie'),(8,'Layla','Dunton'),(9,'Charlotte','Huges'),(10,'Lily','Davies'),(11,'Alice','Young'),(12,'Jack','Wilson'),(13,'River','Falconer'),(14,'Elodie','Baker'),(15,'Emaan','Sulyman'),(16,'Michael','Dunton'),(17,'Alysha','Gueye'),(18,'Rain','Ashbee'),(19,'Willow','Driscoll'),(20,'Raeya','Staffold'),(21,'Bella','Lawrence'),(22,'Zan','Swanson'),(23,'Kohi','Hoffman'),(24,'Bella','Norman'),(25,'Jenson','Cox'),(26,'Faith','Collins'),(27,'Martin','Duncan'),(28,'Oliver','Bennett'),(29,'Malick','Bukenya'),(30,'Beatrice','Allan'),(31,'Sophie','Blackburn');
/*!40000 ALTER TABLE `students_names` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'year_7_project'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `delete_message_records` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = '' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`localhost`*/ /*!50106 EVENT `delete_message_records` ON SCHEDULE EVERY 1 DAY STARTS '2022-03-17 20:01:17' ON COMPLETION PRESERVE ENABLE DO DELETE FROM Year7Class.behaviour_message WHERE start_time < DATE_SUB(NOW(), 
INTERVAL 1 DAY) */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'year_7_project'
--
/*!50003 DROP FUNCTION IF EXISTS `is_vulnerable` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `is_vulnerable`(LAC VARCHAR (1), SEND VARCHAR(1)) RETURNS varchar(20) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE is_vulnerable VARCHAR(20);
    IF LAC = 'Y' 
    OR SEND = 'Y' THEN
        SET is_vulnerable = 'Y';
	ELSE 
    SET is_vulnerable = 'N';
    END IF;
    RETURN (is_vulnerable);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `reading_level` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `reading_level`(sas_reading INT) RETURNS varchar(20) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE reading_level VARCHAR(20);

    IF sas_reading >= 120 THEN
		SET reading_level = 'GOLD';
    ELSEIF (sas_reading < 120 AND 
			sas_reading >= 100) THEN
        SET reading_level = 'SILVER';
    ELSEIF sas_reading < 100 THEN
        SET reading_level = 'BRONZE';
    END IF;
	RETURN (reading_level);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `student_pronoun` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `student_pronoun`(gender_at_birth VARCHAR (1)) RETURNS varchar(10) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE pronoun VARCHAR(10);

    IF gender_at_birth = 'M' THEN
		SET pronoun = 'his';
    ELSEIF gender_at_birth = 'F' THEN
        SET pronoun = 'her';
    ELSE 
        SET pronoun = 'their';
    END IF;
	RETURN (pronoun);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_AIM_students` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_AIM_students`()
BEGIN
SELECT CONCAT (first_name, " ", last_name) AS AIM_candidate, CAT_score, sas_maths, sas_reading
FROM students_names s
INNER JOIN previous_school_data p
ON s.student_ID = p.student_ID
INNER JOIN sas_data sas
ON p.student_ID = sas.student_ID
WHERE CAT_score > 120 OR (sas_maths + sas_reading) >=240
ORDER BY CAT_score DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `behaviour_profile`
--

/*!50001 DROP VIEW IF EXISTS `behaviour_profile`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `behaviour_profile` AS select concat(`s`.`first_name`,' ',`s`.`last_name`) AS `student_name`,sum(`bm`.`behaviour_points`) AS `total_behaviour_points`,`is_vulnerable`(`lac`.`LAC`,`send`.`SEND`) AS `is_vulnerable`,count(`bm`.`incident_type`) AS `number_of_incidents` from (((`students_names` `s` join `behaviour_management` `bm` on((`s`.`student_ID` = `bm`.`student_ID`))) join `send_status` `send` on((`send`.`student_ID` = `bm`.`student_ID`))) join `lac_status` `lac` on((`lac`.`student_ID` = `send`.`student_ID`))) group by `bm`.`student_ID` order by `student_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `student_details`
--

/*!50001 DROP VIEW IF EXISTS `student_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `student_details` AS select concat(`s`.`first_name`,' ',`s`.`last_name`) AS `student_name`,`g`.`gender_at_birth` AS `gender_at_birth`,`e`.`EAL` AS `eal`,`lac`.`LAC` AS `lac`,`pp`.`PP` AS `pp`,`send`.`SEND` AS `send` from (((((`students_names` `s` join `students_gender` `g` on((`g`.`student_ID` = `s`.`student_ID`))) join `eal_status` `e` on((`e`.`student_ID` = `g`.`student_ID`))) join `pp_status` `pp` on((`pp`.`student_ID` = `e`.`student_ID`))) join `send_status` `send` on((`send`.`student_ID` = `e`.`student_ID`))) join `lac_status` `lac` on((`lac`.`student_ID` = `send`.`student_ID`))) order by concat(`s`.`first_name`,' ',`s`.`last_name`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-20 19:51:59
