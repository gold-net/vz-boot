package org.z.modules.system.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import org.z.common.system.vo.Result;
import org.z.modules.system.entity.SysUser;

import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * <p>
 * 用户表 服务类
 * </p>
 *
 * @author z
 */
public interface ISysUserService extends IService<SysUser> {

    /**
     * 重置密码
     *
     * @param username
     * @param oldpassword
     * @param newpassword
     * @param confirmpassword
     * @return
     */
    Result<?> resetPassword(String username, String oldpassword, String newpassword, String confirmpassword);

    /**
     * 修改密码
     *
     * @param sysUser
     * @return
     */
    Result<?> changePassword(SysUser sysUser);

    /**
     * 删除用户
     *
     * @param userId
     * @return
     */
    boolean deleteUser(String userId);

    /**
     * 批量删除用户
     *
     * @param userIds
     * @return
     */
    boolean deleteBatchUsers(String userIds);

    /**
     * 用户名获取
     *
     * @param username
     * @return
     */
    SysUser getUserByName(String username);

    /**
     * 添加用户和用户角色关系
     *
     * @param user
     */
    void addUserWithRole(SysUser user);


    /**
     * 修改用户和用户角色关系
     *
     * @param user
     */
    void editUserWithRole(SysUser user);

    /**
     * 获取用户的授权角色
     *
     * @param username
     * @return
     */
    List<String> getRole(String username);

    /**
     * 根据角色Id查询
     *
     * @param page
     * @param roleId
     * @param username
     * @return
     */
    IPage<SysUser> getUserByRoleId(Page<SysUser> page, String roleId, String username);

    /**
     * 通过用户名获取用户角色集合
     *
     * @param username 用户名
     * @return 角色集合
     */
    Set<String> getUserRolesSet(String username);

    /**
     * 通过用户名获取用户权限集合
     *
     * @param username 用户名
     * @return 权限集合
     */
    Set<String> getUserPermissionsSet(String username);

    /**
     * 根据手机号获取用户名和密码
     */
    SysUser getUserByPhone(String phone);


    /**
     * 根据邮箱获取用户
     */
    SysUser getUserByEmail(String email);

    /**
     * 校验用户是否有效
     *
     * @param sysUser
     * @return
     */
    Result<Map<String, Object>> checkUserIsEffective(SysUser sysUser);

    /**
     * 查询被逻辑删除的用户
     */
    List<SysUser> queryLogicDeleted();

    /**
     * 查询被逻辑删除的用户（可拼装查询条件）
     */
    List<SysUser> queryLogicDeleted(LambdaQueryWrapper<SysUser> wrapper);

    /**
     * 还原被逻辑删除的用户
     */
    boolean revertLogicDeleted(List<String> userIds, SysUser updateEntity);

    /**
     * 彻底删除被逻辑删除的用户
     */
    boolean removeLogicDeleted(List<String> userIds);

    /**
     * 保存第三方用户信息
     *
     * @param sysUser
     */
    void saveThirdUser(SysUser sysUser);

}
