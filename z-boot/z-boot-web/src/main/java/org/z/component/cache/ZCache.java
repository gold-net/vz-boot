package org.z.component.cache;

import org.springframework.cache.Cache;

/**
 * @author z
 * <p>     2020/7/24
 */
public interface ZCache extends Cache {

    void put(String key, Object value, long timeout);

    void expire(String key, long timeout);

}
