package org.z.common.util;

import org.apache.commons.lang3.time.FastDateFormat;

import java.beans.PropertyEditorSupport;
import java.util.Date;

/**
 * 类描述：时间操作定义类
 *
 * @author z
 */
public class DateUtil extends PropertyEditorSupport {

    private static final long DAY_IN_MILLIS = 24 * 3600 * 1000;
    private static final long HOUR_IN_MILLIS = 3600 * 1000;
    private static final long MINUTE_IN_MILLIS = 60 * 1000;
    private static final long SECOND_IN_MILLIS = 1000;
    public static FastDateFormat date_sdf = FastDateFormat.getInstance("yyyy-MM-dd");
    public static FastDateFormat yyyyMMdd = FastDateFormat.getInstance("yyyyMMdd");
    public static FastDateFormat date_sdf_wz = FastDateFormat.getInstance("yyyy年MM月dd日");
    public static FastDateFormat time_sdf = FastDateFormat.getInstance("yyyy-MM-dd HH:mm");
    public static FastDateFormat yyyymmddhhmmss = FastDateFormat.getInstance("yyyyMMddHHmmss");
    public static FastDateFormat short_time_sdf = FastDateFormat.getInstance("HH:mm");
    public static FastDateFormat datetimeFormat = FastDateFormat.getInstance("yyyy-MM-dd HH:mm:ss");

    /**
     * 当前时间，格式 yyyy-MM-dd HH:mm:ss
     *
     * @return 当前时间的标准形式字符串
     */
    public static String now() {
        return datetimeFormat.format(new Date());
    }
}