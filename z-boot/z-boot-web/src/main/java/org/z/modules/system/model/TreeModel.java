package org.z.modules.system.model;

import lombok.Data;
import org.z.modules.system.entity.SysPermission;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 树形列表用到
 *
 * @author z
 */
@Data
public class TreeModel implements Serializable {

    private static final long serialVersionUID = 4013193970046502756L;

    private Integer key;

    private String title;

    private Boolean isLeaf = Boolean.FALSE;

    private String icon;

    private List<TreeModel> children;
    private Integer parentId;
    private String label;
    private Integer value;

    public TreeModel() {

    }

    public TreeModel(SysPermission permission) {
        this.key = permission.getId();
        this.icon = permission.getIcon();
        this.parentId = permission.getParentId();
        this.title = permission.getTitle();
        this.value = permission.getId();
        this.isLeaf = permission.isLeaf();
        this.label = permission.getTitle();
        if (!permission.isLeaf()) {
            this.children = new ArrayList<>();
        }
    }

    public TreeModel(Integer key, Integer parentId, String title, boolean isLeaf) {
        this.key = key;
        this.parentId = parentId;
        this.title = title;
        this.isLeaf = isLeaf;
        this.value = key;
        if (!isLeaf) {
            this.children = new ArrayList<>();
        }
    }

}
