package org.z.modules.system.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Service;
import org.z.common.system.vo.LoginUser;
import org.z.common.util.IPUtil;
import org.z.component.spring.SpringContextHolder;
import org.z.modules.system.entity.SysLog;
import org.z.modules.system.entity.SysUser;
import org.z.modules.system.mapper.SysLogMapper;
import org.z.modules.system.service.ISysLogService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * 系统日志表 服务实现类
 * </p>
 *
 * @author z
 */
@Service
public class SysLogServiceImpl extends ServiceImpl<SysLogMapper, SysLog> implements ISysLogService {

    @Resource
    private SysLogMapper sysLogMapper;

    @Override
    public void addLog(String logContent, Integer logType, Integer operateType, SysUser user) {
        SysLog sysLog = new SysLog();
        //注解上的描述,操作日志内容
        sysLog.setLogContent(logContent);
        sysLog.setLogType(logType);
        sysLog.setOperateType(operateType);

        //请求的方法名
        //请求的参数

        try {
            //获取request
            HttpServletRequest request = SpringContextHolder.getHttpServletRequest();
            if (request == null) {
                sysLog.setIp("127.0.0.1");
            } else {
                //设置IP地址
                sysLog.setIp(IPUtil.getIpAddr(request));
            }
        } catch (Exception e) {
            sysLog.setIp("127.0.0.1");
        }

        //获取登录用户信息
        if (user != null) {
            sysLog.setUserid(user.getUsername());
            sysLog.setUsername(user.getRealname());
        } else {
            LoginUser sysUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();
            if (sysUser != null) {
                sysLog.setUserid(sysUser.getUsername());
                sysLog.setUsername(sysUser.getRealname());

            }
        }

        sysLog.setCreateTime(new Date());
        //保存系统日志
        sysLogMapper.insert(sysLog);
    }

    /**
     * @功能：清空所有日志记录
     */
    @Override
    public void removeAll() {
        sysLogMapper.removeAll();
    }

    @Override
    public Long findTotalVisitCount() {
        return sysLogMapper.findTotalVisitCount();
    }

    @Override
    public Long findTodayVisitCount(Date dayStart, Date dayEnd) {
        return sysLogMapper.findTodayVisitCount(dayStart, dayEnd);
    }

    @Override
    public Long findTodayIp(Date dayStart, Date dayEnd) {
        return sysLogMapper.findTodayIp(dayStart, dayEnd);
    }

    @Override
    public List<Map<String, Object>> findVisitCount(Date dayStart, Date dayEnd) {
        return sysLogMapper.findVisitCount(dayStart, dayEnd);
    }
}
