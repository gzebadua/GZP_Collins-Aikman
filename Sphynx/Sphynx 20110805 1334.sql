-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.0.91-log


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema websphynx
--

CREATE DATABASE IF NOT EXISTS websphynx;
USE websphynx;

--
-- Definition of table `companies`
--

DROP TABLE IF EXISTS `companies`;
CREATE TABLE `companies` (
  `icompanyid` int(11) NOT NULL,
  `iplantid` int(11) NOT NULL,
  `scompanyname` varchar(500) NOT NULL,
  `splantname` varchar(200) NOT NULL,
  `bactive` int(1) NOT NULL,
  `remotesystemandport` varchar(20) NOT NULL,
  `blinkageactive` int(1) NOT NULL,
  `lastreviewingusername` varchar(100) NOT NULL,
  `lastreviewingdate` datetime NOT NULL,
  PRIMARY KEY  (`icompanyid`,`iplantid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `companies`
--

/*!40000 ALTER TABLE `companies` DISABLE KEYS */;
/*!40000 ALTER TABLE `companies` ENABLE KEYS */;


--
-- Definition of table `errorlogs`
--

DROP TABLE IF EXISTS `errorlogs`;
CREATE TABLE `errorlogs` (
  `querydate` datetime NOT NULL,
  `serror` varchar(5000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `errorlogs`
--

/*!40000 ALTER TABLE `errorlogs` DISABLE KEYS */;
/*!40000 ALTER TABLE `errorlogs` ENABLE KEYS */;


--
-- Definition of table `forecasts`
--

DROP TABLE IF EXISTS `forecasts`;
CREATE TABLE `forecasts` (
  `icompanyid` int(11) NOT NULL,
  `iplantid` int(11) NOT NULL,
  `ipartid` int(20) NOT NULL,
  `forecasteddate` datetime NOT NULL,
  `dquantity` decimal(16,3) NOT NULL,
  PRIMARY KEY  USING BTREE (`icompanyid`,`iplantid`,`ipartid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `forecasts`
--

/*!40000 ALTER TABLE `forecasts` DISABLE KEYS */;
/*!40000 ALTER TABLE `forecasts` ENABLE KEYS */;


--
-- Definition of table `invoicedetails`
--

DROP TABLE IF EXISTS `invoicedetails`;
CREATE TABLE `invoicedetails` (
  `icompanyid` int(11) NOT NULL,
  `iinvoiceid` int(11) NOT NULL,
  `iinvoicedetailsid` int(20) default NULL,
  `ishipmentdetailsid` int(20) default NULL,
  `ipartid` int(20) default NULL,
  `dquantity` decimal(16,3) NOT NULL,
  `scurrency` varchar(4) NOT NULL,
  `damount` decimal(15,2) NOT NULL,
  PRIMARY KEY  (`iinvoiceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `invoicedetails`
--

/*!40000 ALTER TABLE `invoicedetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoicedetails` ENABLE KEYS */;


--
-- Definition of table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
CREATE TABLE `invoices` (
  `icompanyid` int(11) NOT NULL,
  `iinvoiceid` int(11) NOT NULL,
  `scurrency` varchar(4) NOT NULL,
  `invoicedate` datetime NOT NULL,
  `invoicepaymentdate` datetime NOT NULL,
  PRIMARY KEY  (`icompanyid`,`iinvoiceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `invoices`
--

/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoices` ENABLE KEYS */;


--
-- Definition of table `labels`
--

DROP TABLE IF EXISTS `labels`;
CREATE TABLE `labels` (
  `spage` varchar(50) NOT NULL,
  `slabel` varchar(70) NOT NULL,
  `esmx` varchar(5000) NOT NULL,
  `enus` varchar(5000) NOT NULL,
  `frfr` varchar(5000) NOT NULL,
  PRIMARY KEY  (`spage`,`slabel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `labels`
--

/*!40000 ALTER TABLE `labels` DISABLE KEYS */;
INSERT INTO `labels` (`spage`,`slabel`,`esmx`,`enus`,`frfr`) VALUES 
 ('login.aspx','btnGetMyPass','Obtener mi contrase&ntilde;a','Get my password',''),
 ('login.aspx','btnLogin','Entrar','Login',''),
 ('login.aspx','lblLoginInstructions','Ingresa tu usuario y contrase&ntilde;a para continuar.','Type your username and password to login.',''),
 ('login.aspx','lblLostPassword','¿No te acuerdas de tu contrase&ntilde;a?','Lost password?',''),
 ('login.aspx','lblLostPasswordInstructions','Si no te acuerdas de tu contrase&ntilde;a, por favor ingresa tu usuario y las instrucciones para resetearlo te ser&aacute;n enviadas por correo electr&oacute;nico enseguida.','If you can not remember your password, please enter your username and instructions will be emailed to you shortly.',''),
 ('login.aspx','lblLostUsername','Mi usuario es:','My username is:',''),
 ('login.aspx','lblPassword','Contrase&ntilde;a:','Password:',''),
 ('login.aspx','lblShowCopyright','Todos los derechos reservados. 2006. Collins & Aikman, Liger Solutions. El uso de este sitio est&aacute; sujeto a los ','All rights reserved. 2006. Collins and Aikman, Liger Solutions. The use of this site is subject to the ',''),
 ('login.aspx','lblUsername','Usuario:','Username:',''),
 ('login.aspx','lblWelcome','Bienvenido a Sphynx.','Welcome to Sphynx.','Bienvenue á Sphynx.'),
 ('login.aspx','lblWrongUP','La combinaci&oacute;n usuario/contrase&ntilde;a no es v&aacute;lida.','Submitted username and passwords are not valid.',''),
 ('login.aspx','lnkLostPassword','Haz click aqu&iacute;','Click here',''),
 ('login.aspx','lnkTOS',' t&eacute;rminos de servicio.',' terms of service.',''),
 ('login.aspx','rfvPassword','La contrase&ntilde;a es un campo requerido.','The password is required.',''),
 ('login.aspx','rfvUsername','Debes especificar un usuario.','You must specify a username.',''),
 ('login.aspx','systemOutPart1','Lo sentimos, el sistema est&aacute; en mantenimiento.<br />\r\nEstaremos de vuelta en l&iacute;nea en ','We\'re sorry, the system is under maintenance.<br />\r\nWe will be back in ',''),
 ('login.aspx','whenWillSystemBeBackOnline','unas horas.','a few hours.',''),
 ('reopen.aspx','btnGetMyPass','Obtener mi contrase&ntilde;a','Get my password',''),
 ('reopen.aspx','btnLogin','Entrar','Login',''),
 ('reopen.aspx','lblLoginInstructions','Ingresa tu usuario y contrase&ntilde;a para continuar.','Type your username and password to login.',''),
 ('reopen.aspx','lblLostPassword','¿No te acuerdas de tu contrase&ntilde;a?','Lost password?',''),
 ('reopen.aspx','lblLostPasswordInstructions','Si no te acuerdas de tu contrase&ntilde;a, por favor ingresa tu usuario y las instrucciones para resetearlo te ser&aacute;n enviadas por correo electr&oacute;nico enseguida.','If you can not remember your password, please enter your username and instructions will be emailed to you shortly.',''),
 ('reopen.aspx','lblLostUsername','Mi usuario es:','My username is:',''),
 ('reopen.aspx','lblPassword','Contrase&ntilde;a:','Password:',''),
 ('reopen.aspx','lblShowCopyright','Todos los derechos reservados. 2006. Collins & Aikman, Liger Solutions. El uso de este sitio est&aacute; sujeto a los ','All rights reserved. 2006. Collins and Aikman, Liger Solutions. The use of this site is subject to the ',''),
 ('reopen.aspx','lblUsername','Usuario:','Username:',''),
 ('reopen.aspx','lblWelcome','Bienvenido a Sphynx.','Welcome to Sphynx.','Bienvenue á Sphynx.'),
 ('reopen.aspx','lblWrongUP','La combinaci&oacute;n usuario/contrase&ntilde;a no es v&aacute;lida.','Submitted username and passwords are not valid.',''),
 ('reopen.aspx','lnkLostPassword','Haz click aqu&iacute;','Click here',''),
 ('reopen.aspx','lnkTOS',' t&eacute;rminos de servicio.',' terms of service.',''),
 ('reopen.aspx','rfvPassword','La contrase&ntilde;a es un campo requerido.','The password is required.',''),
 ('reopen.aspx','rfvUsername','Debes especificar un usuario.','You must specify a username.',''),
 ('updateCompany.aspx','lblcfID','','',''),
 ('updateCompany.aspx','lblCompany','','',''),
 ('updateCompany.aspx','lblFacility','','',''),
 ('updateCompany.aspx','lblLibrary','','',''),
 ('updateCompany.aspx','lblName','','',''),
 ('updateCompany.aspx','lblRemoteSystem','','',''),
 ('updateCompany.aspx','lblStatus','','','');
/*!40000 ALTER TABLE `labels` ENABLE KEYS */;


--
-- Definition of table `languages`
--

DROP TABLE IF EXISTS `languages`;
CREATE TABLE `languages` (
  `ilanguageid` int(11) NOT NULL,
  `slanguagecode` varchar(4) NOT NULL,
  PRIMARY KEY  (`ilanguageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `languages`
--

/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` (`ilanguageid`,`slanguagecode`) VALUES 
 (1,'esmx'),
 (2,'enus'),
 (3,'frfr');
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;


--
-- Definition of table `longquerieslogs`
--

DROP TABLE IF EXISTS `longquerieslogs`;
CREATE TABLE `longquerieslogs` (
  `querydate` datetime NOT NULL,
  `squeryname` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `longquerieslogs`
--

/*!40000 ALTER TABLE `longquerieslogs` DISABLE KEYS */;
/*!40000 ALTER TABLE `longquerieslogs` ENABLE KEYS */;


--
-- Definition of table `modules`
--

DROP TABLE IF EXISTS `modules`;
CREATE TABLE `modules` (
  `smoduleid` varchar(20) NOT NULL,
  `surl` varchar(300) NOT NULL,
  `bshowInMenu` int(1) NOT NULL,
  `bStatus` int(1) NOT NULL,
  `spermissiongrantingusername` varchar(100) NOT NULL,
  `permissiongrantingdate` varchar(22) NOT NULL,
  `esmx_title` varchar(70) NOT NULL,
  `esmx_description` varchar(150) NOT NULL,
  `enus_title` varchar(70) NOT NULL,
  `enus_description` varchar(150) NOT NULL,
  `frfr_title` varchar(70) NOT NULL,
  `frfr_description` varchar(150) NOT NULL,
  PRIMARY KEY  (`smoduleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `modules`
--

/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
/*!40000 ALTER TABLE `modules` ENABLE KEYS */;


--
-- Definition of table `mrodetails`
--

DROP TABLE IF EXISTS `mrodetails`;
CREATE TABLE `mrodetails` (
  `imroid` int(20) NOT NULL,
  `imrodetailsid` int(20) NOT NULL,
  `slineid` varchar(50) NOT NULL,
  `ipartid` int(20) NOT NULL,
  `sdescription` varchar(500) NOT NULL,
  `sunits` varchar(10) NOT NULL,
  `dquantityordered` decimal(16,3) NOT NULL,
  `dvariationpercentageacceptable` decimal(3,0) NOT NULL,
  `duedate` datetime NOT NULL,
  `baccepted` int(1) NOT NULL,
  `scomments` varchar(500) NOT NULL,
  `sorderingusername` varchar(100) NOT NULL,
  `orderdate` datetime NOT NULL,
  `slastmodificationusername` varchar(100) NOT NULL,
  `lastmodificationdate` datetime NOT NULL,
  PRIMARY KEY  (`imroid`,`imrodetailsid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mrodetails`
--

/*!40000 ALTER TABLE `mrodetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `mrodetails` ENABLE KEYS */;


--
-- Definition of table `mros`
--

DROP TABLE IF EXISTS `mros`;
CREATE TABLE `mros` (
  `icompanyid` int(11) NOT NULL,
  `iplantid` int(11) NOT NULL,
  `ivendorid` int(11) NOT NULL,
  `imroid` int(20) NOT NULL,
  `description` varchar(500) NOT NULL,
  `orderdate` datetime NOT NULL,
  `bmrostatus` int(1) NOT NULL,
  `scurrency` varchar(4) NOT NULL,
  `dtotal` decimal(15,2) NOT NULL,
  `spublishingusername` varchar(100) NOT NULL,
  `publishingdate` datetime NOT NULL,
  `slastmodificationusername` varchar(100) NOT NULL,
  `lastmodificationdate` datetime NOT NULL,
  `sviewingusername` varchar(100) NOT NULL,
  `viewingdate` datetime NOT NULL,
  `sackusername` varchar(10) NOT NULL,
  `ackdate` datetime NOT NULL,
  PRIMARY KEY  (`icompanyid`,`iplantid`,`ivendorid`,`imroid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `mros`
--

/*!40000 ALTER TABLE `mros` DISABLE KEYS */;
/*!40000 ALTER TABLE `mros` ENABLE KEYS */;


--
-- Definition of table `orderdetails`
--

DROP TABLE IF EXISTS `orderdetails`;
CREATE TABLE `orderdetails` (
  `iorderid` int(20) NOT NULL,
  `iorderdetailsid` int(20) NOT NULL,
  `slineid` varchar(50) NOT NULL,
  `ipartid` int(20) NOT NULL,
  `sdescription` varchar(500) NOT NULL,
  `sunits` varchar(10) NOT NULL,
  `dquantityordered` decimal(16,3) NOT NULL,
  `dvariationpercentageacceptable` decimal(3,0) NOT NULL,
  `duedate` datetime NOT NULL,
  `baccepted` int(1) NOT NULL,
  `scomments` varchar(500) NOT NULL,
  `sorderingusername` varchar(100) NOT NULL,
  `orderdate` datetime NOT NULL,
  `slastmodificationusername` varchar(100) NOT NULL,
  `lastmodificationdate` datetime NOT NULL,
  PRIMARY KEY  (`iorderid`,`iorderdetailsid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orderdetails`
--

/*!40000 ALTER TABLE `orderdetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `orderdetails` ENABLE KEYS */;


--
-- Definition of table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `icompanyid` int(11) NOT NULL,
  `iplantid` int(11) NOT NULL,
  `iorderid` int(20) NOT NULL,
  `ivendorid` int(20) NOT NULL,
  `orderdate` datetime NOT NULL,
  `borderstatus` int(1) NOT NULL,
  `spublishingusername` varchar(100) NOT NULL,
  `publishingdate` datetime NOT NULL,
  `slastmodificationusername` varchar(100) NOT NULL,
  `lastmodificationdate` datetime NOT NULL,
  `sviewingusername` varchar(100) NOT NULL,
  `viewingdate` datetime NOT NULL,
  `sackusername` varchar(10) NOT NULL,
  `ackdate` datetime NOT NULL,
  PRIMARY KEY  (`icompanyid`,`iplantid`,`ivendorid`,`iorderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orders`
--

/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;


--
-- Definition of table `passwordresets`
--

DROP TABLE IF EXISTS `passwordresets`;
CREATE TABLE `passwordresets` (
  `ipasswordresetid` int(11) NOT NULL,
  `susername` varchar(100) NOT NULL,
  `sdateresethash` varchar(1000) NOT NULL,
  PRIMARY KEY  (`ipasswordresetid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `passwordresets`
--

/*!40000 ALTER TABLE `passwordresets` DISABLE KEYS */;
INSERT INTO `passwordresets` (`ipasswordresetid`,`susername`,`sdateresethash`) VALUES 
 (1,'memozebadua','aa');
/*!40000 ALTER TABLE `passwordresets` ENABLE KEYS */;


--
-- Definition of table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `susername` varchar(100) NOT NULL,
  `susersession` varchar(300) NOT NULL,
  `bloggedinsuccesfully` tinyint(1) NOT NULL,
  `btimedout` tinyint(1) NOT NULL,
  `blockedout` tinyint(1) NOT NULL,
  `bkickedout` tinyint(1) NOT NULL,
  `suserip` varchar(40) NOT NULL,
  `susermachinename` varchar(500) NOT NULL,
  `logindate` datetime NOT NULL,
  `logoutdate` datetime default NULL,
  PRIMARY KEY  (`susername`,`susersession`,`logindate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sessions`
--

/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` (`susername`,`susersession`,`bloggedinsuccesfully`,`btimedout`,`blockedout`,`bkickedout`,`suserip`,`susermachinename`,`logindate`,`logoutdate`) VALUES 
 ('memozebadua','aeasdaqweqwsdas',0,0,0,0,'192.168.1.106','POLARIS','2011-08-01 01:47:00',NULL),
 ('memozebadua','aeasdaqweqwsdas',0,0,0,0,'192.168.1.106','POLARIS','2011-08-01 01:48:00',NULL),
 ('memozebadua','aeasdaqweqwsdas',1,0,0,0,'192.168.1.106','POLARIS','2011-08-01 01:49:00',NULL);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;


--
-- Definition of table `shipmentdetails`
--

DROP TABLE IF EXISTS `shipmentdetails`;
CREATE TABLE `shipmentdetails` (
  `ishipmentid` int(20) NOT NULL,
  `icontainerid` int(20) NOT NULL,
  `iorderid` int(20) NOT NULL,
  `iorderdetailsid` int(20) NOT NULL,
  `dquantitysent` decimal(16,3) NOT NULL,
  PRIMARY KEY  (`ishipmentid`,`icontainerid`,`iorderid`,`iorderdetailsid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `shipmentdetails`
--

/*!40000 ALTER TABLE `shipmentdetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipmentdetails` ENABLE KEYS */;


--
-- Definition of table `shipments`
--

DROP TABLE IF EXISTS `shipments`;
CREATE TABLE `shipments` (
  `icompanyid` int(11) NOT NULL,
  `iplantid` int(11) NOT NULL,
  `ivendorid` int(11) NOT NULL,
  `ishipmentid` varchar(20) NOT NULL,
  `shipmentdatetime` datetime NOT NULL,
  `sfreightercompanyname` varchar(500) NOT NULL,
  `sfreighterlicenseplates` varchar(15) NOT NULL,
  `sdrivername` varchar(500) NOT NULL,
  `eta` datetime NOT NULL,
  `sshipmentpublishername` varchar(100) NOT NULL,
  `shipmentpublishingdate` datetime NOT NULL,
  `slastmodificationusername` varchar(100) NOT NULL,
  `lastmodificationdate` datetime NOT NULL,
  `sshipmentreceiverusername` varchar(100) NOT NULL,
  `shipmentreceiveddate` datetime NOT NULL,
  `sackusername` varchar(10) NOT NULL,
  `ackdate` datetime NOT NULL,
  PRIMARY KEY  (`icompanyid`,`iplantid`,`ivendorid`,`ishipmentid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `shipments`
--

/*!40000 ALTER TABLE `shipments` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipments` ENABLE KEYS */;


--
-- Definition of table `sqllogs`
--

DROP TABLE IF EXISTS `sqllogs`;
CREATE TABLE `sqllogs` (
  `ilogid` int(11) NOT NULL,
  `querydate` datetime NOT NULL,
  `susername` varchar(100) NOT NULL,
  `susersession` varchar(300) NOT NULL,
  `suserip` varchar(100) NOT NULL,
  `susermachinename` varchar(500) NOT NULL,
  `sactiondone` varchar(5000) NOT NULL,
  `sresult` varchar(5000) NOT NULL,
  PRIMARY KEY  (`ilogid`),
  KEY `username` USING BTREE (`susername`),
  KEY `user&session` (`susername`,`susersession`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sqllogs`
--

/*!40000 ALTER TABLE `sqllogs` DISABLE KEYS */;
INSERT INTO `sqllogs` (`ilogid`,`querydate`,`susername`,`susersession`,`suserip`,`susermachinename`,`sactiondone`,`sresult`) VALUES 
 (1,'2011-08-01 01:49:00','memozebadua','aeasdaqweqwsdas','192.168.1.106','POLARIS','Login Attempt from page login.aspx with a true result','1'),
 (2,'2011-08-01 02:08:00','memozebadua','aeasdaqweqwsdas','192.168.1.106','POLARIS','Login Attempt from page login.aspx with a false result','0'),
 (3,'2011-08-01 02:07:00','memozebadua','aeasdaqweqwsdas','192.168.1.106','POLARIS','Login Attempt from page login.aspx with a false result','0'),
 (4,'2011-08-01 02:06:00','memozebadua','aeasdaqweqwsdas','192.168.1.106','POLARIS','Login Attempt from page login.aspx with a false result','0');
/*!40000 ALTER TABLE `sqllogs` ENABLE KEYS */;


--
-- Definition of table `systemvariables`
--

DROP TABLE IF EXISTS `systemvariables`;
CREATE TABLE `systemvariables` (
  `svariable` varchar(100) NOT NULL,
  `svalue` varchar(3000) NOT NULL,
  PRIMARY KEY  (`svariable`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `systemvariables`
--

/*!40000 ALTER TABLE `systemvariables` DISABLE KEYS */;
INSERT INTO `systemvariables` (`svariable`,`svalue`) VALUES 
 ('minutesToTimeoutLessThan59','15'),
 ('multipleLogins','0'),
 ('systemOnline','0');
/*!40000 ALTER TABLE `systemvariables` ENABLE KEYS */;


--
-- Definition of table `usernotices`
--

DROP TABLE IF EXISTS `usernotices`;
CREATE TABLE `usernotices` (
  `inoticeid` int(11) NOT NULL,
  `susername` varchar(100) NOT NULL,
  `susersession` varchar(300) NOT NULL,
  `susernoticereason` varchar(500) NOT NULL,
  `snoticingusername` varchar(100) NOT NULL,
  `noticingdate` datetime NOT NULL,
  `bread` int(1) NOT NULL,
  `readdate` datetime NOT NULL,
  PRIMARY KEY  (`inoticeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `usernotices`
--

/*!40000 ALTER TABLE `usernotices` DISABLE KEYS */;
/*!40000 ALTER TABLE `usernotices` ENABLE KEYS */;


--
-- Definition of table `userpermissions`
--

DROP TABLE IF EXISTS `userpermissions`;
CREATE TABLE `userpermissions` (
  `susername` varchar(100) NOT NULL,
  `smoduleid` varchar(20) NOT NULL,
  `sgrantingusername` varchar(10) NOT NULL,
  `grantingdate` datetime NOT NULL,
  PRIMARY KEY  (`susername`,`smoduleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `userpermissions`
--

/*!40000 ALTER TABLE `userpermissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `userpermissions` ENABLE KEYS */;


--
-- Definition of table `userplants`
--

DROP TABLE IF EXISTS `userplants`;
CREATE TABLE `userplants` (
  `susername` varchar(100) NOT NULL,
  `iplantid` int(11) NOT NULL,
  `screatingusername` varchar(100) NOT NULL,
  `screatingdate` datetime NOT NULL,
  PRIMARY KEY  (`susername`,`iplantid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `userplants`
--

/*!40000 ALTER TABLE `userplants` DISABLE KEYS */;
/*!40000 ALTER TABLE `userplants` ENABLE KEYS */;


--
-- Definition of table `userprofiles`
--

DROP TABLE IF EXISTS `userprofiles`;
CREATE TABLE `userprofiles` (
  `susername` varchar(100) NOT NULL,
  `bIT` int(1) NOT NULL,
  `bAdmin` int(1) NOT NULL,
  PRIMARY KEY  (`susername`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `userprofiles`
--

/*!40000 ALTER TABLE `userprofiles` DISABLE KEYS */;
INSERT INTO `userprofiles` (`susername`,`bIT`,`bAdmin`) VALUES 
 ('memozebadua',1,0);
/*!40000 ALTER TABLE `userprofiles` ENABLE KEYS */;


--
-- Definition of table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `susername` varchar(100) NOT NULL,
  `suserpasswordhash` varchar(500) NOT NULL,
  `suserrescuequestion` varchar(100) NOT NULL,
  `suserrescueanswerhash` varchar(500) NOT NULL,
  `bactive` int(1) NOT NULL,
  `bonline` int(1) NOT NULL,
  `bapproved` int(1) NOT NULL,
  `blockedout` int(1) NOT NULL,
  `icompanyid` int(11) NOT NULL,
  `suserfullname` varchar(500) NOT NULL,
  `suserdesiredname` varchar(500) NOT NULL,
  `suseremail` varchar(300) NOT NULL,
  `spreferredlanguage` varchar(4) NOT NULL,
  `iuserlevel` int(11) NOT NULL,
  `sparentusername` varchar(100) NOT NULL,
  `screatingusername` varchar(100) NOT NULL,
  `screatingdate` datetime NOT NULL,
  `slastmodificationusername` varchar(100) NOT NULL,
  `slastmodificationdate` datetime NOT NULL,
  PRIMARY KEY  (`susername`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`susername`,`suserpasswordhash`,`suserrescuequestion`,`suserrescueanswerhash`,`bactive`,`bonline`,`bapproved`,`blockedout`,`icompanyid`,`suserfullname`,`suserdesiredname`,`suseremail`,`spreferredlanguage`,`iuserlevel`,`sparentusername`,`screatingusername`,`screatingdate`,`slastmodificationusername`,`slastmodificationdate`) VALUES 
 ('memozebadua','1','My father Middle name','1',1,0,1,0,1,'Guillermo Zebadua','Memo','memozebadua@gmail.com','enus',0,'','memozebadua','2011-01-01 00:00:00','memozebadua','2011-01-01 00:00:00');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;


--
-- Definition of table `vendors`
--

DROP TABLE IF EXISTS `vendors`;
CREATE TABLE `vendors` (
  `ivendorid` int(20) NOT NULL,
  `svendorname` varchar(500) NOT NULL,
  PRIMARY KEY  (`ivendorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `vendors`
--

/*!40000 ALTER TABLE `vendors` DISABLE KEYS */;
/*!40000 ALTER TABLE `vendors` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
