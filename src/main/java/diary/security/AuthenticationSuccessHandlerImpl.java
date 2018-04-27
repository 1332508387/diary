package diary.security;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.DefaultSavedRequest;

import diary.mapper.UserMapper;
import diary.pojo.User;

/**
 * 用于登录认证成功后执行的操作
 */
public class AuthenticationSuccessHandlerImpl implements AuthenticationSuccessHandler {
	@Resource
	private UserMapper userMapper;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		/*// UserDetails 中存放着用户名等信息
		UserDetails userDetails = (UserDetails) authentication.getPrincipal();
		// 获取该用户信息，根据自己的业务规则写
		User user = new User();
		user.setType(null);
		user.setUsername(userDetails.getUsername());
		user = this.userMapper.select(user).get(0);*/
		User user = (User) authentication.getPrincipal();
		// 将用户放到 Session
		request.getSession().setAttribute("currUser", user);
		
		DefaultSavedRequest defaultSavedRequest = (DefaultSavedRequest)request.getSession().getAttribute("SPRING_SECURITY_SAVED_REQUEST");
		String requestUrl = defaultSavedRequest == null ? "/" : defaultSavedRequest.getRequestURI();
		
		// 跳转到请求页
		response.sendRedirect(request.getContextPath() + requestUrl);
	}

}
