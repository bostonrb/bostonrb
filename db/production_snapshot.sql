-- MySQL dump 10.9
--
-- Host: localhost    Database: boston_rb_production
-- ------------------------------------------------------
-- Server version	4.1.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `commits`
--

DROP TABLE IF EXISTS `commits`;
CREATE TABLE `commits` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `url` varchar(255) default NULL,
  `published_at` datetime default NULL,
  `project_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `commits`
--


/*!40000 ALTER TABLE `commits` DISABLE KEYS */;
LOCK TABLES `commits` WRITE;
INSERT INTO `commits` VALUES (1,'Messing with git configs, updating README to declare \"alpha\" status.','http://github.com/dancroak/recommendable/commit/51bac8797bcc33b77790a822b4fcaa4edf844e86',NULL,18703980,'2008-04-27 21:21:29','2008-04-27 21:21:29'),(2,'updated README','http://github.com/dancroak/recommendable/commit/6a46a9b097894d7fdb7f4d3c82e5d62e412b896c',NULL,18703980,'2008-04-27 21:21:29','2008-04-27 21:21:29'),(3,'all conditions in similar query no longer hard-coded','http://github.com/dancroak/recommendable/commit/3f53df0ab372935cdd99e877a2bd6715ed17d22d',NULL,18703980,'2008-04-27 21:21:29','2008-04-27 21:21:29'),(4,'we do not know why this is here','http://github.com/dancroak/recommendable/commit/f7fe8228cc43b8e05bc8a03ba225a554bee59d5a',NULL,18703980,'2008-04-27 21:21:29','2008-04-27 21:21:29'),(5,'recommendable macro passing tests','http://github.com/dancroak/recommendable/commit/7cb7b43ea2bf7a0cd7868475227f564445e4394e',NULL,18703980,'2008-04-27 21:21:29','2008-04-27 21:21:29'),(6,'added notes back in','http://github.com/dancroak/recommendable/commit/8322abc8d55842e6be43e2200299175d0b306bf3',NULL,18703980,'2008-04-27 21:21:29','2008-04-27 21:21:29'),(7,'rolled back to pre-polymorphs','http://github.com/dancroak/recommendable/commit/c3fe788b38d2fbb32892f6cd4edf3356394a9fd7',NULL,18703980,'2008-04-27 21:21:29','2008-04-27 21:21:29'),(8,'last commit before rolling back to pre-polymoprhs','http://github.com/dancroak/recommendable/commit/0779a55f2d5f4b1ab24ac09b5a3884b2be6f376f',NULL,18703980,'2008-04-27 21:21:29','2008-04-27 21:21:29'),(9,'going the has_many_polymorphs route','http://github.com/dancroak/recommendable/commit/d24ed8e25cb7ec3514500fbe3e9a3a253e4a8a87',NULL,18703980,'2008-04-27 21:21:29','2008-04-27 21:21:29'),(10,'trying some reflection on AR','http://github.com/dancroak/recommendable/commit/8fc5a3a7122de0afbcc336907fce6a429a9c47c0',NULL,18703980,'2008-04-27 21:21:29','2008-04-27 21:21:29'),(11,'Updated rakefile.','http://github.com/technicalpickles/ambitious-sphinx/commit/d71e376ab10280a17f76207d0535535aad526d1f',NULL,183206821,'2008-04-27 21:21:32','2008-04-27 21:21:32'),(12,'README updates.','http://github.com/technicalpickles/ambitious-sphinx/commit/c10f14778f8346128fceacdf03749c4556eb6e69',NULL,183206821,'2008-04-27 21:21:32','2008-04-27 21:21:32'),(13,'Added appropriate nodoc.','http://github.com/technicalpickles/ambitious-sphinx/commit/c2cade9d26c6980f024518de484dcfa917b91edd',NULL,183206821,'2008-04-27 21:21:32','2008-04-27 21:21:32'),(14,'A few more cleanups.','http://github.com/technicalpickles/ambitious-sphinx/commit/14d66d6877688d4b4a9133fd3def7460effc2851',NULL,183206821,'2008-04-27 21:21:32','2008-04-27 21:21:32'),(15,'Put modules back to the way they were.','http://github.com/technicalpickles/ambitious-sphinx/commit/c1efe67d2285a3c5ea5fd5186d1f7936de0877a9',NULL,183206821,'2008-04-27 21:21:32','2008-04-27 21:21:32'),(16,'Merged in from paging branch.','http://github.com/technicalpickles/ambitious-sphinx/commit/2414d0c29ce705ff193d2e5b63c9e4f5493b8fa7',NULL,183206821,'2008-04-27 21:21:32','2008-04-27 21:21:32'),(17,'More rdoc improvements','http://github.com/technicalpickles/ambitious-sphinx/commit/753416af4550d0bc834f7891526e128d16c116d6',NULL,183206821,'2008-04-27 21:21:32','2008-04-27 21:21:32'),(18,'Playing around with modules.','http://github.com/technicalpickles/ambitious-sphinx/commit/c1588c2424dbf9b47f16ef40bde58d34ce0ac6a6',NULL,183206821,'2008-04-27 21:21:32','2008-04-27 21:21:32'),(19,'Better docs.','http://github.com/technicalpickles/ambitious-sphinx/commit/2f1350285f55c6ea69b6dae00294d14fc183a1da',NULL,183206821,'2008-04-27 21:21:32','2008-04-27 21:21:32'),(20,'Minor rdoc cleanup.','http://github.com/technicalpickles/ambitious-sphinx/commit/68437f4becda9392b8f50e7011a1d4f6505230ab',NULL,183206821,'2008-04-27 21:21:32','2008-04-27 21:21:32'),(21,'making the README use markdown','http://github.com/dancroak/spec_factories/commit/c2b923cfc6747dcd66d566607c28d7bd6484348f',NULL,916386295,'2008-04-27 21:21:34','2008-04-27 21:21:34'),(22,'she works! updated README with instructions for usage','http://github.com/dancroak/spec_factories/commit/295f90421bdcea6140fd63436f28f04ae3926837',NULL,916386295,'2008-04-27 21:21:34','2008-04-27 21:21:34'),(23,'a few bug fixes, more dir cleaning','http://github.com/dancroak/spec_factories/commit/5943bcf23ee02795cb6e139d6ae2bc404f57e439',NULL,916386295,'2008-04-27 21:21:34','2008-04-27 21:21:34'),(24,'inching toward a working generator','http://github.com/dancroak/spec_factories/commit/17903d44b1c26a62eec483c2ef8a548e87c67072',NULL,916386295,'2008-04-27 21:21:34','2008-04-27 21:21:34'),(25,'changing README','http://github.com/dancroak/spec_factories/commit/765a1220ad1b0ac161ec1e0be6e0b56d2c26f529',NULL,916386295,'2008-04-27 21:21:34','2008-04-27 21:21:34'),(26,'removing old gem stuff','http://github.com/dancroak/spec_factories/commit/628b2780a325dfc3dbe004f1158a301a97504917',NULL,916386295,'2008-04-27 21:21:34','2008-04-27 21:21:34'),(27,'testing git rm','http://github.com/dancroak/spec_factories/commit/0c04eaccbfbba1d0675cfcddc5213424ba80cbe3',NULL,916386295,'2008-04-27 21:21:34','2008-04-27 21:21:34'),(28,'removing unnecessary gem stuff, decided to do stripped-down rails generator','http://github.com/dancroak/spec_factories/commit/1795ea0ce0e468c3600f4c1f4c2c286e290b3b50',NULL,916386295,'2008-04-27 21:21:34','2008-04-27 21:21:34'),(29,'adding rest of newgem-created files','http://github.com/dancroak/spec_factories/commit/5a71d803a52ded352bd703915ac13afd0b366296',NULL,916386295,'2008-04-27 21:21:34','2008-04-27 21:21:34'),(30,'first commit','http://github.com/dancroak/spec_factories/commit/302c17f0d3d933252cc58b854c4b9026432c9a5b',NULL,916386295,'2008-04-27 21:21:34','2008-04-27 21:21:34'),(31,'adding james and joe to copyright','http://github.com/thoughtbot/quietbacktrace/commit/51255856d97f935d6415897053529e4cb1318a3e',NULL,916386294,'2008-04-27 21:25:11','2008-04-27 21:25:11'),(32,'added licensing to ActiveSupport snippets','http://github.com/thoughtbot/quietbacktrace/commit/825ba1f03d8df72408aa943a15561b11598d8c47',NULL,916386294,'2008-04-27 21:25:12','2008-04-27 21:25:12'),(33,'changed gem install line to match the request made to rubyforge','http://github.com/thoughtbot/quietbacktrace/commit/72eb5ea00c48fbf897246f9b350088ff59c57470',NULL,916386294,'2008-04-27 21:25:12','2008-04-27 21:25:12'),(34,'altered how vendor directory works in Rails, improved README','http://github.com/thoughtbot/quietbacktrace/commit/d069cafc627e1d343c1ff37dd498a0956b7d4d0c',NULL,916386294,'2008-04-27 21:25:12','2008-04-27 21:25:12'),(35,'altered the e1 silencer','http://github.com/thoughtbot/quietbacktrace/commit/d170278d9fc54b0d07ae926155cb94a536690931',NULL,916386294,'2008-04-27 21:25:12','2008-04-27 21:25:12'),(36,'fixed final test failures based on James patch','http://github.com/thoughtbot/quietbacktrace/commit/5bc4ef7ca2700b3d90116197e437a06ce0d1c81e',NULL,916386294,'2008-04-27 21:25:12','2008-04-27 21:25:12'),(37,'added e1 nonsense silencer','http://github.com/thoughtbot/quietbacktrace/commit/cab9ec9cd9c074c4a29819d053c8eb20dff1e733',NULL,916386294,'2008-04-27 21:25:12','2008-04-27 21:25:12'),(38,'added james golick blog link, different email address','http://github.com/thoughtbot/quietbacktrace/commit/666c9fec7e83e673d575ef5d1ee6da2a4e855d54',NULL,916386294,'2008-04-27 21:25:12','2008-04-27 21:25:12'),(39,'fixed most test failures','http://github.com/thoughtbot/quietbacktrace/commit/93f93a84e8c4d7756f11d4a720a711d0a386bf36',NULL,916386294,'2008-04-27 21:25:12','2008-04-27 21:25:12'),(40,'baby steps toward turning this sucker into a gem','http://github.com/thoughtbot/quietbacktrace/commit/902995b05088becfaffe0ec1bc1a82084216209e',NULL,916386294,'2008-04-27 21:25:12','2008-04-27 21:25:12');
UNLOCK TABLES;
/*!40000 ALTER TABLE `commits` ENABLE KEYS */;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
CREATE TABLE `events` (
  `id` int(11) NOT NULL auto_increment,
  `date` datetime default NULL,
  `event_type` varchar(255) default NULL,
  `description` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `location` varchar(255) default NULL,
  `lng` float default NULL,
  `lat` float default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `events`
--


/*!40000 ALTER TABLE `events` DISABLE KEYS */;
LOCK TABLES `events` WRITE;
INSERT INTO `events` VALUES (91133883,'2008-04-28 00:00:00','Meeting','The Ezra event tonight has been cancelled.','2008-04-16 13:30:20','2008-04-28 18:29:24',NULL,NULL,NULL),(420662881,'2008-04-15 00:00:00','Hackfest','Worked on creating the app for this site, [bostonrb.org](http://bostonrb.org).\r\n\r\nUsed the [Haml bundle for Textmate](http://bjhess.com/bjhessblog/2007/05/31/installing-haml-bundle-for-textmate/)','2008-04-16 13:30:20','2008-04-29 19:09:53',NULL,NULL,NULL),(530957960,'2008-04-15 00:00:00','Kata','Example of a kata.','2008-04-16 13:30:20','2008-04-21 22:50:57',NULL,NULL,NULL),(530957961,'2008-04-29 00:00:00','Hackfest','Polishing recommendable into a usable gem and experimenting with using github as a gem server.\r\n\r\nRSVP via [upcoming](http://upcoming.yahoo.com/event/519014/)','2008-04-27 19:20:35','2008-04-28 13:34:58',NULL,NULL,NULL),(530957962,'2008-05-06 19:00:00','Hackfest','Either recommendable gem or extending Rails fixtures to be more factory-like.','2008-04-29 21:41:27','2008-05-06 11:50:36','41 Winter Street, Boston, MA, 02018',-71.0616,42.3562),(530957963,'2008-05-13 00:00:00','Meeting','This month\'s meeting will be at __[Sermo](http://www.sermo.com/)__, 215 First St, Cambridge, MA on Tuesday, May 13th from 7 to 9pm. _You can get in as early as 6:30 PM_\r\n\r\nThis meeting is sponsored by [Viximo](http://www.viximo.com)\r\n\r\nThe agenda for Tuesday, 5/13 is:\r\n\r\n * Mark Bates will be presenting the Mack Framework.\r\n * [Mack](http://www.mackframework.com) is a Ruby web framework being designed for distributed, portal-like applications, using \'best of breed\' technologies and form, with an emphasis on performance.','2008-04-30 20:56:51','2008-05-01 13:47:50','215 First Street, Cambridge, MA',-71.079,42.3644);
UNLOCK TABLES;
/*!40000 ALTER TABLE `events` ENABLE KEYS */;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs` (
  `id` int(11) NOT NULL auto_increment,
  `gig` tinyint(1) default NULL,
  `location` varchar(255) default NULL,
  `organization` varchar(255) default NULL,
  `title` varchar(255) default NULL,
  `description` text,
  `email` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `jobs`
--


/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
LOCK TABLES `jobs` WRITE;
INSERT INTO `jobs` VALUES (1,0,'Cambridge, MA','Viximo','Server Developer (aka Ruby on Rails Rockstar)','Viximo is building a rich creative community and a massively scalable service to deliver content over the web that helps creators, developers, and site owners monetize social interactions. We\'re the product of a cool co-working space in Cambridge, so if you\'ve ever considered starting your own company or are excited about the opportunity to make a big impact on something in its earliest stages, this is the place for you.  We are venture funded and our environment is fast-paced, team oriented, and highly interactive. So if you\'re a Ruby star (or willing to become one) and that sounds like a fit for you, then give us a shout.\r\n                \r\nResponsibilities:\r\n                \r\n* You will be working daily in Ruby on Rails with some occasional Javascript and SQL.\r\n* Design and implement extremely high-volume, fault-tolerant, scalable server systems.\r\n                \r\nRequirements:\r\n                \r\n* BS or MS in Computer Science or equivalent.\r\n* Extensive experience developing scalable solutions with Ruby, Python, or PHP.\r\n* Knowledge of relational databases and SQL.\r\n* Knowledge developing and debugging on Unix/Linux systems.\r\n                \r\nThis is a full-time position, on-site at our offices in Cambridge, MA.\r\n                \r\nAnd since we get a lot of resumes, help us get to know you a little better by answering the following questions in your contact:\r\n                \r\n1. If we gave you control of the office sound system, what would you play?\r\n2. What one product or gadget can you not live without?\r\n3. What is your favorite social network and why?\r\n4. What blogs do you read on a regular basis?\r\n5. What is one unique bit of trivia about you that we might find interesting?\r\n\r\nsend resume to: jobs+brug@viximo.com\r\n                \r\nNo recruiters or offshore teams please, we\'ve already got our hands full thanks. ','jobs+brug@viximo.com','2008-04-28 19:41:28','2008-04-29 06:24:02'),(2,0,'Natick, MA','MathWorks','Web Services Developer','[Apply here](http://www.mathworks.com/company/jobs/opportunities/Job-6257-Web-Services-Developer-Product-to-Web-Integration.html)\r\n\r\nJob Summary\r\n-----------\r\n\r\nWeb Services Application Developer to design, develop and deliver web services that integrate with our existing desktop applications. Candidate will provide demonstrable expertise of web services; including testability, performance, deploy-ability and availability aspects. You will work with a cross-functional team focused on product-based web services.\r\n\r\nResponsibilities\r\n----------------\r\n\r\n* Design, develop, debug, document and test Web Services.\r\n* Define and develop integration points between external web services and internal systems.\r\n* Create design specifications and test case documents. Participate in design discussions and code reviews.\r\n* Provide project leads with proper time estimates for assigned tasks and periodic status regarding development progress.\r\n* Work with Product Development, Quality Engineering, Usability, Documentation, and other related teams to refine product requirement specifications, functional specifications.\r\n* Provide documentation as required.\r\n* Participate in defining the product integration strategy.\r\n\r\nQualifications\r\n--------------\r\n\r\n* BS degree in computer science or software engineering.\r\n* Seven (7+) years of commercial software engineering experience and practical knowledge of Object-Oriented analysis and design, design patterns, rapid development, and software engineering principles.\r\n* Five (5) years of commercial software engineering experience using Java technologies, including 3+ years with Web Services.\r\n* Experience with one or more of the following: ESBs, WS-I, WS-Security, WS-BPEL, ESBs.\r\n* Proficiency in XML (including XML Schema, XSL, XPath, XQuery), SQL and database concepts.\r\n* Strong programming and debugging skills with strong understanding of project cycles, software development environments, and source control techniques.\r\n* Ability to take ownership of extensive development tasks.\r\n* Ability to work on a team with many constituents.\r\n* Demonstrated ability to translate business requirements into technical designs.','','2008-04-28 20:17:59','2008-04-28 20:17:59'),(3,0,'Natick, MA','MathWorks','Web Application Developer','[Apply here](http://www.mathworks.com/company/jobs/opportunities/Job-6259-Web-Application-Developer.html)\r\n\r\nJob Summary\r\n-----------\r\n                \r\nCome help make our MATLAB Community a better place with your Web 2.0 development expertise. As a Business Applications Developer for our MATLAB Community, you will be responsible for the analysis, design and development of a variety of socially oriented applications. You must have a solid experience building web applications and know how to tune them for performance and availability.\r\n                \r\nResponsibilities\r\n----------------\r\n                \r\nYou will be responsible for the technical implementation of our community applications on MathWorks.com. Responsibilities also include assisting business areas in defining their needs and effectively translating business and technical requirements into functional specifications and application designs. This includes collaborating with usability and designers to develop workflows and page designs.\r\n                \r\nWe are looking for developers with a strong commitment to quality and reliability as well as an enthusiasm for developing social web applications. \r\n                \r\nQualifications\r\n--------------\r\n                \r\n* 8+ years development experience\r\n* BS in Computer Science or equivalent\r\n* Experience designing  & developing MVC web applications in either Struts/Java or Ruby on Rails\r\n* Solid database experience including SQL Server, mySQL and database modeling concepts\r\n* Web 2.0 experience including the use of XML, RSS, AJAX , REST, SOAP\r\n* Must have proven experience developing and deploying high quality code\r\n* Experience with developing community applications a plus\r\n* Experience with Web Logic or Apache a plus','','2008-04-28 20:19:52','2008-04-28 20:20:59'),(4,0,'Cambridge, MA','MakeMeSustainable','Rails programmer','Briefly, [MakeMeSustainable](http://makemesustainable.com) is a small, angel funded, environmental start up. We have developed a Beta website designed to connect people\'s desire to help the environment with their ability to do so through simple, tangible solutions. \r\n                \r\nWe aren\'t necessarily looking for a single programmer,\r\nit could be a group of people of varying experience.\r\n\r\n* Desire to work initially on an incentive based (equity share and\r\npartnership in the company, with minimal cash compensation but strong\r\npotential upside) contract until the time of venture funding. At that\r\ntime developer would be invited to act as a central architect and\r\nengineer of the MMS system.\r\n* Opportunity to step in early with a start up in a rapidly expanding\r\nindustry and work towards CTO position\r\n* Help MMS build an internal team over the next 6-12 months coinciding\r\nwith venture funding or revenue growth, either as head developer or\r\ncontinued part-time engineer per your preference','','2008-04-28 20:29:08','2008-04-28 20:29:39'),(5,0,'Prudential Building, Boston, MA','OneCause','Senior Web Developer','Are you a Web Developer with experience working on Consumer Websites?\r\nDo you like the idea of working for a company that isn\'t a non-profit,\r\nbut works to help others?  Are you dedicated to working with the most\r\ncutting-edge technology?  If so, now is the time to learn more about\r\n[OneCause](http://onecause.com)!\r\n\r\nOneCause, is a loyalty marketing company for community-minded\r\nmerchants and services providers. We offer a nontraditional\r\nfundraising platform for schools and nonprofit organizations, while\r\nsimultaneously providing community-minded merchants and service\r\nproviders a cause-based loyalty marketing program.\r\n\r\nOur parent company, Rakuten, headquartered in Tokyo, is one of the\r\nworld\'s largest and most comprehensive Internet service companies,\r\nproviding leading services in e-commerce, portal & media, travel,\r\nfinancial services, and professional sports.  Internationally, Rakuten\r\nhas 3,000 employees in 7 countries and yields over a billion dollars\r\nin annual revenue.  Rakuten has one of the most recognized Internet\r\nbrands in Japan and owns Japan\'s newest professional baseball\'s\r\nfranchise, the Rakuten Eagles.\r\n\r\nWeb Developer\r\n-------------\r\n\r\nUnder the direction of our Director of Technology, our new Developer\r\nwill be responsible for both new/migratory application system design\r\nand development in Ruby on Rails, PHP, Java Servlets, JSP, and Java\r\nbackend applications.\r\n\r\nCauseLoyalty works with state of the art technology including a\r\nweb-based client login interface, transaction processing systems,\r\ninvoicing and payment systems, a corporate web site, ad serving and\r\ntracking, mass e-mail systems, as well as several backend and other\r\nOLTP systems. MySQL and Oracle are the current RDBMS used for these\r\nsystems.\r\n\r\nRequired Skills and Experience:\r\n-------------------------------\r\n\r\n* Bachelor\'s degree in Computer Science or related field.\r\n* Experience with MySQL or Oracle, or other compatible SQL and PL/SQL.\r\n* Solid experience designing and programming a Ruby on Rails or Java\r\nweb-based system either in an educational/research or business\r\nenvironment.\r\n* Experience or familiarity with Unix/Linux, Web Services, XML/XSL,\r\nSOAP, AJAX, Ruby on Rails, PHP, J2EE, EJB, Struts, JavaScript, HTML,\r\nCSS.\r\n* Strong verbal & written communication skills.  \"Team Player\"\r\nmentaility is a must.\r\n* Excellent problem-solving skills.\r\n* Ability to work in a fast-paced deadline-driven environment.\r\n* A Fascination with technology and a drive to succeed.\r\n* Experience with, and interest in; social networking, social\r\nshopping, e-commerce, affiliate marketing, ad networks and/or consumer\r\nwebsites.\r\n* Aptitude for standard project lifecycle practices including source\r\ncode versioning control and maintenance.\r\n* Experience with open source projects.\r\n* Leadership qualities and project management skills (successful\r\ncandidates may be tasked with leading projects.)','seanhussey@gmail.com','2008-04-28 20:38:40','2008-04-28 20:38:40'),(6,0,'Cambridge','traineo','Merb Developer','URL: http://www.traineo.com\r\n\r\ntraineo is seeking an experienced Web Developer to join our small, dynamic, and growing team.\r\n\r\nThe Web Developer will help build exciting new features using the latest web technologies. The ideal candidate combines strong Ruby (Rails/Merb) programming skills; experience building complex web applications using HTML, AJAX, JavaScript, and CSS.\r\n\r\nIn your role you will be responsible for multiple components of the software development lifecycle (testing, design, coding, implementation and maintenance). The ideal candidate will also play an active role in marketing and business initiatives outside their area of expertise.\r\n\r\nRequirements:\r\n* Expertise in Ruby (Rails/Merb), Unix, XHTML, CSS, Javascript, AJAX.\r\n* 3+ years experience developing complex web applications.\r\n* Proven ability to work well in a team environment.\r\n* A passion for creating excellent user interfaces.\r\n* Portfolio of web-applications using latest web technologies.\r\n\r\nPreferable Additional Skills:\r\n* Expertise with Flash and PhotoShop.\r\n* B.S. Computer Science or related field.\r\n\r\nTo apply\r\nSend a resume to hr@traineo.com ','hr@traineo.com','2008-04-28 21:54:52','2008-04-28 21:54:52'),(7,0,'Boston/Providence','Investment Instruments Corporation','Rentometer System Architect','<a href=\"http://rentometer.com/\">Rentometer.com</a> is looking for an experienced software architect/developer interested in joining a small, very experienced development team working on interesting scalable architecture and data warehousing challenges. Ruby on Rails experience is necessary, but more important is experience designing, specing, and developing systems.\r\n\r\nOur team is distributed and located in the Boston and Providence areas. Work from home with the occasional group meeting in Providence.\r\n\r\nInterested? Contact us at jobs [at] rentometer.com.\r\n\r\n','jobs@rentometer.com','2008-04-29 07:15:10','2008-04-29 07:17:17'),(8,0,'Boston, MA','thoughtbot, inc.','Experienced Ruby on Rails Developers Wanted','We are looking for someone with expert knowledge of Ruby on Rails to join our team of Ruby on Rails developers full-time in either our Boston, MA or New York City office. The ideal individual will have been using Ruby on Rails extensively (probably since before 1.0), have an excellent knowledge of Javascript, HTML, and CSS, and experience in TDD.\r\n\r\nThe competitive salary will depend on experience, and includes full medical benefits.\r\n\r\nThis is a great opportunity to work exclusively with Ruby and Rails at one of the leading Ruby on Rails development shops, and work with a group of excellent and experienced Rails developers.\r\n\r\nOur team works in a relaxed and educational environment. We use the latest web development technologies, frameworks and techniques, and embrace both agile development methodologies and a “getting real” project philosophy. We limit our work weeks to 40 hours, stock the fridge with free drinks, and provide lunch on Fridays. We are always seeking like minded people to join our team.\r\n\r\nIn your communication, describe why you want to work for us, what your past experience is, what your salary requirements are, who your work references are, a link to a portfolio, a bunch of sites you like, a list of hobbies, or anything else you think represents who you are or who you want to be.\r\n','resumes@thoughtbot.com','2008-04-29 08:11:58','2008-04-29 08:11:58'),(9,NULL,'Natick, MA','Prospect Markets','Ruby on Rails Intern (Summer Position)','Developing and testing new and existing application functionality.\r\n\r\nLooking for a sophomore/junior for June through August.\r\n\r\nSeveral of us commute from the Cambridge/Somerville area if transportation is a concern.\r\n\r\n','and@prospectmarkets.com','2008-04-29 16:18:59','2008-04-29 16:18:59'),(10,0,'Needham, MA','FAST, A Microsoft® Subsidiary','Systems Engineer','At least 3 years experience writing large scale production applications for system administration and/or Cisco network groups.\r\nExperience with OpenSource SNMP based monitoring programs (e.g. Nagios / OpenNMS) in production environments\r\nWork with other departments on architectural issues regarding requirements and turning that into business solutions.\r\nExpert competency with Red Hat Linux required with at least 3 years working in a production environment, including Bash (or related UNIX shell) scripting.\r\nExpert ability to install, configure, upgrade, modify, and maintain various Open Source technologies\r\nRuby, Python, java or similar programming language\r\nExperience architecting, defining, writing, testing, and implementing applications into production environments.\r\nAssist in system administrator tasks from time to time as need requires.\r\nDatabase administration knowledge desired\r\nExcellent communication, organization, and time management skills\r\nAbility to multi-task in a dynamic fast paced environment, with minimal supervision\r\n\r\nRequirements:\r\n\r\nEducation, Certification, Training and/or Minimum Qualifications: \r\n\r\nBS in Computer Science or equivalent experience in related technical field\r\nTeam player attitude and strong interpersonal skills. \r\nCarry a beeper to provide 24x7 coverage approximately 1 week per month\r\nMust be able to work independently and be a self-starter.','Nelly.Geifman@fastsearch.com','2008-05-08 11:05:29','2008-05-08 11:06:19');
UNLOCK TABLES;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
CREATE TABLE `projects` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `homepage_url` varchar(255) default NULL,
  `feed_url` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `description` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `projects`
--


/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
LOCK TABLES `projects` WRITE;
INSERT INTO `projects` VALUES (18703980,'recommendable','http://github.com/dancroak/recommendable/tree/master','http://github.com/feeds/dancroak/commits/recommendable/master','2008-04-16 13:30:20','2008-04-29 21:52:34','A Rails plugin for Amazon.com-style item-to-item collaborative filtering.'),(183206821,'ambitious-ultrasphinx','http://github.com/technicalpickles/ambitious-sphinx/tree/master','http://github.com/feeds/technicalpickles/commits/ambitious-sphinx/master','2008-04-16 13:30:20','2008-04-29 21:51:53','An Ambition adapter to Sphinx, a full-text search engine.'),(916386294,'quiet_backtrace','http://github.com/thoughtbot/quietbacktrace/tree/master','http://github.com/feeds/thoughtbot/commits/quietbacktrace/master','2008-04-16 13:30:20','2008-04-29 21:53:23','Quiets the noise in your Test::Unit backtrace.'),(916386295,'spec_factories','http://github.com/dancroak/spec_factories/tree/master','http://github.com/feeds/dancroak/commits/spec_factories/master','2008-04-27 19:19:44','2008-04-29 21:53:06','A generator to create Factories in your RSpec suite.');
UNLOCK TABLES;
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;

--
-- Table structure for table `schema_info`
--

DROP TABLE IF EXISTS `schema_info`;
CREATE TABLE `schema_info` (
  `version` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `schema_info`
--


/*!40000 ALTER TABLE `schema_info` DISABLE KEYS */;
LOCK TABLES `schema_info` WRITE;
INSERT INTO `schema_info` VALUES (9);
UNLOCK TABLES;
/*!40000 ALTER TABLE `schema_info` ENABLE KEYS */;

--
-- Table structure for table `videos`
--

DROP TABLE IF EXISTS `videos`;
CREATE TABLE `videos` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `url` varchar(255) default NULL,
  `embed` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `videos`
--


/*!40000 ALTER TABLE `videos` DISABLE KEYS */;
LOCK TABLES `videos` WRITE;
INSERT INTO `videos` VALUES (1,'Rails Scalability &#187; Jeremy Durham &#187; March 2007','http://video.google.com/videoplay?docid=-3964296373638807434','<embed id=\"VideoPlayback\" style=\"width:400px;height:326px\" flashvars=\"\" src=\"http://video.google.com/googleplayer.swf?docid=-3964296373638807434&hl=en\" type=\"application/x-shockwave-flash\"&gt; </embed>','2008-04-27 23:30:09','2008-04-27 23:42:11'),(3,'Hackety Hack &#187; Brian DeLacey &#187; Eric Mill &#187; May 2007','http://video.google.com/videoplay?docid=-6471035934444708692','<embed id=\"VideoPlayback\" style=\"width:400px;height:326px\" flashvars=\"\" src=\"http://video.google.com/googleplayer.swf?docid=-6471035934444708692&hl=en\" type=\"application/x-shockwave-flash\"&gt; </embed>','2008-04-27 23:32:13','2008-04-27 23:42:53'),(4,'jQuery &#187; John Resig &#187; July 2007','http://video.google.com/videoplay?docid=9098790160532178144','<embed id=\"VideoPlayback\" style=\"width:400px;height:326px\" flashvars=\"\" src=\"http://video.google.com/googleplayer.swf?docid=9098790160532178144&hl=en\" type=\"application/x-shockwave-flash\"&gt; </embed>','2008-04-27 23:35:52','2008-04-27 23:42:28'),(5,'hpricot &#187; Brian DeLacey &#187; March 2007','http://video.google.com/videoplay?docid=8992299117893652604','<embed id=\"VideoPlayback\" style=\"width:400px;height:326px\" flashvars=\"\" src=\"http://video.google.com/googleplayer.swf?docid=8992299117893652604&hl=en\" type=\"application/x-shockwave-flash\"&gt; </embed>','2008-04-27 23:37:48','2008-04-27 23:41:57'),(6,'Per-Object Behavior &#187; David Black &#187; June 2007','http://video.google.com/videoplay?docid=1804558171226068832','<embed id=\"VideoPlayback\" style=\"width:400px;height:326px\" flashvars=\"\" src=\"http://video.google.com/googleplayer.swf?docid=1804558171226068832&hl=en\" type=\"application/x-shockwave-flash\"&gt; </embed>','2008-04-27 23:41:43','2008-04-27 23:41:43'),(7,'ActiveResource » Eric Mill » April 2007','http://video.google.com/videoplay?docid=1403607000328237319','<embed id=\"VideoPlayback\" style=\"width:400px;height:326px\" flashvars=\"\" src=\"http://video.google.com/googleplayer.swf?docid=1403607000328237319&hl=en\" type=\"application/x-shockwave-flash\"&gt; </embed>','2008-04-27 23:44:31','2008-04-27 23:44:46');
UNLOCK TABLES;
/*!40000 ALTER TABLE `videos` ENABLE KEYS */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

