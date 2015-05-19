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
  `scompanyname` varchar(500) NOT NULL,
  `bactive` int(1) NOT NULL,
  `lastreviewingusername` varchar(100) NOT NULL,
  `lastreviewingdate` datetime NOT NULL,
  PRIMARY KEY (`icompanyid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `companies`
--

/*!40000 ALTER TABLE `companies` DISABLE KEYS */;
INSERT INTO `companies` (`icompanyid`,`scompanyname`,`bactive`,`lastreviewingusername`,`lastreviewingdate`) VALUES 
 (1,'Liger Solutions',1,'memozebadua','2011-01-01 00:00:00');
/*!40000 ALTER TABLE `companies` ENABLE KEYS */;


--
-- Definition of table `companyplants`
--

DROP TABLE IF EXISTS `companyplants`;
CREATE TABLE `companyplants` (
  `icompanyid` int(11) NOT NULL,
  `iplantid` int(11) NOT NULL,
  `splantname` varchar(200) NOT NULL,
  `bactive` int(1) NOT NULL,
  `remotesystemandport` varchar(20) NOT NULL,
  `blinkageactive` int(1) NOT NULL,
  `lastreviewingusername` varchar(100) NOT NULL,
  `lastreviewingdate` datetime NOT NULL,
  PRIMARY KEY (`icompanyid`,`iplantid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `companyplants`
--

/*!40000 ALTER TABLE `companyplants` DISABLE KEYS */;
INSERT INTO `companyplants` (`icompanyid`,`iplantid`,`splantname`,`bactive`,`remotesystemandport`,`blinkageactive`,`lastreviewingusername`,`lastreviewingdate`) VALUES 
 (1,1,'Queretaro',1,'localhost:1212',0,'memozebadua','2011-01-01 00:00:00');
/*!40000 ALTER TABLE `companyplants` ENABLE KEYS */;


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
  `esmx` varchar(7000) NOT NULL,
  `enus` varchar(7000) NOT NULL,
  `fr` varchar(7000) NOT NULL,
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
 ('answerSecretQuestion.aspx','lnkTOS',' t&eacute;rminos de servicio.',' terms of service.',' conditions de service.'),
 ('answerSecretQuestion.aspx','welcomePart1','Bienvenido','Welcome','Bienvenue'),
 ('answerSecretQuestion.aspx','welcomePart2','Por favor contesta tu respuesta secreta.','Please answer your secret question.','S\'il vous pla&icirc;t r&eacute;pondre &agrave; votre question secr&egrave;te.'),
 ('displayLang.aspx','btnAddLabel','Agregar etiqueta','Add Label','Ajouter une &eacute;tiquette'),
 ('displayLang.aspx','btnAddLanguage','Agregar Idioma','Add Language','Ajouter une langue'),
 ('displayLang.aspx','btnCreateNewLabel','Crear nueva Etiqueta','Create new Label','Cr&eacute;er des nouvelle &eacute;tiquette'),
 ('displayLang.aspx','btnDelete','Eliminar Etiqueta','Delete Label','Supprimer &Eacute;tiquette'),
 ('displayLang.aspx','btnFilter','Buscar','Search','Rechercher'),
 ('displayLang.aspx','btnGoSearch','Buscar','Search','Rechercher'),
 ('displayLang.aspx','btnModify','Guardar Cambios','Save Changes','Enregistrer les modifications'),
 ('displayLang.aspx','btnSaveLabel','Guardar','Guardar','Enregistrer'),
 ('displayLang.aspx','btnSaveNewLang','Crear nuevo Idioma','Create new Language','Cr&eacute;er des nouveau Langue'),
 ('displayLang.aspx','btnShowAll','Mostrar todas','Show All Labels','Voir toutes les &eacute;tiquettes'),
 ('displayLang.aspx','btnShowMenu','Mostrar Menú','Show Menu','Afficher le Menu'),
 ('displayLang.aspx','CancelEdit','Cancelar','Cancel','Annuler'),
 ('displayLang.aspx','CancelNewLanguage','Cancelar','Cancel','Annuler'),
 ('displayLang.aspx','dgHeader1','P&aacute;gina','Page','Page'),
 ('displayLang.aspx','dgHeader2','Etiqueta','Label','&Eacute;tiquette'),
 ('displayLang.aspx','ErrorNewLabel1','Sucedio un error al guardar la nueva etiqueta. Intenta nuevamente.','There was an error saving the new label. Please try again.','Il y avait une erreur sauver la nouvelle &eacute;tiquette. Sil vous pla&icirc;t essayez de nouveau.'),
 ('displayLang.aspx','HideMenu','Ocultar Menú','Hide Menu','Masquer les menus'),
 ('displayLang.aspx','LabelAlreadyExists','Esta etiqueta ya existe','This label is already in the system','Ce &eacute;tiquette est d&eacute;j&agrave; dans le syst&egrave;me'),
 ('displayLang.aspx','LanguageAlreadyInUse','Este c&oacute;digo ya est&aacute; implementado','This language code is already in the system','Ce code de langue est d&eacute;j&agrave; dans le syst&egrave;me'),
 ('displayLang.aspx','LanguageCodeRequired','El c&oacute;digo de lenguaje es requerido.','The language code is required','Le code de langue est requis'),
 ('displayLang.aspx','LanguagesNamesRequired','Es necesario proporcionar los nombres del nuevo Idioma','Language names are required','Noms des langues sont n&eacute;cessaires'),
 ('displayLang.aspx','lblLogout','Salir de la Sesi&oacute;n','Logout','Déconnexion'),
 ('displayLang.aspx','lblNewLabel','Nombre de la etiqueta : ','Label name : ','Nom de la &eacute;tiquette : '),
 ('displayLang.aspx','lblNewPage','Nombre de la p&aacute;gina : ','Page name : ','Nom de la page : '),
 ('displayLang.aspx','lblSearchByNamePart','Buscar : ','Search : ','Rechercher : '),
 ('displayLang.aspx','lblShowCopyright','Todos los derechos reservados. 2006. Collins & Aikman, Liger Solutions. El uso de este sitio est&aacute; sujeto a los ','All rights reserved. 2006. Collins and Aikman, Liger Solutions. The use of this site is subject to the ','Tous droits r&eacute;serv&eacute;s. 2006. Collins et Aikman, Solutions Liger. L\'utilisation de ce site est soumis &agrave; la '),
 ('displayLang.aspx','lblSpecifyNewLang','C&oacute;digo de lenguaje : ','Language Code : ','Code de Langue : '),
 ('displayLang.aspx','lnkDelete','Eliminar','Delete','Supprimer'),
 ('displayLang.aspx','lnkEdit','Modificar','Edit','Modifier'),
 ('displayLang.aspx','lnkTOS',' t&eacute;rminos de servicio.',' terms of service.',' conditions de service.'),
 ('displayLang.aspx','NewLangError','Sucedio un error al guardar el nuevo idioma. Intenta nuevamente.','There was an error saving the new language. Please try again.','Il y avait une erreur en ajoutant la nouvelle langue. Sil vous pla&icirc;t essayez de nouveau.'),
 ('displayLang.aspx','NewLanguage','Nuevo Idioma','New Language','Nouveau Langue'),
 ('displayLang.aspx','NoSearchResults','No hay resultados','No results found','Aucun r&eacute;sultat trouv&eacute;'),
 ('displayLang.aspx','PageNameAndLabelNameRequired','El nombre de la p&aacute;gina y etiqueta son requeridos','Page name and Label name are required','Nom de la page et le nom de l&eacute;tiquette sont requis'),
 ('displayLang.aspx','PageTitle','Idiomas y Etiquetas :: Collins & Aikman Sphynx','Languages and Labels :: Collins & Aikman\'s Sphynx','Langues et &eacute;tiquettes :: Collins & Aikman Sphynx'),
 ('displayUsers.aspx','btnAddUser','Agregar Usuario','Add User',''),
 ('displayUsers.aspx','btnGoSearch','Buscar','Search','Rechercher'),
 ('displayUsers.aspx','btnSetup','Nuevo Usuario Externo','New External User',''),
 ('displayUsers.aspx','btnSetupCA','Nuevo Usuario Collins&Aikman','New User Collins&Aikman',''),
 ('displayUsers.aspx','btnShowActive','Mostrar Usuarios Activos','Show Active Users',''),
 ('displayUsers.aspx','btnShowAll','Mostrar todos','Show All Users','Voir toutes les Utilisateurs'),
 ('displayUsers.aspx','btnShowByNP','Buscar','Search',''),
 ('displayUsers.aspx','btnShowInactive','Mostrar Usuarios Inactivos','Show Inactive Users',''),
 ('displayUsers.aspx','btnShowMenu','Mostrar Menú','Show Menu','Afficher le Menu'),
 ('displayUsers.aspx','btnUpdateStatus','Actualizar Status','Update Status',''),
 ('displayUsers.aspx','CancelNewUser','Cancelar','Cancel','Annuler'),
 ('displayUsers.aspx','CompanyActive','Activa','Active',''),
 ('displayUsers.aspx','CompanyInactive','Inactiva','Inactive',''),
 ('displayUsers.aspx','dgHeader0','Status','Status',''),
 ('displayUsers.aspx','dgHeader1','Acciones','Actions',''),
 ('displayUsers.aspx','dgHeader10','Aprobado','Approved',''),
 ('displayUsers.aspx','dgHeader11','Botado','Locked Out',''),
 ('displayUsers.aspx','dgHeader12','Nivel de Usuario','User Level',''),
 ('displayUsers.aspx','dgHeader13','Login Padre','Father login',''),
 ('displayUsers.aspx','dgHeader14','Pregunta de Rescate','Rescue Question',''),
 ('displayUsers.aspx','dgHeader2','Nombre de Usuario','Username',''),
 ('displayUsers.aspx','dgHeader3','Nombre completo','Full Name',''),
 ('displayUsers.aspx','dgHeader4','Nombre para mostrar','Desired name',''),
 ('displayUsers.aspx','dgHeader5','Compa&ntilde;&iacute;a','Company',''),
 ('displayUsers.aspx','dgHeader6','Estatus de la Compa&ntilde;&iacute;a','Company Status',''),
 ('displayUsers.aspx','dgHeader7','Email','Email','Email'),
 ('displayUsers.aspx','dgHeader8','Idioma preferido','Preferred Language',''),
 ('displayUsers.aspx','dgHeader9','En l&iacute;nea','Online',''),
 ('displayUsers.aspx','HideMenu','Ocultar Menú','Hide Menu','Masquer les menus'),
 ('displayUsers.aspx','lblLogout','Salir de la Sesi&oacute;n','Logout','Déconnexion'),
 ('displayUsers.aspx','lblSearchByNamePart','Buscar : ','Search : ','Rechercher : '),
 ('displayUsers.aspx','lblShowCopyright','Todos los derechos reservados. 2006. Collins & Aikman, Liger Solutions. El uso de este sitio est&aacute; sujeto a los ','All rights reserved. 2006. Collins and Aikman, Liger Solutions. The use of this site is subject to the ','Tous droits r&eacute;serv&eacute;s. 2006. Collins et Aikman, Solutions Liger. L\'utilisation de ce site est soumis &agrave; la '),
 ('displayUsers.aspx','lnkChangeStatus','Cambiar Estatus','Change Status',''),
 ('displayUsers.aspx','lnkEdit','Modificar','Edit','Modifier'),
 ('displayUsers.aspx','lnkTOS',' t&eacute;rminos de servicio.',' terms of service.',' conditions de service.'),
 ('displayUsers.aspx','NoSearchResults','No hay resultados','No results found','Aucun r&eacute;sultat trouv&eacute;'),
 ('displayUsers.aspx','PageTitle','Administración de Usuarios :: Collins & Aikman Sphynx','Users Administration :: Collins & Aikman\'s Sphynx','Administration des Utilisateurs :: Collins & Aikman Sphynx'),
 ('displayUsers.aspx','updateFailed','Error al actualizar','Update failed',''),
 ('displayUsers.aspx','updateSucceeded','Actualizaci&oacute;n exitosa','Update successful',''),
 ('displayUsers.aspx','UserApproved','S&iacute;','Yes',''),
 ('displayUsers.aspx','UserLockedOut','S&iacute;','Yes',''),
 ('displayUsers.aspx','UserNotApproved','No','No',''),
 ('displayUsers.aspx','UserNotLockedOut','No','No',''),
 ('displayUsers.aspx','UserOffline','No','No',''),
 ('displayUsers.aspx','UserOnline','S&iacute;','Yes',''),
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
 ('login.aspx','PageTitle','Iniciar Sesión :: Collins & Aikman Sphynx','Login :: Collins & Aikman\'s Sphynx','Connexion :: Sphynx Collins & Aikman'),
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
 ('main.aspx','moduleNotActive','M&oacute;dulo No Activo','Module Not Active','Module Nest Pas Actif'),
 ('main.aspx','PageTitle','Menú de Control de Misión :: Collins & Aikman Sphynx','Mission Control Menu :: Collins & Aikman\'s Sphynx','Menu de contrôle de mission: Sphynx Collins & Aikman'),
 ('noRight.aspx','lblHeader','Acceso Denegado','Access Denied','Acc&egrave;s Refus&eacute;'),
 ('noRight.aspx','lblLogout','Salir de la Sesi&oacute;n','Logout','Déconnexion'),
 ('noRight.aspx','lblNoRight','No tienes los permisos necesarios para navegar a esta p&aacute;gina. Este intento ha sido notificado al administrador del sistema.','You do not have the necessary privileges to access this page. This attempt has been notified to the system administrator.','Vous n\'avez pas les privil&egrave;ges n&eacute;cessaires pour acc&eacute;der &agrave; cette page. Cette tentative a &eacute;t&eacute; notifi&eacute; &agrave; l\'administrateur syst&egrave;me.'),
 ('noRight.aspx','lblShowCopyright','Todos los derechos reservados. 2006. Collins & Aikman, Liger Solutions. El uso de este sitio est&aacute; sujeto a los ','All rights reserved. 2006. Collins and Aikman, Liger Solutions. The use of this site is subject to the ','Tous droits r&eacute;serv&eacute;s. 2006. Collins et Aikman, Solutions Liger. L\'utilisation de ce site est soumis &agrave; la '),
 ('noRight.aspx','lnkGoBack','Regresar a la p&aacute;gina anterior','Go back to the previous page','Retour &agrave; la page pr&eacute;c&eacute;dente'),
 ('noRight.aspx','lnkTOS',' t&eacute;rminos de servicio.',' terms of service.',' conditions de service.'),
 ('noRight.aspx','PageTitle','Acceso denegado :: Collins & Aikman Sphynx','Access Denied :: Collins & Aikman\'s Sphynx','Accès Refusé :: Collins & Aikman Sphynx'),
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
 ('resetPassword.aspx','lnkTOS',' t&eacute;rminos de servicio.',' terms of service.',' conditions de service.'),
 ('resetPassword.aspx','PageTitle','Restablece tu contraseña :: Collins & Aikman Sphynx','Reset your password :: Collins & Aikman\'s Sphynx','Réinitialiser votre mot de passe:: Sphynx Collins & Aikman'),
 ('resetPassword.aspx','rfvRepeatPassword','Una contrase&ntilde;a es requerida.','The password is required.','Le mot de passe est n&eacute;cessaire.'),
 ('sessionEnd.aspx','lblHeader','Sesi&oacute;n terminada debido a Inactividad','Session Timeout due to Inactivity','Séance s\'est Terminée à cause de l\'Inactivité'),
 ('sessionEnd.aspx','lblLogout','Salir de la Sesi&oacute;n','Logout','Déconnexion'),
 ('sessionEnd.aspx','lblShowCopyright','Todos los derechos reservados. 2006. Collins & Aikman, Liger Solutions. El uso de este sitio est&aacute; sujeto a los ','All rights reserved. 2006. Collins and Aikman, Liger Solutions. The use of this site is subject to the ','Tous droits r&eacute;serv&eacute;s. 2006. Collins et Aikman, Solutions Liger. L\'utilisation de ce site est soumis &agrave; la '),
 ('sessionEnd.aspx','lnkLogin','Regresar a la p&aacute;gina principal','Go back to Login','Retour &agrave; la page Connexion'),
 ('sessionEnd.aspx','lnkTOS',' t&eacute;rminos de servicio.',' terms of service.',' conditions de service.'),
 ('sessionEnd.aspx','PageTitle','Sesión Terminada por Inactividad :: Collins & Aikman Sphynx','Session Timeout :: Collins & Aikman\'s Sphynx','Séance s\'est Terminée à cause de l\'Inactivité :: Collins & Aikman Sphynx'),
 ('sessionEnd.aspx','sessionMessagePart1','No has realizado ninguna acci&oacute;n dentro de Sphynx en','You have not done any action within Sphynx in the last','Vous n\'avez pas fait une action au sein de Sphynx dans la derni&egrave;re'),
 ('sessionEnd.aspx','sessionMessagePart2','minutos y has sido sacado de tu sesi&oacute;n por tu seguridad.','minutes and you have been logged out for your security.','minutes et vous avez &eacute;t&eacute; d&eacute;connect&eacute; de votre s&eacute;curit&eacute;.'),
 ('sysError.aspx','btnShowMenu','Mostrar Menú','Show Menu','Afficher le Menu'),
 ('sysError.aspx','HideMenu','Ocultar Menú','Hide Menu','Masquer les menus'),
 ('sysError.aspx','lblError','Ha ocurrido un error y ya ha sido notificado al administrador del sistema. Lamentamos los inconvenientes que esto puede haber provocado. ','An error has occurred and it has been notified to the system administrator. We apologize for the inconvenience this may cause to you.','Une erreur s\'est produite et il a &eacute;t&eacute; notifi&eacute; &agrave; l\'administrateur syst&egrave;me. Nous nous excusons pour les d&eacute;sagr&eacute;ments que cela pourrait vous causer.'),
 ('sysError.aspx','lblHeader','Error','Error','Erreur'),
 ('sysError.aspx','lblLogout','Salir de la Sesi&oacute;n','Logout','Déconnexion'),
 ('sysError.aspx','lblShowCopyright','Todos los derechos reservados. 2006. Collins & Aikman, Liger Solutions. El uso de este sitio est&aacute; sujeto a los ','All rights reserved. 2006. Collins and Aikman, Liger Solutions. The use of this site is subject to the ','Tous droits r&eacute;serv&eacute;s. 2006. Collins et Aikman, Solutions Liger. L\'utilisation de ce site est soumis &agrave; la '),
 ('sysError.aspx','lnkGoBack','Regresar a la p&aacute;gina anterior','Go back to the previous page','Retour &agrave; la page pr&eacute;c&eacute;dente'),
 ('sysError.aspx','lnkTOS',' t&eacute;rminos de servicio.',' terms of service.',' conditions de service.'),
 ('sysError.aspx','PageTitle','Error :: Collins & Aikman Sphynx','Error :: Collins & Aikman\'s Sphynx','Erreur :: Collins & Aikman Sphynx'),
 ('tos.aspx','btnShowMenu','Mostrar Menú','Show Menu','Afficher le Menu'),
 ('tos.aspx','HideMenu','Ocultar Menú','Hide Menu','Masquer les menus'),
 ('tos.aspx','lblLogout','Salir de la Sesi&oacute;n','Logout','Déconnexion'),
 ('tos.aspx','lblTOS','T&eacute;rminos Legales y Condiciones de Uso\r\nCollins & Aikman posee y opera este sitio, y ponerlo a disposici&oacute;n de ustedes en estas condiciones de uso. Al usar este sitio, usted indica que acepta estas Condiciones de uso. No utilizar el sitio si usted no acepta estos t&eacute;rminos.\r\nTenga en cuenta que nos reservamos el derecho, a nuestra discreci&oacute;n, de modificar estas Condiciones de Uso en cualquier momento sin previo aviso, as&iacute; que deber&aacute;s revisar estas Condiciones de Uso peri&oacute;dicamente para modificaciones. El uso continuado de este sitio tras la publicaci&oacute;n de tales modificaciones implican la aceptaci&oacute;n de las Condiciones de uso modificadas.\r\nPara efectos de estas Condiciones de Uso, \"informaci&oacute;n\" se define ampliamente para incluir todos los materiales electr&oacute;nicos y de contenidos, incluyendo textos, gr&aacute;ficos, audio, software y otros art&iacute;culos de derechos de autor.\r\nMiscel&aacute;neo\r\nCollins & Aikman, controla y opera este sitio desde sus oficinas en los Estados Unidos de Am&eacute;rica. Collins & Aikman no hace ninguna representaci&oacute;n que los materiales en este sitio son apropiados o disponibles para su uso en otros lugares. Si usted tiene acceso a este sitio desde fuera de los Estados Unidos de Am&eacute;rica, usted es responsable de cumplir con todas las leyes locales.\r\nEstas Condiciones de Uso se regir&aacute; e interpretar&aacute; de acuerdo con las leyes del Estado de Michigan, sin dar efecto a cualquier principio de conflicto de leyes. Si alguna disposici&oacute;n de estas Condiciones de Uso se determina que es ilegal, nula o inaplicable por cualquier raz&oacute;n, dicha disposici&oacute;n se considerar&aacute; separable de estos T&eacute;rminos de Uso y no afectar&aacute; la validez y aplicabilidad de las disposiciones restantes. Cualquier causa de acci&oacute;n que pueda tener con respecto al uso de este sitio debe ser iniciada dentro de un a&ntilde;o despu&eacute;s de la reclamaci&oacute;n o causa de acci&oacute;n. Estas Condiciones de Uso constituyen el acuerdo completo entre las partes con respecto al uso de este sitio.\r\nPropiedad Intelectual\r\nCopyright 1999-2005 Collins & Aikman. Todos los derechos reservados.\r\nTodas las im&aacute;genes de material, texto y / o contenido en el sitio de Collins & Aikman web es propiedad de Collins & Aikman y est&aacute; protegido por diversas leyes de EE.UU. e internacionales y los tratados. Cualquier copia, alteraci&oacute;n, distribuci&oacute;n, transmisi&oacute;n, ejecuci&oacute;n, exhibici&oacute;n o cualquier otro uso de dicho material, en todo o en parte, est&aacute; prohibido, salvo Collins & Aikman le otorga, sin costo, el permiso para utilizar, copiar y distribuir dicho material NO para uso comercial, siempre y cuando a) que dicho material no ha sido alterado o editado de ninguna manera, b) que el aviso de copyright de Collins & Aikman y este aviso de permiso aparezcan en todas material copiado y / o de otra forma utilizado o distribuido por usted y c) que cualquier nombre, marca o similar, de Collins & Aikman o cualquier otra de las filiales de Collins & Aikman, no se utilizan en cualquier tipo de publicidad o publicidad sin autorizaci&oacute;n expresa, previa y por escrito de Collins & Aikman.\r\nTodas las marcas de productos que aparecen en una forma diferente tipo de texto que lo rodea son marcas comerciales de Collins & Aikman o subsidiarias de Collins & Aikman. Excepto por el permiso limitado para usar y distribuir copias del material contenido en este sitio web lo expresamente indicado anteriormente, nada de lo contenido aqu&iacute; ser&aacute; interpretado como el otorgamiento de ning&uacute;n derecho o licencia a nadie bajo ninguna patente, marca registrada, derecho de autor u otros derechos de propiedad intelectual de Collins & Aikman o subsidiarias de Collins & Aikman.\r\nPresentaciones por parte de Usted\r\nLe pedimos que no nos env&iacute;e ninguna informaci&oacute;n confidencial o de propiedad no solicitados, incluidos los secretos comerciales, ideas, conceptos o conocimientos t&eacute;cnicos. Si a pesar de nuestra solicitud de que usted o alguien que act&uacute;e en su nombre nos proporciona la informaci&oacute;n solicitada, usted reconoce que Collins & Aikman no tendr&aacute; ninguna obligaci&oacute;n de tratar la informaci&oacute;n confidencial y Collins & Aikman tendr&aacute; una licencia sin restricciones, irrevocable, mundial, libre de regal&iacute;as para usar, reproducir, mostrar, transmitir y distribuir dicha informaci&oacute;n.\r\nDescargo de responsabilidad y limitaci&oacute;n de responsabilidad\r\nEste sitio, y la informaci&oacute;n aqu&iacute; proporcionada, se proporcionan \"tal cual\" sin ninguna representaci&oacute;n o garant&iacute;a, expresa o impl&iacute;cita, de cualquier tipo, incluyendo pero no limitado a, las garant&iacute;as de comerciabilidad, no infracci&oacute;n, o idoneidad para un prop&oacute;sito particular. Algunas jurisdicciones no permiten la exclusi&oacute;n de garant&iacute;as impl&iacute;citas, por lo que las exclusiones anteriores pueden no aplicarse a usted.\r\nEn ning&uacute;n caso, Collins & Aikman o cualquiera de sus subsidiarias o afiliadas ser&aacute;n responsables de cualquier entidad de los da&ntilde;os directos, indirectos, especiales, consecuenciales o de otro tipo (incluyendo, sin limitaci&oacute;n, cualquier p&eacute;rdida de beneficios, interrupci&oacute;n del negocio, p&eacute;rdida de informaci&oacute;n o programas o otros datos de su sistema de manejo de la informaci&oacute;n) que est&aacute;n relacionados con el uso o la imposibilidad de uso, el contenido, los materiales y las funciones de este sitio o cualquier sitio web vinculado, aunque Collins & Aikman o cualquiera de sus subsidiarias o filiales, es expresamente advertido de la posibilidad de tales da&ntilde;os.\r\nCautionary Statement Concerning Forward-Looking Statements\r\nLas declaraciones prospectivas se refieren s&oacute;lo a la fecha en que se hacen. Collins & Aikman  no asume ninguna obligaci&oacute;n de corregir o actualizar p&uacute;blicamente ninguna de ellas a la luz de nueva informaci&oacute;n, eventos futuros u otros. \r\nHist&oacute;ricos y actuales de la poblaci&oacute;n los datos de rendimiento de precios no es necesariamente indicativa de resultados futuros.','Legal Terms and Conditions of Use\r\nCollins & Aikman owns and operates this site, and is making it available to you upon these Terms of Use. By using this site, you signify that you accept these Terms of Use. Do not use the site if you do not accept these terms.\r\nPlease note that we reserve the right, at our discretion, to modify these Terms of Use at any time without notice, so you should check these Terms of Use periodically for modifications. Your continued use of this site following the posting of such modifications will mean that you accept the Terms of Use as modified.\r\nFor purposes of these Terms of Use, \"information\" is defined broadly to include all electronic materials and content, including text, graphics, audio, software and other copyrightable items.\r\nMiscellaneous\r\nCollins & Aikman controls and operates this site from its offices within the United States of America. Collins & Aikman makes no representation that materials on this site are appropriate or available for use in other locations. If you access this site from outside of the United States of America, you are responsible for compliance with all local laws.\r\nThese Terms of Use will be governed by and construed in accordance with the laws of the State of Michigan, without giving effect to any principles of conflicts of law. If any provision of these Terms of Use is determined to be unlawful, void or for any reason unenforceable, then that provision will be deemed severable from these Terms of Use and will not affect the validity and enforceability of any remaining provisions. Any cause of action you may have with respect to your use of this site must be commenced within one year after the claim or cause of action arises. These Terms of Use represent the entire agreement between the parties with respect to your use of this site.\r\nIntellectual Property\r\nCopyright 1999-2005 Collins & Aikman. All rights reserved.\r\nAll the material, text and / or images, contained in the Collins & Aikman web site is the property of Collins & Aikman and is protected by various U.S. and international laws and treaties. Any copying, alteration, distribution, transmission, performance, display or other use of such material, in whole or in part, is prohibited; except Collins & Aikman hereby grants you, without fee, permission to use, copy and distribute such material for NON-COMMERCIAL USE ONLY, provided a) that such material is not altered or edited in any way, b) that the above copyright notice of Collins & Aikman and this permission notice appear in all such material copied and / or otherwise used or distributed by you and c) that any name, trademark or the like of Collins & Aikman or any of Collins & Aikman\'s subsidiaries are not used in any advertising or publicity without specific, prior written permission from Collins & Aikman.\r\nAll product brand names appearing in a type form different from the surrounding text are trademarks of Collins & Aikman or Collins & Aikman\'s subsidiaries. Except for the limited permission to use and distribute copies of the material contained in this web site as expressly stated above, nothing contained herein shall be construed as granting any right or license to anyone under any patent, trademark, copyright or other intellectual property right of Collins & Aikman or Collins & Aikman\'s subsidiaries.\r\nSubmissions by You\r\nWe request that you not send us any unsolicited confidential or proprietary information, including trade secrets, ideas, concepts or know-how. If despite our request you or someone acting on your behalf furnishes us unsolicited information, you acknowledge that Collins & Aikman will be under no obligation to treat such information confidentially and Collins & Aikman will have an unrestricted, irrevocable, worldwide, royalty-free license to use, reproduce, display, transmit and distribute such information.\r\nDisclaimer and Limitation of Liability\r\nThis site, and the information provided here, are provided \"as is\" without any representation or warranty, express or implied, of any kind, including, but not limited to, warranties of merchantability, noninfringement, or fitness for any particular purpose. Some jurisdictions do not allow for the exclusion of implied warranties, so the above exclusions may not apply to you.\r\nIn no event will Collins & Aikman or any of its subsidiaries or affiliates be liable to any entity for any direct, indirect, special, consequential or other damages (including, without limitation, any lost profits, business interruption, loss of information or programs or other data on your information handling system) that are related to the use of, or the inability to use, the content, materials, and functions of this site or any linked website, even if Collins & Aikman or any of its subsidiaries or affiliates is expressly advised of the possibility of such damages.\r\nCautionary Statement Regarding Forward-looking Statements\r\nForward-looking statements speak only as of the date they are made. Collins & Aikman undertakes no obligation to correct or update publicly any of them in light of new information, future events or otherwise.\r\nThe stock information in this investor site is provided for informational purposes only, and is not intended for trading purposes. Neither CKC nor their data or content providers guarantee the sequence, accuracy, or completeness of any stock price information or other data displayed, nor shall any such party be liable in any way to the reader or to any other person, firm or corporation whatsoever for any delays, inaccuracies, errors in, or omission of any such information or data or the transmission thereof, or for any actions taken in reliance thereon or for any damages arising there from or occasioned thereby or by reason of nonperformance or interruption, or termination, of the stock price information for any cause whatsoever.\r\nHistorical and current stock price performance data is not necessarily indicative of future performance.','Modalit&eacute;s et conditions d\'utilisation\r\nCollins & Aikman d&eacute;tient et exploite ce site, et le rend disponible pour vous sur ces conditions d\'utilisation. En utilisant ce site, vous indiquez que vous acceptez ces conditions d\'utilisation. Ne pas utiliser le site si vous n\'acceptez pas ces termes.\r\nS\'il vous pla&icirc;t noter que nous nous r&eacute;servons le droit, &agrave; notre discr&eacute;tion, de modifier les pr&eacute;sentes Conditions d\'Utilisation &agrave; tout moment et sans pr&eacute;avis, de sorte que vous devriez v&eacute;rifier ces conditions d\'utilisation p&eacute;riodiquement pour modifications. Votre utilisation continue de ce site apr&egrave;s l\'affichage de telles modifications signifie que vous acceptez les Conditions d\'utilisation modifi&eacute;es.\r\nAux fins des pr&eacute;sentes Conditions d\'Utilisation, «information» est d&eacute;finie largement pour inclure tous les mat&eacute;riaux &eacute;lectroniques et des contenus, y compris les textes, graphiques, audio, logiciels et autres &eacute;l&eacute;ments prot&eacute;geables.\r\nDivers\r\nCollins & Aikman contr&ocirc;le et exploite ce site depuis ses bureaux situ&eacute;s aux &Eacute;tats-Unis d\'Am&eacute;rique. Collins & Aikman ne fait aucune repr&eacute;sentation que le mat&eacute;riel sur ce site sont appropri&eacute;s ou disponibles pour utilisation dans d\'autres endroits. Si vous acc&eacute;dez &agrave; ce site depuis l\'ext&eacute;rieur des &Eacute;tats-Unis d\'Am&eacute;rique, vous &ecirc;tes responsable du respect de toutes les lois locales.\r\nCes conditions d\'utilisation seront r&eacute;gies et interpr&eacute;t&eacute;es conform&eacute;ment aux lois de l\'&Eacute;tat du Michigan, sans donner effet aux principes de conflits de droit. Si une quelconque disposition de ces conditions d\'utilisation est jug&eacute;e ill&eacute;gale, nulle ou pour toute autre raison inapplicable, cette disposition sera r&eacute;put&eacute;e divisible de ces conditions d\'utilisation et n\'affectera pas la validit&eacute; et l\'applicabilit&eacute; des dispositions restantes. Toute cause d\'action que vous pourriez avoir &agrave; l\'&eacute;gard de votre utilisation de ce site doit &ecirc;tre intent&eacute;e dans l\'ann&eacute;e suivant la r&eacute;clamation ou cause d\'action. Ces conditions d\'utilisation repr&eacute;sentent l\'int&eacute;gralit&eacute; du contrat entre les parties relativement &agrave; votre utilisation de ce site.\r\nPropri&eacute;t&eacute; intellectuelle\r\nCopyright 1999-2005 Collins & Aikman. Tous droits r&eacute;serv&eacute;s.\r\nToutes les images mat&eacute;rielles, texte et / ou, contenues dans le site Web de Collins & Aikman est la propri&eacute;t&eacute; de Collins & Aikman et est prot&eacute;g&eacute; par les lois am&eacute;ricaines et internationales diverses et des trait&eacute;s. Toute copie, modification, distribution, transmission, ex&eacute;cution, affichage ou autre utilisation de ces mati&egrave;res, en tout ou en partie, est interdite, sauf Collins & Aikman vous conc&egrave;de, sans frais, l\'autorisation d\'utiliser, copier et distribuer ce mat&eacute;riel pour les NON commerciales seulement, &agrave; condition a) que ce mat&eacute;riel n\'est pas alt&eacute;r&eacute; ou modifi&eacute; de quelque mani&egrave;re, b) que la mention de copyright ci-dessus de Collins & Aikman et cette autorisation apparaissent dans toutes les mati&egrave;res telles copi&eacute;s et / ou autrement utilis&eacute; ou distribu&eacute; par vous et c) que n\'importe quel nom, marque ou autre de Collins & Aikman ou des filiales de Collins & Aikman ne sont pas utilis&eacute;s dans toute publicit&eacute; sans autorisation sp&eacute;cifique &eacute;crite pr&eacute;alable de Collins & Aikman.\r\nTous les noms de marque de produit apparaissant dans une forme diff&eacute;rente du texte environnant sont des marques de Collins & Aikman ou filiales Collins & Aikman. Sauf pour l\'autorisation limit&eacute;e d\'utiliser et de distribuer des copies du mat&eacute;riel contenu dans ce site web comme express&eacute;ment indiqu&eacute; ci-dessus, rien dans les pr&eacute;sentes ne doit &ecirc;tre interpr&eacute;t&eacute;e comme accordant un droit ou une licence &agrave; quiconque sous aucun brevet, marque, droit d\'auteur ou autre droit de propri&eacute;t&eacute; intellectuelle de Collins & Aikman ou filiales Collins & Aikman.\r\nSoumission que vous faites\r\nNous vous demandons de ne pas nous envoyer d\'informations confidentielles ou propri&eacute;taires non sollicit&eacute;s, y compris les secrets commerciaux, les id&eacute;es, concepts ou savoir-faire. Si, malgr&eacute; notre demande, vous ou quelqu\'un agissant en votre nom nous fournit des informations non sollicit&eacute;es, vous reconnaissez que Collins & Aikman sera sous aucune obligation de traiter ces informations de mani&egrave;re confidentielle et Collins & Aikman aura un droit illimit&eacute; et irr&eacute;vocable, mondiale, libre de redevance pour utiliser, reproduire, afficher, transmettre et distribuer ces informations.\r\nLimitation de responsabilit&eacute;\r\nCe site et les informations fournies ici, sont fournis \"tels quels\" sans aucune repr&eacute;sentation ou garantie, expresse ou implicite, d\'aucune sorte, y compris, mais sans s\'y limiter, les garanties de qualit&eacute; marchande, l\'absence de contrefaçon, ou d\'ad&eacute;quation &agrave; un usage particulier. Certaines juridictions n\'autorisent pas l\'exclusion des garanties implicites, les exclusions ci-dessus peuvent ne pas s\'appliquer &agrave; vous.\r\nEn aucun cas, Collins & Aikman ou une de ses filiales ou soci&eacute;t&eacute;s affili&eacute;es &ecirc;tre soumis &agrave; aucune entit&eacute; pour tout dommage direct, indirect, particulier, cons&eacute;cutif ou autre (y compris, sans limitation, toute perte de profits, interruption d\'activit&eacute;, perte d\'information ou des programmes ou des d\'autres donn&eacute;es sur votre syst&egrave;me d\'information) qui sont li&eacute;s &agrave; l\'utilisation ou l\'impossibilit&eacute; d\'utiliser le contenu, les mat&eacute;riaux, et des fonctions de ce site ou tout site Web li&eacute;, m&ecirc;me si Collins & Aikman ou une de ses filiales ou soci&eacute;t&eacute;s affili&eacute;es sont express&eacute;ment avis&eacute;e de la possibilit&eacute; de tels dommages.\r\nCautionary Statement Concerning Forward-D&eacute;clarations pr&eacute;visionnelles\r\nLes &eacute;nonc&eacute;s prospectifs ne sont valables qu\'&agrave; la date o&ugrave; elles sont faites. Collins & Aikman  n\'assume aucune obligation de corriger ou de mettre &agrave; jour publiquement aucun d\'entre eux &agrave; la lumi&egrave;re de nouvelles informations, &eacute;v&eacute;nements futurs ou autrement. \r\nHistoriques et actuelles donn&eacute;es de stock Prix performances ne sont pas n&eacute;cessairement indicatifs des performances futures.'),
 ('tos.aspx','PageTitle','Términos de Servicio :: Collins & Aikman Sphynx','Terms of Service :: Collins & Aikman\'s Sphynx','Conditions de Service :: Collins & Aikman Sphynx');
/*!40000 ALTER TABLE `labels` ENABLE KEYS */;


--
-- Definition of table `languagenames`
--

DROP TABLE IF EXISTS `languagenames`;
CREATE TABLE `languagenames` (
  `ilanguageid` int(11) NOT NULL,
  `slanguagename_esmx` varchar(100) NOT NULL,
  `slanguagename_enus` varchar(100) NOT NULL,
  `slanguagename_fr` varchar(100) NOT NULL,
  PRIMARY KEY (`ilanguageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `languagenames`
--

/*!40000 ALTER TABLE `languagenames` DISABLE KEYS */;
INSERT INTO `languagenames` (`ilanguageid`,`slanguagename_esmx`,`slanguagename_enus`,`slanguagename_fr`) VALUES 
 (1,'Español','Spanish','Espagnol'),
 (2,'Inglés','English','Anglais'),
 (3,'Francés','French','Français');
/*!40000 ALTER TABLE `languagenames` ENABLE KEYS */;


--
-- Definition of table `languages`
--

DROP TABLE IF EXISTS `languages`;
CREATE TABLE `languages` (
  `ilanguageid` int(11) NOT NULL,
  `slanguagecode` varchar(4) NOT NULL,
  `blive` int(1) NOT NULL,
  PRIMARY KEY (`ilanguageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `languages`
--

/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` (`ilanguageid`,`slanguagecode`,`blive`) VALUES 
 (1,'esmx',1),
 (2,'enus',1),
 (3,'fr',1);
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
 ('2011-08-26 01:33:51','Timeout Query'),
 ('2011-08-26 01:52:18','Timeout Query'),
 ('2011-08-26 02:08:15','Timeout Query'),
 ('2011-08-26 02:28:12','Timeout Query'),
 ('2011-08-26 14:52:09','Timeout Query'),
 ('2011-08-26 15:07:14','Timeout Query'),
 ('2011-08-26 15:28:39','Timeout Query');
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
 ('addLanguage','#',0,1,'memozebadua','2011-08-08 00:00:00','','','','','',''),
 ('addUser','#',0,1,'memozebadua','2011-08-08 00:00:00','','','','','',''),
 ('deactivateUser','#',0,1,'memozebadua','2011-08-08 00:00:00','','','','','',''),
 ('mnuLangsAndLabels','displayLang.aspx',1,1,'memozebadua','2011-08-08 00:00:00','Lenguajes y Etiquetas','Crea un nuevo lenguaje para el sitio y edita las etiquetas actuales!','Languages and Labels','Create new languages for the site on-the-fly and edit current labels!','Langues et étiquettes','Cr&eacute;e de nouvelles langues pour le site sur la vol&eacute;e et de modifie les &eacute;tiquettes actuelles!'),
 ('mnuUsers','displayUsers.aspx',1,1,'memozebadua','2011-08-08 00:00:00','Usuarios','Administraci&oacute;n de Usuarios','Users','Users Administration','Utilisateurs','Administration des Utilisateurs');
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
 ('memozebadua','2hwbbu55rajyhqropqmfxlj0',1,0,0,0,'127.0.0.1','POLARIS','2011-08-26 01:52:18','2011-08-26 01:58:39'),
 ('memozebadua','4g5nod55wvhw2anuojoh0svf',1,0,0,0,'127.0.0.1','POLARIS','2011-08-26 02:08:15','2011-08-26 02:19:24'),
 ('memozebadua','4g5nod55wvhw2anuojoh0svf',1,0,0,0,'127.0.0.1','POLARIS','2011-08-26 02:15:53','2011-08-26 02:19:24'),
 ('memozebadua','aywogp45d1s02vasu2vfyaa5',1,0,0,0,'127.0.0.1','POLARIS','2011-08-26 02:01:22','2011-08-26 02:02:25'),
 ('memozebadua','fhnqsq55qiofja45uixd1v45',1,0,0,0,'127.0.0.1','POLARIS','2011-08-26 14:52:09','2011-08-26 15:11:02'),
 ('memozebadua','fhnqsq55qiofja45uixd1v45',1,0,0,0,'127.0.0.1','POLARIS','2011-08-26 14:55:31','2011-08-26 15:11:02'),
 ('memozebadua','fhnqsq55qiofja45uixd1v45',1,0,0,0,'127.0.0.1','POLARIS','2011-08-26 15:07:14','2011-08-26 15:11:02'),
 ('memozebadua','fhnqsq55qiofja45uixd1v45',1,0,0,0,'127.0.0.1','POLARIS','2011-08-26 15:10:34','2011-08-26 15:11:02'),
 ('memozebadua','fhnqsq55qiofja45uixd1v45',1,0,0,0,'127.0.0.1','POLARIS','2011-08-26 15:28:39',NULL),
 ('memozebadua','fhnqsq55qiofja45uixd1v45',1,0,0,0,'127.0.0.1','POLARIS','2011-08-26 15:30:51',NULL),
 ('memozebadua','fhnqsq55qiofja45uixd1v45',1,0,0,0,'127.0.0.1','POLARIS','2011-08-26 15:35:44',NULL),
 ('memozebadua','fhnqsq55qiofja45uixd1v45',1,0,0,0,'127.0.0.1','POLARIS','2011-08-26 15:41:48',NULL),
 ('memozebadua','udy5vq3xpeuiilb0ng4tjvvn',1,0,0,0,'127.0.0.1','POLARIS','2011-08-26 02:21:17','2011-08-26 02:28:12'),
 ('memozebadua','xffxoerff5k0oryqefe0nkuj',1,0,0,0,'127.0.0.1','POLARIS','2011-08-26 01:33:51','2011-08-26 01:34:25'),
 ('memozebadua','xffxoerff5k0oryqefe0nkuj',1,0,0,0,'127.0.0.1','POLARIS','2011-08-26 01:41:35',NULL),
 ('memozebadua','xffxoerff5k0oryqefe0nkuj',1,0,0,0,'127.0.0.1','POLARIS','2011-08-26 01:46:49',NULL);
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
 (1,'2011-08-26 01:33:51','memozebadua','xffxoerff5k0oryqefe0nkuj','127.0.0.1','POLARIS','Login Attempt from Page login.aspx with a True result','1'),
 (2,'2011-08-26 01:34:25','memozebadua','xffxoerff5k0oryqefe0nkuj','127.0.0.1','POLARIS','Logout from Page displayUsers.aspx','1'),
 (3,'2011-08-26 01:41:35','memozebadua','xffxoerff5k0oryqefe0nkuj','127.0.0.1','POLARIS','Login Attempt from Page login.aspx with a True result','1'),
 (4,'2011-08-26 01:46:49','memozebadua','xffxoerff5k0oryqefe0nkuj','127.0.0.1','POLARIS','Login Attempt from Page login.aspx with a True result','1'),
 (5,'2011-08-26 01:52:18','memozebadua','2hwbbu55rajyhqropqmfxlj0','127.0.0.1','POLARIS','Login Attempt from Page login.aspx with a True result','1'),
 (6,'2011-08-26 01:58:39','memozebadua','2hwbbu55rajyhqropqmfxlj0','127.0.0.1','POLARIS','Logout from Page displayUsers.aspx','1'),
 (7,'2011-08-26 02:01:22','memozebadua','aywogp45d1s02vasu2vfyaa5','127.0.0.1','POLARIS','Login Attempt from Page login.aspx with a True result','1'),
 (8,'2011-08-26 02:02:25','memozebadua','aywogp45d1s02vasu2vfyaa5','127.0.0.1','POLARIS','Logout from Page displayUsers.aspx','1'),
 (9,'2011-08-26 02:08:15','memozebadua','4g5nod55wvhw2anuojoh0svf','127.0.0.1','POLARIS','Login Attempt from Page login.aspx with a True result','1'),
 (10,'2011-08-26 02:08:15','memozebadua','xffxoerff5k0oryqefe0nkuj','127.0.0.1','POLARIS','Logout from Timeout','1'),
 (11,'2011-08-26 02:10:04','memozebadua','4g5nod55wvhw2anuojoh0svf','127.0.0.1','POLARIS','Logout from Page displayUsers.aspx','1'),
 (12,'2011-08-26 02:15:53','memozebadua','4g5nod55wvhw2anuojoh0svf','127.0.0.1','POLARIS','Login Attempt from Page login.aspx with a True result','1'),
 (13,'2011-08-26 02:19:24','memozebadua','4g5nod55wvhw2anuojoh0svf','127.0.0.1','POLARIS','Logout from Page displayUsers.aspx','1'),
 (14,'2011-08-26 02:21:17','memozebadua','udy5vq3xpeuiilb0ng4tjvvn','127.0.0.1','POLARIS','Login Attempt from Page login.aspx with a True result','1'),
 (15,'2011-08-26 02:28:12','memozebadua','udy5vq3xpeuiilb0ng4tjvvn','127.0.0.1','POLARIS','Logout from Page displayUsers.aspx','1'),
 (16,'2011-08-26 02:28:12','memozebadua','xffxoerff5k0oryqefe0nkuj','127.0.0.1','POLARIS','Logout from Timeout','1'),
 (17,'2011-08-26 14:52:09','memozebadua','fhnqsq55qiofja45uixd1v45','127.0.0.1','POLARIS','Login Attempt from Page login.aspx with a True result','1'),
 (18,'2011-08-26 14:52:09','memozebadua','xffxoerff5k0oryqefe0nkuj','127.0.0.1','POLARIS','Logout from Timeout','1'),
 (19,'2011-08-26 14:55:31','memozebadua','fhnqsq55qiofja45uixd1v45','127.0.0.1','POLARIS','Login Attempt from Page login.aspx with a True result','1'),
 (20,'2011-08-26 15:07:14','memozebadua','fhnqsq55qiofja45uixd1v45','127.0.0.1','POLARIS','Login Attempt from Page login.aspx with a True result','1'),
 (21,'2011-08-26 15:10:34','memozebadua','fhnqsq55qiofja45uixd1v45','127.0.0.1','POLARIS','Login Attempt from Page login.aspx with a True result','1'),
 (22,'2011-08-26 15:11:02','memozebadua','fhnqsq55qiofja45uixd1v45','127.0.0.1','POLARIS','Logout from Page displayUsers.aspx','1'),
 (23,'2011-08-26 15:28:39','memozebadua','fhnqsq55qiofja45uixd1v45','127.0.0.1','POLARIS','Login Attempt from Page login.aspx with a True result','1'),
 (24,'2011-08-26 15:28:39','memozebadua','xffxoerff5k0oryqefe0nkuj','127.0.0.1','POLARIS','Logout from Timeout','1'),
 (25,'2011-08-26 15:30:51','memozebadua','fhnqsq55qiofja45uixd1v45','127.0.0.1','POLARIS','Login Attempt from Page login.aspx with a True result','1'),
 (26,'2011-08-26 15:35:44','memozebadua','fhnqsq55qiofja45uixd1v45','127.0.0.1','POLARIS','Login Attempt from Page login.aspx with a True result','1'),
 (27,'2011-08-26 15:41:48','memozebadua','fhnqsq55qiofja45uixd1v45','127.0.0.1','POLARIS','Login Attempt from Page login.aspx with a True result','1');
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
 ('memozebadua','addLanguage','memozebadua','2011-08-08 00:00:00'),
 ('memozebadua','addUser','memozebadua','2011-08-08 00:00:00'),
 ('memozebadua','deactivateUser','memozebadua','2011-08-08 00:00:00'),
 ('memozebadua','mnuLangsAndLabels','memozebadua','2011-08-08 00:00:00'),
 ('memozebadua','mnuUsers','memozebadua','2011-08-08 00:00:00');
/*!40000 ALTER TABLE `userpermissions` ENABLE KEYS */;


--
-- Definition of table `userplants`
--

DROP TABLE IF EXISTS `userplants`;
CREATE TABLE `userplants` (
  `susername` varchar(100) NOT NULL,
  `icompanyid` int(11) NOT NULL,
  `iplantid` int(11) NOT NULL,
  `screatingusername` varchar(100) NOT NULL,
  `screatingdate` datetime NOT NULL,
  PRIMARY KEY (`susername`,`icompanyid`,`iplantid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `userplants`
--

/*!40000 ALTER TABLE `userplants` DISABLE KEYS */;
INSERT INTO `userplants` (`susername`,`icompanyid`,`iplantid`,`screatingusername`,`screatingdate`) VALUES 
 ('memozebadua',1,1,'memozebadua','2011-01-01 00:00:00');
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
 ('memozebadua','0iur2v6gMWLJCz4uJFz45bFaPbW+o6qgNeweCVl5E9LI4DRX64QYYC2pZXT30Leq/5+IHkVZnfJyek8vNHJQDFRvIHNlZSBhIHdvcmxkIGluIGEgZ3JhaW4gb2Ygc2FuZCBhbmQgYSBoZWF2ZW4gaW4gYSB3aWxkIGZsb3dlci4gSG9sZCBpbmZpbml0eSBpbiB0aGUgcGFsbSBvZiB5b3VyIGhhbmQgYW5kIEV0ZXJuaXR5IGluIGFuIGhvdXI=','My father Middle name','egGnEe9hEHXwPL9qXmpE4uundGsJC0K6Furl9Orzp5vnYnvM1MqLRCr0AY0mfgfD6dkKvJMHDIIPVd63L7DFTlRvIHNlZSBhIHdvcmxkIGluIGEgZ3JhaW4gb2Ygc2FuZCBhbmQgYSBoZWF2ZW4gaW4gYSB3aWxkIGZsb3dlci4gSG9sZCBpbmZpbml0eSBpbiB0aGUgcGFsbSBvZiB5b3VyIGhhbmQgYW5kIEV0ZXJuaXR5IGluIGFuIGhvdXI=',1,1,1,0,1,'Guillermo Zebadua','Memo','memozebadua@gmail.com','enus',0,'','memozebadua','2011-01-01 00:00:00','memozebadua','2011-01-01 00:00:00');
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
