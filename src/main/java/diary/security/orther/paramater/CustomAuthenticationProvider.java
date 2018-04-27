package diary.security.orther.paramater;

import diary.common.VerifyCodeContant;
import diary.common.util.MD5Util;
import diary.mapper.UserMapper;
import diary.pojo.User;
import org.apache.commons.lang3.StringUtils;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.authority.AuthorityUtils;

import javax.annotation.Resource;
import java.util.List;

public class CustomAuthenticationProvider implements AuthenticationProvider {
    @Resource
    private UserMapper userMapper;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        CustomWebAuthenticationDetails details = (CustomWebAuthenticationDetails) authentication.getDetails();
        String verifyCode = details.getVerifyCode();
        String realVerify = details.getRealVerifyCode();
        if (StringUtils.isEmpty(verifyCode)) {
            throw new BadCredentialsException("放弃吧，验证码不能为空");
        }

        if (!StringUtils.equalsIgnoreCase(verifyCode, realVerify)) {
            details.getSession().invalidate();
            throw  new BadCredentialsException("验证码错误");
        }
        details.getSession().removeAttribute(VerifyCodeContant.KAPTHA_VERIFY_CODE_KEY);
        User user = details.getUser();
        if (StringUtils.isEmpty(user.getUsername())) {
            throw new BadCredentialsException("用户名不能为空");
        }
        if (StringUtils.isEmpty(user.getPassword())) {
            throw new BadCredentialsException("放弃吧，密码不能为空");
        }

        User tmpUser = new User();
        tmpUser.setPassword(null);
        tmpUser.setType(null);
        tmpUser.setUsername(user.getUsername());
        List<User> users = this.userMapper.select(tmpUser);
        if (users.isEmpty()) {
            throw  new BadCredentialsException("用户不存在");
        }
        tmpUser = users.get(0);
        if (!StringUtils.equals(tmpUser.getPassword(), MD5Util.md5(user.getPassword()))) {
            throw new BadCredentialsException("用户名或密码错误");
        }
        return new UsernamePasswordAuthenticationToken(tmpUser,
                authentication.getCredentials(), AuthorityUtils.createAuthorityList("ROLE_" + tmpUser.getType()));
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return authentication.equals(UsernamePasswordAuthenticationToken.class);
    }
}
