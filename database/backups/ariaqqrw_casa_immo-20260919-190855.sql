-- MariaDB dump 10.19  Distrib 10.4.28-MariaDB, for osx10.10 (x86_64)
--
-- Host: localhost    Database: ariaqqrw_casa_immo
-- ------------------------------------------------------
-- Server version	10.4.28-MariaDB

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
-- Table structure for table `amenities`
--

DROP TABLE IF EXISTS `amenities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `amenities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `icon` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `amenities_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amenities`
--

LOCK TABLES `amenities` WRITE;
/*!40000 ALTER TABLE `amenities` DISABLE KEYS */;
INSERT INTO `amenities` VALUES (1,'Wi-Fi','wifi','confort'),(2,'Climatisation','snow','confort'),(3,'Parking','car','exterieur'),(4,'Piscine','pool','exterieur'),(5,'Cuisine équipée','utensils','cuisine'),(6,'Lave-linge','washer','confort'),(7,'Télévision','tv','confort'),(8,'Sécurité 24h/24','shield','securite'),(9,'Balcon','door-open','exterieur'),(10,'Eau chaude','droplet','confort'),(11,'Petit déjeuner inclus','cup-hot','services'),(12,'Salle de bain privée','droplet-half','confort'),(13,'Toilettes privatives','door-closed','confort'),(14,'Linge de maison','layers','confort'),(15,'Vue mer','water','exterieur'),(16,'Salon meublé','sofa','cuisine');
/*!40000 ALTER TABLE `amenities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_guests`
--

DROP TABLE IF EXISTS `booking_guests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `booking_guests` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `booking_id` bigint(20) unsigned NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(191) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `booking_guests_booking_id_foreign` (`booking_id`),
  CONSTRAINT `booking_guests_booking_id_foreign` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_guests`
--

LOCK TABLES `booking_guests` WRITE;
/*!40000 ALTER TABLE `booking_guests` DISABLE KEYS */;
INSERT INTO `booking_guests` VALUES (1,1,'Fatou','Sow','fatou.sow@email.sn','+221770000003'),(2,2,'Mariama','Diop','mariama.diop@email.sn','+221770000007');
/*!40000 ALTER TABLE `booking_guests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bookings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `property_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `check_in` date NOT NULL,
  `check_out` date NOT NULL,
  `guests` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `nights` int(10) unsigned NOT NULL,
  `rental_type` enum('nightly','weekly','monthly','long_term') NOT NULL DEFAULT 'nightly',
  `price_per_unit` decimal(12,2) NOT NULL,
  `subtotal` decimal(12,2) NOT NULL,
  `commission_rate` decimal(5,2) NOT NULL DEFAULT 10.00,
  `commission_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `total_amount` decimal(12,2) NOT NULL,
  `currency` char(3) NOT NULL DEFAULT 'XOF',
  `status` enum('pending','confirmed','cancelled','completed','rejected') NOT NULL DEFAULT 'pending',
  `notes` text DEFAULT NULL,
  `cancelled_at` datetime DEFAULT NULL,
  `review_reminder_sent_at` datetime DEFAULT NULL,
  `confirmation_pin` char(4) NOT NULL,
  `confirmation_email_sent_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `bookings_property_id_foreign` (`property_id`),
  KEY `bookings_user_id_foreign` (`user_id`),
  KEY `bookings_dates_index` (`check_in`,`check_out`),
  KEY `bookings_status_index` (`status`),
  KEY `bookings_review_reminder_index` (`status`,`check_out`,`review_reminder_sent_at`),
  KEY `bookings_confirmation_email_index` (`status`,`confirmation_email_sent_at`),
  CONSTRAINT `bookings_property_id_foreign` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bookings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (1,1,3,'2026-09-14','2026-09-17',2,3,'nightly',30000.00,90000.00,10.00,9000.00,90000.00,'XOF','completed',NULL,NULL,NULL,'8919','2026-08-18 02:52:31','2026-08-18 02:52:31','2026-09-18 21:44:02'),(2,2,7,'2026-10-01','2026-10-08',4,7,'weekly',75000.00,525000.00,10.00,52500.00,525000.00,'XOF','pending',NULL,NULL,NULL,'6838','2026-08-18 02:52:31','2026-08-18 02:52:31','2026-09-17 18:46:45'),(3,1,8,'2026-08-26','2026-08-31',1,5,'nightly',30000.00,150000.00,10.00,15000.00,150000.00,'XOF','pending',NULL,NULL,NULL,'4757','2026-08-18 13:35:20','2026-08-18 13:35:20','2026-09-17 18:46:45'),(4,28,8,'2026-08-23','2026-08-29',1,6,'nightly',12000.00,72000.00,10.00,7200.00,72000.00,'XOF','cancelled',NULL,'2026-08-22 16:06:03',NULL,'2676','2026-08-22 16:01:58','2026-08-22 16:01:58','2026-09-17 18:46:45'),(5,28,8,'2026-08-23','2026-08-31',2,8,'nightly',12000.00,96000.00,10.00,9600.00,96000.00,'XOF','pending',NULL,NULL,NULL,'0595','2026-08-22 16:06:39','2026-08-22 16:06:39','2026-09-17 18:46:45'),(6,28,8,'2026-09-14','2026-09-20',2,6,'nightly',12000.00,72000.00,10.00,7200.00,72000.00,'XOF','confirmed',NULL,NULL,NULL,'8514','2026-08-23 11:15:12','2026-08-23 11:15:12','2026-09-17 18:46:45'),(7,28,9,'2026-09-01','2026-09-06',1,5,'nightly',12000.00,60000.00,10.00,6000.00,60000.00,'XOF','completed',NULL,NULL,NULL,'6433','2026-08-23 11:52:58','2026-08-23 11:52:58','2026-09-17 18:46:45'),(8,29,9,'2026-08-24','2026-08-30',1,6,'nightly',10000.00,60000.00,10.00,6000.00,60000.00,'XOF','completed',NULL,NULL,NULL,'4352','2026-08-23 12:00:26','2026-08-23 12:00:26','2026-09-17 18:46:45'),(9,1,10,'2026-09-22','2026-09-30',1,8,'nightly',30000.00,240000.00,10.00,24000.00,240000.00,'XOF','confirmed',NULL,NULL,NULL,'2271','2026-09-05 14:38:45','2026-09-05 14:38:45','2026-09-17 18:46:45'),(10,29,11,'2026-09-14','2026-09-30',1,16,'nightly',10000.00,160000.00,10.00,16000.00,160000.00,'XOF','confirmed',NULL,NULL,NULL,'0190','2026-09-05 14:52:30','2026-09-05 14:52:30','2026-09-17 18:46:45'),(11,7,12,'2026-09-24','2026-09-30',3,6,'nightly',32000.00,192000.00,10.00,19200.00,192000.00,'XOF','confirmed',NULL,NULL,NULL,'3854','2026-09-17 20:13:45','2026-09-17 20:13:37','2026-09-17 20:13:45');
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commissions`
--

DROP TABLE IF EXISTS `commissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `booking_id` bigint(20) unsigned NOT NULL,
  `total_amount` decimal(12,2) NOT NULL,
  `percentage` decimal(5,2) NOT NULL,
  `platform_amount` decimal(12,2) NOT NULL,
  `owner_amount` decimal(12,2) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `commissions_booking_id_unique` (`booking_id`),
  CONSTRAINT `commissions_booking_id_foreign` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commissions`
--

LOCK TABLES `commissions` WRITE;
/*!40000 ALTER TABLE `commissions` DISABLE KEYS */;
INSERT INTO `commissions` VALUES (1,1,90000.00,10.00,9000.00,81000.00,'2026-08-18 02:52:31');
/*!40000 ALTER TABLE `commissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `construction_milestones`
--

DROP TABLE IF EXISTS `construction_milestones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `construction_milestones` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `due_date` date DEFAULT NULL,
  `completed_at` date DEFAULT NULL,
  `status` enum('pending','in_progress','done') NOT NULL DEFAULT 'pending',
  `sort_order` int(10) unsigned NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `construction_milestones_project_id_index` (`project_id`),
  CONSTRAINT `construction_milestones_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `construction_projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `construction_milestones`
--

LOCK TABLES `construction_milestones` WRITE;
/*!40000 ALTER TABLE `construction_milestones` DISABLE KEYS */;
/*!40000 ALTER TABLE `construction_milestones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `construction_projects`
--

DROP TABLE IF EXISTS `construction_projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `construction_projects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `owner_id` bigint(20) unsigned NOT NULL,
  `establishment_id` bigint(20) unsigned DEFAULT NULL,
  `property_id` bigint(20) unsigned DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `project_type` enum('maison_fini','maison_finition','villa','immeuble','autre') NOT NULL DEFAULT 'maison_finition',
  `status` enum('devis','planning','chantier','livraison','termine','annule') NOT NULL DEFAULT 'devis',
  `city` varchar(100) NOT NULL,
  `district` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `quote_amount` decimal(15,2) DEFAULT NULL,
  `currency` char(3) NOT NULL DEFAULT 'XOF',
  `start_date` date DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `progress` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `client_name` varchar(150) DEFAULT NULL,
  `client_phone` varchar(30) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `construction_projects_owner_id_index` (`owner_id`),
  KEY `construction_projects_status_index` (`status`),
  KEY `construction_projects_property_id_index` (`property_id`),
  KEY `construction_projects_establishment_id_foreign` (`establishment_id`),
  CONSTRAINT `construction_projects_establishment_id_foreign` FOREIGN KEY (`establishment_id`) REFERENCES `establishments` (`id`) ON DELETE SET NULL,
  CONSTRAINT `construction_projects_owner_id_foreign` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `construction_projects_property_id_foreign` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `construction_projects`
--

LOCK TABLES `construction_projects` WRITE;
/*!40000 ALTER TABLE `construction_projects` DISABLE KEYS */;
/*!40000 ALTER TABLE `construction_projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contract_images`
--

DROP TABLE IF EXISTS `contract_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contract_images` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `contract_id` bigint(20) unsigned NOT NULL,
  `path` varchar(255) NOT NULL,
  `is_primary` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` int(10) unsigned NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `contract_images_contract_id_index` (`contract_id`),
  CONSTRAINT `contract_images_contract_id_foreign` FOREIGN KEY (`contract_id`) REFERENCES `contracts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contract_images`
--

LOCK TABLES `contract_images` WRITE;
/*!40000 ALTER TABLE `contract_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `contract_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contract_payments`
--

DROP TABLE IF EXISTS `contract_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contract_payments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `contract_id` bigint(20) unsigned NOT NULL,
  `due_date` date NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `status` enum('pending','paid','overdue','cancelled') NOT NULL DEFAULT 'pending',
  `paid_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `contract_payments_contract_id_foreign` (`contract_id`),
  KEY `contract_payments_due_date_index` (`due_date`),
  CONSTRAINT `contract_payments_contract_id_foreign` FOREIGN KEY (`contract_id`) REFERENCES `contracts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contract_payments`
--

LOCK TABLES `contract_payments` WRITE;
/*!40000 ALTER TABLE `contract_payments` DISABLE KEYS */;
INSERT INTO `contract_payments` VALUES (1,1,'2026-01-05',450000.00,'paid','2026-01-03 09:00:00','2026-08-18 02:52:31'),(2,1,'2026-02-05',450000.00,'paid','2026-02-01 11:00:00','2026-08-18 02:52:31'),(3,1,'2026-03-05',450000.00,'paid','2026-03-02 10:00:00','2026-08-18 02:52:31'),(4,1,'2026-04-05',450000.00,'pending',NULL,'2026-08-18 02:52:31');
/*!40000 ALTER TABLE `contract_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contracts`
--

DROP TABLE IF EXISTS `contracts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contracts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `property_id` bigint(20) unsigned NOT NULL,
  `owner_id` bigint(20) unsigned NOT NULL,
  `tenant_id` bigint(20) unsigned NOT NULL,
  `booking_id` bigint(20) unsigned DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `monthly_amount` decimal(12,2) NOT NULL,
  `deposit_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `deposit_months` tinyint(3) unsigned NOT NULL DEFAULT 2,
  `terms` text DEFAULT NULL,
  `contract_type` enum('habitation','commercial','saisonnier','autre') NOT NULL DEFAULT 'habitation',
  `rental_duration` enum('court','moyen','long') NOT NULL DEFAULT 'long',
  `status` enum('draft','active','terminated','expired') NOT NULL DEFAULT 'draft',
  `pdf_path` varchar(255) DEFAULT NULL,
  `tenant_photo_path` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `contracts_property_id_foreign` (`property_id`),
  KEY `contracts_owner_id_foreign` (`owner_id`),
  KEY `contracts_tenant_id_foreign` (`tenant_id`),
  KEY `contracts_booking_id_foreign` (`booking_id`),
  CONSTRAINT `contracts_booking_id_foreign` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE SET NULL,
  CONSTRAINT `contracts_owner_id_foreign` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `contracts_property_id_foreign` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE CASCADE,
  CONSTRAINT `contracts_tenant_id_foreign` FOREIGN KEY (`tenant_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contracts`
--

LOCK TABLES `contracts` WRITE;
/*!40000 ALTER TABLE `contracts` DISABLE KEYS */;
INSERT INTO `contracts` VALUES (1,4,4,3,NULL,'2026-01-01','2026-12-31',450000.00,900000.00,2,'Contrat location annuelle renouvelable. Paiement avant le 5 de chaque mois.','habitation','long','active',NULL,NULL,'2026-08-18 02:52:31','2026-08-18 02:52:31');
/*!40000 ALTER TABLE `contracts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conversation_participants`
--

DROP TABLE IF EXISTS `conversation_participants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conversation_participants` (
  `conversation_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`conversation_id`,`user_id`),
  KEY `conversation_participants_user_id_foreign` (`user_id`),
  CONSTRAINT `conversation_participants_conversation_id_foreign` FOREIGN KEY (`conversation_id`) REFERENCES `conversations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `conversation_participants_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conversation_participants`
--

LOCK TABLES `conversation_participants` WRITE;
/*!40000 ALTER TABLE `conversation_participants` DISABLE KEYS */;
INSERT INTO `conversation_participants` VALUES (1,2),(1,3),(2,3),(2,5),(3,8),(3,9),(4,2),(4,8),(5,2),(5,10),(6,2),(6,12);
/*!40000 ALTER TABLE `conversation_participants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conversations`
--

DROP TABLE IF EXISTS `conversations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conversations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `subject` varchar(255) DEFAULT NULL,
  `property_id` bigint(20) unsigned DEFAULT NULL,
  `land_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `conversations_property_id_index` (`property_id`),
  KEY `conversations_land_id_index` (`land_id`),
  CONSTRAINT `conversations_land_id_foreign` FOREIGN KEY (`land_id`) REFERENCES `lands` (`id`) ON DELETE SET NULL,
  CONSTRAINT `conversations_property_id_foreign` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conversations`
--

LOCK TABLES `conversations` WRITE;
/*!40000 ALTER TABLE `conversations` DISABLE KEYS */;
INSERT INTO `conversations` VALUES (1,'Réservation appartement Ziguinchor',1,NULL,'2026-08-18 02:52:31','2026-08-22 15:29:35'),(2,'Visite terrain Ziguinchor',NULL,1,'2026-08-18 02:52:31','2026-08-22 15:29:35'),(3,'studio maubler',28,NULL,'2026-08-22 15:30:10','2026-08-23 11:53:40'),(4,'Appartement moderne à Ziguinchor',1,NULL,'2026-08-22 15:30:57','2026-08-22 15:31:03'),(5,'Appartement moderne à Ziguinchor',1,NULL,'2026-09-05 14:38:55','2026-09-05 14:38:55'),(6,'Résidence Santhiaba',7,NULL,'2026-09-17 20:14:57','2026-09-17 20:14:57');
/*!40000 ALTER TABLE `conversations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `establishments`
--

DROP TABLE IF EXISTS `establishments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `establishments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `owner_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `city` varchar(100) NOT NULL,
  `district` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `status` enum('draft','active','suspended') NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `establishments_owner_id_unique` (`owner_id`),
  KEY `establishments_city_index` (`city`),
  CONSTRAINT `establishments_owner_id_foreign` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `establishments`
--

LOCK TABLES `establishments` WRITE;
/*!40000 ALTER TABLE `establishments` DISABLE KEYS */;
INSERT INTO `establishments` VALUES (1,8,'Residance Justine','bienvenue','Ziguinchor','Tilene','Ziguinchor',NULL,NULL,'770000000','active','2026-08-18 22:01:59','2026-08-18 22:01:59'),(2,9,'Dakar','','Ziguinchor','Commune de Hann Bel-Air','Hann Maristes 1, Commune de Hann Bel-Air, Arrondissement de Grand Dakar, Dakar, Région de Dakar, 00221, Sénégal',14.74179573,-17.42925186,'+221776110061','active','2026-08-21 16:41:12','2026-08-21 16:41:12'),(3,10,'Zig Immobilier','Agence immobilière — gestion locative, vente de terrains, construction et hébergement meublé.','Ziguinchor','Centre-ville','Ziguinchor',NULL,NULL,'+221770000000','active','2026-09-01 22:37:05','2026-09-01 22:37:05'),(4,11,'Teranga','','Ziguinchor','','Ziguinchor',NULL,NULL,'','active','2026-09-05 14:59:02','2026-09-05 14:59:02'),(5,13,'Diouf Immobilier','','Ziguinchor','','Ziguinchor',NULL,NULL,'','active','2026-09-19 19:00:14','2026-09-19 19:00:14');
/*!40000 ALTER TABLE `establishments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `favorites` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `favoritable_type` enum('property','land') NOT NULL,
  `favoritable_id` bigint(20) unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `favorites_unique` (`user_id`,`favoritable_type`,`favoritable_id`),
  KEY `favorites_user_id_index` (`user_id`),
  CONSTRAINT `favorites_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites`
--

LOCK TABLES `favorites` WRITE;
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
INSERT INTO `favorites` VALUES (1,3,'property',2,'2026-08-18 02:52:31'),(2,3,'property',4,'2026-08-18 02:52:31'),(3,7,'property',1,'2026-08-18 02:52:31'),(4,5,'land',1,'2026-08-18 02:52:31'),(6,8,'property',6,'2026-08-18 13:20:17'),(8,12,'property',1,'2026-09-17 20:12:44'),(9,12,'property',29,'2026-09-17 20:12:46');
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `land_documents`
--

DROP TABLE IF EXISTS `land_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `land_documents` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `land_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  `doc_type` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `land_documents_land_id_index` (`land_id`),
  CONSTRAINT `land_documents_land_id_foreign` FOREIGN KEY (`land_id`) REFERENCES `lands` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `land_documents`
--

LOCK TABLES `land_documents` WRITE;
/*!40000 ALTER TABLE `land_documents` DISABLE KEYS */;
INSERT INTO `land_documents` VALUES (1,1,'Titre foncier','uploads/lands/1/titre-foncier.pdf','titre_foncier','2026-08-18 02:52:31'),(2,1,'Plan cadastral','uploads/lands/1/plan.pdf','plan','2026-08-18 02:52:31'),(3,3,'Titre foncier','uploads/lands/3/titre-foncier.pdf','titre_foncier','2026-08-18 02:52:31');
/*!40000 ALTER TABLE `land_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `land_images`
--

DROP TABLE IF EXISTS `land_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `land_images` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `land_id` bigint(20) unsigned NOT NULL,
  `path` varchar(255) NOT NULL,
  `is_primary` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` int(10) unsigned NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `land_images_land_id_index` (`land_id`),
  CONSTRAINT `land_images_land_id_foreign` FOREIGN KEY (`land_id`) REFERENCES `lands` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `land_images`
--

LOCK TABLES `land_images` WRITE;
/*!40000 ALTER TABLE `land_images` DISABLE KEYS */;
INSERT INTO `land_images` VALUES (1,1,'uploads/lands/1/main.jpg',1,0,'2026-08-18 02:52:31'),(2,1,'uploads/lands/1/vue.jpg',0,1,'2026-08-18 02:52:31'),(3,2,'uploads/lands/2/main.jpg',1,0,'2026-08-18 02:52:31'),(4,3,'uploads/lands/3/main.jpg',1,0,'2026-08-18 02:52:31'),(5,4,'uploads/lands/4/main.jpg',1,0,'2026-08-18 02:52:31');
/*!40000 ALTER TABLE `land_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `land_visits`
--

DROP TABLE IF EXISTS `land_visits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `land_visits` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `land_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `requested_date` date NOT NULL,
  `requested_time` time DEFAULT NULL,
  `message` text DEFAULT NULL,
  `status` enum('pending','accepted','rejected','rescheduled','completed','cancelled') NOT NULL DEFAULT 'pending',
  `proposed_date` date DEFAULT NULL,
  `proposed_time` time DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `land_visits_land_id_foreign` (`land_id`),
  KEY `land_visits_user_id_foreign` (`user_id`),
  CONSTRAINT `land_visits_land_id_foreign` FOREIGN KEY (`land_id`) REFERENCES `lands` (`id`) ON DELETE CASCADE,
  CONSTRAINT `land_visits_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `land_visits`
--

LOCK TABLES `land_visits` WRITE;
/*!40000 ALTER TABLE `land_visits` DISABLE KEYS */;
INSERT INTO `land_visits` VALUES (1,1,3,'2026-09-20','10:00:00','Je souhaite visiter ce terrain pour un projet de construction.','pending',NULL,NULL,'2026-08-18 02:52:31','2026-08-18 02:52:31'),(2,3,7,'2026-09-25','14:30:00','Intéressée pour un local commercial.','accepted',NULL,NULL,'2026-08-18 02:52:31','2026-08-18 02:52:31');
/*!40000 ALTER TABLE `land_visits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lands`
--

DROP TABLE IF EXISTS `lands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lands` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `seller_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `area` decimal(12,2) NOT NULL,
  `area_unit` enum('m2','ha','are') NOT NULL DEFAULT 'm2',
  `price` decimal(15,2) NOT NULL,
  `currency` char(3) NOT NULL DEFAULT 'XOF',
  `city` varchar(100) NOT NULL,
  `district` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `land_type` enum('residentiel','commercial','agricole','industriel','autre') NOT NULL DEFAULT 'residentiel',
  `status` enum('draft','pending','approved','rejected','suspended','sold') NOT NULL DEFAULT 'draft',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lands_seller_id_foreign` (`seller_id`),
  KEY `lands_city_index` (`city`),
  KEY `lands_land_type_index` (`land_type`),
  KEY `lands_status_index` (`status`),
  CONSTRAINT `lands_seller_id_foreign` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lands`
--

LOCK TABLES `lands` WRITE;
/*!40000 ALTER TABLE `lands` DISABLE KEYS */;
INSERT INTO `lands` VALUES (1,5,'Terrain 500 m² à Ziguinchor','Terrain viabilisé proche du centre de Ziguinchor. Idéal construction villa ou immeuble.',500.00,'m2',5000000.00,'XOF','Ziguinchor','Nagor','Lotissement Nagor',12.59000000,-16.26000000,'residentiel','approved','2026-08-18 02:52:31','2026-08-18 03:18:37',NULL),(2,6,'Parcelle agricole 2 ha — Sedhiou','Terrain fertile en Casamance, accès eau, parfait pour culture maraîchère ou élevage.',2.00,'ha',15000000.00,'XOF','Sedhiou','Boutoupa','Route de Boutoupa',12.70810000,-15.55690000,'agricole','approved','2026-08-18 02:52:31','2026-08-18 03:18:37',NULL),(3,5,'Terrain commercial Ziguinchor','Emplacement stratégique pour commerce ou bureaux en centre-ville de Ziguinchor.',300.00,'m2',85000000.00,'XOF','Ziguinchor','Centre-ville','Avenue Général de Gaulle',12.58400000,-16.27300000,'commercial','approved','2026-08-18 02:52:31','2026-08-18 03:18:37',NULL),(4,6,'Terrain résidentiel Bignona','Parcelle clôturée avec accès route principale, zone en développement.',5000.00,'m2',120000000.00,'XOF','Bignona','Zone résidentielle','Route de Bignona',12.81500000,-16.23000000,'residentiel','approved','2026-08-18 02:52:31','2026-08-18 03:18:37',NULL);
/*!40000 ALTER TABLE `lands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `conversation_id` bigint(20) unsigned NOT NULL,
  `sender_id` bigint(20) unsigned NOT NULL,
  `body` text NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `read_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `messages_conversation_id_index` (`conversation_id`),
  KEY `messages_sender_id_index` (`sender_id`),
  CONSTRAINT `messages_conversation_id_foreign` FOREIGN KEY (`conversation_id`) REFERENCES `conversations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `messages_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,1,3,'Bonjour, est-il possible d\'arriver à 16h le 14 septembre ?',1,'2026-08-18 02:52:31','2026-08-18 02:52:31'),(2,1,2,'Bonjour Fatou, oui pas de problème. Je vous envoie les instructions d\'accès.',1,'2026-08-18 02:52:31','2026-08-18 02:52:31'),(3,2,3,'Bonjour, je souhaiterais visiter le terrain samedi prochain.',0,NULL,'2026-08-18 02:52:31'),(4,3,8,'salut ca va',1,'2026-08-22 15:44:05','2026-08-22 15:30:24'),(5,4,8,'salut',0,NULL,'2026-08-22 15:31:03'),(6,3,9,'coment ca va',1,'2026-08-22 15:44:43','2026-08-22 15:44:36'),(7,3,8,'oui bien et toi',1,'2026-08-23 01:33:24','2026-08-22 15:49:59'),(8,3,9,'vous vouler confirmer la reservation',1,'2026-08-23 11:19:16','2026-08-23 01:33:51'),(9,3,8,'salut',1,'2026-08-23 11:53:57','2026-08-23 11:53:40');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moderation_actions`
--

DROP TABLE IF EXISTS `moderation_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `moderation_actions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` bigint(20) unsigned NOT NULL,
  `target_type` enum('property','land') NOT NULL,
  `target_id` bigint(20) unsigned NOT NULL,
  `action` enum('warning','suspend','reject','restore') NOT NULL,
  `motives` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`motives`)),
  `notes` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `moderation_actions_target_index` (`target_type`,`target_id`),
  KEY `moderation_actions_admin_id_index` (`admin_id`),
  CONSTRAINT `moderation_actions_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moderation_actions`
--

LOCK TABLES `moderation_actions` WRITE;
/*!40000 ALTER TABLE `moderation_actions` DISABLE KEYS */;
INSERT INTO `moderation_actions` VALUES (1,10,'property',29,'warning','[\"misleading_photos\"]',NULL,'2026-09-02 00:10:37');
/*!40000 ALTER TABLE `moderation_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `type` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `body` text DEFAULT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`data`)),
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `read_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `notifications_user_id_index` (`user_id`),
  KEY `notifications_is_read_index` (`is_read`),
  CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,2,'booking','Nouvelle réservation','Fatou Sow a réservé votre appartement à Almadies.','{\"booking_id\":1,\"property_id\":1}',1,NULL,'2026-08-18 02:52:31'),(2,3,'payment','Nouvelle réservation','Fatou Sow a réservé votre appartement à Ziguinchor.','{\"payment_id\":1,\"booking_id\":1}',1,NULL,'2026-08-18 02:52:31'),(3,5,'land_visit','Demande de visite','Fatou Sow souhaite visiter votre terrain à Diamniadio.','{\"land_visit_id\":1,\"land_id\":1}',0,NULL,'2026-08-18 02:52:31'),(4,1,'listing','Annonce en attente','1 nouvelle annonce attend validation.','{\"count\":0}',0,NULL,'2026-08-18 02:52:31'),(5,9,'message','Message de vroling mendy','oui bien et toi','{\"conversation_id\":3,\"message_id\":7,\"sender_id\":8}',1,'2026-08-23 01:33:24','2026-08-22 15:49:59'),(6,9,'booking','Nouvelle réservation','vroling mendy a réservé studio maubler du 23–29 août 2026.','{\"booking_id\":4,\"event\":\"created\",\"role\":\"host\"}',1,'2026-08-22 16:06:09','2026-08-22 16:01:58'),(7,8,'booking','Réservation enregistrée','Votre séjour à studio maubler (23–29 août 2026) est en attente de confirmation.','{\"booking_id\":4,\"event\":\"created\",\"role\":\"guest\"}',1,'2026-08-22 16:05:59','2026-08-22 16:01:58'),(8,9,'booking','Réservation annulée','vroling mendy a annulé sa réservation pour studio maubler (23–29 août 2026).','{\"booking_id\":4,\"event\":\"cancelled\",\"role\":\"host\"}',1,'2026-08-22 16:06:09','2026-08-22 16:06:03'),(9,8,'booking','Réservation annulée','Votre réservation pour studio maubler (23–29 août 2026) a été annulée.','{\"booking_id\":4,\"event\":\"cancelled\",\"role\":\"guest\"}',1,'2026-08-23 11:19:51','2026-08-22 16:06:03'),(10,9,'booking','Nouvelle réservation','vroling mendy a réservé studio maubler du 23–31 août 2026.','{\"booking_id\":5,\"event\":\"created\",\"role\":\"host\"}',1,'2026-08-22 16:06:47','2026-08-22 16:06:39'),(11,8,'booking','Réservation enregistrée','Votre séjour à studio maubler (23–31 août 2026) est en attente de confirmation.','{\"booking_id\":5,\"event\":\"created\",\"role\":\"guest\"}',1,'2026-08-22 16:07:20','2026-08-22 16:06:39'),(12,8,'message','Message de vroling .','vous vouler confirmer la reservation','{\"conversation_id\":3,\"message_id\":8,\"sender_id\":9}',1,'2026-08-23 11:19:16','2026-08-23 01:33:51'),(13,9,'booking','Nouvelle réservation','vroling mendy a réservé studio meubler du 14–20 sept. 2026.','{\"booking_id\":6,\"event\":\"created\",\"role\":\"host\"}',1,'2026-08-23 11:15:20','2026-08-23 11:15:12'),(14,8,'booking','Réservation enregistrée','Votre séjour à studio meubler (14–20 sept. 2026) est confirmé.','{\"booking_id\":6,\"event\":\"created\",\"role\":\"guest\"}',1,'2026-08-23 11:16:07','2026-08-23 11:15:12'),(15,9,'booking','Réservation enregistrée','Votre séjour à studio meubler (1–6 sept. 2026) est confirmé.','{\"booking_id\":7,\"event\":\"created\",\"role\":\"guest\"}',1,'2026-08-23 11:54:08','2026-08-23 11:52:58'),(16,9,'message','Message de vroling mendy','salut','{\"conversation_id\":3,\"message_id\":9,\"sender_id\":8}',1,'2026-08-23 11:53:57','2026-08-23 11:53:40'),(17,9,'booking','Réservation enregistrée','Votre séjour à studio (24–30 août 2026) est confirmé.','{\"booking_id\":8,\"event\":\"created\",\"role\":\"guest\"}',1,'2026-08-23 12:00:31','2026-08-23 12:00:26'),(18,2,'booking','Nouvelle réservation','Super Admin a réservé Appartement moderne à Ziguinchor du 22–30 sept. 2026.','{\"booking_id\":9,\"event\":\"created\",\"role\":\"host\"}',0,NULL,'2026-09-05 14:38:45'),(19,10,'booking','Réservation enregistrée','Votre séjour à Appartement moderne à Ziguinchor (22–30 sept. 2026) est confirmé.','{\"booking_id\":9,\"event\":\"created\",\"role\":\"guest\"}',1,'2026-09-05 14:38:50','2026-09-05 14:38:45'),(20,9,'booking','Nouvelle réservation','vroling Mendes a réservé studio du 14–30 sept. 2026.','{\"booking_id\":10,\"event\":\"created\",\"role\":\"host\"}',0,NULL,'2026-09-05 14:52:30'),(21,11,'booking','Réservation enregistrée','Votre séjour à studio (14–30 sept. 2026) est confirmé.','{\"booking_id\":10,\"event\":\"created\",\"role\":\"guest\"}',1,'2026-09-05 14:52:31','2026-09-05 14:52:30'),(22,2,'booking','Nouvelle réservation','vroling mendy a réservé Résidence Santhiaba du 24–30 sept. 2026.','{\"booking_id\":11,\"event\":\"created\",\"role\":\"host\"}',0,NULL,'2026-09-17 20:13:37'),(23,12,'booking','Réservation enregistrée','Votre séjour à Résidence Santhiaba (24–30 sept. 2026) est confirmé.','{\"booking_id\":11,\"event\":\"created\",\"role\":\"guest\"}',1,'2026-09-17 20:14:45','2026-09-17 20:13:39');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(191) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
INSERT INTO `password_reset_tokens` VALUES ('admin@zig-imobilier.sn','e272df783c31e3d3c08a597d21b747a308281a575febbc77c3a369bf896b4c48','2026-09-17 17:40:26'),('vroling@groupeisi.com','ffe875a826760c8d01014455fb1ee899e1bfbb1dee73dd5ff6b9eb15859f4490','2026-09-17 18:18:53');
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_transactions`
--

DROP TABLE IF EXISTS `payment_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_transactions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `payment_id` bigint(20) unsigned NOT NULL,
  `transaction_ref` varchar(191) NOT NULL,
  `gateway_response` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`gateway_response`)),
  `status` enum('pending','success','failed') NOT NULL DEFAULT 'pending',
  `amount` decimal(12,2) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `payment_transactions_payment_id_foreign` (`payment_id`),
  CONSTRAINT `payment_transactions_payment_id_foreign` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_transactions`
--

LOCK TABLES `payment_transactions` WRITE;
/*!40000 ALTER TABLE `payment_transactions` DISABLE KEYS */;
INSERT INTO `payment_transactions` VALUES (1,1,'TXN-WAVE-001','{\"status\":\"success\",\"provider\":\"wave\"}','success',90000.00,'2026-08-18 02:52:31');
/*!40000 ALTER TABLE `payment_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `booking_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `currency` char(3) NOT NULL DEFAULT 'XOF',
  `gateway` enum('wave','orange_money','card','cash','other') NOT NULL DEFAULT 'wave',
  `status` enum('pending','processing','completed','failed','refunded') NOT NULL DEFAULT 'pending',
  `reference` varchar(100) DEFAULT NULL,
  `paid_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `payments_booking_id_foreign` (`booking_id`),
  KEY `payments_user_id_foreign` (`user_id`),
  KEY `payments_status_index` (`status`),
  CONSTRAINT `payments_booking_id_foreign` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE SET NULL,
  CONSTRAINT `payments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,1,3,90000.00,'XOF','wave','completed','WAVE-20260901-001','2026-09-01 10:30:00','2026-08-18 02:52:31','2026-08-18 02:52:31');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `properties`
--

DROP TABLE IF EXISTS `properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `properties` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `owner_id` bigint(20) unsigned NOT NULL,
  `establishment_id` bigint(20) unsigned DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `type` enum('appartement','studio','villa','maison','chambre','residence','autre') NOT NULL DEFAULT 'appartement',
  `address` varchar(255) NOT NULL,
  `city` varchar(100) NOT NULL,
  `district` varchar(100) DEFAULT NULL,
  `country` varchar(100) NOT NULL DEFAULT 'Sénégal',
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `area_sqm` decimal(10,2) DEFAULT NULL,
  `bedrooms` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `bathrooms` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `capacity` tinyint(3) unsigned NOT NULL DEFAULT 2,
  `rules` text DEFAULT NULL,
  `status` enum('draft','pending','approved','rejected','suspended') NOT NULL DEFAULT 'draft',
  `currency` char(3) NOT NULL DEFAULT 'XOF',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `properties_owner_id_foreign` (`owner_id`),
  KEY `properties_city_index` (`city`),
  KEY `properties_type_index` (`type`),
  KEY `properties_status_index` (`status`),
  KEY `properties_location_index` (`latitude`,`longitude`),
  KEY `properties_establishment_id_index` (`establishment_id`),
  CONSTRAINT `properties_owner_id_foreign` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `properties`
--

LOCK TABLES `properties` WRITE;
/*!40000 ALTER TABLE `properties` DISABLE KEYS */;
INSERT INTO `properties` VALUES (1,2,NULL,'Appartement moderne à Ziguinchor','Appartement meublé en centre-ville, proche du marché et des transports. Idéal pour séjours courts ou moyens en Casamance.','appartement','Avenue Lamine Guèye','Ziguinchor','Centre-ville','Sénégal',12.58330000,-16.27190000,85.00,2,1,4,'Non fumeur. Pas d\'animaux. Check-in 14h, check-out 11h.','approved','XOF','2026-08-18 02:52:31','2026-08-18 03:18:37',NULL),(2,2,NULL,'Villa luxueuse à Cap Skirring','Villa spacieuse avec piscine privée, proche de la plage. Parfaite pour familles en vacances au bord de l\'océan.','villa','Route de la Plage','Cap Skirring','Bord de mer','Sénégal',12.39500000,-16.74810000,250.00,4,3,8,'Fêtes interdites. Caution requise.','approved','XOF','2026-08-18 02:52:31','2026-08-18 03:18:37',NULL),(3,4,NULL,'Studio cosy à Ziguinchor','Studio fonctionnel proche des commerces et restaurants locaux. Idéal voyageurs solo en Casamance.','studio','Quartier Kandialang','Ziguinchor','Kandialang','Sénégal',12.59000000,-16.28000000,35.00,1,1,2,'Silence après 22h.','approved','XOF','2026-08-18 02:52:31','2026-08-18 03:18:37',NULL),(4,4,NULL,'Maison familiale à Bignona','Grande maison avec cour intérieure, parfaite pour location mensuelle en Casamance.','maison','Quartier Escale','Bignona','Escale','Sénégal',12.81030000,-16.22640000,180.00,3,2,6,'Animaux acceptés avec accord.','approved','XOF','2026-08-18 02:52:31','2026-08-18 03:18:37',NULL),(5,2,NULL,'Chambre privée à Oussouye','Chambre confortable dans résidence calme, accès cuisine partagée. Au cœur du pays Bassari.','chambre','Oussouye Centre','Oussouye','Centre','Sénégal',12.48330000,-16.55000000,18.00,1,1,1,'Espace commun à partager.','approved','XOF','2026-08-18 02:52:31','2026-08-18 03:18:37',NULL),(6,4,NULL,'Appartement lumineux Nagor','Bel appartement meublé dans le lotissement Nagor, calme et sécurisé. Proche écoles et marchés.','appartement','Lotissement Nagor','Ziguinchor','Nagor','Sénégal',12.59200000,-16.25800000,72.00,2,1,4,'Non fumeur. Animaux sur demande.','approved','XOF','2026-08-18 04:51:58','2026-08-18 04:59:24',NULL),(7,2,NULL,'Résidence Santhiaba','Appartement spacieux au cœur de Santhiaba, quartier vivant de Ziguinchor. Idéal familles.','appartement','Rue de Santhiaba','Ziguinchor','Santhiaba','Sénégal',12.58100000,-16.26800000,95.00,3,2,6,'Check-in 15h. Check-out 11h.','approved','XOF','2026-08-18 04:51:58','2026-08-18 04:51:58',NULL),(8,2,NULL,'Villa vue océan Kabrousse','Villa avec terrasse panoramique à Kabrousse, à quelques minutes de la plage.','villa','Route de Kabrousse','Cap Skirring','Kabrousse','Sénégal',12.38000000,-16.76000000,200.00,3,2,6,'Fêtes interdites. Caution exigée.','approved','XOF','2026-08-18 04:51:58','2026-08-18 04:51:58',NULL),(9,4,NULL,'Appartement bord de mer','Appartement rénové face à l\'océan, parfait pour un séjour balnéaire.','appartement','Avenue de la Plage','Cap Skirring','Bord de mer','Sénégal',12.39800000,-16.74500000,65.00,2,1,4,'Non fumeur.','approved','XOF','2026-08-18 04:51:58','2026-08-18 04:51:58',NULL),(10,2,NULL,'Bungalow tropical','Bungalow indépendant dans un jardin tropical, accès piscine partagée.','maison','Boucott-Diamaguène','Cap Skirring','Boucott-Diamaguène','Sénégal',12.40000000,-16.75200000,110.00,2,1,4,'Respect du voisinage.','approved','XOF','2026-08-18 04:51:58','2026-08-18 04:51:58',NULL),(11,4,NULL,'Maison traditionnelle Diembéreng','Maison diola authentique avec cour intérieure, immersion culturelle garantie.','maison','Diembéreng','Oussouye','Diembéreng','Sénégal',12.47500000,-16.54500000,140.00,3,2,5,'Visite de la forêt sacrée à proximité.','approved','XOF','2026-08-18 04:51:58','2026-08-18 04:51:58',NULL),(12,2,NULL,'Studio Oussouye centre','Studio meublé proche du marché et de la forêt du fromager sacré.','studio','Route principale','Oussouye','Centre','Sénégal',12.48400000,-16.54900000,32.00,1,1,2,'Calme après 22h.','approved','XOF','2026-08-18 04:51:58','2026-08-18 04:51:58',NULL),(13,4,NULL,'Villa rizières Mlomp','Villa entourée de rizières, cadre verdoyant et paisible.','villa','Mlomp','Oussouye','Mlomp','Sénégal',12.47000000,-16.52000000,180.00,4,2,8,'Voiture recommandée.','approved','XOF','2026-08-18 04:51:58','2026-08-18 04:51:58',NULL),(14,2,NULL,'Appartement Escale','Appartement neuf dans le quartier Escale, proche route nationale.','appartement','Quartier Escale','Bignona','Escale','Sénégal',12.81200000,-16.22800000,78.00,2,1,4,'Location mensuelle possible.','approved','XOF','2026-08-18 04:51:58','2026-08-18 04:51:58',NULL),(15,4,NULL,'Maison avec cour Bignona','Maison familiale avec grande cour, idéale longue durée.','maison','Zone résidentielle','Bignona','Zone résidentielle','Sénégal',12.81600000,-16.23200000,160.00,3,2,6,'Animaux acceptés.','approved','XOF','2026-08-18 04:51:58','2026-08-18 04:51:58',NULL),(16,2,NULL,'Studio Diouloulou route','Studio pratique sur l\'axe Bignona–Diouloulou, commerces à proximité.','studio','Route de Diouloulou','Bignona','Diouloulou','Sénégal',12.80500000,-16.24000000,38.00,1,1,2,'Idéal solo ou couple.','approved','XOF','2026-08-18 04:51:58','2026-08-18 04:51:58',NULL),(17,4,NULL,'Maison fleuve Casamance','Maison confortable avec vue sur le fleuve, terrasse ombragée.','maison','Bords du fleuve','Sedhiou','Centre-ville','Sénégal',12.70800000,-15.55700000,150.00,3,2,6,'Moustiquaires fournies.','approved','XOF','2026-08-18 04:51:58','2026-08-18 04:51:58',NULL),(18,2,NULL,'Appartement Sedhiou centre','Appartement meublé en centre-ville, marché et gare à pied.','appartement','Avenue du Fleuve','Sedhiou','Centre-ville','Sénégal',12.71000000,-15.55500000,70.00,2,1,4,'Non fumeur.','approved','XOF','2026-08-18 04:51:58','2026-08-18 04:51:58',NULL),(19,4,NULL,'Case de villégiature Boutoupa','Hébergement rustique-chic dans le village de Boutoupa, nature préservée.','maison','Boutoupa','Sedhiou','Boutoupa','Sénégal',12.72000000,-15.54000000,90.00,2,1,4,'Accès 4x4 conseillé en saison des pluies.','approved','XOF','2026-08-18 04:51:58','2026-08-18 04:51:58',NULL),(20,2,NULL,'Chambre d\'hôtes Tanaff','Chambre spacieuse avec petit-déjeuner possible, accueil chaleureux.','chambre','Tanaff','Sedhiou','Tanaff','Sénégal',12.69500000,-15.57000000,22.00,1,1,2,'Espace partagé.','approved','XOF','2026-08-18 04:51:58','2026-08-18 04:51:58',NULL),(21,2,NULL,'Campement pêcheurs Abéné','Hébergement authentique à Abéné, célèbre pour ses poissons braisés.','maison','Abéné','Kafountine','Abéné','Sénégal',12.93000000,-16.05000000,85.00,2,1,4,'Ambiance conviviale.','approved','XOF','2026-08-18 04:51:58','2026-08-18 04:51:58',NULL),(22,4,NULL,'Villa plage Kafountine','Villa proche du port de pêche et des restaurants de bord de mer.','villa','Front de mer','Kafountine','Centre','Sénégal',12.92500000,-16.04500000,175.00,3,2,6,'Parfait amateurs de fruits de mer.','approved','XOF','2026-08-18 04:51:58','2026-08-18 04:51:58',NULL),(23,2,NULL,'Studio vue lagune','Studio avec vue lagune, idéal week-end nature.','studio','Route du port','Kafountine','Centre','Sénégal',12.92800000,-16.04800000,35.00,1,1,2,'Calme et reposant.','approved','XOF','2026-08-18 04:51:58','2026-08-18 04:51:58',NULL),(24,4,NULL,'Maison familiale Kafountine','Grande maison pour familles, proche plage et marché aux poissons.','maison','Quartier résidentiel','Kafountine','Centre','Sénégal',12.92200000,-16.04200000,130.00,3,2,7,'Barbecue disponible.','approved','XOF','2026-08-18 04:51:58','2026-08-18 04:51:58',NULL),(25,2,NULL,'Maison rizières Diouloulou','Maison entourée de rizières verdoyantes, cadre authentique casamançais.','maison','Diouloulou village','Diouloulou','Centre','Sénégal',12.65000000,-16.38000000,120.00,2,1,5,'Sérénité garantie.','approved','XOF','2026-08-18 04:51:58','2026-08-18 04:51:58',NULL),(26,8,1,'studio test','','studio','Djibock','Ziguinchor','Tilene','Sénégal',12.56367394,-16.26247600,NULL,1,1,2,'','draft','XOF','2026-08-18 22:36:23','2026-08-23 11:53:16','2026-08-23 11:53:16'),(27,9,2,'studio meubler','','studio','Commune de Hann Bel-Air, Ziguinchor','Ziguinchor','Commune de Hann Bel-Air','Sénégal',NULL,NULL,NULL,1,1,2,'','draft','XOF','2026-08-21 16:48:57','2026-08-23 10:59:25','2026-08-23 10:59:25'),(28,9,2,'studio meubler','','appartement','Commune de Hann Bel-Air, Ziguinchor','Ziguinchor','Commune de Hann Bel-Air','Sénégal',14.74179573,-17.42925186,NULL,1,1,2,'','approved','XOF','2026-08-21 16:52:30','2026-08-23 11:00:22',NULL),(29,9,2,'studio','','studio','Commune de Hann Bel-Air, Ziguinchor','Ziguinchor','Commune de Hann Bel-Air','Sénégal',14.74179573,-17.42925186,NULL,1,1,2,'','approved','XOF','2026-08-23 11:58:52','2026-08-23 11:58:53',NULL);
/*!40000 ALTER TABLE `properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property_amenities`
--

DROP TABLE IF EXISTS `property_amenities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `property_amenities` (
  `property_id` bigint(20) unsigned NOT NULL,
  `amenity_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`property_id`,`amenity_id`),
  KEY `property_amenities_amenity_id_foreign` (`amenity_id`),
  CONSTRAINT `property_amenities_amenity_id_foreign` FOREIGN KEY (`amenity_id`) REFERENCES `amenities` (`id`) ON DELETE CASCADE,
  CONSTRAINT `property_amenities_property_id_foreign` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property_amenities`
--

LOCK TABLES `property_amenities` WRITE;
/*!40000 ALTER TABLE `property_amenities` DISABLE KEYS */;
INSERT INTO `property_amenities` VALUES (1,1),(1,2),(1,3),(1,5),(1,7),(1,9),(1,11),(1,12),(1,13),(1,14),(1,15),(2,1),(2,2),(2,3),(2,4),(2,5),(2,6),(2,7),(2,8),(2,11),(3,1),(3,2),(3,5),(3,7),(4,1),(4,3),(4,5),(4,6),(4,10),(5,1),(5,2),(5,8),(6,1),(6,2),(6,3),(6,5),(6,7),(7,1),(7,2),(7,3),(7,5),(7,6),(7,9),(8,1),(8,2),(8,3),(8,4),(8,5),(8,7),(8,8),(9,1),(9,2),(9,5),(9,7),(9,9),(10,1),(10,2),(10,4),(10,5),(10,9),(11,1),(11,3),(11,5),(11,10),(12,1),(12,2),(12,5),(12,7),(13,1),(13,2),(13,3),(13,4),(13,5),(13,8),(14,1),(14,2),(14,3),(14,5),(15,1),(15,3),(15,5),(15,6),(15,10),(16,1),(16,2),(16,5),(17,1),(17,3),(17,5),(17,9),(18,1),(18,2),(18,5),(18,7),(19,1),(19,5),(19,10),(20,1),(20,2),(20,8),(21,1),(21,5),(21,7),(22,1),(22,2),(22,3),(22,4),(22,5),(22,7),(23,1),(23,2),(23,5),(24,1),(24,3),(24,5),(24,6),(25,1),(25,3),(25,5),(25,9),(26,2),(26,5),(26,6),(26,7),(26,8),(26,9),(26,10),(26,11),(26,12),(26,13),(26,16),(27,1),(27,2),(27,3),(27,5),(27,6),(27,7),(27,8),(27,9),(27,10),(27,11),(27,12),(27,13),(27,14),(27,15),(27,16),(29,1),(29,2),(29,6),(29,7),(29,9),(29,10),(29,12),(29,14),(29,16);
/*!40000 ALTER TABLE `property_amenities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property_availability`
--

DROP TABLE IF EXISTS `property_availability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `property_availability` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `property_id` bigint(20) unsigned NOT NULL,
  `date` date NOT NULL,
  `status` enum('available','blocked','reserved','maintenance') NOT NULL DEFAULT 'available',
  `booking_id` bigint(20) unsigned DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `property_availability_unique` (`property_id`,`date`),
  KEY `property_availability_date_index` (`date`),
  KEY `property_availability_status_index` (`status`),
  KEY `property_availability_booking_id_foreign` (`booking_id`),
  CONSTRAINT `property_availability_booking_id_foreign` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property_availability`
--

LOCK TABLES `property_availability` WRITE;
/*!40000 ALTER TABLE `property_availability` DISABLE KEYS */;
INSERT INTO `property_availability` VALUES (1,1,'2026-09-10','blocked',NULL,'Travaux peinture','2026-08-18 02:52:31'),(2,1,'2026-09-11','blocked',NULL,'Travaux peinture','2026-08-18 02:52:31'),(3,1,'2026-09-17','blocked',NULL,'Maintenance clim','2026-08-18 02:52:31'),(4,1,'2026-09-18','blocked',NULL,'Maintenance clim','2026-08-18 02:52:31'),(5,1,'2026-09-19','blocked',NULL,'Maintenance clim','2026-08-18 02:52:31'),(6,1,'2026-09-14','reserved',1,NULL,'2026-08-18 02:52:31'),(7,1,'2026-09-15','reserved',1,NULL,'2026-08-18 02:52:31'),(8,1,'2026-09-16','reserved',1,NULL,'2026-08-18 02:52:31'),(9,26,'2026-08-18','blocked',NULL,NULL,'2026-08-18 22:59:48'),(10,26,'2026-08-19','blocked',NULL,NULL,'2026-08-18 22:59:48'),(11,26,'2026-08-20','blocked',NULL,NULL,'2026-08-18 22:59:48'),(12,26,'2026-08-21','blocked',NULL,NULL,'2026-08-18 22:59:48'),(13,26,'2026-08-22','blocked',NULL,NULL,'2026-08-18 22:59:48'),(14,26,'2026-08-23','blocked',NULL,NULL,'2026-08-18 22:59:48'),(15,26,'2026-08-24','blocked',NULL,NULL,'2026-08-18 22:59:48'),(16,26,'2026-08-25','blocked',NULL,NULL,'2026-08-18 22:59:48'),(17,26,'2026-08-26','blocked',NULL,NULL,'2026-08-18 22:59:48'),(18,26,'2026-08-27','blocked',NULL,NULL,'2026-08-18 22:59:48'),(19,26,'2026-08-28','blocked',NULL,NULL,'2026-08-18 22:59:48'),(20,26,'2026-08-29','blocked',NULL,NULL,'2026-08-18 22:59:48'),(21,26,'2026-08-30','blocked',NULL,NULL,'2026-08-18 22:59:48'),(22,28,'2026-09-09','blocked',NULL,NULL,'2026-08-23 11:07:25'),(23,28,'2026-09-10','blocked',NULL,NULL,'2026-08-23 11:07:25'),(24,28,'2026-09-11','blocked',NULL,NULL,'2026-08-23 11:07:25'),(25,28,'2026-09-12','blocked',NULL,NULL,'2026-08-23 11:07:25'),(26,28,'2026-09-14','reserved',6,NULL,'2026-08-23 11:15:12'),(27,28,'2026-09-15','reserved',6,NULL,'2026-08-23 11:15:12'),(28,28,'2026-09-16','reserved',6,NULL,'2026-08-23 11:15:12'),(29,28,'2026-09-17','reserved',6,NULL,'2026-08-23 11:15:12'),(30,28,'2026-09-18','reserved',6,NULL,'2026-08-23 11:15:12'),(31,28,'2026-09-19','reserved',6,NULL,'2026-08-23 11:15:12'),(32,28,'2026-09-01','reserved',7,NULL,'2026-08-23 11:52:58'),(33,28,'2026-09-02','reserved',7,NULL,'2026-08-23 11:52:58'),(34,28,'2026-09-03','reserved',7,NULL,'2026-08-23 11:52:58'),(35,28,'2026-09-04','reserved',7,NULL,'2026-08-23 11:52:58'),(36,28,'2026-09-05','reserved',7,NULL,'2026-08-23 11:52:58'),(37,29,'2026-08-24','reserved',8,NULL,'2026-08-23 12:00:26'),(38,29,'2026-08-25','reserved',8,NULL,'2026-08-23 12:00:26'),(39,29,'2026-08-26','reserved',8,NULL,'2026-08-23 12:00:26'),(40,29,'2026-08-27','reserved',8,NULL,'2026-08-23 12:00:26'),(41,29,'2026-08-28','reserved',8,NULL,'2026-08-23 12:00:26'),(42,29,'2026-08-29','reserved',8,NULL,'2026-08-23 12:00:26'),(43,1,'2026-09-22','reserved',9,NULL,'2026-09-05 14:38:45'),(44,1,'2026-09-23','reserved',9,NULL,'2026-09-05 14:38:45'),(45,1,'2026-09-24','reserved',9,NULL,'2026-09-05 14:38:45'),(46,1,'2026-09-25','reserved',9,NULL,'2026-09-05 14:38:45'),(47,1,'2026-09-26','reserved',9,NULL,'2026-09-05 14:38:45'),(48,1,'2026-09-27','reserved',9,NULL,'2026-09-05 14:38:45'),(49,1,'2026-09-28','reserved',9,NULL,'2026-09-05 14:38:45'),(50,1,'2026-09-29','reserved',9,NULL,'2026-09-05 14:38:45'),(51,29,'2026-09-14','reserved',10,NULL,'2026-09-05 14:52:30'),(52,29,'2026-09-15','reserved',10,NULL,'2026-09-05 14:52:30'),(53,29,'2026-09-16','reserved',10,NULL,'2026-09-05 14:52:30'),(54,29,'2026-09-17','reserved',10,NULL,'2026-09-05 14:52:30'),(55,29,'2026-09-18','reserved',10,NULL,'2026-09-05 14:52:30'),(56,29,'2026-09-19','reserved',10,NULL,'2026-09-05 14:52:30'),(57,29,'2026-09-20','reserved',10,NULL,'2026-09-05 14:52:30'),(58,29,'2026-09-21','reserved',10,NULL,'2026-09-05 14:52:30'),(59,29,'2026-09-22','reserved',10,NULL,'2026-09-05 14:52:30'),(60,29,'2026-09-23','reserved',10,NULL,'2026-09-05 14:52:30'),(61,29,'2026-09-24','reserved',10,NULL,'2026-09-05 14:52:30'),(62,29,'2026-09-25','reserved',10,NULL,'2026-09-05 14:52:30'),(63,29,'2026-09-26','reserved',10,NULL,'2026-09-05 14:52:30'),(64,29,'2026-09-27','reserved',10,NULL,'2026-09-05 14:52:30'),(65,29,'2026-09-28','reserved',10,NULL,'2026-09-05 14:52:30'),(66,29,'2026-09-29','reserved',10,NULL,'2026-09-05 14:52:30'),(67,7,'2026-09-24','reserved',11,NULL,'2026-09-17 20:13:37'),(68,7,'2026-09-25','reserved',11,NULL,'2026-09-17 20:13:37'),(69,7,'2026-09-26','reserved',11,NULL,'2026-09-17 20:13:37'),(70,7,'2026-09-27','reserved',11,NULL,'2026-09-17 20:13:37'),(71,7,'2026-09-28','reserved',11,NULL,'2026-09-17 20:13:37'),(72,7,'2026-09-29','reserved',11,NULL,'2026-09-17 20:13:37');
/*!40000 ALTER TABLE `property_availability` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property_images`
--

DROP TABLE IF EXISTS `property_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `property_images` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `property_id` bigint(20) unsigned NOT NULL,
  `path` varchar(255) NOT NULL,
  `is_primary` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` int(10) unsigned NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `property_images_property_id_index` (`property_id`),
  CONSTRAINT `property_images_property_id_foreign` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property_images`
--

LOCK TABLES `property_images` WRITE;
/*!40000 ALTER TABLE `property_images` DISABLE KEYS */;
INSERT INTO `property_images` VALUES (1,1,'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=1200&h=800&fit=crop',1,0,'2026-08-18 02:52:31'),(2,1,'https://images.unsplash.com/photo-1560448204-e02f11c45751?w=800&h=600&fit=crop',0,1,'2026-08-18 02:52:31'),(3,2,'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=1200&h=800&fit=crop',1,0,'2026-08-18 02:52:31'),(4,2,'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800&h=600&fit=crop',0,1,'2026-08-18 02:52:31'),(5,3,'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=1200&h=800&fit=crop',1,0,'2026-08-18 02:52:31'),(6,4,'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=1200&h=800&fit=crop',1,0,'2026-08-18 02:52:31'),(7,5,'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?w=1200&h=800&fit=crop',1,0,'2026-08-18 02:52:31'),(8,1,'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800&h=600&fit=crop',0,2,'2026-08-18 03:11:03'),(9,1,'https://images.unsplash.com/photo-1556912173-46c336c7fd55?w=800&h=600&fit=crop',0,3,'2026-08-18 03:11:03'),(10,1,'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?w=800&h=600&fit=crop',0,4,'2026-08-18 03:11:03'),(11,1,'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?w=800&h=600&fit=crop',0,5,'2026-08-18 03:11:03'),(12,2,'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800&h=600&fit=crop',0,2,'2026-08-18 04:10:17'),(13,2,'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800&h=600&fit=crop',0,3,'2026-08-18 04:10:17'),(14,3,'https://images.unsplash.com/photo-1560448204-e02f11c45751?w=800&h=600&fit=crop',0,1,'2026-08-18 04:10:17'),(15,3,'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800&h=600&fit=crop',0,2,'2026-08-18 04:10:17'),(16,3,'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?w=800&h=600&fit=crop',0,3,'2026-08-18 04:10:17'),(17,4,'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800&h=600&fit=crop',0,1,'2026-08-18 04:10:17'),(18,4,'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800&h=600&fit=crop',0,2,'2026-08-18 04:10:17'),(19,4,'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=800&h=600&fit=crop',0,3,'2026-08-18 04:10:17'),(20,5,'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?w=800&h=600&fit=crop',0,1,'2026-08-18 04:10:17'),(21,5,'https://images.unsplash.com/photo-1560448204-e02f11c45751?w=800&h=600&fit=crop',0,2,'2026-08-18 04:10:17'),(22,5,'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800&h=600&fit=crop',0,3,'2026-08-18 04:10:17'),(23,6,'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800&h=600&fit=crop',1,0,'2026-08-18 04:51:58'),(24,6,'https://images.unsplash.com/photo-1560448204-e02f11c45751?w=800&h=600&fit=crop',0,1,'2026-08-18 04:51:58'),(25,6,'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800&h=600&fit=crop',0,2,'2026-08-18 04:51:58'),(26,6,'https://images.unsplash.com/photo-1556912173-46c336c7fd55?w=800&h=600&fit=crop',0,3,'2026-08-18 04:51:58'),(27,7,'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800&h=600&fit=crop',1,0,'2026-08-18 04:51:58'),(28,7,'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800&h=600&fit=crop',0,1,'2026-08-18 04:51:58'),(29,7,'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?w=800&h=600&fit=crop',0,2,'2026-08-18 04:51:58'),(30,7,'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?w=800&h=600&fit=crop',0,3,'2026-08-18 04:51:58'),(31,8,'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=800&h=600&fit=crop',1,0,'2026-08-18 04:51:58'),(32,8,'https://images.unsplash.com/photo-1600585154526-990dced4db0d?w=800&h=600&fit=crop',0,1,'2026-08-18 04:51:58'),(33,8,'https://images.unsplash.com/photo-1600047509807-ba8f99d2cd7a?w=800&h=600&fit=crop',0,2,'2026-08-18 04:51:58'),(34,8,'https://images.unsplash.com/photo-1600210492494-03fe3c5fbf0a?w=800&h=600&fit=crop',0,3,'2026-08-18 04:51:58'),(35,9,'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800&h=600&fit=crop',1,0,'2026-08-18 04:51:58'),(36,9,'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800&h=600&fit=crop',0,1,'2026-08-18 04:51:58'),(37,9,'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?w=800&h=600&fit=crop',0,2,'2026-08-18 04:51:58'),(38,9,'https://images.unsplash.com/photo-1560448204-e02f11c45751?w=800&h=600&fit=crop',0,3,'2026-08-18 04:51:58'),(39,10,'https://images.unsplash.com/photo-1600047509358-9dc75507de08?w=800&h=600&fit=crop',1,0,'2026-08-18 04:51:58'),(40,10,'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800&h=600&fit=crop',0,1,'2026-08-18 04:51:58'),(41,10,'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800&h=600&fit=crop',0,2,'2026-08-18 04:51:58'),(42,10,'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=800&h=600&fit=crop',0,3,'2026-08-18 04:51:58'),(43,11,'https://images.unsplash.com/photo-1600566753086-00f18fb576b9?w=800&h=600&fit=crop',1,0,'2026-08-18 04:51:58'),(44,11,'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800&h=600&fit=crop',0,1,'2026-08-18 04:51:58'),(45,11,'https://images.unsplash.com/photo-1556912173-46c336c7fd55?w=800&h=600&fit=crop',0,2,'2026-08-18 04:51:58'),(46,11,'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800&h=600&fit=crop',0,3,'2026-08-18 04:51:58'),(47,12,'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800&h=600&fit=crop',1,0,'2026-08-18 04:51:58'),(48,12,'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?w=800&h=600&fit=crop',0,1,'2026-08-18 04:51:58'),(49,12,'https://images.unsplash.com/photo-1560448204-e02f11c45751?w=800&h=600&fit=crop',0,2,'2026-08-18 04:51:58'),(50,12,'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800&h=600&fit=crop',0,3,'2026-08-18 04:51:58'),(51,13,'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=800&h=600&fit=crop',1,0,'2026-08-18 04:51:58'),(52,13,'https://images.unsplash.com/photo-1600047509807-ba8f99d2cd7a?w=800&h=600&fit=crop',0,1,'2026-08-18 04:51:58'),(53,13,'https://images.unsplash.com/photo-1600210492494-03fe3c5fbf0a?w=800&h=600&fit=crop',0,2,'2026-08-18 04:51:58'),(54,13,'https://images.unsplash.com/photo-1600585154526-990dced4db0d?w=800&h=600&fit=crop',0,3,'2026-08-18 04:51:58'),(55,14,'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800&h=600&fit=crop',1,0,'2026-08-18 04:51:58'),(56,14,'https://images.unsplash.com/photo-1560448204-e02f11c45751?w=800&h=600&fit=crop',0,1,'2026-08-18 04:51:58'),(57,14,'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?w=800&h=600&fit=crop',0,2,'2026-08-18 04:51:58'),(58,14,'https://images.unsplash.com/photo-1556912173-46c336c7fd55?w=800&h=600&fit=crop',0,3,'2026-08-18 04:51:58'),(59,15,'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?w=800&h=600&fit=crop',1,0,'2026-08-18 04:51:58'),(60,15,'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800&h=600&fit=crop',0,1,'2026-08-18 04:51:58'),(61,15,'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800&h=600&fit=crop',0,2,'2026-08-18 04:51:58'),(62,15,'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800&h=600&fit=crop',0,3,'2026-08-18 04:51:58'),(63,16,'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800&h=600&fit=crop',1,0,'2026-08-18 04:51:58'),(64,16,'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?w=800&h=600&fit=crop',0,1,'2026-08-18 04:51:58'),(65,16,'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800&h=600&fit=crop',0,2,'2026-08-18 04:51:58'),(66,16,'https://images.unsplash.com/photo-1560448204-e02f11c45751?w=800&h=600&fit=crop',0,3,'2026-08-18 04:51:58'),(67,17,'https://images.unsplash.com/photo-1600566753086-00f18fb576b9?w=800&h=600&fit=crop',1,0,'2026-08-18 04:51:58'),(68,17,'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800&h=600&fit=crop',0,1,'2026-08-18 04:51:58'),(69,17,'https://images.unsplash.com/photo-1556912173-46c336c7fd55?w=800&h=600&fit=crop',0,2,'2026-08-18 04:51:58'),(70,17,'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=800&h=600&fit=crop',0,3,'2026-08-18 04:51:58'),(71,18,'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800&h=600&fit=crop',1,0,'2026-08-18 04:51:58'),(72,18,'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800&h=600&fit=crop',0,1,'2026-08-18 04:51:58'),(73,18,'https://images.unsplash.com/photo-1560448204-e02f11c45751?w=800&h=600&fit=crop',0,2,'2026-08-18 04:51:58'),(74,18,'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?w=800&h=600&fit=crop',0,3,'2026-08-18 04:51:58'),(75,19,'https://images.unsplash.com/photo-1600047509358-9dc75507de08?w=800&h=600&fit=crop',1,0,'2026-08-18 04:51:58'),(76,19,'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?w=800&h=600&fit=crop',0,1,'2026-08-18 04:51:58'),(77,19,'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800&h=600&fit=crop',0,2,'2026-08-18 04:51:58'),(78,19,'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?w=800&h=600&fit=crop',0,3,'2026-08-18 04:51:58'),(79,20,'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?w=800&h=600&fit=crop',1,0,'2026-08-18 04:51:58'),(80,20,'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800&h=600&fit=crop',0,1,'2026-08-18 04:51:58'),(81,20,'https://images.unsplash.com/photo-1560448204-e02f11c45751?w=800&h=600&fit=crop',0,2,'2026-08-18 04:51:58'),(82,20,'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800&h=600&fit=crop',0,3,'2026-08-18 04:51:58'),(83,21,'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800&h=600&fit=crop',1,0,'2026-08-18 04:51:58'),(84,21,'https://images.unsplash.com/photo-1600566753086-00f18fb576b9?w=800&h=600&fit=crop',0,1,'2026-08-18 04:51:58'),(85,21,'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=800&h=600&fit=crop',0,2,'2026-08-18 04:51:58'),(86,21,'https://images.unsplash.com/photo-1600210492494-03fe3c5fbf0a?w=800&h=600&fit=crop',0,3,'2026-08-18 04:51:58'),(87,22,'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=800&h=600&fit=crop',1,0,'2026-08-18 04:51:58'),(88,22,'https://images.unsplash.com/photo-1600047509807-ba8f99d2cd7a?w=800&h=600&fit=crop',0,1,'2026-08-18 04:51:58'),(89,22,'https://images.unsplash.com/photo-1600585154526-990dced4db0d?w=800&h=600&fit=crop',0,2,'2026-08-18 04:51:58'),(90,22,'https://images.unsplash.com/photo-1600047509358-9dc75507de08?w=800&h=600&fit=crop',0,3,'2026-08-18 04:51:58'),(91,23,'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800&h=600&fit=crop',1,0,'2026-08-18 04:51:58'),(92,23,'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?w=800&h=600&fit=crop',0,1,'2026-08-18 04:51:58'),(93,23,'https://images.unsplash.com/photo-1560448204-e02f11c45751?w=800&h=600&fit=crop',0,2,'2026-08-18 04:51:58'),(94,23,'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800&h=600&fit=crop',0,3,'2026-08-18 04:51:58'),(95,24,'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?w=800&h=600&fit=crop',1,0,'2026-08-18 04:51:58'),(96,24,'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800&h=600&fit=crop',0,1,'2026-08-18 04:51:58'),(97,24,'https://images.unsplash.com/photo-1556912173-46c336c7fd55?w=800&h=600&fit=crop',0,2,'2026-08-18 04:51:58'),(98,24,'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800&h=600&fit=crop',0,3,'2026-08-18 04:51:58'),(99,25,'https://images.unsplash.com/photo-1600566753086-00f18fb576b9?w=800&h=600&fit=crop',1,0,'2026-08-18 04:51:58'),(100,25,'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800&h=600&fit=crop',0,1,'2026-08-18 04:51:58'),(101,25,'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800&h=600&fit=crop',0,2,'2026-08-18 04:51:58'),(102,25,'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=800&h=600&fit=crop',0,3,'2026-08-18 04:51:58'),(103,28,'uploads/properties/28/7fd4d7da537ff6df.webp',1,0,'2026-08-21 16:52:30'),(104,28,'uploads/properties/28/bbb9d55854cd1d19.webp',0,1,'2026-08-21 16:52:31'),(105,28,'uploads/properties/28/3ddf12d678f705b1.webp',0,2,'2026-08-21 16:52:31'),(106,28,'uploads/properties/28/0acbe4254ccb7656.webp',0,3,'2026-08-21 16:52:31'),(107,28,'uploads/properties/28/f14933c6756dca4d.webp',0,4,'2026-08-21 16:52:31'),(108,29,'uploads/properties/29/6dd7fe5b4bb21f01.webp',1,0,'2026-08-23 11:58:52'),(109,29,'uploads/properties/29/86ccaaf22c715aab.webp',0,1,'2026-08-23 11:58:52'),(110,29,'uploads/properties/29/43be78013ef73c19.webp',0,2,'2026-08-23 11:58:53'),(111,29,'uploads/properties/29/c99d0dc90e3b66cd.webp',0,3,'2026-08-23 11:58:53');
/*!40000 ALTER TABLE `property_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property_prices`
--

DROP TABLE IF EXISTS `property_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `property_prices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `property_id` bigint(20) unsigned NOT NULL,
  `price_per_night` decimal(12,2) DEFAULT NULL,
  `price_per_week` decimal(12,2) DEFAULT NULL,
  `price_per_month` decimal(12,2) DEFAULT NULL,
  `currency` char(3) NOT NULL DEFAULT 'XOF',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `property_prices_property_id_unique` (`property_id`),
  CONSTRAINT `property_prices_property_id_foreign` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property_prices`
--

LOCK TABLES `property_prices` WRITE;
/*!40000 ALTER TABLE `property_prices` DISABLE KEYS */;
INSERT INTO `property_prices` VALUES (1,1,30000.00,180000.00,650000.00,'XOF','2026-08-18 02:52:31','2026-08-18 02:52:31'),(2,2,75000.00,450000.00,1500000.00,'XOF','2026-08-18 02:52:31','2026-08-18 02:52:31'),(3,3,15000.00,90000.00,320000.00,'XOF','2026-08-18 02:52:31','2026-08-18 02:52:31'),(4,4,20000.00,120000.00,450000.00,'XOF','2026-08-18 02:52:31','2026-08-18 02:52:31'),(5,5,8000.00,48000.00,180000.00,'XOF','2026-08-18 02:52:31','2026-08-18 02:52:31'),(6,6,25000.00,150000.00,550000.00,'XOF','2026-08-18 04:51:58','2026-08-18 04:51:58'),(7,7,32000.00,190000.00,680000.00,'XOF','2026-08-18 04:51:58','2026-08-18 04:51:58'),(8,8,85000.00,500000.00,1700000.00,'XOF','2026-08-18 04:51:58','2026-08-18 04:51:58'),(9,9,45000.00,270000.00,950000.00,'XOF','2026-08-18 04:51:58','2026-08-18 04:51:58'),(10,10,55000.00,330000.00,1100000.00,'XOF','2026-08-18 04:51:58','2026-08-18 04:51:58'),(11,11,28000.00,165000.00,580000.00,'XOF','2026-08-18 04:51:58','2026-08-18 04:51:58'),(12,12,12000.00,72000.00,260000.00,'XOF','2026-08-18 04:51:58','2026-08-18 04:51:58'),(13,13,65000.00,380000.00,1300000.00,'XOF','2026-08-18 04:51:58','2026-08-18 04:51:58'),(14,14,18000.00,108000.00,400000.00,'XOF','2026-08-18 04:51:58','2026-08-18 04:51:58'),(15,15,22000.00,130000.00,470000.00,'XOF','2026-08-18 04:51:58','2026-08-18 04:51:58'),(16,16,10000.00,60000.00,220000.00,'XOF','2026-08-18 04:51:58','2026-08-18 04:51:58'),(17,17,20000.00,120000.00,430000.00,'XOF','2026-08-18 04:51:58','2026-08-18 04:51:58'),(18,18,17000.00,100000.00,360000.00,'XOF','2026-08-18 04:51:58','2026-08-18 04:51:58'),(19,19,15000.00,90000.00,320000.00,'XOF','2026-08-18 04:51:58','2026-08-18 04:51:58'),(20,20,9000.00,54000.00,195000.00,'XOF','2026-08-18 04:51:58','2026-08-18 04:51:58'),(21,21,24000.00,140000.00,500000.00,'XOF','2026-08-18 04:51:58','2026-08-18 04:51:58'),(22,22,70000.00,410000.00,1400000.00,'XOF','2026-08-18 04:51:58','2026-08-18 04:51:58'),(23,23,14000.00,84000.00,300000.00,'XOF','2026-08-18 04:51:58','2026-08-18 04:51:58'),(24,24,26000.00,155000.00,560000.00,'XOF','2026-08-18 04:51:58','2026-08-18 04:51:58'),(25,25,19000.00,114000.00,410000.00,'XOF','2026-08-18 04:51:58','2026-08-18 04:51:58'),(26,26,15000.00,NULL,NULL,'XOF','2026-08-18 22:36:23','2026-08-18 22:41:09'),(27,27,12000.00,NULL,NULL,'XOF','2026-08-21 16:48:57','2026-08-21 16:48:57'),(28,28,12000.00,NULL,NULL,'XOF','2026-08-21 16:52:30','2026-08-23 11:00:22'),(29,29,10000.00,NULL,NULL,'XOF','2026-08-23 11:58:52','2026-08-23 11:58:53');
/*!40000 ALTER TABLE `property_prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reports` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `reporter_id` bigint(20) unsigned NOT NULL,
  `reportable_type` enum('property','land','user','review','message') NOT NULL,
  `reportable_id` bigint(20) unsigned NOT NULL,
  `reason` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `status` enum('pending','reviewed','resolved','dismissed') NOT NULL DEFAULT 'pending',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `reports_reporter_id_foreign` (`reporter_id`),
  KEY `reports_status_index` (`status`),
  CONSTRAINT `reports_reporter_id_foreign` FOREIGN KEY (`reporter_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
INSERT INTO `reports` VALUES (1,7,'property',5,'description_inexacte','Les photos ne correspondent pas à la chambre actuelle.','resolved','2026-08-18 02:52:31','2026-09-01 22:39:15');
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reviews` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `property_id` bigint(20) unsigned NOT NULL,
  `booking_id` bigint(20) unsigned NOT NULL,
  `rating` tinyint(3) unsigned NOT NULL,
  `comment` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `reviews_booking_id_unique` (`booking_id`),
  KEY `reviews_property_id_index` (`property_id`),
  KEY `reviews_user_id_index` (`user_id`),
  CONSTRAINT `reviews_booking_id_foreign` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reviews_property_id_foreign` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reviews_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reviews_rating_check` CHECK (`rating` between 1 and 5)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,3,1,1,5,'Excellent séjour ! Appartement très propre et bien situé.','2026-08-18 02:52:31');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrateur','admin','Accès complet à la plateforme'),(2,'Client','client','Recherche, réserve et paie'),(3,'Propriétaire','owner','Publie et gère des logements'),(4,'Vendeur terrain','land_seller','Publie et vend des terrains'),(5,'Agence immobilière','agency','Gère des annonces pour une agence immobilière');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) NOT NULL,
  `applied_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `schema_migrations_migration_unique` (`migration`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES (1,'001_establishments.sql','2026-09-17 18:30:40'),(2,'002_amenity_salon_meuble.sql','2026-09-17 18:30:40'),(3,'003_listing_images.sql','2026-09-17 18:30:40'),(4,'004_role_agency.sql','2026-09-17 18:30:40'),(5,'005_establishments_location.sql','2026-09-17 18:30:40'),(6,'006_conversations_listing.sql','2026-09-17 18:46:45'),(7,'007_bookings_auto_confirm.sql','2026-09-17 18:46:45'),(8,'008_land_dimensions.sql','2026-09-17 18:46:45'),(9,'009_land_paper_type.sql','2026-09-17 18:46:45'),(10,'010_land_paper_type_trim.sql','2026-09-17 18:46:45'),(11,'011_property_video.sql','2026-09-17 18:46:45'),(12,'012_admin_zig_user.sql','2026-09-17 18:46:45'),(13,'013_admin_agency.sql','2026-09-17 18:46:45'),(14,'014_construction_projects.sql','2026-09-17 18:46:45'),(15,'015_moderation_actions.sql','2026-09-17 18:46:45'),(16,'016_contract_rental_fields.sql','2026-09-17 18:46:45'),(17,'017_contract_images.sql','2026-09-17 18:46:45'),(18,'018_contract_rental_duration.sql','2026-09-17 18:46:45'),(19,'019_booking_review_reminder.sql','2026-09-17 18:46:45'),(20,'020_booking_confirmation_pin.sql','2026-09-17 18:46:45'),(21,'021_booking_confirmation_email_sent.sql','2026-09-17 18:46:45'),(22,'022_admin_mourtalla.sql','2026-09-18 21:49:30');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `setting_key` varchar(100) NOT NULL,
  `value` text NOT NULL,
  `type` enum('string','integer','float','boolean','json') NOT NULL DEFAULT 'string',
  `description` varchar(255) DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_key_unique` (`setting_key`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (1,'commission_rate','10','float','Taux de commission plateforme (%)','2026-08-18 02:52:31'),(2,'currency_default','XOF','string','Devise par défaut','2026-08-18 02:52:31'),(3,'booking_min_nights','1','integer','Nombre minimum de nuits','2026-08-18 02:52:31'),(4,'site_name','Zig Imobilier — Casamance','string','Nom du site','2026-08-18 03:18:37'),(5,'email_verification','true','boolean','Vérification email obligatoire','2026-08-18 02:52:31');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_roles` (
  `user_id` bigint(20) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `user_roles_role_id_foreign` (`role_id`),
  CONSTRAINT `user_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_roles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES (1,1),(2,2),(2,3),(3,2),(4,3),(5,2),(5,4),(6,4),(7,2),(8,2),(8,3),(9,2),(9,3),(9,5),(10,1),(10,3),(10,5),(11,2),(11,3),(12,2),(13,1),(13,3);
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(191) NOT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `email_verified_at` datetime DEFAULT NULL,
  `status` enum('active','inactive','banned') NOT NULL DEFAULT 'active',
  `last_login_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_status_index` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin','Zig','admin@zig-imobilier.sn','+221770000001','$2y$12$VkfqtRMsEBdiQ61e9YoGceFdq9c2SSEZ08U9/tWmsNz.9tTqxa.KO',NULL,'2026-08-18 02:52:31','active',NULL,'2026-08-18 02:52:31','2026-08-18 02:52:31',NULL),(2,'Amadou','Diallo','amadou.diallo@email.sn','+221770000002','$2y$12$VkfqtRMsEBdiQ61e9YoGceFdq9c2SSEZ08U9/tWmsNz.9tTqxa.KO',NULL,'2026-08-18 02:52:31','active',NULL,'2026-08-18 02:52:31','2026-08-18 02:52:31',NULL),(3,'Fatou','Sow','fatou.sow@email.sn','+221770000003','$2y$12$VkfqtRMsEBdiQ61e9YoGceFdq9c2SSEZ08U9/tWmsNz.9tTqxa.KO',NULL,'2026-08-18 02:52:31','active',NULL,'2026-08-18 02:52:31','2026-08-18 02:52:31',NULL),(4,'Moussa','Ndiaye','moussa.ndiaye@email.sn','+221770000004','$2y$12$VkfqtRMsEBdiQ61e9YoGceFdq9c2SSEZ08U9/tWmsNz.9tTqxa.KO',NULL,'2026-08-18 02:52:31','active',NULL,'2026-08-18 02:52:31','2026-08-18 02:52:31',NULL),(5,'Aïssatou','Ba','aissatou.ba@email.sn','+221770000005','$2y$12$VkfqtRMsEBdiQ61e9YoGceFdq9c2SSEZ08U9/tWmsNz.9tTqxa.KO',NULL,'2026-08-18 02:52:31','active',NULL,'2026-08-18 02:52:31','2026-08-18 02:52:31',NULL),(6,'Ibrahima','Fall','ibrahima.fall@email.sn','+221770000006','$2y$12$VkfqtRMsEBdiQ61e9YoGceFdq9c2SSEZ08U9/tWmsNz.9tTqxa.KO',NULL,'2026-08-18 02:52:31','active',NULL,'2026-08-18 02:52:31','2026-08-18 02:52:31',NULL),(7,'Mariama','Diop','mariama.diop@email.sn','+221770000007','$2y$12$VkfqtRMsEBdiQ61e9YoGceFdq9c2SSEZ08U9/tWmsNz.9tTqxa.KO',NULL,'2026-08-18 02:52:31','active',NULL,'2026-08-18 02:52:31','2026-08-18 02:52:31',NULL),(8,'vroling','mendy','vrolingmendy0@gmail.com',NULL,'$2y$12$nlZP5I0IF8.vxyRd/X.EfOrojVyWO8/4UCQzw2HgfZUgQSpsBgwRO',NULL,NULL,'active','2026-09-18 21:57:10','2026-08-18 13:17:48','2026-09-18 21:57:10',NULL),(9,'vroling','.','vrolingmendes@gmail.com','+221776110061','$2y$12$yhPnMre8VbB6KwMpaJ60SewNf1MovVu0kmkpOFH/Q1cwTAzHOCZW2',NULL,NULL,'active','2026-09-01 20:45:07','2026-08-21 16:41:12','2026-09-01 20:45:07',NULL),(10,'Super','Admin','admin@zig.com',NULL,'$2y$12$rkXQysg6JNjGWRAoOgiLzuPymMdAEuFonuJ1gyvPeOhojcvlcNCvi',NULL,'2026-09-01 21:55:09','active','2026-09-19 19:03:26','2026-09-01 21:55:09','2026-09-19 19:03:26',NULL),(11,'vroling','Mendes','vroling@gmail.com',NULL,'$2y$12$cBpaF6SKYjKpFeh/fayEc.Bm8wyqzf50on4IpKvX1d8RTqgh1TFNS',NULL,NULL,'active',NULL,'2026-09-05 14:52:01','2026-09-05 14:52:01',NULL),(12,'vroling','mendy','vroling@groupeisi.com',NULL,'$2y$12$fyRp5vye0ma0ivG.r4lmMeMP2teNL/4Ga8wm8c/rUIDnbZkuJS2hi',NULL,NULL,'active','2026-09-17 20:12:27','2026-09-17 17:34:51','2026-09-17 20:12:27',NULL),(13,'Mourtalla','Fallou Diouf','mourtallafalloudiouf@gmail.com',NULL,'$2y$12$roq35IazXJ7YeVJZx8LRye0liW2t9AHTD51KuHS0RRKzxHzx2gcHC',NULL,'2026-09-18 21:49:30','active','2026-09-19 18:59:32','2026-09-18 21:49:30','2026-09-19 18:59:32',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-19 19:08:55
