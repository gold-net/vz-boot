package org.z.modules.quartz.job;

import lombok.extern.slf4j.Slf4j;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.z.common.util.DateUtil;

/**
 * 示例不带参定时任务
 *
 * @author z
 */
@Slf4j
public class SampleJob implements Job {

    @Override
    public void execute(JobExecutionContext jobExecutionContext) throws JobExecutionException {

        log.info("普通定时任务 SampleJob !  时间:{}", DateUtil.now());
    }
}
