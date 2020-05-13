use mybook; 

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
   `profile_pic` TEXT DEFAULT NULL,
   `dob` DATE,
   `bio` TEXT, 
   `gender` VARCHAR(2) DEFAULT NULL,
   FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE CASCADE
 );

CREATE TABLE IF NOT EXISTS `Post`(
  `post_id` int(10) NOT NULL auto_increment,
  `user_id` int(10) NOT NULL,
  `text_post` varchar(50) DEFAULT NULL,
  `img_post` text,
  `post_date` DATE,
  `post_time` TIME,
  PRIMARY KEY (`post_id`),
  FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `Groups`(
  `grp_name` varchar(25) NOT NULL,
  `members_id` int not null,
  FOREIGN KEY (`members_id`) REFERENCES `GroupMembers`(`members_id`) ON DELETE CASCADE
 );
 
 CREATE TABLE IF NOT EXISTS `GroupMembers`(
  `groupmember_id` int not null auto_increment,
  `members_id` int not null,
  `user_id` int not null,
  PRIMARY KEY (`groupmember_id`),
  FOREIGN KEY (`user_id`) REFERENCES `User`(`user_id`) ON DELETE CASCADE
 );

CREATE TABLE IF NOT EXISTS `Friends`(
  `user_id` int(10) NOT NULL,
  `user_id2` int NOT NULL,
  `fnd_id` int(10) NOT NULL auto_increment,
  PRIMARY KEY (`fnd_id`),
  FOREIGN KEY (`user_id`) REFERENCES `User`(`user_id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `Relatives`(
  `rel_id` int(10) NOT NULL auto_increment,
  `user_id` int(10) NOT NULL,
   `user_id2` int NOT NULL,
  PRIMARY KEY (`rel_id`),
  FOREIGN KEY (`user_id`) REFERENCES `User`(`user_id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `Work`(
  `work_id` int(10) NOT NULL auto_increment,
  `user_id` int(10) NOT NULL,
  `user_id2` int NOT NULL,
  PRIMARY KEY (`work_id`),
  FOREIGN KEY (`user_id`) REFERENCES `User`(`user_id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `School`(
  `sch_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `user_id2` int NOT NULL,
  PRIMARY KEY (`sch_id`),
  FOREIGN KEY (`user_id`) REFERENCES `User`(`user_id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `Comments`(
  `comt_id` int(10) NOT NULL auto_increment,
  `user_id` int(10) NOT NULL,
  `cmt_date` DATE,
  `cmt_time` TIME,
  PRIMARY KEY(`comt_id`),
  FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `Creators`(
  `crt_id` int(10) NOT NULL auto_increment,
  `user_id` int(10) NOT NULL,
  `grp_id` int(10) NOT NULL,
  PRIMARY KEY (`crt_id`),
  FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE CASCADE,
  FOREIGN KEY (`grp_id`) REFERENCES `Group` (`grp_id`) ON DELETE CASCADE
);


/*Stored Procedures*/

DELIMITER //

/* Updating Profile*/
CREATE PROCEDURE `UpdateProfile`(
    IN id int,
    IN firstN VARCHAR(30),
    IN lastN VARCHAR(30),
    IN dob_ DATE,
    IN biography TEXT,
    IN gen VARCHAR(2),
    IN pro_pic TEXT
)
  BEGIN
    UPDATE `Profile`
    SET
      dob = dob_,
      bio = biography,
      gender = gen,
      profile_pic = pro_pic
      WHERE user_id = id;
      UPDATE `user`
      SET 
      fname = FirstN,
      lname = LastN
      WHERE user_id = id;
  END //
  

/*ACCEPT FRIEND REQUEST - Accept ID and Update Friends Table*/
	CREATE Procedure AddFriend(IN newFriendID int,newUserID int)
    BEGIN
		Insert into Friends values(newFriendID,newUserID);
	END //

 /*REMOVE FRIEND*/
CREATE Procedure RemoveFriend(IN friendID int)
	BEGIN 
		Delete from Friends where fnd_id = friendID;
	END //

/*ADD POST*/
CREATE Procedure NewPost(userID int,textPost varchar(50), imgPost text) 
	BEGIN 
		Insert into Post(user_id, text_post, img_post, post_date, post_time) values (userID,textPost,imgPost, CURDATE(), CURTIME());
	END //
    
/*REMOVE POST*/
CREATE Procedure DeletePost(IN postID int) 
	BEGIN
		Delete from Post where post_id = postID;
	END //

/*View Friends list*/
Create Procedure FriendList(IN userID int)
		BEGIN
			select friends.user_id2, user.fname, user.lname from `friends` JOIN `user` 
      where friends.user_id = userID and friends.user_id2 = user.user_id;
		END //


DELIMITER ;