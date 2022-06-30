/*
Navicat MySQL Data Transfer

Source Server         : dic
Source Server Version : 50726
Source Host           : localhost:3306
Source Database       : dic

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2022-06-23 08:18:32
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for cg1
-- ----------------------------
DROP TABLE IF EXISTS `cg1`;
CREATE TABLE `cg1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wordname` varchar(255) DEFAULT NULL,
  `symbol` varchar(255) DEFAULT NULL COMMENT '音标',
  `wordtrans` varchar(255) DEFAULT NULL COMMENT '单词翻译',
  `video` varchar(255) DEFAULT NULL COMMENT '单词视频解释',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of cg1
-- ----------------------------
INSERT INTO `cg1` VALUES ('1', 'last', null, '你好', null);
INSERT INTO `cg1` VALUES ('2', 'word', null, '单词', null);
INSERT INTO `cg1` VALUES ('3', 'flutter', null, '颤振;(使)飘动，挥动，颤动;(鸟或昆虫)拍(翅)，振(翅)，鼓(翼);飞来飞去;翩翩飞舞;怦怦乱跳', null);
INSERT INTO `cg1` VALUES ('4', 'toggle', null, '切换', null);
INSERT INTO `cg1` VALUES ('5', 'trigger', null, '触发器', null);
INSERT INTO `cg1` VALUES ('6', 'physics', '英 [\'fɪzɪk]', '物理学', 'https://media6.smartstudy.com/00/5c/67051/5/dest.mp4?hmsr=25');
INSERT INTO `cg1` VALUES ('7', 'entity', null, '实体', null);
INSERT INTO `cg1` VALUES ('8', '3', null, '2', null);
INSERT INTO `cg1` VALUES ('9', '4', null, '4', null);
INSERT INTO `cg1` VALUES ('10', '5', null, '2', null);
INSERT INTO `cg1` VALUES ('11', '11', null, '11', null);
INSERT INTO `cg1` VALUES ('12', '112', null, '112', null);
INSERT INTO `cg1` VALUES ('13', '113', null, '113', null);
INSERT INTO `cg1` VALUES ('14', '114', null, '114', null);
INSERT INTO `cg1` VALUES ('15', '115', null, '115', null);
INSERT INTO `cg1` VALUES ('16', '116', null, '116', null);
INSERT INTO `cg1` VALUES ('17', '117', null, '117', null);
INSERT INTO `cg1` VALUES ('18', '118', null, '118', null);
INSERT INTO `cg1` VALUES ('19', '119', null, '119', null);
INSERT INTO `cg1` VALUES ('20', 'first', null, '222', null);
INSERT INTO `cg1` VALUES ('21', 'kan', null, 'kan', null);

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
