package org.z.component.cache;


import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.cache.RedisCache;
import org.springframework.data.redis.cache.RedisCacheConfiguration;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.cache.RedisCacheWriter;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.util.ByteUtils;

import java.time.Duration;
import java.util.Objects;
import java.util.concurrent.TimeUnit;

/**
 * 默认最多缓存30天
 *
 * @author z
 */
@Slf4j
public class RedisZCache extends RedisCache implements ZCache {

    private static final String NAME = "Z_CACHE_NAME";

    public static final int EXPIRE_AFTER_ACCESS_DAYS = 30;

    private final RedisConnectionFactory factory;

    public RedisZCache(RedisConnectionFactory factory) {
        super(NAME, RedisCacheWriter.nonLockingRedisCacheWriter(factory), RedisCacheConfiguration.defaultCacheConfig()
                .entryTtl(Duration.ofDays(EXPIRE_AFTER_ACCESS_DAYS)));
        this.factory = factory;
    }

    @Override
    public void put(String key, Object value, long timeout) {
        RedisCacheWriter writer = getNativeCache();
        RedisCacheConfiguration config = getCacheConfiguration();
        if (config.usePrefix()) {
            key = config.getKeyPrefixFor(NAME) + key;
        }
        byte[] k = ByteUtils.getBytes(config.getKeySerializationPair().write(key));
        byte[] v = ByteUtils.getBytes(config.getValueSerializationPair().write(value));
        writer.put(NAME, k, v, Duration.ofMillis(timeout));
    }

    @Override
    public void expire(String key, long timeout) {
        if (get(key) == null) {
            return;
        }
        RedisCacheConfiguration config = getCacheConfiguration();
        byte[] k = ByteUtils.getBytes(config.getKeySerializationPair().write(key));
        try (RedisConnection connection = factory.getConnection()) {
            connection.expire(k, TimeUnit.MILLISECONDS.toSeconds(timeout));
        }
    }

}
