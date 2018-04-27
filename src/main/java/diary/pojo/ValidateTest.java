package diary.pojo;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

public class ValidateTest {

	@NotEmpty(message = "用户名不能为空")
	private String username;
	
	@NotEmpty(message = "密码不能为空")
	@Size(min = 6, max = 20, message = "密码必须在6-10个字符之间")
	private String password;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Override
	public String toString() {
		return "ValidateTest [username=" + username + ", password=" + password + "]";
	}
	
}
