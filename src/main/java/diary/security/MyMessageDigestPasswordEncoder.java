package diary.security;

import org.apache.commons.lang3.StringUtils;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.encoding.MessageDigestPasswordEncoder;

import diary.common.util.MD5Util;

/**
 * 用于对用户提交的密码进行自定义的加密操作
 */
public class MyMessageDigestPasswordEncoder extends MessageDigestPasswordEncoder {

	public MyMessageDigestPasswordEncoder(String algorithm) {
		super(algorithm);
	}

	/**
	 * encPass：用户的真是密码
	 * raw：用户提交的密码
	 * 
	 */
	@Override
	public boolean isPasswordValid(String encPass, String rawPass, Object salt) {
		if(StringUtils.isEmpty(rawPass)) {
			throw new BadCredentialsException("密码不能为空");
		}
		return encPass.equals(MD5Util.md5(rawPass));
	}

}
