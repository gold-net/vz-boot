package org.z.common.util;

import org.apache.commons.lang3.StringUtils;

import java.util.Random;

/**
 * @author z
 */
public class RandomUtil {

    private static final String BASE_CHECK_CODES = "qwertyuiplkjhgfdsazxcvbnmQWERTYUPLKJHGFDSAZXCVBNM1234567890";

    public static String randomString(String baseString, int length) {
        if (StringUtils.isEmpty(baseString)) {
            return "";
        } else {
            StringBuilder sb = new StringBuilder(length);
            if (length < 1) {
                length = 1;
            }

            int baseLength = baseString.length();
            Random random = new Random();
            for (int i = 0; i < length; ++i) {
                int number = random.nextInt(baseLength);
                sb.append(baseString.charAt(number));
            }
            return sb.toString();
        }
    }

    /**
     * 随机数
     *
     * @param length 定义随机数的位数
     */
    public static String randomString(int length) {
        return randomString(BASE_CHECK_CODES, length);
    }

    public static String randomNumbers(int length) {
        return randomString("0123456789", length);
    }
}