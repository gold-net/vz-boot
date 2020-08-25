package org.z.modules.system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;
import org.z.modules.system.entity.SysUser;

import java.util.List;

/**
 * <p>
 * 用户表 Mapper 接口
 * </p>
 *
 * @author z
 */
public interface SysUserMapper extends BaseMapper<SysUser> {
    /**
     * 通过用户账号查询用户信息
     *
     * @param username
     * @return
     */
    SysUser getUserByName(@Param("username") String username);

    /**
     * 根据角色Id查询用户信息
     *
     * @param page
     * @param
     * @return
     */
    IPage<SysUser> getUserByRoleId(Page page, @Param("roleId") String roleId, @Param("username") String username);

    /**
     * 根据手机号查询用户信息
     *
     * @param phone
     * @return
     */
    SysUser getUserByPhone(@Param("phone") String phone);


    /**
     * 根据邮箱查询用户信息
     *
     * @param email
     * @return
     */
    SysUser getUserByEmail(@Param("email") String email);

    /**
     * @Author scott
     * @Date 2019/12/13 16:10
     * @Description: 批量删除角色与用户关系
     */
    void deleteBathRoleUserRelation(@Param("roleIdArray") String[] roleIdArray);

    /**
     * @Author scott
     * @Date 2019/12/13 16:10
     * @Description: 批量删除角色与权限关系
     */
    void deleteBathRolePermissionRelation(@Param("roleIdArray") String[] roleIdArray);

    /**
     * 查询被逻辑删除的用户
     */
    List<SysUser> selectLogicDeleted();

    /**
     * 还原被逻辑删除的用户
     */
    int revertLogicDeleted(@Param("userIds") String userIds, @Param("entity") SysUser entity);

    /**
     * 彻底删除被逻辑删除的用户
     */
    int deleteLogicDeleted(@Param("userIds") List<String> userIds);
}
