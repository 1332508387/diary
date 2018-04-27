package diary.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import diary.common.mapper.SysMapper;
import diary.pojo.Diary;
import diary.pojo.User;

public interface DiaryMapper extends SysMapper<Diary>{

	List<Diary> queryDiaryList(@Param("user") User user, 
							@Param("diary") Diary diary, 
							@Param("startTime") String startTime,
							@Param("endTime") String endTime,
							@Param("pageIndex") Integer pageIndex, 
							@Param("pageSize") Integer pageSize);
	
	int count(@Param("user") User user, 
			@Param("diary") Diary diary,
			@Param("startTime") String startTime,
			@Param("endTime") String endTime);
	
	@Select("SELECT * FROM tb_diary WHERE write_date = #{writeDate} AND user_id = #{userId} AND status >= 0;")
	List<Diary> queryDiaryByWrite(Diary diary);

	@Select("SELECT * FROM tb_diary WHERE user_id = #{userId} AND write_date = #{writeDate} AND status <> -1")
    Diary getDiaryByWriteDate(Long userId, Date writeDate);
}
