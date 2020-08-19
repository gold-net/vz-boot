package org.z.component.cache;

import org.springframework.cache.CacheManager;

/**
 * @author z
 * <p>     2020/7/24
 */
public interface ZCacheManager extends CacheManager {

    void set(String key, Object value);

    void set(String key, Object value, long timeout);

    Object get(String key);

    void del(String key);

    void expire(String key, long timeout);

}
