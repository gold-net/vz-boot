package org.z.config;

import org.springframework.boot.actuate.trace.http.HttpTraceRepository;
import org.springframework.boot.actuate.trace.http.InMemoryHttpTraceRepository;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.z.component.cache.MemoryZCacheManager;
import org.z.component.cache.ZCacheManager;
import org.z.component.spring.SpringContextHolder;

/**
 * @author zhangshuw
 * <p>     2020/7/27
 */
@Configuration
@EnableCaching
public class CommonConfig {

    @Bean
    public ZCacheManager cacheManager() {
        return new MemoryZCacheManager();
    }

    @Bean
    public SpringContextHolder springContextHolder() {
        return new SpringContextHolder();
    }

    @Bean
    //@Profile({"dev", "test"})
    public HttpTraceRepository httpTraceRepository() {
        return new InMemoryHttpTraceRepository();
    }


}
