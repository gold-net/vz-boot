package org.z.modules.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.z.modules.system.entity.SysRolePermission;

/**
 * <p>
 * 角色权限表 服务类
 * </p>
 *
 * @author z
 */
public interface ISysRolePermissionService extends IService<SysRolePermission> {

	/**
	 * 保存授权/先删后增
	 * @param roleId
	 * @param permissionIds
	 */
	public void saveRolePermission(Integer roleId, String permissionIds);

	/**
	 * 保存授权 将上次的权限和这次作比较 差异处理提高效率
	 * @param roleId
	 * @param permissionIds
	 * @param lastPermissionIds
	 */
	public void saveRolePermission(Integer roleId, String permissionIds, String lastPermissionIds);

}
