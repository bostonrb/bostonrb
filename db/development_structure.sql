CREATE TABLE `companies` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `website_url` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_companies_on_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `events` (
  `id` int(11) NOT NULL auto_increment,
  `date` datetime default NULL,
  `description` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `location` varchar(255) default NULL,
  `lng` float default NULL,
  `lat` float default NULL,
  `title` varchar(255) default NULL,
  `deleted_at` datetime default NULL,
  `place_id` int(11) default NULL,
  `cached_description_html` text,
  `recurring` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `jobs` (
  `id` int(11) NOT NULL auto_increment,
  `location` varchar(255) default NULL,
  `organization` varchar(255) default NULL,
  `title` varchar(255) default NULL,
  `description` text,
  `email` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `deleted_at` datetime default NULL,
  `cached_description_html` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `presentations` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `url` varchar(255) default NULL,
  `embed` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `presenter` varchar(255) default NULL,
  `source` varchar(255) default NULL,
  `deleted_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `projects` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `homepage_url` varchar(255) default NULL,
  `feed_url` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `description` text,
  `deleted_at` datetime default NULL,
  `cached_description_html` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `tweets` (
  `id` int(11) NOT NULL auto_increment,
  `text` varchar(255) default NULL,
  `twitter_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `tweeted_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_tweets_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `email` varchar(255) default NULL,
  `encrypted_password` varchar(128) default NULL,
  `salt` varchar(128) default NULL,
  `token` varchar(128) default NULL,
  `token_expires_at` datetime default NULL,
  `email_confirmed` tinyint(1) NOT NULL default '0',
  `twitter` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_users_on_id_and_token` (`id`,`token`),
  KEY `index_users_on_email` (`email`),
  KEY `index_users_on_token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO schema_migrations (version) VALUES ('1');

INSERT INTO schema_migrations (version) VALUES ('10');

INSERT INTO schema_migrations (version) VALUES ('11');

INSERT INTO schema_migrations (version) VALUES ('12');

INSERT INTO schema_migrations (version) VALUES ('13');

INSERT INTO schema_migrations (version) VALUES ('14');

INSERT INTO schema_migrations (version) VALUES ('15');

INSERT INTO schema_migrations (version) VALUES ('2');

INSERT INTO schema_migrations (version) VALUES ('20080802012029');

INSERT INTO schema_migrations (version) VALUES ('20080924045039');

INSERT INTO schema_migrations (version) VALUES ('20090502210712');

INSERT INTO schema_migrations (version) VALUES ('20090503035521');

INSERT INTO schema_migrations (version) VALUES ('20090503052550');

INSERT INTO schema_migrations (version) VALUES ('20090503203924');

INSERT INTO schema_migrations (version) VALUES ('20090503210648');

INSERT INTO schema_migrations (version) VALUES ('20090516231501');

INSERT INTO schema_migrations (version) VALUES ('20090518042333');

INSERT INTO schema_migrations (version) VALUES ('20090518055807');

INSERT INTO schema_migrations (version) VALUES ('20090518063607');

INSERT INTO schema_migrations (version) VALUES ('20090518234616');

INSERT INTO schema_migrations (version) VALUES ('20090520010446');

INSERT INTO schema_migrations (version) VALUES ('3');

INSERT INTO schema_migrations (version) VALUES ('4');

INSERT INTO schema_migrations (version) VALUES ('5');

INSERT INTO schema_migrations (version) VALUES ('6');

INSERT INTO schema_migrations (version) VALUES ('7');

INSERT INTO schema_migrations (version) VALUES ('8');

INSERT INTO schema_migrations (version) VALUES ('9');