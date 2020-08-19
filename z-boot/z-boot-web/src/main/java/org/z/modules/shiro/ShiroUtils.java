package org.z.modules.shiro;

import org.apache.shiro.SecurityUtils;
import org.z.common.system.vo.LoginUser;

/**
 * @author z
 */
public class ShiroUtils {

    public static LoginUser getLoginUser() {
        return (LoginUser) SecurityUtils.getSubject().getPrincipal();
    }
}
