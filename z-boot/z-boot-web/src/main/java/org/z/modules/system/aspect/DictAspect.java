package org.z.modules.system.aspect;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.z.common.annotation.Dict;
import org.z.common.constant.CommonConstant;
import org.z.common.system.vo.Result;
import org.z.common.util.CommonUtil;
import org.z.common.util.JsonUtil;
import org.z.modules.system.service.ISysDictService;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @Description: 字典aop类
 * @Author: dangzhenghui
 * @Date: 2019-3-17 21:50
 * @Version: 1.0
 */
@Aspect
@Component
@Slf4j
public class DictAspect {
    @Autowired
    private ISysDictService dictService;

    // 定义切点Pointcut
    @Pointcut("execution(public * org.z.modules..*.*Controller.*(..))")
    public void excudeService() {
    }

    @Around("excudeService()")
    public Object doAround(ProceedingJoinPoint pjp) throws Throwable {
        long time1 = System.currentTimeMillis();
        Object result = pjp.proceed();
        long time2 = System.currentTimeMillis();
        log.debug("获取JSON数据 耗时：" + (time2 - time1) + "ms");
        long start = System.currentTimeMillis();
        this.parseDictText(result);
        long end = System.currentTimeMillis();
        log.debug("解析注入JSON数据  耗时" + (end - start) + "ms");
        return result;
    }

    /**
     * 本方法针对返回对象为Result 的IPage的分页列表数据进行动态字典注入
     * 字典注入实现 通过对实体类添加注解@dict 来标识需要的字典内容,字典分为单字典code即可 字典 code text配合使用
     *
     * @param result
     */
    @SneakyThrows
    private void parseDictText(Object result) {
        if (result instanceof Result) {
            if (((Result) result).getResult() instanceof IPage) {
                List<Map<String, Object>> items = new ArrayList<>();
                for (Object record : ((IPage) ((Result) result).getResult()).getRecords()) {
                    Map<String, Object> item;
                    try {
                        String json = JsonUtil.OBJECT_MAPPER.writeValueAsString(record);
                        item = JsonUtil.OBJECT_MAPPER.readValue(json, new TypeReference<Map<String, Object>>() {
                        });
                    } catch (JsonProcessingException e) {
                        log.error("json解析失败" + e.getMessage(), e);
                        continue;
                    }
                    for (Field field : CommonUtil.getAllFields(record)) {
                        if (field.getAnnotation(Dict.class) != null) {
                            String code = field.getAnnotation(Dict.class).dicCode();
                            String text = field.getAnnotation(Dict.class).dicText();
                            String key = String.valueOf(item.get(field.getName()));

                            //翻译字典值对应的txt
                            String textValue = translateDictValue(code, text, key);

                            if (log.isDebugEnabled()) {
                                log.debug(" __翻译字典字段__ " + field.getName() + CommonConstant.DICT_TEXT_SUFFIX + "： " + textValue);
                            }
                            item.put(field.getName() + CommonConstant.DICT_TEXT_SUFFIX, textValue);
                        }
                    }
                    items.add(item);
                }
                ((IPage) ((Result) result).getResult()).setRecords(items);
            }

        }
    }

    /**
     * 翻译字典文本
     *
     * @param code
     * @param text
     * @param key
     * @return
     */
    private String translateDictValue(String code, String text, String key) {
        if (StringUtils.isEmpty(key)) {
            return null;
        }
        StringBuilder textValue = new StringBuilder();
        String[] keys = key.split(",");
        for (String k : keys) {
            String tmpValue;
            log.debug(" 字典 key : " + k);
            if (k.trim().length() == 0) {
                continue;
            }
            tmpValue = dictService.queryDictTextByKey(code, k.trim());

            if (tmpValue != null) {
                if (!"".equals(textValue.toString())) {
                    textValue.append(",");
                }
                textValue.append(tmpValue);
            }

        }
        return textValue.toString();
    }

}
