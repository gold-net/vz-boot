package org.z.modules.shiro.authc;

import org.apache.shiro.authc.UsernamePasswordToken;

/**
 * @author z
 */
public class JwtToken extends UsernamePasswordToken {

    private static final long serialVersionUID = 1L;

    private final String token;

    public JwtToken(String token) {
        this.token = token;
    }

    @Override
    public Object getPrincipal() {
        return token;
    }

    @Override
    public Object getCredentials() {
        return token;
    }
}
