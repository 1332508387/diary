package diary.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import diary.pojo.User;
import diary.service.StatisticsService;

/**
 * 统计
 *
 */
@RequestMapping("/statistics")
@Controller
public class StatisticsController extends DateController {

	@Resource
	private StatisticsService statisticsService;
	
	/**
	 * 获取当前用户日记数量：应写数量，实际数量，漏写数量
	 * 
	 * @return
	 */
	@RequestMapping("/diary/amount")
	@ResponseBody
	public Map<String, Integer> getDiaryAmount(HttpSession session){
		System.out.println("我是断点前的一句话");
		User user = (User) session.getAttribute("currUser");
		Long userId = user.getId();
		return this.statisticsService.getDiaryAmount(userId);
	}
	
	/**
	 * 获取当前用户开始写日记的时间
	 * 
	 * @return
	 */
	@RequestMapping("/diary/startDate")
	@ResponseBody
	public String getStartDate(HttpSession session){
		User user = (User) session.getAttribute("currUser");
		Long userId = user.getId();
		return this.statisticsService.getStartDate(userId);
	}
	
	/**
	 * 获取当前用户所有已写日记的日期
	 * 
	 * @return
	 */
	@RequestMapping("/diary/writeDate/list")
	@ResponseBody
	public List<String> getWriteDateList(HttpSession session){
		return this.statisticsService.getWriteDateList(this.getUserId(session));
	}
	
	@RequestMapping("/diary/writeDate/list2")
	@ResponseBody
	public List<String> getWriteDateList2(HttpSession session, Date startDate, Date endDate){
		return this.statisticsService.getWriteDateList2(this.getUserId(session), startDate, endDate);
	}
	
	
	
	public Long getUserId(HttpSession session){
		return ((User) session.getAttribute("currUser")).getId();
	}
	
}
