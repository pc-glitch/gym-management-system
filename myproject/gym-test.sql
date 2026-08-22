/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80034 (8.0.34)
 Source Host           : localhost:3306
 Source Schema         : gym-test

 Target Server Type    : MySQL
 Target Server Version : 80034 (8.0.34)
 File Encoding         : 65001

 Date: 18/05/2026 13:41:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for aboutus
-- ----------------------------
DROP TABLE IF EXISTS `aboutus`;
CREATE TABLE `aboutus`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `title` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '标题',
  `subtitle` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '副标题',
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '内容',
  `picture1` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '图片1',
  `picture2` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '图片2',
  `picture3` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '图片3',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1729408177362624514 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '关于我们' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of aboutus
-- ----------------------------
INSERT INTO `aboutus` VALUES (1, '2026-03-06 12:12:55', '关于我们', 'ABOUT US', '%3Cp%3E%E4%B8%8D%E7%AE%A1%E4%BD%A0%E6%83%B3%E8%A6%81%E6%80%8E%E6%A0%B7%E7%9A%84%E7%94%9F%E6%B4%BB%EF%BC%8C%E4%BD%A0%E9%83%BD%E8%A6%81%E5%8E%BB%E5%8A%AA%E5%8A%9B%E4%BA%89%E5%8F%96%EF%BC%8C%E4%B8%8D%E5%A4%9A%E5%B0%9D%E8%AF%95%E4%B8%80%E4%BA%9B%E4%BA%8B%E6%83%85%E6%80%8E%E4%B9%88%E7%9F%A5%E9%81%93%E8%87%AA%E5%B7%B1%E9%80%82%E5%90%88%E4%BB%80%E4%B9%88%E3%80%81%E4%B8%8D%E9%80%82%E5%90%88%E4%BB%80%E4%B9%88%E5%91%A2%3F%3C%2Fp%3E%3Cp%3E%E4%BD%A0%E8%AF%B4%E4%BD%A0%E5%96%9C%E6%AC%A2%E8%AF%BB%E4%B9%A6%EF%BC%8C%E8%AE%A9%E6%88%91%E7%BB%99%E4%BD%A0%E5%88%97%E4%B9%A6%E5%8D%95%EF%BC%8C%E4%BD%A0%E8%BF%98%E9%97%AE%E6%88%91%E5%93%AA%E9%87%8C%E6%9C%89%E9%82%A3%E4%B9%88%E5%A4%9A%E6%97%B6%E9%97%B4%E7%9C%8B%E4%B9%A6%3B%E4%BD%A0%E8%AF%B4%E8%87%AA%E5%B7%B1%E6%A2%A6%E6%83%B3%E7%9A%84%E8%81%8C%E4%B8%9A%E6%98%AF%E5%B9%BF%E5%91%8A%E6%96%87%E6%A1%88%EF%BC%8C%E9%97%AE%E6%88%91%E5%A6%82%E4%BD%95%E6%88%90%E4%B8%BA%E4%B8%80%E4%B8%AA%E6%96%87%E6%A1%88%EF%BC%8C%E5%BA%94%E8%AF%A5%E5%85%B7%E5%A4%87%E5%93%AA%E4%BA%9B%E7%B4%A0%E8%B4%A8%3B%E4%BD%A0%E8%AF%B4%E4%BD%A0%E8%AE%A1%E5%88%92%E6%99%A8%E8%B7%91%EF%BC%8C%E4%BD%86%E6%80%BB%E6%98%AF%E5%9B%A0%E4%B8%BA%E5%AD%A6%E4%B9%A0%E3%80%81%E5%B7%A5%E4%BD%9C%E8%BE%9B%E8%8B%A6%E6%88%96%E8%80%85%E8%BA%AB%E4%BD%93%E4%B8%8D%E8%88%92%E6%9C%8D%E7%AC%AC%E4%BA%8C%E5%A4%A9%E8%B5%B7%E4%B8%8D%E4%BA%86%E5%BA%8A%3B%E4%BD%A0%E8%AF%B4%E4%BD%A0%E4%B8%80%E7%9B%B4%E6%A2%A6%E6%83%B3%E4%B8%80%E4%B8%AA%E4%BA%BA%E5%8E%BB%E9%95%BF%E9%80%94%E6%97%85%E8%A1%8C%EF%BC%8C%E4%BD%86%E6%98%AF%E6%B2%A1%E9%92%B1%EF%BC%8C%E7%88%B6%E6%AF%8D%E8%A7%89%E5%BE%97%E5%8D%B1%E9%99%A9%E3%80%82%E5%85%B6%E5%AE%9E%EF%BC%8C%E6%88%91%E5%B7%B2%E7%BB%8F%E5%8E%8C%E5%80%A6%E4%BA%86%E4%BD%A0%E8%BF%99%E6%A0%B7%E8%AF%B4%E8%AF%B4%E8%80%8C%E5%B7%B2%E7%9A%84%E6%8A%8A%E6%88%8F%EF%BC%8C%E6%88%91%E8%A7%89%E5%BE%97%E5%B0%B1%E7%AE%97%E6%88%91%E5%91%8A%E8%AF%89%E4%BD%A0%E5%A6%82%E4%BD%95%E5%8E%BB%E5%81%9A%EF%BC%8C%E4%BD%A0%E4%B9%9F%E4%B8%8D%E4%BC%9A%E7%85%A7%E5%81%9A%EF%BC%8C%E5%9B%A0%E4%B8%BA%E4%BD%A0%E6%A0%B9%E6%9C%AC%E4%BB%80%E4%B9%88%E9%83%BD%E4%B8%8D%E5%81%9A%E3%80%82%3C%2Fp%3E', 'https://img2.baidu.com/it/u=3678732902,707784979&fm=253&fmt=auto&app=138&f=JPEG?w=704&h=500', 'https://img1.baidu.com/it/u=2540309421,4162180232&fm=253&fmt=auto&app=138&f=JPEG?w=768&h=500', 'https://img2.baidu.com/it/u=761790034,3093948728&fm=253&fmt=auto&app=138&f=JPEG?w=667&h=500');

-- ----------------------------
-- Table structure for activityinformation
-- ----------------------------
DROP TABLE IF EXISTS `activityinformation`;
CREATE TABLE `activityinformation`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '活动名称',
  `classify` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '活动类型',
  `activitytheme` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '活动主题',
  `sponsoringdepartment` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '主办部门',
  `activitytime` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '活动时间',
  `venue` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '活动地点',
  `activestate` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '活动状态',
  `activityrules` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '活动规则',
  `introduction` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '简介',
  `photo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '封面',
  `photos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '详情图',
  `details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '详细信息',
  `adduserid` bigint NULL DEFAULT NULL COMMENT '创建人id',
  `addusername` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人名称',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1152735662412148761 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '活动信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of activityinformation
-- ----------------------------
INSERT INTO `activityinformation` VALUES (1152735662412136451, '乒乓球挑战赛', '体育赛事', '小球转动大球', '乒乓球社', '2023-10-25 10:00:00', '体育馆', '进行中', '1. 采用五局三胜制；2. 每局11分制；3. 发球必须抛球16cm以上。', '考验技巧和反应速度的乒乓球比赛。', 'https://img2.baidu.com/it/u=1015939374%2C364123025&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=627', 'https://img0.baidu.com/it/u=3921479565%2C1404074060&fm=253&fmt=auto&app=120&f=JPEG?w=702&h=500', '报名人数众多，将进行多轮淘汰赛决出冠军。', 10, 'user001', '2026-03-06 13:39:59');
INSERT INTO `activityinformation` VALUES (1152735662412136452, '校园足球联赛', '体育赛事', '绿茵场上展风采', '足球协会', '2023-11-10 16:00:00', '体育馆', '报名中', '1. 每队上场11人；2. 比赛时间为90分钟；3. 红黄牌制度严格执行。', '展现团队协作精神的足球盛宴。', 'https://img2.baidu.com/it/u=2204441803%2C401652385&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=707', 'https://img2.baidu.com/it/u=658524750%2C3660737811&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', '共有8支球队参赛，采用单循环赛制。', 10, 'user001', '2026-03-06 13:39:59');
INSERT INTO `activityinformation` VALUES (1152735662412136457, '合唱比赛', '文化活动', '歌声飞扬，梦想起航', '音乐协会', '2023-11-15 18:30:00', '体育馆', '报名中', '1. 参赛人数不少于20人；2. 曲目时长3-6分钟；3. 可加入伴舞或伴奏。', '展现团队歌唱实力的比赛。', 'https://img2.baidu.com/it/u=2843984095%2C3752921441&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 'https://img0.baidu.com/it/u=3921479565%2C1404074060&fm=253&fmt=auto&app=120&f=JPEG?w=702&h=500', '分为专业组和业余组进行比赛。', 10, 'user001', '2026-03-06 13:39:59');
INSERT INTO `activityinformation` VALUES (1152735662412136460, '摄影大赛', '艺术展览', '光影世界，记录美好', '摄影协会', '2023-10-12 14:00:00', '体育馆', '已完成', '1. 作品必须原创；2. 可适当后期处理；3. 需附简短说明。', '用镜头记录校园美好瞬间的比赛。', 'https://img2.baidu.com/it/u=617799345%2C503735683&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=706', 'https://img0.baidu.com/it/u=3921479565%2C1404074060&fm=253&fmt=auto&app=120&f=JPEG?w=702&h=500', '分为风景、人物、纪实等组别。', 10, 'user001', '2026-03-06 13:39:59');
INSERT INTO `activityinformation` VALUES (1152735662412136461, '美术作品展', '艺术展览', '色彩斑斓，创意无限', '美术社', '2023-11-25 09:30:00', '体育馆', '报名中', '1. 作品尺寸不超过2米；2. 题材不限；3. 需附创作说明。', '展示学生美术创作成果的作品展。', 'https://img1.baidu.com/it/u=4205243848%2C3878102060&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 'https://img2.baidu.com/it/u=3211721176%2C272088394&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=577', '包括油画、国画、水彩等多种形式。', 10, 'user001', '2026-03-06 13:39:59');
INSERT INTO `activityinformation` VALUES (1152735662412136462, '科技创新大赛', '学术竞赛', '创新引领未来', '科技创新协会', '2023-10-30 13:30:00', '体育馆', '进行中', '1. 每队不超过5人；2. 作品必须原创；3. 需提交详细技术报告。', '展示学生科技创新能力的比赛。', 'https://img1.baidu.com/it/u=3651267614%2C39403406&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1131', 'https://img1.baidu.com/it/u=3651267614%2C39403406&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1131', '包括机器人、软件、硬件等多个类别。', 10, 'user001', '2026-03-06 13:39:59');
INSERT INTO `activityinformation` VALUES (1152735662412136466, '物理学术竞赛', '学术竞赛', '探索自然规律', '物理协会', '2023-10-26 10:30:00', '体育馆', '报名中', '1. 每队3人；2. 比赛时间4小时；3. 可使用计算器。', '检验物理知识和应用能力的竞赛。', 'https://img0.baidu.com/it/u=3546475578%2C2696018391&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=813', 'https://img2.baidu.com/it/u=2843984095%2C3752921441&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', '包括理论计算和实验操作两部分。', 10, 'user001', '2026-03-06 13:39:59');
INSERT INTO `activityinformation` VALUES (1152735662412136473, '经济学知识竞赛', '学术竞赛', '经世济民，学以致用', '经济学社', '2023-11-04 10:00:00', '体育馆', '进行中', '1. 个人参赛；2. 比赛时间2小时；3. 可使用计算器。', '检验经济学知识的竞赛。', 'https://img1.baidu.com/it/u=887267920%2C2480366026&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=887', 'https://img2.baidu.com/it/u=350278922%2C34978712&fm=253&fmt=auto&app=120&f=JPEG?w=667&h=500', '包括微观经济和宏观经济。', 10, 'user001', '2026-03-06 13:39:59');
INSERT INTO `activityinformation` VALUES (1152735662412136477, '人工智能挑战赛', '学术竞赛', '智能时代，未来已来', '人工智能协会', '2023-11-14 16:00:00', '体育馆', '报名中', '1. 每队不超过4人；2. 比赛时间4小时；3. 可使用AI工具。', '探索人工智能应用的竞赛。', 'https://img0.baidu.com/it/u=1378848582%2C1977939649&fm=253&fmt=auto&app=120&f=JPEG?w=925&h=451', 'https://img2.baidu.com/it/u=522382658%2C3607042073&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=726', '包括图像识别、自然语言处理等方向。', 10, 'user001', '2026-03-06 13:39:59');
INSERT INTO `activityinformation` VALUES (1152735662412140544, '2023年校园篮球联赛', '体育赛事', '团结拼搏，勇攀高峰', '体育部', '2023-10-15 14:00:00', '体育馆', '进行中', '1. 每队限报12人，上场5人；2. 比赛采用国际篮联规则；3. 迟到15分钟视为弃权；4. 比赛中禁止恶意犯规。', '一年一度的校园篮球联赛，旨在增强学生体质，培养团队合作精神。', 'https://img2.baidu.com/it/u=658524750%2C3660737811&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 'https://img1.baidu.com/it/u=3714254629%2C3763860272&fm=253&fmt=auto&app=138&f=JPEG?w=769&h=500', '本次比赛共有16支队伍参加，分为四个小组进行循环赛，每组前两名出线后进行淘汰赛。', 10, 'user001', '2026-03-06 13:39:59');
INSERT INTO `activityinformation` VALUES (1152735662412140545, '秋季田径运动会', '体育赛事', '强身健体，超越自我', '体育部', '2023-09-20 09:00:00', '体育馆', '已完成', '1. 每人限报2项；2. 检录时间提前30分钟；3. 比赛过程中必须佩戴号码布。', '全校师生参与的体育盛会，展现青春活力。', 'https://img0.baidu.com/it/u=4253585533%2C4186500009&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1561', 'https://img1.baidu.com/it/u=3068104650%2C1541999979&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=707', '设有田赛和径赛多个项目，包括100米、跳远、铅球等。', 10, 'user001', '2026-03-06 13:39:59');
INSERT INTO `activityinformation` VALUES (1152735662412140561, '化学实验竞赛', '学术竞赛', '探索微观世界', '化学协会', '2023-11-12 09:00:00', '体育馆', '进行中', '1. 每队2人；2. 实验时间3小时；3. 必须注意安全操作。', '检验化学实验技能的竞赛。', 'https://img2.baidu.com/it/u=522382658%2C3607042073&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=726', 'https://img1.baidu.com/it/u=3651267614%2C39403406&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1131', '包括无机、有机、分析等多个方向。', 10, 'user001', '2026-03-06 13:39:59');
INSERT INTO `activityinformation` VALUES (1152735662412140564, '历史知识竞赛', '学术竞赛', '以史为鉴，面向未来', '历史协会', '2023-10-14 15:00:00', '体育馆', '已完成', '1. 个人参赛；2. 比赛时间1.5小时；3. 可携带纸质资料。', '检验历史知识的竞赛。', 'https://img1.baidu.com/it/u=610000078%2C1390850871&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=653', 'https://img0.baidu.com/it/u=143180186%2C2066510241&fm=253&fmt=auto&app=120&f=JPEG?w=655&h=359', '包括中国古代史、近现代史等内容。', 10, 'user001', '2026-03-06 13:39:59');
INSERT INTO `activityinformation` VALUES (1152735662412140567, '哲学知识竞赛', '学术竞赛', '思考人生，探索真理', '哲学协会', '2023-11-16 19:30:00', '体育馆', '报名中', '1. 个人参赛；2. 比赛时间2小时；3. 可携带纸质资料。', '检验哲学知识的竞赛。', 'https://img2.baidu.com/it/u=999928491%2C590065789&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1422', 'https://img1.baidu.com/it/u=1770085289%2C817140618&fm=253&fmt=auto&app=120&f=JPEG?w=514&h=500', '包括中西方哲学思想。', 10, 'user001', '2026-03-06 13:39:59');
INSERT INTO `activityinformation` VALUES (1152735662412140570, '法学知识竞赛', '学术竞赛', '知法守法，维护正义', '法学社', '2023-10-31 15:30:00', '体育馆', '报名中', '1. 个人参赛；2. 比赛时间2小时；3. 可携带纸质资料。', '检验法学知识的竞赛。', 'https://img0.baidu.com/it/u=3908890486%2C3560383583&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=700', 'https://img2.baidu.com/it/u=2843984095%2C3752921441&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', '包括宪法、民法、刑法等基础法律。', 10, 'user001', '2026-03-06 13:39:59');
INSERT INTO `activityinformation` VALUES (1152735662412144642, '羽毛球友谊赛', '体育赛事', '友谊第一，比赛第二', '羽毛球协会', '2023-11-05 15:30:00', '体育馆', '报名中', '1. 采用三局两胜制；2. 发球高度不得超过腰部；3. 比赛用球由主办方提供。', '为促进同学间交流，特举办羽毛球友谊赛。', 'https://img1.baidu.com/it/u=3848953233%2C376465381&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1500', 'https://img0.baidu.com/it/u=1378848582%2C1977939649&fm=253&fmt=auto&app=120&f=JPEG?w=925&h=451', '比赛分为男子单打、女子单打和混合双打三个项目。', 10, 'user001', '2026-03-06 13:39:59');
INSERT INTO `activityinformation` VALUES (1152735662412144646, '网球表演赛', '体育赛事', '优雅挥拍，享受运动', '网球俱乐部', '2023-10-18 14:30:00', '体育馆', '进行中', '1. 采用三盘两胜制；2. 发球时脚不得踩线；3. 球拍必须符合规定。', '展示网球技巧的表演赛。', 'https://img1.baidu.com/it/u=3714254629%2C3763860272&fm=253&fmt=auto&app=138&f=JPEG?w=769&h=500', 'https://img0.baidu.com/it/u=143180186%2C2066510241&fm=253&fmt=auto&app=120&f=JPEG?w=655&h=359', '邀请校内外知名网球选手参与。', 10, 'user001', '2026-03-06 13:39:59');
INSERT INTO `activityinformation` VALUES (1152735662412144647, '武术文化节', '文化活动', '弘扬国粹，传承文化', '武术协会', '2023-11-20 09:00:00', '体育馆', '报名中', '1. 表演时间不少于3分钟；2. 服装必须符合规定；3. 配乐需提前提交。', '展示中华武术魅力的文化节。', 'https://img0.baidu.com/it/u=143180186%2C2066510241&fm=253&fmt=auto&app=120&f=JPEG?w=655&h=359', 'https://img2.baidu.com/it/u=617799345%2C503735683&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=706', '包括太极拳、长拳、刀术等多个项目。', 10, 'user001', '2026-03-06 13:39:59');
INSERT INTO `activityinformation` VALUES (1152735662412144651, '书法展览', '艺术展览', '翰墨飘香，传承文明', '书法协会', '2023-11-08 10:00:00', '体育馆', '进行中', '1. 作品尺寸不超过6尺；2. 内容积极健康；3. 需附作者简历。', '展示优秀书法作品的艺术展览。', 'https://img2.baidu.com/it/u=4063617942%2C2241864640&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 'https://img0.baidu.com/it/u=3546475578%2C2696018391&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=813', '展出古今名家及学生优秀作品。', 10, 'user001', '2026-03-06 13:39:59');
INSERT INTO `activityinformation` VALUES (1152735662412144659, '生物知识竞赛', '学术竞赛', '探索生命奥秘', '生物协会', '2023-11-22 14:00:00', '体育馆', '报名中', '1. 个人参赛；2. 比赛时间2小时；3. 可使用参考资料。', '检验生物学知识的竞赛。', 'https://img1.baidu.com/it/u=4190187254%2C3406209624&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=690', 'https://img1.baidu.com/it/u=3714254629%2C3763860272&fm=253&fmt=auto&app=138&f=JPEG?w=769&h=500', '包括植物、动物、人体等多个领域。', 10, 'user001', '2026-03-06 13:39:59');
INSERT INTO `activityinformation` VALUES (1152735662412144662, '文学知识竞赛', '学术竞赛', '感受文字魅力', '文学社', '2023-10-24 18:00:00', '体育馆', '进行中', '1. 个人参赛；2. 比赛时间2小时；3. 可携带参考资料。', '检验文学知识的竞赛。', 'https://img1.baidu.com/it/u=1770085289%2C817140618&fm=253&fmt=auto&app=120&f=JPEG?w=514&h=500', 'https://img1.baidu.com/it/u=3848953233%2C376465381&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1500', '包括中外文学经典作品。', 10, 'user001', '2026-03-06 13:39:59');
INSERT INTO `activityinformation` VALUES (1152735662412144667, '管理学知识竞赛', '学术竞赛', '管理智慧，创造价值', '管理学社', '2023-11-09 13:00:00', '体育馆', '进行中', '1. 个人参赛；2. 比赛时间1.5小时；3. 可使用参考资料。', '检验管理学知识的竞赛。', 'https://img0.baidu.com/it/u=4279913965%2C3258122432&fm=253&fmt=auto&app=120&f=PNG?w=747&h=500', 'https://img2.baidu.com/it/u=522382658%2C3607042073&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=726', '包括管理理论和案例分析。', 10, 'user001', '2026-03-06 13:39:59');
INSERT INTO `activityinformation` VALUES (1152735662412144668, '计算机科学竞赛', '学术竞赛', '代码改变世界', '计算机协会', '2023-10-17 09:30:00', '体育馆', '已完成', '1. 个人参赛；2. 比赛时间3小时；3. 可使用编程工具。', '检验编程和算法能力的竞赛。', 'https://img2.baidu.com/it/u=3833945186%2C319260251&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=750', 'https://img0.baidu.com/it/u=1378848582%2C1977939649&fm=253&fmt=auto&app=120&f=JPEG?w=925&h=451', '包括算法设计、代码实现等。', 10, 'user001', '2026-03-06 13:39:59');
INSERT INTO `activityinformation` VALUES (1152735662412148741, '游泳公开赛', '体育赛事', '畅游泳池，畅享清凉', '游泳协会', '2023-09-30 13:00:00', '体育馆', '已完成', '1. 每人限报2个单项；2. 出发必须从出发台跳水；3. 转身必须触壁。', '清凉一夏的游泳比赛。', 'https://img1.baidu.com/it/u=287310919%2C4033385410&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1108', 'https://img2.baidu.com/it/u=522382658%2C3607042073&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=726', '设有自由泳、蛙泳、仰泳等多个项目。', 10, 'user001', '2026-03-06 13:39:59');
INSERT INTO `activityinformation` VALUES (1152735662412148744, '舞蹈大赛', '文化活动', '舞动青春，展现自我', '舞蹈社', '2023-10-28 19:00:00', '体育馆', '进行中', '1. 表演时间3-5分钟；2. 服装道具自备；3. 音乐需提前一周提交。', '青春洋溢的舞蹈比赛。', 'https://img2.baidu.com/it/u=350278922%2C34978712&fm=253&fmt=auto&app=120&f=JPEG?w=667&h=500', 'https://img1.baidu.com/it/u=1770085289%2C817140618&fm=253&fmt=auto&app=120&f=JPEG?w=514&h=500', '分为现代舞、民族舞、街舞等组别。', 10, 'user001', '2026-03-06 13:39:59');
INSERT INTO `activityinformation` VALUES (1152735662412148746, '话剧表演', '文化活动', '演绎经典，感受人生', '话剧社', '2023-10-22 15:00:00', '体育馆', '进行中', '1. 表演时间不少于45分钟；2. 服装道具自备；3. 剧本需提前审核。', '经典话剧的现场演绎。', 'https://img0.baidu.com/it/u=4037809461%2C4281294659&fm=253&fmt=auto&app=120&f=JPEG?w=760&h=1997', 'https://img0.baidu.com/it/u=3908890486%2C3560383583&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=700', '改编自经典文学作品。', 10, 'user001', '2026-03-06 13:39:59');
INSERT INTO `activityinformation` VALUES (1152735662412148751, '数学建模竞赛', '学术竞赛', '用数学解决实际问题', '数学协会', '2023-11-18 08:00:00', '体育馆', '报名中', '1. 每队3人；2. 比赛时间72小时；3. 可使用任何参考资料。', '培养数学应用能力的竞赛。', 'https://img1.baidu.com/it/u=3068104650%2C1541999979&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=707', 'https://img1.baidu.com/it/u=3848953233%2C376465381&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1500', '从实际问题中抽象出数学模型并求解。', 10, 'user001', '2026-03-06 13:39:59');
INSERT INTO `activityinformation` VALUES (1152735662412148752, '英语演讲比赛', '学术竞赛', 'Show Your English', '英语协会', '2023-10-20 16:00:00', '体育馆', '已完成', '1. 演讲时间3-5分钟；2. 主题不限；3. 可使用PPT辅助。', '展现英语口语表达能力的比赛。', 'https://img2.baidu.com/it/u=3211721176%2C272088394&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=577', 'https://img0.baidu.com/it/u=143180186%2C2066510241&fm=253&fmt=auto&app=120&f=JPEG?w=655&h=359', '分为专业组和业余组进行。', 10, 'user001', '2026-03-06 13:39:59');
INSERT INTO `activityinformation` VALUES (1152735662412148757, '地理知识竞赛', '学术竞赛', '认识地球，了解世界', '地理协会', '2023-11-06 16:30:00', '体育馆', '进行中', '1. 个人参赛；2. 比赛时间1小时；3. 可使用地图。', '检验地理知识的竞赛。', 'https://img0.baidu.com/it/u=3401160569%2C1113078906&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=654', 'https://img0.baidu.com/it/u=3908890486%2C3560383583&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=700', '包括自然地理和人文地理两部分。', 10, 'user001', '2026-03-06 13:39:59');
INSERT INTO `activityinformation` VALUES (1152735662412148760, '心理学知识竞赛', '学术竞赛', '认识心理，健康成长', '心理学协会', '2023-10-16 14:30:00', '体育馆', '已完成', '1. 个人参赛；2. 比赛时间1.5小时；3. 可携带参考资料。', '检验心理学知识的竞赛。', 'https://img0.baidu.com/it/u=3921479565%2C1404074060&fm=253&fmt=auto&app=120&f=JPEG?w=702&h=500', 'https://img0.baidu.com/it/u=1378848582%2C1977939649&fm=253&fmt=auto&app=120&f=JPEG?w=925&h=451', '包括基础理论和实际应用。', 10, 'user001', '2026-03-06 13:39:59');

-- ----------------------------
-- Table structure for activityregistration
-- ----------------------------
DROP TABLE IF EXISTS `activityregistration`;
CREATE TABLE `activityregistration`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '活动名称',
  `shenheid` bigint NULL DEFAULT NULL COMMENT '活动id',
  `userid` bigint NULL DEFAULT NULL COMMENT '报名人id',
  `username` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '报名人',
  `shenhe` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核',
  `photo` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '封面',
  `registrationinformation` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '报名信息',
  `adduserid` bigint NULL DEFAULT NULL COMMENT '审核人id',
  `addusername` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核人',
  `shenhehuifu` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '审核回复',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2054754261007065090 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '活动报名' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of activityregistration
-- ----------------------------
INSERT INTO `activityregistration` VALUES (2042536300280270850, '乒乓球挑战赛', 1, 1152735791059828742, 'user007', '通过', NULL, '急急急', 1, '管理员', '报名审核通过，请按活动时间准时参加。', '2026-04-10 17:32:57');
INSERT INTO `activityregistration` VALUES (2049407427455627266, '乒乓球挑战赛', NULL, 1152735791059828742, '周丽', NULL, NULL, '报名参加活动: 乒乓球挑战赛', NULL, NULL, NULL, '2026-04-29 16:36:22');
INSERT INTO `activityregistration` VALUES (2049408541152391170, '乒乓球挑战赛', NULL, 1152735791059828742, '周丽', NULL, NULL, '报名参加活动: 乒乓球挑战赛', NULL, NULL, NULL, '2026-04-29 16:40:47');
INSERT INTO `activityregistration` VALUES (2049409540734726146, '乒乓球挑战赛', 1152735662412136451, 1152735791059828742, '周丽', NULL, NULL, '报名参加活动: 乒乓球挑战赛', NULL, NULL, NULL, '2026-04-29 16:44:45');
INSERT INTO `activityregistration` VALUES (2054385861009215490, '校园足球联赛', 1152735662412136452, 1152735791059828742, '周丽', NULL, NULL, '嘻嘻嘻', NULL, NULL, NULL, '2026-05-13 10:18:53');
INSERT INTO `activityregistration` VALUES (2054754261007065089, '校园足球联赛', 1152735662412136452, 1152735791059828742, '周丽', NULL, NULL, '报名参加活动: 校园足球联赛', NULL, NULL, NULL, '2026-05-14 10:42:46');

-- ----------------------------
-- Table structure for activitytype
-- ----------------------------
DROP TABLE IF EXISTS `activitytype`;
CREATE TABLE `activitytype`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1152735528093757463 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '活动类型' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of activitytype
-- ----------------------------
INSERT INTO `activitytype` VALUES (1152735528093745154, '乒乓球友谊赛', '2026-03-06 13:39:51');
INSERT INTO `activitytype` VALUES (1152735528093745156, '健身操课程', '2026-03-06 13:39:51');
INSERT INTO `activitytype` VALUES (1152735528093749251, '游泳健身', '2026-03-06 13:39:51');
INSERT INTO `activitytype` VALUES (1152735528093749253, '瑜伽练习', '2026-03-06 13:39:51');
INSERT INTO `activitytype` VALUES (1152735528093749259, '舞蹈排练', '2026-03-06 13:39:51');
INSERT INTO `activitytype` VALUES (1152735528093749265, '老年人健身', '2026-03-06 13:39:51');
INSERT INTO `activitytype` VALUES (1152735528093749268, '社区体育节', '2026-03-06 13:39:51');
INSERT INTO `activitytype` VALUES (1152735528093749269, '职工运动会', '2026-03-06 13:39:51');
INSERT INTO `activitytype` VALUES (1152735528093749271, '残疾人运动会', '2026-03-06 13:39:51');
INSERT INTO `activitytype` VALUES (1152735528093749274, '家庭运动会', '2026-03-06 13:39:51');
INSERT INTO `activitytype` VALUES (1152735528093749276, '体育嘉年华', '2026-03-06 13:39:51');
INSERT INTO `activitytype` VALUES (1152735528093749277, '全民健身日', '2026-03-06 13:39:51');
INSERT INTO `activitytype` VALUES (1152735528093753344, '篮球比赛', '2026-03-06 13:39:51');
INSERT INTO `activitytype` VALUES (1152735528093753350, '跑步训练', '2026-03-06 13:39:51');
INSERT INTO `activitytype` VALUES (1152735528093753354, '武术表演', '2026-03-06 13:39:51');
INSERT INTO `activitytype` VALUES (1152735528093753357, '团体操练习', '2026-03-06 13:39:51');
INSERT INTO `activitytype` VALUES (1152735528093753358, '体育讲座', '2026-03-06 13:39:51');
INSERT INTO `activitytype` VALUES (1152735528093753360, '青少年体适能', '2026-03-06 13:39:51');
INSERT INTO `activitytype` VALUES (1152735528093753362, '残疾人体育', '2026-03-06 13:39:51');
INSERT INTO `activitytype` VALUES (1152735528093753368, '学校运动会', '2026-03-06 13:39:51');
INSERT INTO `activitytype` VALUES (1152735528093753369, '企业运动会', '2026-03-06 13:39:51');
INSERT INTO `activitytype` VALUES (1152735528093753371, '趣味运动会', '2026-03-06 13:39:51');
INSERT INTO `activitytype` VALUES (1152735528093757441, '羽毛球训练', '2026-03-06 13:39:51');
INSERT INTO `activitytype` VALUES (1152735528093757447, '足球友谊赛', '2026-03-06 13:39:51');
INSERT INTO `activitytype` VALUES (1152735528093757448, '排球训练', '2026-03-06 13:39:51');
INSERT INTO `activitytype` VALUES (1152735528093757449, '网球比赛', '2026-03-06 13:39:51');
INSERT INTO `activitytype` VALUES (1152735528093757452, '健身器械使用', '2026-03-06 13:39:51');
INSERT INTO `activitytype` VALUES (1152735528093757455, '运动康复', '2026-03-06 13:39:51');
INSERT INTO `activitytype` VALUES (1152735528093757459, '校园运动会', '2026-03-06 13:39:51');
INSERT INTO `activitytype` VALUES (1152735528093757462, '老年人运动会', '2026-03-06 13:39:51');

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `userid` bigint NOT NULL COMMENT '用户id',
  `address` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '地址',
  `name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '收货人',
  `phone` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '电话',
  `isdefault` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '是否默认地址[是/否]',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2054753576882528259 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '地址' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (2029802353861689345, '2026-03-06 14:12:48', 1152735791059828739, '河北省-秦皇岛市-山海关区-地址xxx', '张三', '18888888888', '否');
