package org.z.common.annotation;

import java.lang.annotation.*;

/**
 * 数据权限注解
 *
 * @author z
 */
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.TYPE, ElementType.METHOD})
@Documented
public @interface PermissionData {

    String value() default "";

    /**
     * 配置菜单的组件路径,用于数据权限
     */
    String pageComponent() default "";
}