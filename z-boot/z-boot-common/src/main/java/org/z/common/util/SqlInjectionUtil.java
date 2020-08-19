package org.z.common.util;

import lombok.extern.slf4j.Slf4j;

/**
 * sql注入处理工具类
 *
 * @author z
 */
@Slf4j
public class SqlInjectionUtil {
    /**
     * sign 用于表字典加签的盐值【SQL漏洞】
     * （上线修改值 20200501，同步修改前端的盐值）
     */
    private final static String XSS_STR = "'|and |exec |insert |select |delete |update |drop |count |chr |mid |master |truncate |char |declare |;|or |+|,";


    /**
     * sql注入过滤处理，遇到注入关键字抛异常
     *
     * @param value
     * @return
     */
    public static void filterContent(String value) {
        filterContent(new String[]{value});
    }

    /**
     * sql注入过滤处理，遇到注入关键字抛异常
     *
     * @param values
     * @return
     */
    public static void filterContent(String[] values) {
        String[] xssArr = XSS_STR.split("\\|");
        for (String value : values) {
            if (value == null || "".equals(value)) {
                continue;
            }
            // 统一转为小写
            value = value.toLowerCase();
            for (String arr: xssArr) {
                if (value.contains(arr)) {
                    log.error("请注意，值可能存在SQL注入风险!---> {}", value);
                    throw new RuntimeException("请注意，值可能存在SQL注入风险!--->" + value);
                }
            }
        }
    }


}
