package diary.listener;

import java.util.LinkedHashMap;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import diary.pojo.User;

public class UserLoginListener implements ServletContextListener {

    public UserLoginListener() {}

    public void contextDestroyed(ServletContextEvent sce)  {}

    public void contextInitialized(ServletContextEvent sce)  { 
         sce.getServletContext().setAttribute("userMap", new LinkedHashMap<Long, User>());
    }
	
}
