/*
Navicat MySQL Data Transfer

Source Server         : 192.168.3.38_3306
Source Server Version : 80016
Source Host           : 192.168.3.40:3306
Source Database       : dic

Target Server Type    : MYSQL
Target Server Version : 80016
File Encoding         : 65001

Date: 2022-06-30 21:33:30
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for item1
-- ----------------------------
DROP TABLE IF EXISTS `item1`;
CREATE TABLE `item1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wordname` varchar(255) DEFAULT NULL,
  `tone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '音标',
  `wordtrans` varchar(255) DEFAULT NULL COMMENT '单词翻译',
  `video` varchar(255) DEFAULT NULL COMMENT '单词视频解释',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of item1
-- ----------------------------
INSERT INTO `item1` VALUES ('1', '1', null, '你好', null);
INSERT INTO `item1` VALUES ('3', '3', null, '颤振;(使)飘动，挥动，颤动;(鸟或昆虫)拍(翅)，振(翅)，鼓(翼);飞来飞去;翩翩飞舞;怦怦乱跳', null);
INSERT INTO `item1` VALUES ('4', '4', null, '切换', null);
INSERT INTO `item1` VALUES ('5', '5', null, '触发器', null);
INSERT INTO `item1` VALUES ('6', '6', '英 [\'fɪzɪk]', '物理学', 'https://media6.smartstudy.com/00/5c/67051/5/dest.mp4?hmsr=25');
INSERT INTO `item1` VALUES ('7', '7', null, '实体', null);
INSERT INTO `item1` VALUES ('8', '8', null, '2', null);
INSERT INTO `item1` VALUES ('9', '9', null, '4', null);
INSERT INTO `item1` VALUES ('10', '10', null, '2', null);
INSERT INTO `item1` VALUES ('11', '11', null, '11', null);
INSERT INTO `item1` VALUES ('12', '12', null, '112', null);
INSERT INTO `item1` VALUES ('13', '13', null, '113', null);
INSERT INTO `item1` VALUES ('14', '14', null, '114', null);
INSERT INTO `item1` VALUES ('15', '15', null, '115', null);
INSERT INTO `item1` VALUES ('16', '16', null, '116', null);
INSERT INTO `item1` VALUES ('17', '17', null, '117', null);
INSERT INTO `item1` VALUES ('18', '18', null, '118', null);
INSERT INTO `item1` VALUES ('19', '19', null, '119', null);
INSERT INTO `item1` VALUES ('20', '20', null, '222', null);
INSERT INTO `item1` VALUES ('21', '21', null, 'kan', null);

-- ----------------------------
-- Table structure for items
-- ----------------------------
DROP TABLE IF EXISTS `items`;
CREATE TABLE `items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupname` varchar(255) DEFAULT NULL,
  `groupid` varchar(255) DEFAULT NULL,
  `finish` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of items
-- ----------------------------
INSERT INTO `items` VALUES ('1', '第一组', 'item1', '0');
INSERT INTO `items` VALUES ('2', '第二组', 'item2', '0');
INSERT INTO `items` VALUES ('3', '第三组', 'item3', '0');
INSERT INTO `items` VALUES ('4', '第四组', 'item4', '0');
INSERT INTO `items` VALUES ('5', '第五组', 'item5', '0');
INSERT INTO `items` VALUES ('6', '第六组', 'item6', '0');
INSERT INTO `items` VALUES ('7', '第七组', 'item7', '0');
INSERT INTO `items` VALUES ('8', '第八组', 'item8', '0');
INSERT INTO `items` VALUES ('9', '第九组', 'item9', '0');
INSERT INTO `items` VALUES ('10', '第十组', 'item10', '0');
INSERT INTO `items` VALUES ('11', '第十一组', 'item11', '0');
INSERT INTO `items` VALUES ('12', '第十二组', 'item12', '0');
INSERT INTO `items` VALUES ('13', '第十三组', 'item13', '0');
INSERT INTO `items` VALUES ('14', '第十四组', 'item14', '0');
