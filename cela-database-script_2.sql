-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: cela
-- ------------------------------------------------------
-- Server version	8.0.22

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
-- Table structure for table `faculty`
--

DROP TABLE IF EXISTS `faculty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faculty` (
  `id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `id_student` int DEFAULT NULL,
  `id_subject` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculty`
--

LOCK TABLES `faculty` WRITE;
/*!40000 ALTER TABLE `faculty` DISABLE KEYS */;
INSERT INTO `faculty` VALUES (0,'Computer Sciences',NULL,NULL);
/*!40000 ALTER TABLE `faculty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `semester`
--

DROP TABLE IF EXISTS `semester`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `semester` (
  `id` int NOT NULL,
  `type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `semester`
--

LOCK TABLES `semester` WRITE;
/*!40000 ALTER TABLE `semester` DISABLE KEYS */;
INSERT INTO `semester` VALUES (0,'Summer'),(1,'Winter');
/*!40000 ALTER TABLE `semester` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `id` int NOT NULL AUTO_INCREMENT,
  `last_name` varchar(45) DEFAULT NULL,
  `first_name` varchar(45) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `nationality` varchar(45) DEFAULT NULL,
  `sex` varchar(45) DEFAULT NULL,
  `field_of_education` int DEFAULT NULL,
  `id_faculty` int DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `sending_inst_name` varchar(100) DEFAULT NULL,
  `sending_inst_dept` varchar(100) DEFAULT NULL,
  `sending_inst_erascode` varchar(45) DEFAULT NULL,
  `sending_inst_address` varchar(200) DEFAULT NULL,
  `sending_inst_country` varchar(45) DEFAULT NULL,
  `sending_inst_contact_name` varchar(100) DEFAULT NULL,
  `sending_inst_contact_email` varchar(100) DEFAULT NULL,
  `receiving_inst_contact_name` varchar(100) DEFAULT NULL,
  `receiving_inst_contact_email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_faculty_idx` (`id_faculty`),
  CONSTRAINT `fk_student_faculty` FOREIGN KEY (`id_faculty`) REFERENCES `faculty` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (1,'Mihotić','Ivona','1995-04-15','Croatian','Female',1,0,'ivi_1504@hotmail.com','ivona', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),(38,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'daniel.dujmovic@fer.hr','daniel', NULL, NULL, NULL, NULL, NULL ,NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_subject`
--

DROP TABLE IF EXISTS `student_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_subject` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_student` int DEFAULT NULL,
  `id_subject` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_subject_UNIQUE` (`id_subject`),
  KEY `fk_student_subject_student_idx` (`id_student`),
  CONSTRAINT `fk_student_subject_student` FOREIGN KEY (`id_student`) REFERENCES `student` (`id`),
  CONSTRAINT `fk_student_subject_subject` FOREIGN KEY (`id_subject`) REFERENCES `subject` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_subject`
--

LOCK TABLES `student_subject` WRITE;
/*!40000 ALTER TABLE `student_subject` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject`
--

DROP TABLE IF EXISTS `subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subject` (
  `id` int NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `ects` int DEFAULT NULL,
  `id_semester` int DEFAULT NULL,
  `id_faculty` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_subject_semester_idx` (`id_semester`),
  KEY `fk_subject_faculty_idx` (`id_faculty`),
  CONSTRAINT `fk_subject_faculty` FOREIGN KEY (`id_faculty`) REFERENCES `faculty` (`id`),
  CONSTRAINT `fk_subject_semester` FOREIGN KEY (`id_semester`) REFERENCES `semester` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject`
--

LOCK TABLES `subject` WRITE;
/*!40000 ALTER TABLE `subject` DISABLE KEYS */;
INSERT INTO `subject` VALUES 
(0,'Software Architecture and Verification','In the lectures you will learn the definition of software architecture, role of the architect, process of creating software architecture, how and what should be documented in description of software architecture. In the laboratory: creating a software architecture description, including usability tree, design decisions and architectural views. Preparation to an ATAM meeting.',6,1,0),
(1,'Software Development Studio 2','The course is the continuation of the Software Development 1 course given in the previous semester and is about further development of a software project for a real customer.',6,1,0),
(2,'Pre-diploma Seminar','Seminars are conducted in the form of 15 2-hour meetings. During seminar classes, the students are to prepare and give three presentations in English related to the topic considered for the prospective Master thesis.',3,1,0),
(3,'Quality Managment and Experimental Software Engineering','The course includes seminars and project classes. During the seminars students learn and discuss about quality management and experimental engineering. A part of the seminar classes has a form of showcase or individual tasks that are performed by students. During the project classes’ student is running a research project that has to employ at least one of the following empirical methods: controlled experiment, case study, survey, or meta-analysis.',5,1,0),
(4,'Software Evolution and Maintenance','The aim of this course is to present students with models and mechanisms of software evolution, as well as to develop the ability to extract information and analyze repositories and, based on the results of this analysis, evaluate the process of evolution of a given component or artifact.',6,1,0),
(5,'Scientific and Technical Writing','Presenting students’ scientific career and interests. The writing process: text organisation. Presenting Thesis statement. Elements of a formal definition. Elements and types of paragraphs (process, comparison/contrast). Forms of scientific expression: reporting results of research, a review of a selected article on newest developments in computer science. Differences between summary and paraphrase. The issue of plagiarism in scientific papers. Summarising: main structural elements, including relevant information in a logical order. Summary and abstract. Editing and proofreading scientific papers. Main features of scientific articles. Quoting.',2,1,0),
(6,'Introduction to Computing','The lectures and laboratory classes regard IT methods and tools that are currently used by professional IT companies. The presentations of the methods and tools can have a form of lecture or tutorial conducted during laboratory classes.',5,1,0),
(7,'Introduction to Programming','Python programming for beginners.',5,1,0),
(8,'Introduction to Artificial Intelligence','New course, no description available yet.',3,1,0),
(9,'Database Systems','New course, no description available yet.',5,1,0),
(10,'Artificial Intelligence','New course, no description available yet.',5,1,0),
(11,'Polish','Introduction to the basics of Polish language',2,1,0);


/*!40000 ALTER TABLE `subject` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-15 18:36:25semester