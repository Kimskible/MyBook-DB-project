CREATE TABLE IF NOT EXISTS `User`(
  `user_id` int(10) NOT NULL AUTO_INCREMENT,
  `fname` varchar(30) DEFAULT NULL,
  `lname` varchar(30) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `pwd` varchar(30) DEFAULT NULL,
  `datejoined` DATE NOT NULL,
  PRIMARY KEY(`user_id`)
 );  

CREATE TABLE IF NOT EXISTS `Profile` (
   `user_id` int(10) NOT NULL,
   `profile_pic` text(20) DEFAULT NULL,
   `dob` DATE,
   `bio` TEXT, 
   `gender` VARCHAR(20) DEFAULT NULL,
   FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE CASCADE
 );

CREATE TABLE IF NOT EXISTS `Post`(
  `post_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `text_post` varchar(50) DEFAULT NULL,
  `img_post` text,
  `post_date` DATE,
  `post_time` TIME,
  PRIMARY KEY (`post_id`),
  FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE CASCADE

);

CREATE TABLE IF NOT EXISTS `Groups`(
  `grp_id` int(10) NOT NULL, 
  `user_id` int(10) NOT NULL,
  `post_id` int(10) NOT NULL,
  `rel_id` int(10) NOT NULL,
  `sch_id` int(10) NOT NULL,
  `work_id` int(10) NOT NULL,
  `grptype` VARCHAR(20) DEFAULT NULL,
  PRIMARY KEY (`grp_id`),
  FOREIGN KEY (`user_id`) REFERENCES `User`(`user_id`) ON DELETE CASCADE,
  FOREIGN KEY (`post_id`) REFERENCES `Post`(`post_id`) ON DELETE CASCADE,
  FOREIGN KEY (`rel_id`) REFERENCES `Relatives`(`rel_id`) ON DELETE CASCADE,
  FOREIGN KEY (`work_id`) REFERENCES `Work`(`work_id`) ON DELETE CASCADE,
  FOREIGN KEY (`sch_id`) REFERENCES `School`(`sch_id`) ON DELETE CASCADE
 );

CREATE TABLE IF NOT EXISTS `Friends`(
  `user_id` int(10) NOT NULL,
  `fnd_id` int(10) NOT NULL,
  `class` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`fnd_id`),
  FOREIGN KEY (`user_id`) REFERENCES `User`(`user_id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `Relatives`(
  `rel_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `grp_id` int(10) NOT NULL, 
  PRIMARY KEY (`rel_id`),
  FOREIGN KEY (`user_id`) REFERENCES `User`(`user_id`) ON DELETE CASCADE,
  FOREIGN KEY (`grp_id`) REFERENCES `Groups`(`grp_id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `Work`(
  `work_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `grp_id` int(10) NOT NULL, 
  PRIMARY KEY (`work_id`),
  FOREIGN KEY (`user_id`) REFERENCES `User`(`user_id`) ON DELETE CASCADE,
  FOREIGN KEY (`grp_id`) REFERENCES `Groups`(`grp_id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `School`(
  `sch_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `grp_id` int(10) NOT NULL, 
  PRIMARY KEY (`sch_id`),
  FOREIGN KEY (`user_id`) REFERENCES `User`(`user_id`) ON DELETE CASCADE,
  FOREIGN KEY (`grp_id`) REFERENCES `Groups`(`grp_id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `Comments`(
  `user_id` int(10) NOT NULL,
  `cmt_date` DATE,
  `cmt_time` TIME,
 FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `Creators`(
  `user_id` int(10) NOT NULL,
  `grp_id` int(10) NOT NULL,
  FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE CASCADE,
  FOREIGN KEY (`grp_id`) REFERENCES `Group` (`grp_id`) ON DELETE CASCADE
);


/*ALTER TABLE `User` ADD `datejoined` DATE NOT NULL;*/



