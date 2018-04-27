package diary.mapper;

import java.util.List;
import java.util.Map;

import diary.common.mapper.SysMapper;
import diary.pojo.Mood;

public interface MoodMapper extends SysMapper<Mood> {

	List<Mood> queryMoodList(Map<String, Object> params);

	int count(Map<String, Object> params);

}