INSERT INTO `address` VALUES (2054753576882528258, '2026-05-14 10:40:03', 1152735791059828742, '北京市-市辖区-东城区-1', '1', '13576747877', '否');

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户账号',
  `password` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '密码',
  `name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户姓名',
  `gender` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '性别',
  `phone` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '联系方式',
  `avatarurl` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '头像',
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `role` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '权限',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `yonghuzhanghao`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '后台管理用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', '322b8933cf6c060f9246825dbd68d10db9abb747c75e1f84b7a836ddd22bb2a9', '管理员', '男', '13823888881', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg', NULL, '0', '2026-03-06 00:00:00');
INSERT INTO `admin` VALUES (2, 'admin1', '322b8933cf6c060f9246825dbd68d10db9abb747c75e1f84b7a836ddd22bb2a9', '管理员1', '男', '13823888882', NULL, NULL, '0', '2026-05-08 18:13:11');
INSERT INTO `admin` VALUES (3, 'admin2', '322b8933cf6c060f9246825dbd68d10db9abb747c75e1f84b7a836ddd22bb2a9', '管理员2', '女', '13823888883', NULL, NULL, '0', '2026-05-08 18:15:19');

-- ----------------------------
-- Table structure for commodityclassification
-- ----------------------------
DROP TABLE IF EXISTS `commodityclassification`;
CREATE TABLE `commodityclassification`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1152735617415655449 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商品分类' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of commodityclassification
-- ----------------------------
INSERT INTO `commodityclassification` VALUES (1152735617415643140, '运动配件', '2026-03-06 13:39:56');
INSERT INTO `commodityclassification` VALUES (1152735617415643144, '运动包', '2026-03-06 13:39:56');
INSERT INTO `commodityclassification` VALUES (1152735617415643145, '运动手表', '2026-03-06 13:39:56');
INSERT INTO `commodityclassification` VALUES (1152735617415643146, '运动耳机', '2026-03-06 13:39:56');
INSERT INTO `commodityclassification` VALUES (1152735617415643150, '运动帽', '2026-03-06 13:39:56');
INSERT INTO `commodityclassification` VALUES (1152735617415643151, '运动眼镜', '2026-03-06 13:39:56');
INSERT INTO `commodityclassification` VALUES (1152735617415643152, '运动腰带', '2026-03-06 13:39:56');
INSERT INTO `commodityclassification` VALUES (1152735617415643153, '运动手套', '2026-03-06 13:39:56');
INSERT INTO `commodityclassification` VALUES (1152735617415643163, '运动护臀', '2026-03-06 13:39:56');
INSERT INTO `commodityclassification` VALUES (1152735617415643165, '运动护脚', '2026-03-06 13:39:56');
INSERT INTO `commodityclassification` VALUES (1152735617415647232, '体育用品', '2026-03-06 13:39:56');
INSERT INTO `commodityclassification` VALUES (1152735617415647252, '运动护肘', '2026-03-06 13:39:56');
INSERT INTO `commodityclassification` VALUES (1152735617415647257, '运动护胸', '2026-03-06 13:39:56');
INSERT INTO `commodityclassification` VALUES (1152735617415647258, '运动护背', '2026-03-06 13:39:56');
INSERT INTO `commodityclassification` VALUES (1152735617415647260, '运动护腿', '2026-03-06 13:39:56');
INSERT INTO `commodityclassification` VALUES (1152735617415651330, '运动服装', '2026-03-06 13:39:56');
INSERT INTO `commodityclassification` VALUES (1152735617415651333, '运动饮料', '2026-03-06 13:39:56');
INSERT INTO `commodityclassification` VALUES (1152735617415651339, '运动毛巾', '2026-03-06 13:39:56');
INSERT INTO `commodityclassification` VALUES (1152735617415651347, '运动护膝', '2026-03-06 13:39:56');
INSERT INTO `commodityclassification` VALUES (1152735617415651349, '运动护腕', '2026-03-06 13:39:56');
INSERT INTO `commodityclassification` VALUES (1152735617415651350, '运动护踝', '2026-03-06 13:39:56');
INSERT INTO `commodityclassification` VALUES (1152735617415655425, '健身器材', '2026-03-06 13:39:56');
INSERT INTO `commodityclassification` VALUES (1152735617415655427, '运动鞋', '2026-03-06 13:39:56');
INSERT INTO `commodityclassification` VALUES (1152735617415655430, '运动营养品', '2026-03-06 13:39:56');
INSERT INTO `commodityclassification` VALUES (1152735617415655431, '运动护具', '2026-03-06 13:39:56');
INSERT INTO `commodityclassification` VALUES (1152735617415655436, '运动水壶', '2026-03-06 13:39:56');
INSERT INTO `commodityclassification` VALUES (1152735617415655437, '运动袜', '2026-03-06 13:39:56');
INSERT INTO `commodityclassification` VALUES (1152735617415655442, '运动鞋垫', '2026-03-06 13:39:56');
INSERT INTO `commodityclassification` VALUES (1152735617415655447, '运动护腰', '2026-03-06 13:39:56');
INSERT INTO `commodityclassification` VALUES (1152735617415655448, '运动护肩', '2026-03-06 13:39:56');

-- ----------------------------
-- Table structure for commodityinformation
-- ----------------------------
DROP TABLE IF EXISTS `commodityinformation`;
CREATE TABLE `commodityinformation`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `classify` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属分类',
  `brand` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '品牌',
  `units` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '单位',
  `specificationsdetails` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '规格详情',
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '描述',
  `price` int NULL DEFAULT NULL COMMENT '价格',
  `photo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '封面',
  `photos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '详情图',
  `details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '详细信息',
  `adduserid` bigint NULL DEFAULT NULL COMMENT '发布人id',
  `addusername` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发布人',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1152735605872930845 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商品信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of commodityinformation
