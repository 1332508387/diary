package diary.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

public interface StatisticsMapper {

	Map<String, Integer> getDiaryAmount(Long userId);

	@Select("SELECT DATE_FORMAT(MIN(write_date),'%Y-%m-%d') FROM tb_diary WHERE user_id = #{userId} AND status >= 0")
	String getStartDate(Long userId);

	@Select("SELECT DATE_FORMAT(write_date,'%Y-%m-%d') FROM tb_diary WHERE user_id = #{userId} AND status >= 0 ORDER BY write_date")
	List<String> getWriteDateList(Long userId);

	@Select("(SELECT DATE_FORMAT(write_date,'%Y-%m-%d') wd "
			+ "FROM tb_diary "
			+ "WHERE user_id = #{userId} AND status >= 0 AND write_date BETWEEN #{startDate} AND #{endDate}) "
			+ "UNION ALL "
			+ "(SELECT DATE_FORMAT(MIN(write_date),'%Y-%m-%d') wd "
			+ "FROM tb_diary "
			+ "WHERE user_id = #{userId} AND status >= 0) ORDER BY wd")
	List<String> getWriteDateList2(Map<String, Object> params);
}
