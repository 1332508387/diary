package diary.pojo;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 用户
 *
 */
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@Table(name = "tb_user")
public class User extends BasePojo {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	private String username;
	
	private String password;
	
	/** 用户类型 0、管理员 1、普通用户 */
	private Integer type = 1;
	
	/** 用户的状态 0、正常 -1、删除 */
	private Integer status;
}
