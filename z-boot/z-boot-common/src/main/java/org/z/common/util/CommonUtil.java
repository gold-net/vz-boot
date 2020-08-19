package org.z.common.util;

import java.lang.reflect.Field;
import java.util.*;

/**
 * @author z
 */
public class CommonUtil {

    /**
     * 获取类的所有属性，包括父类
     *
     * @param object
     * @return
     */
    public static Field[] getAllFields(Object object) {
        Class<?> clazz = object.getClass();
        List<Field> fieldList = new ArrayList<>();
        while (clazz != null) {
            fieldList.addAll(new ArrayList<>(Arrays.asList(clazz.getDeclaredFields())));
            clazz = clazz.getSuperclass();
        }
        Field[] fields = new Field[fieldList.size()];
        fieldList.toArray(fields);
        return fields;
    }

    /**
     * 将map的key全部转成小写
     *
     * @param list
     * @return
     */
    public static List<Map<String, Object>> toLowerCasePageList(List<Map<String, Object>> list) {
        List<Map<String, Object>> select = new ArrayList<>();
        for (Map<String, Object> row : list) {
            Map<String, Object> resultMap = new HashMap<>();
            Set<Map.Entry<String, Object>> keySet = row.entrySet();
            for (Map.Entry<String, Object> entry : keySet) {
                String newKey = entry.getKey().toLowerCase();
                resultMap.put(newKey, entry.getValue());
            }
            select.add(resultMap);
        }
        return select;
    }

}
