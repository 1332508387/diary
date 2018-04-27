package diary.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import diary.common.VerifyCodeContant;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import diary.common.vo.SysResult;
import diary.pojo.User;
import diary.service.UserService;

@SessionAttributes("currUser")
@RequestMapping("/user")
@RestController
public class UserController {
	@Resource
	private UserService userService;
	
	@RequestMapping("/doRegister")
	public SysResult register(User user, String verifyCode,  HttpSession session){
		String realVerifyCode = (String) session.getAttribute(VerifyCodeContant.KAPTHA_VERIFY_CODE_KEY);
		if(!StringUtils.equalsIgnoreCase(realVerifyCode, verifyCode)){
			session.invalidate();
			return SysResult.build(201, "验证码错误");
		}
		session.removeAttribute(VerifyCodeContant.KAPTHA_VERIFY_CODE_KEY);
		// 检查用户是否已存在
		User _user = new User();
		_user.setUsername(user.getUsername());
		User checkUser = this.userService.queryByWhere(_user);
		if(null != checkUser){
			return SysResult.build(201, "该用户已存在！");
		}
		
		try {
			this.userService.saveUser(user);
			return SysResult.ok();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SysResult.build(201, "用户注册失败！");
	}
	
	/*@RequestMapping("/doLogin")
	public SysResult login(User user, Model model, HttpServletRequest request){
		user.setPassword(MD5Util.md5(user.getPassword()));
		user.setType(null);
		User checkUser = this.userService.queryByWhere(user);
		
		if(null == checkUser){
			return SysResult.build(201, "用户名或密码错误！");
		}
		
		// 禁止多处登陆
		@SuppressWarnings("unchecked")
		Map<Long, User> userMap = (Map<Long, User>) request.getSession().getServletContext().getAttribute("userMap");
		if(userMap.containsKey(checkUser.getId())){
			return SysResult.build(201, "用户已在其他浏览器登录，请注销后在登录");
		}
		
		// 登陆成功
		userMap.put(checkUser.getId(), checkUser);
		model.addAttribute("currUser", checkUser);
		
		return SysResult.ok();
	}*/
	
	/*@RequestMapping("/login/failure")
	public String loginFailure(String error, HttpServletRequest request) {
		request.setAttribute("error", error);
		System.err.println("nonono");
		return "forward:/login";
	}*/
	
	/*@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public ModelAndView logout(HttpSession session){
//		@SuppressWarnings("unchecked")
//		Map<Long, User> userMap = (Map<Long, User>) session.getServletContext().getAttribute("userMap");
//		userMap.remove(((User)session.getAttribute("currUser")).getId());
		session.invalidate();
		return new ModelAndView("login");
	}*/
	
	@RequestMapping("/getData")
	public Map<String, Object> getUserList(Integer pageIndex, Integer pageSize, String key, String value){
		return this.userService.queryUserList(pageIndex, pageSize, key, value);
	}
	
	@RequestMapping("/del/{userId}")
	public SysResult remove(@PathVariable Long userId) {
		try {
			this.userService.removeUserById(userId);
			return SysResult.build(200, "用户删除成功");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SysResult.build(201, "用户删除失败");
	}
	
	@RequestMapping("/save")
	public SysResult save(User user) {
		try {
			return this.userService.saveAdminUser(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SysResult.build(201, "管理员添加失败");
	}
	
}
