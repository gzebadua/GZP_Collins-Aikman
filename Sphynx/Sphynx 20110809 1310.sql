-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.1.45-community


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
  PRIMARY KEY (`icompanyid`,`iplantid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `companies`
--

/*!40000 ALTER TABLE `companies` DISABLE KEYS */;
INSERT INTO `companies` (`icompanyid`,`iplantid`,`scompanyname`,`splantname`,`bactive`,`remotesystemandport`,`blinkageactive`,`lastreviewingusername`,`lastreviewingdate`) VALUES 
 (1,1,'Liger Solutions','Queretaro',1,'',0,'memozebadua','2011-01-01 00:00:00');
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
  PRIMARY KEY (`icompanyid`,`iplantid`,`ipartid`) USING BTREE
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
  `iinvoicedetailsid` int(20) DEFAULT NULL,
  `ishipmentdetailsid` int(20) DEFAULT NULL,
  `ipartid` int(20) DEFAULT NULL,
  `dquantity` decimal(16,3) NOT NULL,
  `scurrency` varchar(4) NOT NULL,
  `damount` decimal(15,2) NOT NULL,
  PRIMARY KEY (`iinvoiceid`)
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
  PRIMARY KEY (`icompanyid`,`iinvoiceid`)
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
  `fr` varchar(5000) NOT NULL,
  PRIMARY KEY (`spage`,`slabel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `labels`
--

/*!40000 ALTER TABLE `labels` DISABLE KEYS */;
INSERT INTO `labels` (`spage`,`slabel`,`esmx`,`enus`,`fr`) VALUES 
 ('answerSecretQuestion.aspx','btnAnswer','Enviar Respuesta','Submit Answer','Envoyer Réponse'),
 ('answerSecretQuestion.aspx','lblSecretAnswer','Respuesta secreta:','Secret Answer:','R&eacute;ponse Secr&egrave;te:'),
 ('answerSecretQuestion.aspx','lblShowCopyright','Todos los derechos reservados. 2006. Collins & Aikman, Liger Solutions. El uso de este sitio est&aacute; sujeto a los ','All rights reserved. 2006. Collins and Aikman, Liger Solutions. The use of this site is subject to the ','Tous droits r&eacute;serv&eacute;s. 2006. Collins et Aikman, Solutions Liger. L\'utilisation de ce site est soumis &agrave; la '),
 ('answerSecretQuestion.aspx','lblWelcome','Hola Invitado! Por favor contesta tu respuesta secreta.','Hi Guest! Please answer your secret question.','Salut Visiteur! S\'il vous pla&icirc;t r&eacute;pondre &agrave; votre question secr&egrave;te.'),
 ('answerSecretQuestion.aspx','PageTitle','Contesta tu respuesta secreta :: Collins & Aikman Sphynx','Answer your Secret Question :: Collins & Aikman\'s Sphynx','Répondre à votre question secrète :: Collins et Aikman Sphynx'),
 ('answerSecretQuestion.aspx','rfvSecretAnswer','La respuesta secreta es requerida.','The secret answer is required.','La r&eacute;ponse secr&egrave;te est requise.'),
 ('answerSecretQuestion.aspx','welcomePart1','Bienvenido','Welcome','Bienvenue'),
 ('answerSecretQuestion.aspx','welcomePart2','Por favor contesta tu respuesta secreta.','Please answer your secret question.','S\'il vous pla&icirc;t r&eacute;pondre &agrave; votre question secr&egrave;te.'),
 ('login.aspx','alreadyLoggedIn','El usuario ya se encuentra dentro del sistema.','The user is already logged in.','L\'utilisateur est d&eacute;j&egrave; connect&eacute; po.'),
 ('login.aspx','btnCancel','Cancelar','Cancel','Annuler'),
 ('login.aspx','btnGetMyPass','Obtener mi contraseña','Get my password','Obtenir mon mot de passe'),
 ('login.aspx','btnLogin','Entrar','Login','Connectez-vous'),
 ('login.aspx','lblLoginInstructions','Ingresa tu usuario y contrase&ntilde;a para continuar.','Type your username and password to login.','Tapez votre identifiant et votre mot de passe pour vous connecter.'),
 ('login.aspx','lblLostPassword','¿No te acuerdas de tu contrase&ntilde;a?','Lost password?','Mot de passe perdu?'),
 ('login.aspx','lblLostPasswordInstructions','Si no te acuerdas de tu contrase&ntilde;a, por favor ingresa tu usuario y las instrucciones para resetearlo te ser&aacute;n enviadas por correo electr&oacute;nico enseguida.','If you can not remember your password, please enter your username and instructions will be emailed to you shortly.','Si vous ne vous souvenez de votre mot de passe, s\'il vous pla&icirc;t entrer votre nom d\'utilisateur et des instructions seront envoy&eacute;es par courriel &agrave; vous sous peu.'),
 ('login.aspx','lblLostUsername','Mi usuario es:','My username is:','Mon pseudo est:'),
 ('login.aspx','lblPassword','Contrase&ntilde;a:','Password:','Mot de passe:'),
 ('login.aspx','lblShowCopyright','Todos los derechos reservados. 2006. Collins & Aikman, Liger Solutions. El uso de este sitio est&aacute; sujeto a los ','All rights reserved. 2006. Collins and Aikman, Liger Solutions. The use of this site is subject to the ','Tous droits r&eacute;serv&eacute;s. 2006. Collins et Aikman, Solutions Liger. L\'utilisation de ce site est soumis &agrave; la '),
 ('login.aspx','lblUsername','Usuario:','Username:','Nom d\'utilisateur:'),
 ('login.aspx','lblWelcome','Bienvenido a Sphynx.','Welcome to Sphynx.','Bienvenue &aacute; Sphynx.'),
 ('login.aspx','lblWrongUP','La combinaci&oacute;n usuario/contrase&ntilde;a no es v&aacute;lida.','Submitted username and password are not valid.','Soumis identifiant et mot de passe ne sont pas valides.'),
 ('login.aspx','lnkLostPassword','Haz click aqu&iacute;','Click here','Cliquez ici'),
 ('login.aspx','lnkTOS',' t&eacute;rminos de servicio.',' terms of service.',' conditions de service.'),
 ('login.aspx','PageTitle','Iniciar Sesión :: Collins & Aikman Sphynx','Login :: Collins & Aikman\'s Sphynx','Connexion:: Sphynx Collins & Aikman'),
 ('login.aspx','passwordNotValid','La combinaci&oacute;n usuario/contrase&ntilde;a no es v&aacute;lida.','Submitted username and password are not valid.','Soumis identifiant et mot de passe ne sont pas valides.'),
 ('login.aspx','restoreYourPasswordEmailError','Ha ocurrido un error. Intenta nuevamente.','An error has ocurred. Try again.','Une erreur s\'est produite. Essayez &agrave; nouveau.'),
 ('login.aspx','restoreYourPasswordEmailSent','Un email con instrucciones debe llegar a tu bandeja en unos minutos.','An email with password reset instructions has been mailed to you and will be arriving shortly to your inbox.','Un e-mail avec les instructions de r&eacute;initialisation de mot de passe a &eacute;t&eacute; envoy&eacute; &agrave; vous et va arriver prochainement &agrave; votre bo&icirc;te de r&eacute;ception.'),
 ('login.aspx','restoreYourPasswordUsernameNotFound','No se ha encontrado el usuario.','Username not found.','Nom d\'utilisateur introuvable.'),
 ('login.aspx','rfvPassword','La contrase&ntilde;a es un campo requerido.','The password is required.','Le mot de passe est n&eacute;cessaire.'),
 ('login.aspx','rfvUsername','Debes especificar un usuario.','You must specify a username.','Vous devez sp&eacute;cifier un nom d\'utilisateur.'),
 ('login.aspx','systemOutPart1','Lo sentimos, el sistema est&aacute; en mantenimiento.<br />\r\nEstaremos de vuelta en l&iacute;nea en ','We\'re sorry, the system is under maintenance.<br />\r\nWe will be back in ','Nous sommes d&eacute;sol&eacute;s, le syst&egrave;me est en maintenance. <br />\r\nNous serons de retour dans '),
 ('login.aspx','tooManyUsers','Hay demasiados usuarios dentro de Sphynx ahora. Espera un momento e intenta de nuevo.','There are too many users in Sphynx right now. Please wait a moment and try again.','Il ya trop d\'utilisateurs dans le Sphynx en ce moment. S\'il vous pla&icirc;t attendez un moment et essayez &agrave; nouveau.'),
 ('login.aspx','userInactive','Acceso revocado por el administrador del sistema (Usuario inactivo).','Access denied by the system administrador (User inactive).','Acc&egrave;s refus&eacute; par l\'administrador syst&egrave;me (utilisateur inactif).'),
 ('login.aspx','userLockedOut','Has excedido el límite de intentos fallidos de sesi&oacute;n. Esta cuenta ha sido deshabilitada por ','You have exceeded the maximum number of failed logins. This user has been disabled for ','Vous avez d&eacute;pass&eacute; le nombre maximal de connexions qui ont &eacute;chou&eacute;. Cet utilisateur a &eacute;t&eacute; d&eacute;sactiv&eacute; pour '),
 ('login.aspx','userLockedOut2','minutos','minutes','minutes'),
 ('login.aspx','userNotApproved','Usuario todav&iacute;a no aprobado por el administrador del sistema.','User not yet approved by the system administrator.','Utilisateur non encore approuv&eacute; par l\'administrateur du syst&egrave;me.'),
 ('login.aspx','userNotExists','El usuario no existe.','User does not exist.','L\'utilisateur n\'existe pas.'),
 ('login.aspx','whenWillSystemBeBackOnline','unas horas.','a few hours.','quelques heures.'),
 ('main.aspx','lblLogout','Salir de la Sesi&oacute;n','Logout','Déconnexion'),
 ('main.aspx','lblShowCopyright','Todos los derechos reservados. 2006. Collins & Aikman, Liger Solutions. El uso de este sitio est&aacute; sujeto a los ','All rights reserved. 2006. Collins and Aikman, Liger Solutions. The use of this site is subject to the ','Tous droits r&eacute;serv&eacute;s. 2006. Collins et Aikman, Solutions Liger. L\'utilisation de ce site est soumis &agrave; la '),
 ('main.aspx','lnkTOS',' t&eacute;rminos de servicio.',' terms of service.',' conditions de service.'),
 ('main.aspx','PageTitle','Menú de Control de Misión :: Collins & Aikman Sphynx','Mission Control Menu :: Collins & Aikman\'s Sphynx','Menu de contrôle de mission: Sphynx Collins & Aikman'),
 ('reopen.aspx','alreadyLoggedIn','El usuario ya se encuentra dentro del sistema.','The user is already logged in.','L\'utilisateur est d&eacute;j&egrave; connect&eacute; po.'),
 ('reopen.aspx','btnCancel','Cancelar','Cancel','Annuler'),
 ('reopen.aspx','btnGetMyPass','Obtener mi contraseña','Get my password','Obtenir mon mot de passe'),
 ('reopen.aspx','btnLogin','Entrar','Login','Connectez-vous'),
 ('reopen.aspx','lblLoginInstructions','Ingresa tu usuario y contrase&ntilde;a para continuar.','Type your username and password to login.','Tapez votre identifiant et votre mot de passe pour vous connecter.'),
 ('reopen.aspx','lblLostPassword','¿No te acuerdas de tu contrase&ntilde;a?','Lost password?','Mot de passe perdu?'),
 ('reopen.aspx','lblLostPasswordInstructions','Si no te acuerdas de tu contrase&ntilde;a, por favor ingresa tu usuario y las instrucciones para resetearlo te ser&aacute;n enviadas por correo electr&oacute;nico enseguida.','If you can not remember your password, please enter your username and instructions will be emailed to you shortly.','Si vous ne vous souvenez de votre mot de passe, s\'il vous pla&icirc;t entrer votre nom d\'utilisateur et des instructions seront envoy&eacute;es par courriel &agrave; vous sous peu.'),
 ('reopen.aspx','lblLostUsername','Mi usuario es:','My username is:','Mon pseudo est:'),
 ('reopen.aspx','lblPassword','Contrase&ntilde;a:','Password:','Mot de passe:'),
 ('reopen.aspx','lblShowCopyright','Todos los derechos reservados. 2006. Collins & Aikman, Liger Solutions. El uso de este sitio est&aacute; sujeto a los ','All rights reserved. 2006. Collins and Aikman, Liger Solutions. The use of this site is subject to the ','Tous droits r&eacute;serv&eacute;s. 2006. Collins et Aikman, Solutions Liger. L\'utilisation de ce site est soumis &agrave; la '),
 ('reopen.aspx','lblUsername','Usuario:','Username:','Nom d\'utilisateur:'),
 ('reopen.aspx','lblWelcome','Bienvenido a Sphynx.','Welcome to Sphynx.','Bienvenue á Sphynx.'),
 ('reopen.aspx','lblWrongUP','La combinaci&oacute;n usuario/contrase&ntilde;a no es v&aacute;lida.','Submitted username and passwords are not valid.','Soumis identifiant et mot de passe ne sont pas valides.'),
 ('reopen.aspx','lnkLostPassword','Haz click aqu&iacute;','Click here','Cliquez ici'),
 ('reopen.aspx','lnkTOS',' t&eacute;rminos de servicio.',' terms of service.',' conditions de service.'),
 ('reopen.aspx','PageTitle','Iniciar Sesión :: Collins & Aikman Sphynx','Login :: Collins & Aikman\'s Sphynx','Connexion:: Sphynx Collins & Aikman'),
 ('reopen.aspx','passwordNotValid','La combinaci&oacute;n usuario/contrase&ntilde;a no es v&aacute;lida.','Submitted username and password are not valid.','Soumis identifiant et mot de passe ne sont pas valides.'),
 ('reopen.aspx','restoreYourPasswordEmailError','Ha ocurrido un error. Intenta nuevamente.','An error has ocurred. Try again.','Une erreur s\'est produite. Essayez &agrave; nouveau.'),
 ('reopen.aspx','restoreYourPasswordEmailSent','Un email con instrucciones debe llegar a tu bandeja en unos minutos.','An email with password reset instructions has been mailed to you and will be arriving shortly to your inbox.','Un e-mail avec les instructions de r&eacute;initialisation de mot de passe a &eacute;t&eacute; envoy&eacute; &agrave; vous et va arriver prochainement &agrave; votre bo&icirc;te de r&eacute;ception.'),
 ('reopen.aspx','restoreYourPasswordUsernameNotFound','No se ha encontrado el usuario.','Username not found.','Nom d\'utilisateur introuvable.'),
 ('reopen.aspx','rfvPassword','La contrase&ntilde;a es un campo requerido.','The password is required.','Le mot de passe est n&eacute;cessaire.'),
 ('reopen.aspx','rfvUsername','Debes especificar un usuario.','You must specify a username.','Vous devez sp&eacute;cifier un nom d\'utilisateur.'),
 ('reopen.aspx','tooManyUsers','Hay demasiados usuarios dentro de Sphynx ahora. Espera un momento e intenta de nuevo.','There are too many users in Sphynx right now. Please wait a moment and try again.','Il ya trop d\'utilisateurs dans le Sphynx en ce moment. S\'il vous pla&icirc;t attendez un moment et essayez &agrave; nouveau.'),
 ('reopen.aspx','userInactive','Acceso revocado por el administrador del sistema (Usuario inactivo).','Access denied by the system administrador (User inactive).','Acc&egrave;s refus&eacute; par l\'administrador syst&egrave;me (utilisateur inactif).'),
 ('reopen.aspx','userLockedOut','Has excedido el límite de intentos fallidos de sesi&oacute;n. Esta cuenta ha sido deshabilitada por ','You have exceeded the maximum number of failed logins. This user has been disabled for ','Vous avez d&eacute;pass&eacute; le nombre maximal de connexions qui ont &eacute;chou&eacute;. Cet utilisateur a &eacute;t&eacute; d&eacute;sactiv&eacute; pour '),
 ('reopen.aspx','userLockedOut2','minutos','minutes','minutes'),
 ('reopen.aspx','userNotApproved','Usuario todav&iacute;a no aprobado por el administrador del sistema.','User not yet approved by the system administrator.','Utilisateur non encore approuv&eacute; par l\'administrateur du syst&egrave;me.'),
 ('reopen.aspx','userNotExists','El usuario no existe.','User does not exist.','L\'utilisateur n\'existe pas.'),
 ('resetPassword.aspx','btnSaveNewPassword','Guardar Nueva Contraseña','Save New Password','Enregistrer nouveau mot de passe'),
 ('resetPassword.aspx','cvPassword','Las contrase&ntilde;as no coinciden','Passwords do not match','Les mots de passe ne correspondent pas'),
 ('resetPassword.aspx','lblInstructions','Sphynx recomienda usar contrase&ntilde;as diferentes para cada p&aacute;gina web que visites.<br /><br />Por ejemplo, puedes crear una frase como contrase&ntilde;a bastante f&aacute;cil de recordar uniendo 2 o m&aacute;s palabras claves con sus primeras letras en may&uacute;sculas con o sin un n&uacute;mero:<br /><br />Tu usuario y el nombre del sitio: NickMeyers01Sphynx. <br /><br />O incluso una frase de una de tus pel&iacute;culas favoritas!<br /><br />Ahora te toca intentarlo a t&iacute;:','Sphynx recommends using different passwords for each site you use.<br /><br />For example, you could create a lasting passphrase by joining two or more meaningful words and capitalizing the first letters, with or without an additional number:<br /><br />Your username and the name of the site: NickMeyers01Sphynx. <br /><br />Or even a phrase from your favorite movie!<br /><br />Now you try it.','Recommande l\'utilisation de mots de passe Sphynx diff&eacute;rent pour chaque site que vous utilisez <br /> <br /> Par exemple, vous pouvez cr&eacute;er un mot de passe durables en joignant deux ou plusieurs mots significatifs et en capitalisant les premières lettres, avec ou sans un nombre suppl&eacute;mentaire:. <Br /> <br /> Votre nom d\'utilisateur et le nom du site: NickMeyers01Sphynx. <br /> <br /> Ou m&ecirc;me une phrase de votre film pr&eacute;f&eacute;r&eacute;es! <br /> <br />Maintenant que vous l\'essayez.'),
 ('resetPassword.aspx','lblPassword','Nueva contrase&ntilde;a:','New Password:','Nouveau mot de passe:'),
 ('resetPassword.aspx','lblRepeatPassword','Repetir contrase&ntilde;a:','Repeat Password:','R&eacute;p&eacute;ter Mot de passe:'),
 ('resetPassword.aspx','lblShowCopyright','Todos los derechos reservados. 2006. Collins & Aikman, Liger Solutions. El uso de este sitio est&aacute; sujeto a los ','All rights reserved. 2006. Collins and Aikman, Liger Solutions. The use of this site is subject to the ','Tous droits r&eacute;serv&eacute;s. 2006. Collins et Aikman, Solutions Liger. L\'utilisation de ce site est soumis &agrave; la '),
 ('resetPassword.aspx','lblWelcome','Felicitaciones! Por favor, cambia tu contrase&ntilde;a.','Congratulations! Now please change your password.','F&eacute;licitations! Maintenant s\'il vous pla&icirc;t changer votre mot de passe.'),
 ('resetPassword.aspx','lblWrongPass','La contrase&ntilde;a es demasiado f&aacute;cil o demasiado corta. Por favor usa una contrase&ntilde;a m&aacute;s segura.','Password is too easy or too short. Please use a stronger password.','Mot de passe est trop facile ou trop court. S\'il vous pla&icirc;t utilisez un fort mot de passe.'),
 ('resetPassword.aspx','PageTitle','Restablece tu contraseña :: Collins & Aikman Sphynx','Reset your password :: Collins & Aikman\'s Sphynx','Réinitialiser votre mot de passe:: Sphynx Collins & Aikman'),
 ('resetPassword.aspx','rfvRepeatPassword','Una contrase&ntilde;a es requerida.','The password is required.','Le mot de passe est n&eacute;cessaire.');
/*!40000 ALTER TABLE `labels` ENABLE KEYS */;


--
-- Definition of table `languages`
--

DROP TABLE IF EXISTS `languages`;
CREATE TABLE `languages` (
  `ilanguageid` int(11) NOT NULL,
  `slanguagecode` varchar(4) NOT NULL,
  PRIMARY KEY (`ilanguageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `languages`
--

/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` (`ilanguageid`,`slanguagecode`) VALUES 
 (1,'esmx'),
 (2,'enus'),
 (3,'fr');
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
INSERT INTO `longquerieslogs` (`querydate`,`squeryname`) VALUES 
 ('2011-08-08 03:03:08','Timeout Query'),
 ('2011-08-08 03:23:39','Timeout Query'),
 ('2011-08-08 03:45:38','Timeout Query'),
 ('2011-08-08 04:33:13','Timeout Query'),
 ('2011-08-08 05:09:53','Timeout Query'),
 ('2011-08-08 15:01:14','Timeout Query');
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
  `fr_title` varchar(70) NOT NULL,
  `fr_description` varchar(150) NOT NULL,
  PRIMARY KEY (`smoduleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `modules`
--

/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
INSERT INTO `modules` (`smoduleid`,`surl`,`bshowInMenu`,`bStatus`,`spermissiongrantingusername`,`permissiongrantingdate`,`esmx_title`,`esmx_description`,`enus_title`,`enus_description`,`fr_title`,`fr_description`) VALUES 
 ('mnuTest1','#',1,1,'memozebadua','2011-08-08','Prueba1','Pruebaaaaa','Test1','Teeeeeeest','Essayer1','Essayeeeeeeeeeeeer');
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
  PRIMARY KEY (`imroid`,`imrodetailsid`)
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
  PRIMARY KEY (`icompanyid`,`iplantid`,`ivendorid`,`imroid`)
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
  PRIMARY KEY (`iorderid`,`iorderdetailsid`)
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
  PRIMARY KEY (`icompanyid`,`iplantid`,`ivendorid`,`iorderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orders`
--

/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;


--
-- Definition of table `passwordresetrequests`
--

DROP TABLE IF EXISTS `passwordresetrequests`;
CREATE TABLE `passwordresetrequests` (
  `ipasswordresetrequestid` int(11) NOT NULL,
  `susername` varchar(100) NOT NULL,
  `requestdate` datetime NOT NULL,
  PRIMARY KEY (`ipasswordresetrequestid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `passwordresetrequests`
--

/*!40000 ALTER TABLE `passwordresetrequests` DISABLE KEYS */;
/*!40000 ALTER TABLE `passwordresetrequests` ENABLE KEYS */;


--
-- Definition of table `passwordresets`
--

DROP TABLE IF EXISTS `passwordresets`;
CREATE TABLE `passwordresets` (
  `ipasswordresetid` int(11) NOT NULL,
  `susername` varchar(100) NOT NULL,
  `resetdate` datetime NOT NULL,
  PRIMARY KEY (`ipasswordresetid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `passwordresets`
--

/*!40000 ALTER TABLE `passwordresets` DISABLE KEYS */;
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
  `logoutdate` datetime DEFAULT NULL,
  PRIMARY KEY (`susername`,`susersession`,`logindate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sessions`
--

/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` (`susername`,`susersession`,`bloggedinsuccesfully`,`btimedout`,`blockedout`,`bkickedout`,`suserip`,`susermachinename`,`logindate`,`logoutdate`) VALUES 
 ('memozebadua','b1dv1vb0fic2scqdooxpa345',1,0,0,0,'127.0.0.1','POLARIS','2011-08-08 05:09:52','2011-08-08 05:10:00'),
 ('memozebadua','cjpxxe24lmok53fqlhvnrrqe',1,0,0,0,'127.0.0.1','POLARIS','2011-08-08 04:35:30','2011-08-08 04:41:20'),
 ('memozebadua','cjpxxe24lmok53fqlhvnrrqe',1,0,0,0,'127.0.0.1','POLARIS','2011-08-08 04:40:28','2011-08-08 04:41:20'),
 ('memozebadua','hvojyu453obei2uwokeo5c55',1,0,0,0,'127.0.0.1','POLARIS','2011-08-08 15:01:14','2011-08-08 15:01:36'),
 ('memozebadua','serlwsrlmiz4kr2qkbnoanea',1,0,0,0,'127.0.0.1','POLARIS','2011-08-08 03:45:38','2011-08-08 03:56:14'),
 ('memozebadua','serlwsrlmiz4kr2qkbnoanea',1,0,0,0,'127.0.0.1','POLARIS','2011-08-08 03:47:30','2011-08-08 03:56:14'),
 ('memozebadua','serlwsrlmiz4kr2qkbnoanea',1,0,0,0,'127.0.0.1','POLARIS','2011-08-08 03:49:58','2011-08-08 03:56:14'),
 ('memozebadua','serlwsrlmiz4kr2qkbnoanea',1,0,0,0,'127.0.0.1','POLARIS','2011-08-08 03:51:11','2011-08-08 03:56:14'),
 ('memozebadua','serlwsrlmiz4kr2qkbnoanea',1,0,0,0,'127.0.0.1','POLARIS','2011-08-08 03:53:19','2011-08-08 03:56:14'),
 ('memozebadua','serlwsrlmiz4kr2qkbnoanea',1,0,0,0,'127.0.0.1','POLARIS','2011-08-08 03:55:37','2011-08-08 03:56:14'),
 ('memozebadua','tykjdk45gld5wg3wx3k25n45',1,0,0,0,'127.0.0.1','POLARIS','2011-08-08 03:59:55','2011-08-08 04:00:04');
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
  PRIMARY KEY (`ishipmentid`,`icontainerid`,`iorderid`,`iorderdetailsid`)
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
  PRIMARY KEY (`icompanyid`,`iplantid`,`ivendorid`,`ishipmentid`)
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
  PRIMARY KEY (`ilogid`),
  KEY `username` (`susername`) USING BTREE,
  KEY `user&session` (`susername`,`susersession`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sqllogs`
--

/*!40000 ALTER TABLE `sqllogs` DISABLE KEYS */;
INSERT INTO `sqllogs` (`ilogid`,`querydate`,`susername`,`susersession`,`suserip`,`susermachinename`,`sactiondone`,`sresult`) VALUES 
 (1,'2011-08-08 03:45:38','memozebadua','serlwsrlmiz4kr2qkbnoanea','127.0.0.1','POLARIS','Login Attempt from Page login.aspx with a True result','1'),
 (2,'2011-08-08 03:47:30','memozebadua','serlwsrlmiz4kr2qkbnoanea','127.0.0.1','POLARIS','Login Attempt from Page login.aspx with a True result','1'),
 (3,'2011-08-08 03:49:58','memozebadua','serlwsrlmiz4kr2qkbnoanea','127.0.0.1','POLARIS','Login Attempt from Page login.aspx with a True result','1'),
 (4,'2011-08-08 03:51:11','memozebadua','serlwsrlmiz4kr2qkbnoanea','127.0.0.1','POLARIS','Login Attempt from Page login.aspx with a True result','1'),
 (5,'2011-08-08 03:53:19','memozebadua','serlwsrlmiz4kr2qkbnoanea','127.0.0.1','POLARIS','Login Attempt from Page login.aspx with a True result','1'),
 (6,'2011-08-08 03:55:37','memozebadua','serlwsrlmiz4kr2qkbnoanea','127.0.0.1','POLARIS','Login Attempt from Page login.aspx with a True result','1'),
 (7,'2011-08-08 03:56:14','memozebadua','serlwsrlmiz4kr2qkbnoanea','127.0.0.1','POLARIS','Logout from Page main.aspx','1'),
 (8,'2011-08-08 03:59:55','memozebadua','tykjdk45gld5wg3wx3k25n45','127.0.0.1','POLARIS','Login Attempt from Page login.aspx with a True result','1'),
 (9,'2011-08-08 04:00:04','memozebadua','tykjdk45gld5wg3wx3k25n45','127.0.0.1','POLARIS','Logout from Page main.aspx','1'),
 (10,'2011-08-08 04:33:13','memozebadua','kwmruh45n2mem055ndyrzu3m','127.0.0.1','POLARIS','Login Attempt from Page login.aspx with a False result','0'),
 (11,'2011-08-08 04:34:09','memozebadua','1ixhcx55cgw0xw4521rgz0uz','127.0.0.1','POLARIS','Login Attempt from Page login.aspx with a False result','0'),
 (12,'2011-08-08 04:35:30','memozebadua','cjpxxe24lmok53fqlhvnrrqe','127.0.0.1','POLARIS','Login Attempt from Page login.aspx with a True result','1'),
 (13,'2011-08-08 04:40:28','memozebadua','cjpxxe24lmok53fqlhvnrrqe','127.0.0.1','POLARIS','Login Attempt from Page login.aspx with a True result','1'),
 (14,'2011-08-08 04:41:20','memozebadua','cjpxxe24lmok53fqlhvnrrqe','127.0.0.1','POLARIS','Logout from Page main.aspx','1'),
 (15,'2011-08-08 05:09:52','memozebadua','b1dv1vb0fic2scqdooxpa345','127.0.0.1','POLARIS','Login Attempt from Page login.aspx with a True result','1'),
 (16,'2011-08-08 05:10:00','memozebadua','b1dv1vb0fic2scqdooxpa345','127.0.0.1','POLARIS','Logout from Page main.aspx','1'),
 (17,'2011-08-08 15:01:14','memozebadua','hvojyu453obei2uwokeo5c55','127.0.0.1','POLARIS','Login Attempt from Page login.aspx with a True result','1'),
 (18,'2011-08-08 15:01:36','memozebadua','hvojyu453obei2uwokeo5c55','127.0.0.1','POLARIS','Logout from Page main.aspx','1');
/*!40000 ALTER TABLE `sqllogs` ENABLE KEYS */;


--
-- Definition of table `systemvariables`
--

DROP TABLE IF EXISTS `systemvariables`;
CREATE TABLE `systemvariables` (
  `svariable` varchar(100) NOT NULL,
  `svalue` varchar(3000) NOT NULL,
  PRIMARY KEY (`svariable`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `systemvariables`
--

/*!40000 ALTER TABLE `systemvariables` DISABLE KEYS */;
INSERT INTO `systemvariables` (`svariable`,`svalue`) VALUES 
 ('dynamicLabelsOnLoginOffline','1'),
 ('minutesToTimeoutLessThan59','15'),
 ('multipleLogins','0'),
 ('systemOnline','1');
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
  `readdate` datetime DEFAULT NULL,
  PRIMARY KEY (`inoticeid`)
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
  `sgrantingusername` varchar(100) NOT NULL,
  `grantingdate` datetime NOT NULL,
  PRIMARY KEY (`susername`,`smoduleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `userpermissions`
--

/*!40000 ALTER TABLE `userpermissions` DISABLE KEYS */;
INSERT INTO `userpermissions` (`susername`,`smoduleid`,`sgrantingusername`,`grantingdate`) VALUES 
 ('memozebadua','mnuTest1','memozebadua','2011-08-08 00:00:00');
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
  PRIMARY KEY (`susername`,`iplantid`)
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
  PRIMARY KEY (`susername`)
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
  PRIMARY KEY (`susername`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`susername`,`suserpasswordhash`,`suserrescuequestion`,`suserrescueanswerhash`,`bactive`,`bonline`,`bapproved`,`blockedout`,`icompanyid`,`suserfullname`,`suserdesiredname`,`suseremail`,`spreferredlanguage`,`iuserlevel`,`sparentusername`,`screatingusername`,`screatingdate`,`slastmodificationusername`,`slastmodificationdate`) VALUES 
 ('memozebadua','0iur2v6gMWLJCz4uJFz45bFaPbW+o6qgNeweCVl5E9LI4DRX64QYYC2pZXT30Leq/5+IHkVZnfJyek8vNHJQDFRvIHNlZSBhIHdvcmxkIGluIGEgZ3JhaW4gb2Ygc2FuZCBhbmQgYSBoZWF2ZW4gaW4gYSB3aWxkIGZsb3dlci4gSG9sZCBpbmZpbml0eSBpbiB0aGUgcGFsbSBvZiB5b3VyIGhhbmQgYW5kIEV0ZXJuaXR5IGluIGFuIGhvdXI=','My father Middle name','egGnEe9hEHXwPL9qXmpE4uundGsJC0K6Furl9Orzp5vnYnvM1MqLRCr0AY0mfgfD6dkKvJMHDIIPVd63L7DFTlRvIHNlZSBhIHdvcmxkIGluIGEgZ3JhaW4gb2Ygc2FuZCBhbmQgYSBoZWF2ZW4gaW4gYSB3aWxkIGZsb3dlci4gSG9sZCBpbmZpbml0eSBpbiB0aGUgcGFsbSBvZiB5b3VyIGhhbmQgYW5kIEV0ZXJuaXR5IGluIGFuIGhvdXI=',1,0,1,0,1,'Guillermo Zebadua','Memo','memozebadua@gmail.com','enus',0,'','memozebadua','2011-01-01 00:00:00','memozebadua','2011-01-01 00:00:00');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;


--
-- Definition of table `vendors`
--

DROP TABLE IF EXISTS `vendors`;
CREATE TABLE `vendors` (
  `ivendorid` int(20) NOT NULL,
  `svendorname` varchar(500) NOT NULL,
  PRIMARY KEY (`ivendorid`)
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
