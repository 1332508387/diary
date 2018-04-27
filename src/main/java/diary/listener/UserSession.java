package diary.listener;

import java.util.Map;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import diary.pojo.User;

public class UserSession implements HttpSessionListener {

	public UserSession() {}

	public void sessionCreated(HttpSessionEvent se) {}

	/**
	 * 当 session 销毁时调用
	 */
	public void sessionDestroyed(HttpSessionEvent se) {
		User user = (User) se.getSession().getAttribute("currUser");
		@SuppressWarnings("unchecked")
		Map<Long, User> userMap = (Map<Long, User>) se.getSession().getServletContext().getAttribute("userMap");
		userMap.remove(user.getId());
	}

}
