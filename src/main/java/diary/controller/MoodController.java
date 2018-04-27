package diary.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import diary.common.vo.SysResult;
import diary.pojo.Mood;
import diary.pojo.User;
import diary.service.MoodService;

@RequestMapping("/mood")
@RestController
public class MoodController {
	@Resource
	private MoodService moodService;
	
	/**
	 * 用于前端页面心情下拉列表显示（Ajax请求）
	 */
	@RequestMapping(value = "/getMoodIdAndName", method = RequestMethod.GET)
	public Map<Long, String> getMoodIdAndName(){
		Map<Long, String> result = new HashMap<>();
		List<Mood> moods = this.moodService.queryAll();
		for (Mood mood : moods) {
			result.put(mood.getId(), mood.getName());
		}
		return result;
	}
	
	@RequestMapping(value = "/getData", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getMoodList(Integer pageIndex, Integer pageSize, String key, String value){
		return this.moodService.queryMoodList(pageIndex, pageSize, key, value);
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public SysResult saveMood(Mood mood, HttpSession session){
		User user = (User) session.getAttribute("currUser");
		if(null == user || user.getType() != 0){
			return SysResult.build(201, "无权限！");
		}
		
		try {
			mood.setCreated(new Date());
			mood.setUpdated(mood.getCreated());
			this.moodService.saveSelective(mood);
			return SysResult.build(200, "心情保存成功！");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SysResult.build(201, "心情保存失败！");
	}
	
	@RequestMapping("/update")
	@ResponseBody
	public SysResult updateMood(Mood mood, HttpSession session){
		User user = (User) session.getAttribute("currUser");
		if(null == user || user.getType() != 0){
			return SysResult.build(201, "无权限！");
		}
		
		try {
			mood.setUpdated(new Date());
			this.moodService.updateSelective(mood);
			return SysResult.build(200, "心情修改成功！");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SysResult.build(201, "心情修改失败！");
	}
	
	@RequestMapping("/del/{id}")
	@ResponseBody
	public SysResult removeMood(@PathVariable Long id, HttpSession session){
		User user = (User) session.getAttribute("currUser");
		if(null == user || user.getType() != 0){
			return SysResult.build(201, "无权限！");
		}
		
		try {
			this.moodService.deleteById(id);
			return SysResult.build(200, "心情删除成功！");
		} catch (Exception e) {
			e.printStackTrace();
		}	
		return SysResult.build(201, "心情修改失败！");
	}
}
