package diary.controller;

import diary.common.vo.SysResult;
import diary.pojo.Diary;
import diary.pojo.DiaryContent;
import diary.pojo.DiaryPwd;
import diary.pojo.User;
import diary.service.DiaryPwdService;
import diary.service.DiaryService;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import java.util.Map;

@RequestMapping("/diary")
@RestController
public class DiaryController extends DateController {
	@Resource
	private DiaryService diaryService;
	@Resource
	private DiaryPwdService diaryPwdService;

	@RequestMapping("/getData")
	public Map<String, Object> getDiaryList(Diary diary, String startTime, 
			String endTime, Integer pageIndex, 
			Integer pageSize, HttpSession session){
		User user = (User) session.getAttribute("currUser");
		
		return this.diaryService.queryDiaryList(user, diary, startTime, endTime, pageIndex, pageSize);
	}
	
	@RequestMapping("/save")
	public SysResult saveDiaty(Diary diary, DiaryContent content, HttpSession session){
		User user = (User) session.getAttribute("currUser");
		diary.setUserId(user.getId());
		try {
			return this.diaryService.saveDiaryAnContent(diary, content);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SysResult.build(201, "日记保存失败！");
	}
	
	@RequestMapping("/update")
	public SysResult updateDiary(Diary diary, DiaryContent content, HttpSession session){
		User user = (User) session.getAttribute("currUser");
		diary.setUserId(user.getId());
		try{
			return this.diaryService.updateDiaryAndContent(diary, content);
		} catch(Exception e) {
			e.printStackTrace();
		} 
		return SysResult.build(201, "日记修改失败！");
	}
	
	/**
	 * 删除指定 ID 的日记信息（逻辑删除，将状态置为 -1）
	 */
	@RequestMapping("/del/{id}")
	public SysResult removeDiary(@PathVariable Long id){
		Diary diary = new Diary();
		diary.setId(id);
		diary.setStatus(-1);
		try {
			this.diaryService.updateSelective(diary);
			return SysResult.build(200, "日记删除成功！");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SysResult.build(201, "日记删除失败！");
	}
	
	/**
	 * 检测用户是否设置了日记密码
	 */
	@RequestMapping("/check/pwd")
	public SysResult checkDiaryPwd(HttpSession session){
		User user = (User) session.getAttribute("currUser");
		return this.diaryPwdService.checkDiaryPwdByUserId(user.getId());
	}
	
	/**
	 * 保存用户日记口令
	 */
	@RequestMapping("/pwd/save")
	public SysResult saveDiaryPwd(DiaryPwd diaryPwd, HttpSession session){
		User user = (User) session.getAttribute("currUser");
		diaryPwd.setUserId(user.getId());
		try {
			this.diaryPwdService.saveDiaryPwd(diaryPwd);
			return SysResult.ok();
		} catch (Exception e) {
			
		}
		return SysResult.build(201, "用户日记口令保存失败");
	}
	
	@RequestMapping("/pwd/update")
	public SysResult updateDiaryPwd(DiaryPwd diaryPwd, String oldPwd, HttpSession session){
		User user = (User) session.getAttribute("currUser");
		diaryPwd.setUserId(user.getId());
		try {
			return this.diaryPwdService.updateDiaryPwd(diaryPwd, oldPwd);
		} catch (Exception e) {
			
		}
		return SysResult.build(201, "用户日记口令修改失败");
	}
	
	@RequestMapping("/pwd/isLock")
	public Integer isLock(Long diaryId){
		return this.diaryService.queryById(diaryId).getIsLock();
	}

	@RequestMapping("/pwd/isLock2")
	public Integer isLock(Date writeDate) {
		try {
			Diary diary = new Diary();
			diary.setStatus(null);
			diary.setWriteDate(writeDate);
			Diary diary1 = this.diaryService.queryByWhere(diary);
			return diary1.getIsLock();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@RequestMapping("/getDiray/{id}")
	@SuppressWarnings("unchecked")
	public SysResult getDiaryById(@PathVariable Long id){
		Map<String, Object> result = this.diaryService.getDiaryById(id);
		List<Diary> diaries = (List<Diary>) result.get("data");
		return SysResult.ok(diaries.get(0));
	}

	@RequestMapping("/getDiaryByWD/{writeDate}")
	public SysResult getDiaryByWriteDate(@PathVariable Date writeDate, HttpSession session) {
		User user = (User) session.getAttribute("currUser");
		try {
			Diary diary = this.diaryService.getDiaryByWriteDate(user.getId(), writeDate);
			return SysResult.ok(diary);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SysResult.build(201, "操作失败");
	}

	@RequestMapping("/unLock")
	public SysResult unLock(DiaryPwd diaryPwd, HttpSession session){
		User user = (User) session.getAttribute("currUser");
		diaryPwd.setUserId(user.getId());
		return this.diaryPwdService.unLock(diaryPwd);
	}
}
