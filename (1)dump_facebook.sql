-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: localhost    Database: facebook2
-- ------------------------------------------------------
-- Server version	8.0.18

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
-- Table structure for table `_group`
--

DROP TABLE IF EXISTS `_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_group` (
  `group_id` varchar(10) NOT NULL,
  `group_name` varchar(20) DEFAULT NULL,
  `permission` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_group`
--

LOCK TABLES `_group` WRITE;
/*!40000 ALTER TABLE `_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `comment_id` varchar(10) NOT NULL,
  `post_id` varchar(10) NOT NULL,
  `user_id` varchar(10) NOT NULL,
  `commenter_id` varchar(10) NOT NULL,
  `date` decimal(8,0) DEFAULT NULL,
  `text` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`comment_id`,`commenter_id`,`post_id`,`user_id`),
  KEY `post_id` (`post_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`),
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES ('000','01','1','0',20191103,'ㅎㅎ 밥이라두 얻어먹어야지'),('000','00','0','1',20191103,'와 이클래스에 있는 문제 안풀어봤어? 거기서 많이 나왔는데!'),('000','00','1','1',20191103,'오예 밥이다 밥!!ㅋㅋ'),('001','01','1','1',20191103,'ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ'),('001','00','0','2',20191103,'나두 안풀어봤는데... 아쉽다!'),('002','01','1','2',20191103,'몇점받았는데 망했다고하냐!');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follower`
--

DROP TABLE IF EXISTS `follower`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follower` (
  `user_id` varchar(10) NOT NULL,
  `follower_id` varchar(10) NOT NULL,
  PRIMARY KEY (`user_id`,`follower_id`),
  CONSTRAINT `follower_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follower`
--

LOCK TABLES `follower` WRITE;
/*!40000 ALTER TABLE `follower` DISABLE KEYS */;
/*!40000 ALTER TABLE `follower` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `following`
--

DROP TABLE IF EXISTS `following`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `following` (
  `user_id` varchar(10) NOT NULL,
  `following_id` varchar(10) NOT NULL,
  PRIMARY KEY (`user_id`,`following_id`),
  CONSTRAINT `following_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `following`
--

LOCK TABLES `following` WRITE;
/*!40000 ALTER TABLE `following` DISABLE KEYS */;
/*!40000 ALTER TABLE `following` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `like_id` varchar(10) NOT NULL,
  `post_id` varchar(10) NOT NULL,
  `user_id` varchar(10) NOT NULL,
  `liker_id` varchar(10) NOT NULL,
  PRIMARY KEY (`like_id`,`liker_id`,`post_id`,`user_id`),
  KEY `post_id` (`post_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`),
  CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES ('0000','00','1','0'),('0000','00','2','0'),('0000','00','0','1'),('0000','00','1','1'),('0001','00','2','1'),('0002','00','2','2');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message` (
  `msg_id` varchar(10) NOT NULL,
  `text` varchar(100) DEFAULT NULL,
  `location` varchar(30) DEFAULT NULL,
  `date` decimal(8,0) DEFAULT NULL,
  PRIMARY KEY (`msg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `post_id` varchar(10) NOT NULL,
  `user_id` varchar(10) NOT NULL,
  `date` decimal(8,0) DEFAULT NULL,
  `location` varchar(30) DEFAULT NULL,
  `contents` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`post_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES ('00','0',20191102,'6120호','아 진짜 이클래스 왜 안봤지? 후회된다 ㅜㅜ'),('00','1',20191102,'6120호','아 오늘 시험 인간적으로 너무 쉬웠따.. 밥은 내가 산다.. 빠끄!'),('00','2',20191103,'천호 어딘가','아.. 길거리에서 잤다.. 눈 떠보니 거리더라... 빠끄!!'),('01','1',20191103,'장충동 어딘가','아.. 시험 개망했다 얻어먹어야지.. 빠끄!!');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` varchar(10) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `birth` decimal(8,0) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `address` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('0','손준영',19950320,'01041528014','남자','동대문구 신설동 난계로 30길'),('1','유지훈',19960311,'01057666393','남자','중구 장충동 2가'),('2','박현태',19970111,'01030052005','남자','중구 신공학관 6120');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_group`
--

DROP TABLE IF EXISTS `user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_group` (
  `group_id` varchar(10) NOT NULL,
  `user_id` varchar(10) NOT NULL,
  PRIMARY KEY (`group_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_group_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `_group` (`group_id`),
  CONSTRAINT `user_group_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_group`
--

LOCK TABLES `user_group` WRITE;
/*!40000 ALTER TABLE `user_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_message`
--

DROP TABLE IF EXISTS `user_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_message` (
  `msg_id` varchar(10) NOT NULL,
  `user_id` varchar(10) NOT NULL,
  PRIMARY KEY (`msg_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_message_ibfk_1` FOREIGN KEY (`msg_id`) REFERENCES `message` (`msg_id`),
  CONSTRAINT `user_message_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_message`
--

LOCK TABLES `user_message` WRITE;
/*!40000 ALTER TABLE `user_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_message` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-24 15:23:32
