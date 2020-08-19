package org.z.modules.system.model;

import lombok.Data;

import java.io.Serializable;

/**
 * 树形下拉框
 *
 * @author z
 */
@Data
public class TreeSelectModel implements Serializable {

    private static final long serialVersionUID = 9016390975325574747L;

    private String key;

    private String title;

    private boolean isLeaf;

    private String icon;

    private String parentId;

    private String value;

    private String code;

}
