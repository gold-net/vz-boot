package org.z.modules.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.z.modules.system.entity.SysLog;
import org.z.modules.system.entity.SysUser;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * 系统日志表 服务类
 * </p>
 *
 * @author z
 */
public interface ISysLogService extends IService<SysLog> {

    /**
     * 日志添加
     *
     * @param logContent  内容
     * @param logType     日志类型(0:操作日志;1:登录日志;2:定时任务)
     * @param operateType 操作类型(1:添加;2:修改;3:删除;)
     * @param user        登录用户
     */
    void addLog(String logContent, Integer logType, Integer operateType, SysUser user);

    /**
     * @功能：清空所有日志记录
     */
    void removeAll();

    /**
     * 获取系统总访问次数
     *
     * @return Long
     */
    Long findTotalVisitCount();


    /**
     * 获取系统今日访问次数
     *
     * @return Long
     */
    Long findTodayVisitCount(Date dayStart, Date dayEnd);

    /**
     * 获取系统今日访问 IP数
     *
     * @return Long
     */
    Long findTodayIp(Date dayStart, Date dayEnd);

    /**
     * 首页：根据时间统计访问数量/ip数量
     *
     * @param dayStart
     * @param dayEnd
     * @return
     */
    List<Map<String, Object>> findVisitCount(Date dayStart, Date dayEnd);
}