-- ----------------------------
INSERT INTO `commodityinformation` VALUES (1152735605872918530, '跑步机', '健身器材', '舒华', '台', '1.5匹马达，折叠设计', '静音设计，适合家庭使用，支持多种运动模式。', 2999, 'https://img0.baidu.com/it/u=1545544595%2C3868238751&fm=253&fmt=auto&app=138&f=JPEG?w=1778&h=800', 'https://img0.baidu.com/it/u=1782179775%2C1361710183&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=2409', '详细介绍：跑步机采用静音马达，支持多种运动模式，折叠设计节省空间，适合家庭使用。', 3, 'user002', '2026-03-06 13:39:56');
INSERT INTO `commodityinformation` VALUES (1152735605872918548, '运动护腕', '体育用品', '阿迪达斯', '个', '可调节，适合运动', '可调节，适合运动，提供手腕支撑。', 69, 'https://img0.baidu.com/it/u=3128463249%2C3930226998&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=4028', 'https://img1.baidu.com/it/u=2109553732%2C2996151438&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=2689', '详细介绍：运动护腕可调节，适合运动，提供手腕支撑。', 21, 'user011', '2026-03-06 13:39:56');
INSERT INTO `commodityinformation` VALUES (1152735605872918554, '运动护颈', '体育用品', '阿迪达斯', '个', '可调节，适合运动', '可调节，适合运动，提供颈部保护。', 69, 'https://img2.baidu.com/it/u=1734206736%2C229749012&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=664', 'https://img1.baidu.com/it/u=1088331977%2C776636980&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1112', '详细介绍：运动护颈可调节，适合运动，提供颈部保护。', 27, 'user014', '2026-03-06 13:39:56');
INSERT INTO `commodityinformation` VALUES (1152735605872918557, '运动护腿', '体育用品', '阿迪达斯', '副', '可调节，适合运动', '可调节，适合运动，提供腿部保护。', 89, 'https://img2.baidu.com/it/u=897684685%2C1893677581&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1722', 'https://img0.baidu.com/it/u=3391361624%2C3200672960&fm=253&fmt=auto&app=138&f=JPEG?w=716&h=615', '详细介绍：运动护腿可调节，适合运动，提供腿部保护。', 30, 'volunteers015', '2026-03-06 13:39:56');
INSERT INTO `commodityinformation` VALUES (1152735605872922632, '健身手套', '健身器材', '耐克', '双', '透气网眼设计', '透气网眼设计，防滑耐磨，适合力量训练。', 79, 'https://img1.baidu.com/it/u=4235493934%2C4065908190&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=790', 'https://img0.baidu.com/it/u=1782179775%2C1361710183&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=2409', '详细介绍：健身手套采用透气网眼设计，防滑耐磨，适合力量训练。', 9, 'user005', '2026-03-06 13:39:56');
INSERT INTO `commodityinformation` VALUES (1152735605872922634, '篮球架', '体育用品', '红双喜', '套', '可调节高度，适合家庭使用', '可调节高度，适合家庭使用，适合室内外场地。', 1999, 'https://img0.baidu.com/it/u=1005307839%2C1961848469&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=552', 'https://img1.baidu.com/it/u=1088331977%2C776636980&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1112', '详细介绍：篮球架采用可调节高度设计，适合家庭使用，适合室内外场地。', 11, 'user006', '2026-03-06 13:39:56');
INSERT INTO `commodityinformation` VALUES (1152735605872922637, '运动服', '体育用品', '耐克', '套', '透气材质，适合运动', '透气材质，适合运动，提供舒适体验。', 299, 'https://img0.baidu.com/it/u=1083817442%2C3036891415&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 'https://img0.baidu.com/it/u=1083817442%2C3036891415&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', '详细介绍：运动服采用透气材质，适合运动，提供舒适体验。', 14, 'volunteers007', '2026-03-06 13:39:56');
INSERT INTO `commodityinformation` VALUES (1152735605872922639, '运动袜', '体育用品', '李宁', '双', '吸汗透气，适合运动', '吸汗透气，适合运动，提供舒适体验。', 39, 'https://img0.baidu.com/it/u=4099048394%2C1850690692&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1571', 'https://img0.baidu.com/it/u=4099048394%2C1850690692&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1571', '详细介绍：运动袜采用吸汗透气材质，适合运动，提供舒适体验。', 16, 'volunteers008', '2026-03-06 13:39:56');
INSERT INTO `commodityinformation` VALUES (1152735605872922642, '运动背包', '体育用品', '李宁', '个', '大容量，适合运动', '大容量，适合运动，提供便利携带。', 199, 'https://img2.baidu.com/it/u=3723270698%2C1179772403&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=1214', 'https://img2.baidu.com/it/u=1734206736%2C229749012&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=664', '详细介绍：运动背包采用大容量设计，适合运动，提供便利携带。', 19, 'user010', '2026-03-06 13:39:56');
INSERT INTO `commodityinformation` VALUES (1152735605872922643, '运动耳机', '体育用品', '耐克', '个', '无线设计，适合运动', '无线设计，适合运动，提供清晰音质。', 299, 'https://img0.baidu.com/it/u=4156224537%2C1197201582&fm=253&fmt=auto&app=138&f=JPEG?w=667&h=500', 'https://img2.baidu.com/it/u=1032881531%2C543986297&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', '详细介绍：运动耳机采用无线设计，适合运动，提供清晰音质。', 20, 'volunteers010', '2026-03-06 13:39:56');
INSERT INTO `commodityinformation` VALUES (1152735605872922647, '运动护踝', '体育用品', '阿迪达斯', '副', '可调节，适合运动', '可调节，适合运动，提供脚踝保护。', 59, 'https://img0.baidu.com/it/u=3391361624%2C3200672960&fm=253&fmt=auto&app=138&f=JPEG?w=716&h=615', 'https://img0.baidu.com/it/u=37829530%2C2993867577&fm=253&fmt=auto&app=120&f=JPEG?w=860&h=500', '详细介绍：运动护踝可调节，适合运动，提供脚踝保护。', 24, 'volunteers012', '2026-03-06 13:39:56');
INSERT INTO `commodityinformation` VALUES (1152735605872926721, '瑜伽垫', '健身器材', '李宁', '张', '6mm厚，防滑设计', '环保材质，防滑耐用，适合各种瑜伽动作。', 89, 'https://img0.baidu.com/it/u=37829530%2C2993867577&fm=253&fmt=auto&app=120&f=JPEG?w=860&h=500', 'https://img2.baidu.com/it/u=3896740627%2C355569389&fm=253&fmt=auto&app=138&f=JPEG?w=750&h=487', '详细介绍：瑜伽垫采用TPE环保材质，厚度适中，防滑性能优异，适合各种瑜伽和健身动作。', 2, 'volunteers001', '2026-03-06 13:39:56');
INSERT INTO `commodityinformation` VALUES (1152735605872926723, '哑铃套装', '健身器材', '阿迪达斯', '套', '可调节重量，适合家庭使用', '哑铃套装，重量可调节，适合各种力量训练。', 599, 'https://img2.baidu.com/it/u=1961033900%2C1530670621&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1200', 'https://img0.baidu.com/it/u=1545544595%2C3868238751&fm=253&fmt=auto&app=138&f=JPEG?w=1778&h=800', '详细介绍：哑铃套装采用优质钢材制作，重量可调节，适合各种力量训练，是家庭健身的好帮手。', 4, 'volunteers002', '2026-03-06 13:39:56');
INSERT INTO `commodityinformation` VALUES (1152735605872926724, '羽毛球拍', '体育用品', '尤尼克斯', '副', '碳纤维材质，轻量化设计', '轻量化设计，适合专业比赛和训练使用。', 899, 'https://img1.baidu.com/it/u=2675837989%2C3036446787&fm=253&fmt=auto&app=138&f=JPEG?w=742&h=500', 'https://img1.baidu.com/it/u=1902795327%2C2564618744&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=749', '详细介绍：羽毛球拍采用碳纤维材质，轻量化设计，适合专业比赛和训练使用。', 5, 'user003', '2026-03-06 13:39:56');
INSERT INTO `commodityinformation` VALUES (1152735605872926727, '跳绳', '健身器材', '李宁', '根', '可调节长度，PVC材质', '可调节长度，PVC材质，适合有氧运动。', 39, 'https://img2.baidu.com/it/u=3833945186%2C319260251&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=750', 'https://img1.baidu.com/it/u=873001685%2C1415547548&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=2550', '详细介绍：跳绳采用PVC材质，可调节长度，适合有氧运动。', 8, 'volunteers004', '2026-03-06 13:39:56');
INSERT INTO `commodityinformation` VALUES (1152735605872926741, '运动护膝', '体育用品', '李宁', '副', '可调节，适合运动', '可调节，适合运动，提供膝盖保护。', 79, 'https://img2.baidu.com/it/u=3896740627%2C355569389&fm=253&fmt=auto&app=138&f=JPEG?w=750&h=487', 'https://img0.baidu.com/it/u=1757168073%2C2770841325&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=667', '详细介绍：运动护膝可调节，适合运动，提供膝盖保护。', 22, 'volunteers011', '2026-03-06 13:39:56');
INSERT INTO `commodityinformation` VALUES (1152735605872926744, '运动护腰', '体育用品', '李宁', '条', '可调节，适合运动', '可调节，适合运动，提供腰部支撑。', 89, 'https://img0.baidu.com/it/u=4001560020%2C227395410&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=667', 'https://img2.baidu.com/it/u=1961033900%2C1530670621&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1200', '详细介绍：运动护腰可调节，适合运动，提供腰部支撑。', 25, 'user013', '2026-03-06 13:39:56');
INSERT INTO `commodityinformation` VALUES (1152735605872926745, '运动护肩', '体育用品', '耐克', '个', '可调节，适合运动', '可调节，适合运动，提供肩部保护。', 79, 'https://img1.baidu.com/it/u=2942584263%2C2891077592&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1067', 'https://img0.baidu.com/it/u=1757168073%2C2770841325&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=667', '详细介绍：运动护肩可调节，适合运动，提供肩部保护。', 26, 'volunteers013', '2026-03-06 13:39:56');
INSERT INTO `commodityinformation` VALUES (1152735605872926747, '运动护臀', '体育用品', '李宁', '个', '可调节，适合运动', '可调节，适合运动，提供臀部保护。', 79, 'https://img0.baidu.com/it/u=1782179775%2C1361710183&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=2409', 'https://img2.baidu.com/it/u=1734206736%2C229749012&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=664', '详细介绍：运动护臀可调节，适合运动，提供臀部保护。', 28, 'volunteers014', '2026-03-06 13:39:56');
INSERT INTO `commodityinformation` VALUES (1152735605872930816, '专业篮球', '体育用品', '耐克', '个', '标准比赛用球，7号球', '采用优质皮革制作，适合专业比赛和训练使用。', 299, 'https://img0.baidu.com/it/u=1735801558%2C1521738084&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1051', 'https://img2.baidu.com/it/u=1961033900%2C1530670621&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1200', '详细介绍：这款篮球采用高级合成皮革，手感舒适，耐用性强。适用于室内外场地，是篮球爱好者的首选。', 1, 'user001', '2026-03-06 13:39:56');
INSERT INTO `commodityinformation` VALUES (1152735605872930821, '乒乓球拍', '体育用品', '红双喜', '副', '实木拍板，橡胶胶皮', '实木拍板，橡胶胶皮，适合专业比赛和训练。', 199, 'https://img1.baidu.com/it/u=287310919%2C4033385410&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1108', 'https://img1.baidu.com/it/u=2675837989%2C3036446787&fm=253&fmt=auto&app=138&f=JPEG?w=742&h=500', '详细介绍：乒乓球拍采用实木拍板和橡胶胶皮，适合专业比赛和训练。', 6, 'volunteers003', '2026-03-06 13:39:56');
INSERT INTO `commodityinformation` VALUES (1152735605872930822, '游泳镜', '体育用品', 'Speedo', '个', '防雾设计，舒适贴合', '防雾设计，舒适贴合，适合游泳训练。', 129, 'https://img2.baidu.com/it/u=1032881531%2C543986297&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 'https://img1.baidu.com/it/u=287310919%2C4033385410&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1108', '详细介绍：游泳镜采用防雾设计，舒适贴合，适合游泳训练。', 7, 'user004', '2026-03-06 13:39:56');
INSERT INTO `commodityinformation` VALUES (1152735605872930825, '运动水壶', '体育用品', '阿迪达斯', '个', '350ml，防漏设计', '350ml容量，防漏设计，适合运动时使用。', 59, 'https://img1.baidu.com/it/u=2109553732%2C2996151438&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=2689', 'https://img1.baidu.com/it/u=1902795327%2C2564618744&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=749', '详细介绍：运动水壶采用防漏设计，适合运动时使用。', 10, 'volunteers005', '2026-03-06 13:39:56');
INSERT INTO `commodityinformation` VALUES (1152735605872930827, '跑步机配件', '健身器材', '舒华', '套', '跑步机专用配件', '跑步机专用配件，包括跑带、电机等。', 299, 'https://img2.baidu.com/it/u=4241480548%2C4100945626&fm=253&fmt=auto&app=138&f=JPEG?w=708&h=500', 'https://img0.baidu.com/it/u=1735801558%2C1521738084&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1051', '详细介绍：跑步机专用配件，包括跑带、电机等，确保跑步机正常运行。', 12, 'volunteers006', '2026-03-06 13:39:56');
INSERT INTO `commodityinformation` VALUES (1152735605872930828, '瑜伽球', '健身器材', '李宁', '个', '65cm直径，防滑设计', '65cm直径，防滑设计，适合瑜伽和核心训练。', 149, 'https://img1.baidu.com/it/u=1902795327%2C2564618744&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=749', 'https://img2.baidu.com/it/u=1032881531%2C543986297&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', '详细介绍：瑜伽球采用防滑设计，适合瑜伽和核心训练。', 13, 'user007', '2026-03-06 13:39:56');
INSERT INTO `commodityinformation` VALUES (1152735605872930830, '运动鞋', '体育用品', '阿迪达斯', '双', '轻量化设计，适合跑步', '轻量化设计，适合跑步，提供良好支撑。', 599, 'https://img0.baidu.com/it/u=853937590%2C1697710826&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 'https://img0.baidu.com/it/u=4001560020%2C227395410&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=667', '详细介绍：运动鞋采用轻量化设计，适合跑步，提供良好支撑。', 15, 'user008', '2026-03-06 13:39:56');
INSERT INTO `commodityinformation` VALUES (1152735605872930832, '健身腰带', '健身器材', '耐克', '条', '可调节，适合力量训练', '可调节，适合力量训练，提供腰部支撑。', 199, 'https://img0.baidu.com/it/u=3308863920%2C2685546000&fm=253&fmt=auto&app=120&f=JPEG?w=1187&h=500', 'https://img2.baidu.com/it/u=3896740627%2C355569389&fm=253&fmt=auto&app=138&f=JPEG?w=750&h=487', '详细介绍：健身腰带可调节，适合力量训练，提供腰部支撑。', 17, 'user009', '2026-03-06 13:39:56');
INSERT INTO `commodityinformation` VALUES (1152735605872930833, '运动毛巾', '体育用品', '阿迪达斯', '条', '吸汗速干，适合运动', '吸汗速干，适合运动，提供舒适体验。', 49, 'https://img1.baidu.com/it/u=1088331977%2C776636980&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1112', 'https://img0.baidu.com/it/u=1735801558%2C1521738084&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1051', '详细介绍：运动毛巾采用吸汗速干材质，适合运动，提供舒适体验。', 18, 'volunteers009', '2026-03-06 13:39:56');
INSERT INTO `commodityinformation` VALUES (1152735605872930838, '运动护肘', '体育用品', '耐克', '副', '可调节，适合运动', '可调节，适合运动，提供肘部保护。', 69, 'https://img1.baidu.com/it/u=873001685%2C1415547548&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=2550', 'https://img2.baidu.com/it/u=3833945186%2C319260251&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=750', '详细介绍：运动护肘可调节，适合运动，提供肘部保护。', 23, 'user012', '2026-03-06 13:39:56');
INSERT INTO `commodityinformation` VALUES (1152735605872930844, '运动护胸', '体育用品', '耐克', '个', '可调节，适合运动', '可调节，适合运动，提供胸部保护。', 69, 'https://img0.baidu.com/it/u=1757168073%2C2770841325&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=667', 'https://img0.baidu.com/it/u=4099048394%2C1850690692&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1571', '详细介绍：运动护胸可调节，适合运动，提供胸部保护。', 29, 'user015', '2026-03-06 13:39:56');

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '配置参数名称',
  `value` varchar(1500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '配置参数值',
  `addtime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2042499530192826371 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '配置文件' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of config
-- ----------------------------
INSERT INTO `config` VALUES (2042499479366250497, 'ca140cfc5974fbb9f146f06baf3bfce3.jpeg', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54398.jpeg', '2026-04-10 15:06:38');
INSERT INTO `config` VALUES (2042499530192826370, 'PNG.png', 'api/upload/PNG_54410.png', '2026-04-10 15:06:50');

-- ----------------------------
-- Table structure for discuss
-- ----------------------------
DROP TABLE IF EXISTS `discuss`;
CREATE TABLE `discuss`  (
  `id` bigint NOT NULL,
  `refid` bigint NOT NULL COMMENT '关联表id',
  `userid` bigint NOT NULL COMMENT '用户id',
  `avatarurl` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '头像',
  `nickname` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '用户名',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '评论内容',
  `parent_id` bigint NULL DEFAULT NULL COMMENT '父id',
  `likes_count` int NULL DEFAULT NULL COMMENT '点赞数量',
  `create_time` timestamp NOT NULL COMMENT '创建时间',
  `picture` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片',
  `star` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '星级',
  `display` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否显示',
  `video` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '视频',
  `refuserid` bigint NULL DEFAULT NULL COMMENT '关联用户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '评论表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of discuss
-- ----------------------------
INSERT INTO `discuss` VALUES (1152735577032884229, 1, 6, 'https://img2.baidu.com/it/u=534162264%2C3559376102&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=707', 'user006', '整体体验不错，下次还会再来。', NULL, 18, '2026-03-06 13:39:54', 'https://img2.baidu.com/it/u=534162264%2C3559376102&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=707', '5', '是', '1', 7);
INSERT INTO `discuss` VALUES (1152735577032884232, 1, 9, 'https://img1.baidu.com/it/u=1938507704%2C3098018985&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=725', 'user009', '更衣室卫生条件有待改善。', NULL, 4, '2026-03-06 13:39:54', 'https://img1.baidu.com/it/u=1938507704%2C3098018985&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=725', '2', '是', '1', 10);
INSERT INTO `discuss` VALUES (1152735577032884239, 1, 16, 'https://img0.baidu.com/it/u=3405653906%2C95338805&fm=253&fmt=auto&app=120&f=JPEG?w=800&h=1015', 'user016', '价格偏高，性价比一般。', NULL, 7, '2026-03-06 13:39:54', 'https://img0.baidu.com/it/u=3405653906%2C95338805&fm=253&fmt=auto&app=120&f=JPEG?w=800&h=1015', '3', '是', '1', 17);
INSERT INTO `discuss` VALUES (1152735577032884252, 1, 29, 'https://img0.baidu.com/it/u=4028207874%2C3909854039&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=707', 'user029', '周边环境嘈杂，影响运动体验。', NULL, 3, '2026-03-06 13:39:54', 'https://img0.baidu.com/it/u=4028207874%2C3909854039&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=707', '2', '是', '1', 30);
INSERT INTO `discuss` VALUES (1152735577032884253, 1, 30, 'https://img2.baidu.com/it/u=3806299481%2C2493834394&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1250', 'user030', '整体评价较高，推荐大家来体验。', NULL, 19, '2026-03-06 13:39:54', 'https://img2.baidu.com/it/u=3806299481%2C2493834394&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1250', '5', '是', '1', 1);
INSERT INTO `discuss` VALUES (1152735577032888324, 1, 5, 'https://img1.baidu.com/it/u=857497526%2C2402760230&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=668', 'user005', '设备有些旧了，需要更新。', NULL, 6, '2026-03-06 13:39:54', 'https://img1.baidu.com/it/u=857497526%2C2402760230&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=668', '3', '是', '1', 6);
INSERT INTO `discuss` VALUES (1152735577032888330, 1, 11, 'https://img0.baidu.com/it/u=2795338382%2C430191394&fm=253&fmt=auto&app=138&f=JPEG?w=707&h=500', 'user011', '音响效果不错，适合举办活动。', NULL, 9, '2026-03-06 13:39:54', 'https://img0.baidu.com/it/u=2795338382%2C430191394&fm=253&fmt=auto&app=138&f=JPEG?w=707&h=500', '4', '是', '1', 12);
INSERT INTO `discuss` VALUES (1152735577032888331, 1, 12, 'https://img0.baidu.com/it/u=2064114293%2C4280249887&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=506', 'user012', '预约系统经常卡顿，希望改进。', NULL, 3, '2026-03-06 13:39:54', 'https://img0.baidu.com/it/u=2064114293%2C4280249887&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=506', '2', '是', '1', 13);
INSERT INTO `discuss` VALUES (1152735577032888343, 1, 24, 'https://img0.baidu.com/it/u=2839261401%2C2639571878&fm=253&fmt=auto&app=138&f=JPEG?w=603&h=592', 'user024', '地理位置好，靠近地铁站。', NULL, 15, '2026-03-06 13:39:54', 'https://img0.baidu.com/it/u=2839261401%2C2639571878&fm=253&fmt=auto&app=138&f=JPEG?w=603&h=592', '5', '是', '1', 25);
INSERT INTO `discuss` VALUES (1152735577032888345, 1, 26, 'https://img0.baidu.com/it/u=785347992%2C1531285458&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1069', 'user026', '通风系统需要加强，夏天闷热。', NULL, 6, '2026-03-06 13:39:54', 'https://img0.baidu.com/it/u=785347992%2C1531285458&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1069', '3', '是', '1', 27);
INSERT INTO `discuss` VALUES (1152735577032892419, 1, 4, 'https://img0.baidu.com/it/u=730125516%2C1343510347&fm=253&fmt=auto&app=138&f=JPEG?w=959&h=800', 'user004', '停车方便，工作人员态度友好。', NULL, 12, '2026-03-06 13:39:54', 'https://img0.baidu.com/it/u=730125516%2C1343510347&fm=253&fmt=auto&app=138&f=JPEG?w=959&h=800', '5', '是', '1', 5);
INSERT INTO `discuss` VALUES (1152735577032892422, 1, 7, 'https://img0.baidu.com/it/u=2552997716%2C641048984&fm=253&fmt=auto&app=120&f=JPEG?w=800&h=987', 'user007', '空气流通一般，人多的时候有点闷。', NULL, 5, '2026-03-06 13:39:54', 'https://img0.baidu.com/it/u=2552997716%2C641048984&fm=253&fmt=auto&app=120&f=JPEG?w=800&h=987', '3', '是', '1', 8);
INSERT INTO `discuss` VALUES (1152735577032892430, 1, 15, 'https://img0.baidu.com/it/u=1072974488%2C2587958220&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=808', 'user015', '儿童区域安全设施到位，家长放心。', NULL, 13, '2026-03-06 13:39:54', 'https://img0.baidu.com/it/u=1072974488%2C2587958220&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=808', '5', '是', '1', 16);
INSERT INTO `discuss` VALUES (1152735577032892433, 1, 18, 'https://img0.baidu.com/it/u=330171995%2C3376559340&fm=253&fmt=auto&app=120&f=JPEG?w=407&h=169', 'user018', '场地较大，但指示牌不够清晰。', NULL, 6, '2026-03-06 13:39:54', 'https://img0.baidu.com/it/u=330171995%2C3376559340&fm=253&fmt=auto&app=120&f=JPEG?w=407&h=169', '3', '是', '1', 19);
INSERT INTO `discuss` VALUES (1152735577032892434, 1, 19, 'https://img2.baidu.com/it/u=93968852%2C2520230054&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=707', 'user019', '经常有优惠活动，很实惠。', NULL, 12, '2026-03-06 13:39:54', 'https://img2.baidu.com/it/u=93968852%2C2520230054&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=707', '4', '是', '1', 20);
INSERT INTO `discuss` VALUES (1152735577032892436, 1, 21, 'https://img1.baidu.com/it/u=2678026349%2C3297816220&fm=253&fmt=auto&app=120&f=JPEG?w=800&h=1044', 'user021', '卫生状况良好，定期清洁。', NULL, 14, '2026-03-06 13:39:54', 'https://img1.baidu.com/it/u=2678026349%2C3297816220&fm=253&fmt=auto&app=120&f=JPEG?w=800&h=1044', '5', '是', '1', 22);
INSERT INTO `discuss` VALUES (1152735577032896512, 1, 1, 'https://img2.baidu.com/it/u=3869421941%2C1933590836&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1297', 'user001', '这个体育馆设施很完善，服务态度也很好！', NULL, 15, '2026-03-06 13:39:54', 'https://img2.baidu.com/it/u=3869421941%2C1933590836&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1297', '5', '是', '1', 2);
INSERT INTO `discuss` VALUES (1152735577032896513, 1, 2, 'https://img0.baidu.com/it/u=2069770673%2C528725172&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=707', 'user002', '场地干净，灯光不错，值得推荐。', NULL, 10, '2026-03-06 13:39:54', 'https://img0.baidu.com/it/u=2069770673%2C528725172&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=707', '4', '是', '1', 3);
INSERT INTO `discuss` VALUES (1152735577032896514, 1, 3, 'https://img1.baidu.com/it/u=1354005208%2C3894412961&fm=253&fmt=auto&app=120&f=JPEG?w=800&h=1047', 'user003', '价格有点贵，但环境确实好。', NULL, 8, '2026-03-06 13:39:54', 'https://img1.baidu.com/it/u=1354005208%2C3894412961&fm=253&fmt=auto&app=120&f=JPEG?w=800&h=1047', '4', '是', '1', 4);
INSERT INTO `discuss` VALUES (1152735577032896519, 1, 8, 'https://img0.baidu.com/it/u=318789455%2C2220586973&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1107', 'user008', '教练专业，课程安排合理。', NULL, 20, '2026-03-06 13:39:54', 'https://img0.baidu.com/it/u=318789455%2C2220586973&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1107', '5', '是', '1', 9);
INSERT INTO `discuss` VALUES (1152735577032896521, 1, 10, 'https://img0.baidu.com/it/u=4200792817%2C3252452260&fm=253&fmt=auto&app=138&f=JPEG?w=707&h=500', 'user010', '交通便利，周边餐饮配套齐全。', NULL, 14, '2026-03-06 13:39:54', 'https://img0.baidu.com/it/u=4200792817%2C3252452260&fm=253&fmt=auto&app=138&f=JPEG?w=707&h=500', '4', '是', '1', 11);
INSERT INTO `discuss` VALUES (1152735577032896524, 1, 13, 'https://img1.baidu.com/it/u=3978766244%2C1372897194&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=707', 'user013', '水质很好，游泳池很干净。', NULL, 16, '2026-03-06 13:39:54', 'https://img1.baidu.com/it/u=3978766244%2C1372897194&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=707', '5', '是', '1', 14);
INSERT INTO `discuss` VALUES (1152735577032896525, 1, 14, 'https://img0.baidu.com/it/u=811559953%2C3676565414&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1069', 'user014', '开放时间较长，适合上班族。', NULL, 11, '2026-03-06 13:39:54', 'https://img0.baidu.com/it/u=811559953%2C3676565414&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1069', '4', '是', '1', 15);
INSERT INTO `discuss` VALUES (1152735577032896528, 1, 17, 'https://img0.baidu.com/it/u=277673439%2C1649037240&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1269', 'user017', '工作人员热情，解答问题很耐心。', NULL, 17, '2026-03-06 13:39:54', 'https://img0.baidu.com/it/u=277673439%2C1649037240&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1269', '5', '是', '1', 18);
INSERT INTO `discuss` VALUES (1152735577032896531, 1, 20, 'https://img1.baidu.com/it/u=2584243714%2C3553601571&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1271', 'user020', '音响设备偶尔有杂音。', NULL, 5, '2026-03-06 13:39:54', 'https://img1.baidu.com/it/u=2584243714%2C3553601571&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1271', '3', '是', '1', 21);
INSERT INTO `discuss` VALUES (1152735577032896533, 1, 22, 'https://img2.baidu.com/it/u=1695306320%2C1926982674&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=707', 'user022', '适合团队训练，空间宽敞。', NULL, 10, '2026-03-06 13:39:54', 'https://img2.baidu.com/it/u=1695306320%2C1926982674&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=707', '4', '是', '1', 23);
INSERT INTO `discuss` VALUES (1152735577032896534, 1, 23, 'https://img2.baidu.com/it/u=581302307%2C1603583462&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=658', 'user023', '灯光太亮，影响打球体验。', NULL, 4, '2026-03-06 13:39:54', 'https://img2.baidu.com/it/u=581302307%2C1603583462&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=658', '2', '是', '1', 24);
INSERT INTO `discuss` VALUES (1152735577032896536, 1, 25, 'https://t13.baidu.com/it/u=472029912%2C3804784203&fm=224&app=112&f=JPEG?w=500&h=500', 'user025', '会员制度灵活，性价比高。', NULL, 11, '2026-03-06 13:39:54', 'https://t13.baidu.com/it/u=472029912%2C3804784203&fm=224&app=112&f=JPEG?w=500&h=500', '4', '是', '1', 26);
INSERT INTO `discuss` VALUES (1152735577032896538, 1, 27, 'https://img1.baidu.com/it/u=3929807081%2C1720622562&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1122', 'user027', '服务态度好，响应及时。', NULL, 13, '2026-03-06 13:39:54', 'https://img1.baidu.com/it/u=3929807081%2C1720622562&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1122', '5', '是', '1', 28);
INSERT INTO `discuss` VALUES (1152735577032896539, 1, 28, 'https://img2.baidu.com/it/u=1132927144%2C1906798533&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1058', 'user028', '设备维护及时，故障率低。', NULL, 9, '2026-03-06 13:39:54', 'https://img2.baidu.com/it/u=1132927144%2C1906798533&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1058', '4', '是', '1', 29);
INSERT INTO `discuss` VALUES (2055914999687909378, 1152735577032884232, 1, 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg', '管理员', '1', 1152735577032884232, 0, '2026-05-17 15:35:08', NULL, NULL, 'true', NULL, NULL);

-- ----------------------------
-- Table structure for equipment
-- ----------------------------
DROP TABLE IF EXISTS `equipment`;
CREATE TABLE `equipment`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '器材名称',
  `classify` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '器材分类',
  `equipmentno` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '器材编号',
  `brand` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '品牌',
  `model` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '型号',
  `purchasedate` timestamp NULL DEFAULT NULL COMMENT '购买日期',
  `warrantyenddate` timestamp NULL DEFAULT NULL COMMENT '保修截止日期',
  `status` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '器材状态',
  `location` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '存放位置',
  `price` double NULL DEFAULT NULL COMMENT '单价',
  `quantity` int NULL DEFAULT NULL COMMENT '数量',
  `borrowedquantity` int NULL DEFAULT NULL COMMENT '已借数量',
  `remainingquantity` int NULL DEFAULT NULL COMMENT '剩余数量',
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '器材描述',
  `photo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '封面图片',
  `adduserid` bigint NULL DEFAULT NULL COMMENT '创建人id',
  `addusername` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人名称',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2049059853829914626 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '器材信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of equipment
-- ----------------------------
INSERT INTO `equipment` VALUES (2048734678148157441, '羽毛球', '球', '01', '01', '01', '2026-04-01 00:00:00', '2026-04-01 00:00:00', '正常', '器材室1-2-1', 11, 10, 1, 9, '羽毛球', 'api/upload/羽毛球_63051.jpg', 1, '管理员', '2026-04-27 20:03:06');
INSERT INTO `equipment` VALUES (2048746930926469122, '乒乓球', '球', '2', '01', '1', '2026-04-02 00:00:00', '2026-04-02 00:00:00', '正常', '器材室1-1-1', 11, 11, 1, 10, '好用', 'api/upload/乒乓球_63039.jpg', 1, '管理员', '2026-04-27 20:51:47');
INSERT INTO `equipment` VALUES (2049059853829914625, '羽毛球拍', '球拍', '1', '11', '11', '2026-04-01 00:00:00', '2026-04-01 00:00:00', '正常', '器材室1-2-2', 80, 10, 0, 10, '好用', 'api/upload/羽毛球拍_63311.webp', 1, '管理员', '2026-04-28 17:35:14');

-- ----------------------------
-- Table structure for equipment_rental
-- ----------------------------
DROP TABLE IF EXISTS `equipment_rental`;
CREATE TABLE `equipment_rental`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `equipmentid` bigint NULL DEFAULT NULL COMMENT '器材id',
  `equipmentname` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '器材名称',
  `userid` bigint NULL DEFAULT NULL COMMENT '租借人id',
  `username` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '租借人名称',
  `quantity` int NULL DEFAULT NULL COMMENT '租借数量',
  `rentaltime` timestamp NULL DEFAULT NULL COMMENT '租借时间',
  `expectedreturntime` timestamp NULL DEFAULT NULL COMMENT '预计归还时间',
  `actualreturntime` timestamp NULL DEFAULT NULL COMMENT '实际归还时间',
  `status` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '租借状态',
  `approvalstatus` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审批状态',
  `remark` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '备注',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `approvalremark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审批回复',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2049395938837540867 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '器材租借' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of equipment_rental
-- ----------------------------
INSERT INTO `equipment_rental` VALUES (2049055223230218242, 2048734678148157441, '羽毛球', 1152735791059828742, '周丽', 1, '2026-04-28 17:16:49', '2026-04-30 00:00:00', NULL, '待审批', '待审批', NULL, '2026-04-28 17:16:49', NULL);
INSERT INTO `equipment_rental` VALUES (2049063096924487681, 2049059853829914625, '羽毛球拍', 1152735791059828742, '周丽', 2, '2026-04-28 17:48:07', '2026-04-29 00:00:00', '2026-04-28 17:48:28', '已归还', '已通过', NULL, '2026-04-28 17:48:07', '器材租借审批通过，请按时归还。');
INSERT INTO `equipment_rental` VALUES (2049080931352559617, 2048734678148157441, '羽毛球', 1152735791059828742, '周丽', 1, '2026-04-28 18:58:59', '2026-04-28 18:58:40', NULL, '待审批', '待审批', '速度', '2026-04-28 18:58:59', NULL);

-- ----------------------------
-- Table structure for eventinformation
-- ----------------------------
DROP TABLE IF EXISTS `eventinformation`;
CREATE TABLE `eventinformation`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '赛事名称',
  `classify` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '赛事类型',
  `theleveloftheevent` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '赛事级别',
  `venue` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '举办地点',
  `holdingdate` timestamp NULL DEFAULT NULL COMMENT '举办日期',
  `competitiontime` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '比赛时间',
  `totheschedule` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '赛程安排',
  `rulesandbackground` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '规则与背景',
  `photo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '封面',
  `photos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '详情图',
  `adduserid` bigint NULL DEFAULT NULL COMMENT '创建人id',
  `addusername` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人名称',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1152735647228768286 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '赛事信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of eventinformation
-- ----------------------------
INSERT INTO `eventinformation` VALUES (1152735647228755968, '2023年全国青少年羽毛球锦标赛', '羽毛球', '国家级', '北京体育馆', '2026-03-06 13:39:58', '2023-08-15 09:00:00', '小组赛:8月15日-17日，淘汰赛:8月18日-20日', '比赛采用中国羽毛球协会最新规则，旨在推动青少年羽毛球运动发展。', 'https://img2.baidu.com/it/u=2483220259%2C337689308&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=667', 'https://img0.baidu.com/it/u=3963971826%2C2766099680&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1030', 1, 'user001', '2026-03-06 13:39:58');
INSERT INTO `eventinformation` VALUES (1152735647228755971, '2023年全国游泳冠军赛', '游泳', '国家级', '深圳体育馆', '2026-03-06 13:39:58', '2023-06-10 08:00:00', '预赛:6月10日-12日，决赛:6月13日-15日', '比赛采用国际泳联最新规则，设有自由泳、仰泳、蛙泳、蝶泳四个泳姿的多个项目。', 'https://img2.baidu.com/it/u=3152444004%2C3382229529&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=947', 'https://img2.baidu.com/it/u=2486263115%2C1854423853&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=850', 4, 'volunteers003', '2026-03-06 13:39:58');
INSERT INTO `eventinformation` VALUES (1152735647228755972, '2023年城市马拉松赛', '马拉松', '市级', '杭州体育馆', '2026-03-06 13:39:58', '2023-05-20 06:00:00', '全程马拉松:5月20日06:00-12:00，半程马拉松:5月20日06:30-11:00', '比赛采用中国田径协会最新规则，设有全程马拉松和半程马拉松两个项目。', 'https://img0.baidu.com/it/u=2673673056%2C2727029773&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=665', 'https://img2.baidu.com/it/u=3956987237%2C4265460618&fm=253&fmt=auto&app=138&f=JPEG?w=905&h=800', 5, 'volunteers004', '2026-03-06 13:39:58');
INSERT INTO `eventinformation` VALUES (1152735647228755973, '2023年全国体操锦标赛', '体操', '国家级', '南京体育馆', '2026-03-06 13:39:58', '2023-08-25 13:00:00', '团体赛:8月25日-27日，个人赛:8月28日-30日', '比赛采用国际体操联合会最新规则，设有自由体操、鞍马、吊环、跳马、双杠、单杠六个项目。', 'https://img2.baidu.com/it/u=2709272340%2C1054865518&fm=253&fmt=auto&app=138&f=JPEG?w=1207&h=520', 'https://img2.baidu.com/it/u=2483220259%2C337689308&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=667', 6, 'volunteers005', '2026-03-06 13:39:58');
INSERT INTO `eventinformation` VALUES (1152735647228755974, '2023年城市网球公开赛', '网球', '市级', '成都体育馆', '2026-03-06 13:39:58', '2023-07-15 11:00:00', '单打赛:7月15日-17日，双打赛:7月18日-20日', '比赛采用国际网球联合会最新规则，设有男子单打、女子单打、男子双打、女子双打四个项目。', 'https://img1.baidu.com/it/u=2384604556%2C3191166193&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=756', 'https://img2.baidu.com/it/u=601450137%2C2380309720&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=598', 7, 'volunteers006', '2026-03-06 13:39:58');
INSERT INTO `eventinformation` VALUES (1152735647228755979, '2023年全国射击锦标赛', '射击', '国家级', '沈阳体育馆', '2026-03-06 13:39:58', '2023-09-15 09:00:00', '10米气步枪:9月15日09:00-10:00，10米气手枪:9月15日10:30-11:30', '比赛采用国际射击运动联合会最新规则，设有10米气步枪、10米气手枪、25米手枪、50米手枪、10米气步枪团体、10米气手枪团体六个项目。', 'https://img2.baidu.com/it/u=3093825138%2C3934871004&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=599', 'https://img1.baidu.com/it/u=2384604556%2C3191166193&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=756', 12, 'volunteers011', '2026-03-06 13:39:58');
INSERT INTO `eventinformation` VALUES (1152735647228755986, '2023年城市壁球赛', '壁球', '市级', '无锡体育馆', '2026-03-06 13:39:58', '2023-07-10 14:00:00', '男子单打:7月10日-12日，女子单打:7月13日-15日', '比赛采用国际壁球联合会最新规则，设有男子单打、女子单打、男子双打、女子双打、混合双打五个项目。', 'https://img2.baidu.com/it/u=3956987237%2C4265460618&fm=253&fmt=auto&app=138&f=JPEG?w=905&h=800', 'https://img1.baidu.com/it/u=2903564822%2C461880882&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=2530', 19, 'volunteers018', '2026-03-06 13:39:58');
INSERT INTO `eventinformation` VALUES (1152735647228755989, '2023年全国蹦床锦标赛', '蹦床', '国家级', '郑州体育馆', '2026-03-06 13:39:58', '2023-08-15 13:00:00', '个人蹦床:8月15日-17日，双人蹦床:8月18日-20日', '比赛采用国际体操联合会最新规则，设有个人蹦床和双人蹦床两个项目。', 'https://img1.baidu.com/it/u=3491022972%2C1144409359&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=2586', 'https://img1.baidu.com/it/u=1647139064%2C604948431&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=3018', 22, 'volunteers021', '2026-03-06 13:39:58');
INSERT INTO `eventinformation` VALUES (1152735647228755992, '2023年城市手球赛', '手球', '市级', '南宁体育馆', '2026-03-06 13:39:58', '2023-06-25 14:00:00', '小组赛:6月25日-27日，淘汰赛:6月28日-30日', '比赛采用国际手球联合会最新规则，设有男子手球和女子手球两个项目。', 'https://img0.baidu.com/it/u=1782179775%2C1361710183&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=2409', 'https://img2.baidu.com/it/u=462234781%2C403618188&fm=253&fmt=auto&app=138&f=JPEG?w=1422&h=800', 25, 'volunteers024', '2026-03-06 13:39:58');
INSERT INTO `eventinformation` VALUES (1152735647228760066, '2023年省级乒乓球锦标赛', '乒乓球', '省级', '广州体育馆', '2026-03-06 13:39:58', '2023-09-05 10:00:00', '预选赛:9月5日-7日，决赛:9月8日-10日', '比赛采用国际乒联最新规则，设有男子单打、女子单打、男子双打、女子双打和混合双打五个项目。', 'https://img1.baidu.com/it/u=2791587786%2C2135478060&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=889', 'https://img2.baidu.com/it/u=3625623058%2C199338878&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=809', 3, 'volunteers002', '2026-03-06 13:39:58');
INSERT INTO `eventinformation` VALUES (1152735647228760071, '2023年全国举重锦标赛', '举重', '国家级', '武汉体育馆', '2026-03-06 13:39:58', '2023-09-10 09:00:00', '抓举:9月10日09:00-10:00，挺举:9月10日10:30-12:00', '比赛采用国际举重联合会最新规则，设有男子56公斤级、62公斤级、69公斤级、77公斤级、85公斤级、94公斤级、105公斤级和105公斤以上级八个级别。', 'https://img2.baidu.com/it/u=601450137%2C2380309720&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=598', 'https://img2.baidu.com/it/u=902504652%2C2591253129&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1087', 8, 'volunteers007', '2026-03-06 13:39:58');
INSERT INTO `eventinformation` VALUES (1152735647228760073, '2023年全国摔跤锦标赛', '摔跤', '国家级', '天津体育馆', '2026-03-06 13:39:58', '2023-08-05 10:00:00', '古典式摔跤:8月5日-7日，自由式摔跤:8月8日-10日', '比赛采用国际摔跤联合会最新规则，设有古典式摔跤和自由式摔跤两个项目。', 'https://img2.baidu.com/it/u=2366903585%2C4013341484&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1344', 'https://img2.baidu.com/it/u=3152444004%2C3382229529&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=947', 10, 'volunteers009', '2026-03-06 13:39:58');
INSERT INTO `eventinformation` VALUES (1152735647228760077, '2023年全国柔道锦标赛', '柔道', '国家级', '济南体育馆', '2026-03-06 13:39:58', '2023-08-10 10:00:00', '男子柔道:8月10日-12日，女子柔道:8月13日-15日', '比赛采用国际柔道联合会最新规则，设有男子柔道和女子柔道两个项目。', 'https://img2.baidu.com/it/u=196152618%2C3835734358&fm=253&fmt=auto&app=120&f=JPEG?w=645&h=500', 'https://img0.baidu.com/it/u=2673673056%2C2727029773&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=665', 14, 'volunteers013', '2026-03-06 13:39:58');
INSERT INTO `eventinformation` VALUES (1152735647228760087, '2023年全国射箭锦标赛', '射箭', '国家级', '贵阳体育馆', '2026-03-06 13:39:58', '2023-09-10 10:00:00', '个人赛:9月10日-12日，团体赛:9月13日-15日', '比赛采用国际射箭联合会最新规则，设有个人赛和团体赛两个项目。', 'https://img2.baidu.com/it/u=3723270698%2C1179772403&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=1214', 'https://img1.baidu.com/it/u=3491022972%2C1144409359&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=2586', 24, 'volunteers023', '2026-03-06 13:39:58');
INSERT INTO `eventinformation` VALUES (1152735647228760089, '2023年全国马术锦标赛', '马术', '国家级', '海口体育馆', '2026-03-06 13:39:58', '2023-08-25 09:00:00', '障碍赛:8月25日-27日，盛装舞步:8月28日-30日', '比赛采用国际马术联合会最新规则，设有障碍赛和盛装舞步两个项目。', 'https://img1.baidu.com/it/u=3257401205%2C2328495407&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=2735', 'https://img1.baidu.com/it/u=1647139064%2C604948431&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=3018', 26, 'volunteers025', '2026-03-06 13:39:58');
INSERT INTO `eventinformation` VALUES (1152735647228764172, '2023年城市击剑赛', '击剑', '市级', '青岛体育馆', '2026-03-06 13:39:58', '2023-06-20 13:00:00', '花剑:6月20日-22日，重剑:6月23日-25日', '比赛采用国际击剑联合会最新规则，设有花剑、重剑、佩剑三个剑种。', 'https://img1.baidu.com/it/u=2406014003%2C1230810135&fm=253&fmt=auto&app=138&f=JPEG?w=708&h=500', 'https://img2.baidu.com/it/u=3625623058%2C199338878&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=809', 13, 'volunteers012', '2026-03-06 13:39:58');
INSERT INTO `eventinformation` VALUES (1152735647228764175, '2023年全国皮划艇锦标赛', '皮划艇', '国家级', '厦门体育馆', '2026-03-06 13:39:58', '2023-09-05 08:00:00', '静水:9月5日-7日，激流:9月8日-10日', '比赛采用国际皮划艇联合会最新规则，设有静水和激流两个项目。', 'https://img2.baidu.com/it/u=3465603103%2C3945071897&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1016', 'https://img2.baidu.com/it/u=2483220259%2C337689308&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=667', 16, 'volunteers015', '2026-03-06 13:39:58');
INSERT INTO `eventinformation` VALUES (1152735647228764177, '2023年全国空手道锦标赛', '空手道', '国家级', '福州体育馆', '2026-03-06 13:39:58', '2023-08-20 11:00:00', '个人型:8月20日-22日，个人组手:8月23日-25日', '比赛采用国际空手道联合会最新规则，设有个人型和个人组手两个项目。', 'https://img1.baidu.com/it/u=2212428827%2C1136291960&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1733', 'https://img2.baidu.com/it/u=3465603103%2C3945071897&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1016', 18, 'volunteers017', '2026-03-06 13:39:58');
INSERT INTO `eventinformation` VALUES (1152735647228764180, '2023年城市铁人三项赛', '铁人三项', '市级', '长沙体育馆', '2026-03-06 13:39:58', '2023-06-30 07:00:00', '游泳:6月30日07:00-08:00，自行车:6月30日08:30-10:30', '比赛采用国际铁人三项联盟最新规则，设有游泳、自行车和跑步三个项目。', 'https://img0.baidu.com/it/u=52438547%2C1810529324&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=1620', 'https://img2.baidu.com/it/u=462234781%2C403618188&fm=253&fmt=auto&app=138&f=JPEG?w=1422&h=800', 21, 'volunteers020', '2026-03-06 13:39:58');
INSERT INTO `eventinformation` VALUES (1152735647228764186, '2023年城市拳击赛', '拳击', '市级', '太原体育馆', '2026-03-06 13:39:58', '2023-07-15 12:00:00', '轻量级:7月15日-17日，中量级:7月18日-20日', '比赛采用国际拳击联合会最新规则，设有轻量级、中量级、重量级等多个级别。', 'https://img2.baidu.com/it/u=3625623058%2C199338878&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=809', 'https://img2.baidu.com/it/u=3152444004%2C3382229529&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=947', 27, 'volunteers026', '2026-03-06 13:39:58');
INSERT INTO `eventinformation` VALUES (1152735647228764187, '2023年全国跆拳道锦标赛', '跆拳道', '国家级', '兰州体育馆', '2026-03-06 13:39:58', '2023-09-05 11:00:00', '男子跆拳道:9月05日-07日，女子跆拳道:9月08日-10日', '比赛采用国际跆拳道联合会最新规则，设有男子跆拳道和女子跆拳道两个项目。', 'https://img2.baidu.com/it/u=2486263115%2C1854423853&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=850', 'https://img1.baidu.com/it/u=2903564822%2C461880882&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=2530', 28, 'volunteers027', '2026-03-06 13:39:58');
INSERT INTO `eventinformation` VALUES (1152735647228768257, '2023年城市篮球联赛', '篮球', '市级', '上海体育馆', '2026-03-06 13:39:58', '2023-07-20 14:00:00', '常规赛:7月20日-8月10日，季后赛:8月15日-8月25日', '比赛采用FIBA最新规则，每队12人，分常规赛和季后赛两个阶段。', 'https://img1.baidu.com/it/u=2903564822%2C461880882&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=2530', 'https://img2.baidu.com/it/u=3625623058%2C199338878&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=809', 2, 'volunteers001', '2026-03-06 13:39:58');
INSERT INTO `eventinformation` VALUES (1152735647228768264, '2023年城市自行车赛', '自行车', '市级', '西安体育馆', '2026-03-06 13:39:58', '2023-06-25 07:00:00', '公路赛:6月25日07:00-15:00，场地赛:6月25日16:00-18:00', '比赛采用国际自行车联盟最新规则，设有公路赛和场地赛两个项目。', 'https://img2.baidu.com/it/u=462234781%2C403618188&fm=253&fmt=auto&app=138&f=JPEG?w=1422&h=800', 'https://img0.baidu.com/it/u=52438547%2C1810529324&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=1620', 9, 'volunteers008', '2026-03-06 13:39:58');
INSERT INTO `eventinformation` VALUES (1152735647228768266, '2023年城市曲棍球赛', '曲棍球', '市级', '重庆体育馆', '2026-03-06 13:39:58', '2023-07-05 14:00:00', '小组赛:7月5日-7日，淘汰赛:7月8日-10日', '比赛采用国际曲棍球联合会最新规则，设有男子曲棍球和女子曲棍球两个项目。', 'https://img0.baidu.com/it/u=3963971826%2C2766099680&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1030', 'https://img1.baidu.com/it/u=2903564822%2C461880882&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=2530', 11, 'volunteers010', '2026-03-06 13:39:58');
INSERT INTO `eventinformation` VALUES (1152735647228768270, '2023年城市橄榄球赛', '橄榄球', '市级', '大连体育馆', '2026-03-06 13:39:58', '2023-07-25 15:00:00', '小组赛:7月25日-27日，淘汰赛:7月28日-30日', '比赛采用国际橄榄球理事会最新规则，设有男子橄榄球和女子橄榄球两个项目。', 'https://img1.baidu.com/it/u=1647139064%2C604948431&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=3018', 'https://img1.baidu.com/it/u=244377185%2C496919585&fm=253&fmt=auto&app=120&f=PNG?w=500&h=626', 15, 'volunteers014', '2026-03-06 13:39:58');
INSERT INTO `eventinformation` VALUES (1152735647228768272, '2023年城市保龄球赛', '保龄球', '市级', '宁波体育馆', '2026-03-06 13:39:58', '2023-06-15 12:00:00', '男子单打:6月15日-17日，女子单打:6月18日-20日', '比赛采用国际保龄球联合会最新规则，设有男子单打、女子单打、男子双打、女子双打、混合双打五个项目。', 'https://img2.baidu.com/it/u=999963525%2C105272128&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 'https://img1.baidu.com/it/u=1647139064%2C604948431&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=3018', 17, 'volunteers016', '2026-03-06 13:39:58');
INSERT INTO `eventinformation` VALUES (1152735647228768275, '2023年全国现代五项锦标赛', '现代五项', '国家级', '苏州体育馆', '2026-03-06 13:39:58', '2023-09-20 09:00:00', '击剑:9月20日09:00-10:00，游泳:9月20日10:30-11:30', '比赛采用国际现代五项联盟最新规则，设有击剑、游泳、马术、跑步和射击五个项目。', 'https://img2.baidu.com/it/u=902504652%2C2591253129&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1087', 'https://img2.baidu.com/it/u=689219785%2C302874848&fm=253&fmt=auto&app=120&f=JPEG?w=800&h=1131', 20, 'volunteers019', '2026-03-06 13:39:58');
INSERT INTO `eventinformation` VALUES (1152735647228768278, '2023年城市高尔夫赛', '高尔夫', '市级', '昆明体育馆', '2026-03-06 13:39:58', '2023-07-05 08:00:00', '男子单打:7月5日-7日，女子单打:7月8日-10日', '比赛采用国际高尔夫联合会最新规则，设有男子单打、女子单打、男子双打、女子双打、混合双打五个项目。', 'https://img1.baidu.com/it/u=244377185%2C496919585&fm=253&fmt=auto&app=120&f=PNG?w=500&h=626', 'https://img0.baidu.com/it/u=2673673056%2C2727029773&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=665', 23, 'volunteers022', '2026-03-06 13:39:58');
INSERT INTO `eventinformation` VALUES (1152735647228768284, '2023年城市滑板赛', '滑板', '市级', '西宁体育馆', '2026-03-06 13:39:58', '2023-06-20 13:00:00', '男子滑板:6月20日-22日，女子滑板:6月23日-25日', '比赛采用国际滑板联合会最新规则，设有男子滑板和女子滑板两个项目。', 'https://img2.baidu.com/it/u=689219785%2C302874848&fm=253&fmt=auto&app=120&f=JPEG?w=800&h=1131', 'https://img1.baidu.com/it/u=2903564822%2C461880882&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=2530', 29, 'volunteers028', '2026-03-06 13:39:58');
INSERT INTO `eventinformation` VALUES (1152735647228768285, '2023年全国攀岩锦标赛', '攀岩', '国家级', '银川体育馆', '2026-03-06 13:39:58', '2023-08-10 10:00:00', '速度攀岩:8月10日-12日，难度攀岩:8月13日-15日', '比赛采用国际攀岩联合会最新规则，设有速度攀岩和难度攀岩两个项目。', 'https://img1.baidu.com/it/u=82909855%2C460423412&fm=253&fmt=auto&app=138&f=JPEG?w=667&h=500', 'https://img2.baidu.com/it/u=689219785%2C302874848&fm=253&fmt=auto&app=120&f=JPEG?w=800&h=1131', 30, 'volunteers029', '2026-03-06 13:39:58');

-- ----------------------------
-- Table structure for eventregistration
-- ----------------------------
DROP TABLE IF EXISTS `eventregistration`;
CREATE TABLE `eventregistration`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '赛事名称',
  `shenheid` bigint NULL DEFAULT NULL COMMENT '赛事id',
  `userid` bigint NULL DEFAULT NULL COMMENT '报名人id',
  `username` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '报名人',
  `shenhe` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核',
  `photo` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '封面',
  `registrationinformation` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '报名信息',
  `adduserid` bigint NULL DEFAULT NULL COMMENT '审核人id',
  `addusername` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核人',
  `shenhehuifu` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '审核回复',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2054748616379850755 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '赛事报名' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of eventregistration
-- ----------------------------
INSERT INTO `eventregistration` VALUES (1152735619848339459, '2023年羽毛球公开赛', 1, 204, '赵六', '通过', 'https://img2.baidu.com/it/u=1132844912%2C1152407923&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1254', '姓名：赵六，年龄：30，单位：某公司，联系方式：13654321098', 1, '管理员', '报名审核通过，请按赛事时间准时参加。', '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (1152735619848339460, '2023年乒乓球友谊赛', 1, 205, '钱七', '通过', 'https://img2.baidu.com/it/u=2975850349%2C1558627256&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1549', '姓名：钱七，年龄：22，学校：复旦大学，联系方式：13543210987', 1, '管理员', '报名审核通过，请按赛事时间准时参加。', '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (1152735619848339462, '2023年网球挑战赛', 107, 207, '李九', '已审核', 'https://img2.baidu.com/it/u=1048247030%2C4222740870&fm=253&fmt=auto&app=138&f=JPEG?w=678&h=737', '姓名：李九，年龄：35，单位：某机关，联系方式：13321098765', 307, '王审核', '比赛时间调整为下午2点。', '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (1152735619848339466, '2023年射击比赛', 111, 211, '孙十三', '已审核', 'https://img2.baidu.com/it/u=1119842906%2C1378412817&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=707', '姓名：孙十三，年龄：29，单位：某单位，联系方式：12987654321', 311, '李审核', '请携带射击证。', '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (1152735619848339469, '2023年象棋比赛', 114, 214, '赵十六', '待审核', 'https://img2.baidu.com/it/u=3038854933%2C3212128678&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=707', '姓名：赵十六，年龄：33，单位：某公司，联系方式：12654321098', 314, '钱审核', NULL, '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (1152735619848339472, '2023年桥牌比赛', 117, 217, '李十九', '已审核', 'https://img0.baidu.com/it/u=3111221763%2C1219804140&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=2133', '姓名：李十九，年龄：36，单位：某单位，联系方式：12321098765', 317, '王审核', '请自备桥牌。', '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (1152735619848339473, '2023年电子竞技比赛', 118, 218, '王二十', '待审核', 'https://img1.baidu.com/it/u=3738407979%2C313419995&fm=253&fmt=auto&app=120&f=JPEG?w=654&h=460', '姓名：王二十，年龄：23，单位：某公司，联系方式：12210987654', 318, '赵审核', NULL, '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (1152735619848339474, '2023年电子竞技比赛', 119, 219, '赵二十一', '已审核', 'https://img0.baidu.com/it/u=1762566056%2C1424750716&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=707', '姓名：赵二十一，年龄：21，单位：某机关，联系方式：12109876543', 319, '钱审核', '请自备游戏设备。', '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (1152735619848339482, '2023年电子竞技比赛', 127, 227, '李二十九', '已审核', 'https://img2.baidu.com/it/u=2727343327%2C4087535059&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=707', '姓名：李二十九，年龄：12，单位：某机关，联系方式：11321098765', 327, '王审核', '请自备游戏设备。', '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (1152735619848339484, '2023年电子竞技比赛', 129, 229, '赵三十一', '已审核', 'https://img0.baidu.com/it/u=1132609296%2C336056852&fm=253&fmt=auto&app=138&f=JPEG?w=615&h=468', '姓名：赵三十一，年龄：10，单位：某单位，联系方式：11109876543', 329, '钱审核', '请自备游戏设备。', '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (1152735619848343553, '2023年城市马拉松比赛', 102, 202, '李四', '待审核', 'https://img0.baidu.com/it/u=313566937%2C3366597024&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=707', '姓名：李四，年龄：25，性别：男，联系方式：13987654321', 302, '王审核', NULL, '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (1152735619848343559, '2023年田径运动会', 108, 208, '王十', '待审核', 'https://img0.baidu.com/it/u=4023627655%2C1820207078&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=803', '姓名：王十，年龄：20，学校：上海交通大学，联系方式：13210987654', 308, '赵审核', NULL, '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (1152735619848343561, '2023年攀岩比赛', 110, 210, '钱十二', '待审核', 'https://img1.baidu.com/it/u=386331671%2C3294791991&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=675', '姓名：钱十二，年龄：24，单位：某公司，联系方式：13098765432', 310, '孙审核', NULL, '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (1152735619848343573, '2023年电子竞技比赛', 122, 222, '李二十四', '待审核', 'https://img0.baidu.com/it/u=478700600%2C3561189838&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=707', '姓名：李二十四，年龄：17，单位：某公司，联系方式：11876543210', 322, '王审核', NULL, '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (1152735619848343576, '2023年电子竞技比赛', 125, 225, '钱二十七', '已审核', 'https://img2.baidu.com/it/u=3605859553%2C3392278510&fm=253&fmt=auto&app=138&f=JPEG?w=707&h=500', '姓名：钱二十七，年龄：14，单位：某单位，联系方式：11543210987', 325, '孙审核', '请自备游戏设备。', '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (1152735619848343579, '2023年电子竞技比赛', 128, 228, '王三十', '待审核', 'https://img0.baidu.com/it/u=2511045928%2C1510601462&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=722', '姓名：王三十，年龄：11，单位：某企业，联系方式：11210987654', 328, '赵审核', NULL, '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (1152735619848347648, '2023年全国大学生篮球联赛', 101, 201, '张三', '已审核', 'https://img0.baidu.com/it/u=718337689%2C394342276&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=707', '姓名：张三，学校：清华大学，年级：大三，联系方式：13812345678', 301, '李审核', '审核通过，请按时参加比赛。', '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (1152735619848347650, '2023年青少年游泳锦标赛', 103, 203, '王五', '已审核', 'https://img2.baidu.com/it/u=3318655828%2C1360635432&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=747', '姓名：王五，年龄：18，学校：北京大学，联系方式：13765432109', 303, '赵审核', '比赛地点已更新，请注意查看。', '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (1152735619848347656, '2023年自行车比赛', 109, 209, '赵十一', '已审核', 'https://img0.baidu.com/it/u=354079788%2C360869128&fm=253&fmt=auto?w=607&h=410', '姓名：赵十一，年龄：26，单位：某单位，联系方式：13109876543', 309, '钱审核', '请自备自行车。', '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (1152735619848347660, '2023年武术比赛', 113, 213, '王十五', '已审核', 'https://img1.baidu.com/it/u=3540074930%2C2744442134&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1556', '姓名：王十五，年龄：31，单位：某单位，联系方式：12765432109', 313, '赵审核', '请自备武术服装。', '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (1152735619848347663, '2023年国际象棋比赛', 116, 216, '孙十八', '待审核', 'https://img0.baidu.com/it/u=2071011874%2C1991346935&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=6418', '姓名：孙十八，年龄：34，单位：某企业，联系方式：12432109876', 316, '李审核', NULL, '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (1152735619848347668, '2023年电子竞技比赛', 121, 221, '孙二十三', '已审核', 'https://img0.baidu.com/it/u=104600266%2C1762186349&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=707', '姓名：孙二十三，年龄：18，单位：某单位，联系方式：11987654321', 321, '李审核', '请自备游戏设备。', '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (1152735619848347677, '2023年电子竞技比赛', 130, 230, '钱三十二', '待审核', 'https://img1.baidu.com/it/u=2719059897%2C3222581118&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1765', '姓名：钱三十二，年龄：9，单位：某公司，联系方式：11098765432', 330, '孙审核', NULL, '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (1152735619848351749, '2023年足球杯赛', 106, 206, '孙八', '待审核', 'https://img1.baidu.com/it/u=1091197609%2C1427142767&fm=253&fmt=auto&app=138&f=JPEG?w=750&h=500', '姓名：孙八，年龄：28，单位：某企业，联系方式：13432109876', 306, '李审核', NULL, '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (1152735619848351755, '2023年击剑比赛', 112, 212, '李十四', '待审核', 'https://img2.baidu.com/it/u=2217339242%2C52821438&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=659', '姓名：李十四，年龄：27，单位：某企业，联系方式：12876543210', 312, '王审核', NULL, '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (1152735619848351758, '2023年围棋比赛', 115, 215, '钱十七', '已审核', 'https://img0.baidu.com/it/u=597883950%2C2427395715&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=1083', '姓名：钱十七，年龄：32，单位：某机关，联系方式：12543210987', 315, '孙审核', '请自备围棋。', '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (1152735619848351763, '2023年电子竞技比赛', 120, 220, '钱二十二', '待审核', 'https://img0.baidu.com/it/u=1115896285%2C4002245014&fm=253&fmt=auto&app=138&f=JPEG?w=512&h=500', '姓名：钱二十二，年龄：19，单位：某企业，联系方式：12098765432', 320, '孙审核', NULL, '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (1152735619848351766, '2023年电子竞技比赛', 123, 223, '王二十五', '已审核', 'https://img2.baidu.com/it/u=2548137386%2C1523432849&fm=253&fmt=auto&app=138&f=JPEG?w=539&h=1215', '姓名：王二十五，年龄：16，单位：某机关，联系方式：11765432109', 323, '赵审核', '请自备游戏设备。', '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (1152735619848351767, '2023年电子竞技比赛', 124, 224, '赵二十六', '待审核', 'https://img1.baidu.com/it/u=2001133827%2C1609760232&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=2402', '姓名：赵二十六，年龄：15，单位：某企业，联系方式：11654321098', 324, '钱审核', NULL, '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (1152735619848351769, '2023年电子竞技比赛', 126, 226, '孙二十八', '待审核', 'https://img2.baidu.com/it/u=3458664114%2C670366921&fm=253&fmt=auto&app=120&f=PNG?w=503&h=500', '姓名：孙二十八，年龄：13，单位：某公司，联系方式：11432109876', 326, '李审核', NULL, '2026-03-06 13:39:57');
INSERT INTO `eventregistration` VALUES (2029802400644956161, '2023年全国青少年羽毛球锦标赛', NULL, 1152735791059828739, 'user004', '待审核', 'api/upload/pexels_architecture_276724_51178.jpg', '报名xxx', NULL, NULL, NULL, '2026-03-06 14:12:59');
INSERT INTO `eventregistration` VALUES (2042512165617496066, '2023年城市曲棍球赛', 1, 1152735791059828742, 'user007', '通过', NULL, '快快快', 1, '管理员', '报名审核通过，请按赛事时间准时参加。', '2026-04-10 15:57:03');
INSERT INTO `eventregistration` VALUES (2045406969619775489, '2023年城市马拉松赛', 1, 1152735791059828742, 'user007', '通过', NULL, '快快快', 1, '管理员', '报名审核通过，请按赛事时间准时参加。', '2026-04-18 15:39:58');
INSERT INTO `eventregistration` VALUES (2049404183899680769, '2023年城市壁球赛', 1152735647228755986, 1152735791059828742, '周丽', NULL, NULL, '111', NULL, NULL, NULL, '2026-04-29 16:23:28');
INSERT INTO `eventregistration` VALUES (2049408014163259394, '2023年全国游泳冠军赛', 1152735647228755971, 1152735791059828742, '周丽', NULL, NULL, '报名参加赛事: 2023年全国游泳冠军赛', NULL, NULL, NULL, '2026-04-29 16:38:41');
INSERT INTO `eventregistration` VALUES (2054748616379850754, '2023年全国游泳冠军赛', 1152735647228755971, 1152735791059828742, '周丽', NULL, NULL, '11', NULL, NULL, NULL, '2026-05-14 10:20:20');

-- ----------------------------
-- Table structure for image_content
-- ----------------------------
DROP TABLE IF EXISTS `image_content`;
CREATE TABLE `image_content`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '图片消息ID',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '图片存储路径',
  `file_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '文件ID',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_image_content_file_id`(`file_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1001 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of image_content
-- ----------------------------

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '消息ID',
  `from_id` bigint UNSIGNED NOT NULL COMMENT '发送方用户ID',
  `to_id` bigint UNSIGNED NOT NULL COMMENT '接收方用户ID',
  `type` tinyint UNSIGNED NOT NULL COMMENT '消息类型(0 ~ 255)，私聊(0)/群聊(1)消息',
  `content_type` tinyint UNSIGNED NOT NULL COMMENT '消息内容类型，文本(0)/图片(1)/文件(2)',
  `content_id` bigint UNSIGNED NOT NULL COMMENT '消息内容ID',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '消息发送时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户名',
  `avatarurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_message_from_id`(`from_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2056244582677094402 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES (2029801631476711426, 1, 1152735791059828739, 0, 0, 2029801631409602561, '2026-03-06 14:09:55', '2026-03-06 14:09:55', 'admin', 'api/upload/pexels_architecture_290595_50965.jpg');
INSERT INTO `message` VALUES (2029802181685510146, 1152735791059828700, 1152735791059832800, 0, 0, 2029802181685510145, '2026-03-06 14:12:06', '2026-03-06 14:12:06', 'user004', 'https://img0.baidu.com/it/u=2135737441%2C2485979813&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666');
INSERT INTO `message` VALUES (2045041174146416641, 1, 1152735791059828742, 0, 0, 2045041174075113473, '2026-04-17 15:26:25', '2026-04-17 15:26:25', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2054385433030823937, 1, 1152735791059828742, 0, 0, 2054385432963715073, '2026-05-13 10:17:10', '2026-05-13 10:17:10', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2055913850477973506, 1152735791059828700, 1152735791059832800, 0, 0, 2055913850306007042, '2026-05-17 15:30:33', '2026-05-17 15:30:33', 'user007', 'https://img1.baidu.com/it/u=2939552026%2C234974731&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667');
INSERT INTO `message` VALUES (2055914656719671299, 1, 1152735791059832853, 0, 0, 2055914656719671298, '2026-05-17 15:33:45', '2026-05-17 15:33:45', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2055923042949500930, 1152735791059832800, 1152735791059828700, 0, 0, 2055923042894974978, '2026-05-17 16:07:05', '2026-05-17 16:07:05', 'user022', 'https://img1.baidu.com/it/u=3767016028%2C718846990&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500');
INSERT INTO `message` VALUES (2055923181743214594, 1, 1152735791059832853, 0, 0, 2055923181743214593, '2026-05-17 16:07:38', '2026-05-17 16:07:38', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2055923241721761794, 1152735791059832800, 1, 0, 0, 2055923241721761793, '2026-05-17 16:07:52', '2026-05-17 16:07:52', 'user022', 'https://img1.baidu.com/it/u=3767016028%2C718846990&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500');
INSERT INTO `message` VALUES (2055923691363733507, 1, 1152735791059832853, 0, 0, 2055923691363733506, '2026-05-17 16:09:39', '2026-05-17 16:09:39', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2055924559177814017, 1, 1152735791059832853, 0, 0, 2055924559123288065, '2026-05-17 16:13:06', '2026-05-17 16:13:06', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2055928359699578883, 1, 1152735791059832853, 0, 0, 2055928359699578882, '2026-05-17 16:28:12', '2026-05-17 16:28:12', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2055930088964980738, 2, 1152735791059832853, 0, 0, 2055930088902066177, '2026-05-17 16:35:05', '2026-05-17 16:35:05', 'admin1', NULL);
INSERT INTO `message` VALUES (2055930718362238978, 1152735791059828700, 1152735791059832800, 0, 0, 2055930718362238977, '2026-05-17 16:37:35', '2026-05-17 16:37:35', 'user007', 'https://img1.baidu.com/it/u=2939552026%2C234974731&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667');
INSERT INTO `message` VALUES (2055936137684025347, 1152735791059828700, 1152735791059832800, 0, 0, 2055936137684025346, '2026-05-17 16:59:07', '2026-05-17 16:59:07', 'user007', 'https://img1.baidu.com/it/u=2939552026%2C234974731&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667');
INSERT INTO `message` VALUES (2055937247337480194, 1152735791059828700, 1, 0, 0, 2055937247274565634, '2026-05-17 17:03:31', '2026-05-17 17:03:31', 'user007', 'https://img1.baidu.com/it/u=2939552026%2C234974731&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667');
INSERT INTO `message` VALUES (2055944007695695874, 1152735791059828700, 1, 0, 0, 2055944007628587009, '2026-05-17 17:30:23', '2026-05-17 17:30:23', 'user007', 'https://img1.baidu.com/it/u=2939552026%2C234974731&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667');
INSERT INTO `message` VALUES (2055995617171873795, 1152735791059828700, 1, 0, 0, 2055995617171873794, '2026-05-17 20:55:28', '2026-05-17 20:55:28', 'user007', 'https://img1.baidu.com/it/u=2939552026%2C234974731&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667');
INSERT INTO `message` VALUES (2055995698889498627, 1152735791059828700, 1, 0, 0, 2055995698889498626, '2026-05-17 20:55:47', '2026-05-17 20:55:47', 'user007', 'https://img1.baidu.com/it/u=2939552026%2C234974731&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667');
INSERT INTO `message` VALUES (2055995720716656641, 1, 1152735791059828742, 0, 0, 2055995720653742082, '2026-05-17 20:55:53', '2026-05-17 20:55:53', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2055996004071251970, 1, 1152735791059828742, 0, 0, 2055996004071251969, '2026-05-17 20:57:00', '2026-05-17 20:57:00', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2055996037244002307, 1152735791059828700, 1, 0, 0, 2055996037244002306, '2026-05-17 20:57:08', '2026-05-17 20:57:08', 'user007', 'https://img1.baidu.com/it/u=2939552026%2C234974731&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667');
INSERT INTO `message` VALUES (2055996165535178755, 1152735791059828700, 1, 0, 0, 2055996165535178754, '2026-05-17 20:57:39', '2026-05-17 20:57:39', 'user007', 'https://img1.baidu.com/it/u=2939552026%2C234974731&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667');
INSERT INTO `message` VALUES (2055996199790059522, 1, 1152735791059828742, 0, 0, 2055996199790059521, '2026-05-17 20:57:47', '2026-05-17 20:57:47', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2055997021093502978, 1, 1152735791059828742, 0, 0, 2055997021030588418, '2026-05-17 21:01:03', '2026-05-17 21:01:03', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2055997053259620354, 1152735791059828700, 1, 0, 0, 2055997053259620353, '2026-05-17 21:01:10', '2026-05-17 21:01:10', 'user007', 'https://img1.baidu.com/it/u=2939552026%2C234974731&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667');
INSERT INTO `message` VALUES (2055998596885127169, 1152735791059828700, 1, 0, 0, 2055998596750909442, '2026-05-17 21:07:18', '2026-05-17 21:07:18', 'user007', 'https://img1.baidu.com/it/u=2939552026%2C234974731&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667');
INSERT INTO `message` VALUES (2055999040281780226, 1, 1152735791059828742, 0, 0, 2055999040218865666, '2026-05-17 21:09:04', '2026-05-17 21:09:04', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2055999566444634115, 1152735791059828700, 1, 0, 0, 2055999566444634114, '2026-05-17 21:11:09', '2026-05-17 21:11:09', 'user007', 'https://img1.baidu.com/it/u=2939552026%2C234974731&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667');
INSERT INTO `message` VALUES (2056000578572132354, 1152735791059828700, 1, 0, 0, 2056000578505023490, '2026-05-17 21:15:11', '2026-05-17 21:15:11', 'user007', 'https://img1.baidu.com/it/u=2939552026%2C234974731&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667');
INSERT INTO `message` VALUES (2056000845518606339, 1152735791059828700, 1, 0, 0, 2056000845518606338, '2026-05-17 21:16:14', '2026-05-17 21:16:14', 'user007', 'https://img1.baidu.com/it/u=2939552026%2C234974731&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667');
INSERT INTO `message` VALUES (2056002058943434754, 1, 1152735791059828742, 0, 0, 2056002058930851841, '2026-05-17 21:21:04', '2026-05-17 21:21:04', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2056002068992987139, 1, 1152735791059828742, 0, 0, 2056002068992987138, '2026-05-17 21:21:06', '2026-05-17 21:21:06', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2056002104715874306, 1152735791059828700, 1, 0, 0, 2056002104715874305, '2026-05-17 21:21:15', '2026-05-17 21:21:15', 'user007', 'https://img1.baidu.com/it/u=2939552026%2C234974731&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667');
INSERT INTO `message` VALUES (2056004323972366338, 1, 1152735791059828742, 0, 0, 2056004323972366337, '2026-05-17 21:30:04', '2026-05-17 21:30:04', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2056005525401387010, 1152735791059828700, 1, 0, 0, 2056005525334278145, '2026-05-17 21:34:50', '2026-05-17 21:34:50', 'user007', 'https://img1.baidu.com/it/u=2939552026%2C234974731&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667');
INSERT INTO `message` VALUES (2056005571714891778, 1, 1152735791059828742, 0, 0, 2056005571714891777, '2026-05-17 21:35:01', '2026-05-17 21:35:01', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2056005946102755329, 1152735791059828700, 1, 0, 0, 2056005946073395202, '2026-05-17 21:36:30', '2026-05-17 21:36:30', 'user007', 'https://img1.baidu.com/it/u=2939552026%2C234974731&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667');
INSERT INTO `message` VALUES (2056005979741073410, 1, 1152735791059828742, 0, 0, 2056005979741073409, '2026-05-17 21:36:38', '2026-05-17 21:36:38', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2056006866299498497, 2, 1152735791059828742, 0, 0, 2056006866232389633, '2026-05-17 21:40:10', '2026-05-17 21:40:10', 'admin1', NULL);
INSERT INTO `message` VALUES (2056006956837744642, 1152735791059828700, 1, 0, 0, 2056006956770635777, '2026-05-17 21:40:31', '2026-05-17 21:40:31', 'user007', 'https://img1.baidu.com/it/u=2939552026%2C234974731&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667');
INSERT INTO `message` VALUES (2056008294699085825, 1, 1152735791059828742, 0, 0, 2056008294631976962, '2026-05-17 21:45:50', '2026-05-17 21:45:50', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2056008363343065090, 1152735791059828700, 1, 0, 0, 2056008363343065089, '2026-05-17 21:46:07', '2026-05-17 21:46:07', 'user007', 'https://img1.baidu.com/it/u=2939552026%2C234974731&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667');
INSERT INTO `message` VALUES (2056008389653934083, 1, 1152735791059828742, 0, 0, 2056008389653934082, '2026-05-17 21:46:13', '2026-05-17 21:46:13', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2056212506246533122, 1152735791059828700, 1, 0, 0, 2056212506183618562, '2026-05-18 11:17:18', '2026-05-18 11:17:18', 'user007', 'https://img1.baidu.com/it/u=2939552026%2C234974731&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667');
INSERT INTO `message` VALUES (2056212544905433090, 1, 1152735791059828742, 0, 0, 2056212544842518529, '2026-05-18 11:17:27', '2026-05-18 11:17:27', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2056212699100631041, 1, 1152735791059828742, 0, 0, 2056212699037716481, '2026-05-18 11:18:04', '2026-05-18 11:18:04', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2056215080265809923, 1152735791059828700, 1, 0, 0, 2056215080265809922, '2026-05-18 11:27:32', '2026-05-18 11:27:32', 'user007', 'https://img1.baidu.com/it/u=2939552026%2C234974731&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667');
INSERT INTO `message` VALUES (2056215102202019841, 1, 1152735791059828742, 0, 0, 2056215102134910977, '2026-05-18 11:27:37', '2026-05-18 11:27:37', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2056216446635835394, 1152735791059828700, 1, 0, 0, 2056216446635835393, '2026-05-18 11:32:58', '2026-05-18 11:32:58', 'user007', 'https://img1.baidu.com/it/u=2939552026%2C234974731&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667');
INSERT INTO `message` VALUES (2056216471231234050, 1, 1152735791059828742, 0, 0, 2056216471231234049, '2026-05-18 11:33:04', '2026-05-18 11:33:04', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2056217083100495874, 1152735791059828700, 1, 0, 0, 2056217083100495873, '2026-05-18 11:35:29', '2026-05-18 11:35:29', 'user007', 'https://img1.baidu.com/it/u=2939552026%2C234974731&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667');
INSERT INTO `message` VALUES (2056217107658145795, 1, 1152735791059828742, 0, 0, 2056217107658145794, '2026-05-18 11:35:35', '2026-05-18 11:35:35', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2056220104626778114, 1, 1152735791059828742, 0, 0, 2056220104626778113, '2026-05-18 11:47:30', '2026-05-18 11:47:30', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2056220138399313922, 1152735791059828700, 1, 0, 0, 2056220138332205058, '2026-05-18 11:47:38', '2026-05-18 11:47:38', 'user007', 'https://img1.baidu.com/it/u=2939552026%2C234974731&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667');
INSERT INTO `message` VALUES (2056220160398438402, 1, 1152735791059828742, 0, 0, 2056220160398438401, '2026-05-18 11:47:43', '2026-05-18 11:47:43', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2056221827961434114, 1152735791059828700, 1, 0, 0, 2056221827961434113, '2026-05-18 11:54:21', '2026-05-18 11:54:21', 'user007', 'https://img1.baidu.com/it/u=2939552026%2C234974731&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667');
INSERT INTO `message` VALUES (2056221901659549698, 1, 1152735791059828742, 0, 0, 2056221901596635138, '2026-05-18 11:54:38', '2026-05-18 11:54:38', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2056237383276015617, 1152735791059828700, 1, 0, 0, 2056237383213101058, '2026-05-18 12:56:09', '2026-05-18 12:56:09', 'user007', 'https://img1.baidu.com/it/u=2939552026%2C234974731&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667');
INSERT INTO `message` VALUES (2056237459792703489, 1, 1152735791059828742, 0, 0, 2056237459469742081, '2026-05-18 12:56:28', '2026-05-18 12:56:28', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2056238119397339139, 1, 1152735791059828742, 0, 0, 2056238119397339138, '2026-05-18 12:59:05', '2026-05-18 12:59:05', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2056238883322703875, 1, 1152735791059828742, 0, 0, 2056238883322703874, '2026-05-18 13:02:07', '2026-05-18 13:02:07', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2056239865519624195, 1, 1152735791059828742, 0, 0, 2056239865519624194, '2026-05-18 13:06:01', '2026-05-18 13:06:01', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');
INSERT INTO `message` VALUES (2056244582677094401, 1, 1152735791059828742, 0, 0, 2056244582656122881, '2026-05-18 13:24:46', '2026-05-18 13:24:46', 'admin', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg');

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `title` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '标题',
  `introduction` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '简介',
  `picture` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '图片',
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '内容',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1729061975584571394 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '公告信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (93, '2026-03-06 12:12:55', '探索人生的真谛：从挫折到成长', '人生之路充满了挑战与机遇，我们在其中不断摸索前行，每一次的挫折都是成长的契机。就像航行在大海中的船只，虽会遭遇狂风巨浪，但也能借此磨练驶向更广阔的天地。', 'https://img1.baidu.com/it/u=1518197838,2926277201&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=500', '<p>回头看看，你会不会发现，曾经的你在这里摔倒过;回头看看，你是否发现，一次次地重复着，却从没爬起过。而如今，让我们把视线转向前方，那一道道金色的弧线，是流星飞逝的痕迹，或是成功运行的轨道。今天的你，是否要扬帆起航，让幸福来敲门?</p><p>清晨的太阳撒向大地，神奇的宇宙赋予它神奇的色彩，大自然沐浴着春光，世界因太阳的照射而精彩，林中百鸟啾啾，河水轻轻流淌，汇成清宁的山间小调。</p><p>是的，面对道途上那无情的嘲讽，面对步伐中那重复的摔跤，面对激流与硬石之间猛烈的碰撞，我们必须选择那富于阴雨，却最终见到彩虹的荆棘路。也许，经历了那暴风雨的洗礼，我们便会变得自信，幸福也随之而来。</p><p>司马迁屡遭羞辱，却依然在狱中撰写《史记》，作为一名史学家，不因王权而极度赞赏，也不因卑微而极度批判，然而他在坚持自己操守的同时，却依然要受统治阶级的阻碍，他似乎无权选择自己的本职。但是，他不顾于此，只是在面对道途的阻隔之时，他依然选择了走下去的信念。终于一部开山巨作《史记》诞生，为后人留下一份馈赠，也许在他完成毕生的杰作之时，他微微地笑了，没有什么比梦想实现更快乐的了......</p><p>	或许正如“长风破浪会有时，直挂云帆济沧海”一般，欣欣然地走向看似深渊的崎岖路，而在一番耕耘之后，便会发现这里另有一番天地。也许这就是困难与快乐的交融。</p><p>也许在形形色色的社会中，我们常能看到一份坚持，一份自信，但这里却还有一类人。这类人在暴风雨来临之际，只会闪躲，从未懂得这也是一种历炼，这何尝不是一份快乐。在阴暗的角落里，总是独自在哭，带着伤愁，看不到一点希望。</p><p>我们不能堕落于此，而要像海燕那般，在苍茫的大海上，高傲地飞翔，任何事物都无法阻挡，任何事都是幸福快乐的。</p>');
INSERT INTO `news` VALUES (94, '2026-03-06 12:12:55', '所有的努力都不会完全白费', '21.所有的努力都不会完全白费，你付出多少时间和精力，都是在对未来的积累。世界上什么都不公平，唯独时间最公平，你是懒惰还是努力，时间都会给出结果。', 'https://img0.baidu.com/it/u=2517008745,4008398621&fm=253&fmt=auto&app=120&f=JPEG?w=1422&h=800', '<p>当遇到挫折或失败，你是看见失败还是看见机会?</p><p>挫折是我们每个人成长的必经之路，它不是你想有就有，想没有就没有的。有句名言说的好，如果你想一生摆脱苦难，你就得是神或者是死尸。这句话形象地说明了挫折是伴随着人生的，是谁都逃不掉的。</p><p>人生在世，从古到今，不分天子平民，机遇虽有不同，但总不免有身陷困境或遭遇难题之处，这时候唯有通权达变，才能使人转危为安，甚至反败为胜。</p><p>大部分的人，一生当中，最痛苦的经验是失去所爱的人，其次是丢掉一份工作。其实，经得起考验的人，就算是被开除也不会惊慌，要学会面对。</p><p>	“塞翁失马，焉知非福。”人生的道路，并不是每一步都迈向成功，这就是追求的意义。我们还要认识到一点，挫折作为一种情绪状态和一种个人体验，各人的耐受性是大不相同的，有的人经历了一次次挫折，就能够坚忍不拔，百折不挠;有的人稍遇挫折便意志消沉，一蹶不振。所以，挫折感是一种主观感受，因为人的目的和需要不同，成功标准不同，所以同一种活动对于不同的人可能会造成不同的挫折感受。</p><p>凡事皆以平常心来看待，对于生命顺逆不要太执著。能够“破我执”是很高层的人生境界。</p><p>人事的艰难就是一种考验。就像—支剑要有磨刀来磨，剑才会利:一块璞玉要有粗石来磨，才会发出耀眼的光芒。我们能够做到的，只是如何减少、避免那些由于自身的原因所造成的挫折，而在遇到痛苦和挫折之后，则力求化解痛苦，争取幸福。我们要知道，痛苦和挫折是双重性的，它既是我们人生中难以完全避免的，也是我们在争取成功时，不可缺少的一种动力。因为我认为，推动我们奋斗的力量，不仅仅是对成功的渴望，还有为摆脱痛苦和挫折而进行的奋斗。</p>');
INSERT INTO `news` VALUES (95, '2026-03-06 12:12:55', '人生，没有过不去的坎', '19.人生，没有过不去的坎，你不可以坐在坎边等它消失，你只能想办法穿过它；人生，没有永远的伤痛，再深的痛，伤口总会痊愈；人生，没有永远的爱情，没有结局的感情，总要结束；不能拥有的人，总会忘记。慢慢地，你不会再流泪；慢慢地，一切都过去了，适当的放弃，是人生优雅的转身。', 'https://img0.baidu.com/it/u=3659291939,2517349581&fm=253&fmt=auto&app=138&f=JPEG?w=890&h=500', '<p>有梦想就去努力，因为在这一辈子里面，现在不去勇敢的努力，也许就再也没有机会了。你要去相信，一定要相信，没有到不了的明天。不要被命运打败，让自己变得更强大。</p><p>不管你现在是一个人走在异乡的街道上始终没有找到一丝归属感，还是你在跟朋友们一起吃饭开心址笑着的时候闪过一丝落寞。</p><p>	不管你现在是在图书馆里背着怎么也看不进去的英语单词，还是你现在迷茫地看不清未来的方向不知道要往哪走。</p><p>不管你现在是在努力着去实现梦想却没能拉近与梦想的距离，还是你已经慢慢地找不到自己的梦想了。</p><p>你都要去相信，没有到不了的明天。</p><p>	有的时候你的梦想太大，别人说你的梦想根本不可能实现;有的时候你的梦想又太小，又有人说你胸无大志;有的时候你对死党说着将来要去环游世界的梦想，却换来他的不屑一顾，于是你再也不提自己的梦想;有的时候你突然说起将来要开个小店的愿望，却发现你讲述的那个人，并没有听到你在说什么。</p><p>不过又能怎么样呢，未来始终是自己的，梦想始终是自己的，没有人会来帮你实现它。</p><p>也许很多时候我们只是需要朋友的一句鼓励，一句安慰，却也得不到。但是相信我，世界上还有很多人，只是想要和你说说话。</p><p>因为我们都一样。一样的被人说成固执，一样的在追逐他们眼里根本不在意的东西。</p><p>所以，又有什么关系呢，别人始终不是你、不能懂你的心情，你又何必多去解释呢。这个世界会来阻止你，困难也会接踵而至，其实真正关键的只有自己，有没有那个倔强。</p><p>这个世界上没有不带伤的人，真正能治愈自己的，只有自己。</p>');
INSERT INTO `news` VALUES (97, '2026-03-06 12:12:55', '生活中可以没有诗歌', '23.生活中可以没有诗歌，但不能没有诗意；行进中可以没有道路，但不能没有前进的脚步；工作中可以没有经验，但不能没有学习，人生中可以没有闪光，但不能有污迹。', 'https://img1.baidu.com/it/u=830161647,194147596&fm=253&fmt=auto&app=138&f=JPEG?w=1422&h=800', '<p>无穷无尽是离愁，天涯海角遍寻思。当离别在即之时，当面对着相濡以沫兄弟般的朋友时，当面对着经历了四年的磨合而形成的真挚友谊之时，我内心激动无语，说一声再见，道一声珍重都很难出口。回想自己四年大学的风风雨雨，回想我们曾经共同经历的岁月流年，我感谢大家的相扶相依，感谢朋友们的莫大支持与帮助。虽然舍不得，但离别的脚步却不因我们的挚情而停滞。离别的确是一种痛苦，但同样也是我们走入社会，走向新环境、新领域的一个开端，希望大家在以后新的工作岗位上能够确定自己的新起点，坚持不懈，向着更新、更高的目标前进，因为人生最美好的东西永远都在最前方!</p><p>忆往昔峥嵘岁月，看今朝潮起潮落，望未来任重而道远。作为新时代的我们，就应在失败时，能拼搏奋起，去谱写人生的辉煌。在成功时，亦能居安思危，不沉湎于一时的荣耀、鲜花和掌声中，时时刻刻怀着一颗积极寻找自己新的奶酪的心，处变不惊、成败不渝，始终踏着自己坚实的步伐，从零开始，不断向前迈进，这样才能在这风起云涌、变幻莫测的社会大潮中成为真正的弄潮儿!</p>');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `orderid` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '订单编号',
  `tablename` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '商品表名',
  `userid` bigint NOT NULL COMMENT '用户id',
  `goodid` bigint NOT NULL COMMENT '商品id',
  `goodname` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `picture` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '商品图片',
  `buynumber` int NOT NULL COMMENT '购买数量',
  `price` float NOT NULL DEFAULT 0 COMMENT '价格',
  `discountprice` float NULL DEFAULT 0 COMMENT '折扣价格',
  `total` float NOT NULL DEFAULT 0 COMMENT '总价格',
  `discounttotal` float NULL DEFAULT 0 COMMENT '折扣总价格',
  `type` int NULL DEFAULT 1 COMMENT '支付类型',
  `status` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '状态',
  `address` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '地址',
  `tel` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电话',
  `consignee` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '收货人',
  `remark` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '备注',
  `logistics` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '物流',
  `shangjiazhanghao` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商户名称',
  `evaluation` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '评价',
  `fenlei` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '商品分类',
  `couponrecordid` bigint NULL DEFAULT NULL COMMENT '优惠券id',
  `shenhe` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '审核',
  `shenhehuifu` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '审核回复',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2055959267756441603 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '订单' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1152735669106245636, '2026-03-06 13:40:00', 'ORD202310010005', 'stadium', 1005, 2005, '哑铃套装', 'https://img1.baidu.com/it/u=2947132640%2C1646736090&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1118', 1, 300, 250, 300, 250, 1, '待核验', '成都市武侯区xxx街xxx号', '13500135000', '钱七', '包装完好', '德邦快递', '健身器械店', '很好用', '健身器材', NULL, '已通过', '谢谢');
INSERT INTO `orders` VALUES (1152735669106245637, '2026-03-06 13:40:00', 'ORD202310010006', 'stadium', 1006, 2006, '乒乓球拍', 'https://img1.baidu.com/it/u=317116515%2C2919552978&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 2, 60, 50, 120, 100, 1, '待评价', '杭州市西湖区xxx路xxx号', '13400134000', '孙八', '拍子有点重', '圆通快递', '球类用品店', '还行', '体育用品', NULL, '待审核', NULL);
INSERT INTO `orders` VALUES (1152735669106245641, '2026-03-06 13:40:00', 'ORD202310010010', 'stadium', 1010, 2010, '跳绳', 'https://img2.baidu.com/it/u=1199630458%2C1292916257&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=1250', 1, 20, 15, 20, 15, 1, '已支付', '重庆市渝北区xxx路xxx号', '13000130000', '王十二', '质量很好', '顺丰快递', '体育用品店', '满意', '体育用品', NULL, '已通过', '感谢您的支持');
INSERT INTO `orders` VALUES (1152735669106245642, '2026-03-06 13:40:00', 'ORD202310010011', 'stadium', 1011, 2011, '健身手套', 'https://img1.baidu.com/it/u=4710226%2C1050046919&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1093', 2, 30, 25, 60, 50, 1, '待发货', '天津市和平区xxx街xxx号', '12900129000', '李十三', '尺寸合适', '中通快递', '健身用品店', '好用', '健身器材', NULL, '待审核', NULL);
INSERT INTO `orders` VALUES (1152735669106245644, '2026-03-06 13:40:00', 'ORD202310010013', 'stadium', 1013, 2013, '拉力器', 'https://img1.baidu.com/it/u=3425762252%2C1205977533&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 1, 80, 70, 80, 70, 1, '已评价', '大连市中山区xxx街xxx号', '12700127000', '刘十五', '操作简单', '韵达快递', '健身器材店', '满意', '健身器材', NULL, '已通过', '感谢您的信任');
INSERT INTO `orders` VALUES (1152735669106245652, '2026-03-06 13:40:00', 'ORD202310010021', 'stadium', 1021, 2021, '俯卧撑架', 'https://img1.baidu.com/it/u=3956662551%2C3971118059&fm=253&fmt=auto&app=120&f=JPEG?w=654&h=368', 1, 70, 60, 70, 60, 1, '已完成', '石家庄市桥西区xxx街xxx号', '11900119000', '李二十三', '很稳固', '京东物流', '健身器材店', '满意', '健身器材', NULL, '已通过', '感谢您的信任');
INSERT INTO `orders` VALUES (1152735669106245654, '2026-03-06 13:40:00', 'ORD202310010023', 'stadium', 1023, 2023, '瑜伽砖', 'https://img1.baidu.com/it/u=2480280280%2C2739013006&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1741', 4, 15, 12, 60, 48, 1, '已支付', '长沙市岳麓区xxx街xxx号', '11700117000', '刘二十五', '材质好', '德邦快递', '瑜伽用品店', '不错', '瑜伽用品', NULL, '已通过', '欢迎再次光临');
INSERT INTO `orders` VALUES (1152735669106249728, '2026-03-06 13:40:00', 'ORD202310010001', 'stadium', 1001, 2001, '羽毛球拍', 'https://img2.baidu.com/it/u=4177289990%2C2387658996&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1734', 2, 150, 120, 300, 240, 1, '待核验', '北京市朝阳区xxx路xxx号', '13800138000', '张三', '请尽快发货', '顺丰快递', '体育用品店', '很好', '体育用品', NULL, '已通过', '订单确认无误');
INSERT INTO `orders` VALUES (1152735669106249729, '2026-03-06 13:40:00', 'ORD202310010002', 'stadium', 1002, 2002, '篮球', 'https://img0.baidu.com/it/u=419548747%2C2364054390&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1081', 1, 80, 70, 80, 70, 1, '待发货', '上海市浦东新区xxx街xxx号', '13900139000', '李四', '希望质量好', '中通快递', '运动器材店', '不错', '体育用品', NULL, '待审核', NULL);
INSERT INTO `orders` VALUES (1152735669106249730, '2026-03-06 13:40:00', 'ORD202310010003', 'stadium', 1003, 2003, '跑步机', 'https://img2.baidu.com/it/u=4283218301%2C1385056497&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889', 1, 2000, 1800, 2000, 1800, 1, '已完成', '广州市天河区xxx大道xxx号', '13700137000', '王五', '非常满意', '京东物流', '健身器材店', '推荐购买', '健身器材', NULL, '已通过', '感谢您的支持');
INSERT INTO `orders` VALUES (1152735669106249741, '2026-03-06 13:40:00', 'ORD202310010014', 'stadium', 1014, 2014, '仰卧板', 'https://img2.baidu.com/it/u=3854299089%2C176097682&fm=253&fmt=auto&app=138&f=JPEG?w=667&h=500', 1, 150, 130, 150, 130, 1, '已收货', '青岛市市南区xxx路xxx号', '12600126000', '陈十六', '很实用', '德邦快递', '健身器材店', '推荐', '健身器材', NULL, '已通过', '欢迎再次光临');
INSERT INTO `orders` VALUES (1152735669106249743, '2026-03-06 13:40:00', 'ORD202310010016', 'stadium', 1016, 2016, '哑铃凳', 'https://img2.baidu.com/it/u=297783121%2C1524957302&fm=253&fmt=auto&app=138&f=JPEG?w=837&h=500', 1, 200, 180, 200, 180, 1, '已收货', '福州市鼓楼区xxx路xxx号', '12400124000', '黄十八', '组装简单', '申通快递', '健身器材店', '满意', '健身器材', NULL, '已通过', '谢谢');
INSERT INTO `orders` VALUES (1152735669106249753, '2026-03-06 13:40:00', 'ORD202310010026', 'stadium', 1026, 2026, '瑜伽毯', 'https://img1.baidu.com/it/u=2917403420%2C3132567979&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=946', 1, 50, 40, 50, 40, 1, '已完成', '南京市鼓楼区xxx路xxx号', '11400114000', '黄二十八', '很柔软', '百世快递', '瑜伽用品店', '满意', '瑜伽用品', NULL, '已通过', '感谢您的支持');
INSERT INTO `orders` VALUES (1152735669106253838, '2026-03-06 13:40:00', 'ORD202310010015', 'stadium', 1015, 2015, '踏步机', 'https://img1.baidu.com/it/u=794464445%2C80392549&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1067', 1, 500, 450, 500, 450, 1, '待评价', '厦门市思明区xxx街xxx号', '12500125000', '杨十七', '噪音小', '圆通快递', '健身器材店', '不错', '健身器材', NULL, '待审核', NULL);
INSERT INTO `orders` VALUES (1152735669106253840, '2026-03-06 13:40:00', 'ORD202310010017', 'stadium', 1017, 2017, '健腹轮', 'https://img2.baidu.com/it/u=326427345%2C3897736377&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=575', 2, 100, 80, 200, 160, 1, '已完成', '南宁市青秀区xxx街xxx号', '12300123000', '何十九', '很有效', '百世快递', '健身器材店', '推荐', '健身器材', NULL, '已通过', '感谢您的支持');
INSERT INTO `orders` VALUES (1152735669106253843, '2026-03-06 13:40:00', 'ORD202310010020', 'stadium', 1020, 2020, '扭腰盘', 'https://img1.baidu.com/it/u=1088331977%2C776636980&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1112', 2, 50, 40, 100, 80, 1, '待发货', '太原市小店区xxx路xxx号', '12000120000', '张二十二', '很灵活', '中通快递', '健身器材店', '推荐', '健身器材', NULL, '待审核', NULL);
INSERT INTO `orders` VALUES (1152735669106253848, '2026-03-06 13:40:00', 'ORD202310010025', 'stadium', 1025, 2025, '瑜伽轮', 'https://img2.baidu.com/it/u=262429708%2C2350693592&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=889', 1, 80, 70, 80, 70, 1, '已发货', '合肥市蜀山区xxx街xxx号', '11500115000', '杨二十七', '很顺滑', '申通快递', '瑜伽用品店', '推荐', '瑜伽用品', NULL, '已通过', '谢谢');
INSERT INTO `orders` VALUES (1152735669106253850, '2026-03-06 13:40:00', 'ORD202310010027', 'stadium', 1027, 2027, '瑜伽柱', 'https://img1.baidu.com/it/u=2848602667%2C932349549&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=661', 2, 40, 35, 80, 70, 1, '已评价', '苏州市姑苏区xxx街xxx号', '11300113000', '何二十九', '很耐用', '天天快递', '瑜伽用品店', '推荐', '瑜伽用品', NULL, '已通过', '欢迎再次光临');
INSERT INTO `orders` VALUES (1152735669106257923, '2026-03-06 13:40:00', 'ORD202310010004', 'stadium', 1004, 2004, '瑜伽垫', 'https://img0.baidu.com/it/u=3111443919%2C1368556939&fm=253&fmt=auto&app=138&f=JPEG?w=1021&h=500', 3, 50, 40, 150, 120, 1, '已评价', '深圳市南山区xxx路xxx号', '13600136000', '赵六', '很薄，需要加厚版', '韵达快递', '瑜伽用品店', '一般', '瑜伽用品', NULL, '已通过', '下次改进');
INSERT INTO `orders` VALUES (1152735669106257926, '2026-03-06 13:40:00', 'ORD202310010007', 'stadium', 1007, 2007, '足球', 'https://img0.baidu.com/it/u=3945669556%2C1319451703&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=744', 1, 100, 90, 100, 90, 1, '已发货', '南京市鼓楼区xxx大道xxx号', '13300133000', '周九', '质量不错', '申通快递', '体育用品店', '满意', '体育用品', NULL, '已通过', '感谢您的信任');
INSERT INTO `orders` VALUES (1152735669106257927, '2026-03-06 13:40:00', 'ORD202310010008', 'stadium', 1008, 2008, '网球拍', 'https://img0.baidu.com/it/u=827311055%2C3568717410&fm=253&fmt=auto&app=138&f=JPEG?w=1067&h=800', 1, 120, 100, 120, 100, 1, '已完成', '武汉市江汉区xxx路xxx号', '13200132000', '吴十', '很轻，适合新手', '百世快递', '球拍专卖店', '推荐', '体育用品', NULL, '已通过', '欢迎再次光临');
INSERT INTO `orders` VALUES (1152735669106257928, '2026-03-06 13:40:00', 'ORD202310010009', 'stadium', 1009, 2009, '游泳镜', 'https://img2.baidu.com/it/u=1873815998%2C1196222742&fm=253&fmt=auto&app=120&f=PNG?w=991&h=500', 2, 40, 35, 80, 70, 1, '已评价', '西安市雁塔区xxx街xxx号', '13100131000', '郑十一', '防雾效果好', '天天快递', '游泳用品店', '不错', '体育用品', NULL, '已通过', '谢谢');
INSERT INTO `orders` VALUES (1152735669106257931, '2026-03-06 13:40:00', 'ORD202310010012', 'stadium', 1012, 2012, '瑜伽球', 'https://img2.baidu.com/it/u=4040036923%2C2370143602&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1097', 1, 60, 50, 60, 50, 1, '已完成', '沈阳市沈河区xxx路xxx号', '12800128000', '张十四', '很结实', '京东物流', '瑜伽用品店', '推荐', '瑜伽用品', NULL, '已通过', '谢谢');
INSERT INTO `orders` VALUES (1152735669106257937, '2026-03-06 13:40:00', 'ORD202310010018', 'stadium', 1018, 2018, '握力器', 'https://img2.baidu.com/it/u=1410401259%2C2388659497&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1731', 3, 25, 20, 75, 60, 1, '已评价', '昆明市五华区xxx路xxx号', '12200122000', '吕二十', '手感好', '天天快递', '健身器材店', '满意', '健身器材', NULL, '已通过', '欢迎再次光临');
INSERT INTO `orders` VALUES (1152735669106257938, '2026-03-06 13:40:00', 'ORD202310010019', 'stadium', 1019, 2019, '臂力器', 'https://img2.baidu.com/it/u=106285577%2C2003921472&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 1, 40, 35, 40, 35, 1, '已支付', '贵阳市云岩区xxx街xxx号', '12100121000', '施二十一', '强度适中', '顺丰快递', '健身器材店', '不错', '健身器材', NULL, '已通过', '谢谢');
INSERT INTO `orders` VALUES (1152735669106257941, '2026-03-06 13:40:00', 'ORD202310010022', 'stadium', 1022, 2022, '仰卧起坐板', 'https://img0.baidu.com/it/u=2978904647%2C1014156455&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=642', 1, 120, 100, 120, 100, 1, '已评价', '郑州市中原区xxx路xxx号', '11800118000', '王二十四', '角度可调', '韵达快递', '健身器材店', '推荐', '健身器材', NULL, '已通过', '谢谢');
INSERT INTO `orders` VALUES (1152735669106257943, '2026-03-06 13:40:00', 'ORD202310010024', 'stadium', 1024, 2024, '拉伸带', 'https://img0.baidu.com/it/u=503011674%2C1026807325&fm=253&fmt=auto&app=138&f=JPEG?w=963&h=500', 2, 30, 25, 60, 50, 1, '待评价', '南昌市东湖区xxx路xxx号', '11600116000', '陈二十六', '弹性好', '圆通快递', '瑜伽用品店', '满意', '瑜伽用品', NULL, '待审核', NULL);
INSERT INTO `orders` VALUES (1152735669106257947, '2026-03-06 13:40:00', 'ORD202310010028', 'stadium', 1028, 2028, '瑜伽垫支架', 'https://img2.baidu.com/it/u=1165390232%2C380780661&fm=253&fmt=auto?w=1158&h=640', 1, 60, 50, 60, 50, 1, '已支付', '无锡市梁溪区xxx路xxx号', '11200112000', '吕三十', '很方便', '顺丰快递', '瑜伽用品店', '不错', '瑜伽用品', NULL, '已通过', '谢谢');
INSERT INTO `orders` VALUES (1152735669106257948, '2026-03-06 13:40:00', 'ORD202310010029', 'stadium', 1029, 2029, '瑜伽绳', 'https://img2.baidu.com/it/u=3811252390%2C523499130&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=293', 3, 20, 18, 60, 54, 1, '待发货', '常州市天宁区xxx街xxx号', '11100111000', '施三十一', '很结实', '中通快递', '瑜伽用品店', '满意', '瑜伽用品', NULL, '待审核', NULL);
INSERT INTO `orders` VALUES (1152735669106257949, '2026-03-06 13:40:00', 'ORD202310010030', 'stadium', 1030, 2030, '瑜伽球套', 'https://img2.baidu.com/it/u=1766827329%2C853602814&fm=253&fmt=auto&app=138&f=JPEG?w=796&h=500', 2, 10, 8, 20, 16, 1, '已完成', '杭州市拱墅区xxx路xxx号', '11000110000', '张三十二', '颜色好看', '京东物流', '瑜伽用品店', '推荐', '瑜伽用品', NULL, '已通过', '感谢您的信任');
INSERT INTO `orders` VALUES (2055955506082316289, '2026-05-17 18:16:05', '2055955506107482112', '', 1152735791059828742, 1152735605872922632, '健身手套', 'https://img1.baidu.com/it/u=4235493934%2C4065908190&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=790', 1, 79, 0, 79, 0, 0, '申请退款', '北京市-市辖区-东城区-1', '13576747877', '1', NULL, NULL, 'user005', '111', NULL, NULL, NULL, NULL);
INSERT INTO `orders` VALUES (2055958032991092737, '2026-05-17 18:26:07', '2055958033020452864', '', 1152735791059828742, 1152735605872918554, '运动护颈', 'https://img2.baidu.com/it/u=1734206736%2C229749012&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=664', 1, 69, 0, 69, 0, 0, '已收货', '北京市-市辖区-东城区-1', '13576747877', '1', NULL, NULL, 'user014', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `orders` VALUES (2055959267756441602, '2026-05-17 18:31:01', '2055959267789996032', '', 1152735791059828742, 1152735605872918557, '运动护腿', 'https://img2.baidu.com/it/u=897684685%2C1893677581&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1722', 1, 89, 0, 89, 0, 0, '退款中', '北京市-市辖区-东城区-1', '13576747877', '1', NULL, NULL, 'volunteers015', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for postcategories
-- ----------------------------
DROP TABLE IF EXISTS `postcategories`;
CREATE TABLE `postcategories`  (
  `id` bigint NOT NULL COMMENT '主键',
  `addtime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `userid` bigint NULL DEFAULT NULL COMMENT '创建人',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人名字',
  `category_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '帖子话题分类' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of postcategories
-- ----------------------------
INSERT INTO `postcategories` VALUES (1152735563460116484, '2026-03-06 13:39:53', 123456789012345674, 'user005', '网球');
INSERT INTO `postcategories` VALUES (1152735563460116486, '2026-03-06 13:39:53', 123456789012345676, 'user007', '跑步');
INSERT INTO `postcategories` VALUES (1152735563460116489, '2026-03-06 13:39:53', 123456789012345679, 'user010', '武术');
INSERT INTO `postcategories` VALUES (1152735563460116490, '2026-03-06 13:39:53', 123456789012345680, 'user011', '篮球');
INSERT INTO `postcategories` VALUES (1152735563460116492, '2026-03-06 13:39:53', 123456789012345682, 'user013', '羽毛球');
INSERT INTO `postcategories` VALUES (1152735563460116493, '2026-03-06 13:39:53', 123456789012345683, 'user014', '乒乓球');
INSERT INTO `postcategories` VALUES (1152735563460120579, '2026-03-06 13:39:53', 123456789012345673, 'user004', '乒乓球');
INSERT INTO `postcategories` VALUES (1152735563460120583, '2026-03-06 13:39:53', 123456789012345677, 'user008', '健身');
INSERT INTO `postcategories` VALUES (1152735563460120584, '2026-03-06 13:39:53', 123456789012345678, 'user009', '瑜伽');
INSERT INTO `postcategories` VALUES (1152735563460120591, '2026-03-06 13:39:53', 123456789012345685, 'user016', '游泳');
INSERT INTO `postcategories` VALUES (1152735563460120592, '2026-03-06 13:39:53', 123456789012345686, 'user017', '跑步');
INSERT INTO `postcategories` VALUES (1152735563460120594, '2026-03-06 13:39:53', 123456789012345688, 'user019', '瑜伽');
INSERT INTO `postcategories` VALUES (1152735563460120599, '2026-03-06 13:39:53', 123456789012345693, 'user024', '乒乓球');
INSERT INTO `postcategories` VALUES (1152735563460120603, '2026-03-06 13:39:53', 123456789012345697, 'user028', '健身');
INSERT INTO `postcategories` VALUES (1152735563460120604, '2026-03-06 13:39:53', 123456789012345698, 'user029', '瑜伽');
INSERT INTO `postcategories` VALUES (1152735563460124672, '2026-03-06 13:39:53', 123456789012345670, 'user001', '篮球');
INSERT INTO `postcategories` VALUES (1152735563460124673, '2026-03-06 13:39:53', 123456789012345671, 'user002', '足球');
INSERT INTO `postcategories` VALUES (1152735563460124674, '2026-03-06 13:39:53', 123456789012345672, 'user003', '羽毛球');
INSERT INTO `postcategories` VALUES (1152735563460124693, '2026-03-06 13:39:53', 123456789012345691, 'user022', '足球');
INSERT INTO `postcategories` VALUES (1152735563460124697, '2026-03-06 13:39:53', 123456789012345695, 'user026', '游泳');
INSERT INTO `postcategories` VALUES (1152735563460128773, '2026-03-06 13:39:53', 123456789012345675, 'user006', '游泳');
INSERT INTO `postcategories` VALUES (1152735563460128779, '2026-03-06 13:39:53', 123456789012345681, 'user012', '足球');
INSERT INTO `postcategories` VALUES (1152735563460128782, '2026-03-06 13:39:53', 123456789012345684, 'user015', '网球');
INSERT INTO `postcategories` VALUES (1152735563460128785, '2026-03-06 13:39:53', 123456789012345687, 'user018', '健身');
INSERT INTO `postcategories` VALUES (1152735563460128787, '2026-03-06 13:39:53', 123456789012345689, 'user020', '武术');
INSERT INTO `postcategories` VALUES (1152735563460128788, '2026-03-06 13:39:53', 123456789012345690, 'user021', '篮球');
INSERT INTO `postcategories` VALUES (1152735563460128790, '2026-03-06 13:39:53', 123456789012345692, 'user023', '羽毛球');
INSERT INTO `postcategories` VALUES (1152735563460128792, '2026-03-06 13:39:53', 123456789012345694, 'user025', '网球');
INSERT INTO `postcategories` VALUES (1152735563460128794, '2026-03-06 13:39:53', 123456789012345696, 'user027', '跑步');
INSERT INTO `postcategories` VALUES (1727991403442307074, '2026-03-06 12:12:55', 2, 'admin1', '啦啦啦la');
INSERT INTO `postcategories` VALUES (1727992664430444546, '2026-03-06 12:12:55', 2, 'admin1', 'qqqqll');
INSERT INTO `postcategories` VALUES (1727993431035969538, '2026-03-06 12:12:55', 2, 'admin1', 'hhhh');

-- ----------------------------
-- Table structure for posts
-- ----------------------------
DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts`  (
  `id` bigint NOT NULL COMMENT '主键',
  `category_id` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '话题分类',
  `posting_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发帖地址',
  `picture` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '封面',
  `post_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '帖子标题',
  `post_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
  `is_published` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否发布(Y/N)',
  `is_approved` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否审核通过(Y/N)',
  `userid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发帖人',
  `addtime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发帖人名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '帖子详情' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of posts
-- ----------------------------
INSERT INTO `posts` VALUES (1152735715411361794, '体育', '广州市天河区体育馆', 'https://img2.baidu.com/it/u=882779485%2C1679395817&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=742', '羽毛球比赛', '下周日羽毛球比赛，报名从速。', 'Y', 'Y', 'user002', '2026-03-06 13:40:02', 'user002');
INSERT INTO `posts` VALUES (1152735715411361806, '体育', '济南市历下区体育馆', 'https://img2.baidu.com/it/u=882335149%2C3308055737&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=625', '足球比赛', '足球比赛即将开始，欢迎观看。', 'Y', 'Y', 'user008', '2026-03-06 13:40:02', 'user008');
INSERT INTO `posts` VALUES (1152735715411361809, '体育', '厦门市思明区体育馆', 'https://img1.baidu.com/it/u=2675837989%2C3036446787&fm=253&fmt=auto&app=138&f=JPEG?w=742&h=500', '网球课程', '新开设的网球课程，适合各年龄段。', 'Y', 'Y', 'volunteers009', '2026-03-06 13:40:02', 'volunteers009');
INSERT INTO `posts` VALUES (1152735715411361814, '体育', '太原市小店区体育馆', 'https://img0.baidu.com/it/u=798035275%2C2462155690&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1733', '健身比赛', '健身比赛即将开始，欢迎观看。', 'Y', 'Y', 'user012', '2026-03-06 13:40:02', 'user012');
INSERT INTO `posts` VALUES (1152735715411361815, '体育', '石家庄市桥西区体育馆', 'https://img2.baidu.com/it/u=3565869733%2C563361687&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1085', '游泳比赛', '游泳比赛通知，请做好准备。', 'Y', 'Y', 'volunteers012', '2026-03-06 13:40:02', 'volunteers012');
INSERT INTO `posts` VALUES (1152735715411361821, '体育', '南昌市红谷滩区体育馆', 'https://img2.baidu.com/it/u=2240506244%2C834905539&fm=253&fmt=auto&app=120&f=JPEG?w=780&h=500', '健身比赛', '健身比赛通知，请做好准备。', 'Y', 'Y', 'volunteers015', '2026-03-06 13:40:02', 'volunteers015');
INSERT INTO `posts` VALUES (1152735715411365888, '体育', '北京市朝阳区体育馆', 'https://img1.baidu.com/it/u=3235754671%2C4064570557&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1128', '篮球比赛通知', '本周六下午2点在体育馆举行篮球比赛，欢迎大家参加。', 'Y', 'Y', 'user001', '2026-03-06 13:40:02', 'user001');
INSERT INTO `posts` VALUES (1152735715411365891, '体育', '深圳市南山区体育馆', 'https://img1.baidu.com/it/u=973101355%2C868984322&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=4743', '游泳课程', '新开设的游泳课程，适合各年龄段。', 'Y', 'Y', 'volunteers002', '2026-03-06 13:40:02', 'volunteers002');
INSERT INTO `posts` VALUES (1152735715411365894, '体育', '武汉市江汉区体育馆', 'https://img0.baidu.com/it/u=1083817442%2C3036891415&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', '足球友谊赛', '周末足球友谊赛，欢迎组队参加。', 'Y', 'Y', 'user004', '2026-03-06 13:40:02', 'user004');
INSERT INTO `posts` VALUES (1152735715411365896, '体育', '西安市雁塔区体育馆', 'https://img0.baidu.com/it/u=3478497944%2C4238524077&fm=253&fmt=auto&app=138&f=JPEG?w=772&h=500', '网球比赛', '网球比赛即将开始，报名截止时间为本周五。', 'Y', 'Y', 'user005', '2026-03-06 13:40:02', 'user005');
INSERT INTO `posts` VALUES (1152735715411365900, '体育', '哈尔滨市道里区体育馆', 'https://img0.baidu.com/it/u=807476163%2C1686733348&fm=253&fmt=auto&app=138&f=JPEG?w=686&h=500', '羽毛球课程', '新开设的羽毛球课程，适合初学者。', 'Y', 'Y', 'user007', '2026-03-06 13:40:02', 'user007');
INSERT INTO `posts` VALUES (1152735715411365903, '体育', '青岛市市南区体育馆', 'https://img2.baidu.com/it/u=297783121%2C1524957302&fm=253&fmt=auto&app=138&f=JPEG?w=837&h=500', '跑步比赛', '跑步比赛通知，请做好准备。', 'Y', 'Y', 'volunteers008', '2026-03-06 13:40:02', 'volunteers008');
INSERT INTO `posts` VALUES (1152735715411365912, '体育', '郑州市中原区体育馆', 'https://img2.baidu.com/it/u=2148741606%2C662577964&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=852', '篮球讲座', '篮球讲座，欢迎参加。', 'Y', 'Y', 'user013', '2026-03-06 13:40:02', 'user013');
INSERT INTO `posts` VALUES (1152735715411369988, '体育', '杭州市西湖区体育馆', 'https://img1.baidu.com/it/u=4087164979%2C1298540985&fm=253&fmt=auto&app=120&f=JPEG?w=540&h=500', '乒乓球比赛', '欢迎乒乓球爱好者报名参加。', 'Y', 'Y', 'user003', '2026-03-06 13:40:02', 'user003');
INSERT INTO `posts` VALUES (1152735715411369989, '体育', '成都市锦江区体育馆', 'https://img0.baidu.com/it/u=3143175069%2C792656290&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500', '瑜伽课程', '每周二、四晚6点瑜伽课程。', 'Y', 'Y', 'volunteers003', '2026-03-06 13:40:02', 'volunteers003');
INSERT INTO `posts` VALUES (1152735715411369991, '体育', '南京市鼓楼区体育馆', 'https://img2.baidu.com/it/u=170450162%2C3111513134&fm=253&fmt=auto&app=120&f=JPEG?w=655&h=463', '跑步俱乐部', '每周六早晨7点跑步俱乐部活动。', 'Y', 'Y', 'volunteers004', '2026-03-06 13:40:02', 'volunteers004');
INSERT INTO `posts` VALUES (1152735715411369997, '体育', '长春市朝阳区体育馆', 'https://img0.baidu.com/it/u=3911872156%2C2434871650&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1066', '健身讲座', '健身讲座，欢迎参加。', 'Y', 'Y', 'volunteers007', '2026-03-06 13:40:02', 'volunteers007');
INSERT INTO `posts` VALUES (1152735715411370002, '体育', '福州市鼓楼区体育馆', 'https://img2.baidu.com/it/u=2807599515%2C2551029775&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500', '健身比赛', '健身比赛即将开始，欢迎观看。', 'Y', 'Y', 'user010', '2026-03-06 13:40:02', 'user010');
INSERT INTO `posts` VALUES (1152735715411370003, '体育', '南宁市青秀区体育馆', 'https://img1.baidu.com/it/u=637969528%2C3404976219&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1931', '游泳讲座', '游泳讲座，欢迎参加。', 'Y', 'Y', 'volunteers010', '2026-03-06 13:40:02', 'volunteers010');
INSERT INTO `posts` VALUES (1152735715411370005, '体育', '昆明市五华区体育馆', 'https://img1.baidu.com/it/u=2575098054%2C478463669&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500', '羽毛球讲座', '羽毛球讲座，欢迎参加。', 'Y', 'Y', 'volunteers011', '2026-03-06 13:40:02', 'volunteers011');
INSERT INTO `posts` VALUES (1152735715411370010, '体育', '南昌市东湖区体育馆', 'https://img0.baidu.com/it/u=2443142797%2C2741207191&fm=253&fmt=auto&app=138&f=JPEG?w=1064&h=500', '健身课程', '新开设的健身课程，适合各年龄段。', 'Y', 'Y', 'user014', '2026-03-06 13:40:02', 'user014');
INSERT INTO `posts` VALUES (1152735715411370011, '体育', '南昌市西湖区体育馆', 'https://img0.baidu.com/it/u=3654828791%2C4065074565&fm=253&fmt=auto&app=138&f=JPEG?w=667&h=500', '游泳讲座', '游泳讲座，欢迎参加。', 'Y', 'Y', 'volunteers014', '2026-03-06 13:40:02', 'volunteers014');
INSERT INTO `posts` VALUES (1152735715411374081, '体育', '上海市浦东体育馆', 'https://img2.baidu.com/it/u=3381368646%2C3621768413&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=714', '健身活动', '每周一、三、五晚7点在体育馆举行健身活动。', 'Y', 'Y', 'volunteers001', '2026-03-06 13:40:02', 'volunteers001');
INSERT INTO `posts` VALUES (1152735715411374089, '体育', '重庆市渝中区体育馆', 'https://img1.baidu.com/it/u=3127307558%2C3804722932&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=326', '健身操课程', '每周一、三、五晚8点健身操课程。', 'Y', 'Y', 'volunteers005', '2026-03-06 13:40:02', 'volunteers005');
INSERT INTO `posts` VALUES (1152735715411374090, '体育', '天津市和平区体育馆', 'https://img2.baidu.com/it/u=2895804776%2C765798418&fm=253&fmt=auto&app=138&f=JPEG?w=805&h=500', '篮球训练营', '青少年篮球训练营，欢迎报名。', 'Y', 'Y', 'user006', '2026-03-06 13:40:02', 'user006');
INSERT INTO `posts` VALUES (1152735715411374091, '体育', '沈阳市沈河区体育馆', 'https://img0.baidu.com/it/u=3599540408%2C2523200469&fm=253&fmt=auto&app=138&f=JPEG?w=805&h=500', '游泳比赛', '游泳比赛通知，请做好准备。', 'Y', 'Y', 'volunteers006', '2026-03-06 13:40:02', 'volunteers006');
INSERT INTO `posts` VALUES (1152735715411374096, '体育', '大连市中山区体育馆', 'https://img0.baidu.com/it/u=3297096626%2C2908962627&fm=253&fmt=auto&app=138&f=JPEG?w=499&h=241', '瑜伽讲座', '瑜伽讲座，欢迎参加。', 'Y', 'Y', 'user009', '2026-03-06 13:40:02', 'user009');
INSERT INTO `posts` VALUES (1152735715411374100, '体育', '贵阳市南明区体育馆', 'https://img2.baidu.com/it/u=3163541578%2C312513792&fm=253&fmt=auto&app=138&f=JPEG?w=700&h=500', '篮球课程', '新开设的篮球课程，适合各年龄段。', 'Y', 'Y', 'user011', '2026-03-06 13:40:02', 'user011');
INSERT INTO `posts` VALUES (1152735715411374105, '体育', '长沙市岳麓区体育馆', 'https://img1.baidu.com/it/u=3521884319%2C4270204350&fm=253&fmt=auto&app=138&f=JPEG?w=667&h=500', '羽毛球比赛', '羽毛球比赛即将开始，欢迎观看。', 'Y', 'Y', 'volunteers013', '2026-03-06 13:40:02', 'volunteers013');
INSERT INTO `posts` VALUES (1152735715411374108, '体育', '南昌市青云谱区体育馆', 'https://img0.baidu.com/it/u=1433839140%2C513977463&fm=253&fmt=auto&app=138&f=JPEG?w=667&h=500', '篮球比赛', '篮球比赛即将开始，欢迎观看。', 'Y', 'Y', 'user015', '2026-03-06 13:40:02', 'user015');
INSERT INTO `posts` VALUES (1729390431694393345, 'qqqqll', '[\"上海\",\"徐汇区\",\"湖南路街道\"]', 'https://img2.baidu.com/it/u=882779485%2C1679395817&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=742', 'qq', '%3Cp%3Eaaa%3C%2Fp%3E', 'N', NULL, '1', '2026-03-06 12:12:55', 'admin');

-- ----------------------------
-- Table structure for siteclassification
-- ----------------------------
DROP TABLE IF EXISTS `siteclassification`;
CREATE TABLE `siteclassification`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类名称',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1152735535375069211 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '场地分类' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of siteclassification
-- ----------------------------
INSERT INTO `siteclassification` VALUES (1152735535375056903, '乒乓球馆', '2026-03-06 13:39:52');
INSERT INTO `siteclassification` VALUES (1152735535375056908, '武术馆', '2026-03-06 13:39:52');
INSERT INTO `siteclassification` VALUES (1152735535375056909, '击剑馆', '2026-03-06 13:39:52');
INSERT INTO `siteclassification` VALUES (1152735535375056918, '赛车场', '2026-03-06 13:39:52');
INSERT INTO `siteclassification` VALUES (1152735535375056919, '赛车跑道', '2026-03-06 13:39:52');
INSERT INTO `siteclassification` VALUES (1152735535375056920, '赛车道', '2026-03-06 13:39:52');
INSERT INTO `siteclassification` VALUES (1152735535375056921, '赛车线', '2026-03-06 13:39:52');
INSERT INTO `siteclassification` VALUES (1152735535375056923, '赛车道', '2026-03-06 13:39:52');
INSERT INTO `siteclassification` VALUES (1152735535375056924, '赛车线', '2026-03-06 13:39:52');
INSERT INTO `siteclassification` VALUES (1152735535375056925, '赛车场', '2026-03-06 13:39:52');
INSERT INTO `siteclassification` VALUES (1152735535375060997, '游泳池', '2026-03-06 13:39:52');
INSERT INTO `siteclassification` VALUES (1152735535375060998, '健身房', '2026-03-06 13:39:52');
INSERT INTO `siteclassification` VALUES (1152735535375061000, '保龄球馆', '2026-03-06 13:39:52');
INSERT INTO `siteclassification` VALUES (1152735535375061001, '台球厅', '2026-03-06 13:39:52');
INSERT INTO `siteclassification` VALUES (1152735535375061002, '瑜伽馆', '2026-03-06 13:39:52');
INSERT INTO `siteclassification` VALUES (1152735535375061006, '攀岩馆', '2026-03-06 13:39:52');
INSERT INTO `siteclassification` VALUES (1152735535375061008, '马术馆', '2026-03-06 13:39:52');
INSERT INTO `siteclassification` VALUES (1152735535375061013, '卡丁车场', '2026-03-06 13:39:52');
INSERT INTO `siteclassification` VALUES (1152735535375065088, '篮球场', '2026-03-06 13:39:52');
INSERT INTO `siteclassification` VALUES (1152735535375065089, '足球场', '2026-03-06 13:39:52');
INSERT INTO `siteclassification` VALUES (1152735535375065091, '羽毛球场', '2026-03-06 13:39:52');
INSERT INTO `siteclassification` VALUES (1152735535375065092, '排球场', '2026-03-06 13:39:52');
INSERT INTO `siteclassification` VALUES (1152735535375065099, '舞蹈室', '2026-03-06 13:39:52');
INSERT INTO `siteclassification` VALUES (1152735535375065105, '滑板场', '2026-03-06 13:39:52');
INSERT INTO `siteclassification` VALUES (1152735535375065107, '攀岩墙', '2026-03-06 13:39:52');
INSERT INTO `siteclassification` VALUES (1152735535375069186, '网球场', '2026-03-06 13:39:52');
INSERT INTO `siteclassification` VALUES (1152735535375069199, '射箭馆', '2026-03-06 13:39:52');
INSERT INTO `siteclassification` VALUES (1152735535375069202, '轮滑场', '2026-03-06 13:39:52');
INSERT INTO `siteclassification` VALUES (1152735535375069204, '射击场', '2026-03-06 13:39:52');
INSERT INTO `siteclassification` VALUES (1152735535375069210, '赛车场', '2026-03-06 13:39:52');

-- ----------------------------
-- Table structure for storeup
-- ----------------------------
DROP TABLE IF EXISTS `storeup`;
CREATE TABLE `storeup`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `userid` bigint NOT NULL COMMENT '用户id',
  `refid` bigint NOT NULL COMMENT '关联id',
  `tablename` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '表名',
  `name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '名称',
  `picture` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '图片',
  `type` int NOT NULL DEFAULT 1 COMMENT '类型(-1:踩,1:浏览,2:关注,3:收藏,4:点赞,5:喜欢)',
  `inteltype` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '推荐类型',
  `remark` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2055940753050009602 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '收藏表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of storeup
-- ----------------------------
INSERT INTO `storeup` VALUES (2029802057915793409, '2026-03-06 14:11:37', 1152735791059828739, 1152735662412136451, 'activityinformation', '乒乓球挑战赛', 'https://img2.baidu.com/it/u=1015939374%2C364123025&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=627', 4, NULL, NULL);
INSERT INTO `storeup` VALUES (2029802063146090497, '2026-03-06 14:11:38', 1152735791059828739, 1152735662412136451, 'activityinformation', '乒乓球挑战赛', 'https://img2.baidu.com/it/u=1015939374%2C364123025&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=627', 3, NULL, NULL);
INSERT INTO `storeup` VALUES (2029802106645217282, '2026-03-06 14:11:49', 1152735791059828739, 1152735655114047490, 'venueinformation', '青少年篮球训练营', 'https://img0.baidu.com/it/u=561570794%2C1291898217&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1044', 1, NULL, NULL);
INSERT INTO `storeup` VALUES (2045402607262597122, '2026-04-18 15:22:38', 1152735791059828742, 1152735655114047490, 'venueinformation', '青少年篮球训练营', 'https://img0.baidu.com/it/u=561570794%2C1291898217&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1044', 1, NULL, NULL);
INSERT INTO `storeup` VALUES (2045403737375866882, '2026-04-18 15:27:07', 1152735791059828742, 1152735655114047490, 'venueinformation', '青少年篮球训练营', 'https://img0.baidu.com/it/u=561570794%2C1291898217&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1044', 1, NULL, NULL);
INSERT INTO `storeup` VALUES (2046884476755783682, '2026-04-22 17:31:03', 1152735791059828742, 1152735655114047490, 'venueinformation', '青少年篮球训练营', 'https://img0.baidu.com/it/u=561570794%2C1291898217&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1044', 1, NULL, NULL);
INSERT INTO `storeup` VALUES (2049409604785942529, '2026-04-29 16:45:01', 1152735791059828742, 1152735655114047490, 'venueinformation', '青少年篮球训练营', 'https://img0.baidu.com/it/u=561570794%2C1291898217&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1044', 1, NULL, NULL);
INSERT INTO `storeup` VALUES (2049411880653041666, '2026-04-29 16:54:03', 1152735791059828742, 1152735655114047490, 'venueinformation', '青少年篮球训练营', 'https://img0.baidu.com/it/u=561570794%2C1291898217&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1044', 1, NULL, NULL);
INSERT INTO `storeup` VALUES (2049411917000880130, '2026-04-29 16:54:12', 1152735791059828742, 1152735655114047494, 'venueinformation', '市拳击馆', 'https://img1.baidu.com/it/u=1932176336%2C1348489562&fm=253&fmt=auto&app=138&f=JPEG?w=667&h=500', 1, NULL, NULL);
INSERT INTO `storeup` VALUES (2049413554494910465, '2026-04-29 17:00:42', 1152735791059828742, 1152735655114047498, 'venueinformation', '市台球馆', 'https://img0.baidu.com/it/u=285858192%2C1451896218&fm=253&fmt=auto&app=138&f=JPEG?w=688&h=500', 1, NULL, NULL);
INSERT INTO `storeup` VALUES (2049414006489886722, '2026-04-29 17:02:30', 1152735791059828742, 1152735655114047498, 'venueinformation', '市台球馆', 'https://img0.baidu.com/it/u=285858192%2C1451896218&fm=253&fmt=auto&app=138&f=JPEG?w=688&h=500', 1, NULL, NULL);
INSERT INTO `storeup` VALUES (2049414343544156162, '2026-04-29 17:03:50', 1152735791059828742, 1152735655114047498, 'venueinformation', '市台球馆', 'https://img0.baidu.com/it/u=285858192%2C1451896218&fm=253&fmt=auto&app=138&f=JPEG?w=688&h=500', 1, NULL, NULL);
INSERT INTO `storeup` VALUES (2049415594432409602, '2026-04-29 17:08:49', 1152735791059828742, 1152735655114047498, 'venueinformation', '市台球馆', 'https://img0.baidu.com/it/u=285858192%2C1451896218&fm=253&fmt=auto&app=138&f=JPEG?w=688&h=500', 1, NULL, NULL);
INSERT INTO `storeup` VALUES (2054386002348871682, '2026-05-13 10:19:26', 1152735791059828742, 1152735655114047490, 'venueinformation', '青少年篮球训练营', 'https://img0.baidu.com/it/u=561570794%2C1291898217&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1044', 1, NULL, NULL);
INSERT INTO `storeup` VALUES (2054389024521064449, '2026-05-13 10:31:27', 1152735791059828742, 1152735655114047490, 'venueinformation', '青少年篮球训练营', 'https://img0.baidu.com/it/u=561570794%2C1291898217&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1044', 1, NULL, NULL);
INSERT INTO `storeup` VALUES (2055915098837061634, '2026-05-17 15:35:31', 1152735791059832853, 1152735655114047490, 'venueinformation', '青少年篮球训练营', 'https://img0.baidu.com/it/u=561570794%2C1291898217&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1044', 1, NULL, NULL);
INSERT INTO `storeup` VALUES (2055940753050009601, '2026-05-17 17:17:28', 1152735791059828742, 1152735655114047494, 'venueinformation', '市拳击馆', 'https://img1.baidu.com/it/u=1932176336%2C1348489562&fm=253&fmt=auto&app=138&f=JPEG?w=667&h=500', 1, NULL, NULL);

-- ----------------------------
-- Table structure for sys_attachment
-- ----------------------------
DROP TABLE IF EXISTS `sys_attachment`;
CREATE TABLE `sys_attachment`  (
  `id` bigint NOT NULL COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '附件名称',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '附件地址',
  `size` bigint NULL DEFAULT NULL COMMENT '附件大小',
  `platform` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '存储平台',
  `creator` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '附件管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_attachment
-- ----------------------------
INSERT INTO `sys_attachment` VALUES (2029801505303658498, 'pexels_architecture_290595.jpg', 'api/upload/pexels_architecture_290595_50965.jpg', 41662, 'LOCAL', NULL, NULL);
INSERT INTO `sys_attachment` VALUES (2029801583980412929, 'pexels_architecture_290595.jpg', 'api/upload/pexels_architecture_290595_50984.jpg', 41662, 'LOCAL', NULL, NULL);
INSERT INTO `sys_attachment` VALUES (2029801601676181505, 'pexels_architecture_276724.jpg', 'api/upload/pexels_architecture_276724_50988.jpg', 82903, 'LOCAL', NULL, NULL);
INSERT INTO `sys_attachment` VALUES (2029802397897687041, 'pexels_architecture_276724.jpg', 'api/upload/pexels_architecture_276724_51178.jpg', 82903, 'LOCAL', NULL, NULL);
INSERT INTO `sys_attachment` VALUES (2029802451270205441, 'pexels_architecture_271667.jpg', 'api/upload/pexels_architecture_271667_51190.jpg', 57289, 'LOCAL', NULL, NULL);
INSERT INTO `sys_attachment` VALUES (2042499381290840065, 'ca140cfc5974fbb9f146f06baf3bfce3.jpeg', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54374.jpeg', 60320, 'LOCAL', NULL, NULL);
INSERT INTO `sys_attachment` VALUES (2042499477994713089, 'ca140cfc5974fbb9f146f06baf3bfce3.jpeg', 'api/upload/ca140cfc5974fbb9f146f06baf3bfce3_54398.jpeg', 60320, 'LOCAL', NULL, NULL);
INSERT INTO `sys_attachment` VALUES (2042499528812900354, 'PNG.png', 'api/upload/PNG_54410.png', 2546011, 'LOCAL', NULL, NULL);
INSERT INTO `sys_attachment` VALUES (2047914775287562242, 'PNG.png', 'api/upload/PNG_49505.png', 2546011, 'LOCAL', NULL, NULL);
INSERT INTO `sys_attachment` VALUES (2048006870035845121, 'PNG.png', 'api/upload/PNG_71462.png', 2546011, 'LOCAL', NULL, NULL);
INSERT INTO `sys_attachment` VALUES (2048734624574312450, '商品实体图.png', 'api/upload/商品实体图_72172.png', 114560, 'LOCAL', NULL, NULL);
INSERT INTO `sys_attachment` VALUES (2048734673119186945, 'PNG.png', 'api/upload/PNG_72184.png', 2546011, 'LOCAL', NULL, NULL);
INSERT INTO `sys_attachment` VALUES (2048746925511622657, 'PNG.png', 'api/upload/PNG_75105.png', 2546011, 'LOCAL', NULL, NULL);
INSERT INTO `sys_attachment` VALUES (2049058673775067137, '羽毛球.jpg', 'api/upload/羽毛球_63032.jpg', 363003, 'LOCAL', NULL, NULL);
INSERT INTO `sys_attachment` VALUES (2049058705454645249, '乒乓球.jpg', 'api/upload/乒乓球_63039.jpg', 34068, 'LOCAL', NULL, NULL);
INSERT INTO `sys_attachment` VALUES (2049058754104377345, '羽毛球.jpg', 'api/upload/羽毛球_63051.jpg', 363003, 'LOCAL', NULL, NULL);
INSERT INTO `sys_attachment` VALUES (2049059573847539714, '羽毛球.jpg', 'api/upload/羽毛球_63246.jpg', 363003, 'LOCAL', NULL, NULL);
INSERT INTO `sys_attachment` VALUES (2049059845802016770, '羽毛球拍.webp', 'api/upload/羽毛球拍_63311.webp', 6846, 'LOCAL', NULL, NULL);
INSERT INTO `sys_attachment` VALUES (2049402104669941762, 'PNG.png', 'api/upload/PNG_58512.png', 2546011, 'LOCAL', NULL, NULL);

-- ----------------------------
-- Table structure for systemintro
-- ----------------------------
DROP TABLE IF EXISTS `systemintro`;
CREATE TABLE `systemintro`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `title` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '标题',
  `subtitle` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '副标题',
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '内容',
  `picture1` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '图片1',
  `picture2` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '图片2',
  `picture3` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '图片3',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '关于我们' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of systemintro
-- ----------------------------
INSERT INTO `systemintro` VALUES (1, '2026-03-06 12:12:55', '系统简介', 'SYSTEM INTRODUCTION', '人生犹如一场漫长的征途，途中充满了挑战与未知。然而，正是这些挑战，塑造了我们坚韧不拔的品格。无论前方有多少艰难险阻，只要我们怀揣梦想，秉持着坚定的信念，一步一个脚印地勇往直前，就能穿越黑暗，迎接黎明的曙光。就像那些伟大的人物，他们在困境中不屈不挠，凭借着顽强的毅力和对梦想的执着追求，最终实现了人生的价值。所以，让我们以他们为榜样，在逐梦的道路上，不畏艰难，砥砺前行，相信终有一天，我们也能站在梦想的巅峰，俯瞰世界。', 'https://img1.baidu.com/it/u=830161647,194147596&fm=253&fmt=auto&app=138&f=JPEG?w=1422&h=800', 'https://img1.baidu.com/it/u=4167354562,4085498952&fm=253&fmt=auto&app=120&f=JPEG?w=1024&h=640', 'https://img0.baidu.com/it/u=3573020317,210193071&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500');

-- ----------------------------
-- Table structure for text_content
-- ----------------------------
DROP TABLE IF EXISTS `text_content`;
CREATE TABLE `text_content`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '文本消息ID',
  `content` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文本消息',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `admin_id` bigint NULL DEFAULT NULL COMMENT '管理员id',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_id`(`id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2056247478630174723 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of text_content
-- ----------------------------
INSERT INTO `text_content` VALUES (2029801631409602561, '{\"type\":0,\"content\":\"您好\n\"}', '2026-03-06 14:09:55', '2026-03-06 14:09:55', NULL, NULL);
INSERT INTO `text_content` VALUES (2029802181685510145, '{\"type\":0,\"content\":\"您好\n\"}', '2026-03-06 14:12:06', '2026-03-06 14:12:06', NULL, NULL);
INSERT INTO `text_content` VALUES (2045041174075113473, '{\"type\":0,\"content\":\"你好\\n\"}', '2026-04-17 15:26:25', '2026-04-17 15:26:25', NULL, NULL);
INSERT INTO `text_content` VALUES (2054385432963715073, '{\"type\":0,\"content\":\"111\"}', '2026-05-13 10:17:10', '2026-05-13 10:17:10', NULL, NULL);
INSERT INTO `text_content` VALUES (2055913850306007042, '{\"type\":0,\"content\":\"test\\n\"}', '2026-05-17 15:30:33', '2026-05-17 15:30:33', NULL, NULL);
INSERT INTO `text_content` VALUES (2055914656719671298, '{\"type\":0,\"content\":\"11\"}', '2026-05-17 15:33:45', '2026-05-17 15:33:45', NULL, NULL);
INSERT INTO `text_content` VALUES (2056246520906993665, '{\"type\":0,\"content\":\"4545\\n\"}', '2026-05-18 13:32:28', '2026-05-18 13:32:28', NULL, NULL);
INSERT INTO `text_content` VALUES (2056247462461132801, '{\"type\":0,\"content\":\"56556\\n\"}', '2026-05-18 13:36:12', '2026-05-18 13:36:12', NULL, NULL);
INSERT INTO `text_content` VALUES (2056247478630174722, '{\"type\":0,\"content\":\"145456\\n\"}', '2026-05-18 13:36:16', '2026-05-18 13:36:16', NULL, NULL);

-- ----------------------------
-- Table structure for tousufankui
-- ----------------------------
DROP TABLE IF EXISTS `tousufankui`;
CREATE TABLE `tousufankui`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '投诉原因',
  `photo` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '投诉照片',
  `detail` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '投诉简介',
  `details` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '投诉详情',
  `userid` bigint NULL DEFAULT NULL COMMENT '投诉人id',
  `username` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '投诉人名字',
  `status` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '投诉状态',
  `fankuijieguo` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '反馈结果',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1743547502863691779 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '投诉反馈' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tousufankui
-- ----------------------------
INSERT INTO `tousufankui` VALUES (1152735599346581505, '卫生条件差', 'https://img2.baidu.com/it/u=4238008982%2C3415112765&fm=253&fmt=auto&app=138&f=JPEG?w=667&h=500', '更衣室地面有积水，清洁不及时', '更衣室地面湿滑，有异味，垃圾桶满溢未清理', 1002, 'user002', '已解决', '已加强清洁频次，安排专人每日检查', '2026-03-06 13:39:55');
INSERT INTO `tousufankui` VALUES (1152735599346581509, '器材老化', 'https://img2.baidu.com/it/u=2117562773%2C246804075&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500', '跑步机按键失灵', '多台跑步机按键损坏，无法正常使用', 1006, 'user006', '已解决', '已更换损坏器材', '2026-03-06 13:39:55');
INSERT INTO `tousufankui` VALUES (1152735599346581511, '安全出口标识不清', 'https://img1.baidu.com/it/u=91415690%2C1556522903&fm=253&fmt=auto&app=138&f=JPEG?w=668&h=500', '紧急出口标志模糊', '安全出口标志不清晰，影响紧急疏散', 1008, 'user008', '已解决', '已更换新标识', '2026-03-06 13:39:55');
INSERT INTO `tousufankui` VALUES (1152735599346581521, '门锁故障', 'https://img0.baidu.com/it/u=3587602560%2C3208329373&fm=253&fmt=auto&app=120&f=JPEG?w=667&h=500', '门锁无法正常开启', '部分门锁损坏，影响出入', 1018, 'user018', '已解决', '已维修门锁', '2026-03-06 13:39:55');
INSERT INTO `tousufankui` VALUES (1152735599346581533, '音响杂音', 'https://img2.baidu.com/it/u=2574830298%2C3495913871&fm=253&fmt=auto&app=138&f=JPEG?w=667&h=500', '音响有杂音', '音响播放时有杂音', 1030, 'user030', '已解决', '已调试音响设备', '2026-03-06 13:39:55');
INSERT INTO `tousufankui` VALUES (1152735599346585606, '空调故障', 'https://img1.baidu.com/it/u=1865853346%2C874477068&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889', '室内温度过高', '空调无法制冷，室内闷热', 1007, 'user007', '处理中', '维修人员正在排查', '2026-03-06 13:39:55');
INSERT INTO `tousufankui` VALUES (1152735599346585609, '储物柜不足', 'https://img2.baidu.com/it/u=3599861838%2C3389309650&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=800', '储物柜数量不够', '高峰时段储物柜紧张', 1010, 'user010', '已解决', '已增加储物柜数量', '2026-03-06 13:39:55');
INSERT INTO `tousufankui` VALUES (1152735599346585610, '水质不佳', 'https://img1.baidu.com/it/u=2257782418%2C2707402055&fm=253&fmt=auto&app=138&f=JPEG?w=1066&h=800', '饮用水有异味', '直饮水有异味，无法饮用', 1011, 'user011', '处理中', '已联系水质检测', '2026-03-06 13:39:55');
INSERT INTO `tousufankui` VALUES (1152735599346585612, '通风不良', 'https://img1.baidu.com/it/u=3604396689%2C3679578144&fm=253&fmt=auto&app=138&f=JPEG?w=750&h=500', '室内闷热不透气', '通风系统故障，空气不流通', 1013, 'user013', '处理中', '正在检修通风设备', '2026-03-06 13:39:55');
INSERT INTO `tousufankui` VALUES (1152735599346585613, '照明损坏', 'https://img2.baidu.com/it/u=1329702238%2C2810685087&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=326', '部分区域灯光熄灭', '多个区域灯光不亮', 1014, 'user014', '已解决', '已更换损坏灯具', '2026-03-06 13:39:55');
INSERT INTO `tousufankui` VALUES (1152735599346585614, '噪音污染', 'https://img2.baidu.com/it/u=2687093165%2C56522183&fm=253&fmt=auto&app=138&f=JPEG?w=1067&h=800', '施工噪音扰民', '施工时噪音过大，影响使用', 1015, 'user015', '处理中', '已要求控制施工时间', '2026-03-06 13:39:55');
INSERT INTO `tousufankui` VALUES (1152735599346585618, '温度过高', 'https://img1.baidu.com/it/u=109058075%2C3156841317&fm=253&fmt=auto&app=138&f=JPEG?w=712&h=473', '室内过热', '夏季室内温度过高', 1019, 'user019', '处理中', '正在调整空调系统', '2026-03-06 13:39:55');
INSERT INTO `tousufankui` VALUES (1152735599346585620, '音响设备故障', 'https://img2.baidu.com/it/u=782077879%2C771786742&fm=253&fmt=auto&app=138&f=JPEG?w=666&h=500', '音响无法使用', '音响设备损坏，无法播放音乐', 1021, 'user021', '处理中', '正在检修设备', '2026-03-06 13:39:55');
INSERT INTO `tousufankui` VALUES (1152735599346585621, '灯光闪烁', 'https://img2.baidu.com/it/u=376509500%2C1173870542&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', '灯光频繁闪烁', '部分区域灯光闪烁不停', 1022, 'user022', '已解决', '已更换损坏灯具', '2026-03-06 13:39:55');
INSERT INTO `tousufankui` VALUES (1152735599346585622, '通风口堵塞', 'https://img1.baidu.com/it/u=2167451134%2C3755067372&fm=253&fmt=auto&app=138&f=JPEG?w=1067&h=800', '空调出风口堵塞', '空调出风口被杂物堵塞', 1023, 'user023', '处理中', '正在清理通风口', '2026-03-06 13:39:55');
INSERT INTO `tousufankui` VALUES (1152735599346585623, '地面不平', 'https://img0.baidu.com/it/u=1775220045%2C4175142288&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', '地面有凹凸', '地面不平，影响行走', 1024, 'user024', '已解决', '已平整地面', '2026-03-06 13:39:55');
INSERT INTO `tousufankui` VALUES (1152735599346589696, '设施损坏未及时维修', 'https://img2.baidu.com/it/u=1951396997%2C3709030908&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', '体育馆篮球架出现松动，存在安全隐患', '篮球架底座螺丝松动，篮筐轻微晃动，已持续一周未维修', 1001, 'user001', '处理中', '已安排维修人员今日到场检修', '2026-03-06 13:39:55');
INSERT INTO `tousufankui` VALUES (1152735599346589698, '照明不足', 'https://img1.baidu.com/it/u=2976352065%2C487162912&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', '夜间训练光线昏暗', '晚上使用场地时灯光不足，影响运动安全', 1003, 'user003', '处理中', '正在申请增加照明设备', '2026-03-06 13:39:55');
INSERT INTO `tousufankui` VALUES (1152735599346589711, '器材维护不及时', 'https://img2.baidu.com/it/u=304887579%2C2701592974&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', '哑铃生锈', '哑铃表面生锈，影响使用', 1016, 'user016', '已解决', '已安排清洁保养', '2026-03-06 13:39:55');
INSERT INTO `tousufankui` VALUES (1152735599346589712, '卫生纸不足', 'https://img0.baidu.com/it/u=1909893350%2C264833725&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=669', '洗手间卫生纸经常缺货', '洗手间卫生纸补充不及时', 1017, 'user017', '处理中', '已增加补充频次', '2026-03-06 13:39:55');
INSERT INTO `tousufankui` VALUES (1152735599346589715, '地板破损', 'https://img0.baidu.com/it/u=3980705395%2C2420069715&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889', '地板有裂缝', '地板出现裂缝，存在安全隐患', 1020, 'user020', '已解决', '已安排地板维修', '2026-03-06 13:39:55');
INSERT INTO `tousufankui` VALUES (1152735599346589721, '水质浑浊', 'https://img2.baidu.com/it/u=2772457975%2C2424052802&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', '饮用水浑浊', '直饮水出现浑浊现象', 1026, 'user026', '已解决', '已更换滤芯', '2026-03-06 13:39:55');
INSERT INTO `tousufankui` VALUES (1152735599346589722, '门锁松动', 'https://img1.baidu.com/it/u=370167867%2C93568418&fm=253&fmt=auto&app=138&f=JPEG?w=1082&h=500', '门锁松动', '门锁松动，无法正常锁闭', 1027, 'user027', '处理中', '正在加固门锁', '2026-03-06 13:39:55');
INSERT INTO `tousufankui` VALUES (1152735599346589723, '温度过低', 'https://img0.baidu.com/it/u=3454759298%2C2567471768&fm=253&fmt=auto&app=138&f=JPEG?w=666&h=500', '室内过冷', '冬季室内温度过低', 1028, 'user028', '已解决', '已调整空调温度', '2026-03-06 13:39:55');
INSERT INTO `tousufankui` VALUES (1152735599346589724, '地板湿滑', 'https://img1.baidu.com/it/u=2926284326%2C4056502686&fm=253&fmt=auto&app=138&f=JPEG?w=668&h=500', '地板湿滑', '地板潮湿，容易滑倒', 1029, 'user029', '处理中', '已加强地面干燥', '2026-03-06 13:39:55');
INSERT INTO `tousufankui` VALUES (1152735599346593795, '预约系统故障', 'https://img2.baidu.com/it/u=5636265%2C3671306505&fm=253&fmt=auto&app=138&f=JPEG?w=1082&h=500', '无法正常预约场地', '系统频繁崩溃，预约失败率高', 1004, 'user004', '已解决', '系统已修复，运行正常', '2026-03-06 13:39:55');
INSERT INTO `tousufankui` VALUES (1152735599346593796, '噪音扰民', 'https://img0.baidu.com/it/u=65663101%2C3524415776&fm=253&fmt=auto&app=138&f=JPEG?w=749&h=500', '夜间音响声音过大', '晚上使用音响时音量过大，影响周边居民休息', 1005, 'user005', '处理中', '已限制夜间音响使用音量', '2026-03-06 13:39:55');
INSERT INTO `tousufankui` VALUES (1152735599346593800, '地面湿滑', 'https://img0.baidu.com/it/u=3332927025%2C451948525&fm=253&fmt=auto&app=138&f=JPEG?w=667&h=500', '雨天地面未及时清理', '下雨后地面湿滑，未放置防滑警示', 1009, 'user009', '处理中', '已加强雨天地面清理', '2026-03-06 13:39:55');
INSERT INTO `tousufankui` VALUES (1152735599346593803, '开放时间不合理', 'https://img1.baidu.com/it/u=1546659306%2C2855914671&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=332', '关门时间太早', '晚上关门时间过早，影响训练', 1012, 'user012', '已解决', '已延长开放时间至晚上10点', '2026-03-06 13:39:55');
INSERT INTO `tousufankui` VALUES (1152735599346593816, '储物柜损坏', 'https://img1.baidu.com/it/u=443829229%2C4108454566&fm=253&fmt=auto&app=138&f=JPEG?w=499&h=333', '储物柜门无法关闭', '多个储物柜门损坏', 1025, 'user025', '处理中', '正在维修储物柜', '2026-03-06 13:39:55');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '密码',
  `role` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '3' COMMENT '角色',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `avatarurl` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '头像',
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `money` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '0' COMMENT '余额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2055988176954728450 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1152735791059828739, 'user004', '04e09609497b99b836c2c67883f55bc2d5c5f1dfd8f6b44c75ce1ee0d5ffbc4d', '1', '刘洋', 'https://img0.baidu.com/it/u=2135737441%2C2485979813&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666', '138001380089', 'liuyang@example.com', '2026-03-06 13:40:07', '10300.0');
INSERT INTO `user` VALUES (1152735791059828742, 'user007', 'b3b72761d8db8c78dd195bcd433f29b97d80c7ecf81dfd54819542bdc706740e', '1', '周丽', 'https://img1.baidu.com/it/u=2939552026%2C234974731&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', '13800138007', 'zhoul@example.com', '2026-03-06 13:40:07', '380.0');
INSERT INTO `user` VALUES (1152735791059828750, 'user015', 'b3b72761d8db8c78dd195bcd433f29b97d80c7ecf81dfd54819542bdc706740e', '1', '高飞', 'https://img2.baidu.com/it/u=2070187165%2C3764625&fm=253&fmt=auto&app=120&f=JPEG?w=756&h=1159', '13800138015', 'gaofei@example.com', '2026-03-06 13:40:07', '260.00');
INSERT INTO `user` VALUES (1152735791059828751, 'user016', 'b3b72761d8db8c78dd195bcd433f29b97d80c7ecf81dfd54819542bdc706740e', '1', '黄丽', 'https://img0.baidu.com/it/u=3549247650%2C430636279&fm=253&fmt=auto&app=138&f=JPEG?w=731&h=500', '13800138016', 'huangling@example.com', '2026-03-06 13:40:07', '270.00');
INSERT INTO `user` VALUES (1152735791059832839, 'user008', 'b3b72761d8db8c78dd195bcd433f29b97d80c7ecf81dfd54819542bdc706740e', '1', '吴军', 'https://img2.baidu.com/it/u=1518701867%2C3292064128&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', '13800138008', 'wujun@example.com', '2026-03-06 13:40:07', '170.00');
INSERT INTO `user` VALUES (1152735791059832840, 'user009', 'b3b72761d8db8c78dd195bcd433f29b97d80c7ecf81dfd54819542bdc706740e', '1', '郑华', 'https://img0.baidu.com/it/u=3725153846%2C3103058900&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=708', '13800138009', 'zhenghua@example.com', '2026-03-06 13:40:07', '280.00');
INSERT INTO `user` VALUES (1152735791059832841, 'user010', 'b3b72761d8db8c78dd195bcd433f29b97d80c7ecf81dfd54819542bdc706740e', '1', '孙芳', 'https://img0.baidu.com/it/u=1513772456%2C3834267842&fm=253&fmt=auto&app=120&f=JPEG?w=800&h=1056', '13800138010', 'sunfang@example.com', '2026-03-06 13:40:07', '190.00');
INSERT INTO `user` VALUES (1152735791059832844, 'user013', 'b3b72761d8db8c78dd195bcd433f29b97d80c7ecf81dfd54819542bdc706740e', '1', '郭磊', 'https://img2.baidu.com/it/u=1413550264%2C2214978947&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=1124', '13800138013', 'guolei@example.com', '2026-03-06 13:40:07', '160.00');
INSERT INTO `user` VALUES (1152735791059832848, 'user017', 'b3b72761d8db8c78dd195bcd433f29b97d80c7ecf81dfd54819542bdc706740e', '1', '徐涛', 'https://img2.baidu.com/it/u=3134823380%2C4132922175&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=722', '13800138017', 'xutao@example.com', '2026-03-06 13:40:07', '140.00');
INSERT INTO `user` VALUES (1152735791059832853, 'user022', 'b3b72761d8db8c78dd195bcd433f29b97d80c7ecf81dfd54819542bdc706740e', '1', '石磊', 'https://img1.baidu.com/it/u=3767016028%2C718846990&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500', '13800138022', 'shilei@example.com', '2026-03-06 13:40:07', '108.00');
INSERT INTO `user` VALUES (1152735791059832857, 'user026', 'b3b72761d8db8c78dd195bcd433f29b97d80c7ecf81dfd54819542bdc706740e', '1', '秦明', 'https://img0.baidu.com/it/u=1493976991%2C87048605&fm=253&fmt=auto?w=500&h=764', '13800138026', 'qinming@example.com', '2026-03-06 13:40:07', '118.00');
INSERT INTO `user` VALUES (1152735791059832858, 'user027', 'b3b72761d8db8c78dd195bcd433f29b97d80c7ecf81dfd54819542bdc706740e', '1', '尤静', 'https://img1.baidu.com/it/u=1249968943%2C3080466216&fm=253&fmt=auto&app=138&f=JPEG?w=812&h=500', '13800138027', 'youjing@example.com', '2026-03-06 13:40:07', '125.00');
INSERT INTO `user` VALUES (1152735791059832859, 'user028', 'b3b72761d8db8c78dd195bcd433f29b97d80c7ecf81dfd54819542bdc706740e', '1', '许强', 'https://img0.baidu.com/it/u=3264376092%2C3640635402&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=986', '13800138028', 'xuqiang@example.com', '2026-03-06 13:40:07', '128.00');
INSERT INTO `user` VALUES (1152735791059836929, 'user002', 'b3b72761d8db8c78dd195bcd433f29b97d80c7ecf81dfd54819542bdc706740e', '1', '李娜', 'https://img1.baidu.com/it/u=507963813%2C909021067&fm=253&fmt=auto&app=138&f=JPEG?w=755&h=500', '13800138002', 'lina@example.com', '2026-03-06 13:40:07', '200.00');
INSERT INTO `user` VALUES (1152735791059836930, 'user003', 'b3b72761d8db8c78dd195bcd433f29b97d80c7ecf81dfd54819542bdc706740e', '1', '王强', 'https://img2.baidu.com/it/u=1168124860%2C3472107516&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1091', '13800138003', 'wangqiang@example.com', '2026-03-06 13:40:07', '150.00');
INSERT INTO `user` VALUES (1152735791059836946, 'user019', 'b3b72761d8db8c78dd195bcd433f29b97d80c7ecf81dfd54819542bdc706740e', '1', '吕明', 'https://img0.baidu.com/it/u=2102223865%2C1929461595&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1556', '13800138019', 'lvming@example.com', '2026-03-06 13:40:07', '120.00');
INSERT INTO `user` VALUES (1152735791059836947, 'user020', 'b3b72761d8db8c78dd195bcd433f29b97d80c7ecf81dfd54819542bdc706740e', '1', '丁红', 'https://img0.baidu.com/it/u=1780920050%2C1984547981&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=652', '13800138020', 'dinghong@example.com', '2026-03-06 13:40:07', '110.00');
INSERT INTO `user` VALUES (1152735791059836950, 'user023', 'b3b72761d8db8c78dd195bcd433f29b97d80c7ecf81dfd54819542bdc706740e', '1', '史静', 'https://img1.baidu.com/it/u=914176501%2C4073589602&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=706', '13800138023', 'shijing@example.com', '2026-03-06 13:40:07', '109.00');
INSERT INTO `user` VALUES (1152735791059836952, 'user025', 'b3b72761d8db8c78dd195bcd433f29b97d80c7ecf81dfd54819542bdc706740e', '1', '朱红', 'https://img2.baidu.com/it/u=2623558041%2C870893650&fm=253&fmt=auto?w=800&h=4918', '13800138025', 'zhuhong@example.com', '2026-03-06 13:40:07', '115.00');
INSERT INTO `user` VALUES (1152735791059836956, 'user029', 'b3b72761d8db8c78dd195bcd433f29b97d80c7ecf81dfd54819542bdc706740e', '1', '何丽', 'https://img1.baidu.com/it/u=1580590365%2C1329900301&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=512', '13800138029', 'heli@example.com', '2026-03-06 13:40:07', '135.00');
INSERT INTO `user` VALUES (1152735791059841024, 'user001', 'b3b72761d8db8c78dd195bcd433f29b97d80c7ecf81dfd54819542bdc706740e', '1', '张伟', 'https://img0.baidu.com/it/u=2974370142%2C3654507290&fm=253&fmt=auto&app=138&f=JPEG?w=691&h=500', '13800138001', 'zhangwei@example.com', '2026-03-06 13:40:07', '100.00');
INSERT INTO `user` VALUES (1152735791059841028, 'user005', 'b3b72761d8db8c78dd195bcd433f29b97d80c7ecf81dfd54819542bdc706740e', '1', '陈静', 'https://img0.baidu.com/it/u=1995727433%2C3217111540&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666', '13800138005', 'chenjing@example.com', '2026-03-06 13:40:07', '250.00');
INSERT INTO `user` VALUES (1152735791059841029, 'user006', 'b3b72761d8db8c78dd195bcd433f29b97d80c7ecf81dfd54819542bdc706740e', '1', '杨帆', 'https://t13.baidu.com/it/u=472029912%2C3804784203&fm=224&app=112&f=JPEG?w=500&h=500', '13800138006', 'yangfan@example.com', '2026-03-06 13:40:07', '180.00');
INSERT INTO `user` VALUES (1152735791059841034, 'user011', 'b3b72761d8db8c78dd195bcd433f29b97d80c7ecf81dfd54819542bdc706740e', '1', '马超', 'https://img0.baidu.com/it/u=3585856888%2C2440262292&fm=253&fmt=auto&app=120&f=JPEG?w=884&h=500', '13800138011', 'machao@example.com', '2026-03-06 13:40:07', '210.00');
INSERT INTO `user` VALUES (1152735791059841035, 'user012', 'b3b72761d8db8c78dd195bcd433f29b97d80c7ecf81dfd54819542bdc706740e', '1', '胡敏', 'https://img2.baidu.com/it/u=2270537349%2C2559979928&fm=253&fmt=auto&app=120&f=JPEG?w=456&h=2574', '13800138012', 'humin@example.com', '2026-03-06 13:40:07', '230.00');
INSERT INTO `user` VALUES (1152735791059841037, 'user014', 'b3b72761d8db8c78dd195bcd433f29b97d80c7ecf81dfd54819542bdc706740e', '1', '林雪', 'https://img0.baidu.com/it/u=2087392242%2C652570624&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=2822', '13800138014', 'linxue@example.com', '2026-03-06 13:40:07', '240.00');
INSERT INTO `user` VALUES (1152735791059841041, 'user018', 'b3b72761d8db8c78dd195bcd433f29b97d80c7ecf81dfd54819542bdc706740e', '1', '何静', 'https://img1.baidu.com/it/u=3547388911%2C3827634692&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=704', '13800138018', 'hejing@example.com', '2026-03-06 13:40:07', '130.00');
INSERT INTO `user` VALUES (1152735791059841044, 'user021', 'b3b72761d8db8c78dd195bcd433f29b97d80c7ecf81dfd54819542bdc706740e', '1', '田亮', 'https://img2.baidu.com/it/u=3862996196%2C4013019154&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=527', '13800138021', 'tianliang@example.com', '2026-03-06 13:40:07', '105.00');
INSERT INTO `user` VALUES (1152735791059841047, 'user024', 'b3b72761d8db8c78dd195bcd433f29b97d80c7ecf81dfd54819542bdc706740e', '1', '白强', 'https://img2.baidu.com/it/u=3144819430%2C3900022181&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=561', '13800138024', 'baiqiang@example.com', '2026-03-06 13:40:07', '112.00');
INSERT INTO `user` VALUES (1152735791059841053, 'user030', 'b3b72761d8db8c78dd195bcd433f29b97d80c7ecf81dfd54819542bdc706740e', '1', '贾明', 'https://img1.baidu.com/it/u=3354398414%2C3952415046&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=661', '13800138030', 'jiaming@example.com', '2026-03-06 13:40:07', '145.00');

-- ----------------------------
-- Table structure for venueinformation
-- ----------------------------
DROP TABLE IF EXISTS `venueinformation`;
CREATE TABLE `venueinformation`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '场地名称',
  `clubname` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '俱乐部名称',
  `classify` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用途类型',
  `yardstate` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '场地状态',
  `venuespecifications` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '场地规格',
  `supportingfacilities` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT ' 配套设施',
  `serviceinformation` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '服务信息',
  `introduction` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '简介',
  `photo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '封面',
  `photos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '详情图',
  `details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '详细信息',
  `adduserid` bigint NULL DEFAULT NULL COMMENT '创建人id',
  `addusername` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人名称',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1152735655114059805 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '场地信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of venueinformation
-- ----------------------------
INSERT INTO `venueinformation` VALUES (1152735655114047490, '青少年篮球训练营', '市青少年篮球俱乐部', '青少年培训', '正常开放', '篮球场尺寸：28米×15米\n标准篮球架', '更衣室、淋浴间、观众席、训练器材', '专业篮球教练、体能训练、比赛组织', '专注于青少年篮球技能培养，通过系统训练提升孩子们的篮球水平和团队协作能力。', 'https://img0.baidu.com/it/u=561570794%2C1291898217&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1044', 'https://img2.baidu.com/it/u=4222538980%2C2714434286&fm=253&fmt=auto&app=138&f=JPEG?w=675&h=500', '详细介绍：青少年篮球训练营拥有专业的教练团队，采用科学的教学方法，针对不同年龄段学员制定个性化训练计划。场馆设施完善，为青少年提供安全、专业的训练环境。', 3, 'user002', '2026-03-06 13:39:59');
INSERT INTO `venueinformation` VALUES (1152735655114047494, '市拳击馆', '市拳击俱乐部', '拳击训练', '正常开放', '拳击馆面积：300平方米\n标准拳击台', '更衣室、淋浴间、观众席、训练器材', '拳击教学、比赛组织、体能训练', '专业的拳击训练场馆，拥有标准拳击台和完善的训练设施，为拳击爱好者提供专业的训练环境。', 'https://img1.baidu.com/it/u=1932176336%2C1348489562&fm=253&fmt=auto&app=138&f=JPEG?w=667&h=500', 'https://img0.baidu.com/it/u=4099048394%2C1850690692&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1571', '详细介绍：市拳击馆是本市最专业的拳击训练基地，拥有标准拳击台和全套训练器械。我们提供从入门到高级的拳击培训课程，培养拳击人才。', 7, 'user004', '2026-03-06 13:39:59');
INSERT INTO `venueinformation` VALUES (1152735655114047498, '市台球馆', '市台球俱乐部', '台球训练', '正常开放', '台球馆面积：150平方米\n标准台球桌', '更衣室、淋浴间、观众席、训练器材', '台球教学、比赛组织、体能训练', '专业的台球训练场馆，拥有标准台球桌和完善的训练设施，为台球爱好者提供专业的训练环境。', 'https://img0.baidu.com/it/u=285858192%2C1451896218&fm=253&fmt=auto&app=138&f=JPEG?w=688&h=500', 'https://img1.baidu.com/it/u=1932176336%2C1348489562&fm=253&fmt=auto&app=138&f=JPEG?w=667&h=500', '详细介绍：市台球馆是本市最专业的台球训练基地，拥有全套国际标准台球器械。我们提供从入门到高级的台球培训课程，培养台球人才。', 11, 'user006', '2026-03-06 13:39:59');
INSERT INTO `venueinformation` VALUES (1152735655114047499, '市保龄球馆', '市保龄球俱乐部', '保龄球训练', '正常开放', '保龄球馆面积：200平方米\n标准保龄球道', '更衣室、淋浴间、观众席、训练器材', '保龄球教学、比赛组织、体能训练', '专业的保龄球训练场馆，拥有标准保龄球道和完善的训练设施，为保龄球爱好者提供专业的训练环境。', 'https://img1.baidu.com/it/u=2544375385%2C382706932&fm=253&fmt=auto&app=120&f=JPEG?w=722&h=500', 'https://img2.baidu.com/it/u=2843984095%2C3752921441&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', '详细介绍：市保龄球馆是本市最专业的保龄球训练基地，拥有全套国际标准保龄球器械。我们提供从基础到高级的保龄球培训课程，培养保龄球人才。', 12, 'volunteers006', '2026-03-06 13:39:59');
INSERT INTO `venueinformation` VALUES (1152735655114047502, '市高尔夫练习场', '市高尔夫俱乐部', '高尔夫训练', '正常开放', '高尔夫练习场面积：1000平方米\n标准高尔夫球杆', '更衣室、淋浴间、观众席、训练器材', '高尔夫教学、比赛组织、体能训练', '专业的高尔夫训练场馆，拥有标准高尔夫球杆和完善的训练设施，为高尔夫爱好者提供专业的训练环境。', 'https://img2.baidu.com/it/u=1538430953%2C3587805226&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1031', 'https://img2.baidu.com/it/u=3681502697%2C1902447787&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=988', '详细介绍：市高尔夫练习场是本市最专业的高尔夫训练基地，拥有全套国际标准高尔夫器械。我们提供从入门到高级的高尔夫培训课程，培养高尔夫人才。', 15, 'user008', '2026-03-06 13:39:59');
INSERT INTO `venueinformation` VALUES (1152735655114047506, '市瑜伽馆', '市瑜伽俱乐部', '瑜伽训练', '正常开放', '瑜伽馆面积：100平方米\n标准瑜伽垫', '更衣室、淋浴间、观众席、训练器材', '瑜伽教学、比赛组织、体能训练', '专业的瑜伽训练场馆，拥有标准瑜伽垫和完善的训练设施，为瑜伽爱好者提供专业的训练环境。', 'https://img2.baidu.com/it/u=822531677%2C3766691348&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=591', 'https://img1.baidu.com/it/u=2384604556%2C3191166193&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=756', '详细介绍：市瑜伽馆是本市最专业的瑜伽训练基地，拥有全套国际标准瑜伽器械。我们提供从入门到高级的瑜伽培训课程，培养瑜伽人才。', 19, 'user010', '2026-03-06 13:39:59');
INSERT INTO `venueinformation` VALUES (1152735655114047508, '市舞蹈馆', '市舞蹈俱乐部', '舞蹈训练', '正常开放', '舞蹈馆面积：200平方米\n标准舞蹈器械', '更衣室、淋浴间、观众席、训练器材', '舞蹈教学、比赛组织、体能训练', '专业的舞蹈训练场馆，拥有标准舞蹈器械和完善的训练设施，为舞蹈爱好者提供专业的训练环境。', 'https://img1.baidu.com/it/u=1494831741%2C521656431&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=654', 'https://img0.baidu.com/it/u=3719010037%2C2523290225&fm=253&fmt=auto&app=120&f=JPEG?w=788&h=500', '详细介绍：市舞蹈馆是本市最专业的舞蹈训练基地，拥有全套国际标准舞蹈器械。我们提供从入门到高级的舞蹈培训课程，培养舞蹈人才。', 21, 'user011', '2026-03-06 13:39:59');
INSERT INTO `venueinformation` VALUES (1152735655114047509, '市武术馆', '市武术俱乐部', '武术训练', '正常开放', '武术馆面积：500平方米\n标准武术器械', '更衣室、淋浴间、观众席、训练器材', '武术教学、比赛组织、体能训练', '专业的武术训练场馆，拥有全套武术器械，为武术爱好者提供专业的训练环境。', 'https://img2.baidu.com/it/u=1647448073%2C2033255456&fm=253&fmt=auto&app=138&f=JPEG?w=1024&h=800', 'https://img1.baidu.com/it/u=1961137854%2C3815583199&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=500', '详细介绍：市武术馆是本市最专业的武术训练基地，拥有全套国际标准武术器械。我们提供从基础到高级的武术培训课程，培养武术人才。', 22, 'volunteers011', '2026-03-06 13:39:59');
INSERT INTO `venueinformation` VALUES (1152735655114051587, '市游泳馆', '市游泳俱乐部', '游泳训练', '正常开放', '游泳池：50米×25米×2米\n标准泳道：8条', '更衣室、淋浴间、救生设备、休息区', '游泳教学、救生培训、游泳比赛', '拥有标准奥林匹克规格游泳池，配备专业救生团队，为游泳爱好者提供安全、专业的训练场所。', 'https://img2.baidu.com/it/u=4222538980%2C2714434286&fm=253&fmt=auto&app=138&f=JPEG?w=675&h=500', 'https://img0.baidu.com/it/u=3719010037%2C2523290225&fm=253&fmt=auto&app=120&f=JPEG?w=788&h=500', '详细介绍：市游泳馆是本市最大的游泳训练基地，拥有完善的救生设施和专业的教学团队。我们提供从初学者到专业选手的全方位游泳培训服务。', 4, 'volunteers002', '2026-03-06 13:39:59');
INSERT INTO `venueinformation` VALUES (1152735655114051593, '市乒乓球馆', '市乒乓球俱乐部', '乒乓球训练', '正常开放', '乒乓球馆面积：100平方米\n标准乒乓球台', '更衣室、淋浴间、观众席、训练器材', '乒乓球教学、比赛组织、体能训练', '专业的乒乓球训练场馆，拥有标准乒乓球台和完善的训练设施，为乒乓球爱好者提供专业的训练环境。', 'https://img0.baidu.com/it/u=2579828701%2C896089502&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1353', 'https://img0.baidu.com/it/u=2579828701%2C896089502&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1353', '详细介绍：市乒乓球馆是本市最专业的乒乓球训练基地，拥有全套国际标准乒乓球器械。我们提供从基础到高级的乒乓球培训课程，培养乒乓球人才。', 10, 'volunteers005', '2026-03-06 13:39:59');
INSERT INTO `venueinformation` VALUES (1152735655114051597, '市马术馆', '市马术俱乐部', '马术训练', '正常开放', '马术馆面积：500平方米\n标准马术器械', '更衣室、淋浴间、观众席、训练器材', '马术教学、比赛组织、体能训练', '专业的马术训练场馆，拥有标准马术器械和完善的训练设施，为马术爱好者提供专业的训练环境。', 'https://img1.baidu.com/it/u=2737081558%2C1870522013&fm=253&fmt=auto&app=138&f=JPEG?w=943&h=800', 'https://img0.baidu.com/it/u=285858192%2C1451896218&fm=253&fmt=auto&app=138&f=JPEG?w=688&h=500', '详细介绍：市马术馆是本市最专业的马术训练基地，拥有全套国际标准马术器械。我们提供从基础到高级的马术培训课程，培养马术人才。', 14, 'volunteers007', '2026-03-06 13:39:59');
INSERT INTO `venueinformation` VALUES (1152735655114051600, '市攀岩馆', '市攀岩俱乐部', '攀岩训练', '正常开放', '攀岩馆面积：200平方米\n标准攀岩器械', '更衣室、淋浴间、观众席、训练器材', '攀岩教学、比赛组织、体能训练', '专业的攀岩训练场馆，拥有标准攀岩器械和完善的训练设施，为攀岩爱好者提供专业的训练环境。', 'https://img2.baidu.com/it/u=2843984095%2C3752921441&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=667', 'https://img1.baidu.com/it/u=1961137854%2C3815583199&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=500', '详细介绍：市攀岩馆是本市最专业的攀岩训练基地，拥有全套国际标准攀岩器械。我们提供从入门到高级的攀岩培训课程，培养攀岩人才。', 17, 'user009', '2026-03-06 13:39:59');
INSERT INTO `venueinformation` VALUES (1152735655114051601, '市轮滑馆', '市轮滑俱乐部', '轮滑训练', '正常开放', '轮滑馆面积：150平方米\n标准轮滑器械', '更衣室、淋浴间、观众席、训练器材', '轮滑教学、比赛组织、体能训练', '专业的轮滑训练场馆，拥有标准轮滑器械和完善的训练设施，为轮滑爱好者提供专业的训练环境。', 'https://img1.baidu.com/it/u=3174976294%2C2061247954&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=640', 'https://img2.baidu.com/it/u=1465296704%2C195487817&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=556', '详细介绍：市轮滑馆是本市最专业的轮滑训练基地，拥有全套国际标准轮滑器械。我们提供从基础到高级的轮滑培训课程，培养轮滑人才。', 18, 'volunteers009', '2026-03-06 13:39:59');
INSERT INTO `venueinformation` VALUES (1152735655114051606, '市武术馆', '市武术俱乐部', '武术训练', '正常开放', '武术馆面积：500平方米\n标准武术器械', '更衣室、淋浴间、观众席、训练器材', '武术教学、比赛组织、体能训练', '专业的武术训练场馆，拥有全套武术器械，为武术爱好者提供专业的训练环境。', 'https://img1.baidu.com/it/u=2186436434%2C915990981&fm=253&fmt=auto&app=120&f=JPEG?w=628&h=500', 'https://img1.baidu.com/it/u=4286813541%2C1522200002&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1200', '详细介绍：市武术馆是本市最专业的武术训练基地，拥有全套国际标准武术器械。我们提供从基础到高级的武术培训课程，培养武术人才。', 23, 'user012', '2026-03-06 13:39:59');
INSERT INTO `venueinformation` VALUES (1152735655114051609, '市武术馆', '市武术俱乐部', '武术训练', '正常开放', '武术馆面积：500平方米\n标准武术器械', '更衣室、淋浴间、观众席、训练器材', '武术教学、比赛组织、体能训练', '专业的武术训练场馆，拥有全套武术器械，为武术爱好者提供专业的训练环境。', 'https://img1.baidu.com/it/u=2253693942%2C585555415&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=668', 'https://img2.baidu.com/it/u=1538430953%2C3587805226&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1031', '详细介绍：市武术馆是本市最专业的武术训练基地，拥有全套国际标准武术器械。我们提供从基础到高级的武术培训课程，培养武术人才。', 26, 'volunteers013', '2026-03-06 13:39:59');
INSERT INTO `venueinformation` VALUES (1152735655114055680, '市体育中心羽毛球馆', '市羽毛球俱乐部', '体育训练', '正常开放', '场地尺寸：13.4米×6.1米\n标准羽毛球场地', '空调、灯光、更衣室、淋浴间、停车场', '提供球拍租赁、专业教练指导、赛事组织', '位于市中心，交通便利，设施完善，是羽毛球爱好者的理想训练场所。', 'https://img1.baidu.com/it/u=2384604556%2C3191166193&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=756', 'https://img1.baidu.com/it/u=2544375385%2C382706932&fm=253&fmt=auto&app=120&f=JPEG?w=722&h=500', '详细介绍：市体育中心羽毛球馆拥有8片国际标准场地，配备先进的灯光和空调系统，确保全年舒适的训练环境。场馆定期举办各类羽毛球赛事，为业余和专业运动员提供交流平台。', 1, 'user001', '2026-03-06 13:39:59');
INSERT INTO `venueinformation` VALUES (1152735655114055681, '阳光健身中心', '阳光健身俱乐部', '健身休闲', '正常开放', '健身房面积：500平方米\n器械数量：50台', '跑步机、力量训练器械、瑜伽室、动感单车房', '24小时营业、私人教练服务、营养咨询', '现代化的健身设施，专业教练团队，为不同年龄层的会员提供个性化健身方案。', 'https://img1.baidu.com/it/u=322771902%2C3303586788&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=654', 'https://img1.baidu.com/it/u=4286813541%2C1522200002&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1200', '详细介绍：阳光健身中心位于商业繁华区，拥有宽敞明亮的健身空间。我们提供多样化的健身课程，包括瑜伽、普拉提、有氧搏击等，满足会员的多样化需求。', 2, 'volunteers001', '2026-03-06 13:39:59');
INSERT INTO `venueinformation` VALUES (1152735655114055685, '市体操馆', '市体操俱乐部', '体操训练', '正常开放', '体操馆面积：800平方米\n标准体操器械', '更衣室、淋浴间、观众席、训练器材', '体操教学、比赛组织、体能训练', '专业的体操训练场馆，拥有全套体操器械，为体操运动员提供专业的训练环境。', 'https://img1.baidu.com/it/u=82909855%2C460423412&fm=253&fmt=auto&app=138&f=JPEG?w=667&h=500', 'https://img2.baidu.com/it/u=1538430953%2C3587805226&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1031', '详细介绍：市体操馆是本市最专业的体操训练基地，拥有全套国际标准体操器械。我们提供从基础到高级的体操培训课程，培养体操人才。', 6, 'volunteers003', '2026-03-06 13:39:59');
INSERT INTO `venueinformation` VALUES (1152735655114055692, '市射箭馆', '市射箭俱乐部', '射箭训练', '正常开放', '射箭馆面积：100平方米\n标准射箭器械', '更衣室、淋浴间、观众席、训练器材', '射箭教学、比赛组织、体能训练', '专业的射箭训练场馆，拥有标准射箭器械和完善的训练设施，为射箭爱好者提供专业的训练环境。', 'https://img1.baidu.com/it/u=2675837989%2C3036446787&fm=253&fmt=auto&app=138&f=JPEG?w=742&h=500', 'https://img1.baidu.com/it/u=1932176336%2C1348489562&fm=253&fmt=auto&app=138&f=JPEG?w=667&h=500', '详细介绍：市射箭馆是本市最专业的射箭训练基地，拥有全套国际标准射箭器械。我们提供从入门到高级的射箭培训课程，培养射箭人才。', 13, 'user007', '2026-03-06 13:39:59');
INSERT INTO `venueinformation` VALUES (1152735655114055699, '市普拉提馆', '市普拉提俱乐部', '普拉提训练', '正常开放', '普拉提馆面积：100平方米\n标准普拉提器械', '更衣室、淋浴间、观众席、训练器材', '普拉提教学、比赛组织、体能训练', '专业的普拉提训练场馆，拥有标准普拉提器械和完善的训练设施，为普拉提爱好者提供专业的训练环境。', 'https://img0.baidu.com/it/u=4099048394%2C1850690692&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1571', 'https://img1.baidu.com/it/u=2737081558%2C1870522013&fm=253&fmt=auto&app=138&f=JPEG?w=943&h=800', '详细介绍：市普拉提馆是本市最专业的普拉提训练基地，拥有全套国际标准普拉提器械。我们提供从基础到高级的普拉提培训课程，培养普拉提人才。', 20, 'volunteers010', '2026-03-06 13:39:59');
INSERT INTO `venueinformation` VALUES (1152735655114055703, '市武术馆', '市武术俱乐部', '武术训练', '正常开放', '武术馆面积：500平方米\n标准武术器械', '更衣室、淋浴间、观众席、训练器材', '武术教学、比赛组织、体能训练', '专业的武术训练场馆，拥有全套武术器械，为武术爱好者提供专业的训练环境。', 'https://img2.baidu.com/it/u=3681502697%2C1902447787&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=988', 'https://img2.baidu.com/it/u=3649956846%2C2967627513&fm=253&fmt=auto&app=120&f=JPEG?w=655&h=463', '详细介绍：市武术馆是本市最专业的武术训练基地，拥有全套国际标准武术器械。我们提供从基础到高级的武术培训课程，培养武术人才。', 24, 'volunteers012', '2026-03-06 13:39:59');
INSERT INTO `venueinformation` VALUES (1152735655114055704, '市武术馆', '市武术俱乐部', '武术训练', '正常开放', '武术馆面积：500平方米\n标准武术器械', '更衣室、淋浴间、观众席、训练器材', '武术教学、比赛组织、体能训练', '专业的武术训练场馆，拥有全套武术器械，为武术爱好者提供专业的训练环境。', 'https://img1.baidu.com/it/u=3948747228%2C2333704058&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1272', 'https://img1.baidu.com/it/u=322771902%2C3303586788&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=654', '详细介绍：市武术馆是本市最专业的武术训练基地，拥有全套国际标准武术器械。我们提供从基础到高级的武术培训课程，培养武术人才。', 25, 'user013', '2026-03-06 13:39:59');
INSERT INTO `venueinformation` VALUES (1152735655114055709, '市武术馆', '市武术俱乐部', '武术训练', '正常开放', '武术馆面积：500平方米\n标准武术器械', '更衣室、淋浴间、观众席、训练器材', '武术教学、比赛组织、体能训练', '专业的武术训练场馆，拥有全套武术器械，为武术爱好者提供专业的训练环境。', 'https://img1.baidu.com/it/u=3769452722%2C2423593917&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1024', 'https://img2.baidu.com/it/u=4222538980%2C2714434286&fm=253&fmt=auto&app=138&f=JPEG?w=675&h=500', '详细介绍：市武术馆是本市最专业的武术训练基地，拥有全套国际标准武术器械。我们提供从基础到高级的武术培训课程，培养武术人才。', 30, 'volunteers015', '2026-03-06 13:39:59');
INSERT INTO `venueinformation` VALUES (1152735655114059780, '市网球中心', '市网球俱乐部', '网球训练', '正常开放', '网球场：23.77米×10.97米\n硬地球场', '更衣室、淋浴间、观众席、球拍租赁', '网球教学、比赛组织、场地租赁', '拥有多个国际标准网球场，提供专业的网球培训和赛事服务，是网球爱好者的首选训练基地。', 'https://img1.baidu.com/it/u=3377086132%2C3195144515&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=820', 'https://img2.baidu.com/it/u=1465296704%2C195487817&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=556', '详细介绍：市网球中心拥有8片硬地球场，配备先进的照明系统，确保夜间训练的舒适度。我们提供从入门到高级的网球培训课程，满足不同水平的学员需求。', 5, 'user003', '2026-03-06 13:39:59');
INSERT INTO `venueinformation` VALUES (1152735655114059783, '市武术馆', '市武术俱乐部', '武术训练', '正常开放', '武术馆面积：500平方米\n标准武术器械', '更衣室、淋浴间、观众席、训练器材', '武术教学、比赛组织、体能训练', '专业的武术训练场馆，拥有全套武术器械，为武术爱好者提供专业的训练环境。', 'https://img2.baidu.com/it/u=3649956846%2C2967627513&fm=253&fmt=auto&app=120&f=JPEG?w=655&h=463', 'https://img1.baidu.com/it/u=1961137854%2C3815583199&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=500', '详细介绍：市武术馆是本市最专业的武术训练基地，拥有全套国际标准武术器械。我们提供从基础到高级的武术培训课程，培养武术人才。', 8, 'volunteers004', '2026-03-06 13:39:59');
INSERT INTO `venueinformation` VALUES (1152735655114059784, '市击剑馆', '市击剑俱乐部', '击剑训练', '正常开放', '击剑馆面积：200平方米\n标准击剑器械', '更衣室、淋浴间、观众席、训练器材', '击剑教学、比赛组织、体能训练', '专业的击剑训练场馆，拥有标准击剑器械和完善的训练设施，为击剑爱好者提供专业的训练环境。', 'https://img1.baidu.com/it/u=4286813541%2C1522200002&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1200', 'https://img0.baidu.com/it/u=561570794%2C1291898217&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1044', '详细介绍：市击剑馆是本市最专业的击剑训练基地，拥有全套国际标准击剑器械。我们提供从入门到高级的击剑培训课程，培养击剑人才。', 9, 'user005', '2026-03-06 13:39:59');
INSERT INTO `venueinformation` VALUES (1152735655114059791, '市滑板公园', '市滑板俱乐部', '滑板训练', '正常开放', '滑板公园面积：300平方米\n标准滑板器械', '更衣室、淋浴间、观众席、训练器材', '滑板教学、比赛组织、体能训练', '专业的滑板训练场馆，拥有标准滑板器械和完善的训练设施，为滑板爱好者提供专业的训练环境。', 'https://img2.baidu.com/it/u=1465296704%2C195487817&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=556', 'https://img1.baidu.com/it/u=4286813541%2C1522200002&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1200', '详细介绍：市滑板公园是本市最专业的滑板训练基地，拥有全套国际标准滑板器械。我们提供从基础到高级的滑板培训课程，培养滑板人才。', 16, 'volunteers008', '2026-03-06 13:39:59');
INSERT INTO `venueinformation` VALUES (1152735655114059802, '市武术馆', '市武术俱乐部', '武术训练', '正常开放', '武术馆面积：500平方米\n标准武术器械', '更衣室、淋浴间、观众席、训练器材', '武术教学、比赛组织、体能训练', '专业的武术训练场馆，拥有全套武术器械，为武术爱好者提供专业的训练环境。', 'https://img1.baidu.com/it/u=1961137854%2C3815583199&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=500', 'https://img1.baidu.com/it/u=3174976294%2C2061247954&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=640', '详细介绍：市武术馆是本市最专业的武术训练基地，拥有全套国际标准武术器械。我们提供从基础到高级的武术培训课程，培养武术人才。', 27, 'user014', '2026-03-06 13:39:59');
INSERT INTO `venueinformation` VALUES (1152735655114059803, '市武术馆', '市武术俱乐部', '武术训练', '正常开放', '武术馆面积：500平方米\n标准武术器械', '更衣室、淋浴间、观众席、训练器材', '武术教学、比赛组织、体能训练', '专业的武术训练场馆，拥有全套武术器械，为武术爱好者提供专业的训练环境。', 'https://img2.baidu.com/it/u=2583112179%2C2940915470&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=666', 'https://img0.baidu.com/it/u=3719010037%2C2523290225&fm=253&fmt=auto&app=120&f=JPEG?w=788&h=500', '详细介绍：市武术馆是本市最专业的武术训练基地，拥有全套国际标准武术器械。我们提供从基础到高级的武术培训课程，培养武术人才。', 28, 'volunteers014', '2026-03-06 13:39:59');
INSERT INTO `venueinformation` VALUES (1152735655114059804, '市武术馆', '市武术俱乐部', '武术训练', '正常开放', '武术馆面积：500平方米\n标准武术器械', '更衣室、淋浴间、观众席、训练器材', '武术教学、比赛组织、体能训练', '专业的武术训练场馆，拥有全套武术器械，为武术爱好者提供专业的训练环境。', 'https://img0.baidu.com/it/u=3719010037%2C2523290225&fm=253&fmt=auto&app=120&f=JPEG?w=788&h=500', 'https://img1.baidu.com/it/u=1961137854%2C3815583199&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=500', '详细介绍：市武术馆是本市最专业的武术训练基地，拥有全套国际标准武术器械。我们提供从基础到高级的武术培训课程，培养武术人才。', 29, 'user015', '2026-03-06 13:39:59');

-- ----------------------------
-- Table structure for venuereservation
-- ----------------------------
DROP TABLE IF EXISTS `venuereservation`;
CREATE TABLE `venuereservation`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '场地名称',
  `thereservationstarttime` timestamp NULL DEFAULT NULL COMMENT '预约开始时间',
  `appointmentendtime` timestamp NULL DEFAULT NULL COMMENT '预约结束时间',
  `photo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '封面',
  `remarkinformation` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '备注信息',
  `reservationpersonid` bigint NULL DEFAULT NULL COMMENT '预约人id',
  `reservationpersonname` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '预约人',
  `adduserid` bigint NULL DEFAULT NULL COMMENT '审核人id',
  `addusername` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核人',
  `shenhe` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核',
  `shenheid` bigint NULL DEFAULT NULL COMMENT '场地id',
  `shenhehuifu` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '审核回复',
  `userid` bigint NULL DEFAULT NULL COMMENT '用户id',
  `username` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名称',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2049415913631526915 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '场地预约' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of venuereservation
-- ----------------------------
INSERT INTO `venuereservation` VALUES (1152735631575613445, '乒乓球馆F', '2023-10-06 16:00:00', '2023-10-06 18:00:00', 'https://img0.baidu.com/it/u=4279913965%2C3258122432&fm=253&fmt=auto&app=120&f=PNG?w=747&h=500', '社团活动', 1006, '韩十八', 2006, '杨十九', '通过', 5006, '设备齐全', 3006, '朱二十', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (1152735631575613448, '保龄球馆I', '2023-10-09 17:00:00', '2023-10-09 19:00:00', 'https://img1.baidu.com/it/u=323658114%2C1679732955&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=1111', '休闲娱乐', 1009, '张二十七', 2009, '孔二十八', '通过', 5009, '设备正常', 3009, '曹二十九', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (1152735631575613452, '射箭场M', '2023-10-13 10:00:00', '2023-10-13 12:00:00', 'https://img0.baidu.com/it/u=2433795006%2C2035697124&fm=253&fmt=auto&app=138&f=JPEG?w=667&h=500', '射箭体验', 1013, '沈八十九', 2013, '张九十', '通过', 5013, '安全设施齐全', 3013, '郑百零一', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (1152735631575613453, '攀岩馆N', '2023-10-14 14:00:00', '2023-10-14 16:00:00', 'https://img2.baidu.com/it/u=3620424473%2C3403920798&fm=253&fmt=auto?w=405&h=357', '攀岩训练', 1014, '王百零二', 1, '管理员', '拒绝', 1, '预约审核未通过，请调整时段后重新提交。', 3014, '赵百零四', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (1152735631575613457, '滑板场R', '2023-10-18 13:00:00', '2023-10-18 15:00:00', 'https://img0.baidu.com/it/u=3639868014%2C720111515&fm=253&fmt=auto&app=138&f=JPEG?w=1024&h=421', '滑板练习', 1018, '蒋百一十四', 2018, '沈百一十五', '通过', 5018, '场地宽敞', 3018, '韩百一十六', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (1152735631575613459, '赛车场T', '2023-10-20 11:00:00', '2023-10-20 13:00:00', 'https://img1.baidu.com/it/u=562100495%2C2345975791&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=1115', '赛车体验', 1020, '尤百二十', 2020, '许百二十一', '待审核', 5020, NULL, 3020, '何百二十二', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (1152735631575613463, '赛车场X', '2023-10-24 12:00:00', '2023-10-24 14:00:00', 'https://img0.baidu.com/it/u=2630530125%2C973283455&fm=253&fmt=auto&app=120&f=JPEG?w=800&h=500', '赛车体验', 1024, '陶百三十二', 2024, '姜百三十三', '通过', 5024, '设备先进', 3024, '彭百三十四', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (1152735631575613466, '赛车场AA', '2023-10-27 08:00:00', '2023-10-27 10:00:00', 'https://img2.baidu.com/it/u=233524705%2C1913017699&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1069', '赛车体验', 1027, '赵百四十一', 2027, '孙百四十二', '通过', 5027, '体验良好', 3027, '周百四十三', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (1152735631575617536, '篮球场A', '2023-10-01 09:00:00', '2023-10-01 11:00:00', 'https://img1.baidu.com/it/u=4211588636%2C4069832737&fm=253&fmt=auto?w=500&h=878', '用于校队训练', 1001, '张三', 2001, '李四', '通过', 5001, '场地已审核通过', 3001, '王五', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (1152735631575617538, '网球场C', '2023-10-03 10:00:00', '2023-10-03 12:00:00', 'https://img2.baidu.com/it/u=1128392882%2C2762876755&fm=253&fmt=auto&app=120&f=PNG?w=500&h=775', '友谊赛', 1003, '吴九', 2003, '郑十', '通过', 5003, '场地安排妥当', 3003, '王十一', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (1152735631575617539, '游泳馆D', '2023-10-04 15:00:00', '2023-10-04 17:00:00', 'https://img1.baidu.com/it/u=2693273723%2C2846366436&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=750', '游泳课程', 1004, '冯十二', 2004, '陈十三', '通过', 5004, '水质良好', 3004, '褚十四', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (1152735631575617540, '健身房E', '2023-10-05 08:00:00', '2023-10-05 10:00:00', 'https://img2.baidu.com/it/u=2667963828%2C1176361145&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=1034', '健身训练', 1005, '卫十五', 1, '管理员', '通过', 1, '预约审核通过，请按时到场核验。', 3005, '沈十七', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (1152735631575617542, '足球场G', '2023-10-07 11:00:00', '2023-10-07 13:00:00', 'https://img0.baidu.com/it/u=3674281880%2C1572138619&fm=253&fmt=auto&app=120&f=JPEG?w=408&h=778', '校队比赛', 1007, '秦二十一', 2007, '尤二十二', '通过', 5007, '场地平整', 3007, '许二十三', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (1152735631575617546, '瑜伽馆K', '2023-10-11 07:00:00', '2023-10-11 09:00:00', 'https://img2.baidu.com/it/u=4287539209%2C2338247958&fm=253&fmt=auto&app=138&f=JPEG?w=1026&h=500', '瑜伽课程', 1011, '魏三十三', 2011, '陶四十四', '待审核', 5011, NULL, 3011, '姜五十五', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (1152735631575617550, '击剑馆O', '2023-10-15 09:00:00', '2023-10-15 11:00:00', 'https://img1.baidu.com/it/u=386331671%2C3294791991&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=675', '击剑课程', 1015, '孙百零五', 2015, '周百零六', '通过', 5015, '装备齐全', 3015, '吴百零七', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (1152735631575617556, '赛车场U', '2023-10-21 14:00:00', '2023-10-21 16:00:00', 'https://img2.baidu.com/it/u=1764760678%2C1723287508&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=977', '赛车比赛', 1021, '吕百二十三', 2021, '施百二十四', '通过', 5021, '赛道完善', 3021, '张百二十五', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (1152735631575617557, '赛车场V', '2023-10-22 09:00:00', '2023-10-22 11:00:00', 'https://img2.baidu.com/it/u=3351118890%2C182955992&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=1097', '赛车培训', 1022, '孔百二十六', 2022, '曹百二十七', '通过', 5022, '教练经验丰富', 3022, '严百二十八', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (1152735631575617558, '赛车场W', '2023-10-23 16:00:00', '2023-10-23 18:00:00', 'https://img0.baidu.com/it/u=3942380174%2C2516400176&fm=253&fmt=auto?w=500&h=932', '赛车娱乐', 1023, '华百二十九', 2023, '金百三十', '待审核', 5023, NULL, 3023, '魏百三十一', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (1152735631575617561, '赛车场Z', '2023-10-26 15:00:00', '2023-10-26 17:00:00', 'https://img0.baidu.com/it/u=3790772936%2C1235376853&fm=253&fmt=auto&app=120&f=JPEG?w=929&h=500', '赛车培训', 1026, '郑百三十八', 2026, '王百三十九', '待审核', 5026, NULL, 3026, '李百四十', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (1152735631575617565, '赛车场AD', '2023-10-30 16:00:00', '2023-10-30 18:00:00', 'https://img1.baidu.com/it/u=4190187254%2C3406209624&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=690', '赛车娱乐', 1030, '卫百五十', 2030, '蒋百五十一', '通过', 5030, '娱乐性强', 3030, '沈百五十二', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (1152735631575621639, '排球场H', '2023-10-08 13:00:00', '2023-10-08 15:00:00', 'https://img0.baidu.com/it/u=1084407344%2C2851590513&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1574', '排球训练', 1008, '何二十四', 2008, '吕二十五', '待审核', 5008, NULL, 3008, '施二十六', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (1152735631575621641, '台球厅J', '2023-10-10 12:00:00', '2023-10-10 14:00:00', 'https://img1.baidu.com/it/u=3656252909%2C3936022277&fm=253&fmt=auto?w=800&h=1018', '朋友聚会', 1010, '严三十', 2010, '华三十一', '通过', 5010, '环境舒适', 3010, '金三十二', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (1152735631575621656, '赛车场Y', '2023-10-25 10:00:00', '2023-10-25 12:00:00', 'https://img1.baidu.com/it/u=3587406753%2C3530550056&fm=253&fmt=auto?w=564&h=370', '赛车比赛', 1025, '韦百三十五', 2025, '沈百三十六', '通过', 5025, '赛事精彩', 3025, '张百三十七', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (1152735631575621660, '赛车场AC', '2023-10-29 11:00:00', '2023-10-29 13:00:00', 'https://img0.baidu.com/it/u=510768352%2C78718537&fm=253&fmt=auto&app=138&f=JPEG?w=667&h=500', '赛车培训', 1029, '冯百四十七', 2029, '陈百四十八', '待审核', 5029, NULL, 3029, '褚百四十九', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (1152735631575625729, '羽毛球场B', '2023-10-02 14:00:00', '2023-10-02 16:00:00', 'https://img1.baidu.com/it/u=1332845439%2C2591167582&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=659', '个人练习', 1002, '赵六', 2002, '孙七', '待审核', 5002, NULL, 3002, '周八', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (1152735631575625739, '武术馆L', '2023-10-12 18:00:00', '2023-10-12 20:00:00', 'https://img0.baidu.com/it/u=1150150915%2C804327559&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=1233', '武术练习', 1012, '张五十六', 2012, '彭六十七', '通过', 5012, '教练专业', 3012, '韦七十八', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (1152735631575625743, '滑冰场P', '2023-10-16 16:00:00', '2023-10-16 18:00:00', 'https://img2.baidu.com/it/u=2401261451%2C2725294287&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=625', '滑冰活动', 1016, '郑百零八', 2016, '王百零九', '通过', 5016, '冰面平整', 3016, '冯百一十', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (1152735631575625744, '滑雪馆Q', '2023-10-17 08:00:00', '2023-10-17 10:00:00', 'https://img0.baidu.com/it/u=1597267696%2C3037883110&fm=253&fmt=auto&app=120&f=JPEG?w=910&h=347', '滑雪体验', 1017, '陈百一十一', 2017, '褚百一十二', '待审核', 5017, NULL, 3017, '卫百一十三', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (1152735631575625746, '卡丁车场S', '2023-10-19 15:00:00', '2023-10-19 17:00:00', 'https://img1.baidu.com/it/u=902140279%2C3972991072&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=648', '卡丁车比赛', 1019, '杨百一十七', 2019, '朱百一十八', '通过', 5019, '设备安全', 3019, '秦百一十九', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (1152735631575625755, '赛车场AB', '2023-10-28 13:00:00', '2023-10-28 15:00:00', 'https://img2.baidu.com/it/u=2339193709%2C411080875&fm=253&fmt=auto&app=120&f=JPEG?w=889&h=500', '赛车比赛', 1028, '吴百四十四', 2028, '郑百四十五', '通过', 5028, '比赛激烈', 3028, '王百四十六', '2026-03-06 13:39:57');
INSERT INTO `venuereservation` VALUES (2029802458236944385, '青少年篮球训练营', '2026-03-06 14:13:02', '2026-03-07 00:00:00', 'api/upload/pexels_architecture_271667_51190.jpg', '备注xx', 1152735791059828739, 'user004', 1, '管理员', '通过', 1, '预约审核通过，请按时到场核验。', 1152735791059828739, 'user004', '2026-03-06 14:13:13');
INSERT INTO `venuereservation` VALUES (2049413617480773634, '市台球馆', '2026-04-29 17:00:51', '2026-04-30 00:00:00', NULL, NULL, NULL, '周丽', NULL, NULL, NULL, NULL, NULL, 1152735791059828742, '周丽', '2026-04-29 17:00:57');
INSERT INTO `venuereservation` VALUES (2049413787446554626, '市台球馆', '2026-04-01 00:00:00', '2026-04-30 00:00:00', NULL, NULL, NULL, '王五', NULL, NULL, NULL, NULL, NULL, 1152735791059828742, '王五', '2026-04-29 17:01:38');
INSERT INTO `venuereservation` VALUES (2049415913631526914, '市台球馆', '2026-04-15 00:00:00', '2026-04-29 17:10:01', NULL, NULL, NULL, '周丽', NULL, NULL, NULL, 1152735655114047498, NULL, 1152735791059828742, '周丽', '2026-04-29 17:10:05');

SET FOREIGN_KEY_CHECKS = 1;
