package org.z.modules.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.z.modules.system.entity.SysPermission;
import org.z.modules.system.model.TreeModel;

import java.util.List;

/**
 * <p>
 * 菜单权限表 服务类
 * </p>
 *
 * @author z
 */
public interface ISysPermissionService extends IService<SysPermission> {

    List<TreeModel> queryListByParentId(String parentId);

    /**
     * 真实删除
     */
    void deletePermission(String id);

    /**
     * 逻辑删除
     */
    void deletePermissionLogical(String id);

    void addPermission(SysPermission sysPermission);

    void editPermission(SysPermission sysPermission);

    List<SysPermission> queryByUser(String username);

    /**
     * 查询出带有特殊符号的菜单地址的集合
     *
     * @return
     */
    List<String> queryPermissionUrlWithStar();

    /**
     * 判断用户否拥有权限
     *
     * @param username
     * @param sysPermission
     * @return
     */
    boolean hasPermission(String username, SysPermission sysPermission);

    /**
     * 根据用户和请求地址判断是否有此权限
     *
     * @param username
     * @param url
     * @return
     */
    boolean hasPermission(String username, String url);
}
