-- MySQL dump 10.17  Distrib 10.3.11-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: pet_db
-- ------------------------------------------------------
-- Server version	10.3.11-MariaDB-1:10.3.11+maria~bionic

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add authorization',7,'add_authorization'),(26,'Can change authorization',7,'change_authorization'),(27,'Can delete authorization',7,'delete_authorization'),(28,'Can view authorization',7,'view_authorization'),(29,'Can add entity',8,'add_entity'),(30,'Can change entity',8,'change_entity'),(31,'Can delete entity',8,'delete_entity'),(32,'Can view entity',8,'view_entity'),(33,'Can add file',9,'add_file'),(34,'Can change file',9,'change_file'),(35,'Can delete file',9,'delete_file'),(36,'Can view file',9,'view_file'),(37,'Can add job',10,'add_job'),(38,'Can change job',10,'change_job'),(39,'Can delete job',10,'delete_job'),(40,'Can view job',10,'view_job'),(41,'Can add task',11,'add_task'),(42,'Can change task',11,'change_task'),(43,'Can delete task',11,'delete_task'),(44,'Can view task',11,'view_task');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(7,'rest','authorization'),(8,'rest','entity'),(9,'rest','file'),(10,'rest','job'),(11,'rest','task'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2018-11-24 18:11:53.622568'),(2,'auth','0001_initial','2018-11-24 18:11:55.420793'),(3,'admin','0001_initial','2018-11-24 18:11:55.857126'),(4,'admin','0002_logentry_remove_auto_add','2018-11-24 18:11:55.887011'),(5,'admin','0003_logentry_add_action_flag_choices','2018-11-24 18:11:55.904576'),(6,'contenttypes','0002_remove_content_type_name','2018-11-24 18:11:56.172088'),(7,'auth','0002_alter_permission_name_max_length','2018-11-24 18:11:56.201794'),(8,'auth','0003_alter_user_email_max_length','2018-11-24 18:11:56.226110'),(9,'auth','0004_alter_user_username_opts','2018-11-24 18:11:56.249428'),(10,'auth','0005_alter_user_last_login_null','2018-11-24 18:11:56.393073'),(11,'auth','0006_require_contenttypes_0002','2018-11-24 18:11:56.404276'),(12,'auth','0007_alter_validators_add_error_messages','2018-11-24 18:11:56.423254'),(13,'auth','0008_alter_user_username_max_length','2018-11-24 18:11:56.499247'),(14,'auth','0009_alter_user_last_name_max_length','2018-11-24 18:11:56.529358'),(15,'rest','0001_initial','2018-11-24 18:11:59.440538'),(16,'sessions','0001_initial','2018-11-24 18:11:59.536001');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rest_authorization`
--

DROP TABLE IF EXISTS `rest_authorization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rest_authorization` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject` varchar(45) NOT NULL,
  `fingerprint` varchar(45) NOT NULL,
  `start_date` datetime(6) NOT NULL,
  `expiry_date` datetime(6) NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  `entity_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `rest_authorization_entity_id_11ba9b51_fk_rest_entity_id` (`entity_id`),
  CONSTRAINT `rest_authorization_entity_id_11ba9b51_fk_rest_entity_id` FOREIGN KEY (`entity_id`) REFERENCES `rest_entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rest_authorization`
--

LOCK TABLES `rest_authorization` WRITE;
/*!40000 ALTER TABLE `rest_authorization` DISABLE KEYS */;
/*!40000 ALTER TABLE `rest_authorization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rest_entity`
--

DROP TABLE IF EXISTS `rest_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rest_entity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `common_name` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  `contact` varchar(45) NOT NULL,
  `comments` longtext DEFAULT NULL,
  `timestamp` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `common_name` (`common_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rest_entity`
--

LOCK TABLES `rest_entity` WRITE;
/*!40000 ALTER TABLE `rest_entity` DISABLE KEYS */;
/*!40000 ALTER TABLE `rest_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rest_file`
--

DROP TABLE IF EXISTS `rest_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rest_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `comments` varchar(45) DEFAULT NULL,
  `path` varchar(45) DEFAULT NULL,
  `task_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `rest_file_task_id_87201326_fk_rest_task_id` (`task_id`),
  CONSTRAINT `rest_file_task_id_87201326_fk_rest_task_id` FOREIGN KEY (`task_id`) REFERENCES `rest_task` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rest_file`
--

LOCK TABLES `rest_file` WRITE;
/*!40000 ALTER TABLE `rest_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `rest_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rest_job`
--

DROP TABLE IF EXISTS `rest_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rest_job` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `saved_id` int(11) DEFAULT NULL,
  `job_status` varchar(45) NOT NULL,
  `started_date` datetime(6) DEFAULT NULL,
  `completed_date` datetime(6) DEFAULT NULL,
  `job_description` varchar(45) DEFAULT NULL,
  `job_params` varchar(45) DEFAULT NULL,
  `exit_code` int(11) DEFAULT NULL,
  `err_file_id` int(11) DEFAULT NULL,
  `out_file_id` int(11) DEFAULT NULL,
  `task_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `err_file_id` (`err_file_id`),
  UNIQUE KEY `out_file_id` (`out_file_id`),
  KEY `rest_job_task_id_cc157c6b_fk_rest_task_id` (`task_id`),
  CONSTRAINT `rest_job_err_file_id_75d8a92f_fk_rest_file_id` FOREIGN KEY (`err_file_id`) REFERENCES `rest_file` (`id`),
  CONSTRAINT `rest_job_out_file_id_d69e4d89_fk_rest_file_id` FOREIGN KEY (`out_file_id`) REFERENCES `rest_file` (`id`),
  CONSTRAINT `rest_job_task_id_cc157c6b_fk_rest_task_id` FOREIGN KEY (`task_id`) REFERENCES `rest_task` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rest_job`
--

LOCK TABLES `rest_job` WRITE;
/*!40000 ALTER TABLE `rest_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `rest_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rest_job_input_data`
--

DROP TABLE IF EXISTS `rest_job_input_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rest_job_input_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` int(11) NOT NULL,
  `file_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rest_job_input_data_job_id_file_id_299087f1_uniq` (`job_id`,`file_id`),
  KEY `rest_job_input_data_file_id_dd6775ab_fk_rest_file_id` (`file_id`),
  CONSTRAINT `rest_job_input_data_file_id_dd6775ab_fk_rest_file_id` FOREIGN KEY (`file_id`) REFERENCES `rest_file` (`id`),
  CONSTRAINT `rest_job_input_data_job_id_8b1f5259_fk_rest_job_id` FOREIGN KEY (`job_id`) REFERENCES `rest_job` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rest_job_input_data`
--

LOCK TABLES `rest_job_input_data` WRITE;
/*!40000 ALTER TABLE `rest_job_input_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `rest_job_input_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rest_job_job_previous`
--

DROP TABLE IF EXISTS `rest_job_job_previous`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rest_job_job_previous` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from_job_id` int(11) NOT NULL,
  `to_job_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rest_job_job_previous_from_job_id_to_job_id_87242196_uniq` (`from_job_id`,`to_job_id`),
  KEY `rest_job_job_previous_to_job_id_01fcc179_fk_rest_job_id` (`to_job_id`),
  CONSTRAINT `rest_job_job_previous_from_job_id_0431bd4e_fk_rest_job_id` FOREIGN KEY (`from_job_id`) REFERENCES `rest_job` (`id`),
  CONSTRAINT `rest_job_job_previous_to_job_id_01fcc179_fk_rest_job_id` FOREIGN KEY (`to_job_id`) REFERENCES `rest_job` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rest_job_job_previous`
--

LOCK TABLES `rest_job_job_previous` WRITE;
/*!40000 ALTER TABLE `rest_job_job_previous` DISABLE KEYS */;
/*!40000 ALTER TABLE `rest_job_job_previous` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rest_job_output_data`
--

DROP TABLE IF EXISTS `rest_job_output_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rest_job_output_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` int(11) NOT NULL,
  `file_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rest_job_output_data_job_id_file_id_fa9ed7f3_uniq` (`job_id`,`file_id`),
  KEY `rest_job_output_data_file_id_61cb1867_fk_rest_file_id` (`file_id`),
  CONSTRAINT `rest_job_output_data_file_id_61cb1867_fk_rest_file_id` FOREIGN KEY (`file_id`) REFERENCES `rest_file` (`id`),
  CONSTRAINT `rest_job_output_data_job_id_b2ffe608_fk_rest_job_id` FOREIGN KEY (`job_id`) REFERENCES `rest_job` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rest_job_output_data`
--

LOCK TABLES `rest_job_output_data` WRITE;
/*!40000 ALTER TABLE `rest_job_output_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `rest_job_output_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rest_task`
--

DROP TABLE IF EXISTS `rest_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rest_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_status` varchar(45) NOT NULL,
  `started_date` datetime(6) DEFAULT NULL,
  `completed_date` datetime(6) DEFAULT NULL,
  `timestamp` datetime(6) NOT NULL,
  `priority` int(11) NOT NULL,
  `parameters` varchar(45) DEFAULT NULL,
  `comments` longtext DEFAULT NULL,
  `task_type` varchar(45) DEFAULT NULL,
  `entity_id` int(11) NOT NULL,
  `log_file_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `log_file_id` (`log_file_id`),
  KEY `rest_task_entity_id_782bd389_fk_rest_entity_id` (`entity_id`),
  CONSTRAINT `rest_task_entity_id_782bd389_fk_rest_entity_id` FOREIGN KEY (`entity_id`) REFERENCES `rest_entity` (`id`),
  CONSTRAINT `rest_task_log_file_id_942677c8_fk_rest_file_id` FOREIGN KEY (`log_file_id`) REFERENCES `rest_file` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rest_task`
--

LOCK TABLES `rest_task` WRITE;
/*!40000 ALTER TABLE `rest_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `rest_task` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-24 18:15:08
