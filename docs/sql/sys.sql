/*
 Navicat Premium Data Transfer

 Source Server         : y
 Source Server Type    : MySQL
 Source Server Version : 50725
 Source Host           : 60.205.212.93:3306
 Source Schema         : z-boot

 Target Server Type    : MySQL
 Target Server Version : 50725
 File Encoding         : 65001

 Date: 19/08/2020 08:47:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dict_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典名称',
  `dict_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典编码',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `del_flag` int(1) NULL DEFAULT NULL COMMENT '删除状态',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `type` int(1) UNSIGNED ZEROFILL NULL DEFAULT 0 COMMENT '字典类型0为string,1为number',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `indextable_dict_code`(`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES (11, '定时任务状态', 'quartz_status', '', 0, 'admin', '2020-04-16 15:30:14', '', NULL, NULL);
INSERT INTO `sys_dict` VALUES (16, '删除状态', 'del_flag', NULL, 0, 'admin', '2019-01-18 21:46:26', 'admin', '2019-03-30 11:17:11', 0);
INSERT INTO `sys_dict` VALUES (17, '性别', 'sex', NULL, 0, NULL, '2019-01-04 14:56:32', 'admin', '2019-03-30 11:28:27', 1);
INSERT INTO `sys_dict` VALUES (20, '字典状态', 'dict_item_status', NULL, 0, 'admin', '2020-06-18 23:18:42', 'admin', '2019-03-30 19:33:52', 1);
INSERT INTO `sys_dict` VALUES (21, '优先级', 'priority', '优先级', 0, 'admin', '2019-03-16 17:03:34', 'admin', '2019-04-16 17:39:23', 0);
INSERT INTO `sys_dict` VALUES (24, '有效无效状态', 'valid_status', '有效无效状态', 0, 'admin', '2020-09-26 19:21:14', 'admin', '2019-04-26 19:21:23', 0);
INSERT INTO `sys_dict` VALUES (25, '用户类型', 'user_type', NULL, 0, NULL, '2019-01-04 14:59:01', 'admin', '2019-03-18 23:28:18', 0);
INSERT INTO `sys_dict` VALUES (28, '日志类型', 'log_type', NULL, 0, 'admin', '2019-03-18 23:22:19', NULL, NULL, 1);
INSERT INTO `sys_dict` VALUES (29, '状态', 'status', NULL, 0, 'admin', '2019-03-18 21:45:25', 'admin', '2019-03-18 21:58:25', 0);
INSERT INTO `sys_dict` VALUES (30, '操作类型', 'operate_type', '操作类型', 0, 'admin', '2019-07-22 10:54:29', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES (32, '1是0否', 'yn', '', 0, 'admin', '2019-05-22 19:29:29', NULL, NULL, 0);
INSERT INTO `sys_dict` VALUES (34, '菜单类型', 'menu_type', NULL, 0, 'admin', '2020-12-18 23:24:32', 'admin', '2019-04-01 15:27:06', 1);
INSERT INTO `sys_dict` VALUES (40, '用户状态', 'user_status', NULL, 0, 'admin', '2019-03-18 21:57:25', 'admin', '2019-03-18 23:11:58', 1);

-- ----------------------------
-- Table structure for sys_dict_item
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_item`;
CREATE TABLE `sys_dict_item`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dict_id` int(11) NULL DEFAULT NULL,
  `item_text` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典项文本',
  `item_value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典项值',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `sort_order` int(10) NULL DEFAULT NULL COMMENT '排序',
  `status` int(11) NULL DEFAULT NULL COMMENT '状态（1启用 0不启用）',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_table_sort_order`(`sort_order`) USING BTREE,
  INDEX `index_table_dict_status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 119 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_item
-- ----------------------------
INSERT INTO `sys_dict_item` VALUES (1, 21, '低', 'L', '低', 3, 1, 'admin', '2019-04-16 17:04:59', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES (2, 16, '已删除', '1', NULL, NULL, 1, 'admin', '2025-10-18 21:46:56', 'admin', '2019-03-28 22:23:20');
INSERT INTO `sys_dict_item` VALUES (38, 11, '正常', '0', '', 1, 1, 'admin', '2020-04-16 15:31:05', '', NULL);
INSERT INTO `sys_dict_item` VALUES (39, 11, '停止', '-1', '', 1, 1, 'admin', '2020-04-16 15:31:18', '', NULL);
INSERT INTO `sys_dict_item` VALUES (49, 24, '有效', '1', '有效', 2, 1, 'admin', '2019-04-26 19:22:01', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES (57, 29, '正常', '1', NULL, NULL, 1, 'admin', '2019-03-18 21:45:51', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES (58, 28, '操作日志', '2', NULL, NULL, 1, 'admin', '2019-03-18 23:22:49', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES (60, 32, '是', '1', '', 1, 1, 'admin', '2019-05-22 19:29:45', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES (65, 30, '修改', '3', '', 3, 1, 'admin', '2019-07-22 10:55:07', 'admin', '2019-07-22 10:55:41');
INSERT INTO `sys_dict_item` VALUES (66, 17, '女', '2', NULL, 2, 1, NULL, '2019-01-04 14:56:56', NULL, '2019-01-04 17:38:12');
INSERT INTO `sys_dict_item` VALUES (73, 21, '高', 'H', '高', 1, 1, 'admin', '2019-04-16 17:04:24', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES (79, 40, '正常', '1', NULL, NULL, 1, 'admin', '2019-03-18 23:30:28', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES (80, 34, '按钮权限', '2', NULL, NULL, 1, 'admin', '2019-03-18 23:25:40', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES (81, 40, '冻结', '2', NULL, NULL, 1, 'admin', '2019-03-18 23:30:37', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES (86, 34, '子菜单', '1', NULL, NULL, 1, 'admin', '2019-03-18 23:25:27', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES (88, 20, '启用', '1', '', 0, 1, 'admin', '2020-07-18 23:19:27', 'admin', '2019-05-17 14:51:18');
INSERT INTO `sys_dict_item` VALUES (90, 21, '中', 'M', '中', 2, 1, 'admin', '2019-04-16 17:04:40', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES (91, 30, '添加', '2', '', 2, 1, 'admin', '2019-07-22 10:54:59', 'admin', '2019-07-22 10:55:36');
INSERT INTO `sys_dict_item` VALUES (92, 20, '不启用', '0', NULL, 1, 1, 'admin', '2019-03-18 23:19:53', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES (93, 30, '导出', '6', '', 6, 1, 'admin', '2019-07-22 12:06:50', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES (95, 34, '一级菜单', '0', NULL, NULL, 1, 'admin', '2019-03-18 23:24:52', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES (98, 16, '正常', '0', NULL, NULL, 1, 'admin', '2022-10-18 21:46:48', 'admin', '2019-03-28 22:22:20');
INSERT INTO `sys_dict_item` VALUES (100, 24, '无效', '0', '无效', 1, 1, 'admin', '2019-04-26 19:21:49', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES (103, 30, '导入', '5', '', 5, 1, 'admin', '2019-07-22 12:06:41', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES (104, 30, '查询', '1', '', 1, 1, 'admin', '2019-07-22 10:54:51', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES (105, 32, '否', '0', '', 1, 1, 'admin', '2019-05-22 19:29:55', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES (108, 17, '男', '1', NULL, 1, 1, NULL, '2027-08-04 14:56:49', 'admin', '2019-03-23 22:44:44');
INSERT INTO `sys_dict_item` VALUES (113, 29, '冻结', '2', NULL, NULL, 1, 'admin', '2019-03-18 21:46:02', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES (114, 28, '登录日志', '1', NULL, NULL, 1, 'admin', '2019-03-18 23:22:37', NULL, NULL);
INSERT INTO `sys_dict_item` VALUES (116, 30, '删除', '4', '', 4, 1, 'admin', '2019-07-22 10:55:14', 'admin', '2019-07-22 10:55:30');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `log_type` int(2) NULL DEFAULT NULL COMMENT '日志类型（1登录日志，2操作日志）',
  `log_content` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志内容',
  `operate_type` int(2) NULL DEFAULT NULL COMMENT '操作类型',
  `userid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作用户账号',
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作用户名称',
  `ip` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP',
  `method` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求java方法',
  `request_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求路径',
  `request_param` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '请求参数',
  `request_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求类型',
  `cost_time` bigint(20) NULL DEFAULT NULL COMMENT '耗时',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_table_userid`(`userid`) USING BTREE,
  INDEX `index_logt_ype`(`log_type`) USING BTREE,
  INDEX `index_operate_type`(`operate_type`) USING BTREE,
  INDEX `index_log_type`(`log_type`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1382 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES (1380, 1, '用户: test,退出成功！', NULL, NULL, NULL, '219.142.131.162', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-18 11:46:38', NULL, NULL);
INSERT INTO `sys_log` VALUES (1381, 1, '用户: test,登录成功！', NULL, 'test', 'test', '219.142.131.162', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-18 22:16:13', NULL, NULL);
INSERT INTO `sys_log` VALUES (1377, 1, '用户: test,退出成功！', NULL, NULL, NULL, '202.85.209.162', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-18 10:29:16', NULL, NULL);
INSERT INTO `sys_log` VALUES (1378, 1, '用户: test,登录成功！', NULL, 'test', 'test', '202.85.209.162', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-18 10:29:23', NULL, NULL);
INSERT INTO `sys_log` VALUES (1379, 2, '定时任务-分页列表查询', 1, 'test', 'test', '202.85.209.162', 'org.z.modules.quartz.controller.QuartzJobController.queryPageList()', NULL, '  quartzJob: QuartzJob(id=null, createBy=null, createTime=null, delFlag=null, updateBy=null, updateTime=null, jobClassName=null, cronExpression=null, parameter=null, description=null, status=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@442b79d5', NULL, 28, 'test', '2020-08-18 10:54:05', NULL, NULL);
INSERT INTO `sys_log` VALUES (1372, 1, '用户: test,登录成功！', NULL, 'test', 'test', '60.205.212.93', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-18 09:45:11', NULL, NULL);
INSERT INTO `sys_log` VALUES (1373, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-18 09:49:33', NULL, NULL);
INSERT INTO `sys_log` VALUES (1374, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-18 09:49:42', NULL, NULL);
INSERT INTO `sys_log` VALUES (1375, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-18 10:22:02', NULL, NULL);
INSERT INTO `sys_log` VALUES (1376, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-18 10:22:48', NULL, NULL);
INSERT INTO `sys_log` VALUES (1367, 1, '用户: test,退出成功！', NULL, NULL, NULL, '202.85.209.162', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-18 08:39:28', NULL, NULL);
INSERT INTO `sys_log` VALUES (1368, 1, '用户: test,登录成功！', NULL, 'test', 'test', '202.85.209.162', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-18 08:39:34', NULL, NULL);
INSERT INTO `sys_log` VALUES (1369, 1, '用户: test,退出成功！', NULL, NULL, NULL, '60.205.212.93', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-18 09:10:50', NULL, NULL);
INSERT INTO `sys_log` VALUES (1370, 1, '用户: test,登录成功！', NULL, 'test', 'test', '60.205.212.93', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-18 09:11:01', NULL, NULL);
INSERT INTO `sys_log` VALUES (1371, 1, '用户: test,退出成功！', NULL, NULL, NULL, '60.205.212.93', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-18 09:45:04', NULL, NULL);
INSERT INTO `sys_log` VALUES (1365, 1, '用户: test,退出成功！', NULL, NULL, NULL, '202.85.209.162', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 22:05:04', NULL, NULL);
INSERT INTO `sys_log` VALUES (1366, 1, '用户: test,登录成功！', NULL, 'test', 'test', '202.85.209.162', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-18 08:06:47', NULL, NULL);
INSERT INTO `sys_log` VALUES (1364, 2, '职务表-分页列表查询', 1, 'test', 'test', '202.85.209.162', 'org.z.modules.system.controller.SysPositionController.queryPageList()', NULL, '  sysPosition: SysPosition(id=null, code=null, name=null, postRank=null, companyId=null, createBy=null, createTime=null, updateBy=null, updateTime=null, sysOrgCode=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@1312380f', NULL, 18, 'test', '2020-08-17 22:03:40', NULL, NULL);
INSERT INTO `sys_log` VALUES (1362, 2, '职务表-通过id删除', 4, 'test', 'test', '202.85.209.162', 'org.z.modules.system.controller.SysPositionController.delete()', NULL, '  id: 1', NULL, 86, 'test', '2020-08-17 22:03:37', NULL, NULL);
INSERT INTO `sys_log` VALUES (1363, 2, '职务表-分页列表查询', 1, 'test', 'test', '202.85.209.162', 'org.z.modules.system.controller.SysPositionController.queryPageList()', NULL, '  sysPosition: SysPosition(id=null, code=null, name=null, postRank=null, companyId=null, createBy=null, createTime=null, updateBy=null, updateTime=null, sysOrgCode=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@4ed19ba3', NULL, 16, 'test', '2020-08-17 22:03:37', NULL, NULL);
INSERT INTO `sys_log` VALUES (1361, 2, '职务表-分页列表查询', 1, 'test', 'test', '202.85.209.162', 'org.z.modules.system.controller.SysPositionController.queryPageList()', NULL, '  sysPosition: SysPosition(id=null, code=null, name=null, postRank=null, companyId=null, createBy=null, createTime=null, updateBy=null, updateTime=null, sysOrgCode=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@72a3db7b', NULL, 19, 'test', '2020-08-17 22:03:28', NULL, NULL);
INSERT INTO `sys_log` VALUES (1358, 1, '用户: test,退出成功！', NULL, NULL, NULL, '202.85.209.162', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 21:55:56', NULL, NULL);
INSERT INTO `sys_log` VALUES (1359, 1, '用户: test,登录成功！', NULL, 'test', 'test', '202.85.209.162', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 21:56:27', NULL, NULL);
INSERT INTO `sys_log` VALUES (1360, 2, '职务表-分页列表查询', 1, 'test', 'test', '202.85.209.162', 'org.z.modules.system.controller.SysPositionController.queryPageList()', NULL, '  sysPosition: SysPosition(id=null, code=null, name=null, postRank=null, companyId=null, createBy=null, createTime=null, updateBy=null, updateTime=null, sysOrgCode=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@4b1cd22d', NULL, 27, 'test', '2020-08-17 22:03:26', NULL, NULL);
INSERT INTO `sys_log` VALUES (1357, 2, '定时任务-分页列表查询', 1, 'test', 'test', '202.85.209.162', 'org.z.modules.quartz.controller.QuartzJobController.queryPageList()', NULL, '  quartzJob: QuartzJob(id=null, createBy=null, createTime=null, delFlag=null, updateBy=null, updateTime=null, jobClassName=null, cronExpression=null, parameter=null, description=null, status=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@2396eedb', NULL, 88, 'test', '2020-08-17 21:55:51', NULL, NULL);
INSERT INTO `sys_log` VALUES (1355, 1, '用户: test,登录成功！', NULL, 'test', 'test', '202.85.209.162', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 21:55:37', NULL, NULL);
INSERT INTO `sys_log` VALUES (1356, 2, '职务表-分页列表查询', 1, 'test', 'test', '202.85.209.162', 'org.z.modules.system.controller.SysPositionController.queryPageList()', NULL, '  sysPosition: SysPosition(id=null, code=null, name=null, postRank=null, companyId=null, createBy=null, createTime=null, updateBy=null, updateTime=null, sysOrgCode=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@3e363694', NULL, 75, 'test', '2020-08-17 21:55:50', NULL, NULL);
INSERT INTO `sys_log` VALUES (1352, 1, '用户: test,退出成功！', NULL, NULL, NULL, '202.85.209.162', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 21:52:11', NULL, NULL);
INSERT INTO `sys_log` VALUES (1353, 1, '用户: test,登录成功！', NULL, 'test', 'test', '202.85.209.162', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 21:52:21', NULL, NULL);
INSERT INTO `sys_log` VALUES (1354, 1, '用户: test,退出成功！', NULL, NULL, NULL, '202.85.209.162', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 21:55:30', NULL, NULL);
INSERT INTO `sys_log` VALUES (1351, 2, '定时任务-分页列表查询', 1, 'test', 'test', '202.85.209.162', 'org.z.modules.quartz.controller.QuartzJobController.queryPageList()', NULL, '  quartzJob: QuartzJob(id=null, createBy=null, createTime=null, delFlag=null, updateBy=null, updateTime=null, jobClassName=null, cronExpression=null, parameter=null, description=null, status=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@7400f059', NULL, 78, 'test', '2020-08-17 21:41:38', NULL, NULL);
INSERT INTO `sys_log` VALUES (1349, 1, '用户: test,登录成功！', NULL, 'test', 'test', '202.85.209.162', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 21:41:09', NULL, NULL);
INSERT INTO `sys_log` VALUES (1350, 2, '职务表-分页列表查询', 1, 'test', 'test', '202.85.209.162', 'org.z.modules.system.controller.SysPositionController.queryPageList()', NULL, '  sysPosition: SysPosition(id=null, code=null, name=null, postRank=null, companyId=null, createBy=null, createTime=null, updateBy=null, updateTime=null, sysOrgCode=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@346acbce', NULL, 84, 'test', '2020-08-17 21:41:37', NULL, NULL);
INSERT INTO `sys_log` VALUES (1348, 1, '用户: test,退出成功！', NULL, NULL, NULL, '202.85.209.162', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 21:40:32', NULL, NULL);
INSERT INTO `sys_log` VALUES (1347, 2, '定时任务-分页列表查询', 1, 'test', 'test', '127.0.0.1', 'org.z.modules.quartz.controller.QuartzJobController.queryPageList()', NULL, '  quartzJob: QuartzJob(id=null, createBy=null, createTime=null, delFlag=null, updateBy=null, updateTime=null, jobClassName=null, cronExpression=null, parameter=null, description=null, status=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@3b18ba5c', NULL, 29, 'test', '2020-08-17 21:35:35', NULL, NULL);
INSERT INTO `sys_log` VALUES (1346, 2, '职务表-分页列表查询', 1, 'test', 'test', '127.0.0.1', 'org.z.modules.system.controller.SysPositionController.queryPageList()', NULL, '  sysPosition: SysPosition(id=null, code=null, name=null, postRank=null, companyId=null, createBy=null, createTime=null, updateBy=null, updateTime=null, sysOrgCode=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@7a716fa6', NULL, 22, 'test', '2020-08-17 21:35:33', NULL, NULL);
INSERT INTO `sys_log` VALUES (1345, 2, '职务表-分页列表查询', 1, 'test', 'test', '127.0.0.1', 'org.z.modules.system.controller.SysPositionController.queryPageList()', NULL, '  sysPosition: SysPosition(id=null, code=null, name=null, postRank=null, companyId=null, createBy=null, createTime=null, updateBy=null, updateTime=null, sysOrgCode=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@5589f520', NULL, 61, 'test', '2020-08-17 21:30:39', NULL, NULL);
INSERT INTO `sys_log` VALUES (1344, 2, '定时任务-分页列表查询', 1, 'test', 'test', '127.0.0.1', 'org.z.modules.quartz.controller.QuartzJobController.queryPageList()', NULL, '  quartzJob: QuartzJob(id=null, createBy=null, createTime=null, delFlag=null, updateBy=null, updateTime=null, jobClassName=null, cronExpression=null, parameter=null, description=null, status=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@43cf68ab', NULL, 19, 'test', '2020-08-17 21:30:30', NULL, NULL);
INSERT INTO `sys_log` VALUES (1343, 2, '定时任务-分页列表查询', 1, 'test', 'test', '127.0.0.1', 'org.z.modules.quartz.controller.QuartzJobController.queryPageList()', NULL, '  quartzJob: QuartzJob(id=null, createBy=null, createTime=null, delFlag=null, updateBy=null, updateTime=null, jobClassName=null, cronExpression=null, parameter=null, description=null, status=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@75d49725', NULL, 20, 'test', '2020-08-17 21:23:42', NULL, NULL);
INSERT INTO `sys_log` VALUES (1340, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 21:20:03', NULL, NULL);
INSERT INTO `sys_log` VALUES (1341, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 21:20:13', NULL, NULL);
INSERT INTO `sys_log` VALUES (1342, 2, '定时任务-分页列表查询', 1, 'test', 'test', '127.0.0.1', 'org.z.modules.quartz.controller.QuartzJobController.queryPageList()', NULL, '  quartzJob: QuartzJob(id=null, createBy=null, createTime=null, delFlag=null, updateBy=null, updateTime=null, jobClassName=null, cronExpression=null, parameter=null, description=null, status=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@212a0658', NULL, 257, 'test', '2020-08-17 21:20:22', NULL, NULL);
INSERT INTO `sys_log` VALUES (1335, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 15:10:50', NULL, NULL);
INSERT INTO `sys_log` VALUES (1336, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 15:25:33', NULL, NULL);
INSERT INTO `sys_log` VALUES (1337, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 15:26:38', NULL, NULL);
INSERT INTO `sys_log` VALUES (1338, 1, '用户: test,登录成功！', NULL, 'test', 'test', '202.85.209.162', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 15:34:23', NULL, NULL);
INSERT INTO `sys_log` VALUES (1339, 1, '用户: test,登录成功！', NULL, 'test', 'test', '202.85.209.162', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 15:57:22', NULL, NULL);
INSERT INTO `sys_log` VALUES (1330, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 15:01:17', NULL, NULL);
INSERT INTO `sys_log` VALUES (1331, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 15:01:22', NULL, NULL);
INSERT INTO `sys_log` VALUES (1332, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 15:02:25', NULL, NULL);
INSERT INTO `sys_log` VALUES (1333, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 15:02:29', NULL, NULL);
INSERT INTO `sys_log` VALUES (1334, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 15:10:45', NULL, NULL);
INSERT INTO `sys_log` VALUES (1325, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 08:47:45', NULL, NULL);
INSERT INTO `sys_log` VALUES (1326, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 08:47:52', NULL, NULL);
INSERT INTO `sys_log` VALUES (1327, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 08:48:27', NULL, NULL);
INSERT INTO `sys_log` VALUES (1328, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 08:52:53', NULL, NULL);
INSERT INTO `sys_log` VALUES (1329, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-17 15:00:45', NULL, NULL);
INSERT INTO `sys_log` VALUES (1321, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-16 22:39:58', NULL, NULL);
INSERT INTO `sys_log` VALUES (1322, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-16 22:40:13', NULL, NULL);
INSERT INTO `sys_log` VALUES (1323, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-16 22:44:39', NULL, NULL);
INSERT INTO `sys_log` VALUES (1324, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-16 22:44:49', NULL, NULL);
INSERT INTO `sys_log` VALUES (1316, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-16 22:28:24', NULL, NULL);
INSERT INTO `sys_log` VALUES (1317, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-16 22:33:46', NULL, NULL);
INSERT INTO `sys_log` VALUES (1318, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-16 22:34:01', NULL, NULL);
INSERT INTO `sys_log` VALUES (1319, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-16 22:35:29', NULL, NULL);
INSERT INTO `sys_log` VALUES (1320, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-16 22:36:36', NULL, NULL);
INSERT INTO `sys_log` VALUES (1311, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-16 22:11:00', NULL, NULL);
INSERT INTO `sys_log` VALUES (1312, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-16 22:11:07', NULL, NULL);
INSERT INTO `sys_log` VALUES (1313, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-16 22:26:47', NULL, NULL);
INSERT INTO `sys_log` VALUES (1314, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-16 22:26:54', NULL, NULL);
INSERT INTO `sys_log` VALUES (1315, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-16 22:28:16', NULL, NULL);
INSERT INTO `sys_log` VALUES (1310, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-16 22:03:03', NULL, NULL);
INSERT INTO `sys_log` VALUES (1305, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-16 14:44:34', NULL, NULL);
INSERT INTO `sys_log` VALUES (1306, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-16 15:00:19', NULL, NULL);
INSERT INTO `sys_log` VALUES (1307, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-16 21:49:58', NULL, NULL);
INSERT INTO `sys_log` VALUES (1308, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-16 21:50:08', NULL, NULL);
INSERT INTO `sys_log` VALUES (1309, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-16 22:02:57', NULL, NULL);
INSERT INTO `sys_log` VALUES (1301, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-16 14:29:16', NULL, NULL);
INSERT INTO `sys_log` VALUES (1302, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-16 14:29:25', NULL, NULL);
INSERT INTO `sys_log` VALUES (1303, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-16 14:29:55', NULL, NULL);
INSERT INTO `sys_log` VALUES (1304, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-16 14:30:08', NULL, NULL);
INSERT INTO `sys_log` VALUES (1296, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 23:52:21', NULL, NULL);
INSERT INTO `sys_log` VALUES (1297, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-16 13:39:24', NULL, NULL);
INSERT INTO `sys_log` VALUES (1298, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-16 14:04:19', NULL, NULL);
INSERT INTO `sys_log` VALUES (1299, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-16 14:17:03', NULL, NULL);
INSERT INTO `sys_log` VALUES (1300, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-16 14:17:10', NULL, NULL);
INSERT INTO `sys_log` VALUES (1291, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 22:59:30', NULL, NULL);
INSERT INTO `sys_log` VALUES (1292, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 23:00:15', NULL, NULL);
INSERT INTO `sys_log` VALUES (1293, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 23:14:36', NULL, NULL);
INSERT INTO `sys_log` VALUES (1294, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 23:14:42', NULL, NULL);
INSERT INTO `sys_log` VALUES (1295, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 23:52:16', NULL, NULL);
INSERT INTO `sys_log` VALUES (1290, 2, '定时任务-分页列表查询', 1, 'test', 'test', '127.0.0.1', 'org.z.modules.quartz.controller.QuartzJobController.queryPageList()', NULL, '  quartzJob: QuartzJob(id=null, createBy=null, createTime=null, delFlag=null, updateBy=null, updateTime=null, jobClassName=null, cronExpression=null, parameter=null, description=null, status=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@69fcd59', NULL, 60, 'test', '2020-08-15 22:37:31', NULL, NULL);
INSERT INTO `sys_log` VALUES (1289, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 22:27:21', NULL, NULL);
INSERT INTO `sys_log` VALUES (1288, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 22:26:59', NULL, NULL);
INSERT INTO `sys_log` VALUES (1059, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-07-22 06:53:59', NULL, NULL);
INSERT INTO `sys_log` VALUES (1060, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-03 21:40:04', NULL, NULL);
INSERT INTO `sys_log` VALUES (1061, 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-05 21:52:14', NULL, NULL);
INSERT INTO `sys_log` VALUES (1062, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-05 21:52:46', NULL, NULL);
INSERT INTO `sys_log` VALUES (1063, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-05 22:47:05', NULL, NULL);
INSERT INTO `sys_log` VALUES (1064, 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-05 22:47:26', NULL, NULL);
INSERT INTO `sys_log` VALUES (1065, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-05 22:48:05', NULL, NULL);
INSERT INTO `sys_log` VALUES (1066, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 10:04:18', NULL, NULL);
INSERT INTO `sys_log` VALUES (1067, 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 13:55:26', NULL, NULL);
INSERT INTO `sys_log` VALUES (1068, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 13:55:31', NULL, NULL);
INSERT INTO `sys_log` VALUES (1069, 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 14:01:30', NULL, NULL);
INSERT INTO `sys_log` VALUES (1070, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 14:01:35', NULL, NULL);
INSERT INTO `sys_log` VALUES (1071, 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 14:14:03', NULL, NULL);
INSERT INTO `sys_log` VALUES (1072, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 14:14:07', NULL, NULL);
INSERT INTO `sys_log` VALUES (1073, 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 14:15:59', NULL, NULL);
INSERT INTO `sys_log` VALUES (1074, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 14:16:07', NULL, NULL);
INSERT INTO `sys_log` VALUES (1075, 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 15:17:22', NULL, NULL);
INSERT INTO `sys_log` VALUES (1076, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 15:17:27', NULL, NULL);
INSERT INTO `sys_log` VALUES (1077, 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 15:25:19', NULL, NULL);
INSERT INTO `sys_log` VALUES (1078, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 15:25:23', NULL, NULL);
INSERT INTO `sys_log` VALUES (1079, 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 15:31:11', NULL, NULL);
INSERT INTO `sys_log` VALUES (1080, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 15:31:16', NULL, NULL);
INSERT INTO `sys_log` VALUES (1081, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 15:56:42', NULL, NULL);
INSERT INTO `sys_log` VALUES (1082, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 15:58:10', NULL, NULL);
INSERT INTO `sys_log` VALUES (1083, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 15:59:04', NULL, NULL);
INSERT INTO `sys_log` VALUES (1084, 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 16:00:20', NULL, NULL);
INSERT INTO `sys_log` VALUES (1085, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 16:00:23', NULL, NULL);
INSERT INTO `sys_log` VALUES (1086, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-06 19:54:16', NULL, NULL);
INSERT INTO `sys_log` VALUES (1087, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-07 11:32:53', NULL, NULL);
INSERT INTO `sys_log` VALUES (1088, 2, '编辑用户，id： 2', 2, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2020-08-07 17:28:49', NULL, NULL);
INSERT INTO `sys_log` VALUES (1089, 2, '编辑用户，id： 2', 2, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, 'admin', '2020-08-07 17:29:11', NULL, NULL);
INSERT INTO `sys_log` VALUES (1090, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-08 22:59:59', NULL, NULL);
INSERT INTO `sys_log` VALUES (1091, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-09 16:27:59', NULL, NULL);
INSERT INTO `sys_log` VALUES (1092, 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-09 17:14:22', NULL, NULL);
INSERT INTO `sys_log` VALUES (1093, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-09 17:18:24', NULL, NULL);
INSERT INTO `sys_log` VALUES (1094, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-10 08:57:56', NULL, NULL);
INSERT INTO `sys_log` VALUES (1095, 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.z.modules.system.controller.SysPositionController.queryPageList()', NULL, '  sysPosition: SysPosition(id=null, code=null, name=null, postRank=null, companyId=null, createBy=null, createTime=null, updateBy=null, updateTime=null, sysOrgCode=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@6927d70', NULL, 51, 'admin', '2020-08-10 09:06:57', NULL, NULL);
INSERT INTO `sys_log` VALUES (1096, 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.z.modules.system.controller.SysPositionController.queryPageList()', NULL, '  sysPosition: SysPosition(id=null, code=null, name=null, postRank=null, companyId=null, createBy=null, createTime=null, updateBy=null, updateTime=null, sysOrgCode=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@4e3e3dc2', NULL, 28, 'admin', '2020-08-10 09:07:01', NULL, NULL);
INSERT INTO `sys_log` VALUES (1097, 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.z.modules.system.controller.SysPositionController.queryPageList()', NULL, '  sysPosition: SysPosition(id=null, code=null, name=null, postRank=null, companyId=null, createBy=null, createTime=null, updateBy=null, updateTime=null, sysOrgCode=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@4ecd51cf', NULL, 27, 'admin', '2020-08-10 09:07:08', NULL, NULL);
INSERT INTO `sys_log` VALUES (1098, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-10 22:22:12', NULL, NULL);
INSERT INTO `sys_log` VALUES (1099, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-10 22:22:29', NULL, NULL);
INSERT INTO `sys_log` VALUES (1100, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-10 22:22:39', NULL, NULL);
INSERT INTO `sys_log` VALUES (1101, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-10 22:22:45', NULL, NULL);
INSERT INTO `sys_log` VALUES (1102, 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-10 22:25:28', NULL, NULL);
INSERT INTO `sys_log` VALUES (1103, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-10 22:25:32', NULL, NULL);
INSERT INTO `sys_log` VALUES (1104, 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.z.modules.system.controller.SysPositionController.queryPageList()', NULL, '  sysPosition: SysPosition(id=null, code=null, name=null, postRank=null, companyId=null, createBy=null, createTime=null, updateBy=null, updateTime=null, sysOrgCode=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@29309c72', NULL, 96, 'admin', '2020-08-10 23:15:35', NULL, NULL);
INSERT INTO `sys_log` VALUES (1105, 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.z.modules.system.controller.SysPositionController.queryPageList()', NULL, '  sysPosition: SysPosition(id=null, code=null, name=null, postRank=null, companyId=null, createBy=null, createTime=null, updateBy=null, updateTime=null, sysOrgCode=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@4c1a1263', NULL, 69, 'admin', '2020-08-11 09:11:47', NULL, NULL);
INSERT INTO `sys_log` VALUES (1106, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-11 11:56:30', NULL, NULL);
INSERT INTO `sys_log` VALUES (1107, 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-11 12:44:55', NULL, NULL);
INSERT INTO `sys_log` VALUES (1108, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-11 12:45:00', NULL, NULL);
INSERT INTO `sys_log` VALUES (1109, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-11 14:22:16', NULL, NULL);
INSERT INTO `sys_log` VALUES (1110, 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-11 14:56:58', NULL, NULL);
INSERT INTO `sys_log` VALUES (1111, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-11 14:57:19', NULL, NULL);
INSERT INTO `sys_log` VALUES (1112, 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.z.modules.system.controller.SysPositionController.queryPageList()', NULL, '  sysPosition: SysPosition(id=null, code=null, name=null, postRank=null, companyId=null, createBy=null, createTime=null, updateBy=null, updateTime=null, sysOrgCode=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@384bc3ba', NULL, 73, 'admin', '2020-08-11 21:07:02', NULL, NULL);
INSERT INTO `sys_log` VALUES (1113, 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.z.modules.system.controller.SysPositionController.queryPageList()', NULL, '  sysPosition: SysPosition(id=null, code=null, name=null, postRank=null, companyId=null, createBy=null, createTime=null, updateBy=null, updateTime=null, sysOrgCode=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@3178121f', NULL, 29, 'admin', '2020-08-11 21:07:03', NULL, NULL);
INSERT INTO `sys_log` VALUES (1114, 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.z.modules.system.controller.SysPositionController.queryPageList()', NULL, '  sysPosition: SysPosition(id=null, code=null, name=null, postRank=null, companyId=null, createBy=null, createTime=null, updateBy=null, updateTime=null, sysOrgCode=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@32f24905', NULL, 51, 'admin', '2020-08-11 21:07:05', NULL, NULL);
INSERT INTO `sys_log` VALUES (1115, 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.z.modules.system.controller.SysPositionController.queryPageList()', NULL, '  sysPosition: SysPosition(id=null, code=null, name=null, postRank=null, companyId=null, createBy=null, createTime=null, updateBy=null, updateTime=null, sysOrgCode=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@19eb0cbd', NULL, 30, 'admin', '2020-08-11 21:07:09', NULL, NULL);
INSERT INTO `sys_log` VALUES (1116, 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.z.modules.system.controller.SysPositionController.queryPageList()', NULL, '  sysPosition: SysPosition(id=null, code=null, name=null, postRank=null, companyId=null, createBy=null, createTime=null, updateBy=null, updateTime=null, sysOrgCode=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@4dcaab31', NULL, 28, 'admin', '2020-08-11 21:07:41', NULL, NULL);
INSERT INTO `sys_log` VALUES (1117, 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.z.modules.system.controller.SysPositionController.queryPageList()', NULL, '  sysPosition: SysPosition(id=null, code=null, name=null, postRank=null, companyId=null, createBy=null, createTime=null, updateBy=null, updateTime=null, sysOrgCode=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@42beabae', NULL, 29, 'admin', '2020-08-11 21:07:53', NULL, NULL);
INSERT INTO `sys_log` VALUES (1118, 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.z.modules.system.controller.SysPositionController.queryPageList()', NULL, '  sysPosition: SysPosition(id=null, code=null, name=null, postRank=null, companyId=null, createBy=null, createTime=null, updateBy=null, updateTime=null, sysOrgCode=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@2fc0133b', NULL, 34, 'admin', '2020-08-11 22:00:46', NULL, NULL);
INSERT INTO `sys_log` VALUES (1119, 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.z.modules.system.controller.SysPositionController.queryPageList()', NULL, '  sysPosition: SysPosition(id=null, code=null, name=null, postRank=null, companyId=null, createBy=null, createTime=null, updateBy=null, updateTime=null, sysOrgCode=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@67c6e2be', NULL, 28, 'admin', '2020-08-11 22:15:41', NULL, NULL);
INSERT INTO `sys_log` VALUES (1120, 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.z.modules.system.controller.SysPositionController.queryPageList()', NULL, '  sysPosition: SysPosition(id=null, code=null, name=null, postRank=null, companyId=null, createBy=null, createTime=null, updateBy=null, updateTime=null, sysOrgCode=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@6695541f', NULL, 27, 'admin', '2020-08-11 22:20:59', NULL, NULL);
INSERT INTO `sys_log` VALUES (1121, 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.z.modules.system.controller.SysPositionController.queryPageList()', NULL, '  sysPosition: SysPosition(id=null, code=null, name=null, postRank=null, companyId=null, createBy=null, createTime=null, updateBy=null, updateTime=null, sysOrgCode=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@28d3b885', NULL, 63, 'admin', '2020-08-11 22:24:56', NULL, NULL);
INSERT INTO `sys_log` VALUES (1122, 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.z.modules.system.controller.SysPositionController.queryPageList()', NULL, '  sysPosition: SysPosition(id=null, code=null, name=null, postRank=null, companyId=null, createBy=null, createTime=null, updateBy=null, updateTime=null, sysOrgCode=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@793a996f', NULL, 29, 'admin', '2020-08-11 22:24:58', NULL, NULL);
INSERT INTO `sys_log` VALUES (1123, 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.z.modules.system.controller.SysPositionController.queryPageList()', NULL, '  sysPosition: SysPosition(id=null, code=null, name=null, postRank=null, companyId=null, createBy=null, createTime=null, updateBy=null, updateTime=null, sysOrgCode=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@23c6b22e', NULL, 29, 'admin', '2020-08-11 22:26:46', NULL, NULL);
INSERT INTO `sys_log` VALUES (1124, 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.z.modules.system.controller.SysPositionController.queryPageList()', NULL, '  sysPosition: SysPosition(id=null, code=null, name=null, postRank=null, companyId=null, createBy=null, createTime=null, updateBy=null, updateTime=null, sysOrgCode=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@51a20dd9', NULL, 25, 'admin', '2020-08-11 22:29:57', NULL, NULL);
INSERT INTO `sys_log` VALUES (1125, 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.z.modules.system.controller.SysPositionController.queryPageList()', NULL, '  sysPosition: SysPosition(id=null, code=null, name=null, postRank=null, companyId=null, createBy=null, createTime=null, updateBy=null, updateTime=null, sysOrgCode=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@5ef26ecd', NULL, 28, 'admin', '2020-08-11 22:30:03', NULL, NULL);
INSERT INTO `sys_log` VALUES (1126, 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-11 23:03:13', NULL, NULL);
INSERT INTO `sys_log` VALUES (1127, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-11 23:03:26', NULL, NULL);
INSERT INTO `sys_log` VALUES (1128, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-11 23:16:13', NULL, NULL);
INSERT INTO `sys_log` VALUES (1129, 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-11 23:27:24', NULL, NULL);
INSERT INTO `sys_log` VALUES (1130, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-11 23:31:26', NULL, NULL);
INSERT INTO `sys_log` VALUES (1131, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-11 23:34:10', NULL, NULL);
INSERT INTO `sys_log` VALUES (1132, 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-12 10:11:36', NULL, NULL);
INSERT INTO `sys_log` VALUES (1133, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-12 10:11:48', NULL, NULL);
INSERT INTO `sys_log` VALUES (1134, 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-12 10:11:49', NULL, NULL);
INSERT INTO `sys_log` VALUES (1135, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-12 10:12:10', NULL, NULL);
INSERT INTO `sys_log` VALUES (1136, 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-12 10:12:11', NULL, NULL);
INSERT INTO `sys_log` VALUES (1137, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-12 10:21:16', NULL, NULL);
INSERT INTO `sys_log` VALUES (1138, 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-12 10:21:17', NULL, NULL);
INSERT INTO `sys_log` VALUES (1139, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-12 10:21:50', NULL, NULL);
INSERT INTO `sys_log` VALUES (1140, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-12 23:43:09', NULL, NULL);
INSERT INTO `sys_log` VALUES (1141, 1, '用户名: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-12 23:44:04', NULL, NULL);
INSERT INTO `sys_log` VALUES (1142, 1, '用户名: admin,登录成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-13 09:52:17', NULL, NULL);
INSERT INTO `sys_log` VALUES (1143, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-13 11:33:59', NULL, NULL);
INSERT INTO `sys_log` VALUES (1144, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-13 11:34:10', NULL, NULL);
INSERT INTO `sys_log` VALUES (1145, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 10:56:36', NULL, NULL);
INSERT INTO `sys_log` VALUES (1146, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 10:56:46', NULL, NULL);
INSERT INTO `sys_log` VALUES (1147, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 10:56:46', NULL, NULL);
INSERT INTO `sys_log` VALUES (1148, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 10:57:05', NULL, NULL);
INSERT INTO `sys_log` VALUES (1149, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 10:57:06', NULL, NULL);
INSERT INTO `sys_log` VALUES (1150, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 11:00:00', NULL, NULL);
INSERT INTO `sys_log` VALUES (1151, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 11:00:00', NULL, NULL);
INSERT INTO `sys_log` VALUES (1152, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 11:06:28', NULL, NULL);
INSERT INTO `sys_log` VALUES (1153, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 11:06:28', NULL, NULL);
INSERT INTO `sys_log` VALUES (1154, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 11:10:08', NULL, NULL);
INSERT INTO `sys_log` VALUES (1155, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 11:10:08', NULL, NULL);
INSERT INTO `sys_log` VALUES (1156, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 11:10:54', NULL, NULL);
INSERT INTO `sys_log` VALUES (1157, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 11:10:54', NULL, NULL);
INSERT INTO `sys_log` VALUES (1158, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 11:15:04', NULL, NULL);
INSERT INTO `sys_log` VALUES (1159, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 11:15:05', NULL, NULL);
INSERT INTO `sys_log` VALUES (1160, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 11:16:34', NULL, NULL);
INSERT INTO `sys_log` VALUES (1161, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 16:16:48', NULL, NULL);
INSERT INTO `sys_log` VALUES (1162, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 16:17:19', NULL, NULL);
INSERT INTO `sys_log` VALUES (1163, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 16:17:19', NULL, NULL);
INSERT INTO `sys_log` VALUES (1164, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 16:18:57', NULL, NULL);
INSERT INTO `sys_log` VALUES (1165, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 16:18:57', NULL, NULL);
INSERT INTO `sys_log` VALUES (1166, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 16:20:43', NULL, NULL);
INSERT INTO `sys_log` VALUES (1167, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 16:20:43', NULL, NULL);
INSERT INTO `sys_log` VALUES (1168, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 16:25:01', NULL, NULL);
INSERT INTO `sys_log` VALUES (1169, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 16:25:01', NULL, NULL);
INSERT INTO `sys_log` VALUES (1170, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 16:29:30', NULL, NULL);
INSERT INTO `sys_log` VALUES (1171, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 17:15:20', NULL, NULL);
INSERT INTO `sys_log` VALUES (1172, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 17:15:56', NULL, NULL);
INSERT INTO `sys_log` VALUES (1173, 2, '职务表-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.z.modules.system.controller.SysPositionController.queryPageList()', NULL, '  sysPosition: SysPosition(id=null, code=null, name=null, postRank=null, companyId=null, createBy=null, createTime=null, updateBy=null, updateTime=null, sysOrgCode=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@1e715f7e', NULL, 68, 'admin', '2020-08-14 17:18:57', NULL, NULL);
INSERT INTO `sys_log` VALUES (1174, 2, '定时任务-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.z.modules.quartz.controller.QuartzJobController.queryPageList()', NULL, '  quartzJob: QuartzJob(id=null, createBy=null, createTime=null, delFlag=null, updateBy=null, updateTime=null, jobClassName=null, cronExpression=null, parameter=null, description=null, status=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@21ef9b6a', NULL, 63, 'admin', '2020-08-14 17:18:59', NULL, NULL);
INSERT INTO `sys_log` VALUES (1175, 2, '定时任务-分页列表查询', 1, 'admin', '管理员', '127.0.0.1', 'org.z.modules.quartz.controller.QuartzJobController.queryPageList()', NULL, '  quartzJob: QuartzJob(id=null, createBy=null, createTime=null, delFlag=null, updateBy=null, updateTime=null, jobClassName=null, cronExpression=null, parameter=null, description=null, status=null)  pageNo: 1  pageSize: 10  req: org.apache.shiro.web.servlet.ShiroHttpServletRequest@3d72073c', NULL, 55, 'admin', '2020-08-14 17:20:58', NULL, NULL);
INSERT INTO `sys_log` VALUES (1176, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 23:15:35', NULL, NULL);
INSERT INTO `sys_log` VALUES (1177, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 23:18:37', NULL, NULL);
INSERT INTO `sys_log` VALUES (1178, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 23:18:46', NULL, NULL);
INSERT INTO `sys_log` VALUES (1179, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 23:26:36', NULL, NULL);
INSERT INTO `sys_log` VALUES (1180, 1, '用户登录失败，用户名:test已冻结！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 23:26:45', NULL, NULL);
INSERT INTO `sys_log` VALUES (1181, 1, '用户登录失败，用户名:test已冻结！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 23:31:11', NULL, NULL);
INSERT INTO `sys_log` VALUES (1182, 1, '用户登录失败，用户名:test已冻结！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 23:31:26', NULL, NULL);
INSERT INTO `sys_log` VALUES (1183, 1, '用户登录失败，用户名:test已冻结！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 23:32:11', NULL, NULL);
INSERT INTO `sys_log` VALUES (1184, 1, '用户登录失败，用户名:test已冻结！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 23:33:16', NULL, NULL);
INSERT INTO `sys_log` VALUES (1185, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 23:33:33', NULL, NULL);
INSERT INTO `sys_log` VALUES (1186, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 23:33:38', NULL, NULL);
INSERT INTO `sys_log` VALUES (1187, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 23:34:30', NULL, NULL);
INSERT INTO `sys_log` VALUES (1188, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 23:34:46', NULL, NULL);
INSERT INTO `sys_log` VALUES (1189, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 23:36:00', NULL, NULL);
INSERT INTO `sys_log` VALUES (1190, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 23:36:01', NULL, NULL);
INSERT INTO `sys_log` VALUES (1191, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 23:37:19', NULL, NULL);
INSERT INTO `sys_log` VALUES (1192, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 23:37:20', NULL, NULL);
INSERT INTO `sys_log` VALUES (1193, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 23:37:53', NULL, NULL);
INSERT INTO `sys_log` VALUES (1194, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 23:37:53', NULL, NULL);
INSERT INTO `sys_log` VALUES (1195, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 23:37:56', NULL, NULL);
INSERT INTO `sys_log` VALUES (1196, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 23:37:56', NULL, NULL);
INSERT INTO `sys_log` VALUES (1197, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 23:38:11', NULL, NULL);
INSERT INTO `sys_log` VALUES (1198, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 23:38:44', NULL, NULL);
INSERT INTO `sys_log` VALUES (1199, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-14 23:38:48', NULL, NULL);
INSERT INTO `sys_log` VALUES (1200, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 10:05:28', NULL, NULL);
INSERT INTO `sys_log` VALUES (1201, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 10:05:34', NULL, NULL);
INSERT INTO `sys_log` VALUES (1202, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 10:08:25', NULL, NULL);
INSERT INTO `sys_log` VALUES (1203, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 10:08:33', NULL, NULL);
INSERT INTO `sys_log` VALUES (1204, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 10:13:49', NULL, NULL);
INSERT INTO `sys_log` VALUES (1205, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 10:13:55', NULL, NULL);
INSERT INTO `sys_log` VALUES (1206, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 10:48:25', NULL, NULL);
INSERT INTO `sys_log` VALUES (1207, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 10:48:33', NULL, NULL);
INSERT INTO `sys_log` VALUES (1208, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 10:53:59', NULL, NULL);
INSERT INTO `sys_log` VALUES (1209, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 10:54:08', NULL, NULL);
INSERT INTO `sys_log` VALUES (1210, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 10:58:17', NULL, NULL);
INSERT INTO `sys_log` VALUES (1211, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 10:58:29', NULL, NULL);
INSERT INTO `sys_log` VALUES (1212, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 10:58:52', NULL, NULL);
INSERT INTO `sys_log` VALUES (1213, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 10:58:56', NULL, NULL);
INSERT INTO `sys_log` VALUES (1214, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 10:59:38', NULL, NULL);
INSERT INTO `sys_log` VALUES (1215, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 10:59:43', NULL, NULL);
INSERT INTO `sys_log` VALUES (1216, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 11:00:52', NULL, NULL);
INSERT INTO `sys_log` VALUES (1217, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 11:00:58', NULL, NULL);
INSERT INTO `sys_log` VALUES (1218, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 11:38:39', NULL, NULL);
INSERT INTO `sys_log` VALUES (1219, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 11:38:53', NULL, NULL);
INSERT INTO `sys_log` VALUES (1220, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 11:44:01', NULL, NULL);
INSERT INTO `sys_log` VALUES (1221, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 11:44:06', NULL, NULL);
INSERT INTO `sys_log` VALUES (1222, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 11:46:01', NULL, NULL);
INSERT INTO `sys_log` VALUES (1223, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 11:52:21', NULL, NULL);
INSERT INTO `sys_log` VALUES (1224, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 11:56:10', NULL, NULL);
INSERT INTO `sys_log` VALUES (1225, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 11:57:38', NULL, NULL);
INSERT INTO `sys_log` VALUES (1226, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 11:59:29', NULL, NULL);
INSERT INTO `sys_log` VALUES (1227, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 12:02:47', NULL, NULL);
INSERT INTO `sys_log` VALUES (1228, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 12:03:07', NULL, NULL);
INSERT INTO `sys_log` VALUES (1229, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 12:09:37', NULL, NULL);
INSERT INTO `sys_log` VALUES (1230, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 12:10:26', NULL, NULL);
INSERT INTO `sys_log` VALUES (1231, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 12:12:53', NULL, NULL);
INSERT INTO `sys_log` VALUES (1232, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 12:22:48', NULL, NULL);
INSERT INTO `sys_log` VALUES (1233, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 12:23:05', NULL, NULL);
INSERT INTO `sys_log` VALUES (1234, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 12:23:53', NULL, NULL);
INSERT INTO `sys_log` VALUES (1235, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 12:25:03', NULL, NULL);
INSERT INTO `sys_log` VALUES (1236, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 12:25:33', NULL, NULL);
INSERT INTO `sys_log` VALUES (1237, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 12:26:53', NULL, NULL);
INSERT INTO `sys_log` VALUES (1238, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 12:33:39', NULL, NULL);
INSERT INTO `sys_log` VALUES (1239, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 12:34:07', NULL, NULL);
INSERT INTO `sys_log` VALUES (1240, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 12:34:23', NULL, NULL);
INSERT INTO `sys_log` VALUES (1241, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 12:34:41', NULL, NULL);
INSERT INTO `sys_log` VALUES (1242, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 12:35:00', NULL, NULL);
INSERT INTO `sys_log` VALUES (1243, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 12:35:09', NULL, NULL);
INSERT INTO `sys_log` VALUES (1244, 2, '用户-编辑', 3, 'admin', '管理员', '127.0.0.1', 'org.z.modules.system.controller.SysUserController.edit()', NULL, '[{\"id\":\"2\",\"username\":\"test\",\"realname\":\"test\",\"avatar\":\"https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif?imageView2/1/w/80/h/80\",\"sex\":\"1\",\"orgCode\":\"A02A01\",\"status\":\"1\",\"delFlag\":\"0\",\"workNo\":\"00002\",\"post\":\"devleader\",\"createBy\":\"admin\",\"createTime\":\"2019-02-13 16:02:36\",\"updateBy\":\"admin\",\"updateTime\":\"2020-08-14 23:34:41\",\"introduction\":\"\",\"sex_dictText\":\"男\",\"status_dictText\":\"正常\",\"birthday\":\"2015-08-13\",\"email\":\"test@163.com\",\"phone\":\"18889633695\",\"telephone\":\"010-96633256\",\"selectedroles\":\"3\"}]', NULL, 320, 'admin', '2020-08-15 12:36:02', NULL, NULL);
INSERT INTO `sys_log` VALUES (1245, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 12:38:12', NULL, NULL);
INSERT INTO `sys_log` VALUES (1246, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 12:38:22', NULL, NULL);
INSERT INTO `sys_log` VALUES (1247, 2, '用户-编辑', 3, 'admin', '管理员', '127.0.0.1', 'org.z.modules.system.controller.SysUserController.edit()', NULL, '[{\"id\":\"2\",\"username\":\"test\",\"realname\":\"test\",\"avatar\":\"https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif?imageView2/1/w/80/h/80\",\"sex\":\"1\",\"orgCode\":\"A02A01\",\"status\":\"1\",\"delFlag\":\"0\",\"workNo\":\"00002\",\"post\":\"devleader\",\"createBy\":\"admin\",\"createTime\":\"2019-02-13 16:02:36\",\"updateBy\":\"admin\",\"updateTime\":\"2020-08-14 23:34:41\",\"introduction\":\"\",\"sex_dictText\":\"男\",\"status_dictText\":\"正常\",\"birthday\":\"2020-07-01\",\"email\":\"test@163.com\",\"phone\":\"18889633695\",\"telephone\":\"010-96633256\",\"selectedroles\":\"3\"}]', NULL, 263, 'admin', '2020-08-15 12:38:38', NULL, NULL);
INSERT INTO `sys_log` VALUES (1248, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 12:40:23', NULL, NULL);
INSERT INTO `sys_log` VALUES (1249, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 12:40:32', NULL, NULL);
INSERT INTO `sys_log` VALUES (1250, 2, '用户-编辑', 3, 'admin', '管理员', '127.0.0.1', 'org.z.modules.system.controller.SysUserController.edit()', NULL, '[{\"id\":\"2\",\"username\":\"test\",\"realname\":\"test\",\"avatar\":\"https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif?imageView2/1/w/80/h/80\",\"sex\":\"1\",\"orgCode\":\"A02A01\",\"status\":\"1\",\"delFlag\":\"0\",\"workNo\":\"00002\",\"post\":\"devleader\",\"createBy\":\"admin\",\"createTime\":\"2019-02-13 16:02:36\",\"updateBy\":\"admin\",\"updateTime\":\"2020-08-14 23:34:41\",\"introduction\":\"\",\"sex_dictText\":\"男\",\"status_dictText\":\"正常\",\"birthday\":\"2016-08-17\",\"email\":\"test@163.com\",\"phone\":\"18889633695\",\"telephone\":\"010-96633256\",\"selectedroles\":\"3\"}]', NULL, 11800, 'admin', '2020-08-15 12:41:00', NULL, NULL);
INSERT INTO `sys_log` VALUES (1251, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 12:57:16', NULL, NULL);
INSERT INTO `sys_log` VALUES (1252, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 12:57:29', NULL, NULL);
INSERT INTO `sys_log` VALUES (1253, 2, '用户-编辑', 3, 'admin', '管理员', '127.0.0.1', 'org.z.modules.system.controller.SysUserController.edit()', NULL, '[{\"id\":2,\"username\":\"test\",\"realname\":\"test\",\"avatar\":\"https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif?imageView2/1/w/80/h/80\",\"birthday\":\"2017-08-03\",\"sex\":1,\"email\":\"test@163.com\",\"phone\":\"18889633695\",\"orgCode\":\"A02A01\",\"status\":1,\"delFlag\":0,\"workNo\":\"00002\",\"post\":\"devleader\",\"telephone\":\"010-96633256\",\"createBy\":\"admin\",\"createTime\":\"2019-02-13 16:02:36\",\"updateBy\":\"admin\",\"updateTime\":\"2020-08-15 12:57:47\",\"introduction\":\"\"},null]', NULL, 107, 'admin', '2020-08-15 12:57:48', NULL, NULL);
INSERT INTO `sys_log` VALUES (1254, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 13:36:29', NULL, NULL);
INSERT INTO `sys_log` VALUES (1255, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 13:36:39', NULL, NULL);
INSERT INTO `sys_log` VALUES (1256, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 13:36:40', NULL, NULL);
INSERT INTO `sys_log` VALUES (1257, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 13:36:58', NULL, NULL);
INSERT INTO `sys_log` VALUES (1258, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 13:36:59', NULL, NULL);
INSERT INTO `sys_log` VALUES (1259, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 13:37:07', NULL, NULL);
INSERT INTO `sys_log` VALUES (1260, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 13:37:08', NULL, NULL);
INSERT INTO `sys_log` VALUES (1261, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 13:37:31', NULL, NULL);
INSERT INTO `sys_log` VALUES (1262, 2, '用户-编辑', 3, 'admin', '管理员', '127.0.0.1', 'org.z.modules.system.controller.SysUserController.edit()', NULL, '[{\"id\":2,\"username\":\"test\",\"realname\":\"test\",\"avatar\":\"https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif?imageView2/1/w/80/h/80\",\"birthday\":\"2017-08-03\",\"sex\":1,\"email\":\"test@163.com\",\"phone\":\"18889633695\",\"orgCode\":\"A02A01\",\"status\":1,\"delFlag\":0,\"workNo\":\"00002\",\"post\":\"devleader\",\"telephone\":\"010-96633256\",\"createBy\":\"admin\",\"createTime\":\"2019-02-13 16:02:36\",\"updateBy\":\"admin\",\"updateTime\":\"2020-08-15 13:37:47\",\"introduction\":\"\"},null]', NULL, 94, 'admin', '2020-08-15 13:37:48', NULL, NULL);
INSERT INTO `sys_log` VALUES (1263, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 13:38:43', NULL, NULL);
INSERT INTO `sys_log` VALUES (1264, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 13:38:48', NULL, NULL);
INSERT INTO `sys_log` VALUES (1265, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 13:38:48', NULL, NULL);
INSERT INTO `sys_log` VALUES (1266, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 13:38:56', NULL, NULL);
INSERT INTO `sys_log` VALUES (1267, 2, '用户-编辑', 3, 'admin', '管理员', '127.0.0.1', 'org.z.modules.system.controller.SysUserController.edit()', NULL, '[{\"id\":2,\"username\":\"test\",\"realname\":\"test\",\"avatar\":\"https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif?imageView2/1/w/80/h/80\",\"birthday\":\"2017-08-03\",\"sex\":1,\"email\":\"test@163.com\",\"phone\":\"18889633695\",\"orgCode\":\"A02A01\",\"status\":1,\"delFlag\":0,\"workNo\":\"00002\",\"post\":\"devleader\",\"telephone\":\"010-96633256\",\"createBy\":\"admin\",\"createTime\":\"2019-02-13 16:02:36\",\"updateBy\":\"admin\",\"updateTime\":\"2020-08-15 13:40:24\",\"introduction\":\"\"},null]', NULL, 85, 'admin', '2020-08-15 13:40:24', NULL, NULL);
INSERT INTO `sys_log` VALUES (1268, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 13:46:10', NULL, NULL);
INSERT INTO `sys_log` VALUES (1269, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 13:46:16', NULL, NULL);
INSERT INTO `sys_log` VALUES (1270, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 13:46:16', NULL, NULL);
INSERT INTO `sys_log` VALUES (1271, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 13:46:23', NULL, NULL);
INSERT INTO `sys_log` VALUES (1272, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 13:54:17', NULL, NULL);
INSERT INTO `sys_log` VALUES (1273, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 13:54:25', NULL, NULL);
INSERT INTO `sys_log` VALUES (1274, 2, '用户-删除用户', 4, 'admin', '管理员', '127.0.0.1', 'org.z.modules.system.controller.SysUserController.delete()', NULL, '  id: 5', NULL, 64, 'admin', '2020-08-15 13:54:31', NULL, NULL);
INSERT INTO `sys_log` VALUES (1275, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 14:04:07', NULL, NULL);
INSERT INTO `sys_log` VALUES (1276, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 14:04:15', NULL, NULL);
INSERT INTO `sys_log` VALUES (1277, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 14:04:16', NULL, NULL);
INSERT INTO `sys_log` VALUES (1278, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 14:04:23', NULL, NULL);
INSERT INTO `sys_log` VALUES (1279, 2, '用户-编辑', 3, 'admin', '管理员', '127.0.0.1', 'org.z.modules.system.controller.SysUserController.edit()', NULL, '[{\"id\":2,\"username\":\"test\",\"realname\":\"test\",\"avatar\":\"https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif?imageView2/1/w/80/h/80\",\"birthday\":\"2017-08-03\",\"sex\":1,\"email\":\"test@163.com\",\"phone\":\"18889633695\",\"orgCode\":\"A02A01\",\"status\":1,\"delFlag\":0,\"workNo\":\"00002\",\"post\":\"devleader\",\"telephone\":\"010-96633256\",\"createBy\":\"admin\",\"createTime\":\"2019-02-13 16:02:36\",\"updateBy\":\"admin\",\"updateTime\":\"2020-08-15 14:04:36\",\"introduction\":\"\",\"roles\":\"2\"}]', NULL, 124, 'admin', '2020-08-15 14:04:37', NULL, NULL);
INSERT INTO `sys_log` VALUES (1280, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 14:04:51', NULL, NULL);
INSERT INTO `sys_log` VALUES (1281, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 14:04:58', NULL, NULL);
INSERT INTO `sys_log` VALUES (1282, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 14:09:00', NULL, NULL);
INSERT INTO `sys_log` VALUES (1283, 1, '用户: 管理员,登录成功！', NULL, 'admin', '管理员', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 14:09:05', NULL, NULL);
INSERT INTO `sys_log` VALUES (1284, 1, '用户: 管理员,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 14:09:21', NULL, NULL);
INSERT INTO `sys_log` VALUES (1285, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 14:09:26', NULL, NULL);
INSERT INTO `sys_log` VALUES (1286, 1, '用户: test,退出成功！', NULL, NULL, NULL, '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 14:10:21', NULL, NULL);
INSERT INTO `sys_log` VALUES (1287, 1, '用户: test,登录成功！', NULL, 'test', 'test', '127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 14:10:24', NULL, NULL);

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NULL DEFAULT NULL COMMENT '父id',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单标题',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路径',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件名字',
  `redirect` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '一级菜单跳转地址',
  `menu_type` int(11) NULL DEFAULT NULL COMMENT '菜单类型(0:一级菜单; 1:子菜单:2:按钮权限)',
  `perms` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单权限编码',
  `perms_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '权限策略1显示2禁用',
  `sort_no` double(8, 2) NULL DEFAULT NULL COMMENT '菜单排序',
  `always_show` tinyint(1) NULL DEFAULT NULL COMMENT '聚合子路由: 1是0否',
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `is_route` tinyint(1) NULL DEFAULT 1 COMMENT '是否路由菜单: 0:不是  1:是（默认值1）',
  `is_leaf` tinyint(1) NULL DEFAULT NULL COMMENT '是否叶子节点:    1:是   0:不是',
  `keep_alive` tinyint(1) NULL DEFAULT NULL COMMENT '是否缓存该页面:    1:是   0:不是',
  `hidden` int(2) NULL DEFAULT 0 COMMENT '是否隐藏路由: 0否,1是',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `del_flag` int(1) NULL DEFAULT 0 COMMENT '删除状态 0正常 1已删除',
  `rule_flag` int(3) NULL DEFAULT 0 COMMENT '是否添加数据权限1是0否',
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮权限状态(0无效1有效)',
  `external` tinyint(1) NULL DEFAULT NULL COMMENT '外链菜单打开方式 0/内部打开 1/外部打开',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_prem_is_route`(`is_route`) USING BTREE,
  INDEX `index_prem_is_leaf`(`is_leaf`) USING BTREE,
  INDEX `index_prem_sort_no`(`sort_no`) USING BTREE,
  INDEX `index_prem_del_flag`(`del_flag`) USING BTREE,
  INDEX `index_menu_type`(`menu_type`) USING BTREE,
  INDEX `index_menu_hidden`(`hidden`) USING BTREE,
  INDEX `index_menu_status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES (1, NULL, 'menu.dashboard', '/dashboard', 'layouts/BasicLayout', '仪表盘', '/dashboard/analysis', 0, NULL, NULL, 1.00, 0, 'home', 1, 0, NULL, 0, NULL, NULL, '2018-12-25 20:34:38', 'admin', '2019-03-29 11:04:13', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES (2, 1, 'menu.dashboard.analysis', '/dashboard/analysis', 'dashboard/Analysis', '分析台', NULL, 0, NULL, NULL, 0.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, '2018-12-25 20:34:38', 'admin', '2019-03-29 11:04:13', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES (3, 1, 'menu.dashboard.workplace', '/dashboard/workplace', 'dashboard/Workplace', '工作台', NULL, 0, NULL, NULL, 0.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, '2018-12-25 20:34:38', 'admin', '2019-03-29 11:04:13', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES (4, 35, 'icons', '/icons/index', 'icons/IconsTab', 'icons', '', 1, NULL, '0', 5.00, 0, 'bulb', 1, 1, 0, 0, NULL, NULL, '2020-08-03 22:01:33', 'admin', '2020-08-15 23:22:18', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES (5, NULL, 'menu.home', '/', 'layouts/BasicLayout', '首页', '/dashboard', 0, NULL, '0', 0.00, 0, 'bulb', 1, 1, 0, 0, NULL, NULL, '2020-08-03 22:01:33', 'admin', '2020-08-15 23:17:52', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES (6, NULL, '系统管理', '/isystem', 'layouts/BasicLayout', '系统管理', NULL, 0, NULL, NULL, 2.00, 0, 'setting', 1, 0, NULL, 0, NULL, NULL, '2018-12-25 20:34:38', 'admin', '2019-03-31 22:19:52', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES (7, 6, '职务管理', '/isystem/position', 'system/SysPositionList', '职务管理', NULL, 1, NULL, '1', 2.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2019-09-19 10:14:13', 'admin', '2019-09-19 10:15:22', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES (8, 6, '角色管理', '/isystem/roleUserList', 'system/RoleList', '角色管理', NULL, 1, NULL, NULL, 1.20, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2019-04-17 15:13:56', 'admin', '2019-12-25 09:36:31', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES (9, 6, '用户管理', '/isystem/user', 'system/UserList', '用户管理', NULL, 1, NULL, NULL, 1.10, 0, NULL, 1, 0, 0, 0, NULL, NULL, '2018-12-25 20:34:38', 'admin', '2019-12-25 09:36:24', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES (10, 6, '菜单管理', '/isystem/permission', 'system/PermissionList', '菜单管理', NULL, 1, NULL, NULL, 1.30, 0, NULL, 1, 1, 0, 0, NULL, NULL, '2018-12-25 20:34:38', 'admin', '2019-12-25 09:36:39', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES (12, 6, '数据字典', '/isystem/dict', 'system/DictList', '数据字典', NULL, 1, NULL, NULL, 5.00, 0, NULL, 1, 1, 0, 0, NULL, NULL, '2018-12-28 13:54:43', 'admin', '2020-02-23 22:45:25', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES (13, 6, '定时任务', '/monitor/QuartzJobList', 'system/QuartzJobList', '定时任务', NULL, 1, NULL, NULL, 3.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, '2019-01-03 09:38:52', 'admin', '2019-04-02 10:24:13', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES (14, NULL, '系统监控', '/monitor', 'layouts/BasicLayout', '系统监控', NULL, 1, NULL, NULL, 3.00, 0, 'dashboard', 1, 0, NULL, 0, NULL, 'admin', '2019-04-02 11:34:34', 'admin', '2019-05-05 17:49:47', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES (15, 14, 'Tomcat信息', '/monitor/TomcatInfo', 'modules/monitor/TomcatInfo', 'Tomcat信息', NULL, 1, NULL, NULL, 4.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-04-02 09:44:29', 'admin', '2019-05-07 15:19:10', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES (16, 14, '服务器信息', '/monitor/SystemInfo', 'modules/monitor/SystemInfo', '服务器信息', NULL, 1, NULL, NULL, 4.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-04-02 11:39:19', 'admin', '2019-04-02 15:40:02', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES (19, 14, 'JVM信息', '/monitor/JvmInfo', 'modules/monitor/JvmInfo', 'JVM信息', NULL, 1, NULL, NULL, 4.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-04-01 23:07:48', 'admin', '2019-04-02 11:37:16', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES (20, 14, '请求追踪', '/monitor/HttpTrace', 'modules/monitor/HttpTrace', '请求追踪', NULL, 1, NULL, NULL, 4.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-04-02 09:46:19', 'admin', '2019-04-02 11:37:27', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES (21, 14, '日志信息', '/monitor/log', 'system/LogList', '日志信息', NULL, 1, NULL, NULL, 1.00, 0, '', 1, 1, NULL, 0, NULL, NULL, '2018-12-26 10:11:18', 'admin', '2019-04-02 11:38:17', 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES (22, 14, 'SQL监控', 'http://localhost:8080/dev-api/druid/', 'layouts/IframePageView', 'SQL监控', NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-01-30 09:43:22', 'admin', '2019-03-23 19:00:46', 0, 0, NULL, 0);
INSERT INTO `sys_permission` VALUES (23, NULL, '错误页面', '/exception', 'layouts/BasicLayout', '错误页面', NULL, 0, NULL, NULL, 4.00, NULL, 'warning', 1, 0, NULL, NULL, NULL, NULL, '2018-12-25 20:34:38', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES (24, 23, '403', '/exception/403', 'exception/403', '403', NULL, 1, NULL, NULL, 2.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, '2018-12-25 20:34:38', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES (25, 23, '404', '/exception/404', 'exception/404', '404', NULL, 1, NULL, NULL, 1.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, '2018-12-25 20:34:38', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission` VALUES (26, 9, '添加用户按钮', '', NULL, '添加用户按钮', NULL, 2, 'user:add', '1', 1.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-03-16 11:20:33', 'admin', '2019-05-17 18:31:25', 0, 0, '1', NULL);
INSERT INTO `sys_permission` VALUES (30, NULL, '外链', '/external', 'layouts/BasicLayout', '外链', NULL, 0, NULL, NULL, 6.00, 0, 'ie', 1, 0, 0, 0, NULL, 'admin', '2020-08-14 09:58:38', 'admin', '2020-08-14 17:06:40', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES (31, 30, '百度_in', 'https://www.baidu.com', 'layouts/IframePageView', '百度_in', NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-08-14 09:58:38', 'admin', '2020-08-14 17:06:57', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES (32, 30, '百度_out', 'https://www.baidu.com', 'null', '百度_out', NULL, 0, NULL, NULL, 1.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-08-14 09:58:38', 'admin', '2020-08-14 16:53:08', 0, 0, '1', 1);
INSERT INTO `sys_permission` VALUES (34, 9, '编辑用户', NULL, NULL, '编辑用户', NULL, 2, 'user:edit', '1', 1.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2020-08-15 11:11:49', 'admin', '2020-08-15 11:44:29', 0, 0, '1', 0);
INSERT INTO `sys_permission` VALUES (35, NULL, '组件', '/components', 'layouts/BasicLayout', '组件', NULL, 0, NULL, '1', 6.00, 0, 'plus-square', 1, 0, 0, 0, NULL, 'admin', '2020-08-15 23:22:05', NULL, NULL, 0, 0, '1', 0);

-- ----------------------------
-- Table structure for sys_permission_element
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission_element`;
CREATE TABLE `sys_permission_element`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NULL DEFAULT NULL COMMENT '父id',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单标题',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路径',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件',
  `component_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件名字',
  `redirect` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '一级菜单跳转地址',
  `menu_type` int(11) NULL DEFAULT NULL COMMENT '菜单类型(0:一级菜单; 1:子菜单:2:按钮权限)',
  `perms` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单权限编码',
  `perms_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '权限策略1显示2禁用',
  `sort_no` double(8, 2) NULL DEFAULT NULL COMMENT '菜单排序',
  `always_show` tinyint(1) NULL DEFAULT NULL COMMENT '聚合子路由: 1是0否',
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `is_route` tinyint(1) NULL DEFAULT 1 COMMENT '是否路由菜单: 0:不是  1:是（默认值1）',
  `is_leaf` tinyint(1) NULL DEFAULT NULL COMMENT '是否叶子节点:    1:是   0:不是',
  `keep_alive` tinyint(1) NULL DEFAULT NULL COMMENT '是否缓存该页面:    1:是   0:不是',
  `hidden` int(2) NULL DEFAULT 0 COMMENT '是否隐藏路由: 0否,1是',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `del_flag` int(1) NULL DEFAULT 0 COMMENT '删除状态 0正常 1已删除',
  `rule_flag` int(3) NULL DEFAULT 0 COMMENT '是否添加数据权限1是0否',
  `status` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按钮权限状态(0无效1有效)',
  `internal_or_external` tinyint(1) NULL DEFAULT NULL COMMENT '外链菜单打开方式 0/内部打开 1/外部打开',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_prem_is_route`(`is_route`) USING BTREE,
  INDEX `index_prem_is_leaf`(`is_leaf`) USING BTREE,
  INDEX `index_prem_sort_no`(`sort_no`) USING BTREE,
  INDEX `index_prem_del_flag`(`del_flag`) USING BTREE,
  INDEX `index_menu_type`(`menu_type`) USING BTREE,
  INDEX `index_menu_hidden`(`hidden`) USING BTREE,
  INDEX `index_menu_status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 113 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_permission_element
-- ----------------------------
INSERT INTO `sys_permission_element` VALUES (1, NULL, 'icons', '/icon', 'Layout', NULL, NULL, 0, NULL, '0', NULL, NULL, 'icon', 1, 0, NULL, 0, NULL, NULL, '2020-08-03 22:01:33', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission_element` VALUES (2, 1, 'icons', '/icon/index', 'icons/index', NULL, NULL, 1, NULL, '0', NULL, NULL, 'icon', 1, 1, NULL, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission_element` VALUES (8, NULL, '系统监控', '/monitor', 'Layout', NULL, NULL, 0, NULL, NULL, 6.00, 0, 'dashboard', 1, 0, NULL, 0, NULL, NULL, '2018-12-25 20:34:38', 'admin', '2019-03-31 22:19:58', 0, 0, NULL, NULL);
INSERT INTO `sys_permission_element` VALUES (13, 92, '职务管理', '/isystem/position', 'system/SysPositionList', NULL, NULL, 1, NULL, '1', 2.00, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2019-09-19 10:14:13', 'admin', '2019-09-19 10:15:22', 0, 0, '1', 0);
INSERT INTO `sys_permission_element` VALUES (28, 92, '角色管理', '/isystem/roleUserList', 'permission/role', NULL, NULL, 1, NULL, NULL, 1.20, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2019-04-17 15:13:56', 'admin', '2019-12-25 09:36:31', 0, 0, NULL, 0);
INSERT INTO `sys_permission_element` VALUES (30, 108, '搜索列表（应用）', '/list/search/application', 'list/TableList', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-02-12 14:02:51', 'admin', '2019-02-12 14:14:01', 0, 0, NULL, NULL);
INSERT INTO `sys_permission_element` VALUES (39, 92, '用户管理', '/isystem/user', 'system/UserList', NULL, NULL, 1, NULL, NULL, 1.10, 0, NULL, 1, 0, 0, 0, NULL, NULL, '2018-12-25 20:34:38', 'admin', '2019-12-25 09:36:24', 0, 0, NULL, 0);
INSERT INTO `sys_permission_element` VALUES (51, 92, '菜单管理', '/isystem/permission', 'system/PermissionList', NULL, NULL, 1, NULL, NULL, 1.30, 0, NULL, 1, 1, 0, 0, NULL, NULL, '2018-12-25 20:34:38', 'admin', '2019-12-25 09:36:39', 0, 0, NULL, 0);
INSERT INTO `sys_permission_element` VALUES (52, 8, '日志管理', '/monitor/log', 'system/LogList', NULL, NULL, 1, NULL, NULL, 1.00, 0, '', 1, 1, NULL, 0, NULL, NULL, '2018-12-26 10:11:18', 'admin', '2019-04-02 11:38:17', 0, 0, NULL, NULL);
INSERT INTO `sys_permission_element` VALUES (58, 87, '401', '/error/401', 'error-page/401', NULL, NULL, 1, NULL, NULL, 1.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, '2018-12-25 20:34:38', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission_element` VALUES (64, 39, '添加用户按钮', '', NULL, NULL, NULL, 2, 'user:add', '1', 1.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-03-16 11:20:33', 'admin', '2019-05-17 18:31:25', 0, 0, '1', NULL);
INSERT INTO `sys_permission_element` VALUES (81, 8, 'SQL监控', 'http://localhost:8080/dev-api/druid/', 'system/IframePageView', NULL, NULL, 1, NULL, NULL, 1.00, 0, NULL, 1, 1, NULL, 0, NULL, 'admin', '2019-01-30 09:43:22', 'admin', '2019-03-23 19:00:46', 0, 0, NULL, 0);
INSERT INTO `sys_permission_element` VALUES (82, 8, '定时任务', '/monitor/QuartzJobList', 'system/QuartzJobList', NULL, NULL, 1, NULL, NULL, 3.00, 0, NULL, 1, 1, NULL, 0, NULL, NULL, '2019-01-03 09:38:52', 'admin', '2019-04-02 10:24:13', 0, 0, NULL, NULL);
INSERT INTO `sys_permission_element` VALUES (87, NULL, 'errorPages', '/error', 'Layout', NULL, NULL, 0, NULL, NULL, 8.00, NULL, '404', 1, 0, NULL, NULL, NULL, NULL, '2018-12-25 20:34:38', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission_element` VALUES (91, 87, '404', '/error/404', 'error-page/404', NULL, NULL, 1, NULL, NULL, 2.00, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, '2018-12-25 20:34:38', NULL, NULL, 0, 0, NULL, NULL);
INSERT INTO `sys_permission_element` VALUES (92, NULL, '系统管理', '/isystem', 'Layout', NULL, NULL, 0, NULL, NULL, 4.00, 0, 'dashboard', 1, 0, NULL, 0, NULL, NULL, '2018-12-25 20:34:38', 'admin', '2019-03-31 22:19:52', 0, 0, NULL, NULL);
INSERT INTO `sys_permission_element` VALUES (101, 92, '分类字典', '/isys/category', 'system/SysCategoryList', NULL, NULL, 1, NULL, '1', 5.20, 0, NULL, 1, 1, 0, 0, NULL, 'admin', '2019-05-29 18:48:07', 'admin', '2020-02-23 22:45:33', 0, 0, '1', 0);
INSERT INTO `sys_permission_element` VALUES (104, 92, '数据字典', '/isystem/dict', 'system/DictList', NULL, NULL, 1, NULL, NULL, 5.00, 0, NULL, 1, 1, 0, 0, NULL, NULL, '2018-12-28 13:54:43', 'admin', '2020-02-23 22:45:25', 0, 0, NULL, 0);

-- ----------------------------
-- Table structure for sys_position
-- ----------------------------
DROP TABLE IF EXISTS `sys_position`;
CREATE TABLE `sys_position`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职务编码',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职务名称',
  `post_rank` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职级',
  `company_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公司id',
  `create_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `sys_org_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组织机构编码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_position
-- ----------------------------
INSERT INTO `sys_position` VALUES (2, '总经理', 'laozong', '5', NULL, 'admin', '2020-05-02 15:28:00', 'admin', '2020-05-02 15:28:03', '北京国炬公司');

-- ----------------------------
-- Table structure for sys_quartz_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_quartz_job`;
CREATE TABLE `sys_quartz_job`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `del_flag` int(1) NULL DEFAULT NULL COMMENT '删除状态',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `job_class_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务类名',
  `cron_expression` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'cron表达式',
  `parameter` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `status` int(1) NULL DEFAULT NULL COMMENT '状态 0正常 -1停止',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_job_class_name`(`job_class_name`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_quartz_job
-- ----------------------------
INSERT INTO `sys_quartz_job` VALUES (1, 'admin', '2020-08-03 22:54:06', 0, 'admin', '2020-08-06 17:07:02', 'org.z.modules.quartz.job.SampleJob', '0/2 * * * * ?', 'test', '带参测试 后台将每隔1秒执行输出日志', -1);
INSERT INTO `sys_quartz_job` VALUES (2, 'admin', '2019-03-30 12:44:48', 0, 'admin', '2020-07-02 11:52:55', 'org.z.modules.quartz.job.SampleParamJob', '0/1 * * * * ?', NULL, NULL, -1);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  `role_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色编码',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_sys_role_role_code`(`role_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '管理员', 'admin', '管理员', NULL, '2018-12-21 18:03:39', 'admin', '2019-05-20 11:40:26');
INSERT INTO `sys_role` VALUES (2, '临时角色', 'test', '这是临时角色', NULL, '2018-12-20 10:59:04', 'admin', '2020-08-15 14:09:18');
INSERT INTO `sys_role` VALUES (3, '第三方登录角色', 'third_role', '第三方登录角色', 'admin', '2019-09-05 14:57:49', 'admin', '2020-05-02 18:20:58');

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NULL DEFAULT NULL,
  `permission_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 86 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO `sys_role_permission` VALUES (1, 1, 1);
INSERT INTO `sys_role_permission` VALUES (2, 1, 2);
INSERT INTO `sys_role_permission` VALUES (3, 1, 3);
INSERT INTO `sys_role_permission` VALUES (4, 1, 4);
INSERT INTO `sys_role_permission` VALUES (6, 1, 6);
INSERT INTO `sys_role_permission` VALUES (7, 1, 7);
INSERT INTO `sys_role_permission` VALUES (8, 1, 8);
INSERT INTO `sys_role_permission` VALUES (9, 1, 9);
INSERT INTO `sys_role_permission` VALUES (10, 1, 10);
INSERT INTO `sys_role_permission` VALUES (11, 1, 11);
INSERT INTO `sys_role_permission` VALUES (12, 1, 12);
INSERT INTO `sys_role_permission` VALUES (13, 1, 13);
INSERT INTO `sys_role_permission` VALUES (14, 1, 14);
INSERT INTO `sys_role_permission` VALUES (15, 1, 15);
INSERT INTO `sys_role_permission` VALUES (16, 1, 16);
INSERT INTO `sys_role_permission` VALUES (19, 1, 19);
INSERT INTO `sys_role_permission` VALUES (20, 1, 20);
INSERT INTO `sys_role_permission` VALUES (21, 1, 21);
INSERT INTO `sys_role_permission` VALUES (22, 1, 22);
INSERT INTO `sys_role_permission` VALUES (23, 1, 23);
INSERT INTO `sys_role_permission` VALUES (24, 1, 24);
INSERT INTO `sys_role_permission` VALUES (25, 1, 25);
INSERT INTO `sys_role_permission` VALUES (26, 1, 26);
INSERT INTO `sys_role_permission` VALUES (28, 1, 32);
INSERT INTO `sys_role_permission` VALUES (29, 1, 5);
INSERT INTO `sys_role_permission` VALUES (30, 1, 31);
INSERT INTO `sys_role_permission` VALUES (31, 1, 30);
INSERT INTO `sys_role_permission` VALUES (32, 3, 2);
INSERT INTO `sys_role_permission` VALUES (33, 3, 3);
INSERT INTO `sys_role_permission` VALUES (34, 3, 5);
INSERT INTO `sys_role_permission` VALUES (35, 3, 1);
INSERT INTO `sys_role_permission` VALUES (36, 3, 21);
INSERT INTO `sys_role_permission` VALUES (37, 3, 22);
INSERT INTO `sys_role_permission` VALUES (38, 3, 25);
INSERT INTO `sys_role_permission` VALUES (39, 3, 31);
INSERT INTO `sys_role_permission` VALUES (40, 3, 32);
INSERT INTO `sys_role_permission` VALUES (41, 3, 9);
INSERT INTO `sys_role_permission` VALUES (42, 3, 8);
INSERT INTO `sys_role_permission` VALUES (43, 3, 10);
INSERT INTO `sys_role_permission` VALUES (44, 3, 6);
INSERT INTO `sys_role_permission` VALUES (45, 3, 7);
INSERT INTO `sys_role_permission` VALUES (46, 3, 24);
INSERT INTO `sys_role_permission` VALUES (47, 3, 13);
INSERT INTO `sys_role_permission` VALUES (48, 3, 14);
INSERT INTO `sys_role_permission` VALUES (49, 3, 15);
INSERT INTO `sys_role_permission` VALUES (50, 3, 16);
INSERT INTO `sys_role_permission` VALUES (51, 3, 19);
INSERT INTO `sys_role_permission` VALUES (52, 3, 20);
INSERT INTO `sys_role_permission` VALUES (53, 3, 23);
INSERT INTO `sys_role_permission` VALUES (54, 3, 4);
INSERT INTO `sys_role_permission` VALUES (55, 3, 12);
INSERT INTO `sys_role_permission` VALUES (56, 3, 30);
INSERT INTO `sys_role_permission` VALUES (57, 1, 34);
INSERT INTO `sys_role_permission` VALUES (58, 2, 2);
INSERT INTO `sys_role_permission` VALUES (59, 2, 3);
INSERT INTO `sys_role_permission` VALUES (60, 2, 5);
INSERT INTO `sys_role_permission` VALUES (61, 2, 1);
INSERT INTO `sys_role_permission` VALUES (62, 2, 21);
INSERT INTO `sys_role_permission` VALUES (63, 2, 22);
INSERT INTO `sys_role_permission` VALUES (64, 2, 25);
INSERT INTO `sys_role_permission` VALUES (65, 2, 31);
INSERT INTO `sys_role_permission` VALUES (66, 2, 32);
INSERT INTO `sys_role_permission` VALUES (67, 2, 9);
INSERT INTO `sys_role_permission` VALUES (68, 2, 8);
INSERT INTO `sys_role_permission` VALUES (69, 2, 10);
INSERT INTO `sys_role_permission` VALUES (70, 2, 6);
INSERT INTO `sys_role_permission` VALUES (71, 2, 7);
INSERT INTO `sys_role_permission` VALUES (72, 2, 24);
INSERT INTO `sys_role_permission` VALUES (73, 2, 13);
INSERT INTO `sys_role_permission` VALUES (74, 2, 14);
INSERT INTO `sys_role_permission` VALUES (75, 2, 15);
INSERT INTO `sys_role_permission` VALUES (76, 2, 16);
INSERT INTO `sys_role_permission` VALUES (77, 2, 19);
INSERT INTO `sys_role_permission` VALUES (78, 2, 20);
INSERT INTO `sys_role_permission` VALUES (79, 2, 23);
INSERT INTO `sys_role_permission` VALUES (80, 2, 4);
INSERT INTO `sys_role_permission` VALUES (81, 2, 12);
INSERT INTO `sys_role_permission` VALUES (82, 2, 30);
INSERT INTO `sys_role_permission` VALUES (83, 2, 26);
INSERT INTO `sys_role_permission` VALUES (84, 2, 34);
INSERT INTO `sys_role_permission` VALUES (85, 1, 35);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录账号',
  `realname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `salt` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'md5密码盐',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `birthday` datetime(0) NULL DEFAULT NULL COMMENT '生日',
  `sex` tinyint(1) NULL DEFAULT NULL COMMENT '性别(0-默认未知,1-男,2-女)',
  `email` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电子邮件',
  `phone` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `org_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '机构编码',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '状态(1-正常,2-冻结)',
  `del_flag` tinyint(1) NULL DEFAULT NULL COMMENT '删除状态(0-正常,1-已删除)',
  `third_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '第三方登录的唯一标识',
  `third_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '第三方类型',
  `work_no` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工号，唯一键',
  `post` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职务，关联职务表',
  `telephone` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '座机号',
  `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `introduction` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '简单介绍',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `index_user_name`(`username`) USING BTREE,
  UNIQUE INDEX `uniq_sys_user_work_no`(`work_no`) USING BTREE,
  UNIQUE INDEX `uniq_sys_user_username`(`username`) USING BTREE,
  UNIQUE INDEX `uniq_sys_user_phone`(`phone`) USING BTREE,
  UNIQUE INDEX `uniq_sys_user_email`(`email`) USING BTREE,
  INDEX `index_user_status`(`status`) USING BTREE,
  INDEX `index_user_del_flag`(`del_flag`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '管理员', '2dd977cc690324c7', 'RCGTeGiH', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif?imageView2/1/w/80/h/80', '2018-12-05 00:00:00', 1, 'jeecg@163.com', '18611111111', 'A01', 1, 0, NULL, NULL, '00001', '总经理', NULL, NULL, '2038-06-21 17:54:10', 'admin', '2020-08-16 14:29:44', 'c6d7cb4deeac411cb3384b1b31278596');
INSERT INTO `sys_user` VALUES (2, 'test', 'test', 'b613725e542c0489', 'k0Q1Gl6z', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif?imageView2/1/w/80/h/80', '2017-08-03 00:00:00', 1, 'test@163.com', '18889633695', 'A02A01', 1, 0, NULL, NULL, '00002', 'devleader', '010-96633256', 'admin', '2019-02-13 16:02:36', 'admin', '2020-08-15 14:04:37', '');
INSERT INTO `sys_user` VALUES (5, 'test1', 'test1', '111', 'DAkjQSwK', '1111', '2000-08-16 22:45:29', 1, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, NULL, 'admin', '2020-08-15 13:44:41', 'test', '2020-08-16 22:44:58', NULL);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `role_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (2, 1, 1);
INSERT INTO `sys_user_role` VALUES (6, NULL, 3);
INSERT INTO `sys_user_role` VALUES (7, NULL, 3);
INSERT INTO `sys_user_role` VALUES (8, NULL, 3);
INSERT INTO `sys_user_role` VALUES (9, 5, 2);
INSERT INTO `sys_user_role` VALUES (10, 2, 2);

SET FOREIGN_KEY_CHECKS = 1;
