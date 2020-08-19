package org.z.modules.shiro.web;

import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.authz.AuthorizationException;
import org.apache.shiro.authz.UnauthenticatedException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.z.common.system.vo.Result;

import javax.security.enterprise.AuthenticationException;
import javax.servlet.http.HttpServletResponse;

@Slf4j
@RestControllerAdvice
public class ExceptionHandlerController {

    /**
     * 认证异常
     *
     * @return Result<?>
     */
    @ExceptionHandler({UnauthenticatedException.class, AuthenticationException.class})
    public Result<?> authenticationException(Exception e, HttpServletResponse response) {
        log.error(e.getMessage(), e);
        response.setStatus(HttpServletResponse.SC_FORBIDDEN);
        return Result.error(HttpServletResponse.SC_UNAUTHORIZED, e.getMessage());
    }

    /**
     * 权限异常
     *
     * @return Result<?>
     */
    @ExceptionHandler({AuthorizationException.class})
    public Result<?> authorizationException(Exception e, HttpServletResponse response) {
        log.error(e.getMessage(), e);
        response.setStatus(HttpServletResponse.SC_FORBIDDEN);
        return Result.error(HttpServletResponse.SC_FORBIDDEN, e.getMessage());
    }
}