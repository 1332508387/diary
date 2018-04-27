package diary.security;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import diary.mapper.UserMapper;
import diary.pojo.User;

/**
 * 根据用户提交的用户名查询出用户信息
 */
public class UserDetailsServiceImpl implements UserDetailsService {
    @Resource
    private UserMapper userMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        if (StringUtils.isEmpty(username)) {
            throw new BadCredentialsException("用户名不能为空");
        }

        UserDetails userDetails = null;
        User user = new User();
        user.setUsername(username);
        user.setType(null);
        // 根据用户名查询用户信息
        List<User> users = null;
        try {
            users = this.userMapper.select(user);
        } catch (Exception e) {
            throw new BadCredentialsException("出错了，请稍候重试");
        }
        if (users.isEmpty()) {
            throw new BadCredentialsException("用户名不存在");
        }
        user = users.get(0);
        userDetails = new org.springframework.security.core.userdetails.User(
                user.getUsername(),
                user.getPassword(),    // 数据库中存储的密码
                true,                // 用户是否激活
                true,                // 帐户是否过期
                true,                // 证书是否过期
                true,                // 账号是否锁定
                AuthorityUtils.createAuthorityList("ROLE_" + user.getType()));    // 用户角色列表，必须以 ROLE_ 开头
        return userDetails;
    }
}
