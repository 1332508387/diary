package diary.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import diary.mapper.StatisticsMapper;

@Service
public class StatisticsService {

	@Resource
	private StatisticsMapper statisticsMapper;

	public Map<String, Integer> getDiaryAmount(Long userId) {
		return this.statisticsMapper.getDiaryAmount(userId);
	}

	public String getStartDate(Long userId) {
		return this.statisticsMapper.getStartDate(userId);
	}

	public List<String> getWriteDateList(Long userId) {
		return this.statisticsMapper.getWriteDateList(userId);
	}
	
	public List<String> getWriteDateList2(Long userId, Date startDate, Date endDate) {
		Map<String, Object> params = new HashMap<>();
		params.put("userId", userId);
		params.put("startDate", startDate);
		params.put("endDate", endDate);
		return this.statisticsMapper.getWriteDateList2(params);
	}
	
}
