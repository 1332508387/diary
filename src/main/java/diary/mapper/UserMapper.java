package diary.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import diary.common.mapper.SysMapper;
import diary.pojo.User;

public interface UserMapper extends SysMapper<User> {
//	@Select("SELECT * FROM tb_user WHERE status = 0 ORDER BY updated DESC LIMIT #{pageIndex}, #{pageSize}")
	List<User> getUserList(@Param("pageIndex") Integer pageIndex,
						   @Param("pageSize") Integer pageSize,
						   @Param("key") String key,
						   @Param("value") String value);

	int count(@Param("key") String key, @Param("value") String value);
}
