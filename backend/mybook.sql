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


-- ACCEPT FRIEND REQUEST - Accept ID and Update Friends Table
DELIMITER //;
	CREATE Procedure AddFriend(IN newFriendID int(10),newUserID int(10)) 
	BEGIN Insert into Friends values(newFriendID,newUserID,null)
	END //;
DELIMITER ;

-- REMOVE FRIEND
DELIMITER //;
	CREATE Procedure RemoveFriend(IN friendID int(10)) 
	BEGIN 
	Delete from Friends where fnd_ID = friendID;
	END //;
DELIMITER ;



--ADD POST
DELIMITER //;
	CREATE Procedure NewPost(IN postID int(10),userID int(10),textPost varchar(50),imgPost text) 
	BEGIN 
	Insert into Post values(postID,userID,textPost,imgPost,CONVERT (date, GETDATE()),CONVERT (time, CURRENT_TIMESTAMP));
	END //;
DELIMITER ;

--REMOVE POST
	DELIMITER //;
	CREATE Procedure DeletePost(IN postID, int(10)) 
	BEGIN Delete from Post where post_id = postID;
	END //;
DELIMITER ;

--ADD COMMENT this procedure assumes that the comment table would have a comment ID attribute but it does not currently have it
DELIMITER //;
	CREATE Procedure AddComment(IN commentID, int(10)) 
	BEGIN 
	Insert into Comments values(newFriendID,newUserID,null);
	END //;
DELIMITER ;

--DELETE COMMENT this procedure assumes that the comment table would have a comment ID attribute but it does not currently have it
DELIMITER //;
	CREATE Procedure DeleteComment(IN commentID, int(10)) 
	BEGIN 
	Delete from Comments where cmt_ID = commentID;
	END //;
DELIMITER ;
  
  
--CREATE NEW GROUP
DELIMITER //;
	CREATE Procedure AddGrp(IN groupID (10), memberID (10)) 
	BEGIN 
	Insert into Groups values(groupID,memberID,null);
	END //;
DELIMITER ;


 --DELETE GROUP
DELIMITER //;
	CREATE Procedure DeleteGrp(IN groupID (10)) 
	BEGIN 
	Delete from Groups where grp_id=groupID;
	END //;
DELIMITER ;
  
--ADD USER TO GROUP
DELIMITER //;
	CREATE Procedure AddGrpMember(IN groupID int(10),memberID int(10)) 
	BEGIN 
	Insert into Groups values(groupID,memberID,null);
	END //;
DELIMITER ;

--REMOVE USER FROM GROUP
DELIMITER //;
	CREATE Procedure RemoveGrpMember(IN memberID int(10)) 
	BEGIN 
	Delete from Groups where user_id = commentID;
	END //;
DELIMITER ; 
 
--ADD POST TO GROUP

DELIMITER //;
	CREATE Procedure AddGrpPost(IN groupID(10), userID(10), postID (10))
	BEGIN 
	Insert into Groups values(groupID,userID,postID);
	END //;
DELIMITER ; 

--REMOVE POST FROM GROUP
DELIMITER //;
	CREATE Procedure RemoveGrpPost(IN groupID(10), postID (10)) 
	BEGIN 
	Delete from Groups where (grp_id=groupID) and (post_id = postID);
	END //;
DELIMITER ; 

