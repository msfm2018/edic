/*
Navicat MySQL Data Transfer

Source Server         : dic
Source Server Version : 50726
Source Host           : localhost:3306
Source Database       : dic

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2022-05-11 18:52:49
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for cg1
-- ----------------------------
DROP TABLE IF EXISTS `cg1`;
CREATE TABLE `cg1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wordname` varchar(255) DEFAULT NULL,
  `wordtrans` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of cg1
-- ----------------------------
INSERT INTO `cg1` VALUES ('1', 'hello', '你好');
INSERT INTO `cg1` VALUES ('2', 'word', '单词');
INSERT INTO `cg1` VALUES ('3', 'flutter', '颤振;(使)飘动，挥动，颤动;(鸟或昆虫)拍(翅)，振(翅)，鼓(翼);飞来飞去;翩翩飞舞;怦怦乱跳');

-- ----------------------------
-- Table structure for grouptablec
-- ----------------------------
DROP TABLE IF EXISTS `grouptablec`;
CREATE TABLE `grouptablec` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupname` varchar(255) DEFAULT NULL,
  `groupid` varchar(255) DEFAULT NULL,
  `finish` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of grouptablec
-- ----------------------------
INSERT INTO `grouptablec` VALUES ('1', '第一组', 'cg1', '0');
INSERT INTO `grouptablec` VALUES ('2', '第二组', 'cg2', '0');
INSERT INTO `grouptablec` VALUES ('3', '第三组', 'cg3', '0');
INSERT INTO `grouptablec` VALUES ('4', '第四组', 'cg4', '0');
INSERT INTO `grouptablec` VALUES ('5', '第五组', 'cg5', '0');
INSERT INTO `grouptablec` VALUES ('6', '第六组', 'cg6', '0');
INSERT INTO `grouptablec` VALUES ('7', '第七组', 'cg7', '0');
INSERT INTO `grouptablec` VALUES ('8', '第八组', 'cg8', '0');
INSERT INTO `grouptablec` VALUES ('9', '第九组', 'cg9', '0');
INSERT INTO `grouptablec` VALUES ('10', '第十组', 'cg10', '0');
INSERT INTO `grouptablec` VALUES ('11', '第十一组', 'cg11', '0');
INSERT INTO `grouptablec` VALUES ('12', '第十二组', 'cg12', '0');
INSERT INTO `grouptablec` VALUES ('13', '第十三组', 'cg13', '0');
INSERT INTO `grouptablec` VALUES ('14', '第十四组', 'cg14', '0');
