package org.z.common.constant;

/**
 * @author z
 */
public interface CacheConstant {

    /**
     * 字典信息缓存
     */
    String SYS_DICT_CACHE = "sys:cache:dict";

    /**
     * 数据权限配置缓存
     */
    String SYS_DATA_PERMISSIONS_CACHE = "sys:cache:permission:datarules";

    /**
     * 缓存用户信息
     */
    String SYS_USERS_CACHE = "sys:cache:user";

    /**
     * 登录用户Shiro权限缓存KEY前缀
     */
    String PREFIX_USER_SHIRO_CACHE = "shiro:cache:org.z.modules.shiro.authc.ShiroRealm.authorizationCache:";

    /**
     * 登录用户Token令牌缓存KEY前缀
     */
    String PREFIX_USER_TOKEN = "prefix_user_token_";

}
