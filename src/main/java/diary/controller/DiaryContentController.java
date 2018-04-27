package diary.controller;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import diary.common.vo.SysResult;
import diary.service.DiaryContentService;

@RestController
public class DiaryContentController {
	@Resource
	private DiaryContentService diaryContentService;
	
	@RequestMapping(value = "/diary/content/{diaryId}", method = RequestMethod.GET)
	public SysResult getContentById(@PathVariable Long diaryId){
		return SysResult.ok(this.diaryContentService.queryContentById(diaryId));
	}
}
