package org.z.modules.shiro.authc.filter;

import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.AuthenticatingFilter;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.RequestMethod;
import org.z.common.constant.CommonConstant;
import org.z.common.system.vo.Result;
import org.z.common.util.JsonUtil;
import org.z.modules.shiro.authc.JwtToken;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author z
 */
@Slf4j
public class JwtFilter extends AuthenticatingFilter {
    /**
     * 执行登录认证
     */
    @Override
    protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) {
        HttpServletResponse httpServletResponse = (HttpServletResponse) response;
        Result<?> result;
        RuntimeException throwable;
        try {
            AuthenticationToken token = createToken(request, response);
            Subject subject = getSubject(request, response);
            subject.login(token);
            return true;
        } catch (AuthenticationException e) {
            throwable = e;
            httpServletResponse.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            result = Result.error(HttpServletResponse.SC_UNAUTHORIZED, e.getMessage());
        } catch (RuntimeException e) {
            throwable = e;
            httpServletResponse.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            result = Result.error(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
        try {
            httpServletResponse.getWriter().write(JsonUtil.OBJECT_MAPPER.writeValueAsString(result));
        } catch (IOException e) {
            log.error(e.getMessage(), e);
            throw throwable;
        }
        return false;
    }
    @Override
    protected boolean onAccessDenied(ServletRequest request, ServletResponse response) {
        return false;
    }

    @Override
    protected AuthenticationToken createToken(ServletRequest request, ServletResponse response) {
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        String token = httpServletRequest.getHeader(CommonConstant.X_ACCESS_TOKEN);
        if (StringUtils.isEmpty(token)) {
            throw new UnknownAccountException("token cannot be empty.");
        }
        return new JwtToken(token);
    }

    /**
     * 对跨域提供支持
     */
    @Override
    protected boolean preHandle(ServletRequest request, ServletResponse response) throws Exception {
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        HttpServletResponse httpServletResponse = (HttpServletResponse) response;
        httpServletResponse.setHeader("Access-control-Allow-Origin", httpServletRequest.getHeader("Origin"));
        httpServletResponse.setHeader("Access-Control-Allow-Methods", "GET,POST,OPTIONS,PUT,DELETE");
        httpServletResponse.setHeader("Access-Control-Allow-Headers", httpServletRequest.getHeader("Access-Control-Request-Headers"));
        // 跨域时会首先发送一个option请求，这里我们给option请求直接返回正常状态
        if (httpServletRequest.getMethod().equals(RequestMethod.OPTIONS.name())) {
            httpServletResponse.setStatus(HttpStatus.OK.value());
            return false;
        }
        return super.preHandle(request, response);
    }
}
