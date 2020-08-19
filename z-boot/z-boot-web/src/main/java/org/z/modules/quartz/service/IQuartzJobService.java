package org.z.modules.quartz.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.quartz.SchedulerException;
import org.z.modules.quartz.entity.QuartzJob;

import java.util.List;

/**
 * @author z
 */
public interface IQuartzJobService extends IService<QuartzJob> {

    List<QuartzJob> findByJobClassName(String jobClassName);

    boolean saveAndScheduleJob(QuartzJob quartzJob);

    boolean editAndScheduleJob(QuartzJob quartzJob) throws SchedulerException;

    boolean deleteAndStopJob(QuartzJob quartzJob);

    boolean resumeJob(QuartzJob quartzJob);
}
