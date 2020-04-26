--SCHEMA
-- User (user_ID, fname, lname, user_name, pwd, email)
-- Profile (user_ID, prof_photo, photo, description)
-- Groups (grp_ID, user_ID, post_ID)
-- Friends (fnd_ID, user_ID, class)
-- Post (post_ID, user_ID text_post, img_post, date, time)
-- Comments (user_ID, date, time)
-- Creators (user_ID, grp_ID)

CREATE TABLE if not EXIST 'User'(
  'user_ID' int(100) NOT NULL,
  'fname' varchar(30) DEFAULT NULL,
  'lname' varchar(30) DEFAULT NULL,
  'fname' varchar(30) DEFAULT NULL,
  'email' varchar(50) DEFAULT NULL,
  'pwd' varchar(30) DEFAULT NULL,
  PRIMARY KEY('user_ID')
 )

 CREATE TABLE if not EXIST 'Profile'(
   'profile_pic' text(20) DEFAULT NULL,
   'photo' text DEFAULT NULL,
   'desc' varchar(50) DEFAULT NULL,
   
 )