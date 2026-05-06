/*
SQLyog Ultimate v10.42 
MySQL - 8.0.45 : Database - labex
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`labex` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

/*Table structure for table `t_assistant` */

DROP TABLE IF EXISTS `t_assistant`;

CREATE TABLE `t_assistant` (
  `assistant_account` varchar(255) NOT NULL,
  `assistant_password` varchar(255) DEFAULT NULL,
  `assistant_student_no` varchar(8) DEFAULT NULL,
  `assistant_student_name` varchar(255) DEFAULT NULL,
  `assistant_student_clazz` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

/*Data for the table `t_assistant` */

/*Table structure for table `t_clazz` */

DROP TABLE IF EXISTS `t_clazz`;

CREATE TABLE `t_clazz` (
  `no` varchar(6) NOT NULL,
  `memo` text,
  `state` int DEFAULT '0',
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

/*Data for the table `t_clazz` */

insert  into `t_clazz`(`no`,`memo`,`state`) values ('182011','胡',1),('182012','安',1),('232013','于峰老师',0),('992011','联系人',1);

/*Table structure for table `t_ex3` */

DROP TABLE IF EXISTS `t_ex3`;

CREATE TABLE `t_ex3` (
  `id` int NOT NULL AUTO_INCREMENT,
  `no` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `extype` int DEFAULT NULL,
  `type` int DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `begin_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

/*Data for the table `t_ex3` */

insert  into `t_ex3`(`id`,`no`,`name`,`extype`,`type`,`description`,`begin_time`,`end_time`) values (1,1,'HTML练习',1,2,'HTML','2016-07-04 00:00:00','2016-09-13 21:16:27');

/*Table structure for table `t_ex3_item` */

DROP TABLE IF EXISTS `t_ex3_item`;

CREATE TABLE `t_ex3_item` (
  `excercise_item_id` int NOT NULL AUTO_INCREMENT,
  `excercise_id` int NOT NULL,
  `question` varchar(255) DEFAULT NULL,
  `options` varchar(255) DEFAULT NULL,
  `answer` varchar(255) DEFAULT NULL,
  `type` int DEFAULT NULL,
  PRIMARY KEY (`excercise_item_id`),
  KEY `fk_excercise_id` (`excercise_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

/*Data for the table `t_ex3_item` */

insert  into `t_ex3_item`(`excercise_item_id`,`excercise_id`,`question`,`options`,`answer`,`type`) values (1,1,'下面哪些标签不是超链接?','A,BR,TR,IMG','BCD',2),(2,1,'图片用什么标签?','A,BR,TR,IMG','D',1);

/*Table structure for table `t_exam` */

DROP TABLE IF EXISTS `t_exam`;

CREATE TABLE `t_exam` (
  `id` int NOT NULL,
  `description` varchar(30) NOT NULL,
  `duration` int DEFAULT NULL COMMENT '即使单位-分',
  `time` datetime DEFAULT NULL,
  `flag` bit(1) DEFAULT NULL COMMENT '考试开放标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

/*Data for the table `t_exam` */

/*Table structure for table `t_experiment` */

DROP TABLE IF EXISTS `t_experiment`;

CREATE TABLE `t_experiment` (
  `experiment_id` int NOT NULL AUTO_INCREMENT,
  `experiment_no` int NOT NULL,
  `experiment_name` varchar(30) NOT NULL,
  `experiment_type` int DEFAULT NULL,
  `instruction_type` varchar(10) DEFAULT NULL,
  `experiment_requirement` text,
  `experiment_content` text,
  `state` int DEFAULT NULL,
  PRIMARY KEY (`experiment_id`),
  KEY `idx_experiment_no` (`experiment_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb3;

/*Data for the table `t_experiment` */

/*Table structure for table `t_experiment_item` */

DROP TABLE IF EXISTS `t_experiment_item`;

CREATE TABLE `t_experiment_item` (
  `experiment_item_id` int NOT NULL AUTO_INCREMENT,
  `experiment_item_no` int NOT NULL,
  `experiment_item_name` varchar(100) NOT NULL,
  `experiment_item_type` int NOT NULL,
  `experiment_item_content` text,
  `experiment_id` int NOT NULL,
  `experiment_item_answer` varchar(255) DEFAULT NULL,
  `experiment_item_score` tinyint DEFAULT NULL,
  `state` int DEFAULT NULL,
  PRIMARY KEY (`experiment_item_id`),
  KEY `fk_experiment_id` (`experiment_id`),
  KEY `idx_experiment_item_no` (`experiment_item_no`) USING BTREE,
  CONSTRAINT `fk_experiment_id` FOREIGN KEY (`experiment_id`) REFERENCES `t_experiment` (`experiment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb3;

/*Data for the table `t_experiment_item` */

/*Table structure for table `t_lecture` */

DROP TABLE IF EXISTS `t_lecture`;

CREATE TABLE `t_lecture` (
  `lecture_id` int NOT NULL AUTO_INCREMENT,
  `lecture_name` varchar(50) DEFAULT NULL,
  `lecture_type` int DEFAULT NULL,
  `lecture_filetype` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`lecture_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

/*Data for the table `t_lecture` */

/*Table structure for table `t_paper` */

DROP TABLE IF EXISTS `t_paper`;

CREATE TABLE `t_paper` (
  `id` int NOT NULL,
  `no` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

/*Data for the table `t_paper` */

/*Table structure for table `t_paper_question` */

DROP TABLE IF EXISTS `t_paper_question`;

CREATE TABLE `t_paper_question` (
  `id` int NOT NULL,
  `paper_id` int DEFAULT NULL,
  `question_id` int DEFAULT NULL,
  `score` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

/*Data for the table `t_paper_question` */

/*Table structure for table `t_question` */

DROP TABLE IF EXISTS `t_question`;

CREATE TABLE `t_question` (
  `id` int NOT NULL,
  `question` varchar(255) DEFAULT NULL,
  `answer` varchar(255) DEFAULT NULL,
  `type` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

/*Data for the table `t_question` */

/*Table structure for table `t_question_type` */

DROP TABLE IF EXISTS `t_question_type`;

CREATE TABLE `t_question_type` (
  `type_id` int NOT NULL,
  `type_name` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

/*Data for the table `t_question_type` */

insert  into `t_question_type`(`type_id`,`type_name`) values (1,'填空'),(2,'单选'),(3,'多选'),(4,'判断'),(5,'简答'),(6,'编程'),(7,'综合');

/*Table structure for table `t_score` */

DROP TABLE IF EXISTS `t_score`;

CREATE TABLE `t_score` (
  `score_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `experiment_id` int DEFAULT NULL,
  `score` int DEFAULT NULL,
  PRIMARY KEY (`score_id`),
  KEY `fk_score_student` (`student_id`),
  KEY `fk_score_experiment` (`experiment_id`),
  CONSTRAINT `fk_score_experiment` FOREIGN KEY (`experiment_id`) REFERENCES `t_experiment` (`experiment_id`),
  CONSTRAINT `fk_score_student` FOREIGN KEY (`student_id`) REFERENCES `t_student` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

/*Data for the table `t_score` */

/*Table structure for table `t_student` */

DROP TABLE IF EXISTS `t_student`;

CREATE TABLE `t_student` (
  `student_id` int NOT NULL AUTO_INCREMENT,
  `student_no` varchar(8) NOT NULL,
  `student_name` varchar(20) NOT NULL,
  `student_password` char(32) NOT NULL,
  `clazz_no` varchar(6) NOT NULL,
  `memo` text,
  `state` int(10) unsigned zerofill DEFAULT NULL,
  `error` int(10) unsigned zerofill DEFAULT NULL,
  `ip` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  UNIQUE KEY `idx_student_no` (`student_no`) USING BTREE,
  KEY `fk_clazz_no` (`clazz_no`),
  CONSTRAINT `fk_clazz_no` FOREIGN KEY (`clazz_no`) REFERENCES `t_clazz` (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=2227 DEFAULT CHARSET=utf8mb3;

/*Data for the table `t_student` */

insert  into `t_student`(`student_id`,`student_no`,`student_name`,`student_password`,`clazz_no`,`memo`,`state`,`error`,`ip`) values (2226,'23201335','余飞杨','c9668e0f75ce49ebaf7813f903076e5f','232013','很帅气',NULL,NULL,NULL);

/*Table structure for table `t_student_answer` */

DROP TABLE IF EXISTS `t_student_answer`;

CREATE TABLE `t_student_answer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `item_id` int DEFAULT NULL,
  `fill_no` int DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `content_hash` char(32) DEFAULT NULL,
  `count` int DEFAULT NULL,
  `is_correct` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_answer_pk` (`item_id`,`fill_no`,`content_hash`) USING BTREE,
  CONSTRAINT `fk_answer_item_id` FOREIGN KEY (`item_id`) REFERENCES `t_experiment_item` (`experiment_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11811 DEFAULT CHARSET=utf8mb3;

/*Data for the table `t_student_answer` */

/*Table structure for table `t_student_excercise` */

DROP TABLE IF EXISTS `t_student_excercise`;

CREATE TABLE `t_student_excercise` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `item_id` int DEFAULT NULL,
  `student_id` int DEFAULT NULL,
  `answer` varchar(30) DEFAULT NULL,
  `content` text,
  `score` int DEFAULT NULL,
  `fill_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_excercise_item_id` (`item_id`),
  KEY `fk_student_excercise_id` (`student_id`),
  CONSTRAINT `fk_excercise_item_id` FOREIGN KEY (`item_id`) REFERENCES `t_ex3_item` (`excercise_item_id`),
  CONSTRAINT `fk_student_excercise_id` FOREIGN KEY (`student_id`) REFERENCES `t_student` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

/*Data for the table `t_student_excercise` */

/*Table structure for table `t_student_item` */

DROP TABLE IF EXISTS `t_student_item`;

CREATE TABLE `t_student_item` (
  `student_item_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `item_id` int NOT NULL,
  `content` text NOT NULL,
  `score` tinyint DEFAULT NULL,
  `fill_time` datetime NOT NULL,
  `score_flag` int DEFAULT NULL,
  PRIMARY KEY (`student_item_id`),
  UNIQUE KEY `idx_student_item` (`student_id`,`item_id`) USING BTREE,
  KEY `fk_item_id` (`item_id`),
  CONSTRAINT `fk_item_id` FOREIGN KEY (`item_id`) REFERENCES `t_experiment_item` (`experiment_item_id`),
  CONSTRAINT `fk_student_id` FOREIGN KEY (`student_id`) REFERENCES `t_student` (`student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25112 DEFAULT CHARSET=utf8mb3;

/*Data for the table `t_student_item` */

/*Table structure for table `t_student_item_log` */

DROP TABLE IF EXISTS `t_student_item_log`;

CREATE TABLE `t_student_item_log` (
  `log_id` bigint NOT NULL AUTO_INCREMENT,
  `student_item` int DEFAULT NULL,
  `content` text,
  `fill_time` datetime DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  KEY `fk_student_item` (`student_item`,`fill_time`) USING BTREE,
  CONSTRAINT `fk_student_item` FOREIGN KEY (`student_item`) REFERENCES `t_student_item` (`student_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=136670 DEFAULT CHARSET=utf8mb3;

/*Data for the table `t_student_item_log` */

/*Table structure for table `t_student_log` */

DROP TABLE IF EXISTS `t_student_log`;

CREATE TABLE `t_student_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account` varchar(20) DEFAULT NULL,
  `type` int DEFAULT NULL,
  `info` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `ip` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_time` (`time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=352452 DEFAULT CHARSET=utf8mb3;

/*Data for the table `t_student_log` */

/*Table structure for table `t_student_question` */

DROP TABLE IF EXISTS `t_student_question`;

CREATE TABLE `t_student_question` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `question_id` int DEFAULT NULL,
  `answer` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_sq` (`student_id`,`question_id`) USING BTREE,
  KEY `fk_question` (`question_id`),
  CONSTRAINT `fk_question` FOREIGN KEY (`question_id`) REFERENCES `t_question` (`id`),
  CONSTRAINT `fk_student` FOREIGN KEY (`student_id`) REFERENCES `t_student` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

/*Data for the table `t_student_question` */

/*Table structure for table `t_sys_config` */

DROP TABLE IF EXISTS `t_sys_config`;

CREATE TABLE `t_sys_config` (
  `param` varchar(20) NOT NULL,
  `value` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`param`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

/*Data for the table `t_sys_config` */

/*Table structure for table `t_sys_log` */

DROP TABLE IF EXISTS `t_sys_log`;

CREATE TABLE `t_sys_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account` varchar(20) DEFAULT NULL,
  `type` int DEFAULT NULL,
  `info` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_time` (`time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=231236 DEFAULT CHARSET=utf8mb3;

/*Data for the table `t_sys_log` */

insert  into `t_sys_log`(`id`,`account`,`type`,`info`,`time`,`ip`) values (231213,NULL,2,'登录失败','2021-06-23 22:51:57','0:0:0:0:0:0:0:1'),(231214,'admin',1,'登录成功','2021-06-23 22:53:05','0:0:0:0:0:0:0:1'),(231215,'admin',1,'登录成功','2021-06-23 23:47:05','0:0:0:0:0:0:0:1'),(231216,'admin',2,'登录失败','2021-06-23 23:47:33','0:0:0:0:0:0:0:1'),(231217,'admin',1,'登录成功','2021-06-23 23:47:43','0:0:0:0:0:0:0:1'),(231218,'admin',1,'登录成功','2021-06-24 00:04:07','0:0:0:0:0:0:0:1'),(231219,'admin',1,'登录成功','2021-06-24 00:20:39','0:0:0:0:0:0:0:1'),(231220,'admin',1,'登录成功','2021-06-24 00:22:09','0:0:0:0:0:0:0:1'),(231221,'admin',1,'登录成功','2021-06-24 00:30:44','0:0:0:0:0:0:0:1'),(231222,'admin',1,'登录成功','2021-06-24 00:44:04','0:0:0:0:0:0:0:1'),(231223,'admin',1,'登录成功','2026-03-24 18:13:11','0:0:0:0:0:0:0:1'),(231224,'admin',1,'登录成功','2026-03-24 18:13:51','0:0:0:0:0:0:0:1'),(231225,'admin',1,'登录成功','2026-03-24 18:13:53','0:0:0:0:0:0:0:1'),(231226,'admin',1,'登录成功','2026-03-24 18:15:34','0:0:0:0:0:0:0:1'),(231227,'admin',3,'注销成功','2026-03-24 18:15:59','0:0:0:0:0:0:0:1'),(231228,'admin',2,'登录失败','2026-03-24 18:16:04','0:0:0:0:0:0:0:1'),(231229,'admin',1,'登录成功','2026-03-24 18:16:09','0:0:0:0:0:0:0:1'),(231230,'admin',1,'登录成功','2026-03-24 18:31:10','0:0:0:0:0:0:0:1'),(231231,'admin',1,'登录成功','2026-03-25 13:12:45','0:0:0:0:0:0:0:1'),(231232,'admin',1,'登录成功','2026-03-25 13:18:48','0:0:0:0:0:0:0:1'),(231233,'admin',1,'登录成功','2026-03-25 13:19:02','0:0:0:0:0:0:0:1'),(231234,'admin',1,'登录成功','2026-03-25 13:19:10','0:0:0:0:0:0:0:1'),(231235,'admin',1,'登录成功','2026-03-25 14:09:43','0:0:0:0:0:0:0:1');

/*Table structure for table `t_teacher` */

DROP TABLE IF EXISTS `t_teacher`;

CREATE TABLE `t_teacher` (
  `teacher_id` int NOT NULL AUTO_INCREMENT,
  `teacher_account` varchar(6) NOT NULL,
  `teacher_password` char(32) NOT NULL,
  `teacher_name` varchar(20) NOT NULL,
  PRIMARY KEY (`teacher_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

/*Data for the table `t_teacher` */

insert  into `t_teacher`(`teacher_id`,`teacher_account`,`teacher_password`,`teacher_name`) values (1,'admin','e10adc3949ba59abbe56e057f20f883e','Green'),(2,'arga27','e10adc3949ba59abbe56e057f20f883e','Lion'),(3,'test','e10adc3949ba59abbe56e057f20f883e','Test');

/* Procedure structure for procedure `answerQuestion` */

/*!50003 DROP PROCEDURE IF EXISTS  `answerQuestion` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `answerQuestion`(IN studentId int, IN itemId int, IN type int, IN studentAnswer VARCHAR(500))
BEGIN
	DECLARE n INT;
	SELECT count(*) INTO n FROM t_student_excercise WHERE student_id=studentId AND item_id=itemId;

	IF n=0 THEN
		IF type=1 OR type=2	THEN
			INSERT INTO t_student_excercise(student_id,item_id,answer,fill_time) VALUES(studentId,itemId,studentAnswer,now());
		ELSE
			INSERT INTO t_student_excercise(student_id,item_id,content,fill_time) VALUES(studentId,itemId,studentAnswer,now());
		END IF;
	ELSE
		IF type=1 OR type=2	THEN
			UPDATE t_student_excercise SET answer=studentAnswer,fill_time=now()
				WHERE student_id=studentId AND item_id=itemId;
		ELSE
			UPDATE t_student_excercise SET content=studentAnswer,fill_time=now()
				WHERE student_id=studentId AND item_id=itemId;
		END IF;
	END IF;

END */$$
DELIMITER ;

/* Procedure structure for procedure `p_clazz_experiment_answers` */

/*!50003 DROP PROCEDURE IF EXISTS  `p_clazz_experiment_answers` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `p_clazz_experiment_answers`(IN `expid` int,IN `cno` varchar(6))
BEGIN
	
select student_item_id,item_id,b.experiment_item_score,a.content 
from t_student_item as a,t_experiment_item as b,t_student as c 
where  a.item_id=b.experiment_item_id 
			and a.student_id = c.student_id 
			and b.experiment_id = expid 
			and c.clazz_no = cno;

END */$$
DELIMITER ;

/* Procedure structure for procedure `p_clazz_experiment_score` */

/*!50003 DROP PROCEDURE IF EXISTS  `p_clazz_experiment_score` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `p_clazz_experiment_score`(IN `cno` varchar(6), IN `expid` int)
BEGIN
	SELECT
		student_id,student_no,student_name,clazz_no,memo, 
		(select sum(score) from t_student_item,t_experiment_item 
				where t_student_item.item_id = t_experiment_item.experiment_item_id 							
							and t_experiment_item.experiment_id = expid 
							and t_student_item.student_id = t_student.student_id
		) as score
	FROM
		t_student	
  WHERE
		clazz_no = cno
	ORDER BY
		student_no;		
END */$$
DELIMITER ;

/* Procedure structure for procedure `p_student_experiment_item_score` */

/*!50003 DROP PROCEDURE IF EXISTS  `p_student_experiment_item_score` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `p_student_experiment_item_score`(IN `sid` int, IN `expid` int)
BEGIN
	SELECT
		experiment_item_id,
		experiment_item_no,
		experiment_item_name,
		experiment_item_type,
		experiment_item_content,
		experiment_item_score,
		(select student_item_id from t_student_item 
				where t_student_item.item_id = experiment_item_id 							
							and student_id = sid				
		) as student_item_id,
		(select content from t_student_item 
				where t_student_item.item_id = experiment_item_id 							
							and student_id = sid				
		) as student_answer,
		(select score from t_student_item 
				where t_student_item.item_id = experiment_item_id 							
							and student_id = sid				
		) as score,
		state
	FROM
		t_experiment_item
	WHERE 
		t_experiment_item.experiment_id = expid 
  ORDER BY
		experiment_item_no;

END */$$
DELIMITER ;

/* Procedure structure for procedure `p_student_experiment_score` */

/*!50003 DROP PROCEDURE IF EXISTS  `p_student_experiment_score` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `p_student_experiment_score`(IN `sid` int)
BEGIN
	SELECT
		t_experiment.experiment_id,
		t_experiment.experiment_no,
		t_experiment.experiment_name,
		t_experiment.experiment_type,
		t_experiment.instruction_type,
		(select sum(score) from t_student_item,t_experiment_item
				where t_student_item.item_id = t_experiment_item.experiment_item_id 
							and t_experiment_item.experiment_id = t_experiment.experiment_id
							and student_id = sid				
		) as score,
		state
	FROM
		t_experiment
	ORDER BY
		experiment_no;


END */$$
DELIMITER ;

/*Table structure for table `v_clazz_experiments_score` */

DROP TABLE IF EXISTS `v_clazz_experiments_score`;

/*!50001 DROP VIEW IF EXISTS `v_clazz_experiments_score` */;
/*!50001 DROP TABLE IF EXISTS `v_clazz_experiments_score` */;

/*!50001 CREATE TABLE  `v_clazz_experiments_score`(
 `student_id` int ,
 `student_no` varchar(8) ,
 `student_name` varchar(20) ,
 `clazz_no` varchar(6) ,
 `experiment_id` int ,
 `experiment_no` int ,
 `score` decimal(25,0) 
)*/;

/*Table structure for table `v_clazz_info` */

DROP TABLE IF EXISTS `v_clazz_info`;

/*!50001 DROP VIEW IF EXISTS `v_clazz_info` */;
/*!50001 DROP TABLE IF EXISTS `v_clazz_info` */;

/*!50001 CREATE TABLE  `v_clazz_info`(
 `maxId` varchar(6) ,
 `lastAccess` varchar(4) ,
 `count` bigint 
)*/;

/*Table structure for table `v_student_answer_data_info` */

DROP TABLE IF EXISTS `v_student_answer_data_info`;

/*!50001 DROP VIEW IF EXISTS `v_student_answer_data_info` */;
/*!50001 DROP TABLE IF EXISTS `v_student_answer_data_info` */;

/*!50001 CREATE TABLE  `v_student_answer_data_info`(
 `maxId` int ,
 `lastAccess` datetime ,
 `count` bigint 
)*/;

/*Table structure for table `v_student_answer_log_info` */

DROP TABLE IF EXISTS `v_student_answer_log_info`;

/*!50001 DROP VIEW IF EXISTS `v_student_answer_log_info` */;
/*!50001 DROP TABLE IF EXISTS `v_student_answer_log_info` */;

/*!50001 CREATE TABLE  `v_student_answer_log_info`(
 `maxId` bigint ,
 `lastAccess` datetime ,
 `count` bigint 
)*/;

/*Table structure for table `v_student_expeirment_items` */

DROP TABLE IF EXISTS `v_student_expeirment_items`;

/*!50001 DROP VIEW IF EXISTS `v_student_expeirment_items` */;
/*!50001 DROP TABLE IF EXISTS `v_student_expeirment_items` */;

/*!50001 CREATE TABLE  `v_student_expeirment_items`(
 `itemNo` int ,
 `itemName` varchar(100) ,
 `itemType` int ,
 `score` tinyint ,
 `fillTime` datetime ,
 `studentId` int ,
 `itemId` int ,
 `experimentId` int 
)*/;

/*Table structure for table `v_student_experiment_score` */

DROP TABLE IF EXISTS `v_student_experiment_score`;

/*!50001 DROP VIEW IF EXISTS `v_student_experiment_score` */;
/*!50001 DROP TABLE IF EXISTS `v_student_experiment_score` */;

/*!50001 CREATE TABLE  `v_student_experiment_score`(
 `score` tinyint ,
 `student_id` int ,
 `experiment_id` int ,
 `experiment_no` int ,
 `experiment_name` varchar(30) ,
 `experiment_type` int ,
 `instruction_type` varchar(10) 
)*/;

/*Table structure for table `v_student_info` */

DROP TABLE IF EXISTS `v_student_info`;

/*!50001 DROP VIEW IF EXISTS `v_student_info` */;
/*!50001 DROP TABLE IF EXISTS `v_student_info` */;

/*!50001 CREATE TABLE  `v_student_info`(
 `maxId` int ,
 `lastAccess` varchar(20) ,
 `count` bigint 
)*/;

/*Table structure for table `v_studentexperimentitems` */

DROP TABLE IF EXISTS `v_studentexperimentitems`;

/*!50001 DROP VIEW IF EXISTS `v_studentexperimentitems` */;
/*!50001 DROP TABLE IF EXISTS `v_studentexperimentitems` */;

/*!50001 CREATE TABLE  `v_studentexperimentitems`(
 `itemNo` int ,
 `itemName` varchar(100) ,
 `itemType` int ,
 `score` tinyint ,
 `fillTime` datetime ,
 `studentId` int ,
 `itemId` int ,
 `experimentId` int 
)*/;

/*Table structure for table `v_sys_log_info` */

DROP TABLE IF EXISTS `v_sys_log_info`;

/*!50001 DROP VIEW IF EXISTS `v_sys_log_info` */;
/*!50001 DROP TABLE IF EXISTS `v_sys_log_info` */;

/*!50001 CREATE TABLE  `v_sys_log_info`(
 `maxId` int ,
 `lastAccess` datetime ,
 `count` bigint 
)*/;

/*View structure for view v_clazz_experiments_score */

/*!50001 DROP TABLE IF EXISTS `v_clazz_experiments_score` */;
/*!50001 DROP VIEW IF EXISTS `v_clazz_experiments_score` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_clazz_experiments_score` AS select `v`.`student_id` AS `student_id`,(select `t_student`.`student_no` from `t_student` where (`t_student`.`student_id` = `v`.`student_id`)) AS `student_no`,(select `t_student`.`student_name` from `t_student` where (`t_student`.`student_id` = `v`.`student_id`)) AS `student_name`,(select `t_student`.`clazz_no` from `t_student` where (`t_student`.`student_id` = `v`.`student_id`)) AS `clazz_no`,`v`.`experiment_id` AS `experiment_id`,`v`.`experiment_no` AS `experiment_no`,sum(`v`.`score`) AS `score` from `v_student_experiment_score` `v` group by `v`.`student_id`,`v`.`experiment_id` */;

/*View structure for view v_clazz_info */

/*!50001 DROP TABLE IF EXISTS `v_clazz_info` */;
/*!50001 DROP VIEW IF EXISTS `v_clazz_info` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_clazz_info` AS select max(`t_clazz`.`no`) AS `maxId`,'----' AS `lastAccess`,count(`t_clazz`.`no`) AS `count` from `t_clazz` */;

/*View structure for view v_student_answer_data_info */

/*!50001 DROP TABLE IF EXISTS `v_student_answer_data_info` */;
/*!50001 DROP VIEW IF EXISTS `v_student_answer_data_info` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_student_answer_data_info` AS select max(`t_student_item`.`student_item_id`) AS `maxId`,max(`t_student_item`.`fill_time`) AS `lastAccess`,count(`t_student_item`.`student_item_id`) AS `count` from `t_student_item` */;

/*View structure for view v_student_answer_log_info */

/*!50001 DROP TABLE IF EXISTS `v_student_answer_log_info` */;
/*!50001 DROP VIEW IF EXISTS `v_student_answer_log_info` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_student_answer_log_info` AS select max(`t_student_item_log`.`log_id`) AS `maxId`,max(`t_student_item_log`.`fill_time`) AS `lastAccess`,count(`t_student_item_log`.`log_id`) AS `count` from `t_student_item_log` */;

/*View structure for view v_student_expeirment_items */

/*!50001 DROP TABLE IF EXISTS `v_student_expeirment_items` */;
/*!50001 DROP VIEW IF EXISTS `v_student_expeirment_items` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_student_expeirment_items` AS select `t_experiment_item`.`experiment_item_no` AS `itemNo`,`t_experiment_item`.`experiment_item_name` AS `itemName`,`t_experiment_item`.`experiment_item_type` AS `itemType`,`t_student_item`.`score` AS `score`,`t_student_item`.`fill_time` AS `fillTime`,`t_student_item`.`student_id` AS `studentId`,`t_experiment_item`.`experiment_item_id` AS `itemId`,`t_experiment_item`.`experiment_id` AS `experimentId` from (`t_experiment_item` join `t_student_item` on((`t_student_item`.`item_id` = `t_experiment_item`.`experiment_item_id`))) */;

/*View structure for view v_student_experiment_score */

/*!50001 DROP TABLE IF EXISTS `v_student_experiment_score` */;
/*!50001 DROP VIEW IF EXISTS `v_student_experiment_score` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_student_experiment_score` AS select `t_student_item`.`score` AS `score`,`t_student_item`.`student_id` AS `student_id`,`t_experiment`.`experiment_id` AS `experiment_id`,`t_experiment`.`experiment_no` AS `experiment_no`,`t_experiment`.`experiment_name` AS `experiment_name`,`t_experiment`.`experiment_type` AS `experiment_type`,`t_experiment`.`instruction_type` AS `instruction_type` from (`t_experiment` left join (`t_student_item` join `t_experiment_item` on((`t_student_item`.`item_id` = `t_experiment_item`.`experiment_item_id`))) on((`t_experiment_item`.`experiment_id` = `t_experiment`.`experiment_id`))) */;

/*View structure for view v_student_info */

/*!50001 DROP TABLE IF EXISTS `v_student_info` */;
/*!50001 DROP VIEW IF EXISTS `v_student_info` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_student_info` AS select max(`t_student`.`student_id`) AS `maxId`,max(`t_student`.`ip`) AS `lastAccess`,count(`t_student`.`student_id`) AS `count` from `t_student` */;

/*View structure for view v_studentexperimentitems */

/*!50001 DROP TABLE IF EXISTS `v_studentexperimentitems` */;
/*!50001 DROP VIEW IF EXISTS `v_studentexperimentitems` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_studentexperimentitems` AS select `t_experiment_item`.`experiment_item_no` AS `itemNo`,`t_experiment_item`.`experiment_item_name` AS `itemName`,`t_experiment_item`.`experiment_item_type` AS `itemType`,`t_student_item`.`score` AS `score`,`t_student_item`.`fill_time` AS `fillTime`,`t_student_item`.`student_id` AS `studentId`,`t_experiment_item`.`experiment_item_id` AS `itemId`,`t_experiment_item`.`experiment_id` AS `experimentId` from (`t_experiment_item` join `t_student_item` on((`t_student_item`.`item_id` = `t_experiment_item`.`experiment_item_id`))) */;

/*View structure for view v_sys_log_info */

/*!50001 DROP TABLE IF EXISTS `v_sys_log_info` */;
/*!50001 DROP VIEW IF EXISTS `v_sys_log_info` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_sys_log_info` AS select max(`t_sys_log`.`id`) AS `maxId`,max(`t_sys_log`.`time`) AS `lastAccess`,count(`t_sys_log`.`id`) AS `count` from `t_sys_log` */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
