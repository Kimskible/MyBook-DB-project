--SCHEMA
-- User (user_ID, fname, lname, user_name, pwd, email)
CREATE TABLE IF NOT EXISTs 'User'(
  `user_id` int(10) NOT NULL,
  `fname` varchar(30) DEFAULT NULL,
  `lname` varchar(30) DEFAULT NULL,
  `fname` varchar(30) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `pwd` varchar(30) DEFAULT NULL,
  PRIMARY KEY(`user_ID`)
 );

-- Profile (user_ID, prof_photo, photo, description)
 CREATE TABLE IF NOT EXIST `Profile`(
   `profile_pic` text(20) DEFAULT NULL,
   `photo` text DEFAULT NULL,
   `desc` varchar(50) DEFAULT NULL, 
   FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE CASCADE,

 );
 -- Post (post_ID, user_ID text_post, img_post, date, time)
CREATE TABLE IF NOT EXISTS `Post`(
  `post_id ` int(10) NOT NULL,
  `text_post` varchar(100) DEFAULT NULL,
  `img_post` text() DEFAULT NULL,
  `post_date` DATE DEFAULT NULL,
  `Post_time` TIME DEFAULT NULL,
  PRIMARY KEY (`post_id`),
  FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE CASCADE,

);

 -- Groups (grp_ID, user_ID, post_ID)
CREATE TABLE IF NOT EXISTS `Groups`(
  `grp_id` int(100) NOT NULL,
  FOREIGN KEY (`user_id`) REFERENCES `User`(`user_id`) ON DELETE CASCADE,
  FOREIGN KEY (`post_id`) REFERENCES `Post`(`post_id`) ON DELETE CASCADE,
 );

 -- Friends (fnd_ID, user_ID, class)
CREATE TABLE IF NOT EXISTS `Friends`(
  `fnd_id` int(10) NOT NULL,
  `class` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`fnd_id`),
  FOREIGN KEY (`user_id`) REFERENCES `User`(`user_id`) ON DELETE CASCADE,
);

-- Comments (user_ID, date, time)
CREATE TABLE IF NOT EXISTS `Comments`(
 `cmt_date` DATE DEFAULT NULL,
 `cmt_time` TIME DEFAULT NULL,
 FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE CASCADE,
);


-- Creators (user_ID, grp_ID)
CREATE TABLE IF NOT EXISTS `Creators`(
  FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE CASCADE,
  FOREIGN KEY (`grp_id`) REFERENCES `Group` (`grp_id`) ON DELETE CASCADE,

);
