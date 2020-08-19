package org.z.modules.system.model;

import lombok.Data;
import org.z.modules.system.entity.SysPermission;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author z
 */
@Data
public class SysPermissionTree implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * id
     */
    private Integer id;

    private Integer key;
    private String title;

    /**
     * 父id
     */
    private Integer parentId;

    /**
     * 菜单名称
     */
    private String name;

    /**
     * 菜单权限编码
     */
    private String perms;
    /**
     * 权限策略1显示2禁用
     */
    private String permsType;

    /**
     * 菜单图标
     */
    private String icon;

    /**
     * 组件
     */
    private String component;

    /**
     * 跳转网页链接
     */
    private String url;

    /**
     * 一级菜单跳转地址
     */
    private String redirect;

    /**
     * 菜单排序
     */
    private Double sortNo;

    /**
     * 类型（0：一级菜单；1：子菜单 ；2：按钮权限）
     */
    private Integer menuType;

    /**
     * 是否叶子节点: 1:是 0:不是
     */
    private Boolean isLeaf = Boolean.FALSE;

    /**
     * 是否有孩子节点
     */
    private Boolean hasChildren = Boolean.TRUE;

    /**
     * 是否路由菜单: 0:不是  1:是（默认值1）
     */
    private boolean route;


    /**
     * 是否路缓存页面: 0:不是  1:是（默认值1）
     */
    private boolean keepAlive;


    /**
     * 描述
     */
    private String description;

    /**
     * 删除状态 0正常 1已删除
     */
    private Integer delFlag;

    /**
     * 创建人
     */
    private String createBy;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 更新人
     */
    private String updateBy;

    /**
     * 更新时间
     */
    private Date updateTime;

    /**
     * alwaysShow
     */
    private boolean alwaysShow;
    /**
     * 是否隐藏路由菜单: 0否,1是（默认值0）
     */
    private boolean hidden;

    /**
     * 按钮权限状态(0无效1有效)
     */
    private String status;

    /**
     * 外链菜单打开方式 0/内部打开 1/外部打开
     */
    private boolean external;

    private List<SysPermissionTree> children;

    public SysPermissionTree(SysPermission permission) {
        this.key = permission.getId();
        this.id = permission.getId();
        this.perms = permission.getPerms();
        this.permsType = permission.getPermsType();
        this.component = permission.getComponent();
        this.createBy = permission.getCreateBy();
        this.createTime = permission.getCreateTime();
        this.delFlag = permission.getDelFlag();
        this.description = permission.getDescription();
        this.icon = permission.getIcon();
        this.isLeaf = permission.isLeaf();
        this.hasChildren = !this.isLeaf;
        this.menuType = permission.getMenuType();
        this.name = permission.getName();
        this.parentId = permission.getParentId();
        this.sortNo = permission.getSortNo();
        this.updateBy = permission.getUpdateBy();
        this.updateTime = permission.getUpdateTime();
        this.redirect = permission.getRedirect();
        this.url = permission.getUrl();
        this.hidden = permission.isHidden();
        this.route = permission.isRoute();
        this.keepAlive = permission.isKeepAlive();
        this.alwaysShow = permission.isAlwaysShow();
        this.external = permission.isExternal();
        this.title = permission.getTitle();
        if (!permission.isLeaf()) {
            this.children = new ArrayList<>();
        }
        this.status = permission.getStatus();
    }

}
