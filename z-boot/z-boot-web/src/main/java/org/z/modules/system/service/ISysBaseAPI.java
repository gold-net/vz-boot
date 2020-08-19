package org.z.modules.system.service;

import org.z.common.system.vo.ComboModel;
import org.z.common.system.vo.DictModel;
import org.z.common.system.vo.LoginUser;
import org.z.modules.system.entity.SysUser;

import java.util.List;

/**
 * @author z
 */
public interface ISysBaseAPI {

    /**
     * 日志添加
     *
     * @param logContent  内容
     * @param logType     日志类型(0:操作日志;1:登录日志;2:定时任务)
     * @param operateType 操作类型(1:添加;2:修改;3:删除;)
     * @param user 登录用户
     */
    void addLog(String logContent, Integer logType, Integer operateType, SysUser user);

    /**
     * 根据用户账号查询用户信息
     *
     * @param username
     * @return
     */
    LoginUser getUserByName(String username);

    /**
     * 根据用户id查询用户信息
     *
     * @param id
     * @return
     */
    LoginUser getUserById(String id);

    /**
     * 通过用户账号查询角色集合
     *
     * @param username
     * @return
     */
    List<String> getRolesByUsername(String username);

    /**
     * 获取数据字典
     *
     * @param code
     * @return
     */
    List<DictModel> queryDictItemsByCode(String code);

    /**
     * 查询所有的父级字典，按照create_time排序
     */
    List<DictModel> queryAllDict();

    /**
     * 获取所有有效用户
     *
     * @return
     */
    List<ComboModel> queryAllUser();


    /**
     * 获取所有角色
     *
     * @return
     */
    List<ComboModel> queryAllRole();

    /**
     * 获取所有角色 带参
     * roleIds 默认选中角色
     *
     * @return
     */
    List<ComboModel> queryAllRole(String[] roleIds);

    /**
     * 通过用户账号查询角色Id集合
     *
     * @param username
     * @return
     */
    List<String> getRoleIdsByUsername(String username);

    /**
     * 根据部门Id获取部门负责人
     *
     * @param deptId
     * @return
     */
    List<String> getDeptHeadByDepId(String deptId);

    /**
     * 根据id获取所有参与用户
     * userIds
     *
     * @return
     */
    List<LoginUser> queryAllUserByIds(String[] userIds);

    /**
     * 根据name获取所有参与用户
     * userNames
     *
     * @return
     */
    List<LoginUser> queryUserByNames(String[] userNames);
}
