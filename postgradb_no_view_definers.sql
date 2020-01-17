-- MariaDB dump 10.17  Distrib 10.4.10-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: postgradb
-- ------------------------------------------------------
-- Server version	10.4.10-MariaDB-1:10.4.10+maria~xenial-log

DROP SCHEMA IF EXISTS `postgradb`;
CREATE SCHEMA `postgradb`;
USE `postgradb`;

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
-- Table structure for table `Course`
--

DROP TABLE IF EXISTS `Course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Course` (
  `courseID` char(6) NOT NULL,
  `name` varchar(36) NOT NULL,
  `ects` int(10) unsigned NOT NULL,
  PRIMARY KEY (`courseID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Course`
--

LOCK TABLES `Course` WRITE;
/*!40000 ALTER TABLE `Course` DISABLE KEYS */;
INSERT INTO `Course` VALUES ('DM9471','Data Mining',4),('EN2345','English Language',5),('FC3938','Financial Calculus',2),('LA4561','Business Associations',4),('LA7659','Immigration Law and Policy',3),('LA7688','Conflict of Laws',3),('ML1339','Applied Machine Learning',5),('TH9803','Statistical Theory',3);
/*!40000 ALTER TABLE `Course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Department`
--

DROP TABLE IF EXISTS `Department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Department` (
  `departmentID` int(11) NOT NULL,
  `name` varchar(36) NOT NULL,
  `webpage` varchar(45) DEFAULT NULL,
  `academic_field` varchar(36) NOT NULL,
  `university_id` varchar(6) NOT NULL,
  PRIMARY KEY (`departmentID`,`university_id`),
  KEY `university_id_idx` (`university_id`),
  CONSTRAINT `university_id` FOREIGN KEY (`university_id`) REFERENCES `University` (`universityID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Department`
--

LOCK TABLES `Department` WRITE;
/*!40000 ALTER TABLE `Department` DISABLE KEYS */;
INSERT INTO `Department` VALUES (7,'Informatics','csd.auth.gr','Sciences','AUTH'),(18,'Nanoengineering','nanoeng.twente.nl','Engineering','UT'),(32,'Mathematics','maths.uow.edu.au','Sciences','UOW'),(34,'Psychology','psy.essex.ac.uk','Philosophy','ESSEX'),(67,'Mathematics','maths.ox.ac.uk','Sciences','OX'),(89,'Electrical & Computer Engineering','ee.duth.gr','Engineering','DUTH'),(94,'Law','law.eur.nl','Law','EUR'),(95,'Mechanical Engineering','meng.auth.gr','Engineering','AUTH'),(101,'Law','law.auth.gr','Law','AUTH'),(107,'Management','economics.marburg.de','Economics','MAR'),(121,'Dentistry','med.kuleuven.be','Health Sciences','KU'),(184,'Electrical & Computer Engineering','ee.auth.gr','Engineering','AUTH'),(230,'History & Archaeology','hist.auth.gr','Philosophy','AUTH');
/*!40000 ALTER TABLE `Department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Likes`
--

DROP TABLE IF EXISTS `Likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Likes` (
  `user__id` int(11) NOT NULL,
  `ID_program` char(5) NOT NULL,
  PRIMARY KEY (`user__id`,`ID_program`),
  KEY `program_id_idx` (`ID_program`),
  CONSTRAINT `ID_program` FOREIGN KEY (`ID_program`) REFERENCES `Program` (`programID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user__id` FOREIGN KEY (`user__id`) REFERENCES `User` (`userID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Likes`
--

LOCK TABLES `Likes` WRITE;
/*!40000 ALTER TABLE `Likes` DISABLE KEYS */;
INSERT INTO `Likes` VALUES (23,'CP234'),(34,'OD781'),(234,'LC239'),(234,'LE177'),(234,'LP179'),(670,'CS212'),(670,'EE004'),(670,'RB592'),(4667,'CP234');
/*!40000 ALTER TABLE `Likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Program`
--

DROP TABLE IF EXISTS `Program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Program` (
  `programID` char(5) NOT NULL,
  `name` varchar(36) NOT NULL,
  `duration` int(10) unsigned NOT NULL,
  `number_of_students` int(10) unsigned DEFAULT NULL,
  `attendancy` enum('Mandatory','Optional','Distance Learning') DEFAULT 'Mandatory',
  `applications_deadline` char(10) DEFAULT NULL,
  `fees` int(10) unsigned DEFAULT 0,
  `description` varchar(500) DEFAULT NULL,
  `department_id` int(11) NOT NULL,
  PRIMARY KEY (`programID`),
  KEY `department_id_idx` (`department_id`),
  CONSTRAINT `department_id` FOREIGN KEY (`department_id`) REFERENCES `Department` (`departmentID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Program`
--

LOCK TABLES `Program` WRITE;
/*!40000 ALTER TABLE `Program` DISABLE KEYS */;
INSERT INTO `Program` VALUES ('AI336','Artificial Intelligence',6,15,'Mandatory','30-12-2019',10000,'The core topics in the program \"Artificial Intelligence\" are: autonomous perceptive systems, cognitive robotics and multi-agent systems.',184),('AS673','Applied Archaeological Sciences',2,20,'Mandatory','01-09-2019',6300,'The MSc in Applied Archaeological Sciences is designed in order to provide the necessary knowledge and expertise to students, researchers, managers and leaders of the Cultural Heritage sector. The program is an original combination of modern concept and needs for identification, documentation, maintenance, rescue and diffusion of at risk world heritage.',230),('CP234','Criminal Psychology',4,20,'Distance Learning','05-04-2020',6442,'Develop your skills in leading complex criminal investigations, improve your skills in making reasoned arguments and rational decisions, and deepen your understanding of a range of key criminological theories, practices and perspectives in order to improve your potential impact within a policing, prison, probation or other criminal justice.',34),('CS212','Software Engineering',5,20,'Optional','20-02-2020',8000,'The MSc in Software Engineering teaches the principles of modern software engineering, together with the tools, methods and techniques that support their application. It offers working professionals the opportunity to learn more about the technological advances that are changing their lives, through a course of part-time study.',89),('EE004','Nanotechnology',4,25,'Optional','28-08-2019',20000,'The MSc in Nanotechnology at University of Twente (UT) focuses on the design, creation and study of functional materials, structures, devices and systems by directly controlling matter on the nanometre scale and is for anyone interested in the exciting and upcoming field of nanoscience and nanoengineering.',18),('LC239','Construction Law',6,25,'Optional','01-05-2020',9000,'The construction industry increasingly recognises the importance of resolving disputes efficiently and quickly in order to maintain commercial relationships and keep cash flowing within the industry. If you are a professional working in construction, law or a related field, this program will develop your ability to resolve disputes.',101),('LE177','European Master in Law & Economics',4,12,'Mandatory','01-03-2020',7500,'EMLE synthesizes law and economics together into a programme that is both manageable in its structure and innovative in its design. This programme creates an atmosphere of internationality through its students and its universities, which provides both a learning experience for its scholars and a desirable trait for future employers. The combination of law and economics fosters an atmosphere of idea sharing and introduces different techniques for examining and handling problems.',94),('LP179','Law & Politics in EU',3,30,'Distance Learning','10-01-2020',0,'The Program aims to provide the opportunity for bi-scientific approach, deepen and sharpen the cognitive module which consists of the subjects / fields of the State and of European Law, Political Theory, Political Science, International and European Studies and others objects included in the broader field of political science.',101),('OD781','Forensic Odontology',2,50,'Mandatory','15-12-2019',9150,'The aims of the program are to provide you with thorough knowledge and practical skills in the field of forensic odontology. While no single case is alike and many cases are difficult to prepare for, the programme provides a sound and scientific foundation on which you can rely in your future career. The KU Leuven Master’s Programme of Forensic Odontology is one of the few programmes of its kind in the world. ',121),('RB592','Robotics',4,18,'Mandatory','01-04-2020',6000,'The MSc in Robotics will provide you with the ability to understand, design and implement modern robotic systems. Robotics is increasingly prominent in a variety of sectors (eg manufacturing, health and remote exploration of hostile environments such as space and the deep sea) and as autonomous and semi-autonomous systems that interact with people physically and socially',7),('ST029','Statistics',4,15,'Optional','31-03-2020',20770,'The Master of Statistics offered by the University of Wollongong is designed for candidates holding a Bachelor degree with a minor (or major) in mathematics or statistics. This program is designed to upgrade statistical skills and to educate students to undertake advanced statistical work in industry, commerce or government, including the ability to communicate effectively with others.',32),('ST404','Statistics',5,30,'Mandatory','01-06-2020',9000,'This program provides specialized knowledge at postgraduate level to graduates of Greek and foreign Universities in the basic fields of Statistics and Probability.',67);
/*!40000 ALTER TABLE `Program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Program_has_Course`
--

DROP TABLE IF EXISTS `Program_has_Course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Program_has_Course` (
  `program___id` char(5) NOT NULL,
  `course_id` char(6) NOT NULL,
  PRIMARY KEY (`program___id`,`course_id`),
  KEY `course_id_idx` (`course_id`),
  CONSTRAINT `course_id` FOREIGN KEY (`course_id`) REFERENCES `Course` (`courseID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `program___id` FOREIGN KEY (`program___id`) REFERENCES `Program` (`programID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Program_has_Course`
--

LOCK TABLES `Program_has_Course` WRITE;
/*!40000 ALTER TABLE `Program_has_Course` DISABLE KEYS */;
INSERT INTO `Program_has_Course` VALUES ('LP179','EN2345'),('LP179','LA7659'),('LP179','LA7688'),('ST029','DM9471'),('ST029','FC3938'),('ST029','TH9803');
/*!40000 ALTER TABLE `Program_has_Course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Program_prerequisites`
--

DROP TABLE IF EXISTS `Program_prerequisites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Program_prerequisites` (
  `program__id` char(5) NOT NULL,
  `prerequisites` varchar(120) NOT NULL,
  PRIMARY KEY (`program__id`,`prerequisites`),
  CONSTRAINT `program__id` FOREIGN KEY (`program__id`) REFERENCES `Program` (`programID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Program_prerequisites`
--

LOCK TABLES `Program_prerequisites` WRITE;
/*!40000 ALTER TABLE `Program_prerequisites` DISABLE KEYS */;
INSERT INTO `Program_prerequisites` VALUES ('EE004','Certificate of English Language (C2)'),('EE004','Degree grade over 7.5'),('EE004','Degree in Nanoengineering'),('OD781','Degree in Dentistry'),('OD781','Letter of Recommendation'),('ST029','Degree in Mathematics or Finance'),('ST029','Letter of Recommendation');
/*!40000 ALTER TABLE `Program_prerequisites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reviews`
--

DROP TABLE IF EXISTS `Reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Reviews` (
  `user_id` int(11) NOT NULL,
  `IDprogram` char(5) NOT NULL,
  `grade` int(10) unsigned NOT NULL,
  `comment` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`IDprogram`),
  KEY `program_id_idx` (`IDprogram`),
  CONSTRAINT `IDprogram` FOREIGN KEY (`IDprogram`) REFERENCES `Program` (`programID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `User` (`userID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reviews`
--

LOCK TABLES `Reviews` WRITE;
/*!40000 ALTER TABLE `Reviews` DISABLE KEYS */;
INSERT INTO `Reviews` VALUES (20,'AS673',8,'Really good. Except the accommodation cooking facilities. The uni has a lot of facilities such as the study lounge, my friends and I love going there of an evening to watch TV!'),(34,'OD781',9,'The lecturers are fantastic and very well structured, I enjoyed every single one. Professors are awesome as well, willing to help. Facilities fine.'),(67,'EE004',10,'Best time of my life getting to know so many people from different nationalities. Making friendships for life while studying with the best teachers, who give you that attention!...Don’t want anything more..'),(456,'EE004',9,'Had some really good opportunities which I probably would not have at another uni. The campus and facilities are fantastic and lecturers are very helpful. I’m glad I am studying here.'),(670,'EE004',10,'Awesome! There was a really good atmosphere in the class, everyone willing to help. Always sunny in Thessaloniki and so many parties and night life.'),(3098,'OD781',7,'I had a hard time getting to know the university and the way teachers act. Facilities were fine and indeed I gained much knowledge but professors were hard.');
/*!40000 ALTER TABLE `Reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Scholarship`
--

DROP TABLE IF EXISTS `Scholarship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Scholarship` (
  `scholarshipID` int(11) NOT NULL,
  `type` enum('Athletic','Merit-Based','Brand Scholarship','College Scholarship','Contest Scholarship') NOT NULL,
  `amount` int(10) unsigned NOT NULL,
  `institution` varchar(36) NOT NULL,
  `applications_deadline` char(10) DEFAULT NULL,
  `program_id` char(5) NOT NULL,
  PRIMARY KEY (`scholarshipID`,`program_id`),
  KEY `program_id_idx` (`program_id`),
  CONSTRAINT `program_id` FOREIGN KEY (`program_id`) REFERENCES `Program` (`programID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Scholarship`
--

LOCK TABLES `Scholarship` WRITE;
/*!40000 ALTER TABLE `Scholarship` DISABLE KEYS */;
INSERT INTO `Scholarship` VALUES (77,'Merit-Based',25000,'Stavros Niarchos Foundation','01-01-2020','ST029'),(113,'College Scholarship',2000,'AUTH','31-01-2020','ST404'),(123,'Merit-Based',10000,'Stavros Niarchos Foundation','28-12-2019','EE004'),(125,'College Scholarship',5000,'University of Wollonong','06-05-2020','ST029'),(226,'Contest Scholarship',8000,'63th Global Management Contest','25-02-2020','OD781'),(234,'Merit-Based',20000,'Australian Government','15-04-2020','ST029'),(345,'College Scholarship',3000,'AUTH','30-01-2020','EE004');
/*!40000 ALTER TABLE `Scholarship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Scholarship_criteria`
--

DROP TABLE IF EXISTS `Scholarship_criteria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Scholarship_criteria` (
  `scholarship_id` int(11) NOT NULL,
  `programId` char(5) NOT NULL,
  `criteria` varchar(120) NOT NULL,
  PRIMARY KEY (`scholarship_id`,`programId`,`criteria`),
  KEY `programId_idx` (`programId`),
  CONSTRAINT `programId` FOREIGN KEY (`programId`) REFERENCES `Scholarship` (`program_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `scholarship_id` FOREIGN KEY (`scholarship_id`) REFERENCES `Scholarship` (`scholarshipID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Scholarship_criteria`
--

LOCK TABLES `Scholarship_criteria` WRITE;
/*!40000 ALTER TABLE `Scholarship_criteria` DISABLE KEYS */;
INSERT INTO `Scholarship_criteria` VALUES (123,'EE004','Degree grade over 8.5'),(123,'EE004','Income under 12000 per year'),(123,'EE004','Not owning any homeplace at the city of the university'),(125,'ST029','Being an international student'),(125,'ST029','Degree grade over 8'),(226,'OD781','Degree grade over 7.5'),(226,'OD781','Owning the 1st, 2nd or 3rd award in the contest'),(234,'ST029','Australian Nationality'),(234,'ST029','Degree grade over 9'),(234,'ST029','Income under 10000 per year');
/*!40000 ALTER TABLE `Scholarship_criteria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `University`
--

DROP TABLE IF EXISTS `University`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `University` (
  `universityID` varchar(6) NOT NULL,
  `name` varchar(36) NOT NULL,
  `ranking` int(10) unsigned DEFAULT NULL,
  `country` varchar(36) DEFAULT NULL,
  `city` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`universityID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `University`
--

LOCK TABLES `University` WRITE;
/*!40000 ALTER TABLE `University` DISABLE KEYS */;
INSERT INTO `University` VALUES ('AUTH','Aristotle University of Thessaloniki',724,'Greece','Thessaloniki'),('DUTH','Democritus University of Thrace',915,'Greece','Xanthi'),('ESSEX','University of Essex',251,'UK','Essex'),('ETH','ETH Zurich',10,'Switzerland','Zurich'),('EUR','Erasmus University Rotterdam',402,'Netherlands','Rotterdam'),('KU','KU Leuven University',347,'Belgium','Leuven'),('MAR','Philipps-University Marburg',583,'Germany','Marburg'),('OX','University of Oxford',4,'UK','Oxford'),('UNIC','University of Nicosia',1152,'Cyprus','Nicosia'),('UOW','University of Wollongong',217,'Australia','Wollongong'),('UT','University of Twente',419,'Netherlands','Enschede');
/*!40000 ALTER TABLE `University` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  `userID` int(11) NOT NULL,
  `name` varchar(36) NOT NULL,
  `nationality` varchar(36) DEFAULT NULL,
  `email` varchar(36) NOT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (20,'Mary Williams','English','maryy95@yahoo.uk'),(23,'Maria Papadopoulou','Greek','papadop@gmail.com'),(34,'Lucia Pelino','Italian','pelinolu@gmail.com'),(67,'Felix Bauer','Austrian','bauerfelix@gmail.com'),(234,'Harry Black','American','harry_black@gmail.com'),(456,'Elizabeth Jones','English','joneseliz2@yahoo.uk'),(670,'Friedrich Schneider','German','schneider95@yahoo.de'),(984,'Aiko Furukawa','Japanese','furukaiko@gmail.com'),(3098,'Odysseas Papas','Greek','odyssey_p@yahoo.gr'),(4667,'John Smith','American','johnsmith@yahoo.us');
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `curriculums`
--

DROP TABLE IF EXISTS `curriculums`;
/*!50001 DROP VIEW IF EXISTS `curriculums`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `curriculums` (
  `Course` tinyint NOT NULL,
  `Program` tinyint NOT NULL,
  `ID` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `programs_by_unis`
--

DROP TABLE IF EXISTS `programs_by_unis`;
/*!50001 DROP VIEW IF EXISTS `programs_by_unis`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `programs_by_unis` (
  `Msc` tinyint NOT NULL,
  `University` tinyint NOT NULL,
  `universityID` tinyint NOT NULL,
  `Semesters` tinyint NOT NULL,
  `Attendancy` tinyint NOT NULL,
  `Fees` tinyint NOT NULL,
  `Description` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `users_reviews`
--

DROP TABLE IF EXISTS `users_reviews`;
/*!50001 DROP VIEW IF EXISTS `users_reviews`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `users_reviews` (
  `Username` tinyint NOT NULL,
  `Program` tinyint NOT NULL,
  `ID` tinyint NOT NULL,
  `Grade` tinyint NOT NULL,
  `Comment` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `wishlists`
--

DROP TABLE IF EXISTS `wishlists`;
/*!50001 DROP VIEW IF EXISTS `wishlists`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `wishlists` (
  `Username` tinyint NOT NULL,
  `Program` tinyint NOT NULL,
  `ID` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `curriculums`
--

/*!50001 DROP TABLE IF EXISTS `curriculums`*/;
/*!50001 DROP VIEW IF EXISTS `curriculums`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `curriculums` AS select `Course`.`name` AS `Course`,`Program`.`name` AS `Program`,`Program`.`programID` AS `ID` from ((`Program` join `Program_has_Course` on(`Program`.`programID` = `Program_has_Course`.`program___id`)) join `Course` on(`Course`.`courseID` = `Program_has_Course`.`course_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `programs_by_unis`
--

/*!50001 DROP TABLE IF EXISTS `programs_by_unis`*/;
/*!50001 DROP VIEW IF EXISTS `programs_by_unis`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `programs_by_unis` AS select `Program`.`name` AS `Msc`,`University`.`name` AS `University`,`University`.`universityID` AS `universityID`,`Program`.`duration` AS `Semesters`,`Program`.`attendancy` AS `Attendancy`,`Program`.`fees` AS `Fees`,`Program`.`description` AS `Description` from ((`Program` join `Department` on(`Program`.`department_id` = `Department`.`departmentID`)) join `University` on(`University`.`universityID` = `Department`.`university_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `users_reviews`
--

/*!50001 DROP TABLE IF EXISTS `users_reviews`*/;
/*!50001 DROP VIEW IF EXISTS `users_reviews`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `users_reviews` AS select `User`.`name` AS `Username`,`Program`.`name` AS `Program`,`Program`.`programID` AS `ID`,`Reviews`.`grade` AS `Grade`,`Reviews`.`comment` AS `Comment` from ((`User` join `Reviews` on(`User`.`userID` = `Reviews`.`user_id`)) join `Program` on(`Program`.`programID` = `Reviews`.`IDprogram`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `wishlists`
--

/*!50001 DROP TABLE IF EXISTS `wishlists`*/;
/*!50001 DROP VIEW IF EXISTS `wishlists`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `wishlists` AS select `User`.`name` AS `Username`,`Program`.`name` AS `Program`,`Program`.`programID` AS `ID` from ((`User` join `Likes` on(`Likes`.`user__id` = `User`.`userID`)) join `Program` on(`Program`.`programID` = `Likes`.`ID_program`)) */;
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

-- Dump completed on 2019-12-19 21:46:13
