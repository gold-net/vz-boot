package org.z.modules.quartz.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.z.modules.quartz.entity.QuartzJob;

import java.util.List;

/**
 * @author z
 */
public interface QuartzJobMapper extends BaseMapper<QuartzJob> {

    public List<QuartzJob> findByJobClassName(@Param("jobClassName") String jobClassName);

}
