package diary.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import diary.common.util.MD5Util;
import diary.common.vo.SysResult;
import diary.mapper.UserMapper;
import diary.pojo.User;

@Service
public class UserService extends BaseService<User> {
	@Resource
	private UserMapper userMapper;
	
	public void saveUser(User user) {
		user.setStatus(0);
		user.setType(1);
		user.setCreated(new Date());
		user.setUpdated(user.getCreated());
		user.setPassword(MD5Util.md5(user.getPassword()));
		this.saveSelective(user);
	}

	public Map<String, Object> queryUserList(Integer pageIndex, Integer pageSize, String key, String value) {
		//PageHelper.startPage(pageIndex, pageSize);
		if (StringUtils.equals("all", key)) {
			key = null;
			value = null;
		}
		List<User> users = this.userMapper.getUserList(pageIndex, pageSize, key, value);
		int count = this.userMapper.count(key, value);
		//PageInfo<User> info = new PageInfo<>(users);
		
		Map<String, Object> result = new HashMap<>();
		result.put("data", users);
		result.put("recordsTotal", count);
		result.put("recordsFiltered", count);
		
		return result;
	}

	public void removeUserById(Long userId) {
		User user = new User();
		user.setId(userId);
		user.setType(null);
		user.setStatus(-1);
		this.userMapper.updateByPrimaryKeySelective(user);
	}

	public SysResult saveAdminUser(User user) {
		// 只允许手动添加管理员用户
		if(user.getType() == null ? true : user.getType() != 0) {
			return SysResult.build(201, "只能添加管理员用户");
		}
		
		User user2 = new User();
		user2.setUsername(user.getUsername());
		user2.setType(null);
		List<User> users = this.userMapper.select(user2);
		if(!users.isEmpty()) {
			return SysResult.build(201, "用户名已存在");
		}
		
		user.setStatus(0);
		user.setPassword(MD5Util.md5(user.getPassword()));
		user.setCreated(new Date());
		user.setUpdated(user.getCreated());
		this.userMapper.insertSelective(user);
		return SysResult.build(200, "管理员用户添加成功");
	}
}
