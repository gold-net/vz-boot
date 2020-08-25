package org.z.component.cache;


import com.github.benmanes.caffeine.cache.Caffeine;
import com.github.benmanes.caffeine.cache.LoadingCache;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.caffeine.CaffeineCache;
import org.springframework.lang.Nullable;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.Callable;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/**
 * 默认最多缓存30天
 *
 * @author z
 */
@Slf4j
public class MemoryZCache extends CaffeineCache implements ZCache {

    private static final String NAME = "Z_CACHE_NAME";

    private static final int EXPIRE_AFTER_ACCESS_DAYS = 30;

    public MemoryZCache() {
        super(NAME, Caffeine.newBuilder().expireAfterAccess(EXPIRE_AFTER_ACCESS_DAYS, TimeUnit.DAYS).build());
        new ScheduledThreadPoolExecutor(1, r -> new Thread(r, "LocalMemoryCacheCleaner"))
                .scheduleWithFixedDelay(this::evict, 1, 1, TimeUnit.MINUTES);
    }

    @Override
    public void put(String key, Object value, long timeout) {
        this.put(key, new CacheData(value, timeout));
    }

    @Override
    public ValueWrapper get(Object key) {
        if (getNativeCache() instanceof LoadingCache) {
            Object value = ((LoadingCache<Object, Object>) this.getNativeCache()).get(key);
            if (value instanceof CacheData) {
                CacheData cd = (CacheData) value;
                if (cd.isExpired()) {
                    return toValueWrapper(null);
                }
                value = cd.data;
            }
            return toValueWrapper(value);
        }
        return toValueWrapper(lookup(key));
    }

    @SuppressWarnings("unchecked")
    @Override
    public <T> T get(Object key, final Callable<T> valueLoader) {
        Object value = fromStoreValue(this.getNativeCache().get(key, x -> {
            try {
                return toStoreValue(valueLoader.call());
            } catch (Exception e) {
                throw new ValueRetrievalException(x, valueLoader, e);
            }
        }));
        if (value instanceof CacheData) {
            CacheData cd = (CacheData) value;
            if (cd.isExpired()) {
                return null;
            }
            return (T) cd.data;
        }
        return (T) value;
    }

    @Override
    @Nullable
    protected Object lookup(Object key) {
        Object value = this.getNativeCache().getIfPresent(key);
        if (value instanceof CacheData) {
            CacheData cd = (CacheData) value;
            if (cd.isExpired()) {
                return null;
            }
            return cd.data;
        }
        return value;
    }

    @Override
    public void expire(String key, long timeout) {
        CacheData value = get(key, CacheData.class);
        if (value == null) {
            return;
        }
        if (value.isExpired()) {
            evict(key);
            return;
        }
        value.setExpireTime(timeout);
    }

    private void evict() {
        Set<Map.Entry<Object, Object>> keys = getNativeCache().asMap().entrySet();
        Set<String> set = new HashSet<>();
        for (Map.Entry<Object, Object> entry : keys) {
            CacheData value = (CacheData) entry.getValue();
            if (value.isExpired()) {
                evict(entry.getKey());
                set.add((String) entry.getKey());
            }
        }
        log.info("清理本地内存缓存{}个,keys:{}", set.size(), set.toString());
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
