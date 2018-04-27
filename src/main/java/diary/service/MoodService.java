package diary.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import diary.mapper.MoodMapper;
import diary.pojo.Mood;

@Service
public class MoodService extends BaseService<Mood> {
	@Resource
	private MoodMapper moodMapper;

	public Map<String, Object> queryMoodList(Integer pageIndex, Integer pageSize, String key, String value) {
		Map<String, Object> result = new HashMap<>();
		
		Map<String, Object> params = new HashMap<>();
		params.put("pageIndex", pageIndex);
		params.put("pageSize", pageSize);
		params.put("key", key);
		params.put("value", value);
		List<Mood> moods = this.moodMapper.queryMoodList(params);
		int count = this.moodMapper.count(params);
		
		result.put("data", moods);
		result.put("recordsTotal", count);
		result.put("recordsFiltered", count);
		return result;
	}
}
