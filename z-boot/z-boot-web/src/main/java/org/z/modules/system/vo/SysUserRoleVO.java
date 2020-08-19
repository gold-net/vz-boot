package org.z.modules.system.vo;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

@Data
public class SysUserRoleVO implements Serializable{
	private static final long serialVersionUID = 1L;

	/**部门id*/
	private Integer roleId;
	/**对应的用户id集合*/
	private List<Integer> userIdList;

	public SysUserRoleVO() {
		super();
	}

	public SysUserRoleVO(Integer roleId, List<Integer> userIdList) {
		super();
		this.roleId = roleId;
		this.userIdList = userIdList;
	}

}
