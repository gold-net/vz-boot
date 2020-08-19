package org.z.common.constant;

import javax.servlet.http.HttpServletResponse;

/**
 * @author z
 */
public interface CommonConstant {

	/**
	 * 正常状态
	 */
	Integer STATUS_NORMAL = 0;

	/**
	 * 禁用状态
	 */
	Integer STATUS_DISABLE = -1;

	/**
	 * 删除标志
	 */
	Integer DEL_FLAG_1 = 1;

	/**
	 * 未删除
	 */
	Integer DEL_FLAG_0 = 0;

	/**
	 * 系统日志类型： 登录
	 */
	int LOG_TYPE_1 = 1;

	/**
	 * 系统日志类型： 操作
	 */
	int LOG_TYPE_2 = 2;

    /**
     * 系统日志类型： 定时
     */
	int LOG_TYPE_3 = 3;

	/**
	 * 操作日志类型： 查询
	 */
    int OPERATE_TYPE_1 = 1;

	/**
	 * 操作日志类型： 添加
	 */
    int OPERATE_TYPE_2 = 2;

	/**
	 * 操作日志类型： 更新
	 */
    int OPERATE_TYPE_3 = 3;

	/**
	 * 操作日志类型： 删除
	 */
    int OPERATE_TYPE_4 = 4;

	/**
	 * 操作日志类型： 导入
	 */
    int OPERATE_TYPE_5 = 5;

	/**
	 * 操作日志类型： 导出
	 */
    int OPERATE_TYPE_6 = 6;


	/** {@code 500 Server Error} (HTTP/1.0 - RFC 1945) */
    Integer SC_INTERNAL_SERVER_ERROR_500 = HttpServletResponse.SC_INTERNAL_SERVER_ERROR;
    /** {@code 200 OK} (HTTP/1.0 - RFC 1945) */
    Integer SC_OK_200 = 200;

    /**访问权限认证未通过 401*/
    Integer SC_UNAUTHORIZED = HttpServletResponse.SC_UNAUTHORIZED;

    /** 登录用户Shiro权限缓存KEY前缀 */
    public static String PREFIX_USER_SHIRO_CACHE  = "shiro:cache:org.z.modules.shiro.authc.ShiroRealm.authorizationCache:";
    /** 登录用户Token令牌缓存KEY前缀 */
    String PREFIX_USER_TOKEN  = "prefix_user_token_";
    /** Token缓存时间：3600秒即一小时 */
    int  TOKEN_EXPIRE_TIME  = 3600 * 1000;

    /**
     *  0：一级菜单
     */
    Integer MENU_TYPE_0  = 0;
   /**
    *  1：子菜单
    */
    Integer MENU_TYPE_1  = 1;
    /**
     *  2：按钮权限
     */
    Integer MENU_TYPE_2  = 2;

    /**优先级（L低，M中，H高）*/
    String PRIORITY_L  = "L";
    String PRIORITY_M  = "M";
    String PRIORITY_H  = "H";

    /**
     * 短信模板方式  0 .登录模板、1.注册模板、2.忘记密码模板
     */
    String SMS_TPL_TYPE_0  = "0";
    String SMS_TPL_TYPE_1  = "1";
    String SMS_TPL_TYPE_2  = "2";

    /**
     * 状态(0无效1有效)
     */
    String STATUS_0 = "0";
    String STATUS_1 = "1";

    /**
     * 是否配置菜单的数据权限 1是0否
     */
    Integer RULE_FLAG_0 = 0;
    Integer RULE_FLAG_1 = 1;

    /**
     * 是否用户已被冻结 1正常(解冻) 2冻结
     */
    Integer USER_UNFREEZE = 1;
    Integer USER_FREEZE = 2;

    /**字典翻译文本后缀*/
    String DICT_TEXT_SUFFIX = "_dictText";

    String X_ACCESS_TOKEN = "X-Access-Token";

}
