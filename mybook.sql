--Group Assignment
-- User (user_ID, fname, lname, user_name, pwd, email)
CREATE TABLE IF NOT EXISTS `User`(
  `user_id` int(10) NOT NULL,
  `fname` varchar(30) DEFAULT NULL,
  `lname` varchar(30) DEFAULT NULL,
  `username` varchar(30) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `pwd` varchar(30) DEFAULT NULL,
  PRIMARY KEY(`user_ID`)
 );

-- Profile (user_ID, prof_photo, photo, description)
CREATE TABLE IF NOT EXISTS `Profile` (
   `user_id` int(10) NOT NULL,
   `profile_pic` text(20) DEFAULT NULL,
   `photo` text DEFAULT NULL,
   `desc` varchar(50) DEFAULT NULL, 
   FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE CASCADE
 );

 -- Post (post_ID, user_ID text_post, img_post, date, time)
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

--  -- Groups (grp_ID, user_ID, post_ID)
CREATE TABLE IF NOT EXISTS `Groups`(
  `grp_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `post_id` int(10) NOT NULL,
  PRIMARY KEY (`grp_id`),
  FOREIGN KEY (`user_id`) REFERENCES `User`(`user_id`) ON DELETE CASCADE,
  FOREIGN KEY (`post_id`) REFERENCES `Post`(`post_id`) ON DELETE CASCADE
 );

--  -- Friends (fnd_ID, user_ID, class)
CREATE TABLE IF NOT EXISTS `Friends`(
  `user_id` int(10) NOT NULL,
  `fnd_id` int(10) NOT NULL,
  `class` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`fnd_id`),
  FOREIGN KEY (`user_id`) REFERENCES `User`(`user_id`) ON DELETE CASCADE
);

-- -- Comments (user_ID, date, time)
CREATE TABLE IF NOT EXISTS `Comments`(
  `user_id` int(10) NOT NULL,
  `cmt_date` DATE,
  `cmt_time` TIME,
 FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE CASCADE
);

-- -- Creators (user_ID, grp_ID)
CREATE TABLE IF NOT EXISTS `Creators`(
  `user_id` int(10) NOT NULL,
  `grp_id` int(10) NOT NULL,
  FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE CASCADE,
  FOREIGN KEY (`grp_id`) REFERENCES `Group` (`grp_id`) ON DELETE CASCADE
);
