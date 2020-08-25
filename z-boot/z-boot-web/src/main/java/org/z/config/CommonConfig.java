package org.z.config;

import org.springframework.boot.actuate.trace.http.HttpTraceRepository;
import org.springframework.boot.actuate.trace.http.InMemoryHttpTraceRepository;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.data.redis.cache.RedisCacheConfiguration;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.cache.RedisCacheWriter;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.z.component.cache.MemoryZCache;
import org.z.component.cache.RedisZCache;
import org.z.component.cache.ZCache;
import org.z.component.spring.SpringContextHolder;

import java.time.Duration;

/**
 * @author zhangshuw
 * <p>     2020/7/27
 */
@Configuration
@EnableCaching
public class CommonConfig {

    //@Bean
    public ZCache localCache() {
        return new MemoryZCache();
    }

    @Bean
    public SpringContextHolder springContextHolder() {
        return new SpringContextHolder();
    }

    @Bean
    public HttpTraceRepository httpTraceRepository() {
        return new InMemoryHttpTraceRepository();
    }

    /**
     * 缓存配置管理器
     *
     * @param factory RedisConnectionFactory
     * @return CacheManager
     */
    @Bean
    @Primary
    public CacheManager cacheManager(RedisConnectionFactory factory) {
        return new RedisCacheManager(RedisCacheWriter.nonLockingRedisCacheWriter(factory),
                RedisCacheConfiguration.defaultCacheConfig().entryTtl(Duration.ofDays(RedisZCache.EXPIRE_AFTER_ACCESS_DAYS)));
    }

    @Bean
    @Primary
    public ZCache zCache(RedisConnectionFactory factory) {
        return new RedisZCache(factory);
    }
}
