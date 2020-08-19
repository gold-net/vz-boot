package org.z.modules.system.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.z.modules.system.entity.SysRole;
import org.z.modules.system.mapper.SysRoleMapper;
import org.z.modules.system.mapper.SysUserMapper;
import org.z.modules.system.service.ISysRoleService;

import java.util.Arrays;

/**
 * @author z
 */
@Service
public class SysRoleServiceImpl extends ServiceImpl<SysRoleMapper, SysRole> implements ISysRoleService {
    @Autowired
    SysRoleMapper sysRoleMapper;
    @Autowired
    SysUserMapper sysUserMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteRole(String roleId) {
        //1.删除角色和用户关系
        sysRoleMapper.deleteRoleUserRelation(roleId);
        //2.删除角色和权限关系
        sysRoleMapper.deleteRolePermissionRelation(roleId);
        //3.删除角色
        this.removeById(roleId);
        return true;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteBatchRole(String[] roleIds) {
        //1.删除角色和用户关系
        sysUserMapper.deleteBathRoleUserRelation(roleIds);
        //2.删除角色和权限关系
        sysUserMapper.deleteBathRolePermissionRelation(roleIds);
        //3.删除角色
        this.removeByIds(Arrays.asList(roleIds));
        return true;
    }
}
