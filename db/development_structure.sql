CREATE TABLE "apps" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "homepage_url" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "companies" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255) NOT NULL, "website_url" varchar(255), "created_at" datetime, "updated_at" datetime, "github" varchar(255), "twitter" varchar(255));
CREATE TABLE "entries" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255), "author" varchar(255), "url" varchar(255), "summary" text, "content" text, "published_at" datetime, "categories" text, "checksum" varchar(255), "feed_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "events" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "date" datetime, "description" text, "created_at" datetime, "updated_at" datetime, "location" varchar(255), "lng" float, "lat" float, "title" varchar(255), "deleted_at" datetime, "place_id" integer, "cached_description_html" text(255), "recurring" boolean DEFAULT 't' NOT NULL);
CREATE TABLE "feed_errors" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "error_type" varchar(255), "message" varchar(255), "trace" text, "feed_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "feeds" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "url" varchar(255), "title" varchar(255), "etag" varchar(255), "last_modified_at" time, "feed_url" varchar(255), "stale_at" time, "created_at" datetime, "updated_at" datetime, "feed_owner_id" integer, "feed_owner_type" varchar(255));
CREATE TABLE "jobs" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "location" varchar(255), "organization" varchar(255), "title" varchar(255), "description" text, "email" varchar(255), "created_at" datetime, "updated_at" datetime, "deleted_at" datetime, "cached_description_html" text(255));
CREATE TABLE "presentations" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255), "url" varchar(255), "embed" text, "created_at" datetime, "updated_at" datetime, "deleted_at" datetime, "description" text(255), "user_id" integer, "other_speakers" varchar(255) DEFAULT '', "location" varchar(255), "cached_description_html" text, "date_of" datetime);
CREATE TABLE "projects" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "github_url" varchar(255), "created_at" datetime, "updated_at" datetime, "description" text, "watchers" integer DEFAULT 0 NOT NULL, "user_id" integer);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "tweets" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "text" varchar(255), "twitter_id" integer(8), "user_id" integer, "created_at" datetime, "updated_at" datetime, "tweeted_at" datetime);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar(255), "encrypted_password" varchar(128), "salt" varchar(128), "token" varchar(128), "token_expires_at" datetime, "email_confirmed" boolean DEFAULT 'f' NOT NULL, "twitter" varchar(255), "created_at" datetime, "updated_at" datetime, "github" varchar(255), "company_id" integer, "name" varchar(255));
CREATE UNIQUE INDEX "index_companies_on_name" ON "companies" ("name");
CREATE INDEX "index_presentations_on_user_id" ON "presentations" ("user_id");
CREATE INDEX "index_projects_on_user_id" ON "projects" ("user_id");
CREATE INDEX "index_tweets_on_user_id" ON "tweets" ("user_id");
CREATE INDEX "index_users_on_company_id" ON "users" ("company_id");
CREATE INDEX "index_users_on_email" ON "users" ("email");
CREATE INDEX "index_users_on_id_and_token" ON "users" ("id", "token");
CREATE INDEX "index_users_on_token" ON "users" ("token");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('1');

INSERT INTO schema_migrations (version) VALUES ('2');

INSERT INTO schema_migrations (version) VALUES ('3');

INSERT INTO schema_migrations (version) VALUES ('4');

INSERT INTO schema_migrations (version) VALUES ('5');

INSERT INTO schema_migrations (version) VALUES ('6');

INSERT INTO schema_migrations (version) VALUES ('7');

INSERT INTO schema_migrations (version) VALUES ('8');

INSERT INTO schema_migrations (version) VALUES ('9');

INSERT INTO schema_migrations (version) VALUES ('10');

INSERT INTO schema_migrations (version) VALUES ('11');

INSERT INTO schema_migrations (version) VALUES ('12');

INSERT INTO schema_migrations (version) VALUES ('13');

INSERT INTO schema_migrations (version) VALUES ('14');

INSERT INTO schema_migrations (version) VALUES ('15');

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

INSERT INTO schema_migrations (version) VALUES ('20090520011312');

INSERT INTO schema_migrations (version) VALUES ('20090520024906');

INSERT INTO schema_migrations (version) VALUES ('20090521025634');

INSERT INTO schema_migrations (version) VALUES ('20090521033359');

INSERT INTO schema_migrations (version) VALUES ('20090521034645');

INSERT INTO schema_migrations (version) VALUES ('20090521070534');

INSERT INTO schema_migrations (version) VALUES ('20090521075701');

INSERT INTO schema_migrations (version) VALUES ('20090521221115');

INSERT INTO schema_migrations (version) VALUES ('20090521222809');

INSERT INTO schema_migrations (version) VALUES ('20090522041237');

INSERT INTO schema_migrations (version) VALUES ('20090526034754');

INSERT INTO schema_migrations (version) VALUES ('20090526040939');

INSERT INTO schema_migrations (version) VALUES ('20090526231624');

INSERT INTO schema_migrations (version) VALUES ('20090527021951');

INSERT INTO schema_migrations (version) VALUES ('20090527024902');

INSERT INTO schema_migrations (version) VALUES ('20090603002159');

INSERT INTO schema_migrations (version) VALUES ('20090729063311');

INSERT INTO schema_migrations (version) VALUES ('20090730184621');