package org.z.component.cache;


import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.Cache;
import org.springframework.cache.caffeine.CaffeineCache;
import org.springframework.cache.caffeine.CaffeineCacheManager;

import javax.annotation.Nonnull;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicBoolean;

/**
 * @author z
 */
@Slf4j
public class MemoryZCacheManager extends CaffeineCacheManager implements ZCacheManager {

    private static final String NAME = "Z_CACHE_NAME";
    private static final AtomicBoolean INIT = new AtomicBoolean();

    @Override
    public void set(String key, Object value) {
        getCache().put(key, new CacheData(value));
    }

    @Override
    public void set(String key, Object value, long timeout) {
        getCache().put(key, new CacheData(value, timeout));
    }

    @Override
    public Object get(String key) {
        CacheData value = getCache().get(key, CacheData.class);
        if (value == null) {
            return null;
        }
        return value.data;
    }

    @Override
    public void del(String key) {
        getCache().evict(key);
    }

    @Nonnull
    public Cache getCache() {
        Cache cache = super.getCache(NAME);
        cache = cache == null ? super.createCaffeineCache(NAME) : cache;
        if (!INIT.get()) {
            if (INIT.compareAndSet(false, true)) {
                log.debug("本地缓存初始化");
                new ScheduledThreadPoolExecutor(1, r -> new Thread(r, "LocalMemoryCacheCleaner"))
                        .scheduleWithFixedDelay(this::evict, 1, 1, TimeUnit.MINUTES);
            }
        }
        return cache;

    }

    @Override
    public void expire(String key, long timeout) {
        CacheData value = getCache().get(key, CacheData.class);
        if (value == null) {
            return;
        }
        if (value.isExpired()) {
            getCache().evict(key);
            return;
        }
        value.setExpireTime(timeout);
    }

    public void evict() {
        CaffeineCache cache = (CaffeineCache) getCache();
        Set<Map.Entry<Object, Object>> keys = cache.getNativeCache().asMap().entrySet();
        Set<String> set = new HashSet<>();
        for (Map.Entry<Object, Object> entry : keys) {
            CacheData value = (CacheData) entry.getValue();
            if (value.isExpired()) {
                cache.evict(entry.getKey());
                set.add((String) entry.getKey());
            }
        }
        log.info("缓存{}，清理本地内存缓存{}个,keys:{}", cache, set.size(), set.toString());
    }

    private static class CacheData {
        private final Object data;
        private long expireTime;

        public CacheData(Object t, long expire) {
            this.data = t;
            if (expire <= 0) {
                this.expireTime = 0L;
            } else {
                this.expireTime = System.currentTimeMillis() + expire;
            }
        }

        public CacheData(Object t) {
            this.data = t;
        }

        /**
         * 判断缓存数据是否过期
         *
         * @return true表示过期，false表示未过期
         */
        public boolean isExpired() {
            if (expireTime <= 0) {
                return false;
            }
            return expireTime <= System.currentTimeMillis();
        }

        public void setExpireTime(long expireTime) {
            this.expireTime = expireTime;
        }
    }
}
